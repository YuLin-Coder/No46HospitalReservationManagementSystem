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
import com.chengxusheji.service.PatientService;
import com.chengxusheji.po.Patient;
import com.chengxusheji.service.DoctorService;
import com.chengxusheji.po.Doctor;

//Patient管理控制层
@Controller
@RequestMapping("/Patient")
public class PatientController extends BaseController {

    /*业务层对象*/
    @Resource PatientService patientService;

    @Resource DoctorService doctorService;
	@InitBinder("doctorObj")
	public void initBinderdoctorObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("doctorObj.");
	}
	@InitBinder("patient")
	public void initBinderPatient(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("patient.");
	}
	/*跳转到添加Patient视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Patient());
		/*查询所有的Doctor信息*/
		List<Doctor> doctorList = doctorService.queryAllDoctor();
		request.setAttribute("doctorList", doctorList);
		return "Patient_add";
	}

	/*客户端ajax方式提交添加病人信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Patient patient, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        patientService.addPatient(patient);
        message = "病人信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询病人信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("doctorObj") Doctor doctorObj,String patientName,String cardNumber,String telephone,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (patientName == null) patientName = "";
		if (cardNumber == null) cardNumber = "";
		if (telephone == null) telephone = "";
		if (addTime == null) addTime = "";
		if(rows != 0)patientService.setRows(rows);
		List<Patient> patientList = patientService.queryPatient(doctorObj, patientName, cardNumber, telephone, addTime, page);
	    /*计算总的页数和总的记录数*/
	    patientService.queryTotalPageAndRecordNumber(doctorObj, patientName, cardNumber, telephone, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = patientService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = patientService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Patient patient:patientList) {
			JSONObject jsonPatient = patient.getJsonObject();
			jsonArray.put(jsonPatient);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询病人信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Patient> patientList = patientService.queryAllPatient();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Patient patient:patientList) {
			JSONObject jsonPatient = new JSONObject();
			jsonPatient.accumulate("patientId", patient.getPatientId());
			jsonPatient.accumulate("patientName", patient.getPatientName());
			jsonArray.put(jsonPatient);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询病人信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("doctorObj") Doctor doctorObj,String patientName,String cardNumber,String telephone,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (patientName == null) patientName = "";
		if (cardNumber == null) cardNumber = "";
		if (telephone == null) telephone = "";
		if (addTime == null) addTime = "";
		List<Patient> patientList = patientService.queryPatient(doctorObj, patientName, cardNumber, telephone, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    patientService.queryTotalPageAndRecordNumber(doctorObj, patientName, cardNumber, telephone, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = patientService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = patientService.getRecordNumber();
	    request.setAttribute("patientList",  patientList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("doctorObj", doctorObj);
	    request.setAttribute("patientName", patientName);
	    request.setAttribute("cardNumber", cardNumber);
	    request.setAttribute("telephone", telephone);
	    request.setAttribute("addTime", addTime);
	    List<Doctor> doctorList = doctorService.queryAllDoctor();
	    request.setAttribute("doctorList", doctorList);
		return "Patient/patient_frontquery_result"; 
	}

     /*前台查询Patient信息*/
	@RequestMapping(value="/{patientId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer patientId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键patientId获取Patient对象*/
        Patient patient = patientService.getPatient(patientId);

        List<Doctor> doctorList = doctorService.queryAllDoctor();
        request.setAttribute("doctorList", doctorList);
        request.setAttribute("patient",  patient);
        return "Patient/patient_frontshow";
	}

	/*ajax方式显示病人信息修改jsp视图页*/
	@RequestMapping(value="/{patientId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer patientId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键patientId获取Patient对象*/
        Patient patient = patientService.getPatient(patientId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonPatient = patient.getJsonObject();
		out.println(jsonPatient.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新病人信息信息*/
	@RequestMapping(value = "/{patientId}/update", method = RequestMethod.POST)
	public void update(@Validated Patient patient, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			patientService.updatePatient(patient);
			message = "病人信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "病人信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除病人信息信息*/
	@RequestMapping(value="/{patientId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer patientId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  patientService.deletePatient(patientId);
	            request.setAttribute("message", "病人信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "病人信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条病人信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String patientIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = patientService.deletePatients(patientIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出病人信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("doctorObj") Doctor doctorObj,String patientName,String cardNumber,String telephone,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(patientName == null) patientName = "";
        if(cardNumber == null) cardNumber = "";
        if(telephone == null) telephone = "";
        if(addTime == null) addTime = "";
        List<Patient> patientList = patientService.queryPatient(doctorObj,patientName,cardNumber,telephone,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Patient信息记录"; 
        String[] headers = { "病人id","医生","病人姓名","性别","身份证号","联系电话","登记时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<patientList.size();i++) {
        	Patient patient = patientList.get(i); 
        	dataset.add(new String[]{patient.getPatientId() + "",patient.getDoctorObj().getDoctorName(),patient.getPatientName(),patient.getSex(),patient.getCardNumber(),patient.getTelephone(),patient.getAddTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Patient.xls");//filename是下载的xls的名，建议最好用英文 
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
