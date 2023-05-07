package com.chengxusheji.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Product;

public interface ProductMapper {
	/*添加菜品信息信息*/
	public void addProduct(Product product) throws Exception;

	/*按照查询条件分页查询菜品信息记录*/
	public ArrayList<Product> queryProduct(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有菜品信息记录*/
	public ArrayList<Product> queryProductList(@Param("where") String where) throws Exception;

	/* 查询最新菜品信息记录 */
	public List<Product> queryLatestProductList();
	
	/*按照查询条件的菜品信息记录数*/
	public int queryProductCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条菜品信息记录*/
	public Product getProduct(int productId) throws Exception;

	/*更新菜品信息记录*/
	public void updateProduct(Product product) throws Exception;

	/*删除菜品信息记录*/
	public void deleteProduct(int productId) throws Exception;

	

}
