package kr.co.cc.stat.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.cc.stat.service.StatService;

@Controller
public class StatController {
	
	@Autowired StatService statservice;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/stat.go", method = RequestMethod.GET)
	public String statgo() {
		return "StatForm";
	}
	
   @GetMapping(value="/connect.do")
   public String connect(Model model) {
      
      String source = statservice.connect("https://studio.youtube.com/channel/UCyBi9Lv4Bn9_IL6oqmObNLA/analytics/tab-overview/period-default");
      model.addAttribute("elem", source);
      
      return "Statresult";
   }

	
	
	
	@GetMapping(value="/findElem.do")
	public String findElem() {
	      
		statservice.findElem("https://kr.noxinfluencer.com/youtube/channel-calculator/UCaxbXRPhdHPXjM-e-F00LVA");
		  
		return "StatForm";
	}
	
}
