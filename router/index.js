import Router from "koa-router";

import { success, error } from "../utils/response.js";
import { receiveValuePost, receiveValueGet } from "../utils/ReceiveValueObj.js";

import pool from "../utils/db.js";
const router = new Router();

router.get("/api/get", async (ctx) => {
  try {
    const { data } = receiveValueGet(ctx);
    const [rows] = await pool.query("select * from sys_user");
    success(ctx, rows);
  } catch (err) {
    error(ctx, err);
  }
});

router.post("/api/post", async (ctx) => {
  const { data } = receiveValuePost(ctx);
  success(ctx, data);
});

export default router;
