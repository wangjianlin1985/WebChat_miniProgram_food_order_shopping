# WebChat_miniProgram_food_order_shopping
微信小程序多商家外卖送餐订餐购物平台设计后端SSM可升级SpringBoot毕业源码案例设计

 设计一个基于微信小程序外卖送餐app,一共有3个身份包括用户，餐饮店和管理员！用户通过微信小程序打开app后可以查询最新上架的菜品信息，查询和查看餐饮店信息和菜品信息，选择菜品信息提交订单，查询自己的餐饮订单进度，还有查看新闻公告等！餐饮店长可以在web端注册登录后发布自己店铺的菜品信息，也可以管理和修改已经发布的菜品，可以查询自家菜品的订单信息，处理用户的订单，修改店铺信息等！管理员可以在web端登录后台管理注册用户信息以及餐饮店信息，管理菜谱分类及所有菜品信息，管理所有用户订单，发布新闻公告等！

## 实体ER属性如下：
用户: 用户名,登录密码,姓名,性别,出生日期,用户照片,联系电话,邮箱,家庭地址,注册时间,微信openid

餐饮店: 餐饮店账号,登录密码,餐饮店名称,餐饮店照片,餐饮店介绍,成立日期,联系人,联系电话,餐饮店地址

菜品类别: 类别id,类别名称,类别描述

菜品信息: 商品id,菜品类别,菜品名称,菜品图片,菜品价格,菜品描述,餐饮店,发布时间

订单: 订单编号,菜品信息,订单数量,订单总金额,支付方式,订单状态,收货人,收货人电话,收货人地址,订单备注,下单用户,下单时间

新闻公告: 公告id,标题,公告内容,发布时间

## 开发技术：微信小程序客户端 + Java后台服务器端 + mysql数据库