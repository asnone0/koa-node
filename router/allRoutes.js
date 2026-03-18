import routes from "../utils/initRouter.js";

// 控制器
import { getUserController } from "../controller/userController.js";

import {
  uploadFile,
  uploadFiles,
  getFiles,
} from "../controller/uploadController.js";

// 用户管理相关
export const userRouter = [new routes("/api/user", "get", getUserController)];

// 上传文件相关
export const uploadRouter = [
  new routes("/api/upload", "post", uploadFile),
  new routes("/api/uploads", "post", uploadFiles),
  new routes("/api/files", "get", getFiles),
];
