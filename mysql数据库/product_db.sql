/*
Navicat MySQL Data Transfer

Source Server         : mysql5.6
Source Server Version : 50620
Source Host           : localhost:3306
Source Database       : product_db

Target Server Type    : MYSQL
Target Server Version : 50620
File Encoding         : 65001

Date: 2020-06-10 16:00:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(800) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '小程序外卖送餐平台成立', '各位同学，欢迎来这里选择订餐', '2020-05-10 18:05:00');
INSERT INTO `t_notice` VALUES ('2', '订餐多多，实惠多多', '大家多多来订餐，我们入住的都是最实惠的餐饮店', '2020-05-14 00:12:34');

-- ----------------------------
-- Table structure for `t_orderinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_orderinfo`;
CREATE TABLE `t_orderinfo` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `productObj` int(11) NOT NULL COMMENT '打印套餐',
  `orderNum` int(11) NOT NULL COMMENT '订单数量',
  `totalMoney` float NOT NULL COMMENT '订单总金额',
  `payWay` varchar(20) NOT NULL COMMENT '支付方式',
  `orderStateObj` varchar(20) NOT NULL COMMENT '订单状态',
  `receiveName` varchar(20) NOT NULL COMMENT '收货人',
  `telephone` varchar(20) NOT NULL COMMENT '收货人电话',
  `address` varchar(80) NOT NULL COMMENT '收货人地址',
  `orderMemo` varchar(500) DEFAULT NULL COMMENT '订单备注',
  `userObj` varchar(30) NOT NULL COMMENT '下单用户',
  `orderTime` varchar(20) DEFAULT NULL COMMENT '下单时间',
  PRIMARY KEY (`orderId`),
  KEY `productObj` (`productObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_orderinfo_ibfk_1` FOREIGN KEY (`productObj`) REFERENCES `t_product` (`productId`),
  CONSTRAINT `t_orderinfo_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_orderinfo
-- ----------------------------
INSERT INTO `t_orderinfo` VALUES ('1', '1', '2', '40', '微信', '已下单', '李晓彤', '13985012083', '芙蓉8宿舍224寝室', '快递送货，饿死了', '13910831234', '2020-05-10 11:20:11');
INSERT INTO `t_orderinfo` VALUES ('2', '2', '2', '44', '支付宝', '已下单', '黄小琥', '13980224234', '香樟小区4栋1203', '快哦', '13688886666', '2020-05-12 23:08:56');
INSERT INTO `t_orderinfo` VALUES ('3', '3', '3', '75', '支付宝', '送货中', '李明堂', '13598010834', '南校区12宿舍', '来吧', '13688886666', '2020-05-13 00:34:00');

-- ----------------------------
-- Table structure for `t_printshop`
-- ----------------------------
DROP TABLE IF EXISTS `t_printshop`;
CREATE TABLE `t_printshop` (
  `shopUserName` varchar(30) NOT NULL COMMENT 'shopUserName',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `shopName` varchar(20) NOT NULL COMMENT '打印店名称',
  `shopPhoto` varchar(60) NOT NULL COMMENT '打印店照片',
  `shopDesc` varchar(800) NOT NULL COMMENT '打印店介绍',
  `bornDate` varchar(20) DEFAULT NULL COMMENT '成立日期',
  `connectPerson` varchar(50) NOT NULL COMMENT '联系人',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `address` varchar(80) DEFAULT NULL COMMENT '打印店地址',
  PRIMARY KEY (`shopUserName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_printshop
-- ----------------------------
INSERT INTO `t_printshop` VALUES ('shop1', '123', '哥老官川菜馆', 'upload/7f0f24ff-b4e2-4333-a67b-d1f7a8f79091.jpg', '提供各种四川名菜，送货上门', '2020-05-05', '黄先生', '13420182861', '滨江路10号');
INSERT INTO `t_printshop` VALUES ('shop2', '123', '好时尚家常菜馆', 'upload/6df1413a-9648-4d05-901d-6cda1d950eb2.jpg', '提供各种菜系，任你挑选', '2020-05-13', '张先生', '13784504082', '红星路10号');

-- ----------------------------
-- Table structure for `t_product`
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `productId` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `productClassObj` int(11) NOT NULL COMMENT '套餐类别',
  `productName` varchar(50) NOT NULL COMMENT '服务名称',
  `mainPhoto` varchar(60) NOT NULL COMMENT '服务图片',
  `price` float NOT NULL COMMENT '套餐价格',
  `productDesc` varchar(800) NOT NULL COMMENT '服务描述',
  `printShopObj` varchar(30) NOT NULL COMMENT '打印店',
  `addTime` varchar(20) DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`productId`),
  KEY `productClassObj` (`productClassObj`),
  KEY `printShopObj` (`printShopObj`),
  CONSTRAINT `t_product_ibfk_1` FOREIGN KEY (`productClassObj`) REFERENCES `t_productclass` (`classId`),
  CONSTRAINT `t_product_ibfk_2` FOREIGN KEY (`printShopObj`) REFERENCES `t_printshop` (`shopUserName`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('1', '1', '鱼香肉丝', 'upload/535d471e-0426-4c8e-b7cf-2544f1c8eaf7.jpg', '20', '原料：瘦肉、木耳、胡萝卜、小竹笋、青椒、剁椒、豆瓣酱、大蒜头、葱、糖、生抽、醋、淀粉、蚝油、盐、鸡精、水。', 'shop1', '2020-05-10 18:04:04');
INSERT INTO `t_product` VALUES ('2', '1', '宫保鸡丁', 'upload/e3afa543-2fa0-4271-ae98-7dc941d3e11a.jpg', '22', '原料：鸡胸肉、黄瓜、花生、干辣椒、鸡蛋、大葱、宫保酱汁、大蒜、料酒、盐、鸡精、淀粉。', 'shop1', '2020-05-11 00:10:47');
INSERT INTO `t_product` VALUES ('3', '2', '剁椒鱼头', 'upload/eb0e3106-bec6-4afe-bab8-8c9ce7f34eb7.jpg', '25', '原料：鱼头、剁椒、葱、姜片、蒜头、生抽、食用油、盐。', 'shop2', '2020-05-12 23:51:17');
INSERT INTO `t_product` VALUES ('4', '1', '腊豆烧豆腐', 'upload/c33aeb01-065c-4fc3-8203-e66e80a2062f.jpg', '18', '原料：豆腐、腊豆、盐、白糖、辣椒油、鸡汁鲜、豆瓣酱、料酒、食用油。', 'shop1', '2020-06-10 15:54:41');

-- ----------------------------
-- Table structure for `t_productclass`
-- ----------------------------
DROP TABLE IF EXISTS `t_productclass`;
CREATE TABLE `t_productclass` (
  `classId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类别id',
  `className` varchar(40) NOT NULL COMMENT '类别名称',
  `classDesc` varchar(500) NOT NULL COMMENT '类别描述',
  PRIMARY KEY (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_productclass
-- ----------------------------
INSERT INTO `t_productclass` VALUES ('1', '川菜', '四川名菜');
INSERT INTO `t_productclass` VALUES ('2', '湘菜', '湖南名菜');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) DEFAULT NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) DEFAULT NULL COMMENT '家庭地址',
  `regTime` varchar(20) DEFAULT NULL COMMENT '注册时间',
  `openid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('13688886666', '--', '鼠鼠', '男', '2020-01-01', 'upload/4b68b224b63d4c92a9e63916ebf1ca1f', '13688886666', '--', '--', '2020-05-10 23:14:39', 'oM7Mu5XyeVJSc8roaUCRlcz_IP9k');
INSERT INTO `t_userinfo` VALUES ('13910831234', '123', '张若曦', '女', '2020-05-06', 'upload/9e6cca88-d7c6-46df-8eb4-5a9dd12840a5.jpg', '13910831234', 'wagnxiagging@126.com', '四川成都红星路', '2020-05-10 18:00:45', null);
