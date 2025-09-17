<%-- <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>PG Information</title>
    <jsp:include page="css.jsp" />
</head>

<body>
    <div id="pcoded" class="pcoded">
        <div class="pcoded-overlay-box"></div>
        <div class="pcoded-container navbar-wrapper">

            <div class="pcoded-main-container">
                <div class="pcoded-wrapper">
                    <div class="pcoded-content">
                        <div class="pcoded-inner-content">
                            <!-- Main-body start -->
                            <div class="main-body">
                                <div class="page-wrapper">
                                    <!-- Page-body start -->
                                    <div class="page-body">
                                        <div class="row">
                                            <!-- task, page, download counter  start -->
                                            <div class="col-xl-12 col-md-12">
                                                <div class="top-crete-box">
                                                    <p><img src="images/order-i.png" alt=""> PG Information</p>
                                                    <div class="top-head-file">
                                                        <button id="downloadExcel" class="info-download"><i class="bi bi-download"></i></button>
                                                        <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">Filter <i class="bi bi-search"></i></button>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- task, page, download counter  end -->

                                            <div class="col-xl-12 col-md-12">
                                                <div class="collapse" id="collapseExample">
                                                    <div class="card card-body">
                                                        <div class="info-court">
                                                            <h3>Search from Details</h3>
                                                            <form action="">
                                                                <div class="row">
                                                                    <div class="col-md-6">
                                                                        <label for="fname">Enrollment Number</label>
                                                                        <input type="text" id="enrollmentNo" class="fname" name="name" placeholder="Enrollment Number..">
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label for="fname">Counsel Name</label>
                                                                        <input type="text" id="counselNameValue" class="fname" name="counselname" placeholder="Counsel Name..">
                                                                    </div>

                                                                    <div class="col-md-6">
                                                                        <label for="fname" class="crete-form-down">Contact Number</label>
                                                                        <input type="number" id="contactNumberValue" class="fname" name="number" placeholder="Number..">
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label for="fname" class="crete-form-down">Email ID</label>
                                                                        <input type="text" id="emailIdValue" class="fname" name="Email" placeholder="Email-address..">
                                                                    </div>

                                                                    <div class="col-md-6">
                                                                        <div class="button-info-submite-left">
                                                                            <button type="button" id="searchInput" class="search-info"><i class="bi bi-search"></i> Search</button>
                                                                        </div>
                                                                    </div>

                                                                    <div id="loader" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
                                                                        background:rgba(0,0,0,0.5); z-index:9999; text-align:center;">
                                                                        <div style="position:relative; top:50%; transform:translateY(-50%);">
                                                                            <div class="spinner"></div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-6">
                                                                        <div class="button-info-submite-right">
                                                                            <button class="info-refresh"><i class="bi bi-arrow-clockwise"></i> Reset</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>

                                                <table id="pgTable" class="table table-striped table-bordered">
    <thead>
        <tr>
            <th>PG Name</th>
            <th>Short Description</th>
            <th>Description</th>
            <th>PG Type</th>
            <th>Owner ID</th>
            <th>Gender Preference</th>
            <th>Address</th>
            <th>Geo Location</th>
            <th>Base Price</th>
            <th>Amenities</th>
            <th>Rooms</th>
            <th>Contact Email</th>
            <th>Contact Phone</th>
            <th>Tags</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="pg" items="${pgList}">
            <tr>
                <td>${pg.name}</td>
                <td>${pg.shortDescription}</td>
                <td>${pg.description}</td>
                <td>${pg.pgType}</td>
                <td>${pg.ownerId}</td>
                <td>${pg.genderPreference}</td>
                <td>
                    ${pg.address.line1}, ${pg.address.line2}, 
                    ${pg.address.city}, ${pg.address.state}, 
                    ${pg.address.country} - ${pg.address.postalCode}
                </td>
                <td>
                    Lat: ${pg.geoLocation.latitude}, 
                    Lng: ${pg.geoLocation.longitude}, 
                    PlaceId: ${pg.geoLocation.placeId}
                </td>
                <td>${pg.basePrice}</td>
                <td>
                    <c:forEach var="amenity" items="${pg.amenities}">
                        <span class="badge badge-info">${amenity}</span>
                    </c:forEach>
                </td>
                <td>
                    <c:forEach var="room" items="${pg.rooms}">
                        <div style="margin-bottom:8px; border-bottom:1px solid #ccc; padding:5px;">
                            <b>${room.title}</b> (${room.roomType})<br/>
                            Capacity: ${room.capacity}<br/>
                            Price: ${room.price}<br/>
                            Available Units: ${room.availableUnits}<br/>
                            Desc: ${room.description}<br/>
                            Amenities: 
                            <c:forEach var="ra" items="${room.amenities}">
                                <span class="badge badge-secondary">${ra}</span>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </td>
                <td>${pg.contactEmail}</td>
                <td>${pg.contactPhone}</td>
                <td>
                    <c:forEach var="tag" items="${pg.tags}">
                        <span class="badge badge-success">${tag}</span>
                    </c:forEach>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>


                                                <!-- Modal -->
                                                <div class="modal fade" id="viewDetailsModal" tabindex="-1" role="dialog" aria-labelledby="viewDetailsModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">

                                                            <div class="modal-header">
                                                                <h5 class="modal-title">Counsel Details</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>

                                                            <div class="modal-body">
                                                                <table class="table table-bordered">
                                                                    <tr><th>Sr No.</th><td id="modalSrNo"></td></tr>
                                                                    <tr><th>Enrollment Number</th><td id="modalEnrollment"></td></tr>
                                                                    <tr><th>Email ID</th><td id="modalEmail"></td></tr>
                                                                    <tr><th>Counsel Name</th><td id="modalCounselName"></td></tr>
                                                                    <tr><th>Contact Number</th><td id="modalContactNumber"></td></tr>
                                                                    <tr><th>Role Name</th><td id="modalRoleName"></td></tr>
                                                                    <tr><th>Firm Name</th><td id="modalFirmName"></td></tr>
                                                                    <tr><th>Firm Address</th><td id="modalFirmAddress"></td></tr>
                                                                    <tr><th>Chamber Number</th><td id="modalChamberNumber"></td></tr>
                                                                    <tr><th>Bar Council</th><td id="modalBarCouncil"></td></tr>
                                                                    <tr><th>Counsel Type</th><td id="modalCounselType"></td></tr>
                                                                    <tr><th>Practice Areas</th><td id="modalPracticeAreas"></td></tr>
                                                                    <tr><th>CourtType</th><td id="modalCourtType"></td></tr>
                                                                    <tr><th>About</th><td id="modalAbout"></td></tr>
                                                                    <tr><th>Enrollment Date</th><td id="modalEnrollmentDate"></td></tr>
                                                                </table>
                                                            </div>

                                                            <div class="modal-footer">
                                                                <button type="button" id="modalClose" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row info-pannel-cotrol">
                                                    <div class="col-md-4">
                                                        <div class="all-page-number">
                                                            <p>Items per page:</p>
                                                            <select id="pageSize" class="form-select form-select-lg" aria-label="Large select example">
                                                                <option>10</option>
                                                                <option>25</option>
                                                                <option>50</option>
                                                                <option>100</option>
                                                                <option value="10000">All</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div id="pageInfo" class="col-md-4">
                                                        <div class="show-info">Showing <span id="from">1</span> to <span id="to">10</span> of ${fetchUsersResult.totalElements} items</div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <nav aria-label="Page navigation example">
                                                            <ul class="pagination next-info">
                                                                <li id="first" class="page-item" <c:if test='${fetchUsersResult.first==true}'>disabled</c:if>>
                                                                    <a id="prevPage" class="page-link pre-col" href="#"><< Prev</a>
                                                                </li>
                                                                <li class="page-item active"><a id="currentPage" class="page-link" href="#">1</a></li>
                                                                <li id="last" class="page-item" <c:if test='${fetchUsersResult.last==true}'>disabled</c:if>>
                                                                    <a id="nextPage" class="page-link pre-col" href="#">Next >> </a>
                                                                </li>
                                                            </ul>
                                                        </nav>
                                                    </div>
                                                </div>

                                                <!-- ✅ Modal Alert Box -->
                                                <div id="alert" style="display:none; position: fixed; top: 30%; left: 50%; transform: translate(-50%, -50%);
                                                    background: white; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.3);
                                                    width: 300px; z-index: 9999; padding: 20px; text-align: center;">
                                                    <h4 class="modal-title" style="margin-bottom: 10px; color: #222;"></h4>
                                                    <p class="modal-body" style="margin-bottom: 20px;"></p>
                                                    <button class="close-modal" style="padding: 8px 16px; background-color: #007bff;
                                                        color: white; border: none; border-radius: 5px; cursor: pointer;">
                                                        OK
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Page-body end -->
                            </div>
                            <div id="styleSelector"> </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="javascript/counselInformation.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
</body>

</html>
 --%>
 
 
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>PG Information</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/dataTables.bootstrap5.min.css">
    
    <link rel="stylesheet" type="text/css" href="css/pgList.css">
    
</head>

<body>
    <div class="container-fluid py-4">
        <div class="row">
            <div class="col-12">
                <div class="top-crete-box">
                    <p><i class="bi bi-building"></i> PG Information</p>
                    <div class="top-head-file">
                        <button id="downloadExcel" class="info-download"><i class="bi bi-download"></i> Export Excel</button>
                        <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                            <i class="bi bi-funnel"></i> Filter
                        </button>
                    </div>
                </div>
            </div>

            <div class="col-12">
                <div class="collapse" id="collapseExample">
                    <div class="card card-body mb-4">
                        <div class="info-court">
                            <h3><i class="bi bi-search"></i> Search PG Details</h3>
                            <form id="searchForm">
                                <div class="row">
                                    <div class="col-md-6 col-lg-3">
                                        <label for="pgName">PG Name</label>
                                        <input type="text" id="pgName" class="form-control" name="pgName" placeholder="PG Name..">
                                    </div>
                                    <div class="col-md-6 col-lg-3">
                                        <label for="pgType">PG Type</label>
                                        <select id="pgType" class="form-select" name="pgType">
                                            <option value="">Select Type</option>
                                            <option value="Hostel">Hostel</option>
                                            <option value="Apartment">Apartment</option>
                                            <option value="Guest House">Guest House</option>
                                            <option value="Working Women">Working Women</option>
                                            <option value="Students">Students</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 col-lg-3">
                                        <label for="city">City</label>
                                        <input type="text" id="city" class="form-control" name="city" placeholder="City..">
                                    </div>
                                    <div class="col-md-6 col-lg-3">
                                        <label for="basePrice">Max Price</label>
                                        <input type="number" id="basePrice" class="form-control" name="basePrice" placeholder="Max Price..">
                                    </div>

                                    <div class="col-md-6 col-lg-3">
                                        <label for="genderPreference">Gender Preference</label>
                                        <select id="genderPreference" class="form-select" name="genderPreference">
                                            <option value="">Select Preference</option>
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                            <option value="Unisex">Unisex</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 col-lg-3">
                                        <label for="amenities">Amenities</label>
                                        <input type="text" id="amenities" class="form-control" name="amenities" placeholder="Amenities..">
                                    </div>
                                    <div class="col-md-6 col-lg-3">
                                        <label for="contactEmail">Contact Email</label>
                                        <input type="text" id="contactEmail" class="form-control" name="contactEmail" placeholder="Email..">
                                    </div>
                                    <div class="col-md-6 col-lg-3">
                                        <label for="contactPhone">Contact Phone</label>
                                        <input type="text" id="contactPhone" class="form-control" name="contactPhone" placeholder="Phone..">
                                    </div>

                                    <div class="col-12 mt-3">
                                        <div class="d-flex justify-content-between">
                                            <div class="button-info-submite-left">
                                                <button type="button" id="searchInput" class="btn search-info">
                                                    <i class="bi bi-search"></i> Search
                                                </button>
                                            </div>
                                            <div class="button-info-submite-right">
                                                <button type="reset" class="btn info-refresh">
                                                    <i class="bi bi-arrow-clockwise"></i> Reset
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table id="pgTable" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Serial No.</th>
                                <th>PG Name</th>
                                <th>Short Description</th>
                                <th>PG Type</th>
                                <th>City</th>
                                <th>Base Price</th>
                                <th>Address</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="pg" items="${fetchUsersResult.content}" varStatus="index">
                                <tr>
                                    <td>${index.index + 1}</td>
                                    <td>${pg.name}</td>
                                    <td>${pg.shortDescription}</td>
                                    <td><span class="badge bg-primary">${pg.pgType}</span></td>
                                    <td>${pg.address.city}</td>
                                    <td><fmt:formatNumber value="${pg.basePrice}" type="currency"/></td>
                                    <td>${pg.address.line1}${pg.address.line2}${pg.address.city}${pg.address.state}${pg.address.country}</td>
                                   <%--  <td>
                                        <button class="view-details-btn" data-pg-id="${pg.id}">
                                            <i class="bi bi-eye"></i> View
                                        </button>
                                    </td> --%>
                                    <td>
                                       <button type="button" class="view-details-btn" data-toggle="modal" data-target="#exampleModal"
                                           data-pgName="${pg.name}"
                                           data-shortDescription="${pg.shortDescription}"
                                           data-pgType="${pg.pgType}"
                                           data-city="${pg.address.city}"
                                           data-basePrice="${pg.basePrice}"
                                           data-address="${pg.address.line1}${pg.address.line2}${pg.address.city}${pg.address.state}${pg.address.country}">
                                           <i class="bi bi-eye"></i>View
                                       </button>
                                   </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- PG Details Modal -->
                <div class="modal fade" id="viewDetailsModal" tabindex="-1" aria-labelledby="viewDetailsModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="viewDetailsModalLabel">PG Details</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h5 id="modalPgName" class="text-primary mb-3"></h5>
                                        <p><strong>Description:</strong> <span id="modalDescription"></span></p>
                                        <p><strong>PG Type:</strong> <span id="modalPgType" class="badge bg-primary"></span></p>
                                        <p><strong>Gender Preference:</strong> <span id="modalGenderPreference" class="badge bg-info"></span></p>
                                        <p><strong>Base Price:</strong> <span id="modalBasePrice"></span></p>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="border-bottom pb-2">Address</h6>
                                        <p id="modalAddress"></p>
                                    </div>
                                </div>
                                
                                <div class="row mt-4">
                                    <div class="col-12">
                                        <h6 class="border-bottom pb-2">Amenities</h6>
                                        <div id="modalAmenities" class="d-flex flex-wrap gap-2 mb-4"></div>
                                        
                                        <h6 class="border-bottom pb-2">Tags</h6>
                                        <div id="modalTags" class="d-flex flex-wrap gap-2"></div>
                                    </div>
                                </div>
                                
                                <div class="row mt-4">
                                    <div class="col-12">
                                        <h6 class="border-bottom pb-2">Rooms</h6>
                                        <div id="modalRooms" class="accordion"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row info-pannel-cotrol">
                    <div class="col-md-4">
                        <div class="all-page-number d-flex align-items-center">
                            <p class="mb-0 me-2">Items per page:</p>
                            <select id="pageSize" class="form-select" style="width: auto;">
                                <option>10</option>
                                <option>25</option>
                                <option>50</option>
                                <option>100</option>
                                <option value="10000">All</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4 text-center">
                        <div class="show-info">Showing <span id="from">1</span> to <span id="to">10</span> of ${fn:length(pgList)} items</div>
                    </div>
                    <div class="col-md-4">
                        <nav aria-label="Page navigation">
                            <ul class="pagination next-info justify-content-end">
                                <li id="first" class="page-item">
                                    <a id="prevPage" class="page-link" href="#">&laquo; Prev</a>
                                </li>
                                <li class="page-item active"><a id="currentPage" class="page-link" href="#">1</a></li>
                                <li id="last" class="page-item">
                                    <a id="nextPage" class="page-link" href="#">Next &raquo;</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.5/js/dataTables.bootstrap5.min.js"></script>
    <!-- Excel Export -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

 <script src="js/pgList.js"></script>
</body>

</html>