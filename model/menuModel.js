import pool from "../utils/db.js";

export async function getMenuList(params = {}) {
  const { name, type, status } = params;
  
  let whereSql = "WHERE del = 0 AND type = 1";
  const values = [];
  
  if (name) {
    whereSql += " AND name LIKE ?";
    values.push(`%${name}%`);
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
    `SELECT * FROM sys_permission ${whereSql} ORDER BY sort ASC, create_time DESC`,
    values
  );

  const menuTree = buildTree(rows);
  return menuTree;
}

export async function getMenuTree() {
  const [rows] = await pool.query(
    "SELECT * FROM sys_permission WHERE del = 0 AND type = 1 ORDER BY sort ASC"
  );
  return buildTree(rows);
}

export async function getMenuById(id) {
  const [rows] = await pool.query(
    "SELECT * FROM sys_permission WHERE id = ? AND del = 0",
    [id]
  );
  return rows[0] || null;
}

export async function createMenu(menuData) {
  const { name, code, type = 1, parent_id = 0, path, component, icon, sort = 0, status = 1 } = menuData;
  
  if (code) {
    const [existing] = await pool.query("SELECT id FROM sys_permission WHERE code = ? AND del = 0", [code]);
    if (existing.length > 0) {
      throw new Error("权限标识已存在");
    }
  }
  
  const [result] = await pool.query(
    "INSERT INTO sys_permission (name, code, type, parent_id, path, component, icon, sort, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
    [name, code, type, parent_id, path, component, icon, sort, status]
  );
  
  return getMenuById(result.insertId);
}

export async function updateMenu(id, menuData) {
  const { name, code, path, component, icon, sort, status, parent_id } = menuData;
  
  const [existing] = await pool.query("SELECT id FROM sys_permission WHERE id = ? AND del = 0", [id]);
  if (existing.length === 0) {
    throw new Error("菜单不存在");
  }
  
  if (parent_id !== undefined && parent_id == id) {
    throw new Error("不能将自己设为父级菜单");
  }
  
  const updates = [];
  const values = [];
  
  if (name !== undefined) { updates.push("name = ?"); values.push(name); }
  if (code !== undefined) { updates.push("code = ?"); values.push(code); }
  if (path !== undefined) { updates.push("path = ?"); values.push(path); }
  if (component !== undefined) { updates.push("component = ?"); values.push(component); }
  if (icon !== undefined) { updates.push("icon = ?"); values.push(icon); }
  if (sort !== undefined) { updates.push("sort = ?"); values.push(sort); }
  if (status !== undefined) { updates.push("status = ?"); values.push(status); }
  if (parent_id !== undefined) { updates.push("parent_id = ?"); values.push(parent_id); }
  
  if (updates.length === 0) {
    throw new Error("没有需要更新的字段");
  }
  
  values.push(id);
  await pool.query(`UPDATE sys_permission SET ${updates.join(", ")} WHERE id = ?`, values);
  
  return getMenuById(id);
}

export async function deleteMenu(id) {
  const [children] = await pool.query(
    "SELECT id FROM sys_permission WHERE parent_id = ? AND del = 0",
    [id]
  );
  if (children.length > 0) {
    throw new Error("该菜单下存在子菜单，无法删除");
  }
  
  await pool.query("DELETE FROM sys_role_permission WHERE permission_id = ?", [id]);
  const [result] = await pool.query("UPDATE sys_permission SET del = 1 WHERE id = ?", [id]);
  return result.affectedRows > 0;
}

function buildTree(list) {
  const map = {};
  const roots = [];
  
  list.forEach(item => {
    map[item.id] = { ...item, children: [] };
  });
  
  list.forEach(item => {
    if (item.parent_id && map[item.parent_id]) {
      map[item.parent_id].children.push(map[item.id]);
    } else if (item.parent_id === 0 || item.parent_id === null) {
      roots.push(map[item.id]);
    }
  });
  
  return roots;
}
