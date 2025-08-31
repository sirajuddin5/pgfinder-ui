package com.thryve.pgfinder_ui.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.thryve.pgfinder_ui.model.APIResponse;
import com.thryve.pgfinder_ui.model.TokenRequest;
import com.thryve.pgfinder_ui.service.PgFinderService;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private PgFinderService pgFinderService;

	
	@GetMapping("/")
    public String index() {
        return "index"; 
    }
	
	@GetMapping("/register")
    public String register() {
        return "register"; 
    }
	
	@GetMapping("/ownerDasboard")
    public String ownerDasboard(Model model) {
		String token = session.getAttribute("token") == null ? "": session.getAttribute("token").toString();
	    System.out.println("token  : " + token);
	    if (token.equals("")) return "login";
	    
	    APIResponse response = new APIResponse();
	    TokenRequest tokenRequest = new TokenRequest();
	    tokenRequest.setToken(token);
	    
	    response = pgFinderService.getOwner(token);
	    System.out.println("response :"+ response);
	    model.addAttribute("response", response);
	    
	    

		
        return "ownerDasboard"; 
    }
	
	@GetMapping("/upload")
    public String showUploadForm() {
        return "upload";  
    }
	
	@GetMapping("/allPg")
    public String allPg() {
        return "allPg";  
    }
	
	@GetMapping("/login")
    public String login() {
        return "login";  
    }
	

}
