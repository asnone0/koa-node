import "dotenv/config.js";
import koa from "koa";
import cors from "@koa/cors";
import bodyParser from "koa-bodyparser";
import router from "./router/index.js";

// 静态资源
import koaStatic from "koa-static";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// swagger
// import swaggerUi from "swagger-ui-koa";
// import swaggerSpec from "./middlewar/swagger.js";
// 自定义方法
// import { swaggerUtils } from "./utils/swagger.js";

// 校验中间件
import { authMiddleware } from "./middlewar/auth.js";
// 响应处理
import { responseError } from "./utils/error.js";

const app = new koa();

const PORT = process.env.PORT;

// 允许访问 upload 文件夹
app.use(koaStatic(path.join(__dirname, "./upload")));

// Swagger 文档路由
// app.use(swaggerUtils);

// // 更简单的写法：直接作为中间件使用
// app.use(swaggerUi.serve);
// app.use(swaggerUi.setup(swaggerSpec));

/**权限校验 */

/**中间件 */
app.use(cors());
app.use(bodyParser());

/** 登录校验中间件 - 放在路由之前 */
app.use(authMiddleware);

/**统一处理错误 */
app.use(responseError);

/**路由 */
app.use(router.routes());
app.use(router.allowedMethods());

app.listen(PORT, () => {
  console.log(`http://localhost:${PORT}`);
  // console.log(`Swagger UI: http://localhost:${PORT}/swagger-ui`);
});
