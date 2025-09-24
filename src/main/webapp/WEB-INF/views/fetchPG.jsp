<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>PG Finder - Find Your Perfect Stay</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="css/fetchPG.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <div class="container">
<!-- Header -->
        <div class="header">
            <div class="logo">PG Finder</div>
            <div class="tagline">Find your perfect paying guest accommodation</div>
        </div>

        <!-- Search and Filters Section -->
        <div class="search-section">
            <div class="search-bar">
                <input type="text" class="search-input" id="searchInput" placeholder="Search by location, PG name, or area...">
                <button class="search-btn" onclick="performSearch()">
                    <i class="fas fa-search"></i> Search
                </button>
            </div>

            <div class="filters">
                <div class="filter-group">
                    <label class="filter-label">Location</label>
                    <select class="filter-select" id="locationFilter">
                        <option value="">All Locations</option>
                        <option value="Bangalore">Bangalore</option>
                        <option value="Delhi">Delhi</option>
                        <option value="Gurugram">Gurugram</option>
                        <option value="Mumbai">Mumbai</option>
                        <option value="Chennai">Chennai</option>
                        <option value="electronicCity">NOIDA Electronic City</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label class="filter-label">Max Rent</label>
                    <select class="filter-select" id="rentFilter">
                        <option value="">Any Budget</option>
                        <option value="8000">Under ₹8,000</option>
                        <option value="12000">Under ₹12,000</option>
                        <option value="15000">Under ₹15,000</option>
                        <option value="20000">Under ₹20,000</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label class="filter-label">Gender</label>
                    <select class="filter-select" id="genderFilter">
                        <option value="ANY">Any</option>
                        <option value="MALE_ONLY">Male</option>
                        <option value="FEMALE_ONLY">Female</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label class="filter-label">Amenities</label>
                    <select class="filter-select" id="amenityFilter">
                        <option value="">All Amenities</option>
                        <option value="wifi">WiFi</option>
                        <option value="ac">AC</option>
                        <option value="food">Food Included</option>
                        <option value="parking">Parking</option>
                        <option value="laundry">Laundry</option>
                    </select>
                </div>
            </div>

            <div class="sort-section">
                <div class="results-count" id="resultsCount">Showing 12 PGs</div>
                <div class="sort-controls">
                    <label class="filter-label">Sort by:</label>
                    <select class="filter-select" id="sortBy">
                        <option value="relevance">Relevance</option>
                        <option value="rent-low">Rent: Low to High</option>
                        <option value="rent-high">Rent: High to Low</option>
                        <option value="rating">Highest Rated</option>
                        <option value="newest">Newest First</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- Loading Indicator -->
        <div class="loading" id="loading" style="display:none;">
            <div class="spinner"></div>
            <div>Searching for PGs...</div>
        </div>

        <!-- PG Listings -->
        <div class="pg-listings" id="pgListings">
            <c:choose>
                <c:when test="${not empty fetchUsersDataContentList}">
                    <c:forEach var="pg" items="${fetchUsersDataContentList}">
                        <div class="pg-card" data-gender="${pg.pgType}">
                            <div class="pg-image">🏠</div>
                            <div class="pg-content">
                                <div class="pg-title">${pg.name}</div>
                                <div class="pg-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <c:out value="${pg.address.line2}, ${pg.address.city}" />
                                </div>
                                <div class="pg-rent">₹<fmt:formatNumber value="${pg.basePrice}" type="number" groupingUsed="true" />/month</div>
                                <div class="pg-rating">
                                    <span class="stars">
                                        <c:choose>
                                            <c:when test="${not empty pg.avgRating}">
                                                <c:set var="fullStars" value="${fn:substringBefore(pg.avgRating, '.')}"/>
                                                <c:forEach var="i" begin="1" end="${fullStars}">
                                                    <i class="fas fa-star"></i>
                                                </c:forEach>
                                                <c:if test="${fn:contains(pg.avgRating, '.')}">
                                                    <i class="fas fa-star-half-alt"></i>
                                                </c:if>
                                                <c:set var="emptyStars" value="${5 - fullStars - (fn:contains(pg.avgRating, '.') ? 1 : 0)}"/>
                                                <c:forEach var="i" begin="1" end="${emptyStars}">
                                                    <i class="far fa-star"></i>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <span>No Ratings</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <span><c:out value="${pg.avgRating != null ? pg.avgRating : 'N/A'}"/></span>
                                </div>
                                <%-- <div class="pg-amenities">
                                    <c:forEach var="amenity" items="${pg.amenities}">
                                        <span class="amenity-tag">${amenity}</span>
                                    </c:forEach>
                                </div> --%>
                                
                                <button type="button" class="view-btn btn btn-primary"
								        data-bs-toggle="modal"
								        data-bs-target="#viewDetailsModal"
								        data-id="${pg.id}"
								        data-pgname="${pg.name}"
								        data-description="${pg.shortDescription}"
								        data-gender="${pg.pgType}"
								        data-city="${pg.address.city}"
								        data-baseprice="${pg.basePrice}"
								        data-availability="${pg.availabilityStatus}"
								        data-verified="${pg.verified}"
								        data-address="${pg.address.line1}, ${pg.address.line2}, ${pg.address.city}, ${pg.address.state}, ${pg.address.country}, ${pg.address.postalCode}"
								        data-latitude="${pg.geoLocation.latitude}"
								        data-longitude="${pg.geoLocation.longitude}"
								        data-placeid="${pg.geoLocation.placeId}"
								        data-amenities="<c:forEach var='a' items='${pg.amenities}'>${a}, </c:forEach>"
								        data-rating="${pg.avgRating != null ? pg.avgRating : 'N/A'}"
								        data-reviews="${pg.reviewCount}">
								    View Details
								</button>

                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-results" id="noResults">
                        <i class="fas fa-home"></i>
                        <div>No PGs found matching your criteria</div>
                        <div style="font-size: 0.9rem; margin-top: 10px;">Try adjusting your filters or search terms</div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- View Details Modal (same as pgList) -->
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

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/fetchPG.js"></script>
</body>
</html>
