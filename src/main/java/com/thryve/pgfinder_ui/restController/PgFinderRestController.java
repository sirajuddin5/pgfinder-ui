package com.thryve.pgfinder_ui.restController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.thryve.pgfinder_ui.model.APIResponse;
import com.thryve.pgfinder_ui.service.PgFinderService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/pgFinderRest")
@CrossOrigin("*")
public class PgFinderRestController {

	@Autowired
	private HttpSession session;

//	@PostMapping("/register")
//	public APIResponse register(@RequestBody Map<String, Object> requestParams) {
//		 APIResponse response = PgFinderService.register(requestParams); System.out.println("response : "+response);
//		 if (response.isSuccess()) {  // check success boolean
//		        HashMap<String, Object> result = (HashMap<String, Object>) response.getData();  // get data instead of result
//		        String token = result.get("token").toString();
//		        System.out.println("token : " + token);
//		        session.setAttribute("token", token);
//		    }
//		 return response;
//	}
	
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
            
            // Based on your JSON structure, the token is nested inside tokenResponse
            Object token = data.get("tokenResponse");
            System.out.println("token : " + token);
            session.setAttribute("token", token);
           
        } else {
            System.out.println("Data is not a Map or is null");
        }
	        
	    }
	    
	    return response;
	}

	
	
//	@PostMapping("/paymentAction")
//	public HashMap<String, Object> paymentAction(@RequestBody Map<String, Object> requestParams) {
//		System.out.println("request params : "+ requestParams );
//		int pageSize = (requestParams.get("pageSize") != null && Integer.parseInt(String.valueOf(requestParams.get("pageSize"))) > 0)
//	               ? Integer.parseInt(String.valueOf(requestParams.get("pageSize")))
//	               : 10;
//
//		int pageNumber = (requestParams.get("pageNumber") != null && !String.valueOf(requestParams.get("pageNumber")).equals("null"))
//                ? Integer.parseInt(String.valueOf(requestParams.get("pageNumber")))
//                : 0;
//
//		String candidateName = requestParams.get("searchByName") != null
//                ? requestParams.get("searchByName").toString()
//                : ""; // Default value
//
//        System.out.println("candidateName searchByName: " + candidateName);
//
////		//FetchAPIRequest fetchAPIRequest = new FetchAPIRequest();
////		List<Filter> filterList = new ArrayList<>();
////		filterList.add(new Filter().setKey("candidateName").setValue(candidateName).setOperation(Filter.Operation.LIKE));
////		fetchAPIRequest.setFilterList(filterList);
////		GlobalOperator globalOperator = GlobalOperator.AND;
////		fetchAPIRequest.setGlobalOperator(globalOperator);
////		PageRequestDTO pageRequestDTO = new PageRequestDTO();
////		pageRequestDTO.setPageNumber(pageNumber);
////		pageRequestDTO.setPageSize(pageSize);
////		pageRequestDTO.setSort("DESC");
////		pageRequestDTO.setSortByColumn("createdAt");
////		fetchAPIRequest.setPageRequestDTO(pageRequestDTO);
//		APIResponse candidateDataResponse = AdminPanelService.paymentAction(requestParams);
//		//System.out.println("candidateDataResponse : "+candidateDataResponse);
//		HashMap<String, Object> candidateDataResult = (HashMap<String, Object>) candidateDataResponse.getResult();
//
//		Map<String, Object> candidateBasicInfoResponse = (Map<String, Object>) candidateDataResult.get("candidateBasicInfoResponse");
//		//System.out.println("candidateBasicInfoResponse : "+candidateBasicInfoResponse);
//		HashMap<String, Object> candidateBasicInfoResult = (HashMap<String, Object>) candidateBasicInfoResponse.get("result");
//		List<HashMap<String, Object>> candidateBasicInfoContentList = (List<HashMap<String, Object>>) candidateBasicInfoResult.get("content");
//		//System.out.println("candidateBasicInfoContentList : "+candidateBasicInfoContentList);
//
//		return candidateBasicInfoResult;
//	}


}