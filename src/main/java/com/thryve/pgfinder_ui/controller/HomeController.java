package com.thryve.pgfinder_ui.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.thryve.pgfinder_ui.model.APIResponse;
import com.thryve.pgfinder_ui.model.FetchAPIRequest;
import com.thryve.pgfinder_ui.model.Filter;
import com.thryve.pgfinder_ui.model.GlobalOperator;
import com.thryve.pgfinder_ui.model.PageRequestDTO;
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
	
	@GetMapping("/addNewProperty")
    public String addNewProperty(Model model) {
		String token = session.getAttribute("token") == null ? "": session.getAttribute("token").toString();
		 model.addAttribute("token", token); System.out.println("token  : " + token);
	    if (token.equals("")) return "login";
	    
	    APIResponse response = new APIResponse();
	    TokenRequest tokenRequest = new TokenRequest();
	    tokenRequest.setToken(token);
	    
	    response = pgFinderService.getOwner(token); System.out.println("response :"+ response);
	    model.addAttribute("response", response);
        return "addNewProperty";  
    }
	
	@GetMapping("/pgList")
    public String pgList(Model model) {
		String token;
		if (session.getAttribute("token") == null)
			token = "";
		else
			token = session.getAttribute("token").toString();
	    System.out.println("token  : " + token);
	    if (token.equals("")) return "login";

        FetchAPIRequest fetchAPIRequest = new FetchAPIRequest();
        List<Filter> filterList = new ArrayList<>();
        fetchAPIRequest.setFilterList(filterList);

        GlobalOperator globalOperator = GlobalOperator.AND;
        fetchAPIRequest.setGlobalOperator(globalOperator);

        PageRequestDTO pageRequestDTO = new PageRequestDTO();
        pageRequestDTO.setPageNumber(0);
        pageRequestDTO.setPageSize(10);
        pageRequestDTO.setSort("ASC");
        pageRequestDTO.setSortByColumn("id");

        fetchAPIRequest.setPageRequestDTO(pageRequestDTO);

        APIResponse fetchUsersResponse = pgFinderService.getAllPG(fetchAPIRequest, token);System.out.println("fetchUsersResponseService :"+ fetchUsersResponse);
        HashMap<String, Object> fetchUsersResult = (HashMap<String, Object>) fetchUsersResponse.getData();
        
        model.addAttribute("fetchUsersResult", fetchUsersResult);System.out.println("fetchUsersResult :"+ fetchUsersResult);
	    
	    
        return "pgList";  
    }
	

}
