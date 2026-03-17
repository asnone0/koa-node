import { success } from "../utils/response.js";
import { getUserModal } from "../model/userModel.js";

export async function getUserController(ctx) {
  const data = await getUserModal(ctx);
  return success(ctx, data, "获取用户成功");
}
