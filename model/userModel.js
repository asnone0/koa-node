import pool from "../utils/db.js";

import { receiveValuePost, receiveValueGet } from "../utils/receiveValueObj.js";
export async function getUserModal(ctx) {
  const { data } = receiveValueGet(ctx);
  if (!data.id) {
    throw "id不能为空";
  }
  const [rows] = await pool.query("select * from sys_user");
  return rows;
}
