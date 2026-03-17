import { error } from "./response.js";

export async function responseError(ctx, next) {
  try {
    await next();
    if (ctx.status === 404) {
      error.body(-1, "资源不存在");
    }
  } catch (err) {
    ctx.status = err.status || 500;
    error(-2, "服务器异常");
  }
}
