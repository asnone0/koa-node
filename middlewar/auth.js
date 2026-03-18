import jwt from "jsonwebtoken";

import { error } from "../utils/response.js";
import { permissionsCheck } from "../utils/permissionsCheck.js";

const JWT_SECRET = process.env.JWT_SECRET || "your-secret-key";

/** 不需要登录的白名单路径 */
const WHITE_LIST = ["/auth/login", "/auth/register", "/public/", "/swagger-ui"];

/** 认证中间件 */
export const authMiddleware = async (ctx, next) => {
  const { path } = ctx;

  // 检查是否在白名单中
  const isWhitePath = WHITE_LIST.some((whitePath) => {
    if (whitePath.endsWith("/")) {
      return path.startsWith(whitePath);
    }
    return path === whitePath;
  });

  // 白名单路径直接放行
  if (isWhitePath) {
    await next();
    return;
  }

  // 获取 token
  const token = ctx.headers.authorization?.replace("Bearer ", "");

  if (!token) {
    return error(ctx, "未登录，请先登录", -3);
  }

  try {
    // 验证 token
    const decoded = jwt.verify(token, JWT_SECRET);
    ctx.state.user = decoded;
    // 检查权限
    const checkCode = await permissionsCheck(ctx, decoded);
    if (checkCode === 0) {
      return error(ctx, "你没有该权限", -4);
    }

    if (checkCode === -1) {
      return error(ctx, "不存在该角色", -4);
    }
    await next();
  } catch (err) {
    return error(ctx, "登录已过期，请重新登录", -4);
  }
};

/** 可选：手动保护特定路径的装饰器 */
export const protect = (paths) => {
  return async (ctx, next) => {
    const isProtected = paths.some((p) => ctx.path.startsWith(p));
    if (!isProtected) {
      await next();
      return;
    }

    // 执行认证逻辑
    const token = ctx.headers.authorization?.replace("Bearer ", "");
    if (!token) {
      return error(ctx, "未登录，请先登录", -3);
    }

    try {
      ctx.state.user = jwt.verify(token, JWT_SECRET);
      await next();
    } catch (err) {
      error(ctx, "token 无效", -4);
    }
  };
};
