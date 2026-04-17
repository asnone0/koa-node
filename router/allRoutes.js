import routes from "../utils/initRouter.js";

import {
  getUserController,
  getUserByIdController,
  createUserController,
  updateUserController,
  deleteUserController,
  resetPasswordController,
  updatePasswordController,
} from "../controller/userController.js";
import {
  getRoleController,
  getAllRolesController,
  getRoleByIdController,
  createRoleController,
  updateRoleController,
  deleteRoleController,
} from "../controller/roleController.js";
import {
  getMenuController,
  getMenuTreeController,
  getMenuByIdController,
  createMenuController,
  updateMenuController,
  deleteMenuController,
  getMenuAllController,
} from "../controller/menuController.js";
import {
  getPermissionController,
  getAllPermissionsController,
  getPermissionByIdController,
  createPermissionController,
  updatePermissionController,
  deletePermissionController,
} from "../controller/permissionController.js";
import {
  uploadFile,
  uploadFiles,
  getFiles,
} from "../controller/uploadController.js";

export const userRouter = [
  new routes("/api/user", "get", getUserController),
  new routes("/api/user/:id", "get", getUserByIdController),
  new routes("/api/user", "post", createUserController),
  new routes("/api/user/:id", "put", updateUserController),
  new routes("/api/user/:id", "delete", deleteUserController),
  new routes("/api/user/:id/reset-password", "put", resetPasswordController),
  new routes("/api/user/password", "put", updatePasswordController),
];

export const roleRouter = [
  new routes("/api/role", "get", getRoleController),
  new routes("/api/role/all", "get", getAllRolesController),
  new routes("/api/role/:id", "get", getRoleByIdController),
  new routes("/api/role", "post", createRoleController),
  new routes("/api/role/:id", "put", updateRoleController),
  new routes("/api/role/:id", "delete", deleteRoleController),
];

export const menuRouter = [
  new routes("/api/menu", "get", getMenuController),
  new routes("/api/menu/tree", "get", getMenuTreeController),
  new routes("/api/menu/:id", "get", getMenuByIdController),
  new routes("/api/menu", "post", createMenuController),
  new routes("/api/menu/:id", "put", updateMenuController),
  new routes("/api/menu/:id", "delete", deleteMenuController),
  new routes("/api/menuAll", "get", getMenuAllController),
];

export const permissionRouter = [
  new routes("/api/permission", "get", getPermissionController),
  new routes("/api/permission/all", "get", getAllPermissionsController),
  new routes("/api/permission/:id", "get", getPermissionByIdController),
  new routes("/api/permission", "post", createPermissionController),
  new routes("/api/permission/:id", "put", updatePermissionController),
  new routes("/api/permission/:id", "delete", deletePermissionController),
];

export const uploadRouter = [
  new routes("/api/upload", "post", uploadFile),
  new routes("/api/uploads", "post", uploadFiles),
  new routes("/api/files", "get", getFiles),
];
