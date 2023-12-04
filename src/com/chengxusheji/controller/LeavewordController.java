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
import com.chengxusheji.service.LeavewordService;
import com.chengxusheji.po.Leaveword;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Leaveword管理控制层
@Controller
@RequestMapping("/Leaveword")
public class LeavewordController extends BaseController {

    /*业务层对象*/
    @Resource LeavewordService leavewordService;

    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("leaveword")
	public void initBinderLeaveword(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("leaveword.");
	}
	/*跳转到添加Leaveword视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Leaveword());
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Leaveword_add";
	}

	/*客户端ajax方式提交添加留言信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Leaveword leaveword, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        leavewordService.addLeaveword(leaveword);
        message = "留言添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询留言信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String leaveTitle,@ModelAttribute("userObj") UserInfo userObj,String leaveTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (leaveTitle == null) leaveTitle = "";
		if (leaveTime == null) leaveTime = "";
		if(rows != 0)leavewordService.setRows(rows);
		List<Leaveword> leavewordList = leavewordService.queryLeaveword(leaveTitle, userObj, leaveTime, page);
	    /*计算总的页数和总的记录数*/
	    leavewordService.queryTotalPageAndRecordNumber(leaveTitle, userObj, leaveTime);
	    /*获取到总的页码数目*/
	    int totalPage = leavewordService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = leavewordService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Leaveword leaveword:leavewordList) {
			JSONObject jsonLeaveword = leaveword.getJsonObject();
			jsonArray.put(jsonLeaveword);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询留言信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Leaveword> leavewordList = leavewordService.queryAllLeaveword();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Leaveword leaveword:leavewordList) {
			JSONObject jsonLeaveword = new JSONObject();
			jsonLeaveword.accumulate("leaveWordId", leaveword.getLeaveWordId());
			jsonLeaveword.accumulate("leaveTitle", leaveword.getLeaveTitle());
			jsonArray.put(jsonLeaveword);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询留言信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String leaveTitle,@ModelAttribute("userObj") UserInfo userObj,String leaveTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (leaveTitle == null) leaveTitle = "";
		if (leaveTime == null) leaveTime = "";
		List<Leaveword> leavewordList = leavewordService.queryLeaveword(leaveTitle, userObj, leaveTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    leavewordService.queryTotalPageAndRecordNumber(leaveTitle, userObj, leaveTime);
	    /*获取到总的页码数目*/
	    int totalPage = leavewordService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = leavewordService.getRecordNumber();
	    request.setAttribute("leavewordList",  leavewordList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("leaveTitle", leaveTitle);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("leaveTime", leaveTime);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Leaveword/leaveword_frontquery_result"; 
	}

     /*前台查询Leaveword信息*/
	@RequestMapping(value="/{leaveWordId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer leaveWordId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键leaveWordId获取Leaveword对象*/
        Leaveword leaveword = leavewordService.getLeaveword(leaveWordId);

        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("leaveword",  leaveword);
        return "Leaveword/leaveword_frontshow";
	}

	/*ajax方式显示留言修改jsp视图页*/
	@RequestMapping(value="/{leaveWordId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer leaveWordId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键leaveWordId获取Leaveword对象*/
        Leaveword leaveword = leavewordService.getLeaveword(leaveWordId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonLeaveword = leaveword.getJsonObject();
		out.println(jsonLeaveword.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新留言信息*/
	@RequestMapping(value = "/{leaveWordId}/update", method = RequestMethod.POST)
	public void update(@Validated Leaveword leaveword, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			leavewordService.updateLeaveword(leaveword);
			message = "留言更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "留言更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除留言信息*/
	@RequestMapping(value="/{leaveWordId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer leaveWordId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  leavewordService.deleteLeaveword(leaveWordId);
	            request.setAttribute("message", "留言删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "留言删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条留言记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String leaveWordIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = leavewordService.deleteLeavewords(leaveWordIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出留言信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String leaveTitle,@ModelAttribute("userObj") UserInfo userObj,String leaveTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(leaveTitle == null) leaveTitle = "";
        if(leaveTime == null) leaveTime = "";
        List<Leaveword> leavewordList = leavewordService.queryLeaveword(leaveTitle,userObj,leaveTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Leaveword信息记录"; 
        String[] headers = { "留言id","留言标题","留言人","留言时间","管理回复","回复时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<leavewordList.size();i++) {
        	Leaveword leaveword = leavewordList.get(i); 
        	dataset.add(new String[]{leaveword.getLeaveWordId() + "",leaveword.getLeaveTitle(),leaveword.getUserObj().getName(),leaveword.getLeaveTime(),leaveword.getReplyContent(),leaveword.getReplyTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Leaveword.xls");//filename是下载的xls的名，建议最好用英文 
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
