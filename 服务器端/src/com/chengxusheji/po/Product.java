package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;
import com.client.utils.JsonUtils;
import com.client.utils.SessionConsts;
import com.fasterxml.jackson.annotation.JsonIgnore;

public class Product {
    /*商品id*/
    private Integer productId;
    public Integer getProductId(){
        return productId;
    }
    public void setProductId(Integer productId){
        this.productId = productId;
    }

    /*菜品类别*/
    private ProductClass productClassObj;
    public ProductClass getProductClassObj() {
        return productClassObj;
    }
    public void setProductClassObj(ProductClass productClassObj) {
        this.productClassObj = productClassObj;
    }

    /*菜品名称*/
    @NotEmpty(message="菜品名称不能为空")
    private String productName;
    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    /*菜品图片*/
    private String mainPhoto;
    public String getMainPhoto() {
        return mainPhoto;
    }
    public void setMainPhoto(String mainPhoto) {
        this.mainPhoto = mainPhoto;
    }

    private String mainPhotoUrl;
    public void setMainPhotoUrl(String mainPhotoUrl) {
		this.mainPhotoUrl = mainPhotoUrl;
	}
	public String getMainPhotoUrl() {
		return  SessionConsts.BASE_URL + mainPhoto;
	}
    /*套餐价格*/
    @NotNull(message="必须输入套餐价格")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*菜品描述*/
    @NotEmpty(message="菜品描述不能为空")
    private String productDesc;
    public String getProductDesc() {
        return productDesc;
    }
    public void setProductDesc(String productDesc) {
        this.productDesc = productDesc;
    }

    /*餐饮店*/
    private PrintShop printShopObj;
    public PrintShop getPrintShopObj() {
        return printShopObj;
    }
    public void setPrintShopObj(PrintShop printShopObj) {
        this.printShopObj = printShopObj;
    }

    /*发布时间*/
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    @JsonIgnore
    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonProduct=new JSONObject(); 
		jsonProduct.accumulate("productId", this.getProductId());
		jsonProduct.accumulate("productClassObj", this.getProductClassObj().getClassName());
		jsonProduct.accumulate("productClassObjPri", this.getProductClassObj().getClassId());
		jsonProduct.accumulate("productName", this.getProductName());
		jsonProduct.accumulate("mainPhoto", this.getMainPhoto());
		jsonProduct.accumulate("price", this.getPrice());
		jsonProduct.accumulate("productDesc", this.getProductDesc());
		jsonProduct.accumulate("printShopObj", this.getPrintShopObj().getShopName());
		jsonProduct.accumulate("printShopObjPri", this.getPrintShopObj().getShopUserName());
		jsonProduct.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonProduct;
    }

    @Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}