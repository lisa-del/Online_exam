package com.exam.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;

import com.exam.model.Exam;
import com.exam.model.ExamClass;
import com.exam.model.ExamStudent;
import com.exam.model.Question;
import com.exam.model.User;
import com.exam.service.IExamClassService;
import com.exam.service.IExamService;

/**
 * base controller
 * 登记Controller类需要的公共方法，如getCurrentUser()
 * @author zfh14
 *
 */
public class BaseController {
	
	/**
	 * 获得当前用户
	 * @param request
	 * @return
	 */
	protected User getCurrentUser(HttpServletRequest request) {
		HttpSession session = request.getSession();
		return (User)session.getAttribute("user");
	}
	
	/**
	 * 更新当前用户
	 * @param request
	 * @param newUser
	 */
	protected void updateCurrentUser(HttpServletRequest request, User newUser) {
		HttpSession session = request.getSession();
		session.setAttribute("user", newUser);
	}
	
	/**
	 * 接收上传文件
	 * @param request
	 * @return
	 */
	protected String saveHttpFile(HttpServletRequest request) {
		String filePath = "";
		List<Question> questionList = new ArrayList<Question>();
		
		DiskFileUpload diskFileUpload = new DiskFileUpload();//这个已经被废弃了，之后改成菜鸟教程的示例中的做法‘
		try {
			List<FileItem> fileList = diskFileUpload.parseRequest(request);//解析表单中每一个字段的数据，
			//包装成独立的FileItem对象并且以List方式返回
			//下面处理所有的FileItem
			for(FileItem i:fileList) {
				if(!i.isFormField()) {
					//File remoteFile = new File(new String(i.getName().getBytes(),"UTF-8"));//获得要上传的文件的引用
					File remoteFile = new File(i.getName());//不使用转换编码格式的话就可以传递文件名为中文的文件了
					//下面指定要把上面的remoteFile保存为？
					File saveFile = new File(new String(remoteFile.getName()));
					saveFile.createNewFile();
					
					//下面把remoteFile的内容输出到saveFile
					InputStream ins = i.getInputStream();//获得这个fileItem的输入流
					OutputStream ous = new FileOutputStream(saveFile);//获得saveFile的输出流
					
					byte[] buffer = new byte[1024];
					int len=0;
					while( (len=ins.read(buffer)) > -1) {
						ous.write(buffer, 0, len);
					}
					ous.close();
					ins.close(); 
					
					filePath = saveFile.getAbsolutePath();
					break;//找到第一个文件就不再继续
				}
			}
		} catch (FileUploadException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return filePath;
	}
	
	/**
	 * 解析Excel文件，返回内容
	 * @param path
	 * @return
	 */
	protected List<List<String>> getExcelFileContent(String path){
		if(path.lastIndexOf(".xls")>=1 && path.lastIndexOf(".xlsx")<=0) {
			return getXlsFileContent(path);
		}else if(path.lastIndexOf(".xlsx")>=1) {
			return getXlsxFileContent(path);
		}
		
		return null;
	}
	
	/**
	 * excel in .xls
	 * use HSSF
	 * @param path
	 * @return
	 */
	private List<List<String>> getXlsFileContent(String path){
		List<List<String>> list = new ArrayList<List<String>>();
		try {
			InputStream is = new FileInputStream(path);
			HSSFWorkbook xssfWorkbook = new HSSFWorkbook(is);//代表整个Excel文件
			//遍历文件的每一页
			for(int i=0;i<xssfWorkbook.getNumberOfSheets();i++) {
				HSSFSheet sheet = xssfWorkbook.getSheetAt(i);//该页
				if(sheet==null) {
					continue;
				}
				//处理当前页，循环读取每一行
				int lines = sheet.getLastRowNum();
				for(int rowNum=0;rowNum<=lines;rowNum++) {
					HSSFRow row = sheet.getRow(rowNum);//这一行
					if(row==null) {
						continue;
					}
					int minColIx = row.getFirstCellNum();
					int lastColIx = row.getLastCellNum();
					List<String> rowList = new ArrayList<String>();
					//遍历这一行，读取每一个Cell元素
					for(int colIx = minColIx; colIx<lastColIx; colIx++) {
						HSSFCell cell = row.getCell(colIx);
						//rowList.add(ExcelUtils.getStringVal(cell));
						rowList.add(cell.getStringCellValue());
						//cell.toString();
					}
					list.add(rowList);
				}
				
			}
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	/**
	 * excel in .xlsx
	 * use XSSF
	 * @param path
	 * @return
	 */
	private List<List<String>> getXlsxFileContent(String path){
		List<List<String>> list = new ArrayList<List<String>>();
		try {
			InputStream is = new FileInputStream(path);
			XSSFWorkbook xssfWorkbook = new XSSFWorkbook(is);//代表整个Excel文件
			//遍历文件的每一页
			for(int i=0;i<xssfWorkbook.getNumberOfSheets();i++) {
				XSSFSheet sheet = xssfWorkbook.getSheetAt(i);//该页
				if(sheet==null) {
					continue;
				}
				//处理当前页，循环读取每一行
				int lines = sheet.getLastRowNum();
				for(int rowNum=0;rowNum<=lines;rowNum++) {
					XSSFRow row = sheet.getRow(rowNum);//这一行
					if(row==null) {
						continue;
					}
					int minColIx = row.getFirstCellNum();
					int lastColIx = row.getLastCellNum();
					List<String> rowList = new ArrayList<String>();
					//遍历这一行，读取每一个Cell元素
					for(int colIx = minColIx; colIx<lastColIx; colIx++) {
						XSSFCell cell = row.getCell(colIx);
						//rowList.add(ExcelUtils.getStringVal(cell));
						rowList.add(cell.toString());
						//cell.toString();
					}
					list.add(rowList);
				}
				
			}
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Autowired 
	IExamClassService examClassService;
	/**
	 * 返回可选课程列表
	 * @return
	 */
	protected List<ExamClass> getExamClassAsList(){
		return examClassService.getExamClassList();
	}
	
	@Autowired 
	IExamService examService;
	/**
	 * 返回考试列表
	 * @return
	 */
	protected List<Exam> getExamList(){
		return examService.getExamList();
	}

}
