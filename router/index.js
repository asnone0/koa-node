import Router from "koa-router";
const router = new Router();

import { userRouter, roleRouter, menuRouter, permissionRouter, uploadRouter } from "./allRoutes.js";
import { loginController } from "../controller/loginController.js";
import { registerController, getUserInfoController } from "../controller/authController.js";

router.post("/auth/login", loginController);
router.post("/auth/register", registerController);
router.get("/auth/userinfo", getUserInfoController);

function registerRouter(router, routes) {
  routes.forEach((item) => {
    router[item.method](item.path, item.controller);
  });
}

registerRouter(router, userRouter);
registerRouter(router, roleRouter);
registerRouter(router, menuRouter);
registerRouter(router, permissionRouter);
registerRouter(router, uploadRouter);

export default router;
