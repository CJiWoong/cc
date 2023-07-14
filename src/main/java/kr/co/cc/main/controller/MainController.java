package kr.co.cc.main.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;

import java.time.LocalDate;

import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


import kr.co.cc.main.dto.MainDTO;
import kr.co.cc.main.service.MainService;
import kr.co.cc.member.service.MemberService;
import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;
import kr.co.cc.work.dto.WorkDTO;
import kr.co.cc.work.service.WorkService;

@Controller
public class MainController {
	
	@Autowired WorkService service;	
	@Autowired MainService mservice;
	@Autowired MemberService memberservice;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	private String time;
	private String date;
	
	@GetMapping(value="/mainGNB.go")
	public String index() {
		return "index";

	}
	
	@GetMapping(value="/index2.go")
	public String index2() {
		return "index2";
	}
	
	@GetMapping(value="/calender.go")
	public String calenderGo() {
		return "calender";
	}
	

	
	// 000.move 로 요청이 오면 000.jsp 로 이동
	@GetMapping(value="/{page}.move")
	public String pageMove(@PathVariable String page) {
		logger.info(page+".jsp 로 이동");
		return page;
	}
	
	
	
	@GetMapping(value="{root}/{page}.move")
	public String pageMove(@PathVariable String root
			,@PathVariable String page) {
		logger.info(page+".jsp 로 이동");
		return root+"/"+page;
	}
	
	@GetMapping(value="{root}/{sub}/{page}.move")
	public String pageMove(@PathVariable String root
			,@PathVariable String sub
			,@PathVariable String page) {
		logger.info(page+".jsp 로 이동");
		return root+"/"+sub+"/"+page;
	}
	
	
	// 로그인 성공시 가는 메인페이지
	@RequestMapping(value="/main.go")
	public String main(Model model, HttpSession session) {
	    String loginId = (String) session.getAttribute("id");
	    MainDTO mainPage = memberservice.mainPage(loginId);
	    logger.info("mainPage: " + mainPage);

		
		 //출퇴근 
		 MainDTO timeList = mservice.mWorkHistory(loginId); 
		 
		
	    
	    // 대시보드
	    int mstotal = mservice.totalCountMs(loginId);
	    int doctotal = mservice.totalCountDoc(loginId);
	    int prtotal = mservice.totalCountPr(loginId);
	    
	    // 공지사항
	    ArrayList<NoticeBoardDTO> Nolist = mservice.noticelist();
	    
	    
	    model.addAttribute("timeList", timeList);
	    model.addAttribute("main", mainPage);
	    model.addAttribute("ms", mstotal);
	    model.addAttribute("doc", doctotal);
	    model.addAttribute("pro", prtotal);
	    model.addAttribute("Nolist", Nolist);
	    
	    
	    return "mainTest";
	}

	
	
	
	@GetMapping(value="/mtimeGo.do")
	public String mtimeGo(HttpSession session, Model model) {

		String id = (String) session.getAttribute("id");
	
		
		int row = service.timeGoBefore(id,date);
		logger.info("timeGoBefore row : " + row);		
		
		if(row==0) {
			service.timeGo(id);
			
			
			
		}	
		
		
		
		return "redirect:/main.go";

	}
	
	@GetMapping(value="/mtimeEnd.do")
	public String mtimeEnd(HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("id");
		
		
		int row = service.timeGoBefore(id,date);
		logger.info("timeGoBefore row : " + row);		
		
		if(row==1) {
			service.timeEnd(id,date,time);
			
		}
		
	
		
		return "redirect:/main.go";
	}	


	
	
	
}