package com.chengxusheji.utils;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Collection;
import java.util.Iterator;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFComment;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;

public class ExportExcelUtil {

	public void exportExcel(Collection<String[]> dataset, OutputStream out) {
		exportExcel("","测试POI导出EXCEL文档", null, dataset, out, "yyyy-MM-dd");
	}

	public void exportExcel(String rootPath,String title, String[] headers,
			Collection<String[]> dataset, OutputStream out) {
		exportExcel(rootPath,title, headers, dataset, out, "yyyy-MM-dd");
	}

	public void exportExcel(String[] headers, Collection<String[]> dataset,
			OutputStream out, String pattern) {
		exportExcel("","测试POI导出EXCEL文档", headers, dataset, out, pattern);
	}

	/**
	 * 这是一个通用的方法，可以将放置在JAVA集合中并且符号一定条件的数据以EXCEL 的形式输出到指定IO设备上
	 * 
	 * @param title
	 *            表格标题名
	 * @param headers
	 *            表格属性列名数组
	 * @param dataset
	 *            需要显示的数据集合
	 * @param out
	 *            与输出设备关联的流对象，可以将EXCEL文档导出到本地文件或者网络中
	 * @param pattern
	 *            如果有时间数据，设定输出格式。默认为"yyy-MM-dd"
	 */
	@SuppressWarnings("unchecked")
	public void exportExcel(String rootPath,String title, String[] headers,
			Collection<String[]> dataset, OutputStream out, String pattern) {
		// 声明一个工作薄
		HSSFWorkbook workbook = new HSSFWorkbook();
		// 生成一个表格
		HSSFSheet sheet = workbook.createSheet(title);
		// 设置表格默认列宽度为15个字节
		sheet.setDefaultColumnWidth((short) 15);
		// 生成一个样式
		HSSFCellStyle style = workbook.createCellStyle();
		// 设置这些样式
		style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		// 生成一个字体
		HSSFFont font = workbook.createFont();
		font.setColor(HSSFColor.VIOLET.index);
		font.setFontHeightInPoints((short) 12);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		// 把字体应用到当前的样式
		style.setFont(font);
		// 生成并设置另一个样式
		HSSFCellStyle style2 = workbook.createCellStyle();
		style2.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
		style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		// 生成另一个字体
		HSSFFont font2 = workbook.createFont();
		font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
		// 把字体应用到当前的样式
		style2.setFont(font2);

		// 声明一个画图的顶级管理器
		HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
		// 定义注释的大小和位置,详见文档
		HSSFComment comment = patriarch.createComment(new HSSFClientAnchor(0,
				0, 0, 0, (short) 4, 2, (short) 6, 5));
		// 设置注释内容
		comment.setString(new HSSFRichTextString("可以在POI中添加注释！"));
		// 设置注释作者，当鼠标移动到单元格上是可以在状态栏中看到该内容.
		comment.setAuthor("leno");

		// 产生表格标题行
		HSSFRow row = sheet.createRow(0);
		for (short i = 0; i < headers.length; i++) {
			HSSFCell cell = row.createCell(i);
			cell.setCellStyle(style);
			HSSFRichTextString text = new HSSFRichTextString(headers[i]);
			cell.setCellValue(text);
		}

		// 遍历集合数据，产生数据行
		Iterator<String[]> it = dataset.iterator();
		int index = 0;
		while (it.hasNext()) {
			index++;
			row = sheet.createRow(index);
			String[] t = (String[]) it.next();
			for (short i = 0; i < t.length; i++) {
				HSSFCell cell = row.createCell(i);
				cell.setCellStyle(style2);
				// 判断值的类型后进行强制类型转换
				String textValue = t[i];
				 
				if(textValue.startsWith("upload/"))
				{
					// 有图片时，设置行高为50px;  
                    row.setHeightInPoints(50);   
					// 设置图片所在列宽度为80px,注意这里单位的一个换算
					sheet.setColumnWidth(i, (short) (35.7 * 80)); // 
					//sheet.autoSizeColumn(i);  
					BufferedInputStream bis;
					byte[] buf = null;
					try {
						bis = new BufferedInputStream(  
						        new FileInputStream(rootPath + textValue));
						buf = new byte[bis.available()];  
			            while ((bis.read(buf)) != -1) {}   
			            
			            HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0, 1023,
								255, (short) i, index, (short) i, index);
						anchor.setAnchorType(2); 
						patriarch.createPicture(anchor,
								workbook.addPicture( buf,
						HSSFWorkbook.PICTURE_TYPE_JPEG));  
					} catch (Exception e) {  
						e.printStackTrace();
					}     
					
				} else {
					HSSFRichTextString richString = new HSSFRichTextString(
							textValue);
					HSSFFont font3 = workbook.createFont();
					font3.setColor(HSSFColor.BLUE.index);
					richString.applyFont(font3);
					cell.setCellValue(richString);
				}
				
				/*
				 * else if (value instanceof byte[]) { // 有图片时，设置行高为60px;
				 * row.setHeightInPoints(60); // 设置图片所在列宽度为80px,注意这里单位的一个换算
				 * sheet.setColumnWidth(i, (short) (35.7 * 80)); //
				 * sheet.autoSizeColumn(i); byte[] bsValue = (byte[]) value;
				 * HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0, 1023,
				 * 255, (short) 6, index, (short) 6, index);
				 * anchor.setAnchorType(2); patriarch.createPicture(anchor,
				 * workbook.addPicture( bsValue,
				 * HSSFWorkbook.PICTURE_TYPE_JPEG)); } else{ //其它数据类型都当作字符串简单处理
				 * textValue = value.toString(); }
				 */

			}
		}
		try {
			workbook.write(out);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
