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

 Date: 17/04/2026 15:33:57
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
  INDEX `uk_code`(`code` ASC) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE
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
) ENGINE = InnoDB AUTO_INCREMENT = 617 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色权限关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES (539, 1, 1, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (540, 1, 2, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (541, 1, 3, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (542, 1, 4, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (543, 1, 5, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (544, 1, 10, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (545, 1, 11, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (546, 1, 12, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (547, 1, 13, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (548, 1, 14, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (549, 1, 20, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (550, 1, 21, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (551, 1, 22, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (552, 1, 23, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (553, 1, 24, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (554, 1, 30, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (555, 1, 31, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (556, 1, 32, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (557, 1, 33, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (558, 1, 40, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (559, 1, 41, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (560, 1, 42, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (561, 1, 43, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (562, 1, 45, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (563, 1, 46, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (564, 1, 47, '2026-04-17 15:19:42');
INSERT INTO `sys_role_permission` VALUES (565, 3, 45, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (566, 3, 47, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (567, 3, 1, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (568, 3, 2, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (569, 3, 3, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (570, 3, 4, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (571, 3, 5, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (572, 3, 10, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (573, 3, 11, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (574, 3, 12, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (575, 3, 13, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (576, 3, 14, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (577, 3, 20, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (578, 3, 21, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (579, 3, 22, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (580, 3, 23, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (581, 3, 24, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (582, 3, 46, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (583, 3, 30, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (584, 3, 31, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (585, 3, 32, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (586, 3, 33, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (587, 3, 40, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (588, 3, 41, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (589, 3, 42, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (590, 3, 43, '2026-04-17 15:19:50');
INSERT INTO `sys_role_permission` VALUES (591, 2, 10, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (592, 2, 45, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (593, 2, 47, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (594, 2, 1, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (595, 2, 2, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (596, 2, 3, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (597, 2, 4, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (598, 2, 5, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (599, 2, 11, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (600, 2, 12, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (601, 2, 13, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (602, 2, 14, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (603, 2, 20, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (604, 2, 21, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (605, 2, 22, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (606, 2, 23, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (607, 2, 24, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (608, 2, 46, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (609, 2, 30, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (610, 2, 31, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (611, 2, 32, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (612, 2, 33, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (613, 2, 40, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (614, 2, 41, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (615, 2, 42, '2026-04-17 15:23:31');
INSERT INTO `sys_role_permission` VALUES (616, 2, 43, '2026-04-17 15:23:31');

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '$2a$10$eKF6lEGSwQ.7sWoujzEvlOSTU/PFj.Vvpgx59/kfvVZPltx8X7GbC', 'admin@qq.com', '管理员', '13800138000', NULL, 1, 1, '2026-03-05 00:27:27', '2026-03-24 09:39:16', 0);
INSERT INTO `sys_user` VALUES (2, 'user', '$2a$10$eKF6lEGSwQ.7sWoujzEvlOSTU/PFj.Vvpgx59/kfvVZPltx8X7GbC', 'user01@qq.com', '测试用户', '13800138001', NULL, 2, 1, '2026-03-04 14:02:55', '2026-04-17 15:21:53', 0);
INSERT INTO `sys_user` VALUES (3, 'user02', '$2b$10$cpBHGKOFLZ10unrtHfutN.bUhxn3PgRDENjkfnw4PGXgZc9TDsXW6', 'user02@qq,com', 'user02', '1920191012212121', NULL, 2, 1, '2026-03-24 14:32:05', '2026-03-24 14:32:05', 0);

SET FOREIGN_KEY_CHECKS = 1;
