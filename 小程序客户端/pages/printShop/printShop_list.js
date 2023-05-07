var utils = require("../../utils/common.js");
var config = require("../../utils/config.js");

Page({
  /**
   * 页面的初始数据
   */
  data: {
    queryViewHidden: true, //是否隐藏查询条件界面
    shopUserName: "", //餐饮店账号查询关键字
    shopName: "", //餐饮店名称查询关键字
    bornDate: "", //成立日期查询关键字
    connectPerson: "", //联系人查询关键字
    telephone: "", //联系电话查询关键字
    printShops: [], //界面显示的餐饮店列表数据
    page_size: 8, //每页显示几条数据
    page: 1,  //当前要显示第几页
    totalPage: null, //总的页码数
    loading_hide: true, //是否隐藏加载动画
    nodata_hide: true, //是否隐藏没有数据记录提示
  },

  // 加载餐饮店列表
  listPrintShop: function () {
    var self = this
    var url = config.basePath + "api/printShop/list"
    //如果要显示的页码超过总页码不操作
    if(self.data.totalPage != null && self.data.page > self.data.totalPage) return
    self.setData({
      loading_hide: false,  //显示加载动画
    })
    //提交查询参数到服务器查询数据列表
    utils.sendRequest(url, {
      "shopUserName": self.data.shopUserName,
      "shopName": self.data.shopName,
      "bornDate": self.data.bornDate,
      "connectPerson": self.data.connectPerson,
      "telephone": self.data.telephone,
      "page": self.data.page,
      "rows": self.data.page_size,
    }, function (res) { 
      wx.stopPullDownRefresh()
      setTimeout(function () {  
        self.setData({
          printShops: self.data.printShops.concat(res.data.list),
          totalPage: res.data.totalPage,
          loading_hide: true
        })
      }, 500)
      //如果当前显示的是最后一页，则显示没数据提示
      if(self.data.page == self.data.totalPage) {
        self.setData({
          nodata_hide: false,
        })
      }
    })
  },

  //显示或隐藏查询视图切换
  toggleQueryViewHide: function () {
    this.setData({
      queryViewHidden: !this.data.queryViewHidden,
    })
  },

  //点击查询按钮的事件
  queryPrintShop: function(e) {
    var self = this
    self.setData({
      page: 1,
      totalPage: null,
      printShops: [],
      loading_hide: true, //隐藏加载动画
      nodata_hide: true, //隐藏没有数据记录提示 
      queryViewHidden: true, //隐藏查询视图
    })
    self.listPrintShop()
  },

  //查询参数成立日期选择事件
  bind_bornDate_change: function (e) {
    this.setData({
      bornDate: e.detail.value
    })
  },
  //清空查询参数成立日期
  clear_bornDate: function (e) {
    this.setData({
      bornDate: "",
    })
  },

  //绑定查询参数输入事件
  searchValueInput: function (e) {
    var id = e.target.dataset.id
    if (id == "shopUserName") {
      this.setData({
        "shopUserName": e.detail.value,
      })
    }

    if (id == "shopName") {
      this.setData({
        "shopName": e.detail.value,
      })
    }

    if (id == "connectPerson") {
      this.setData({
        "connectPerson": e.detail.value,
      })
    }

    if (id == "telephone") {
      this.setData({
        "telephone": e.detail.value,
      })
    }

  },

  init_query_params: function() { 
    var self = this
    var url = null
  },

  //删除餐饮店记录
  removePrintShop: function (e) {
    var self = this
    var shopUserName = e.currentTarget.dataset.shopusername
    wx.showModal({
      title: '提示',
      content: '确定要删除shopUserName=' + shopUserName + '的记录吗？',
      success: function (sm) {
        if (sm.confirm) {
          // 用户点击了确定 可以调用删除方法了
          var url = config.basePath + "api/printShop/delete/" + shopUserName
          utils.sendRequest(url, null, function (res) {
            wx.stopPullDownRefresh();
            wx.showToast({
              title: '删除成功',
              icon: 'success',
              duration: 500
            })
            //删除餐饮店后客户端同步删除数据
            var printShops = self.data.printShops;
            for (var i = 0; i < printShops.length; i++) {
              if (printShops[i].shopUserName == shopUserName) {
                printShops.splice(i, 1)
                break
              }
            }
            self.setData({ printShops: printShops })
          })
        } else if (sm.cancel) {
          console.log('用户点击取消')
        }
      }
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.listPrintShop()
    this.init_query_params()
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
    var self = this
    self.setData({
      page: 1,  //显示最新的第1页结果
      printShops: [], //清空餐饮店数据
      nodata_hide: true, //隐藏没数据提示
    })
    self.listPrintShop()
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
    var self = this
    if (self.data.page < self.data.totalPage) {
      self.setData({
        page: self.data.page + 1, 
      })
      self.listPrintShop()
    }
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }

})

