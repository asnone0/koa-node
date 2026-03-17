import pool from "../utils/db.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import { error } from "../utils/response.js";
import { receiveValuePost } from "../utils/ReceiveValueObj.js";

const JWT_SECRET = process.env.JWT_SECRET || "your-secret-key";
const JWT_EXPIRES_IN = "7d";

export async function loginModel(ctx) {
  const { data } = receiveValuePost(ctx);
  const { username, password } = data;

  // 1. 参数校验
  if (!username || !password) {
    throw "用户名和密码不能为空";
  }

  // 2. 查询用户
  const [users] = await pool.query(
    "SELECT * FROM sys_user WHERE username = ?",
    [username],
  );

  if (users.length === 0) {
    throw new error("用户不存在", 400, 1002);
  }

  const user = users[0];

  // 3. 验证密码（假设数据库中密码已加密）
  const isValid = await bcrypt.compare(password, user.password);
  if (!isValid) {
    throw "密码错误";
  }

  // 4. 生成 JWT Token
  const token = jwt.sign(
    {
      userId: user.id,
      username: user.username,
      roleId: user.role_id,
    },
    JWT_SECRET,
    { expiresIn: JWT_EXPIRES_IN },
  );

  // 5. 返回用户信息（不包含密码）
  const userInfo = {
    userId: user.id,
    username: user.username,
    email: user.email,
    avatar: user.avatar,
    roleId: user.role_id,
    roleName: user.role_name,
  };

  return {
    token,
    expiresIn: JWT_EXPIRES_IN,
    userInfo,
  };
}
