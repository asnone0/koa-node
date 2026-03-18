export async function swaggerUtils(ctx, next) {
  if (ctx.path === "/api-docs" || ctx.path.startsWith("/api-docs/")) {
    // 手动调用 swaggerUi 的中间件逻辑，或者直接使用以下方式
    return next();
  }
  await next();
}
