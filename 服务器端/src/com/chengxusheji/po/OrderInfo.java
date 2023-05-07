package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;
import com.client.utils.JsonUtils;
import com.client.utils.SessionConsts;
import com.fasterxml.jackson.annotation.JsonIgnore;

public class OrderInfo {
    /*订单编号*/
    private Integer orderId;
    public Integer getOrderId(){
        return orderId;
    }
    public void setOrderId(Integer orderId){
        this.orderId = orderId;
    }

    /*菜谱名称*/
    private Product productObj;
    public Product getProductObj() {
        return productObj;
    }
    public void setProductObj(Product productObj) {
        this.productObj = productObj;
    }

    /*订单数量*/
    @NotNull(message="必须输入订单数量")
    private Integer orderNum;
    public Integer getOrderNum() {
        return orderNum;
    }
    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    /*订单总金额*/
    @NotNull(message="必须输入订单总金额")
    private Float totalMoney;
    public Float getTotalMoney() {
        return totalMoney;
    }
    public void setTotalMoney(Float totalMoney) {
        this.totalMoney = totalMoney;
    }

    /*支付方式*/
    @NotEmpty(message="支付方式不能为空")
    private String payWay;
    public String getPayWay() {
        return payWay;
    }
    public void setPayWay(String payWay) {
        this.payWay = payWay;
    }

    /*订单状态*/
    @NotEmpty(message="订单状态不能为空")
    private String orderStateObj;
    public String getOrderStateObj() {
        return orderStateObj;
    }
    public void setOrderStateObj(String orderStateObj) {
        this.orderStateObj = orderStateObj;
    }

    /*收货人*/
    @NotEmpty(message="收货人不能为空")
    private String receiveName;
    public String getReceiveName() {
        return receiveName;
    }
    public void setReceiveName(String receiveName) {
        this.receiveName = receiveName;
    }

    /*收货人电话*/
    @NotEmpty(message="收货人电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*收货人地址*/
    @NotEmpty(message="收货人地址不能为空")
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    /*订单备注*/
    private String orderMemo;
    public String getOrderMemo() {
        return orderMemo;
    }
    public void setOrderMemo(String orderMemo) {
        this.orderMemo = orderMemo;
    }

    /*下单用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*下单时间*/
    private String orderTime;
    public String getOrderTime() {
        return orderTime;
    }
    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    @JsonIgnore
    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonOrderInfo=new JSONObject(); 
		jsonOrderInfo.accumulate("orderId", this.getOrderId());
		jsonOrderInfo.accumulate("productObj", this.getProductObj().getProductName());
		jsonOrderInfo.accumulate("productObjPri", this.getProductObj().getProductId());
		jsonOrderInfo.accumulate("orderNum", this.getOrderNum());
		jsonOrderInfo.accumulate("totalMoney", this.getTotalMoney());
		jsonOrderInfo.accumulate("payWay", this.getPayWay());
		jsonOrderInfo.accumulate("orderStateObj", this.getOrderStateObj());
		jsonOrderInfo.accumulate("receiveName", this.getReceiveName());
		jsonOrderInfo.accumulate("telephone", this.getTelephone());
		jsonOrderInfo.accumulate("address", this.getAddress());
		jsonOrderInfo.accumulate("orderMemo", this.getOrderMemo());
		jsonOrderInfo.accumulate("userObj", this.getUserObj().getName());
		jsonOrderInfo.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonOrderInfo.accumulate("orderTime", this.getOrderTime());
		return jsonOrderInfo;
    }

    @Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}