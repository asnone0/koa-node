import { error } from "./response.js";
import logger from "./logger.js";
export async function responseError(ctx, next) {
  try {
    await next();
    if (ctx.status === 404) {
      error(-1, "资源不存在");
    }
  } catch (err) {
    if (ctx.status == 500) {
      error(ctx, "服务器异常", -2);
    } else {
      error(ctx, err);
      logger.error(err, {
        path: ctx.path,
        method: ctx.method,
        error: err.message,
        stack: err.stack,
        userId: ctx.state.user?.id,
      });
    }
  }
}
