import Router from "koa-router";
const router = new Router();

import { loginController } from "../controller/loginController.js";
import { getUserController } from "../controller/userController.js";

// 登录
router.post("/auth/login", loginController);

// 获取用户
router.get("/api/user", getUserController);

export default router;
