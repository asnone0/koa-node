import Router from "koa-router";
const router = new Router();

// 引入全部路由
import { userRouter, uploadRouter } from "./allRoutes.js";
//
import { loginController } from "../controller/loginController.js";

// 登录
router.post("/auth/login", loginController);

function registerRouter(router, routes) {
  routes.forEach((item) => {
    router[item.method](item.path, item.controller);
  });
}

// 用户管理注册
registerRouter(router, userRouter);

// 上传文件注册
registerRouter(router, uploadRouter);

export default router;
