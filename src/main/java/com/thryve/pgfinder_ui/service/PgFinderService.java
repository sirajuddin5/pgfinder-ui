package com.thryve.pgfinder_ui.service;

import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thryve.pgfinder_ui.constants.PgFinderConstants;
import com.thryve.pgfinder_ui.model.APIResponse;



@Service
public class PgFinderService {
	
	private static RestTemplate restTemplate = new RestTemplate();
	
		
	public static APIResponse register(Map<String, Object> requestParams) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		String url = PgFinderConstants.REGISTER; System.out.println("URL : "+url);
		HttpEntity<Object> requestEntity = new HttpEntity<>(requestParams, headers); System.out.println("Request : "+requestEntity);
		ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.POST, requestEntity, Map.class);
		
		HttpStatus statusCode = (HttpStatus) responseEntity.getStatusCode(); System.out.println("Response status: "+statusCode);
		APIResponse response = convertMapToObject(responseEntity.getBody()); System.out.println("Response Body : "+response);
		HttpHeaders responseHeaders = responseEntity.getHeaders(); // System.out.println("Response Headers : "+responseHeaders);
		
		return response;
	}
	
	public static APIResponse getOwner(String tokenRequest) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set("Authorization", "Bearer " + tokenRequest);
		
		String url = PgFinderConstants.GET_OWNER; System.out.println("URL : "+url);
		HttpEntity<Object> requestEntity = new HttpEntity<>( headers); System.out.println("Request : "+requestEntity);
		ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.GET, requestEntity, Map.class);
		
		HttpStatus statusCode = (HttpStatus) responseEntity.getStatusCode(); System.out.println("Response status: "+statusCode);
		APIResponse response = convertMapToObject1(responseEntity.getBody()); System.out.println("Response Body : "+response);
		HttpHeaders responseHeaders = responseEntity.getHeaders(); // System.out.println("Response Headers : "+responseHeaders);
		
		return response;
	}
	
	public static APIResponse login(Map<String, Object> requestParams) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		String url = PgFinderConstants.LOGIN; System.out.println("URL : "+url);
		HttpEntity<Object> requestEntity = new HttpEntity<>(requestParams, headers); System.out.println("Request : "+requestEntity);
		ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.POST, requestEntity, Map.class);
		
		HttpStatus statusCode = (HttpStatus) responseEntity.getStatusCode(); System.out.println("Response status: "+statusCode);
		APIResponse response = convertMapToObject(responseEntity.getBody()); System.out.println("Response Body : "+response);
		HttpHeaders responseHeaders = responseEntity.getHeaders(); // System.out.println("Response Headers : "+responseHeaders);
		
		return response;
	}
	
    // For createProperty
 /*   public static APIResponse createProperty(Map<String, Object> requestParams) {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            String url = PgFinderConstants.CREATE_PG;
            HttpEntity<Object> requestEntity = new HttpEntity<>(requestParams);System.out.println("Request createPropertyService: "+requestEntity);

            ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.POST, requestEntity, Map.class);

            if (responseEntity.getStatusCode().is2xxSuccessful() && responseEntity.getBody() != null) {
                return convertMapToObject(responseEntity.getBody());
            }

            return new APIResponse(); // Default response on failure

        } catch (Exception e) {
            e.printStackTrace();
            return new APIResponse(); // Default response on error
        }
    }*/
	
	public static APIResponse createProperty(Map<String, Object> requestParams, String token) {
	    try {
	        HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(MediaType.APPLICATION_JSON);
	        headers.set("Authorization", "Bearer " + token);

	        String url = PgFinderConstants.CREATE_PG;

	        // ❌ Don't convert to String manually
	        HttpEntity<Map<String,Object>> requestEntity = new HttpEntity<>(requestParams, headers);
	        System.out.println("requestEntity createPropertyService: " + requestEntity);

	        ResponseEntity<Map> responseEntity =
	                restTemplate.exchange(url, HttpMethod.POST, requestEntity, Map.class);
	        System.out.println("responseEntity createPropertyService: " + responseEntity);
	        
            if (responseEntity.getStatusCode().is2xxSuccessful()) {
                return convertMapToObject1(responseEntity.getBody());
            }

	        return new APIResponse();
	    } catch (Exception e) {
	        e.printStackTrace();
	        return new APIResponse();
	    }
	}



	
	
//	public static APIResponse paymentAction(Map<String, Object> fetchAPIRequest) {
//		HttpHeaders headers = new HttpHeaders();
//		headers.setContentType(MediaType.APPLICATION_JSON);
//		
//		String url = PgFinderConstants.ADMIN_PANEL_PAYMENT_ACTION; System.out.println("URL : "+url);
//		HttpEntity<Object> requestEntity = new HttpEntity<>(fetchAPIRequest, headers); System.out.println("Request : "+requestEntity);
//		ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.POST, requestEntity, Map.class);
//		
//		HttpStatus statusCode = (HttpStatus) responseEntity.getStatusCode(); System.out.println("Response status: "+statusCode);
//		APIResponse response = convertMapToObject(responseEntity.getBody()); System.out.println("Response Body : "+response);
//		HttpHeaders responseHeaders = responseEntity.getHeaders(); // System.out.println("Response Headers : "+responseHeaders);
//		
//		return response;
//	}
	
	// Utility Method for converting the Linked Hash Map to API Response Object
	public static APIResponse convertMapToObject1(Map<String, Object> inputMap) {
	    APIResponse response = new APIResponse();
	    try {
	        // Convert "status" string to boolean success
	        String status = inputMap.get("status") == null ? "" : inputMap.get("status").toString();
	        response.setSuccess("success".equalsIgnoreCase(status));

	        response.setMessage(inputMap.get("message") == null ? "" : inputMap.get("message").toString());
	        response.setData(inputMap.get("result"));
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return response;
	}

	
/*	public static APIResponse convertMapToObject(Map<String, Object> inputMap) {
	    APIResponse response = new APIResponse();
	    try {
	        String status = inputMap.get("status") == null ? "" : inputMap.get("status").toString();
	        response.setSuccess("success".equalsIgnoreCase(status));
	        response.setMessage(inputMap.get("message") == null ? "" : inputMap.get("message").toString());	        
	        response.setData(inputMap.get("result"));

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.setSuccess(false);
	        response.setMessage("Error while processing the response");
	        response.setData(null);
	    }
	    return response;
	}*/
	
	public static APIResponse convertMapToObject(Map<String, Object> inputMap) {
	    APIResponse response = new APIResponse();
	    try {
	        // Fix: get "success" boolean directly
	        Object successObj = inputMap.get("success");
	        response.setSuccess(successObj != null && Boolean.parseBoolean(successObj.toString()));

	        // Fix: get message from "message"
	        response.setMessage(inputMap.get("message") == null ? "" : inputMap.get("message").toString());

	        // Fix: get "data" instead of "result"
	        response.setData(inputMap.get("data"));

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.setSuccess(false);
	        response.setMessage("Error while processing the response");
	        response.setData(null);
	    }
	    return response;
	}


}