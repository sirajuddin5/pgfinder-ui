package com.thryve.pgfinder_ui.constants;

public interface PgFinderConstants {

	  
    public static final String BASE_API_URL = "http://localhost:8080/api/";
    public static final String BASE_V1_URL = "http://localhost:8080/v1/";

  
    public static final String REGISTER = BASE_API_URL + "auth/register";
    public static final String LOGIN = BASE_API_URL + "auth/login";

   
    public static final String CREATE_PG = BASE_V1_URL + "user/create-pg";
    public static final String UPDATE_PG = BASE_V1_URL + "user/update-pg/";
    public static final String UPDATE_ROOM = BASE_V1_URL + "user/update-room/";
    public static final String DELETE_PG = BASE_V1_URL + "user/delete-pg/";
    public static final String DELETE_ROOM = BASE_V1_URL + "user/delete-room/";
    public static final String GET_ALL_PG = BASE_V1_URL + "user/getAll-pg";
    public static final String GET_PG_BY_ID = BASE_V1_URL + "user/get-pg/";

    public static final String ADD_ROOMS_TO_PG = BASE_V1_URL + "user/addRooms-pg/";

   
    public static final String GET_TENANT = BASE_API_URL + "me/tenant";
    public static final String GET_OWNER = BASE_API_URL + "me/owner";
    public static final String GET_ADMIN = BASE_API_URL + "me/admin";
    
    public static final String CLOUDINARY_URL="cloudinary://612669937538196:Sf8knqmyr5bQPADe6DPdiuaYfbE@dxpulmw2r";

}