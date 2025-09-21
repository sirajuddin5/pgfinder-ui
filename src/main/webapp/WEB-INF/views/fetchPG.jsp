<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PG Finder - Find Your Perfect Stay</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/fetchPG.css">
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
                        <option value="koramangala">Koramangala</option>
                        <option value="btm-layout">BTM Layout</option>
                        <option value="whitefield">Whitefield</option>
                        <option value="marathahalli">Marathahalli</option>
                        <option value="hsr-layout">HSR Layout</option>
                        <option value="electronic-city">Electronic City</option>
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
                        <option value="">Any</option>
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                        <option value="unisex">Unisex</option>
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
        <div class="loading" id="loading">
            <div class="spinner"></div>
            <div>Searching for PGs...</div>
        </div>

        <!-- PG Listings -->
        <div class="pg-listings" id="pgListings">
            <c:choose>
                <c:when test="${not empty fetchUsersDataContentList}">
                    <c:forEach var="pg" items="${fetchUsersDataContentList}">
                        <!-- ✅ Added data-gender here -->
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
                                <div class="pg-amenities">
                                    <c:forEach var="amenity" items="${pg.amenities}">
                                        <span class="amenity-tag">${amenity}</span>
                                    </c:forEach>
                                </div>
                                <!-- ✅ View Details button -->
                                <%-- <button class="view-btn" onclick="viewPG('${pg.id}')">View Details</button> --%>
                                
<button type="button" class="view-btn" 
        data-toggle="modal" 
        data-target="#viewDetailsModal"
        data-pgname="${pg.name}"
        data-description="${pg.shortDescription}"
        data-gender="${pg.pgType}"
        data-city="${pg.address.city}"
        data-baseprice="${pg.basePrice}"
        data-address="${pg.address.line1}, ${pg.address.line2}, ${pg.address.city}, ${pg.address.state}, ${pg.address.country}"
       >
    View Details
</button>

<div class="modal fade" id="viewDetailsModal" tabindex="-1" role="dialog" aria-labelledby="viewDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">PG Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered">
                    <tr><th>PG Name</th><td id="modalPGName"></td></tr>
                    <tr><th>Description</th><td id="modalDescription"></td></tr>
                    <tr><th>Type (Gender)</th><td id="modalGender"></td></tr>
                    <tr><th>City</th><td id="modalCity"></td></tr>
                    <tr><th>Base Price</th><td id="modalBasePrice"></td></tr>
                    <tr><th>Address</th><td id="modalAddress"></td></tr>
                    <tr><th>Amenities</th><td id="modalAmenities"></td></tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


                                
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- ✅ Show this only if no data -->
                    <div class="no-results" id="noResults">
                        <i class="fas fa-home"></i>
                        <div>No PGs found matching your criteria</div>
                        <div style="font-size: 0.9rem; margin-top: 10px;">Try adjusting your filters or search terms</div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="js/fetchPG.js"></script>

</body>
</html>
