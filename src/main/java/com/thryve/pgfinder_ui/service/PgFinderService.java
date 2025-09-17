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
import com.thryve.pgfinder_ui.model.FetchAPIRequest;

@Service
public class PgFinderService {
	
	private static RestTemplate restTemplate = new RestTemplate();
		
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

	public static APIResponse createProperty(Map<String, Object> requestParams, String token) {
	    try {
	        HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(MediaType.APPLICATION_JSON);
	        headers.set("Authorization", "Bearer " + token);

	        String url = PgFinderConstants.CREATE_PG;

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

	public static APIResponse getAllPG(FetchAPIRequest fetchAPIRequest, String token) {
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);
	    headers.set("Authorization", "Bearer " + token);

	    String url = PgFinderConstants.GET_ALL_PG;
	    System.out.println("URL : " + url);

	    HttpEntity<Object> requestEntity = new HttpEntity<>(fetchAPIRequest, headers);
	    System.out.println("Request : " + requestEntity);

	    try {
	        ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.POST, requestEntity, Map.class);

	        HttpStatus statusCode = (HttpStatus) responseEntity.getStatusCode();
	        System.out.println("Response status: " + statusCode);

	        APIResponse response = convertMapToObject1(responseEntity.getBody());
	        System.out.println("Response Body : " + response);

	        return response;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return new APIResponse();
	    }
	}

	
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

	public static APIResponse convertMapToObject(Map<String, Object> inputMap) {
	    APIResponse response = new APIResponse();
	    try {
	        Object successObj = inputMap.get("success");
	        response.setSuccess(successObj != null && Boolean.parseBoolean(successObj.toString()));
	        response.setMessage(inputMap.get("message") == null ? "" : inputMap.get("message").toString());
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