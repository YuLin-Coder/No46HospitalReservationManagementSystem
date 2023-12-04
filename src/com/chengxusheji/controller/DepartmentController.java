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
import com.chengxusheji.service.DepartmentService;
import com.chengxusheji.po.Department;

//Department管理控制层
@Controller
@RequestMapping("/Department")
public class DepartmentController extends BaseController {

    /*业务层对象*/
    @Resource DepartmentService departmentService;

	@InitBinder("department")
	public void initBinderDepartment(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("department.");
	}
	/*跳转到添加Department视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Department());
		return "Department_add";
	}

	/*客户端ajax方式提交添加科室信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Department department, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        departmentService.addDepartment(department);
        message = "科室信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询科室信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String departmentName,String birthDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (departmentName == null) departmentName = "";
		if (birthDate == null) birthDate = "";
		if(rows != 0)departmentService.setRows(rows);
		List<Department> departmentList = departmentService.queryDepartment(departmentName, birthDate, page);
	    /*计算总的页数和总的记录数*/
	    departmentService.queryTotalPageAndRecordNumber(departmentName, birthDate);
	    /*获取到总的页码数目*/
	    int totalPage = departmentService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = departmentService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Department department:departmentList) {
			JSONObject jsonDepartment = department.getJsonObject();
			jsonArray.put(jsonDepartment);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询科室信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Department> departmentList = departmentService.queryAllDepartment();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Department department:departmentList) {
			JSONObject jsonDepartment = new JSONObject();
			jsonDepartment.accumulate("departmentId", department.getDepartmentId());
			jsonDepartment.accumulate("departmentName", department.getDepartmentName());
			jsonArray.put(jsonDepartment);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询科室信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String departmentName,String birthDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (departmentName == null) departmentName = "";
		if (birthDate == null) birthDate = "";
		List<Department> departmentList = departmentService.queryDepartment(departmentName, birthDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    departmentService.queryTotalPageAndRecordNumber(departmentName, birthDate);
	    /*获取到总的页码数目*/
	    int totalPage = departmentService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = departmentService.getRecordNumber();
	    request.setAttribute("departmentList",  departmentList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("departmentName", departmentName);
	    request.setAttribute("birthDate", birthDate);
		return "Department/department_frontquery_result"; 
	}

     /*前台查询Department信息*/
	@RequestMapping(value="/{departmentId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer departmentId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键departmentId获取Department对象*/
        Department department = departmentService.getDepartment(departmentId);

        request.setAttribute("department",  department);
        return "Department/department_frontshow";
	}

	/*ajax方式显示科室信息修改jsp视图页*/
	@RequestMapping(value="/{departmentId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer departmentId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键departmentId获取Department对象*/
        Department department = departmentService.getDepartment(departmentId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonDepartment = department.getJsonObject();
		out.println(jsonDepartment.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新科室信息信息*/
	@RequestMapping(value = "/{departmentId}/update", method = RequestMethod.POST)
	public void update(@Validated Department department, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			departmentService.updateDepartment(department);
			message = "科室信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "科室信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除科室信息信息*/
	@RequestMapping(value="/{departmentId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer departmentId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  departmentService.deleteDepartment(departmentId);
	            request.setAttribute("message", "科室信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "科室信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条科室信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String departmentIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = departmentService.deleteDepartments(departmentIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出科室信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String departmentName,String birthDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(departmentName == null) departmentName = "";
        if(birthDate == null) birthDate = "";
        List<Department> departmentList = departmentService.queryDepartment(departmentName,birthDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Department信息记录"; 
        String[] headers = { "科室id","科室名称","成立日期","负责人"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<departmentList.size();i++) {
        	Department department = departmentList.get(i); 
        	dataset.add(new String[]{department.getDepartmentId() + "",department.getDepartmentName(),department.getBirthDate(),department.getChargeMan()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Department.xls");//filename是下载的xls的名，建议最好用英文 
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
