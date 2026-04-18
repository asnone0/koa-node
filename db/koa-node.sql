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

 Date: 18/04/2026 12:02:12
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '百度网盘文件记录表' ROW_FORMAT = DYNAMIC;

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
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '类型: 1-菜单, 2-按钮/操作, 3-接口 ,4-模块',
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
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `uk_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 78 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '权限表(菜单+按钮+接口)' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES (1, '系统管理', 'system', 2, 0, '/system', 'Layout', 'Setting', 1, 1, '2026-03-18 10:27:36', '2026-04-17 15:05:36', 0);
INSERT INTO `sys_permission` VALUES (2, '用户管理', 'user', 2, 1, '/system/user', 'system/user/index', 'UserOutlined', 1, 1, '2026-03-18 10:27:36', '2026-04-17 15:05:12', 0);
INSERT INTO `sys_permission` VALUES (3, '角色管理', 'role', 2, 1, '/system/role', 'system/role/index', 'TeamOutlined', 2, 1, '2026-03-18 10:27:36', '2026-04-17 15:05:26', 0);
INSERT INTO `sys_permission` VALUES (4, '菜单管理', 'menu', 2, 1, '/system/menu', 'system/menu/index', 'Menu', 3, 1, '2026-03-18 10:27:36', '2026-04-17 15:05:22', 0);
INSERT INTO `sys_permission` VALUES (5, '权限管理', 'permission', 2, 1, '/system/permission', 'system/permission/index', 'Lock', 4, 1, '2026-03-18 10:27:36', '2026-04-17 15:05:17', 0);
INSERT INTO `sys_permission` VALUES (10, '用户查询', 'user:list', 2, 2, '/api/user', NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-24 15:17:45', 0);
INSERT INTO `sys_permission` VALUES (11, '用户新增', 'user:add', 2, 2, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (12, '用户编辑', 'user:edit', 2, 2, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (13, '用户删除', 'user:delete', 2, 2, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (14, '重置密码', 'user:resetPwd', 2, 2, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (20, '角色查询', 'role:list', 2, 3, '/api/role', NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-24 15:18:35', 0);
INSERT INTO `sys_permission` VALUES (21, '角色新增', 'role:add', 2, 3, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (22, '角色编辑', 'role:edit', 2, 3, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (23, '角色删除', 'role:delete', 2, 3, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (24, '分配权限', 'role:assign', 2, 3, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (30, '菜单查询', 'menu:list', 2, 4, '/api/menu', NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-24 15:19:31', 0);
INSERT INTO `sys_permission` VALUES (31, '菜单新增', 'menu:add', 2, 4, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (32, '菜单编辑', 'menu:edit', 2, 4, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (33, '菜单删除', 'menu:delete', 2, 4, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (40, '权限查询', 'permission:list', 2, 5, '/api/permission', NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-25 17:33:47', 0);
INSERT INTO `sys_permission` VALUES (41, '权限新增', 'permission:add', 2, 5, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (42, '权限编辑', 'permission:edit', 2, 5, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (43, '权限删除', 'permission:delete', 2, 5, NULL, NULL, NULL, 0, 1, '2026-03-18 10:27:36', '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (44, '用户查询', 'user:getlist', 3, 10, '/api/user', NULL, NULL, 0, 1, '2026-03-24 15:14:39', '2026-03-24 15:17:35', 1);
INSERT INTO `sys_permission` VALUES (45, '工作台', '', 2, 0, '/work', 'work', 'User', 0, 1, '2026-03-24 17:17:32', '2026-04-17 15:05:31', 0);
INSERT INTO `sys_permission` VALUES (46, '全部权限', 'role:all', 2, 3, '/api/role/all', NULL, NULL, 0, 1, '2026-03-25 17:51:25', '2026-03-25 17:51:25', 0);
INSERT INTO `sys_permission` VALUES (47, '获取基础信息', 'work:info', 2, 45, '/work/info', NULL, NULL, 0, 1, '2026-03-25 18:12:25', '2026-03-25 18:12:25', 0);
INSERT INTO `sys_permission` VALUES (72, '工作台', '', 1, 0, '/work', 'work', 'DashboardOutlined', 0, 1, '2026-04-17 15:16:40', '2026-04-17 15:16:40', 0);
INSERT INTO `sys_permission` VALUES (73, '系统管理', '', 1, 0, '/system', 'Layout', 'DashboardOutlined', 0, 1, '2026-04-17 15:17:35', '2026-04-17 15:17:35', 0);
INSERT INTO `sys_permission` VALUES (74, '用户管理', '', 1, 73, '/system/user', 'system/user/index', 'UserOutlined', 0, 1, '2026-04-17 15:18:09', '2026-04-17 15:18:09', 0);
INSERT INTO `sys_permission` VALUES (75, '角色管理', '', 1, 73, '/system/role', 'system/role/index', 'TeamOutlined', 0, 1, '2026-04-17 15:18:38', '2026-04-17 15:28:25', 0);
INSERT INTO `sys_permission` VALUES (76, '菜单管理', '', 1, 73, '/system/menu', 'system/menu/index', 'MenuOutlined', 0, 1, '2026-04-17 15:18:59', '2026-04-17 15:18:59', 0);
INSERT INTO `sys_permission` VALUES (77, '权限管理', '', 1, 73, '/system/permission', 'system/permission/index', 'AppstoreOutlined', 0, 1, '2026-04-17 15:19:35', '2026-04-17 15:19:35', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 1789 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色权限关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES (1267, 3, 1, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1268, 3, 2, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1269, 3, 3, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1270, 3, 4, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1271, 3, 5, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1272, 3, 10, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1273, 3, 11, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1274, 3, 12, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1275, 3, 13, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1276, 3, 14, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1277, 3, 20, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1278, 3, 21, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1279, 3, 22, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1280, 3, 23, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1281, 3, 24, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1282, 3, 30, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1283, 3, 31, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1284, 3, 32, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1285, 3, 33, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1286, 3, 40, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1287, 3, 41, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1288, 3, 42, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1289, 3, 43, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1290, 3, 45, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1291, 3, 46, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1292, 3, 47, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1293, 3, 72, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1294, 3, 73, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1295, 3, 74, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1296, 3, 75, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1297, 3, 76, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1298, 3, 77, '2026-04-17 16:54:44');
INSERT INTO `sys_role_permission` VALUES (1720, 1, 72, '2026-04-18 10:24:51');
INSERT INTO `sys_role_permission` VALUES (1721, 1, 74, '2026-04-18 10:24:51');
INSERT INTO `sys_role_permission` VALUES (1722, 1, 75, '2026-04-18 10:24:51');
INSERT INTO `sys_role_permission` VALUES (1723, 1, 76, '2026-04-18 10:24:51');
INSERT INTO `sys_role_permission` VALUES (1724, 1, 73, '2026-04-18 10:24:51');
INSERT INTO `sys_role_permission` VALUES (1759, 2, 1, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1760, 2, 2, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1761, 2, 3, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1762, 2, 4, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1763, 2, 5, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1764, 2, 10, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1765, 2, 11, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1766, 2, 12, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1767, 2, 13, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1768, 2, 14, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1769, 2, 20, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1770, 2, 21, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1771, 2, 22, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1772, 2, 23, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1773, 2, 24, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1774, 2, 30, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1775, 2, 31, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1776, 2, 32, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1777, 2, 33, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1778, 2, 40, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1779, 2, 41, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1780, 2, 42, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1781, 2, 43, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1782, 2, 45, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1783, 2, 46, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1784, 2, 47, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1785, 2, 72, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1786, 2, 73, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1787, 2, 74, '2026-04-18 10:25:08');
INSERT INTO `sys_role_permission` VALUES (1788, 2, 75, '2026-04-18 10:25:08');

-- ----------------------------
-- Table structure for sys_upload
-- ----------------------------
DROP TABLE IF EXISTS `sys_upload`;
CREATE TABLE `sys_upload`  (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '主键ID',
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
INSERT INTO `sys_upload` VALUES ('ec4848c7-e94e-449e-8fe6-cf1b4701408a', '�6�s.png', 'E:\\网站\\小程序服务端\\koa-node\\upload\\1776484624623-57616717.png', 3228083, 'image/png', NULL, '2026-04-18 11:57:04', 0);
INSERT INTO `sys_upload` VALUES ('a4a45f65-2185-4297-975e-a4a2a88ea310', '�6�s.png', 'E:\\网站\\小程序服务端\\koa-node\\upload\\1776484584908-429384516.png', 3228083, 'image/png', NULL, '2026-04-18 11:56:24', 0);
INSERT INTO `sys_upload` VALUES ('4fa0174f-f727-4787-a5e1-82798bb9b89d', '�6�s.png', 'E:\\网站\\小程序服务端\\koa-node\\upload\\1776484523427-422699332.png', 3228083, 'image/png', NULL, '2026-04-18 11:55:23', 0);
INSERT INTO `sys_upload` VALUES ('3c1ce492-2d1c-487b-a9b7-065b2fd9100d', '�6�s.png', 'E:\\网站\\小程序服务端\\koa-node\\upload\\1776484634526-981488542.png', 3228083, 'image/png', NULL, '2026-04-18 11:57:14', 0);
INSERT INTO `sys_upload` VALUES ('df1c9ec9-6b1f-46ed-9e8e-b1b3139f634b', '�6�s.png', 'E:\\网站\\小程序服务端\\koa-node\\upload\\1776484636661-173403801.png', 3228083, 'image/png', NULL, '2026-04-18 11:57:16', 0);
INSERT INTO `sys_upload` VALUES ('9d8e5fe8-edc1-4c05-9f30-61e2058651b5', '�6�s.png', 'E:\\网站\\小程序服务端\\koa-node\\upload\\1776484650403-627755407.png', 3228083, 'image/png', NULL, '2026-04-18 11:57:30', 0);
INSERT INTO `sys_upload` VALUES ('cbdd502b-df0a-4b4d-b73a-f93e7c778ec7', '�6�s.png', 'E:\\网站\\小程序服务端\\koa-node\\upload\\1776484668284-847213223.png', 3228083, 'image/png', NULL, '2026-04-18 11:57:48', 0);
INSERT INTO `sys_upload` VALUES ('a3e42432-eb37-401d-99bf-24d8009b49dc', '�6�s.png', 'E:\\网站\\小程序服务端\\koa-node\\upload\\1776484670810-501208508.png', 3228083, 'image/png', NULL, '2026-04-18 11:57:50', 0);
INSERT INTO `sys_upload` VALUES ('c49d7a5e-436f-4cd4-a640-2156127e7419', '�6�s.png', 'E:\\网站\\小程序服务端\\koa-node\\upload\\1776484691828-529477731.png', 3228083, 'image/png', NULL, '2026-04-18 11:58:11', 0);
INSERT INTO `sys_upload` VALUES ('0f9c2f3f-08bf-4ea3-8912-40651ff39671', '�6�s.png', 'E:\\网站\\小程序服务端\\koa-node\\upload\\1776484711056-553884109.png', 3228083, 'image/png', NULL, '2026-04-18 11:58:31', 0);
INSERT INTO `sys_upload` VALUES ('f06a22c0-07c2-4b9a-bb70-e6c69126fb0f', '�6�s.png', 'E:\\网站\\小程序服务端\\koa-node\\upload\\1776484860272-127836230.png', 3228083, 'image/png', NULL, '2026-04-18 12:01:00', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '$2a$10$eKF6lEGSwQ.7sWoujzEvlOSTU/PFj.Vvpgx59/kfvVZPltx8X7GbC', 'admin@qq.com', '管理员', '13800138000', NULL, 1, 1, '2026-03-05 00:27:27', '2026-03-24 09:39:16', 0);
INSERT INTO `sys_user` VALUES (2, 'user', '$2a$10$eKF6lEGSwQ.7sWoujzEvlOSTU/PFj.Vvpgx59/kfvVZPltx8X7GbC', 'user01@qq.com', '测试用户', '13800138001', NULL, 2, 1, '2026-03-04 14:02:55', '2026-04-17 15:21:53', 0);
INSERT INTO `sys_user` VALUES (3, 'user02', '$2b$10$cpBHGKOFLZ10unrtHfutN.bUhxn3PgRDENjkfnw4PGXgZc9TDsXW6', 'user02@qq,com', 'user02', '1920191012212121', NULL, 2, 1, '2026-03-24 14:32:05', '2026-03-24 14:32:05', 0);

SET FOREIGN_KEY_CHECKS = 1;
