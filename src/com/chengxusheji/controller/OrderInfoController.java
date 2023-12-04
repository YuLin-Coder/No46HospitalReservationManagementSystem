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
import com.chengxusheji.service.OrderInfoService;
import com.chengxusheji.po.OrderInfo;
import com.chengxusheji.service.DoctorService;
import com.chengxusheji.po.Doctor;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//OrderInfo管理控制层
@Controller
@RequestMapping("/OrderInfo")
public class OrderInfoController extends BaseController {

    /*业务层对象*/
    @Resource OrderInfoService orderInfoService;

    @Resource DoctorService doctorService;
    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("doctorObj")
	public void initBinderdoctorObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("doctorObj.");
	}
	@InitBinder("orderInfo")
	public void initBinderOrderInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("orderInfo.");
	}
	/*跳转到添加OrderInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new OrderInfo());
		/*查询所有的Doctor信息*/
		List<Doctor> doctorList = doctorService.queryAllDoctor();
		request.setAttribute("doctorList", doctorList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "OrderInfo_add";
	}

	/*客户端ajax方式提交添加预约信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated OrderInfo orderInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        orderInfoService.addOrderInfo(orderInfo);
        message = "预约信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询预约信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("userObj") UserInfo userObj,@ModelAttribute("doctorObj") Doctor doctorObj,String orderDate,String timeInterval,String telephone,String checkState,String orderTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (orderDate == null) orderDate = "";
		if (timeInterval == null) timeInterval = "";
		if (telephone == null) telephone = "";
		if (checkState == null) checkState = "";
		if (orderTime == null) orderTime = "";
		if(rows != 0)orderInfoService.setRows(rows);
		List<OrderInfo> orderInfoList = orderInfoService.queryOrderInfo(userObj, doctorObj, orderDate, timeInterval, telephone, checkState, orderTime, page);
	    /*计算总的页数和总的记录数*/
	    orderInfoService.queryTotalPageAndRecordNumber(userObj, doctorObj, orderDate, timeInterval, telephone, checkState, orderTime);
	    /*获取到总的页码数目*/
	    int totalPage = orderInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = orderInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(OrderInfo orderInfo:orderInfoList) {
			JSONObject jsonOrderInfo = orderInfo.getJsonObject();
			jsonArray.put(jsonOrderInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询预约信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<OrderInfo> orderInfoList = orderInfoService.queryAllOrderInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(OrderInfo orderInfo:orderInfoList) {
			JSONObject jsonOrderInfo = new JSONObject();
			jsonOrderInfo.accumulate("orderId", orderInfo.getOrderId());
			jsonArray.put(jsonOrderInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询预约信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("userObj") UserInfo userObj,@ModelAttribute("doctorObj") Doctor doctorObj,String orderDate,String timeInterval,String telephone,String checkState,String orderTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (orderDate == null) orderDate = "";
		if (timeInterval == null) timeInterval = "";
		if (telephone == null) telephone = "";
		if (checkState == null) checkState = "";
		if (orderTime == null) orderTime = "";
		List<OrderInfo> orderInfoList = orderInfoService.queryOrderInfo(userObj, doctorObj, orderDate, timeInterval, telephone, checkState, orderTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    orderInfoService.queryTotalPageAndRecordNumber(userObj, doctorObj, orderDate, timeInterval, telephone, checkState, orderTime);
	    /*获取到总的页码数目*/
	    int totalPage = orderInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = orderInfoService.getRecordNumber();
	    request.setAttribute("orderInfoList",  orderInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("doctorObj", doctorObj);
	    request.setAttribute("orderDate", orderDate);
	    request.setAttribute("timeInterval", timeInterval);
	    request.setAttribute("telephone", telephone);
	    request.setAttribute("checkState", checkState);
	    request.setAttribute("orderTime", orderTime);
	    List<Doctor> doctorList = doctorService.queryAllDoctor();
	    request.setAttribute("doctorList", doctorList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "OrderInfo/orderInfo_frontquery_result"; 
	}

     /*前台查询OrderInfo信息*/
	@RequestMapping(value="/{orderId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer orderId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键orderId获取OrderInfo对象*/
        OrderInfo orderInfo = orderInfoService.getOrderInfo(orderId);

        List<Doctor> doctorList = doctorService.queryAllDoctor();
        request.setAttribute("doctorList", doctorList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("orderInfo",  orderInfo);
        return "OrderInfo/orderInfo_frontshow";
	}

	/*ajax方式显示预约信息修改jsp视图页*/
	@RequestMapping(value="/{orderId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer orderId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键orderId获取OrderInfo对象*/
        OrderInfo orderInfo = orderInfoService.getOrderInfo(orderId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonOrderInfo = orderInfo.getJsonObject();
		out.println(jsonOrderInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新预约信息信息*/
	@RequestMapping(value = "/{orderId}/update", method = RequestMethod.POST)
	public void update(@Validated OrderInfo orderInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			orderInfoService.updateOrderInfo(orderInfo);
			message = "预约信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "预约信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除预约信息信息*/
	@RequestMapping(value="/{orderId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer orderId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  orderInfoService.deleteOrderInfo(orderId);
	            request.setAttribute("message", "预约信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "预约信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条预约信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String orderIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = orderInfoService.deleteOrderInfos(orderIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出预约信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("userObj") UserInfo userObj,@ModelAttribute("doctorObj") Doctor doctorObj,String orderDate,String timeInterval,String telephone,String checkState,String orderTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(orderDate == null) orderDate = "";
        if(timeInterval == null) timeInterval = "";
        if(telephone == null) telephone = "";
        if(checkState == null) checkState = "";
        if(orderTime == null) orderTime = "";
        List<OrderInfo> orderInfoList = orderInfoService.queryOrderInfo(userObj,doctorObj,orderDate,timeInterval,telephone,checkState,orderTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "OrderInfo信息记录"; 
        String[] headers = { "预约id","预约用户","预约医生","预约日期","时段","联系电话","下单时间","处理状态","医生回复"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<orderInfoList.size();i++) {
        	OrderInfo orderInfo = orderInfoList.get(i); 
        	dataset.add(new String[]{orderInfo.getOrderId() + "",orderInfo.getUserObj().getName(),orderInfo.getDoctorObj().getDoctorName(),orderInfo.getOrderDate(),orderInfo.getTimeInterval(),orderInfo.getTelephone(),orderInfo.getOrderTime(),orderInfo.getCheckState(),orderInfo.getReplyContent()});
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
			response.setHeader("Content-disposition","attachment; filename="+"OrderInfo.xls");//filename是下载的xls的名，建议最好用英文 
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
