import { success, error } from "../utils/response.js";
import * as authModel from "../model/authModel.js";

export async function registerController(ctx) {
  try {
    const data = await authModel.registerModel(ctx);
    return success(ctx, data, "注册成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}

export async function getUserInfoController(ctx) {
  try {
    const data = await authModel.getUserInfoModel(ctx);
    return success(ctx, data);
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}
