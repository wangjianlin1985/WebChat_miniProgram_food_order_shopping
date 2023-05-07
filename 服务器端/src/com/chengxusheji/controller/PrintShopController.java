package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.PrintShopService;
import com.chengxusheji.po.PrintShop;

//PrintShop管理控制层
@Controller
@RequestMapping("/PrintShop")
public class PrintShopController extends BaseController {

    /*业务层对象*/
    @Resource PrintShopService printShopService;

	@InitBinder("printShop")
	public void initBinderPrintShop(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("printShop.");
	}
	/*跳转到添加PrintShop视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new PrintShop());
		return "PrintShop_add";
	}

	/*客户端ajax方式提交添加餐饮店信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated PrintShop printShop, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(printShopService.getPrintShop(printShop.getShopUserName()) != null) {
			message = "餐饮店账号已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			printShop.setShopPhoto(this.handlePhotoUpload(request, "shopPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        printShopService.addPrintShop(printShop);
        message = "餐饮店添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询餐饮店信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String shopUserName,String shopName,String bornDate,String connectPerson,String telephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
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
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(PrintShop printShop:printShopList) {
			JSONObject jsonPrintShop = printShop.getJsonObject();
			jsonArray.put(jsonPrintShop);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询餐饮店信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<PrintShop> printShopList = printShopService.queryAllPrintShop();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(PrintShop printShop:printShopList) {
			JSONObject jsonPrintShop = new JSONObject();
			jsonPrintShop.accumulate("shopUserName", printShop.getShopUserName());
			jsonPrintShop.accumulate("shopName", printShop.getShopName());
			jsonArray.put(jsonPrintShop);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询餐饮店信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String shopUserName,String shopName,String bornDate,String connectPerson,String telephone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (shopUserName == null) shopUserName = "";
		if (shopName == null) shopName = "";
		if (bornDate == null) bornDate = "";
		if (connectPerson == null) connectPerson = "";
		if (telephone == null) telephone = "";
		List<PrintShop> printShopList = printShopService.queryPrintShop(shopUserName, shopName, bornDate, connectPerson, telephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    printShopService.queryTotalPageAndRecordNumber(shopUserName, shopName, bornDate, connectPerson, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = printShopService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = printShopService.getRecordNumber();
	    request.setAttribute("printShopList",  printShopList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("shopUserName", shopUserName);
	    request.setAttribute("shopName", shopName);
	    request.setAttribute("bornDate", bornDate);
	    request.setAttribute("connectPerson", connectPerson);
	    request.setAttribute("telephone", telephone);
		return "PrintShop/printShop_frontquery_result"; 
	}

     /*前台查询PrintShop信息*/
	@RequestMapping(value="/{shopUserName}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String shopUserName,Model model,HttpServletRequest request) throws Exception {
		/*根据主键shopUserName获取PrintShop对象*/
        PrintShop printShop = printShopService.getPrintShop(shopUserName);

        request.setAttribute("printShop",  printShop);
        return "PrintShop/printShop_frontshow";
	}

	/*ajax方式显示餐饮店修改jsp视图页*/
	@RequestMapping(value="/{shopUserName}/update",method=RequestMethod.GET)
	public void update(@PathVariable String shopUserName,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键shopUserName获取PrintShop对象*/
        PrintShop printShop = printShopService.getPrintShop(shopUserName);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonPrintShop = printShop.getJsonObject();
		out.println(jsonPrintShop.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新餐饮店信息*/
	@RequestMapping(value = "/{shopUserName}/update", method = RequestMethod.POST)
	public void update(@Validated PrintShop printShop, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String shopPhotoFileName = this.handlePhotoUpload(request, "shopPhotoFile");
		if(!shopPhotoFileName.equals("upload/NoImage.jpg"))printShop.setShopPhoto(shopPhotoFileName); 


		try {
			printShopService.updatePrintShop(printShop);
			message = "餐饮店更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "餐饮店更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除餐饮店信息*/
	@RequestMapping(value="/{shopUserName}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String shopUserName,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  printShopService.deletePrintShop(shopUserName);
	            request.setAttribute("message", "餐饮店删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "餐饮店删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条餐饮店记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String shopUserNames,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = printShopService.deletePrintShops(shopUserNames);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出餐饮店信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String shopUserName,String shopName,String bornDate,String connectPerson,String telephone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(shopUserName == null) shopUserName = "";
        if(shopName == null) shopName = "";
        if(bornDate == null) bornDate = "";
        if(connectPerson == null) connectPerson = "";
        if(telephone == null) telephone = "";
        List<PrintShop> printShopList = printShopService.queryPrintShop(shopUserName,shopName,bornDate,connectPerson,telephone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "PrintShop信息记录"; 
        String[] headers = { "餐饮店账号","餐饮店名称","餐饮店照片","成立日期","联系人","联系电话"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<printShopList.size();i++) {
        	PrintShop printShop = printShopList.get(i); 
        	dataset.add(new String[]{printShop.getShopUserName(),printShop.getShopName(),printShop.getShopPhoto(),printShop.getBornDate(),printShop.getConnectPerson(),printShop.getTelephone()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"PrintShop.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
