import { error } from "./response.js";
import logger from "./logger.js";
export async function responseError(ctx, next) {
  try {
    await next();
    if (ctx.status === 404) {
      error(ctx, "资源不存在", -1);
    }
  } catch (err) {
    if (ctx.status == 500) {
      error(ctx, "服务器异常", -2);
    } else {
      error(ctx, err, -1);
      logger.error(err, {
        path: ctx.path,
        error: err,
      });
    }
  }
}
