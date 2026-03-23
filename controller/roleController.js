import { success, error } from "../utils/response.js";
import * as roleModel from "../model/roleModel.js";

export async function getRoleController(ctx) {
  const params = ctx.query;
  const data = await roleModel.getRoleList(params);
  return success(ctx, data);
}

export async function getAllRolesController(ctx) {
  const data = await roleModel.getAllRoles();
  return success(ctx, data);
}

export async function getRoleByIdController(ctx) {
  const { id } = ctx.params;
  const role = await roleModel.getRoleById(id);
  if (!role) {
    return error(ctx, "角色不存在", -1);
  }
  return success(ctx, role);
}

export async function createRoleController(ctx) {
  try {
    const roleData = ctx.request.body;
    const result = await roleModel.createRole(roleData);
    return success(ctx, result, "角色创建成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}

export async function updateRoleController(ctx) {
  try {
    const { id } = ctx.params;
    const roleData = ctx.request.body;
    const result = await roleModel.updateRole(id, roleData);
    return success(ctx, result, "角色更新成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}

export async function deleteRoleController(ctx) {
  try {
    const { id } = ctx.params;
    const result = await roleModel.deleteRole(id);
    if (!result) {
      return error(ctx, "角色不存在", -1);
    }
    return success(ctx, null, "角色删除成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}
