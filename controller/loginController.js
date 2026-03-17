import { success } from "../utils/response.js";
import { loginModel } from "../model/loginModel.js";

export async function loginController(ctx) {
  const data = await loginModel(ctx);
  return success(ctx, data, "登录成功");
}
