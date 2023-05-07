var utils = require("../../utils/common.js");
var config = require("../../utils/config.js");

Page({
  /**
   * 页面的初始数据
   */
  data: {
    shopUserName: "", //餐饮店账号
    password: "", //登录密码
    shopName: "", //餐饮店名称
    shopPhoto: "upload/NoImage.jpg", //餐饮店照片
    shopPhotoList: [],
    shopDesc: "", //餐饮店介绍
    bornDate: "", //成立日期
    connectPerson: "", //联系人
    telephone: "", //联系电话
    address: "", //餐饮店地址
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  //选择成立日期
  bind_bornDate_change: function (e) {
    this.setData({
      bornDate: e.detail.value
    })
  },
  //清空成立日期
  clear_bornDate: function (e) {
    this.setData({
      bornDate: "",
    });
  },

  /*提交添加餐饮店到服务器 */
  formSubmit: function (e) {
    var self = this;
    var formData = e.detail.value;
    var url = config.basePath + "api/printShop/add";
    utils.sendRequest(url, formData, function (res) {
      wx.stopPullDownRefresh();
      wx.showToast({
        title: '发布成功',
        icon: 'success',
        duration: 500
      })

      //提交成功后重置表单数据
      self.setData({
        shopUserName: "",
    password: "",
    shopName: "",
        shopPhoto: "upload/NoImage.jpg",
        shopPhotoList: [],
    shopDesc: "",
    bornDate: "",
    connectPerson: "",
    telephone: "",
    address: "",
        loadingHide: true,
        loadingText: "网络操作中。。",
      })
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
          loadingHide: false
        });
        utils.sendUploadImage(config.basePath + "upload/image", tempFilePaths[0], function (res) {
          wx.stopPullDownRefresh()
          setTimeout(function () {
            self.setData({
              shopPhoto: res.data,
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

