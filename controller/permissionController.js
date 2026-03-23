import { success, error } from "../utils/response.js";
import * as permissionModel from "../model/permissionModel.js";

export async function getPermissionController(ctx) {
  const params = ctx.query;
  const data = await permissionModel.getPermissionList(params);
  return success(ctx, data);
}

export async function getAllPermissionsController(ctx) {
  const data = await permissionModel.getAllPermissions();
  return success(ctx, data);
}

export async function getPermissionByIdController(ctx) {
  const { id } = ctx.params;
  const permission = await permissionModel.getPermissionById(id);
  if (!permission) {
    return error(ctx, "权限不存在", -1);
  }
  return success(ctx, permission);
}

export async function createPermissionController(ctx) {
  try {
    const permData = ctx.request.body;
    const result = await permissionModel.createPermission(permData);
    return success(ctx, result, "权限创建成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}

export async function updatePermissionController(ctx) {
  try {
    const { id } = ctx.params;
    const permData = ctx.request.body;
    const result = await permissionModel.updatePermission(id, permData);
    return success(ctx, result, "权限更新成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}

export async function deletePermissionController(ctx) {
  try {
    const { id } = ctx.params;
    const result = await permissionModel.deletePermission(id);
    if (!result) {
      return error(ctx, "权限不存在", -1);
    }
    return success(ctx, null, "权限删除成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}
