import "dotenv/config.js";
import koa from "koa";
import cors from "@koa/cors";
import bodyParser from "koa-bodyparser";
import router from "./router/index.js";

// 校验中间件
import { authMiddleware } from "./middlewar/auth.js";
// 响应处理
import { responseError } from "./utils/error.js";

const app = new koa();

const PORT = process.env.PORT;

/**统一处理错误 */
app.use(responseError);

/**权限校验 */

/**中间件 */
app.use(cors());
app.use(bodyParser());

/** 登录校验中间件 - 放在路由之前 */
app.use(authMiddleware);

/**路由 */
app.use(router.routes());
app.use(router.allowedMethods());

app.listen(PORT, () => {
  console.log(`http://localhost:${PORT}`);
});
