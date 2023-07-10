package kr.co.cc.doc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.doc.service.DocService;

@Controller
public class DocController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// 의존성 생성자 주입
	private final DocService service;
	
	public DocController(DocService service) {
		this.service = service;
	}
	
	// 기안문 작성 폼으로 이동
	@RequestMapping(value="/docWriteForm.go")
	public ModelAndView docWriteForm(HttpSession session) {
		
		return service.docWriteForm(session);
	}
	
	@RequestMapping(value="/docWrite.do")
	public ModelAndView docWrite(MultipartFile[] attachment, HttpSession session,
			@RequestParam String[] approvalPriority, @RequestParam String[] approvalMemberId, 
			@RequestParam HashMap<String, String> params) {

		ArrayList<String[]> approvalList = new ArrayList<String[]>();
		// 결재선 정렬 로직 // HashMap을 쓰면 뒤죽박죽 되어서 List에 String 2개짜리 배열 이용함.
		for(int i=0;i<approvalPriority.length;i++) {
			
			String[] approvalString = new String[2];
			
			approvalString[0] = approvalPriority[i];
			approvalString[1] = approvalMemberId[i];
			approvalList.add(approvalString);
			logger.info("list0 :"+approvalList.get(i)[0]);
			logger.info("list1 :"+approvalList.get(i)[1]);
			
		}
		
		logger.info("params"+params);
		
		return service.docWrite(params, approvalList, attachment, session);
	}
	
	@RequestMapping(value="/tempDocList.go")
	public ModelAndView tempDocList(HttpSession session) {
		
		return service.tempDocList(session);
	}
	
	@RequestMapping(value="/tempDocUpdateForm.go")
	public ModelAndView tempDocUpdateForm(@RequestParam String id) {
		
		return service.tempDocUpdateForm(id);
	}
	
	@RequestMapping(value="/tempDocDelete.do")
	public ModelAndView tempDocDelete(@RequestParam String id) {
		
		return service.tempDocDelete(id);
	}
	
	@RequestMapping(value="/attachmentDownload.do")
	public ResponseEntity<Resource> attachmentDownload(@RequestParam String oriFileName, @RequestParam String attachmentId) {
		
		return service.attachmentDownload(oriFileName, attachmentId);
	}
	
	@RequestMapping(value="/attachmentDelete.do")
	public ModelAndView attachmentDelete(@RequestParam String docId, @RequestParam String attachmentId) {
		
		return service.attachmentDelete(docId, attachmentId);
	}
	
	@RequestMapping(value="/docUpdate.do")
	public ModelAndView docUpdate(MultipartFile[] attachment, HttpSession session,
			@RequestParam String[] approvalPriority, @RequestParam String[] approvalMemberId, 
			@RequestParam HashMap<String, String> params) {

		ArrayList<String[]> approvalList = new ArrayList<String[]>();
		
		// 결재선 정렬 로직 // HashMap을 쓰면 뒤죽박죽 되어서 List에 String 2개짜리 배열 이용함.
		for(int i=0;i<approvalPriority.length;i++) {
			
			String[] approvalString = new String[2];
			
			approvalString[0] = approvalPriority[i];
			approvalString[1] = approvalMemberId[i];
			approvalList.add(approvalString);
			logger.info("list0 :"+approvalList.get(i)[0]);
			logger.info("list1 :"+approvalList.get(i)[1]);
			
		}
		
		return service.docUpdate(params, approvalList, attachment, session);
	}
	
	@RequestMapping(value="/requestDocList.go")
	public ModelAndView requestDocList(HttpSession session) {
		
		return service.requestDocList(session);
	}
	
	@RequestMapping(value="/requestDocDetail.go")
	public ModelAndView requestDocDetail(@RequestParam String id) {
		
		return service.requestDocDetail(id);
	}
	
	@RequestMapping(value="/docWithdraw.ajax")
	@ResponseBody
	public HashMap<String, Object> docWithdraw(@RequestParam String docId){
		
		return service.docWithdraw(docId);
	}
	
	@RequestMapping(value="/requestDocWaitList.go")
	public ModelAndView requestDocWaitList(HttpSession session) {
		
		return service.requestDocWaitList(session);
	}
	
	@RequestMapping(value="/requestDocWaitDetail.go")
	public ModelAndView requestDocWaitDetail(@RequestParam String id, HttpSession session) {
		
		return service.requestDocWaitDetail(id, session);
	}
	
	@RequestMapping(value="/requestDocApproval.do")
	public ModelAndView requestDocApproval(@RequestParam HashMap<String, String> params, HttpSession session) {
		
		return service.requestDocApproval(params, session);
	}
	
	@RequestMapping(value="/objectionDocList.go")
	public ModelAndView objectionDocList(HttpSession session) {
		
		return service.objectionDocList(session);
	}
	
	@RequestMapping(value="/objectionDocDetail.go")
	public ModelAndView objectionDocDetail(@RequestParam String id, HttpSession session) {
		
		return service.objectionDocDetail(id, session);
	}
	
	@RequestMapping(value="/rewriteDoc.ajax")
	@ResponseBody
	public HashMap<String, Object> rewriteDoc(@RequestParam HashMap<String, String> params, HttpSession session){
		
		return service.rewriteDoc(params, session);
	}
	
	
	
	
	
	
}
