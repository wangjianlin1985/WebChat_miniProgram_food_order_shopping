var utils = require("../../utils/common.js")
var config = require("../../utils/config.js")

Page({
  /**
   * 页面的初始数据
   */
  data: {
    productId: 0, //商品id
    productClassObj: "", //菜品类别
    productName: "", //菜品名称
    mainPhotoUrl: "", //菜品图片
    price: "", //套餐价格
    productDesc: "", //菜品描述
    printShopObj: "", //餐饮店
    addTime: "", //发布时间
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (params) {
    var self = this
    var productId = params.productId
    var url = config.basePath + "api/product/get/" + productId
    utils.sendRequest(url, {}, function (productRes) {
      wx.stopPullDownRefresh()
      self.setData({
        productId: productRes.data.productId,
        productClassObj: productRes.data.productClassObj.className,
        productName: productRes.data.productName,
        mainPhoto: productRes.data.mainPhoto,
        mainPhotoUrl: productRes.data.mainPhotoUrl,
        price: productRes.data.price,
        productDesc: productRes.data.productDesc,
        printShopObj: productRes.data.printShopObj.shopName,
        addTime: productRes.data.addTime,
      })
    })
  },

  addOrder: function() {
    var self = this
    wx.navigateTo({
      url: '../orderInfo/orderInfo_user_add?productId=' + self.data.productId ,
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

