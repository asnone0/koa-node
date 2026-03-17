import pool from "../utils/db.js";

export async function getUserModal(ctx) {
  const [rows] = await pool.query("select * from sys_user");
  return rows;
}
