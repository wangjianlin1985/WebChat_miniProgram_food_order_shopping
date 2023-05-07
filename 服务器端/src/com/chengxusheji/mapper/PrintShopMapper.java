package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.PrintShop;

public interface PrintShopMapper {
	/*添加餐饮店信息*/
	public void addPrintShop(PrintShop printShop) throws Exception;

	/*按照查询条件分页查询餐饮店记录*/
	public ArrayList<PrintShop> queryPrintShop(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有餐饮店记录*/
	public ArrayList<PrintShop> queryPrintShopList(@Param("where") String where) throws Exception;

	/*按照查询条件的餐饮店记录数*/
	public int queryPrintShopCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条餐饮店记录*/
	public PrintShop getPrintShop(String shopUserName) throws Exception;

	/*更新餐饮店记录*/
	public void updatePrintShop(PrintShop printShop) throws Exception;

	/*删除餐饮店记录*/
	public void deletePrintShop(String shopUserName) throws Exception;

}
