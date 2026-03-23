import { success, error } from "../utils/response.js";
import * as userModel from "../model/userModel.js";

export async function getUserController(ctx) {
  const params = ctx.query;
  const data = await userModel.getUserList(params);
  return success(ctx, data);
}

export async function getUserByIdController(ctx) {
  const { id } = ctx.params;
  const user = await userModel.getUserById(id);
  if (!user) {
    return error(ctx, "用户不存在", -1);
  }
  return success(ctx, user);
}

export async function createUserController(ctx) {
  try {
    const userData = ctx.request.body;
    const result = await userModel.createUser(userData);
    return success(ctx, result, "用户创建成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}

export async function updateUserController(ctx) {
  try {
    const { id } = ctx.params;
    const userData = ctx.request.body;
    const result = await userModel.updateUser(id, userData);
    return success(ctx, result, "用户更新成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}

export async function deleteUserController(ctx) {
  try {
    const { id } = ctx.params;
    const result = await userModel.deleteUser(id);
    if (!result) {
      return error(ctx, "用户不存在", -1);
    }
    return success(ctx, null, "用户删除成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}

export async function resetPasswordController(ctx) {
  try {
    const { id } = ctx.params;
    const { newPassword } = ctx.request.body;
    if (!newPassword) {
      return error(ctx, "新密码不能为空", -1);
    }
    const result = await userModel.resetPassword(id, newPassword);
    if (!result) {
      return error(ctx, "用户不存在", -1);
    }
    return success(ctx, null, "密码重置成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}

export async function updatePasswordController(ctx) {
  try {
    const userId = ctx.state.user.userId;
    const { oldPassword, newPassword } = ctx.request.body;
    if (!oldPassword || !newPassword) {
      return error(ctx, "原密码和新密码不能为空", -1);
    }
    await userModel.updatePassword(userId, oldPassword, newPassword);
    return success(ctx, null, "密码修改成功");
  } catch (err) {
    return error(ctx, err.message, -1);
  }
}
