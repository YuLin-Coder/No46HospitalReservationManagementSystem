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
import com.chengxusheji.service.DoctorService;
import com.chengxusheji.po.Doctor;
import com.chengxusheji.service.DepartmentService;
import com.chengxusheji.po.Department;

//Doctor管理控制层
@Controller
@RequestMapping("/Doctor")
public class DoctorController extends BaseController {

    /*业务层对象*/
    @Resource DoctorService doctorService;

    @Resource DepartmentService departmentService;
	@InitBinder("departmentObj")
	public void initBinderdepartmentObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("departmentObj.");
	}
	@InitBinder("doctor")
	public void initBinderDoctor(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("doctor.");
	}
	/*跳转到添加Doctor视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Doctor());
		/*查询所有的Department信息*/
		List<Department> departmentList = departmentService.queryAllDepartment();
		request.setAttribute("departmentList", departmentList);
		return "Doctor_add";
	}

	/*客户端ajax方式提交添加医生信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Doctor doctor, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(doctorService.getDoctor(doctor.getDoctorNumber()) != null) {
			message = "医生工号已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			doctor.setDoctorPhoto(this.handlePhotoUpload(request, "doctorPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        doctorService.addDoctor(doctor);
        message = "医生信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询医生信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String doctorNumber,@ModelAttribute("departmentObj") Department departmentObj,String doctorName,String birthDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (doctorNumber == null) doctorNumber = "";
		if (doctorName == null) doctorName = "";
		if (birthDate == null) birthDate = "";
		if(rows != 0)doctorService.setRows(rows);
		List<Doctor> doctorList = doctorService.queryDoctor(doctorNumber, departmentObj, doctorName, birthDate, page);
	    /*计算总的页数和总的记录数*/
	    doctorService.queryTotalPageAndRecordNumber(doctorNumber, departmentObj, doctorName, birthDate);
	    /*获取到总的页码数目*/
	    int totalPage = doctorService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = doctorService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Doctor doctor:doctorList) {
			JSONObject jsonDoctor = doctor.getJsonObject();
			jsonArray.put(jsonDoctor);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询医生信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Doctor> doctorList = doctorService.queryAllDoctor();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Doctor doctor:doctorList) {
			JSONObject jsonDoctor = new JSONObject();
			jsonDoctor.accumulate("doctorNumber", doctor.getDoctorNumber());
			jsonDoctor.accumulate("doctorName", doctor.getDoctorName());
			jsonArray.put(jsonDoctor);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询医生信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String doctorNumber,@ModelAttribute("departmentObj") Department departmentObj,String doctorName,String birthDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (doctorNumber == null) doctorNumber = "";
		if (doctorName == null) doctorName = "";
		if (birthDate == null) birthDate = "";
		List<Doctor> doctorList = doctorService.queryDoctor(doctorNumber, departmentObj, doctorName, birthDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    doctorService.queryTotalPageAndRecordNumber(doctorNumber, departmentObj, doctorName, birthDate);
	    /*获取到总的页码数目*/
	    int totalPage = doctorService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = doctorService.getRecordNumber();
	    request.setAttribute("doctorList",  doctorList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("doctorNumber", doctorNumber);
	    request.setAttribute("departmentObj", departmentObj);
	    request.setAttribute("doctorName", doctorName);
	    request.setAttribute("birthDate", birthDate);
	    List<Department> departmentList = departmentService.queryAllDepartment();
	    request.setAttribute("departmentList", departmentList);
		return "Doctor/doctor_frontquery_result"; 
	}

     /*前台查询Doctor信息*/
	@RequestMapping(value="/{doctorNumber}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String doctorNumber,Model model,HttpServletRequest request) throws Exception {
		/*根据主键doctorNumber获取Doctor对象*/
        Doctor doctor = doctorService.getDoctor(doctorNumber);

        List<Department> departmentList = departmentService.queryAllDepartment();
        request.setAttribute("departmentList", departmentList);
        request.setAttribute("doctor",  doctor);
        return "Doctor/doctor_frontshow";
	}

	/*ajax方式显示医生信息修改jsp视图页*/
	@RequestMapping(value="/{doctorNumber}/update",method=RequestMethod.GET)
	public void update(@PathVariable String doctorNumber,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键doctorNumber获取Doctor对象*/
        Doctor doctor = doctorService.getDoctor(doctorNumber);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonDoctor = doctor.getJsonObject();
		out.println(jsonDoctor.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新医生信息信息*/
	@RequestMapping(value = "/{doctorNumber}/update", method = RequestMethod.POST)
	public void update(@Validated Doctor doctor, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String doctorPhotoFileName = this.handlePhotoUpload(request, "doctorPhotoFile");
		if(!doctorPhotoFileName.equals("upload/NoImage.jpg"))doctor.setDoctorPhoto(doctorPhotoFileName); 


		try {
			doctorService.updateDoctor(doctor);
			message = "医生信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "医生信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除医生信息信息*/
	@RequestMapping(value="/{doctorNumber}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String doctorNumber,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  doctorService.deleteDoctor(doctorNumber);
	            request.setAttribute("message", "医生信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "医生信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条医生信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String doctorNumbers,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = doctorService.deleteDoctors(doctorNumbers);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出医生信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String doctorNumber,@ModelAttribute("departmentObj") Department departmentObj,String doctorName,String birthDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(doctorNumber == null) doctorNumber = "";
        if(doctorName == null) doctorName = "";
        if(birthDate == null) birthDate = "";
        List<Doctor> doctorList = doctorService.queryDoctor(doctorNumber,departmentObj,doctorName,birthDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Doctor信息记录"; 
        String[] headers = { "医生工号","所在科室","医生姓名","性别","医生照片","出生日期","医生职位","工作经验","联系方式"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<doctorList.size();i++) {
        	Doctor doctor = doctorList.get(i); 
        	dataset.add(new String[]{doctor.getDoctorNumber(),doctor.getDepartmentObj().getDepartmentName(),doctor.getDoctorName(),doctor.getSex(),doctor.getDoctorPhoto(),doctor.getBirthDate(),doctor.getPosition(),doctor.getExperience(),doctor.getContactWay()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Doctor.xls");//filename是下载的xls的名，建议最好用英文 
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
