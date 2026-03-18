/*
 Navicat Premium Dump SQL

 Source Server         : asn
 Source Server Type    : MySQL
 Source Server Version : 80012 (8.0.12)
 Source Host           : localhost:3306
 Source Schema         : tasksystem

 Target Server Type    : MySQL
 Target Server Version : 80012 (8.0.12)
 File Encoding         : 65001

 Date: 18/03/2026 16:29:28
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
  `baidu_file_id` bigint(20) NULL DEFAULT NULL COMMENT '百度网盘文件 ID (注意：百度某些ID可能很大，建议确认是否需用 varchar)',
  `baidu_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '百度网盘路径',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del` tinyint(1) NULL DEFAULT 0 COMMENT '删除标记 0-正常 1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_del`(`del` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '百度网盘文件记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of biz_baidu_file
-- ----------------------------

-- ----------------------------
-- Table structure for biz_order
-- ----------------------------
DROP TABLE IF EXISTS `biz_order`;
CREATE TABLE `biz_order`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商单名称',
  `leader_id` bigint(20) NULL DEFAULT NULL COMMENT '负责人ID',
  `client_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '甲方名称',
  `prepaid_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '预付金额',
  `total_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '总付金额',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '描述',
  `images` json NULL COMMENT '上传图片列表 JSON 数组',
  `delivery_nodes` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '交付节点 (字符串描述)',
  `deadline` datetime NULL DEFAULT NULL COMMENT '截至时间/交付时间',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '状态: 0-待分配, 1-已分配, 2-进行中, 3-待交付, 4-已完成, 5-已超时',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_leader_id`(`leader_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_order
-- ----------------------------
INSERT INTO `biz_order` VALUES (1, '新的分镜提示词', 2, '212121', 1221.00, 2112.00, '', '[\"https://task-system-1318456993.cos.ap-chongqing.myqcloud.com/1773022088514-c5ad9820604c31536000f1eb28c92e04.mp4\"]', '[]', NULL, 1, '2026-03-09 10:08:10', '2026-03-09 15:55:52', 0);
INSERT INTO `biz_order` VALUES (2, '新的商单', NULL, '', 0.00, 0.00, '', NULL, '[]', NULL, 0, '2026-03-09 16:07:36', '2026-03-09 16:07:36', 0);

-- ----------------------------
-- Table structure for biz_task
-- ----------------------------
DROP TABLE IF EXISTS `biz_task`;
CREATE TABLE `biz_task`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务标题',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '任务描述',
  `creator_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人username\r\n',
  `creator_id` bigint(20) NOT NULL COMMENT '创建人ID',
  `leader_id` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人 ID 数组 (JSON 格式)',
  `team_id` bigint(20) NULL DEFAULT NULL COMMENT '所属团队ID',
  `order_id` bigint(20) NULL DEFAULT NULL COMMENT '所属商单ID (外键)',
  `deadline` datetime NULL DEFAULT NULL COMMENT '截至时间',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '状态: 0-待分配, 1-已分配, 2-进行中, 3-待交付, 4-已完成, 5-已超时',
  `review_status` tinyint(4) NULL DEFAULT 0 COMMENT '审核状态：0-未提交，1-待审核，2-已通过，3-已驳回',
  `last_submit_time` datetime NULL DEFAULT NULL COMMENT '最后提交时间',
  `attachments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '任务附件 (JSON 格式)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_creator`(`creator_id` ASC) USING BTREE,
  INDEX `idx_leader`(`leader_id` ASC) USING BTREE,
  INDEX `idx_team`(`team_id` ASC) USING BTREE,
  INDEX `idx_order`(`order_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_leader_id`(`leader_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_task
-- ----------------------------
INSERT INTO `biz_task` VALUES (1, '测试任务', '测试任务', 'admin', 2, '[1]', 1, 1, '2026-03-09 15:55:50', 0, 0, NULL, NULL, '2026-03-09 15:55:52', '2026-03-09 15:55:52', 0);

-- ----------------------------
-- Table structure for biz_task_submission
-- ----------------------------
DROP TABLE IF EXISTS `biz_task_submission`;
CREATE TABLE `biz_task_submission`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
  `task_id` bigint(20) NOT NULL COMMENT '任务 ID',
  `submitter_id` bigint(20) NOT NULL COMMENT '提交人 ID',
  `submitter_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '提交人姓名',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '提交内容描述',
  `attachments` json NULL COMMENT '附件列表 JSON 数组',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '审核状态：1-待审核，2-通过，3-驳回',
  `reviewer_id` bigint(20) NULL DEFAULT NULL COMMENT '审核人 ID',
  `reviewer_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核人姓名',
  `review_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '审核意见',
  `review_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_task_id`(`task_id` ASC) USING BTREE,
  INDEX `idx_submitter_id`(`submitter_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务提交记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_task_submission
-- ----------------------------

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限名称 (如: 商单管理)',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限标识 (英文Key, 如: order:list, task:create)',
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '类型: 1-菜单, 2-按钮/操作, 3-接口',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父级ID (用于构建树形菜单)',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '前端路由路径 (仅菜单类型需要)',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标 (仅菜单类型需要)',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `del` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES (1, '获取用户列表', 'user:list', 1, 0, '/api/user', NULL, 0, '2026-03-18 10:27:36', 0);
INSERT INTO `sys_permission` VALUES (2, '编辑用户', 'user:update', 1, 0, '/api/update', NULL, 0, '2026-03-18 10:34:03', 0);
INSERT INTO `sys_permission` VALUES (3, '上传文件', 'upload:file', 1, 0, '/api/upload', NULL, 0, '2026-03-18 11:43:38', 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `permissions` json NULL COMMENT '权限JSON: {\"order\":1, \"task\":0, ...}',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除: 0-正常, 1-删除',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', NULL, '2026-03-05 20:16:02', '2026-03-05 20:16:02', 0, NULL);
INSERT INTO `sys_role` VALUES (2, '团队负责人', NULL, '2026-03-05 20:16:15', '2026-03-05 20:16:15', 0, NULL);
INSERT INTO `sys_role` VALUES (3, '普通员工', NULL, '2026-03-05 20:16:34', '2026-03-05 20:16:34', 0, NULL);

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `permission_id` bigint(20) NOT NULL COMMENT '权限ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_role_perm`(`role_id` ASC, `permission_id` ASC) USING BTREE COMMENT '防止重复授权',
  INDEX `idx_permission_id`(`permission_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色权限关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES (1, 1, 1, '2026-03-18 10:27:53');
INSERT INTO `sys_role_permission` VALUES (2, 1, 2, '2026-03-18 10:37:02');
INSERT INTO `sys_role_permission` VALUES (3, 1, 3, '2026-03-18 11:43:52');

-- ----------------------------
-- Table structure for sys_team
-- ----------------------------
DROP TABLE IF EXISTS `sys_team`;
CREATE TABLE `sys_team`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '团队名称',
  `leader_id` bigint(20) NULL DEFAULT NULL COMMENT '负责人ID (关联 sys_user.id)',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '描述',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除: 0-正常, 1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_leader_id`(`leader_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '团队表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_team
-- ----------------------------
INSERT INTO `sys_team` VALUES (1, '2121', 1, '12121212', '2026-03-09 10:04:06', '2026-03-09 10:04:06', 0);

-- ----------------------------
-- Table structure for sys_team_member
-- ----------------------------
DROP TABLE IF EXISTS `sys_team_member`;
CREATE TABLE `sys_team_member`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `team_id` bigint(20) NOT NULL COMMENT '团队ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `join_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  `del` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_team_user`(`team_id` ASC, `user_id` ASC) USING BTREE COMMENT '防止重复加入'
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '团队成员关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_team_member
-- ----------------------------
INSERT INTO `sys_team_member` VALUES (1, 1, 1, '2026-03-09 10:04:10', 0);

-- ----------------------------
-- Table structure for sys_upload
-- ----------------------------
DROP TABLE IF EXISTS `sys_upload`;
CREATE TABLE `sys_upload`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '原文件名',
  `file_path` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '存储路径',
  `file_size` bigint(20) NULL DEFAULT NULL COMMENT '文件大小 (字节)',
  `file_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '文件类型',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '上传用户 ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `del` tinyint(4) NULL DEFAULT 0 COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_upload
-- ----------------------------
INSERT INTO `sys_upload` VALUES (1, 'HDh_3AeaAAAK46N.jpg', 'E:\\网站\\小程序服务端\\cms-server-node\\upload\\1773816666739-53948505.jpg', 1158713, 'image/jpeg', NULL, '2026-03-18 14:51:06', 0);

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
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
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
INSERT INTO `sys_user` VALUES (1, 'asnone0', '$2a$10$eKF6lEGSwQ.7sWoujzEvlOSTU/PFj.Vvpgx59/kfvVZPltx8X7GbC', '123@qq.com', '野性', 3, '2026-03-04 14:02:55', '2026-03-05 20:20:45', 0);
INSERT INTO `sys_user` VALUES (2, 'admin', '$2a$10$QnbXL73vAQGN3Y58TlZ.lOe16EVKV94pw3kmSqiU1NJQk5Nv8hGp2', 'admin@qq.com', '管理员', 1, '2026-03-05 00:27:27', '2026-03-09 16:57:28', 0);

SET FOREIGN_KEY_CHECKS = 1;
