import pool from "./db.js";

/**
 * 权限检查数据库
 */
export async function permissionsCheckDb(role_id, path) {
  const [rows] = await pool.query(
    `SELECT 
       p.id,
       p.name,
       p.path,
       p.type,
       p.code
     FROM sys_role_permission srp
     INNER JOIN sys_permission p ON srp.permission_id = p.id
     WHERE srp.role_id = ? AND p.del = 0`,
    [role_id],
  );
  if (!rows) return 0;
  if (!rows.length) return 0;
  const pathArr = rows.some((item) => item.path === path);
  if (!pathArr) return 0;
  return 1;
}

/**
 * @param {*} decoded 用户信息
 * @returns 1就是通过，0就是没有权限,-1用户没有该角色
 */
export async function permissionsCheck(ctx, decoded) {
  // 获取路径
  const path = ctx.path;
  if (!decoded.roleId) return -1;
  return permissionsCheckDb(decoded.roleId, path);
}
