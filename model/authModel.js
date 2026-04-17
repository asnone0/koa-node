import pool from "../utils/db.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

const JWT_SECRET = process.env.JWT_SECRET || "your-secret-key";
const JWT_EXPIRES_IN = "7d";

export async function registerModel(ctx) {
  const { username, password, email, name, phone } = ctx.request.body;

  if (!username || !password) {
    throw new Error("用户名和密码不能为空");
  }

  if (username.length < 3 || username.length > 20) {
    throw new Error("用户名长度应在3-20个字符之间");
  }

  if (password.length < 6) {
    throw new Error("密码长度不能少于6位");
  }

  const [existing] = await pool.query(
    "SELECT id FROM sys_user WHERE username = ? AND del = 0",
    [username],
  );

  if (existing.length > 0) {
    throw new Error("用户名已存在");
  }

  const hashedPassword = await bcrypt.hash(password, 10);

  const [result] = await pool.query(
    `INSERT INTO sys_user (username, password, email, name, phone, status) VALUES (?, ?, ?, ?, ?, 1)`,
    [username, hashedPassword, email, name, phone],
  );

  const userId = result.insertId;

  const token = jwt.sign(
    {
      userId: userId,
      username: username,
      roleId: null,
    },
    JWT_SECRET,
    { expiresIn: JWT_EXPIRES_IN },
  );

  return {
    token,
    expiresIn: JWT_EXPIRES_IN,
    userInfo: {
      userId,
      username,
      email,
      name,
    },
  };
}

export async function getUserInfoModel(ctx) {
  // 获取 token
  const token = ctx.headers.authorization?.replace("Bearer ", "");

  if (!token) {
    throw new Error("未登录，请先登录");
  }

  // 验证 token
  const decoded = jwt.verify(token, JWT_SECRET);
  const userId = decoded?.userId || 1;
  const [users] = await pool.query(
    `SELECT u.id, u.username, u.email, u.name, u.phone, u.avatar, u.role_id, u.status, u.create_time,
            r.name as role_name, r.code as role_code
     FROM sys_user u
     LEFT JOIN sys_role r ON u.role_id = r.id
     WHERE u.id = ? AND u.del = 0`,
    [userId],
  );

  if (users.length === 0) {
    throw new Error("用户不存在");
  }

  const user = users[0];

  let menus, permissions;

  if (user.role_id === 1) {
    [menus] = await pool.query(
      `SELECT id, name, code, type, parent_id, path, component, icon, sort
       FROM sys_permission
       WHERE del = 0 AND status = 1 AND type = 1
       ORDER BY sort ASC`,
    );
    [permissions] = await pool.query(
      `SELECT code FROM sys_permission WHERE del = 0 AND status = 1`,
    );
  } else {
    [menus] = await pool.query(
      `SELECT DISTINCT p.id, p.name, p.code, p.type, p.parent_id, p.path, p.component, p.icon, p.sort
       FROM sys_role_permission rp
       JOIN sys_permission p ON rp.permission_id = p.id
       WHERE rp.role_id = ? AND p.del = 0 AND p.status = 1 AND p.type = 1
       ORDER BY p.sort ASC`,
      [user.role_id],
    );
    [permissions] = await pool.query(
      `SELECT p.code
       FROM sys_role_permission rp
       JOIN sys_permission p ON rp.permission_id = p.id
       WHERE rp.role_id = ? AND p.del = 0 AND p.status = 1`,
      [user.role_id],
    );
  }

  const menuTree = buildMenuTree(menus);

  return {
    userInfo: {
      id: user.id,
      username: user.username,
      email: user.email,
      name: user.name,
      phone: user.phone,
      avatar: user.avatar,
      role_id: user.role_id,
      role_name: user.role_name,
      role_code: user.role_code,
      status: user.status,
      create_time: user.create_time,
    },
    menus: menuTree,
    permissions: permissions.map((p) => p.code),
  };
}

function buildMenuTree(menus) {
  const map = {};
  const roots = [];

  menus.forEach((item) => {
    map[item.id] = { ...item, children: [] };
  });

  menus.forEach((item) => {
    if (item.parent_id && map[item.parent_id]) {
      map[item.parent_id].children.push(map[item.id]);
    } else if (item.parent_id === 0 || item.parent_id === null) {
      roots.push(map[item.id]);
    }
  });

  return roots;
}
