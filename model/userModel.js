import pool from "../utils/db.js";
import bcrypt from "bcryptjs";

export async function getUserList(params = {}) {
  const { page = 1, pageSize = 10, username, name, role_id, status } = params;
  const offset = (page - 1) * pageSize;
  
  let whereSql = "WHERE u.del = 0";
  const values = [];
  
    if (username) {
    whereSql += " AND u.username LIKE ?";
    values.push(`%${username}%`);
  }
  if (name) {
    whereSql += " AND u.name LIKE ?";
    values.push(`%${name}%`);
  }
  if (role_id) {
    whereSql += " AND u.role_id = ?";
    values.push(role_id);
  }
  if (status !== undefined && status !== "") {
    whereSql += " AND u.status = ?";
    values.push(status);
  }

  const [rows] = await pool.query(
    `SELECT u.*, r.name as role_name FROM sys_user u LEFT JOIN sys_role r ON u.role_id = r.id ${whereSql} ORDER BY u.create_time DESC LIMIT ? OFFSET ?`,
    [...values, Number(pageSize), Number(offset)]
  );

  const [countResult] = await pool.query(
    `SELECT COUNT(*) as total FROM sys_user u ${whereSql}`,
    values
  );

  return {
    list: rows,
    total: countResult[0].total,
    page: Number(page),
    pageSize: Number(pageSize)
  };
}

export async function getUserById(id) {
  const [rows] = await pool.query(
    `SELECT u.*, r.name as role_name FROM sys_user u LEFT JOIN sys_role r ON u.role_id = r.id WHERE u.id = ? AND u.del = 0`,
    [id]
  );
  return rows[0] || null;
}

export async function createUser(userData) {
  const { username, password, email, name, phone, avatar, role_id, status = 1 } = userData;
  
  const [existing] = await pool.query("SELECT id FROM sys_user WHERE username = ? AND del = 0", [username]);
  if (existing.length > 0) {
    throw new Error("用户名已存在");
  }
  
  const hashedPassword = await bcrypt.hash(password, 10);
  
  const [result] = await pool.query(
    `INSERT INTO sys_user (username, password, email, name, phone, avatar, role_id, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
    [username, hashedPassword, email, name, phone, avatar, role_id, status]
  );
  
  return { id: result.insertId, username, email, name, role_id, status };
}

export async function updateUser(id, userData) {
  const { email, name, phone, avatar, role_id, status } = userData;
  
  const [existing] = await pool.query("SELECT id FROM sys_user WHERE id = ? AND del = 0", [id]);
  if (existing.length === 0) {
    throw new Error("用户不存在");
  }
  
  const updates = [];
  const values = [];
  
  if (email !== undefined) { updates.push("email = ?"); values.push(email); }
  if (name !== undefined) { updates.push("name = ?"); values.push(name); }
  if (phone !== undefined) { updates.push("phone = ?"); values.push(phone); }
  if (avatar !== undefined) { updates.push("avatar = ?"); values.push(avatar); }
  if (role_id !== undefined) { updates.push("role_id = ?"); values.push(role_id); }
  if (status !== undefined) { updates.push("status = ?"); values.push(status); }
  
  if (updates.length === 0) {
    throw new Error("没有需要更新的字段");
  }
  
  values.push(id);
  await pool.query(`UPDATE sys_user SET ${updates.join(", ")} WHERE id = ?`, values);
  
  return getUserById(id);
}

export async function deleteUser(id) {
  const [result] = await pool.query("UPDATE sys_user SET del = 1 WHERE id = ?", [id]);
  return result.affectedRows > 0;
}

export async function resetPassword(id, newPassword) {
  const hashedPassword = await bcrypt.hash(newPassword, 10);
  const [result] = await pool.query("UPDATE sys_user SET password = ? WHERE id = ?", [hashedPassword, id]);
  return result.affectedRows > 0;
}

export async function updatePassword(id, oldPassword, newPassword) {
  const [users] = await pool.query("SELECT password FROM sys_user WHERE id = ? AND del = 0", [id]);
  if (users.length === 0) {
    throw new Error("用户不存在");
  }
  
  const isValid = await bcrypt.compare(oldPassword, users[0].password);
  if (!isValid) {
    throw new Error("原密码错误");
  }
  
  return resetPassword(id, newPassword);
}
