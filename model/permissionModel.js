import pool from "../utils/db.js";

export async function getPermissionList(params = {}) {
  const { page = 1, pageSize = 10, name, code, type, status } = params;
  const offset = (page - 1) * pageSize;

  let whereSql = "WHERE del = 0 and type != 1";
  const values = [];

  if (name) {
    whereSql += " AND name LIKE ?";
    values.push(`%${name}%`);
  }
  if (code) {
    whereSql += " AND code LIKE ?";
    values.push(`%${code}%`);
  }
  if (type) {
    whereSql += " AND type = ?";
    values.push(type);
  }
  if (status !== undefined && status !== "") {
    whereSql += " AND status = ?";
    values.push(status);
  }

  const [rows] = await pool.query(
    `SELECT * FROM sys_permission ${whereSql} ORDER BY type ASC, sort ASC LIMIT ? OFFSET ?`,
    [...values, Number(pageSize), Number(offset)],
  );

  const [countResult] = await pool.query(
    `SELECT COUNT(*) as total FROM sys_permission ${whereSql}`,
    values,
  );

  return {
    list: rows,
    total: countResult[0].total,
    page: Number(page),
    pageSize: Number(pageSize),
  };
}

export async function getAllPermissions() {
  const [rows] = await pool.query(
    "SELECT * FROM sys_permission WHERE del = 0 and type != 1 ORDER BY type ASC, sort ASC",
  );
  return rows;
}

export async function getPermissionById(id) {
  const [rows] = await pool.query(
    "SELECT * FROM sys_permission WHERE id = ? AND del = 0",
    [id],
  );
  return rows[0] || null;
}

export async function createPermission(permData) {
  const {
    name,
    code,
    type = 2,
    parent_id = 0,
    path,
    icon,
    sort = 0,
    status = 1,
  } = permData;

  const [existing] = await pool.query(
    "SELECT id FROM sys_permission WHERE code = ? AND del = 0",
    [code],
  );
  if (existing.length > 0) {
    throw new Error("权限标识已存在");
  }

  const [result] = await pool.query(
    "INSERT INTO sys_permission (name, code, type, parent_id, path, icon, sort, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
    [name, code, type, parent_id, path, icon, sort, status],
  );

  return getPermissionById(result.insertId);
}

export async function updatePermission(id, permData) {
  const { name, code, type, path, icon, sort, status, parent_id } = permData;

  const [existing] = await pool.query(
    "SELECT id FROM sys_permission WHERE id = ? AND del = 0",
    [id],
  );
  if (existing.length === 0) {
    throw new Error("权限不存在");
  }

  const updates = [];
  const values = [];

  if (name !== undefined) {
    updates.push("name = ?");
    values.push(name);
  }
  if (code !== undefined) {
    updates.push("code = ?");
    values.push(code);
  }
  if (type !== undefined) {
    updates.push("type = ?");
    values.push(type);
  }
  if (path !== undefined) {
    updates.push("path = ?");
    values.push(path);
  }
  if (icon !== undefined) {
    updates.push("icon = ?");
    values.push(icon);
  }
  if (sort !== undefined) {
    updates.push("sort = ?");
    values.push(sort);
  }
  if (status !== undefined) {
    updates.push("status = ?");
    values.push(status);
  }
  if (parent_id !== undefined) {
    updates.push("parent_id = ?");
    values.push(parent_id);
  }

  if (updates.length === 0) {
    throw new Error("没有需要更新的字段");
  }

  values.push(id);
  await pool.query(
    `UPDATE sys_permission SET ${updates.join(", ")} WHERE id = ?`,
    values,
  );

  return getPermissionById(id);
}

export async function deletePermission(id) {
  const [children] = await pool.query(
    "SELECT id FROM sys_permission WHERE parent_id = ? AND del = 0",
    [id],
  );
  if (children.length > 0) {
    throw new Error("该权限下存在子权限，无法删除");
  }

  await pool.query("DELETE FROM sys_role_permission WHERE permission_id = ?", [
    id,
  ]);
  const [result] = await pool.query(
    "UPDATE sys_permission SET del = 1 WHERE id = ?",
    [id],
  );
  return result.affectedRows > 0;
}
