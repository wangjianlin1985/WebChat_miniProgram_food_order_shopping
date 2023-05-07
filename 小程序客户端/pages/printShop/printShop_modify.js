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
    shopPhoto: "upload/NoImage.jpg", //餐饮店照片
    shopPhotoUrl: "",
    shopPhotoList: [],
    shopDesc: "", //餐饮店介绍
    bornDate: "", //成立日期
    connectPerson: "", //联系人
    telephone: "", //联系电话
    address: "", //餐饮店地址
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  //选择成立日期事件
  bind_bornDate_change: function (e) {
    this.setData({
      bornDate: e.detail.value
    })
  },
  //清空成立日期事件
  clear_bornDate: function (e) {
    this.setData({
      bornDate: "",
    });
  },

  //选择餐饮店照片上传
  select_shopPhoto: function (e) {
    var self = this
    wx.chooseImage({
      count: 1,   //可以上传一张图片
      sizeType: ['original', 'compressed'],
      sourceType: ['album', 'camera'],
      success: function (res) {
        var tempFilePaths = res.tempFilePaths
        self.setData({
          shopPhotoList: tempFilePaths,
          loadingHide: false, 
        });

        utils.sendUploadImage(config.basePath + "upload/image", tempFilePaths[0], function (res) {
          wx.stopPullDownRefresh()
          setTimeout(function () {
            self.setData({
              shopPhoto: res.data,
              loadingHide: true
            })
          }, 200)
        })
      }
    })
  },

  //提交服务器修改餐饮店信息
  formSubmit: function (e) {
    var self = this
    var formData = e.detail.value
    var url = config.basePath + "api/printShop/update"
    utils.sendRequest(url, formData, function (res) {
      wx.stopPullDownRefresh();
      wx.showToast({
        title: '修改成功',
        icon: 'success',
        duration: 500
      })

      //服务器修改成功返回列表页更新显示为最新的数据
      var pages = getCurrentPages()
      var printShoplist_page = pages[pages.length - 2];
      var printShops = printShoplist_page.data.printShops
      for(var i=0;i<printShops.length;i++) {
        if(printShops[i].shopUserName == res.data.shopUserName) {
          printShops[i] = res.data
          break
        }
      }
      printShoplist_page.setData({printShops:printShops})
      setTimeout(function () {
        wx.navigateBack({})
      }, 500) 
    })
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
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
  },

})

