package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;

import com.chengxusheji.po.Admin;
import com.chengxusheji.po.PrintShop;

import com.chengxusheji.mapper.PrintShopMapper;
@Service
public class PrintShopService {

	@Resource PrintShopMapper printShopMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加餐饮店记录*/
    public void addPrintShop(PrintShop printShop) throws Exception {
    	printShopMapper.addPrintShop(printShop);
    }

    /*按照查询条件分页查询餐饮店记录*/
    public ArrayList<PrintShop> queryPrintShop(String shopUserName,String shopName,String bornDate,String connectPerson,String telephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!shopUserName.equals("")) where = where + " and t_printShop.shopUserName like '%" + shopUserName + "%'";
    	if(!shopName.equals("")) where = where + " and t_printShop.shopName like '%" + shopName + "%'";
    	if(!bornDate.equals("")) where = where + " and t_printShop.bornDate like '%" + bornDate + "%'";
    	if(!connectPerson.equals("")) where = where + " and t_printShop.connectPerson like '%" + connectPerson + "%'";
    	if(!telephone.equals("")) where = where + " and t_printShop.telephone like '%" + telephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return printShopMapper.queryPrintShop(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<PrintShop> queryPrintShop(String shopUserName,String shopName,String bornDate,String connectPerson,String telephone) throws Exception  { 
     	String where = "where 1=1";
    	if(!shopUserName.equals("")) where = where + " and t_printShop.shopUserName like '%" + shopUserName + "%'";
    	if(!shopName.equals("")) where = where + " and t_printShop.shopName like '%" + shopName + "%'";
    	if(!bornDate.equals("")) where = where + " and t_printShop.bornDate like '%" + bornDate + "%'";
    	if(!connectPerson.equals("")) where = where + " and t_printShop.connectPerson like '%" + connectPerson + "%'";
    	if(!telephone.equals("")) where = where + " and t_printShop.telephone like '%" + telephone + "%'";
    	return printShopMapper.queryPrintShopList(where);
    }

    /*查询所有餐饮店记录*/
    public ArrayList<PrintShop> queryAllPrintShop()  throws Exception {
        return printShopMapper.queryPrintShopList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String shopUserName,String shopName,String bornDate,String connectPerson,String telephone) throws Exception {
     	String where = "where 1=1";
    	if(!shopUserName.equals("")) where = where + " and t_printShop.shopUserName like '%" + shopUserName + "%'";
    	if(!shopName.equals("")) where = where + " and t_printShop.shopName like '%" + shopName + "%'";
    	if(!bornDate.equals("")) where = where + " and t_printShop.bornDate like '%" + bornDate + "%'";
    	if(!connectPerson.equals("")) where = where + " and t_printShop.connectPerson like '%" + connectPerson + "%'";
    	if(!telephone.equals("")) where = where + " and t_printShop.telephone like '%" + telephone + "%'";
        recordNumber = printShopMapper.queryPrintShopCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取餐饮店记录*/
    public PrintShop getPrintShop(String shopUserName) throws Exception  {
        PrintShop printShop = printShopMapper.getPrintShop(shopUserName);
        return printShop;
    }

    /*更新餐饮店记录*/
    public void updatePrintShop(PrintShop printShop) throws Exception {
        printShopMapper.updatePrintShop(printShop);
    }

    /*删除一条餐饮店记录*/
    public void deletePrintShop (String shopUserName) throws Exception {
        printShopMapper.deletePrintShop(shopUserName);
    }

    /*删除多条餐饮店信息*/
    public int deletePrintShops (String shopUserNames) throws Exception {
    	String _shopUserNames[] = shopUserNames.split(",");
    	for(String _shopUserName: _shopUserNames) {
    		printShopMapper.deletePrintShop(_shopUserName);
    	}
    	return _shopUserNames.length;
    }
 
	
	/*保存业务逻辑错误信息字段*/
	private String errMessage;
	public String getErrMessage() { return this.errMessage; }
	
	/*验证用户登录*/
	public boolean checkLogin(String userName, String password) throws Exception { 
		PrintShop db_printshop = (PrintShop) printShopMapper.getPrintShop(userName);
		if(db_printshop == null) { 
			this.errMessage = " 账号不存在 ";
			System.out.print(this.errMessage);
			return false;
		} else if( !db_printshop.getPassword().equals(password)) {
			this.errMessage = " 密码不正确! ";
			System.out.print(this.errMessage);
			return false;
		}
		
		return true;
	}
	
	
}
