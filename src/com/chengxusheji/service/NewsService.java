package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.News;

import com.chengxusheji.mapper.NewsMapper;
@Service
public class NewsService {

	@Resource NewsMapper newsMapper;
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

    /*添加新闻信息记录*/
    public void addNews(News news) throws Exception {
    	newsMapper.addNews(news);
    }

    /*按照查询条件分页查询新闻信息记录*/
    public ArrayList<News> queryNews(String newsTitle,String newsDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!newsTitle.equals("")) where = where + " and t_news.newsTitle like '%" + newsTitle + "%'";
    	if(!newsDate.equals("")) where = where + " and t_news.newsDate like '%" + newsDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return newsMapper.queryNews(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<News> queryNews(String newsTitle,String newsDate) throws Exception  { 
     	String where = "where 1=1";
    	if(!newsTitle.equals("")) where = where + " and t_news.newsTitle like '%" + newsTitle + "%'";
    	if(!newsDate.equals("")) where = where + " and t_news.newsDate like '%" + newsDate + "%'";
    	return newsMapper.queryNewsList(where);
    }

    /*查询所有新闻信息记录*/
    public ArrayList<News> queryAllNews()  throws Exception {
        return newsMapper.queryNewsList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String newsTitle,String newsDate) throws Exception {
     	String where = "where 1=1";
    	if(!newsTitle.equals("")) where = where + " and t_news.newsTitle like '%" + newsTitle + "%'";
    	if(!newsDate.equals("")) where = where + " and t_news.newsDate like '%" + newsDate + "%'";
        recordNumber = newsMapper.queryNewsCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取新闻信息记录*/
    public News getNews(int newsId) throws Exception  {
        News news = newsMapper.getNews(newsId);
        return news;
    }

    /*更新新闻信息记录*/
    public void updateNews(News news) throws Exception {
        newsMapper.updateNews(news);
    }

    /*删除一条新闻信息记录*/
    public void deleteNews (int newsId) throws Exception {
        newsMapper.deleteNews(newsId);
    }

    /*删除多条新闻信息信息*/
    public int deleteNewss (String newsIds) throws Exception {
    	String _newsIds[] = newsIds.split(",");
    	for(String _newsId: _newsIds) {
    		newsMapper.deleteNews(Integer.parseInt(_newsId));
    	}
    	return _newsIds.length;
    }
}
