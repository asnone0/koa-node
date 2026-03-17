import jwt from "jsonwebtoken";

const JWT_SECRET = process.env.JWT_SECRET || "your-secret-key";

/** 不需要登录的白名单路径 */
const WHITE_LIST = ["/auth/login", "/auth/register", "/public/"];

/** 认证中间件 */
export const authMiddleware = async (ctx, next) => {
  const { path, method } = ctx;

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
    ctx.status = 401;
    ctx.body = { code: 401, message: "未登录，请先登录", data: null };
    return;
  }

  try {
    // 验证 token
    const decoded = jwt.verify(token, JWT_SECRET);
    ctx.state.user = decoded;
    await next();
  } catch (err) {
    ctx.status = 401;
    ctx.body = { code: 401, message: "登录已过期，请重新登录", data: null };
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
      ctx.status = 401;
      ctx.body = { code: 401, message: "未登录", data: null };
      return;
    }

    try {
      ctx.state.user = jwt.verify(token, JWT_SECRET);
      await next();
    } catch (err) {
      ctx.status = 401;
      ctx.body = { code: 401, message: "token 无效", data: null };
    }
  };
};
