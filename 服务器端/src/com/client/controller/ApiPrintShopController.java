package com.client.controller;

import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.ui.Model;

import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import org.springframework.web.bind.annotation.ModelAttribute;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.chengxusheji.po.PrintShop;
import com.chengxusheji.service.PrintShopService;
import com.client.service.AuthService;
import com.client.utils.JsonResult;
import com.client.utils.JsonResultBuilder;
import com.client.utils.ReturnCode;

@RestController
@RequestMapping("/api/printShop") 
public class ApiPrintShopController {
	@Resource PrintShopService printShopService;
	@Resource AuthService authService;

	@InitBinder("printShop")
	public void initBinderPrintShop(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("printShop.");
	}

	/*客户端ajax方式添加餐饮店信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public JsonResult add(@Validated PrintShop printShop, BindingResult br, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		//通过accessToken获取到用户信息 
		String userName = authService.getUserName(request);
		if(userName == null) return JsonResultBuilder.error(ReturnCode.TOKEN_VALID_ERROR);
		if (br.hasErrors()) //验证输入参数
			return JsonResultBuilder.error(ReturnCode.INPUT_PARAM_ERROR);
		if(printShopService.getPrintShop(printShop.getShopUserName()) != null) //验证主键是否重复
			return JsonResultBuilder.error(ReturnCode.PRIMARY_EXIST_ERROR);
        printShopService.addPrintShop(printShop); //添加到数据库
        return JsonResultBuilder.ok();
	}

	/*客户端ajax更新餐饮店信息*/
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public JsonResult update(@Validated PrintShop printShop, BindingResult br, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		//通过accessToken获取到用户信息 
		String userName = authService.getUserName(request);
		if(userName == null) return JsonResultBuilder.error(ReturnCode.TOKEN_VALID_ERROR);
		if (br.hasErrors())  //验证输入参数
			return JsonResultBuilder.error(ReturnCode.INPUT_PARAM_ERROR); 
        printShopService.updatePrintShop(printShop);  //更新记录到数据库
        return JsonResultBuilder.ok(printShopService.getPrintShop(printShop.getShopUserName()));
	}

	/*ajax方式显示获取餐饮店详细信息*/
	@RequestMapping(value="/get/{shopUserName}",method=RequestMethod.POST)
	public JsonResult getPrintShop(@PathVariable String shopUserName,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键shopUserName获取PrintShop对象*/
        PrintShop printShop = printShopService.getPrintShop(shopUserName); 
        return JsonResultBuilder.ok(printShop);
	}

	/*ajax方式删除餐饮店记录*/
	@RequestMapping(value="/delete/{shopUserName}",method=RequestMethod.POST)
	public JsonResult deletePrintShop(@PathVariable String shopUserName,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		//通过accessToken获取到用户信息 
		String userName = authService.getUserName(request);
		if(userName == null) return JsonResultBuilder.error(ReturnCode.TOKEN_VALID_ERROR);
		try {
			printShopService.deletePrintShop(shopUserName);
			return JsonResultBuilder.ok();
		} catch (Exception ex) {
			return JsonResultBuilder.error(ReturnCode.FOREIGN_KEY_CONSTRAINT_ERROR);
		}
	}

	//客户端查询餐饮店信息
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public JsonResult list(String shopUserName,String shopName,String bornDate,String connectPerson,String telephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (shopUserName == null) shopUserName = "";
		if (shopName == null) shopName = "";
		if (bornDate == null) bornDate = "";
		if (connectPerson == null) connectPerson = "";
		if (telephone == null) telephone = "";
		if(rows != 0)printShopService.setRows(rows);
		List<PrintShop> printShopList = printShopService.queryPrintShop(shopUserName, shopName, bornDate, connectPerson, telephone, page);
	    /*计算总的页数和总的记录数*/
	    printShopService.queryTotalPageAndRecordNumber(shopUserName, shopName, bornDate, connectPerson, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = printShopService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = printShopService.getRecordNumber();
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap.put("totalPage", totalPage);
	    resultMap.put("list", printShopList);
	    return JsonResultBuilder.ok(resultMap);
	}

	//客户端ajax获取所有餐饮店
	@RequestMapping(value="/listAll",method=RequestMethod.POST)
	public JsonResult listAll() throws Exception{
		List<PrintShop> printShopList = printShopService.queryAllPrintShop(); 
		return JsonResultBuilder.ok(printShopList);
	}
}

