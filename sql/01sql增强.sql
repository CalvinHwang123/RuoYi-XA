DROP VIEW IF EXISTS `act_id_user`;
CREATE VIEW `act_id_user` AS select `u`.`login_name` AS `ID_`,0 AS `REV_`,`u`.`user_name` AS `FIRST_`,'' AS `LAST_`,`u`.`email` AS `EMAIL_`,`u`.`password` AS `PWD_`,'' AS `PICTURE_ID_` from `sys_user` `u`;

DROP VIEW IF EXISTS `act_id_group`;
CREATE VIEW `act_id_group` AS select `r`.`role_key` AS `ID_`,NULL AS `REV_`,`r`.`role_name` AS `NAME_`,'assignment' AS `TYPE_` from `sys_role` `r`;

DROP VIEW IF EXISTS `act_id_membership`;
CREATE VIEW `act_id_membership` AS select (select `u`.`login_name` from `sys_user` `u` where (`u`.`user_id` = `ur`.`user_id`)) AS `USER_ID_`,(select `r`.`role_key` from `sys_role` `r` where (`r`.`role_id` = `ur`.`role_id`)) AS `GROUP_ID_` from `sys_user_role` `ur`;

DROP TABLE IF EXISTS `wf_category`;
CREATE TABLE `wf_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '上级ID',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `ancestors` varchar(100) DEFAULT '' COMMENT '祖级列表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程分类表';

DROP TABLE IF EXISTS `wf_base_data`;
CREATE TABLE `wf_base_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key_` varchar(255) DEFAULT NULL COMMENT 'key',
  `value_` longtext COMMENT 'value',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程基础信息表';

DROP TABLE IF EXISTS `wf_form`;
CREATE TABLE `wf_form` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `label` varchar(50) DEFAULT '' COMMENT '名称',
  `path` varchar(500) DEFAULT '' COMMENT '路径',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `schema` longtext COMMENT '表单JSON',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表单管理';

DROP TABLE IF EXISTS `wf_business_instance`;
CREATE TABLE `wf_business_instance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `business_key` varchar(36) DEFAULT NULL COMMENT '业务表id',
  `instance_id` varchar(255) DEFAULT NULL COMMENT '流程实例id',
  `table_code` varchar(255) DEFAULT NULL COMMENT '物理表名',
  `apply_user_id` varchar(255) DEFAULT NULL COMMENT '申请人',
  `apply_user_name` varchar(255) DEFAULT NULL COMMENT '申请人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `type` varchar(255) DEFAULT 'normal' COMMENT '类型（normal业务表单，online在线表单）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务记录流程实例关系表';

DROP TABLE IF EXISTS `wf_msg_log`;
CREATE TABLE `wf_msg_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `to_user` varchar(255) DEFAULT NULL COMMENT '接收用户',
  `content` text COMMENT '内容',
  `type` tinyint(2) DEFAULT NULL COMMENT '类型（1待办提醒、2催办提醒、3抄送提醒、4已审批提醒、5、完成审批提醒、6超时审批提醒）',
  `task_id` varchar(64) DEFAULT NULL COMMENT '任务ID',
  `task_name` varchar(255) DEFAULT NULL COMMENT '任务名称',
  `instance_id` varchar(64) DEFAULT NULL COMMENT '实例ID',
  `instance_name` varchar(255) DEFAULT NULL COMMENT '流程名称',
  `business_key` varchar(36) DEFAULT NULL COMMENT '业务表ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `is_read` bit(1) DEFAULT b'0' COMMENT '0未读，1已读',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息提醒表';

DROP TABLE IF EXISTS `wf_post_relation`;
CREATE TABLE `wf_post_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `post_id` bigint(20) DEFAULT NULL COMMENT '岗位ID',
  `super_post_id` bigint(20) DEFAULT NULL COMMENT '上级岗位ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='岗位汇报关系表';

DROP TABLE IF EXISTS `wf_user_group`;
CREATE TABLE `wf_user_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(50) NOT NULL COMMENT '编码',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `users` text COMMENT '组成员',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程用户组表';

DROP TABLE IF EXISTS `wf_user_post`;
CREATE TABLE `wf_user_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` varchar(100) DEFAULT NULL COMMENT '用户ID',
  `post_id` varchar(100) DEFAULT NULL COMMENT '岗位ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='岗位成员表';

DROP TABLE IF EXISTS `wf_user_dept`;
CREATE TABLE `wf_user_dept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` varchar(100) DEFAULT NULL COMMENT '用户ID',
  `dept_id` varchar(100) DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT=' 部门成员表';

DROP TABLE IF EXISTS `wf_delegate_info`;
CREATE TABLE `wf_delegate_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `assignee` varchar(200) DEFAULT NULL,
  `attorney` varchar(200) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `process_definition_id` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `time_range` varchar(100) DEFAULT NULL COMMENT '时间范围',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='委托数据表';

DROP TABLE IF EXISTS `wf_delegate_history`;
CREATE TABLE `wf_delegate_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `assignee` varchar(200) DEFAULT NULL,
  `attorney` varchar(200) DEFAULT NULL,
  `delegate_time` datetime DEFAULT NULL,
  `task_id` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COMMENT='委托办理流水记录表';

DROP TABLE IF EXISTS `wf_task_auto_complete`;
CREATE TABLE `wf_task_auto_complete` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `task_definition_key` varchar(255) DEFAULT NULL COMMENT '任务定义key',
  `instance_id` varchar(255) DEFAULT NULL COMMENT '流程实例ID',
  `status` varchar(255) DEFAULT '未完成' COMMENT '完成状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务自动完成表';

DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(64) NOT NULL DEFAULT '' COMMENT '文件名',
  `file_suffix` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀名',
  `url` varchar(200) NOT NULL COMMENT 'URL地址',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) NOT NULL DEFAULT '' COMMENT '上传人',
  `service` tinyint(2) NOT NULL DEFAULT '1' COMMENT '服务商',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文件上传';

DROP TABLE IF EXISTS `wf_oss_task`;
CREATE TABLE `wf_oss_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `oss_id` bigint(20) NOT NULL COMMENT '文件id',
  `task_id` varchar(64) DEFAULT NULL COMMENT '任务ID',
  `instance_id` varchar(64) DEFAULT NULL COMMENT '实例ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='附件任务关系表';

DROP TABLE IF EXISTS `wf_table_attachment`;
CREATE TABLE `wf_table_attachment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `table_code` varchar(255) DEFAULT NULL COMMENT '物理表名',
  `field_name` varchar(255) DEFAULT NULL COMMENT '字段名',
  `type` varchar(255) DEFAULT NULL COMMENT '类型（input-file 或者 input-image）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='业务字段附件表';

DROP TABLE IF EXISTS `wf_table_attachment_record`;
CREATE TABLE `wf_table_attachment_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `table_attachment_id` bigint(20) DEFAULT NULL COMMENT '业务字段附件id',
  `business_key` varchar(36) DEFAULT NULL COMMENT '业务表id',
  `oss_id` bigint(20) NOT NULL COMMENT '文件id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='业务字段附件记录表';

DROP TABLE IF EXISTS `wf_function_button`;
CREATE TABLE `wf_function_button` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '上级ID',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `ancestors` varchar(100) DEFAULT '' COMMENT '祖级列表',
  `url` varchar(500) DEFAULT NULL COMMENT '请求url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='功能按钮表';

INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('1', '基础信息', '0', '', '1', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('2', '列表', '1', '', '1', '0,1', '/wfBaseData/list,/wfBaseData/getBusinessInstanceMapping,/wfBaseData/getTableCodeByURI,/wfBaseData/getInstanceIdListByTableCode');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('3', '新增', '1', '', '2', '0,1', '/wfBaseData/add');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('4', '编辑', '1', '', '3', '0,1', '/wfBaseData/update');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('5', '删除', '1', '', '4', '0,1', '/wfBaseData/delete');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('6', '流程分类', '0', '', '2', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('7', '列表', '6', '', '1', '0,6', '/wfCategory/list,/wfCategory/treeSelect');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('8', '新增', '6', '', '2', '0,6', '/wfCategory/add');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('9', '编辑', '6', '', '3', '0,6', '/wfCategory/update');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('10', '删除', '6', '', '4', '0,6', '/wfCategory/delete');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('11', '流程模型', '0', '', '3', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('12', '列表', '11', '', '1', '0,11', '/modeler/list,/modeler/getUserList,/modeler/getRoleList');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('13', '新增', '11', '', '2', '0,11', '/modeler/create');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('14', '编辑', '11', '', '3', '0,11', '/modeler/update,/modeler/batchUpdate,/modeler/editor/stencilset,/modeler/model,/modeler/deploy');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('15', '删除', '11', '', '4', '0,11', '/modeler/delete');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('16', '流程定义', '0', '', '4', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('17', '列表', '16', '', '1', '0,16', '/definition/list,/definition/readResource');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('18', '新增', '16', '', '2', '0,16', '/definition/upload');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('19', '编辑', '16', '', '3', '0,16', '/definition/suspendOrActiveApply,/definition/convert2Model');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('20', '删除', '16', '', '4', '0,16', '/definition/delete');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('21', '流程中心', '0', '', '5', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('22', '提交申请', '21', '', '1', '0,21', '/api/process/submitApply');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('23', '我的待办', '21', '', '2', '0,21', '/api/process/todoTaskList2');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('24', '我参与的', '21', '', '3', '0,21', '/api/process/doneTaskList2');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('25', '我发起的', '21', '', '4', '0,21', '/api/process/applyInstanceList2');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('26', '我的草稿', '21', '', '5', '0,21', '/api/process/draftApplyList');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('27', '审批历史', '21', '', '6', '0,21', '/api/process/historyList');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('28', '进度查看', '21', '', '7', '0,21', '/api/process/readResource');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('29', '上传附件', '21', '', '8', '0,21', '/api/process/addAttachmentFile');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('30', '下载附件', '21', '', '9', '0,21', '/api/process/downloadAttachment');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('31', '同意', '21', '', '10', '0,21', '/api/process/complete');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('32', '退回', '21', '', '11', '0,21', '/api/process/backNodes,/api/process/doBackNode');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('33', '多实例加签', '21', '', '12', '0,21', '/api/process/doAddExecution');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('34', '多实例减签', '21', '', '13', '0,21', '/api/process/doDeleteExecution');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('35', '流程实例', '0', '', '6', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('36', '列表', '35', '', '1', '0,35', '/api/instance/list');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('37', '撤销', '35', '', '2', '0,35', '/api/instance/cancelApply');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('38', '挂起/激活', '35', '', '3', '0,35', '/api/instance/suspendeOrActiveApply');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('39', '门户管理', '0', '', '7', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('40', '获取用户信息', '39', '', '1', '0,39', '/api/portlet/getUserProfile,/api/portlet/getWebsocketOrigin');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('41', '待办数量', '39', '', '2', '0,39', '/api/portlet/getTodoDoneApplyCount');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('42', '消息列表', '39', '', '3', '0,39', '/api/portlet/getMessageLog,/api/portlet/getMessageLog2,/api/portlet/getMessageLogList');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('43', '设为已读', '39', '', '4', '0,39', '/api/portlet/updateIsRead');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('44', '催办', '39', '', '5', '0,39', '/api/portlet/doUrgeTask');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('45', '消息中心', '0', '', '8', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('46', '列表', '45', '', '1', '0,45', '/api/portlet/getMessageLogList');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('47', '设为已读', '45', '', '2', '0,45', '/api/portlet/updateIsRead,/api/portlet/batchUpdateIsRead');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('48', '部门管理', '0', '', '9', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('49', '列表', '48', '', '1', '0,48', '/wfDept/list,/wfDept/treeSelect');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('50', '同步视图', '48', '', '2', '0,48', '/wfDept/syncView');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('51', '删除视图', '48', '', '3', '0,48', '/wfDept/delView');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('52', '新增', '48', '', '4', '0,48', '/wfDept/add');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('53', '删除', '48', '', '5', '0,48', '/wfDept/delete');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('54', '岗位管理', '0', '', '10', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('55', '列表', '54', '', '1', '0,54', '/wfPost/list');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('56', '同步视图', '54', '', '2', '0,54', '/wfPost/syncView');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('57', '删除视图', '54', '', '3', '0,54', '/wfPost/delView');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('58', '新增', '54', '', '4', '0,54', '/wfPost/add');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('59', '删除', '54', '', '5', '0,54', '/wfPost/delete');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('60', '岗位汇报关系', '0', '', '11', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('61', '列表', '60', '', '1', '0,60', '/wfPost/postRelationList');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('62', '新增', '60', '', '2', '0,60', '/wfPost/addPostRelation');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('63', '编辑', '60', '', '3', '0,60', '/wfPost/updatePostRelation,/wfPost/batchUpdatePostRelation');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('64', '删除', '60', '', '4', '0,60', '/wfPost/deletePostRelation');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('65', '岗位成员', '0', '', '12', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('66', '列表', '65', '', '1', '0,65', '/wfUserPost/userPostList');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('67', '新增', '65', '', '2', '0,65', '/wfUserPost/addUserPost');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('68', '编辑', '65', '', '3', '0,65', '/wfUserPost/updateUserPost,/wfUserPost/batchUpdateUserPost');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('69', '删除', '65', '', '4', '0,65', '/wfUserPost/deleteUserPost');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('70', '部门成员', '0', '', '13', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('71', '列表', '70', '', '1', '0,70', '/wfUserDept/userDeptList');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('72', '新增', '70', '', '2', '0,70', '/wfUserDept/addUserDept');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('73', '编辑', '70', '', '3', '0,70', '/wfUserDept/updateUserDept');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('74', '删除', '70', '', '4', '0,70', '/wfUserDept/deleteUserDept');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('75', '用户组', '0', '', '14', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('76', '列表', '75', '', '1', '0,70', '/wfUserGroup/list');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('77', '新增', '75', '', '2', '0,70', '/wfUserGroup/add');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('78', '编辑', '75', '', '3', '0,70', '/wfUserGroup/update');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('79', '删除', '75', '', '4', '0,70', '/wfUserGroup/delete');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('80', '功能按钮', '0', '', '15', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('81', '列表', '80', '', '1', '0,80', '/wfAuth/roleList,/wfAuth/treeSelect');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('82', '配置', '80', '', '2', '0,80', '/wfAuth/updateFunBtn');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('83', '流程代理', '0', '', '15', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('84', '列表', '83', '', '1', '0,83', '/wfDelegate/list,/wfDelegate/getDelegateHistoryList');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('85', '新增', '83', '', '2', '0,83', '/wfDelegate/add');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('86', '编辑', '83', '', '3', '0,83', '/wfDelegate/update');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('87', '删除', '83', '', '4', '0,83', '/wfDelegate/delete');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('88', '流程标题配置', '0', '', '16', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('89', '列表', '88', '', '1', '0,88', '/wfTitle/list');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('90', '新增', '88', '', '2', '0,88', '/wfTitle/add');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('91', '编辑', '88', '', '3', '0,88', '/wfTitle/update');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('92', '删除', '88', '', '4', '0,88', '/wfTitle/delete');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('93', '附件上传配置', '0', '', '17', '0', NULL);
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('94', '列表', '93', '', '1', '0,93', '/wfOss/list');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('95', '新增', '93', '', '2', '0,93', '/wfOss/add');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('96', '编辑', '93', '', '3', '0,93', '/wfOss/update');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('97', '删除', '93', '', '4', '0,93', '/wfOss/delete');
INSERT INTO `wf_function_button` (`id`, `name`, `parent_id`, `remark`, `order_num`, `ancestors`, `url`) VALUES ('98', '上传', '93', '', '5', '0,93', '/wfOss/upload');

DROP TABLE IF EXISTS `wf_role_function`;
CREATE TABLE `wf_role_function` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(64) NOT NULL COMMENT '角色id',
  `function_id` bigint(20) DEFAULT NULL COMMENT '功能按钮ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色功能按钮表';

INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('77', 'common', '2');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('78', 'common', '7');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('79', 'common', '22');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('80', 'common', '23');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('81', 'common', '24');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('82', 'common', '25');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('83', 'common', '26');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('84', 'common', '27');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('85', 'common', '28');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('86', 'common', '29');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('87', 'common', '30');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('88', 'common', '31');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('89', 'common', '32');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('90', 'common', '33');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('91', 'common', '34');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('92', 'common', '40');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('93', 'common', '41');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('94', 'common', '42');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('95', 'common', '43');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('96', 'common', '44');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('97', 'common', '46');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('98', 'common', '47');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('99', 'common', '84');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('100', 'common', '85');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('101', 'common', '86');
INSERT INTO `wf_role_function` (`id`, `role_id`, `function_id`) VALUES ('102', 'common', '87');

DROP TABLE IF EXISTS `wf_apply_auth`;
CREATE TABLE `wf_apply_auth` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `key` varchar(100) DEFAULT NULL COMMENT '流程KEY',
  `type` varchar(100) DEFAULT NULL COMMENT '类型(user, role, dept)',
  `user_id` varchar(64) DEFAULT NULL COMMENT '用户ID',
  `role_id` varchar(64) DEFAULT NULL COMMENT '角色ID',
  `dept_id` varchar(64) DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT=' 流程发起权限表';

DROP TABLE IF EXISTS `wf_dynamic_sql`;
CREATE TABLE `wf_dynamic_sql` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `task_definition_key` varchar(500) DEFAULT NULL COMMENT '用户任务ID',
  `process_definition_key` varchar(500) DEFAULT NULL COMMENT '流程定义KEY',
  `sql` varchar(500) DEFAULT NULL COMMENT 'SQL内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT=' 动态SQL表';

DROP TABLE IF EXISTS `biz_leave`;
CREATE TABLE `biz_leave` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `type` char(20) DEFAULT NULL COMMENT '请假类型',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `reason` varchar(500) DEFAULT NULL COMMENT '原因',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `total_time` bigint(11) DEFAULT NULL COMMENT '请假时长，单位秒',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `reality_start_time` datetime DEFAULT NULL COMMENT '实际开始时间',
  `reality_end_time` datetime DEFAULT NULL COMMENT '实际结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `biz_correct`;
CREATE TABLE `biz_correct` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `employee_name` varchar(50) DEFAULT NULL COMMENT '员工姓名',
  `in_time` date DEFAULT NULL COMMENT '入职日期',
  `reason` varchar(500) DEFAULT NULL COMMENT '转正理由',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工转正表';
