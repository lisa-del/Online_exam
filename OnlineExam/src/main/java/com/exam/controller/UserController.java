package com.exam.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.exam.model.Exam;
import com.exam.model.ExamClass;
import com.exam.model.ExamStudent;
import com.exam.model.User;
import com.exam.service.IExamService;
import com.exam.service.IUserService;
/**
 * userController
 * 负责处理有关用户登录、注册、验证等行为
 *
 */
@Controller
public class UserController extends BaseController{
	
	@Autowired
	IUserService userService;
	
	/**
	 * 登录
	 * Session、Cookie
	 * @param request
	 * @param reponse
	 * @return
	 */
	@RequestMapping("")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = new ModelAndView("login");//登录界面
		String operate = request.getParameter("operate");
		
		if(operate!=null && operate.equals("login")) {
			String numb = request.getParameter("numb");//Email改为numb
			String password = request.getParameter("password");
			String userType = request.getParameter("userType");
			
			String remember = request.getParameter("remember");//单选框，是否记住密码
			//根据remember设置是否保存密码至cookie
			if(remember!=null && remember.equals("on")) {
				Cookie numbCookie = new Cookie("numb",numb);
				Cookie passwordCookie = new Cookie("password",password);
				Cookie userTypeCookie = new Cookie("type",userType);
				//设置Cookie的有效期为30天
				numbCookie.setMaxAge(60*60*24*30);
				passwordCookie.setMaxAge(60*60*24*30);
				userTypeCookie.setMaxAge(60*60*24*30);
				
				response.addCookie(numbCookie);
				response.addCookie(passwordCookie);
				response.addCookie(userTypeCookie);
			}
			
			//下面开始验证
			User paramUser  = new User();
			paramUser.setNumb(numb);
			paramUser.setPassword(password);
			paramUser.setIdentity(Integer.parseInt(userType));
			User user = userService.getUserByParam(paramUser);
			if(user!=null) {
				if(user.getIdentity()==0) {
					view = new ModelAndView("root/main");
				    List<ExamClass> classList = getExamClassAsList();//获得可选课程列表
//				    view.addObject("classList",classList);
				    HttpSession session = request.getSession();
				    session.setAttribute("classList", classList);
				}else if(user.getIdentity()==1) {
					view = new ModelAndView("student/main");
				}
				HttpSession session = request.getSession();
				session.setAttribute("user", user);//必须要实现的，即将当前用户的信息记录到session
				view.addObject("user", user);
				System.out.println("登录成功，打开主页面");
			}else {
				view = new ModelAndView("false");
				System.out.println("登录失败");
			}
		}
		
		return view;
	}
	
	/**
	 * 注册
	 * @param request
	 * @param reponse
	 * @return
	 */
	@RequestMapping("/register")
	public ModelAndView register(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView view = new ModelAndView("register");//注册界面
		String operate = request.getParameter("operate");
		if(operate!=null && operate.equals("register")) {
			String numb = request.getParameter("numb");
			String name = request.getParameter("name");
			String password = request.getParameter("password");
			
			User reUser = new User();
			reUser.setNumb(numb);
			reUser.setName(name);
			reUser.setPassword(password);
			
			reUser.setIdentity(1);//学生
			reUser.setCreateTime(new Date());
			
			boolean res = userService.insertUser(reUser);
			if(res) {
				System.out.println("注册成功");
				view = new ModelAndView("student/main");//注册成功之后打开学生界面
				HttpSession session = request.getSession();
				session.setAttribute("user", reUser);//必须要实现的，即将当前用户的信息记录到session
			}else {
				System.out.println("注册失败");
				//返回提示信息等..
			}
		}
		return view;
		
	}
	
	/**
	 * 退出登录
	 * @param request
	 * @param response
	 */
	@RequestMapping("/logout")
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.removeAttribute("user");//从session删除用户信息
		try {
			response.sendRedirect("/OnlineExam/");//重定向到登录界面
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping("/userInfo")
	public ModelAndView userManager(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = null;//用户信息管理界面
		User user = getCurrentUser(request);
		if(user!=null && user.getIdentity()==1) {
			view = new ModelAndView("/student/userInfo");
		}else if(user!=null && user.getIdentity()==0) {
			view = new ModelAndView("/root/userInfo");
		}
		
		String operate = request.getParameter("operate");
		if(operate!=null && operate.equals("userInfoReset")) {
			String name = request.getParameter("name");
			String numb = request.getParameter("numb");
			if(name!=null && name!="") {
				user.setName(name);
			}
			if(numb!=null && numb!="") {
				user.setNumb(numb);
			}
			userService.updateUserById(user);
			updateCurrentUser(request,user);//更新session中的用户信息
			view.addObject("user", user);
			
		}else if(operate!=null && operate.equals("passwordReset")) {
			String oldPassword = request.getParameter("oldPassword");
			String newPassword = request.getParameter("newPassword");
			if(user.getPassword().equals(oldPassword)) {
				if(newPassword!=null && newPassword!="") {
				    user.setPassword(newPassword);
				    userService.updateUserById(user);
					updateCurrentUser(request,user);//更新session中的用户信息
					view.addObject("user", user);
				}
			}else {
				view.addObject("failMessage", "原密码输入错误");//
			}
		}
		
		return view;
		
	}
	
	@RequestMapping("/main")
	public ModelAndView returnMain(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = null;
		User user = getCurrentUser(request);
		if(user!=null && user.getIdentity()==0) {
			view = new ModelAndView("root/main");
		    List<ExamClass> classList = getExamClassAsList();//获得可选课程列表
		   // view.addObject("classList",classList);
		    HttpSession session = request.getSession();
		    session.setAttribute("classList", classList);
		}else if(user!=null && user.getIdentity()==1) {
			view = new ModelAndView("student/main");
		}
		return view;
	}
	
//	管理员查看考试历史页面
	@RequestMapping(value="/examHistory")
	public ModelAndView returnExamHistory(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = null;
		User user = getCurrentUser(request);
		if(user!=null && user.getIdentity()==0) {
			view = new ModelAndView("root/examHistory");
			List<Exam> examList = getExamList();
//			view.addObject("examList",examList);
			HttpSession session = request.getSession();
			session.setAttribute("examList", examList);
		}else if(user!=null && user.getIdentity()==1) {
			view = new ModelAndView("student/main");
		}
		return view;
	}
	
//	@RequestMapping(value="/getExamList")
//	@ResponseBody
//	public Object getExamList(HttpServletRequest request, HttpServletResponse response) {
//		System.out.println("Get exam list!");
//		List<Exam> studentList = getExamList();
//		
//		Map map = new HashMap<>();
//		map.put("studentList", studentList);
//        return map;
//	}

	//查看详情页面
	@RequestMapping("/examDetail")
	public ModelAndView returnExamDetail(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = null;
		User user = getCurrentUser(request);
		if(user!=null && user.getIdentity()==0) {
			view = new ModelAndView("root/examDetail");
		}else if(user!=null && user.getIdentity()==1) {
			view = new ModelAndView("student/main");
		}
		return view;
	}
}
