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
                            
                            <c:set var="amenitiesStr" value="" />
							<c:forEach var="a" items="${pg.amenities}" varStatus="loop">
							    <c:set var="amenitiesStr" value="${amenitiesStr}${a}${!loop.last ? ', ' : ''}" />
							</c:forEach>
                            
                                <tr>
                                    <td>${index.index + 1}</td>
                                    <td>${pg.name}</td>
                                    <td>${pg.shortDescription}</td>
                                    <td><span class="badge bg-primary">${pg.pgType}</span></td>
                                    <td>${pg.address.city}</td>
                                    <td><fmt:formatNumber value="${pg.basePrice}" type="currency"/></td>
                                    <td>${pg.address.line1}, ${pg.address.line2}, ${pg.address.city}, ${pg.address.state}, ${pg.address.country} - ${pg.address.postalCode}</td>
                                    
						             <td>
						                <button type="button"
						                        class="btn btn-sm btn-primary view-details-btn"
						                        data-bs-toggle="modal"
						                        data-bs-target="#viewDetailsModal"
						                        data-pgname="${pg.name}"
						                        data-description="${pg.shortDescription}"
						                        data-pgtype="${pg.pgType}"
						                        data-baseprice="${pg.basePrice}"
						                        data-availability="${pg.availabilityStatus}"
						                        data-address="${pg.address.line1}, ${pg.address.line2}, ${pg.address.city}, ${pg.address.state}, ${pg.address.country} - ${pg.address.postalCode}"
						                        data-latitude="${pg.geoLocation.latitude}"
						                        data-longitude="${pg.geoLocation.longitude}"
						                        data-placeid="${pg.geoLocation.placeId}"
						                        data-amenities="${amenitiesStr}"
						                        data-rating="${pg.avgRating != null ? pg.avgRating : 'N/A'}"
						                        data-reviews="${pg.reviewCount}"
						                        data-verified="${pg.verified}">
						                    <i class="bi bi-eye"></i> View
						                </button>
						            </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

				<!-- Modal -->
				<div class="modal fade" id="viewDetailsModal" tabindex="-1" aria-labelledby="viewDetailsModalLabel" aria-hidden="true">
				    <div class="modal-dialog modal-xl">
				        <div class="modal-content">
				            <div class="modal-header bg-primary text-white">
				                <h5 class="modal-title" id="viewDetailsModalLabel">PG Details</h5>
				                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
				            </div>
				            <div class="modal-body">
				                <div class="row">
				                    <div class="col-md-6">
				                        <p><strong>Name:</strong> <span id="modalPgName">-</span></p>
				                        <p><strong>Description:</strong> <span id="modalDescription">-</span></p>
				                        <p><strong>PG Type:</strong> <span id="modalPgType">-</span></p>
				                        <p><strong>Base Price:</strong> ₹<span id="modalBasePrice">-</span></p>
				                        <p><strong>Availability:</strong> <span id="modalAvailability">-</span></p>
				                        <p><strong>Verified:</strong> <span id="modalVerified">-</span></p>
				                    </div>
				                    <div class="col-md-6">
				                        <p><strong>Full Address:</strong> <span id="modalAddress">-</span></p>
				                        <p><strong>Latitude:</strong> <span id="modalLatitude">-</span></p>
				                        <p><strong>Longitude:</strong> <span id="modalLongitude">-</span></p>
				                        <p><strong>Place ID:</strong> <span id="modalPlaceId">-</span></p>
				                    </div>
				                </div>
				                <hr>
				                <div>
				                    <p><strong>Amenities:</strong> <span id="modalAmenities">-</span></p>
				                    <p><strong>Rating:</strong> <span id="modalRating">-</span> ⭐</p>
				                    <p><strong>Total Reviews:</strong> <span id="modalReviews">-</span></p>
				                </div>
				            </div>
				            <div class="modal-footer">
				                <button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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
                        <div class="show-info">Showing <span id="from">1</span> to <span id="to">10</span> of ${fetchUsersResult.totalElements} items</div>
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
