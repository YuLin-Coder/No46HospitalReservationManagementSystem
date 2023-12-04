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
import com.chengxusheji.service.NewsService;
import com.chengxusheji.po.News;

//News管理控制层
@Controller
@RequestMapping("/News")
public class NewsController extends BaseController {

    /*业务层对象*/
    @Resource NewsService newsService;

	@InitBinder("news")
	public void initBinderNews(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("news.");
	}
	/*跳转到添加News视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new News());
		return "News_add";
	}

	/*客户端ajax方式提交添加新闻信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated News news, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			news.setNewsPhoto(this.handlePhotoUpload(request, "newsPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        newsService.addNews(news);
        message = "新闻信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询新闻信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String newsTitle,String newsDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (newsTitle == null) newsTitle = "";
		if (newsDate == null) newsDate = "";
		if(rows != 0)newsService.setRows(rows);
		List<News> newsList = newsService.queryNews(newsTitle, newsDate, page);
	    /*计算总的页数和总的记录数*/
	    newsService.queryTotalPageAndRecordNumber(newsTitle, newsDate);
	    /*获取到总的页码数目*/
	    int totalPage = newsService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = newsService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(News news:newsList) {
			JSONObject jsonNews = news.getJsonObject();
			jsonArray.put(jsonNews);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询新闻信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<News> newsList = newsService.queryAllNews();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(News news:newsList) {
			JSONObject jsonNews = new JSONObject();
			jsonNews.accumulate("newsId", news.getNewsId());
			jsonNews.accumulate("newsTitle", news.getNewsTitle());
			jsonArray.put(jsonNews);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询新闻信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String newsTitle,String newsDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (newsTitle == null) newsTitle = "";
		if (newsDate == null) newsDate = "";
		List<News> newsList = newsService.queryNews(newsTitle, newsDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    newsService.queryTotalPageAndRecordNumber(newsTitle, newsDate);
	    /*获取到总的页码数目*/
	    int totalPage = newsService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = newsService.getRecordNumber();
	    request.setAttribute("newsList",  newsList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("newsTitle", newsTitle);
	    request.setAttribute("newsDate", newsDate);
		return "News/news_frontquery_result"; 
	}

     /*前台查询News信息*/
	@RequestMapping(value="/{newsId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer newsId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键newsId获取News对象*/
        News news = newsService.getNews(newsId);

        request.setAttribute("news",  news);
        return "News/news_frontshow";
	}

	/*ajax方式显示新闻信息修改jsp视图页*/
	@RequestMapping(value="/{newsId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer newsId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键newsId获取News对象*/
        News news = newsService.getNews(newsId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonNews = news.getJsonObject();
		out.println(jsonNews.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新新闻信息信息*/
	@RequestMapping(value = "/{newsId}/update", method = RequestMethod.POST)
	public void update(@Validated News news, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String newsPhotoFileName = this.handlePhotoUpload(request, "newsPhotoFile");
		if(!newsPhotoFileName.equals("upload/NoImage.jpg"))news.setNewsPhoto(newsPhotoFileName); 


		try {
			newsService.updateNews(news);
			message = "新闻信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "新闻信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除新闻信息信息*/
	@RequestMapping(value="/{newsId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer newsId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  newsService.deleteNews(newsId);
	            request.setAttribute("message", "新闻信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "新闻信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条新闻信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String newsIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = newsService.deleteNewss(newsIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出新闻信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String newsTitle,String newsDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(newsTitle == null) newsTitle = "";
        if(newsDate == null) newsDate = "";
        List<News> newsList = newsService.queryNews(newsTitle,newsDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "News信息记录"; 
        String[] headers = { "新闻id","新闻标题","新闻图片","新闻日期","新闻来源"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<newsList.size();i++) {
        	News news = newsList.get(i); 
        	dataset.add(new String[]{news.getNewsId() + "",news.getNewsTitle(),news.getNewsPhoto(),news.getNewsDate(),news.getNewsFrom()});
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
			response.setHeader("Content-disposition","attachment; filename="+"News.xls");//filename是下载的xls的名，建议最好用英文 
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
