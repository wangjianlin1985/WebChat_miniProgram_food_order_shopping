package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;
import com.client.utils.JsonUtils;
import com.client.utils.SessionConsts;
import com.fasterxml.jackson.annotation.JsonIgnore;

public class PrintShop {
    /*餐饮店账号*/
    @NotEmpty(message="餐饮店账号不能为空")
    private String shopUserName;
    public String getShopUserName(){
        return shopUserName;
    }
    public void setShopUserName(String shopUserName){
        this.shopUserName = shopUserName;
    }

    /*登录密码*/
    @NotEmpty(message="登录密码不能为空")
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*餐饮店名称*/
    @NotEmpty(message="餐饮店名称不能为空")
    private String shopName;
    public String getShopName() {
        return shopName;
    }
    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    /*餐饮店照片*/
    private String shopPhoto;
    public String getShopPhoto() {
        return shopPhoto;
    }
    public void setShopPhoto(String shopPhoto) {
        this.shopPhoto = shopPhoto;
    }

    private String shopPhotoUrl;
    public void setShopPhotoUrl(String shopPhotoUrl) {
		this.shopPhotoUrl = shopPhotoUrl;
	}
	public String getShopPhotoUrl() {
		return  SessionConsts.BASE_URL + shopPhoto;
	}
    /*餐饮店介绍*/
    @NotEmpty(message="餐饮店介绍不能为空")
    private String shopDesc;
    public String getShopDesc() {
        return shopDesc;
    }
    public void setShopDesc(String shopDesc) {
        this.shopDesc = shopDesc;
    }

    /*成立日期*/
    @NotEmpty(message="成立日期不能为空")
    private String bornDate;
    public String getBornDate() {
        return bornDate;
    }
    public void setBornDate(String bornDate) {
        this.bornDate = bornDate;
    }

    /*联系人*/
    @NotEmpty(message="联系人不能为空")
    private String connectPerson;
    public String getConnectPerson() {
        return connectPerson;
    }
    public void setConnectPerson(String connectPerson) {
        this.connectPerson = connectPerson;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*餐饮店地址*/
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    @JsonIgnore
    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonPrintShop=new JSONObject(); 
		jsonPrintShop.accumulate("shopUserName", this.getShopUserName());
		jsonPrintShop.accumulate("password", this.getPassword());
		jsonPrintShop.accumulate("shopName", this.getShopName());
		jsonPrintShop.accumulate("shopPhoto", this.getShopPhoto());
		jsonPrintShop.accumulate("shopDesc", this.getShopDesc());
		jsonPrintShop.accumulate("bornDate", this.getBornDate().length()>19?this.getBornDate().substring(0,19):this.getBornDate());
		jsonPrintShop.accumulate("connectPerson", this.getConnectPerson());
		jsonPrintShop.accumulate("telephone", this.getTelephone());
		jsonPrintShop.accumulate("address", this.getAddress());
		return jsonPrintShop;
    }

    @Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}