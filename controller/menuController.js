import { success, error } from "../utils/response.js";
import * as menuModel from "../model/menuModel.js";

export async function getMenuController(ctx) {
  const params = ctx.query;
  const data = await menuModel.getMenuList(params);
  return success(ctx, data);
}

export async function getMenuTreeController(ctx) {
  const data = await menuModel.getMenuTree();
  return success(ctx, data);
}

export async function getMenuByIdController(ctx) {
  console.log(ctx.params);
  const { id } = ctx.params;
  const menu = await menuModel.getMenuById(id);
  if (!menu) {
    return error(ctx, "菜单不存在", -1);
  }
  return success(ctx, menu);
}

export async function getMenuAllController(ctx) {
  try {
    const data = await menuModel.getMenuAll();
    return success(ctx, data);
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}

export async function createMenuController(ctx) {
  try {
    const menuData = ctx.request.body;
    const result = await menuModel.createMenu(menuData);
    return success(ctx, result, "菜单创建成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}

export async function updateMenuController(ctx) {
  try {
    const { id } = ctx.params;
    const menuData = ctx.request.body;
    const result = await menuModel.updateMenu(id, menuData);
    return success(ctx, result, "菜单更新成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}

export async function deleteMenuController(ctx) {
  try {
    const { id } = ctx.params;
    const result = await menuModel.deleteMenu(id);
    if (!result) {
      return error(ctx, "菜单不存在", -1);
    }
    return success(ctx, null, "菜单删除成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}
