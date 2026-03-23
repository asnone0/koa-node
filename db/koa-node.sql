/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80012 (8.0.12)
 Source Host           : localhost:3306
 Source Schema         : koa-node

 Target Server Type    : MySQL
 Target Server Version : 80012 (8.0.12)
 File Encoding         : 65001

 Date: 23/03/2026 18:06:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for biz_baidu_file
-- ----------------------------
DROP TABLE IF EXISTS `biz_baidu_file`;
CREATE TABLE `biz_baidu_file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
  `user_id` int(11) NOT NULL COMMENT '用户 ID',
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件名',
  `file_size` bigint(20) NULL DEFAULT NULL COMMENT '文件大小 (字节)',
  `baidu_file_id` bigint(20) NULL DEFAULT NULL COMMENT '百度网盘文件 ID',
  `baidu_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '百度网盘路径',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del` tinyint(1) NULL DEFAULT 0 COMMENT '删除标记 0-正常 1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_del`(`del` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '百度网盘文件记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_baidu_file
-- ----------------------------

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限名称',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限标识',
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '类型: 1-菜单, 2-按钮/操作, 3-接口',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父级ID',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由路径',
  `component` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除: 0-正常, 1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_code`(`code` ASC) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '权限表(菜单+按钮+接口)' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES (1, '系统管理', 'system', 1, 0, '/system', 'Layout', 'Setting', 1, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (2, '用户管理', 'user', 1, 1, '/system/user', 'system/user/index', 'User', 1, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (3, '角色管理', 'role', 1, 1, '/system/role', 'system/role/index', 'Role', 2, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (4, '菜单管理', 'menu', 1, 1, '/system/menu', 'system/menu/index', 'Menu', 3, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (5, '权限管理', 'permission', 1, 1, '/system/permission', 'system/permission/index', 'Lock', 4, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (10, '用户查询', 'user:list', 2, 2, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (11, '用户新增', 'user:add', 2, 2, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (12, '用户编辑', 'user:edit', 2, 2, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (13, '用户删除', 'user:delete', 2, 2, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (14, '重置密码', 'user:resetPwd', 2, 2, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (20, '角色查询', 'role:list', 2, 3, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (21, '角色新增', 'role:add', 2, 3, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (22, '角色编辑', 'role:edit', 2, 3, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (23, '角色删除', 'role:delete', 2, 3, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (24, '分配权限', 'role:assign', 2, 3, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (30, '菜单查询', 'menu:list', 2, 4, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (31, '菜单新增', 'menu:add', 2, 4, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (32, '菜单编辑', 'menu:edit', 2, 4, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (33, '菜单删除', 'menu:delete', 2, 4, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (40, '权限查询', 'permission:list', 2, 5, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (41, '权限新增', 'permission:add', 2, 5, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (42, '权限编辑', 'permission:edit', 2, 5, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (43, '权限删除', 'permission:delete', 2, 5, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色代码',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除: 0-正常, 1-删除',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'super_admin', 1, 1, '2026-03-05 20:16:02', '2026-03-05 20:16:02', 0, '拥有系统所有权限');
INSERT INTO `sys_role` VALUES (2, '管理员', 'admin', 1, 2, '2026-03-05 20:16:15', '2026-03-05 20:16:15', 0, '管理用户和角色');
INSERT INTO `sys_role` VALUES (3, '普通用户', 'user', 1, 3, '2026-03-05 20:16:34', '2026-03-05 20:16:34', 0, '普通用户权限');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `permission_id` bigint(20) NOT NULL COMMENT '权限ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_role_perm`(`role_id` ASC, `permission_id` ASC) USING BTREE COMMENT '防止重复授权',
  INDEX `idx_permission_id`(`permission_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色权限关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES (53, 2, 1, '2026-03-23 17:45:20');
INSERT INTO `sys_role_permission` VALUES (54, 2, 2, '2026-03-23 17:45:20');
INSERT INTO `sys_role_permission` VALUES (55, 2, 3, '2026-03-23 17:45:20');
INSERT INTO `sys_role_permission` VALUES (56, 2, 10, '2026-03-23 17:45:20');
INSERT INTO `sys_role_permission` VALUES (57, 2, 11, '2026-03-23 17:45:20');
INSERT INTO `sys_role_permission` VALUES (58, 2, 12, '2026-03-23 17:45:20');
INSERT INTO `sys_role_permission` VALUES (59, 1, 2, '2026-03-23 18:03:32');
INSERT INTO `sys_role_permission` VALUES (60, 1, 10, '2026-03-23 18:03:32');
INSERT INTO `sys_role_permission` VALUES (61, 1, 11, '2026-03-23 18:03:32');
INSERT INTO `sys_role_permission` VALUES (62, 1, 12, '2026-03-23 18:03:32');
INSERT INTO `sys_role_permission` VALUES (63, 1, 13, '2026-03-23 18:03:32');
INSERT INTO `sys_role_permission` VALUES (64, 1, 14, '2026-03-23 18:03:32');

-- ----------------------------
-- Table structure for sys_upload
-- ----------------------------
DROP TABLE IF EXISTS `sys_upload`;
CREATE TABLE `sys_upload`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '原文件名',
  `file_path` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '存储路径',
  `file_size` bigint(20) NULL DEFAULT NULL COMMENT '文件大小 (字节)',
  `file_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '文件类型',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '上传用户 ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `del` tinyint(4) NULL DEFAULT 0 COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_upload
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码(加密)',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像URL',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除: 0-正常, 1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE,
  INDEX `idx_role_id`(`role_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '$2b$10$us4Uh.REhCfKhWh9JOdcOeRWMSWSHdUcPNvGUJyANwil5OFEuVmqC', 'admin@qq.com', '管理员', '13800138000', NULL, 1, 1, '2026-03-05 00:27:27', '2026-03-23 17:45:11', 0);
INSERT INTO `sys_user` VALUES (2, 'user01', '$2a$10$eKF6lEGSwQ.7sWoujzEvlOSTU/PFj.Vvpgx59/kfvVZPltx8X7GbC', 'user01@qq.com', '测试用户', '13800138001', NULL, 1, 1, '2026-03-04 14:02:55', '2026-03-23 17:25:04', 0);

SET FOREIGN_KEY_CHECKS = 1;
