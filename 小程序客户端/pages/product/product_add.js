var utils = require("../../utils/common.js");
var config = require("../../utils/config.js");

Page({
  /**
   * 页面的初始数据
   */
  data: {
    productId: 0, //商品id
    productClassObj_Index: "0", //菜品类别
    productClasss: [],
    productName: "", //菜品名称
    mainPhoto: "upload/NoImage.jpg", //菜品图片
    mainPhotoList: [],
    price: "", //套餐价格
    productDesc: "", //菜品描述
    printShopObj_Index: "0", //餐饮店
    printShops: [],
    addTime: "", //发布时间
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  //初始化下拉框的信息
  init_select_params: function () { 
    var self = this;
    var url = null;
    url = config.basePath + "api/printShop/listAll";
    utils.sendRequest(url, null, function (res) {
      wx.stopPullDownRefresh();
      self.setData({
        printShops: res.data,
      });
    });
    url = config.basePath + "api/productClass/listAll";
    utils.sendRequest(url, null, function (res) {
      wx.stopPullDownRefresh();
      self.setData({
        productClasss: res.data,
      });
    });
  },
  //菜品类别改变事件
  bind_productClassObj_change: function (e) {
    this.setData({
      productClassObj_Index: e.detail.value
    })
  },

  //餐饮店改变事件
  bind_printShopObj_change: function (e) {
    this.setData({
      printShopObj_Index: e.detail.value
    })
  },

  //选择发布时间
  bind_addTime_change: function (e) {
    this.setData({
      addTime: e.detail.value
    })
  },
  //清空发布时间
  clear_addTime: function (e) {
    this.setData({
      addTime: "",
    });
  },

  /*提交添加菜品信息到服务器 */
  formSubmit: function (e) {
    var self = this;
    var formData = e.detail.value;
    var url = config.basePath + "api/product/add";
    utils.sendRequest(url, formData, function (res) {
      wx.stopPullDownRefresh();
      wx.showToast({
        title: '发布成功',
        icon: 'success',
        duration: 500
      })

      //提交成功后重置表单数据
      self.setData({
        productId: 0,
        productClassObj_Index: "0",
    productName: "",
        mainPhoto: "upload/NoImage.jpg",
        mainPhotoList: [],
    price: "",
    productDesc: "",
        printShopObj_Index: "0",
    addTime: "",
        loadingHide: true,
        loadingText: "网络操作中。。",
      })
    });
  },

  //选择菜品图片上传
  select_mainPhoto: function (e) {
    var self = this
    wx.chooseImage({
      count: 1,   //可以上传一张图片
      sizeType: ['original', 'compressed'],
      sourceType: ['album', 'camera'],
      success: function (res) {
        var tempFilePaths = res.tempFilePaths
        self.setData({
          mainPhotoList: tempFilePaths,
          loadingHide: false
        });
        utils.sendUploadImage(config.basePath + "upload/image", tempFilePaths[0], function (res) {
          wx.stopPullDownRefresh()
          setTimeout(function () {
            self.setData({
              mainPhoto: res.data,
              loadingHide: true
            });
          }, 200);
        });
      }
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.init_select_params();
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    var token = wx.getStorageSync('authToken');
    if (!token) {
      wx.navigateTo({
        url: '../mobile/mobile',
      })
    }
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
  }
})

