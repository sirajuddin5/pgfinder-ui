package com.thryve.pgfinder_ui.restController;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.thryve.pgfinder_ui.model.APIResponse;
import com.thryve.pgfinder_ui.model.FetchAPIRequest;
import com.thryve.pgfinder_ui.model.Filter;
import com.thryve.pgfinder_ui.model.GlobalOperator;
import com.thryve.pgfinder_ui.model.PageRequestDTO;
import com.thryve.pgfinder_ui.service.PgFinderService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/pgFinderRest")
@CrossOrigin("*")
public class PgFinderRestController {

	@Autowired
	private HttpSession session;
	
	@PostMapping("/register")
	public APIResponse register(@RequestBody Map<String, Object> requestParams) {
	    APIResponse response = PgFinderService.register(requestParams);
	    System.out.println("response : " + response);
	    
	    if (response.isSuccess()) {
	        try {
	            // Get the data object
	            Object dataObj = response.getData();
	            
	            if (dataObj instanceof Map) {
	                Map<String, Object> data = (Map<String, Object>) dataObj;
	                
	                // Based on your JSON structure, the token is nested inside tokenResponse
	                Object tokenResponseObj = data.get("tokenResponse");
	                
	                if (tokenResponseObj instanceof Map) {
	                    Map<String, Object> tokenResponse = (Map<String, Object>) tokenResponseObj;
	                    Object tokenObj = tokenResponse.get("token");
	                    
	                    if (tokenObj != null) {
	                        String token = tokenObj.toString();
	                        System.out.println("token : " + token);
	                        session.setAttribute("token", token);
	                    } else {
	                        System.out.println("Token not found in tokenResponse");
	                    }
	                } else {
	                    System.out.println("tokenResponse is not a Map or is null");
	                }
	            } else {
	                System.out.println("Data is not a Map or is null");
	            }
	        } catch (Exception e) {
	            System.out.println("Error extracting token: " + e.getMessage());
	            e.printStackTrace();
	        }
	    }	    
	    return response;
	}
		
	@PostMapping("/login")
	public APIResponse login(@RequestBody Map<String, Object> requestParams) {
	    APIResponse response = PgFinderService.login(requestParams);
	    System.out.println("response : " + response);

	    if (response.isSuccess()) {
	        Object dataObj = response.getData();
	        if (dataObj instanceof Map) {
	            Map<String, Object> data = (Map<String, Object>) dataObj;

	            Object tokenObj = data.get("tokenResponse");
	            if (tokenObj != null) {
	                String token = tokenObj.toString();
	                System.out.println("Login Token : " + token);
	                session.setAttribute("token", token);  
	            }
	        }
	    }
	    return response;
	}

	@PostMapping("/createProperty")
	public ResponseEntity<?> createProperty(
	        @RequestHeader("Authorization") String authHeader,
	        @RequestBody Map<String, Object> requestParams) {
	    
	    String token = authHeader.replace("Bearer ", "");
	    session.setAttribute("token", token); 	    
	    System.out.println("requestParams : " + requestParams);
	    
	    APIResponse response = PgFinderService.createProperty(requestParams, token); 
	    System.out.println("response RestController: " + response);
	    
	    return ResponseEntity.ok(response);
	}

    @PostMapping("/getAllPGList")
    public APIResponse activeCounselList(@RequestBody Map<String, Object> requestParams) {    	
    	  System.out.println("requestParams : " + requestParams);
          int pageSize = requestParams.get("pageSize") != null ? Integer.parseInt(requestParams.get("pageSize").toString()): 10; 
          int pageNum = requestParams.get("pageNumber") != null? Integer.parseInt(requestParams.get("pageNumber").toString()): 0; 

          APIResponse response = new APIResponse();
          String name = requestParams.get("name") != null ? requestParams.get("name").toString() : ""; System.out.println("PGname :   " + name);

          String token = (String) session.getAttribute("token");
        
          FetchAPIRequest fetchAPIRequest = new FetchAPIRequest();
          List<Filter> filterList = new ArrayList<>();
          if(name.length() > 0)filterList.add(new Filter().setKey("name").setValue(name).setOperation(Filter.Operation.LIKE)); 
  
          System.out.println("Filter List:   " + filterList);
          fetchAPIRequest.setFilterList(filterList);
          fetchAPIRequest.setGlobalOperator(GlobalOperator.AND);
          PageRequestDTO pageRequestDTO = new PageRequestDTO();
          pageRequestDTO.setPageNumber(pageNum);
          pageRequestDTO.setPageSize(pageSize);
          pageRequestDTO.setSort("ASC");
          pageRequestDTO.setSortByColumn("id");
          fetchAPIRequest.setPageRequestDTO(pageRequestDTO);
          
          response = PgFinderService.getAllPG(fetchAPIRequest, token);          
          System.out.println("response: " + response);
          return response;
    }

}