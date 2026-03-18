import pool from "../utils/db.js";

/**
 * 保存上传文件信息到数据库
 */
export async function uploadModal(fileInfo) {
  const sql = `INSERT INTO sys_upload (
    file_name,
    file_path,
    file_size,
    file_type,
    create_time
  ) VALUES (?, ?, ?, ?, NOW())`;

  const [result] = await pool.query(sql, [
    fileInfo.originalname,
    fileInfo.path,
    fileInfo.size,
    fileInfo.mimetype,
  ]);

  return result;
}

/**
 * 获取上传文件列表
 */
export async function getUploadList(page = 1, pageSize = 10) {
  const offset = (page - 1) * pageSize;
  const [rows] = await pool.query(
    `SELECT * FROM sys_upload ORDER BY create_time DESC LIMIT ? OFFSET ?`,
    [pageSize, offset],
  );
  return rows;
}
