<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <!-- PG listings will be dynamically populated here -->
        </div>

        <!-- No Results Message -->
        <div class="no-results" id="noResults" style="display: none;">
            <i class="fas fa-home"></i>
            <div>No PGs found matching your criteria</div>
            <div style="font-size: 0.9rem; margin-top: 10px;">Try adjusting your filters or search terms</div>
        </div>
    </div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/fetchPG.js"></script>
</body>
</html>