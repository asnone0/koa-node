import mysql from "mysql2/promise";

const mysqlConfig = {
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
};

/** 创建数据库连接池 */
const pool = mysql.createPool(mysqlConfig);

export default pool;
