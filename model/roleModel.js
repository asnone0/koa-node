import pool from "../utils/db.js";

export async function getRoleList(params = {}) {
  const { page = 1, pageSize = 10, name, code, status } = params;
  const offset = (page - 1) * pageSize;
  
  let whereSql = "WHERE del = 0";
  const values = [];
  
  if (name) {
    whereSql += " AND name LIKE ?";
    values.push(`%${name}%`);
  }
  if (code) {
    whereSql += " AND code LIKE ?";
    values.push(`%${code}%`);
  }
  if (status !== undefined && status !== "") {
    whereSql += " AND status = ?";
    values.push(status);
  }

  const [rows] = await pool.query(
    `SELECT * FROM sys_role ${whereSql} ORDER BY sort ASC, create_time DESC LIMIT ? OFFSET ?`,
    [...values, Number(pageSize), Number(offset)]
  );

  const [countResult] = await pool.query(
    `SELECT COUNT(*) as total FROM sys_role ${whereSql}`,
    values
  );

  for (const row of rows) {
    const [permissions] = await pool.query(
      `SELECT p.* FROM sys_role_permission rp 
       JOIN sys_permission p ON rp.permission_id = p.id 
       WHERE rp.role_id = ? AND p.del = 0`,
      [row.id]
    );
    row.permissions = permissions;
  }

  return {
    list: rows,
    total: countResult[0].total,
    page: Number(page),
    pageSize: Number(pageSize)
  };
}

export async function getAllRoles() {
  const [rows] = await pool.query(
    "SELECT * FROM sys_role WHERE del = 0 AND status = 1 ORDER BY sort ASC"
  );
  return rows;
}

export async function getRoleById(id) {
  const [rows] = await pool.query(
    "SELECT * FROM sys_role WHERE id = ? AND del = 0",
    [id]
  );
  if (rows.length === 0) return null;
  
  const role = rows[0];
  const [permissions] = await pool.query(
    `SELECT p.* FROM sys_role_permission rp 
     JOIN sys_permission p ON rp.permission_id = p.id 
     WHERE rp.role_id = ? AND p.del = 0`,
    [id]
  );
  role.permissions = permissions;
  
  return role;
}

export async function createRole(roleData) {
  const { name, code, status = 1, sort = 0, description, permissions = [] } = roleData;
  
  const [existing] = await pool.query("SELECT id FROM sys_role WHERE code = ? AND del = 0", [code]);
  if (existing.length > 0) {
    throw new Error("角色代码已存在");
  }
  
  const [result] = await pool.query(
    "INSERT INTO sys_role (name, code, status, sort, description) VALUES (?, ?, ?, ?, ?)",
    [name, code, status, sort, description]
  );
  
  const roleId = result.insertId;
  
  if (permissions.length > 0) {
    const validPerms = permissions.filter(pId => pId && !isNaN(Number(pId)));
    if (validPerms.length > 0) {
      const permValues = validPerms.map(pId => [roleId, Number(pId)]);
      await pool.query(
        "INSERT INTO sys_role_permission (role_id, permission_id) VALUES ?",
        [permValues]
      );
    }
  }
  
  return getRoleById(roleId);
}

export async function updateRole(id, roleData) {
  const { name, code, status, sort, description, permissions } = roleData;
  
  const [existing] = await pool.query("SELECT id FROM sys_role WHERE id = ? AND del = 0", [id]);
  if (existing.length === 0) {
    throw new Error("角色不存在");
  }
  
  const updates = [];
  const values = [];
  
  if (name !== undefined) { updates.push("name = ?"); values.push(name); }
  if (code !== undefined) { updates.push("code = ?"); values.push(code); }
  if (status !== undefined) { updates.push("status = ?"); values.push(status); }
  if (sort !== undefined) { updates.push("sort = ?"); values.push(sort); }
  if (description !== undefined) { updates.push("description = ?"); values.push(description); }
  
  if (updates.length > 0) {
    values.push(id);
    await pool.query(`UPDATE sys_role SET ${updates.join(", ")} WHERE id = ?`, values);
  }
  
  if (permissions !== undefined) {
    await pool.query("DELETE FROM sys_role_permission WHERE role_id = ?", [id]);
    
    if (permissions.length > 0) {
      const validPerms = permissions.filter(pId => pId && !isNaN(Number(pId)));
      if (validPerms.length > 0) {
        const permValues = validPerms.map(pId => [id, Number(pId)]);
        await pool.query(
          "INSERT INTO sys_role_permission (role_id, permission_id) VALUES ?",
          [permValues]
        );
      }
    }
  }
  
  return getRoleById(id);
}

export async function deleteRole(id) {
  const [users] = await pool.query("SELECT id FROM sys_user WHERE role_id = ? AND del = 0", [id]);
  if (users.length > 0) {
    throw new Error("该角色下存在用户，无法删除");
  }
  
  await pool.query("DELETE FROM sys_role_permission WHERE role_id = ?", [id]);
  const [result] = await pool.query("UPDATE sys_role SET del = 1 WHERE id = ?", [id]);
  return result.affectedRows > 0;
}
