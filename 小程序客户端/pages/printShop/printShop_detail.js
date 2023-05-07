var utils = require("../../utils/common.js")
var config = require("../../utils/config.js")

Page({
  /**
   * 页面的初始数据
   */
  data: {
    shopUserName: "", //餐饮店账号
    password: "", //登录密码
    shopName: "", //餐饮店名称
    shopPhotoUrl: "", //餐饮店照片
    shopDesc: "", //餐饮店介绍
    bornDate: "", //成立日期
    connectPerson: "", //联系人
    telephone: "", //联系电话
    address: "", //餐饮店地址
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (params) {
    var self = this
    var shopUserName = params.shopUserName
    var url = config.basePath + "api/printShop/get/" + shopUserName
    utils.sendRequest(url, {}, function (printShopRes) {
      wx.stopPullDownRefresh()
      self.setData({
        shopUserName: printShopRes.data.shopUserName,
        password: printShopRes.data.password,
        shopName: printShopRes.data.shopName,
        shopPhoto: printShopRes.data.shopPhoto,
        shopPhotoUrl: printShopRes.data.shopPhotoUrl,
        shopDesc: printShopRes.data.shopDesc,
        bornDate: printShopRes.data.bornDate,
        connectPerson: printShopRes.data.connectPerson,
        telephone: printShopRes.data.telephone,
        address: printShopRes.data.address,
      })
    })
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
  }

})

