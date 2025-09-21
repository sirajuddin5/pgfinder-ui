/*
        $(document).ready(function() {
			const pgData = [
			        {
			            id: 1,
			            name: "Green Valley PG",
			            location: "koramangala",
			            locationDisplay: "Koramangala, Bangalore",
			            rent: 12000,
			            rating: 4.5,
			            amenities: ["wifi", "food", "ac", "laundry"],
			            gender: "unisex",
			            image: "🏠",
			            description: "Modern PG with all facilities"
			        },
			        {
			            id: 2,
			            name: "Royal Comfort PG",
			            location: "btm-layout",
			            locationDisplay: "BTM Layout, Bangalore",
			            rent: 8500,
			            rating: 4.2,
			            amenities: ["wifi", "food", "parking"],
			            gender: "male",
			            image: "🏢",
			            description: "Budget-friendly PG for working professionals"
			        },
			        {
			            id: 3,
			            name: "Elite Stay",
			            location: "whitefield",
			            locationDisplay: "Whitefield, Bangalore",
			            rent: 15000,
			            rating: 4.8,
			            amenities: ["wifi", "ac", "food", "parking", "laundry"],
			            gender: "female",
			            image: "🏘️",
			            description: "Premium PG with luxury amenities"
			        },
			        {
			            id: 4,
			            name: "Tech Hub PG",
			            location: "marathahalli",
			            locationDisplay: "Marathahalli, Bangalore",
			            rent: 10000,
			            rating: 4.3,
			            amenities: ["wifi", "food", "parking"],
			            gender: "male",
			            image: "🏙️",
			            description: "Perfect for IT professionals"
			        },
			        {
			            id: 5,
			            name: "Cozy Corner",
			            location: "hsr-layout",
			            locationDisplay: "HSR Layout, Bangalore",
			            rent: 11500,
			            rating: 4.6,
			            amenities: ["wifi", "ac", "food"],
			            gender: "female",
			            image: "🏡",
			            description: "Homely atmosphere with great food"
			        },
			        {
			            id: 6,
			            name: "Metro PG",
			            location: "electronic-city",
			            locationDisplay: "Electronic City, Bangalore",
			            rent: 9000,
			            rating: 4.1,
			            amenities: ["wifi", "food", "laundry"],
			            gender: "unisex",
			            image: "🌆",
			            description: "Close to metro station"
			        },
			        {
			            id: 7,
			            name: "Sunshine Residency",
			            location: "koramangala",
			            locationDisplay: "Koramangala, Bangalore",
			            rent: 13500,
			            rating: 4.4,
			            amenities: ["wifi", "ac", "parking", "laundry"],
			            gender: "female",
			            image: "☀️",
			            description: "Bright and spacious rooms"
			        },
			        {
			            id: 8,
			            name: "Urban Nest",
			            location: "btm-layout",
			            locationDisplay: "BTM Layout, Bangalore",
			            rent: 7500,
			            rating: 4.0,
			            amenities: ["wifi", "food"],
			            gender: "male",
			            image: "🏠",
			            description: "Affordable accommodation"
			        },
			        {
			            id: 9,
			            name: "Prime Location PG",
			            location: "whitefield",
			            locationDisplay: "Whitefield, Bangalore",
			            rent: 16000,
			            rating: 4.7,
			            amenities: ["wifi", "ac", "food", "parking", "laundry"],
			            gender: "unisex",
			            image: "🏢",
			            description: "Premium location with all amenities"
			        },
			        {
			            id: 10,
			            name: "Student Haven",
			            location: "marathahalli",
			            locationDisplay: "Marathahalli, Bangalore",
			            rent: 8000,
			            rating: 4.2,
			            amenities: ["wifi", "food", "laundry"],
			            gender: "unisex",
			            image: "📚",
			            description: "Perfect for students and young professionals"
			        },
			        {
			            id: 11,
			            name: "Executive Stay",
			            location: "hsr-layout",
			            locationDisplay: "HSR Layout, Bangalore",
			            rent: 14000,
			            rating: 4.5,
			            amenities: ["wifi", "ac", "parking"],
			            gender: "male",
			            image: "💼",
			            description: "Executive rooms for professionals"
			        },
			        {
			            id: 12,
			            name: "Family PG",
			            location: "electronic-city",
			            locationDisplay: "Electronic City, Bangalore",
			            rent: 10500,
			            rating: 4.3,
			            amenities: ["wifi", "food", "ac", "laundry"],
			            gender: "female",
			            image: "👨‍👩‍👧‍👦",
			            description: "Family-like environment"
			        }
			    ];
				
				
				    let filteredData = [...pgData];

    $(document).ready(function () {
        displayPGs(pgData);
        addEventListeners();
    });

    function addEventListeners() {
        // Search input with debounce
        $('#searchInput').on('input', debounce(filterPGs, 300));

        // Filters and sort
        $('#locationFilter, #rentFilter, #genderFilter, #amenityFilter').on('change', filterPGs);
        $('#sortBy').on('change', sortPGs);

        // Enter key for search
        $('#searchInput').on('keypress', function (e) {
            if (e.key === 'Enter') {
                performSearch();
            }
        });
    }

    function performSearch() {
        showLoading();
        setTimeout(() => {
            filterPGs();
            hideLoading();
        }, 500);
    }

    function filterPGs() {
        var searchTerm = $('#searchInput').val().toLowerCase();
        var locationFilter = $('#locationFilter').val();
        var rentFilter = $('#rentFilter').val();
        var genderFilter = $('#genderFilter').val();
        var amenityFilter = $('#amenityFilter').val();

        filteredData = pgData.filter(pg => {
            var matchesSearch = !searchTerm || 
                pg.name.toLowerCase().includes(searchTerm) ||
                pg.locationDisplay.toLowerCase().includes(searchTerm) ||
                pg.description.toLowerCase().includes(searchTerm);

            var matchesLocation = !locationFilter || pg.location === locationFilter;
            var matchesRent = !rentFilter || pg.rent <= parseInt(rentFilter);
            var matchesGender = !genderFilter || pg.gender === genderFilter || pg.gender === 'unisex';
            var matchesAmenity = !amenityFilter || pg.amenities.includes(amenityFilter);

            return matchesSearch && matchesLocation && matchesRent && matchesGender && matchesAmenity;
        });

        sortPGs();
    }

    function sortPGs() {
        var sortBy = $('#sortBy').val();

        switch (sortBy) {
            case 'rent-low':
                filteredData.sort((a, b) => a.rent - b.rent);
                break;
            case 'rent-high':
                filteredData.sort((a, b) => b.rent - a.rent);
                break;
            case 'rating':
                filteredData.sort((a, b) => b.rating - a.rating);
                break;
            case 'newest':
                filteredData.sort((a, b) => b.id - a.id);
                break;
        }

        displayPGs(filteredData);
    }

    function displayPGs(pgs) {
        var $container = $('#pgListings');
        var $noResults = $('#noResults');
        var $resultsCount = $('#resultsCount');

        if (pgs.length === 0) {
            $container.hide();
            $noResults.show();
            $resultsCount.text('No PGs found');
            return;
        }

        $container.show().css('display', 'grid');
        $noResults.hide();
        $resultsCount.text(`Showing ${pgs.length} PG${pgs.length > 1 ? 's' : ''}`);

        var html = pgs.map(pg => `
            <div class="pg-card" data-aos="fade-up">
                <div class="pg-image">${pg.image}</div>
                <div class="pg-content">
                    <div class="pg-title">${pg.name}</div>
                    <div class="pg-location">
                        <i class="fas fa-map-marker-alt"></i> ${pg.locationDisplay}
                    </div>
                    <div class="pg-rent">₹${pg.rent.toLocaleString()}/month</div>
                    <div class="pg-rating">
                        <span class="stars">${generateStars(pg.rating)}</span>
                        <span>${pg.rating}</span>
                    </div>
                    <div class="pg-amenities">
                        ${pg.amenities.map(amenity => 
                            `<span class="amenity-tag">${getAmenityDisplay(amenity)}</span>`
                        ).join('')}
                    </div>
                    <button class="view-btn" onclick="viewPG(${pg.id})">View Details</button>
                </div>
            </div>
        `).join('');

        $container.html(html);
    }

    function generateStars(rating) {
        var fullStars = Math.floor(rating);
        var hasHalfStar = rating % 1 >= 0.5;
        let stars = '';

        for (let i = 0; i < fullStars; i++) {
            stars += '<i class="fas fa-star"></i>';
        }

        if (hasHalfStar) {
            stars += '<i class="fas fa-star-half-alt"></i>';
        }

        var emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
        for (let i = 0; i < emptyStars; i++) {
            stars += '<i class="far fa-star"></i>';
        }

        return stars;
    }

    function getAmenityDisplay(amenity) {
        var amenityMap = {
            'wifi': 'WiFi',
            'ac': 'AC',
            'food': 'Food',
            'parking': 'Parking',
            'laundry': 'Laundry'
        };
        return amenityMap[amenity] || amenity;
    }

    function viewPG(id) {
        alert(`Redirecting to PG details for ID: ${id}`);
        // window.location.href = `pg-details.jsp?id=${id}`;
    }

    function showLoading() {
        $('#loading').addClass('show');
        $('#pgListings').css('opacity', '0.5');
    }

    function hideLoading() {
        $('#loading').removeClass('show');
        $('#pgListings').css('opacity', '1');
    }

    function debounce(func, wait) {
        let timeout;
        return function () {
            var context = this, args = arguments;
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(context, args), wait);
        };
    }
	});*/
	

	$(document).ready(function () {
	    // Trigger filtering/sorting when any filter/search input changes
	    $('#searchInput, #locationFilter, #rentFilter, #genderFilter, #amenityFilter, #sortBy').on('input change', function () {
	        filterAndSortPGs();
	    });

	    // Run initially to show all PGs
	    filterAndSortPGs();
		
		
		$('#viewDetailsModal').on('show.bs.modal', function (event) {
		    
		    // Extract information from data attributes
		    var name = button.data('pgname');
		    var description = button.data('description');
		    var gender = button.data('gender');
		    var city = button.data('city');
		    var price = button.data('baseprice');
		    var address = button.data('address');
		    var amenities = button.data('amenities');
		    
		    // Populate the modal with the corresponding information
		    $('#modalPGName').text(name);
		    $('#modalDescription').text(description);
		    $('#modalGender').text(gender);
		    $('#modalCity').text(city);
		    $('#modalBasePrice').text("₹ " + price + " / month");
		    $('#modalAddress').text(address);
		    
		    // Display amenities list
		    var amenitiesList = amenities ? amenities.join(', ') : 'N/A'; 
		    $('#modalAmenities').text(amenitiesList);
		});


	});

	function filterAndSortPGs() {
	    let searchTerm = $('#searchInput').val().toLowerCase().trim();
	    let locationFilter = $('#locationFilter').val().toLowerCase();
	    let rentFilter = parseInt($('#rentFilter').val()) || null;
	    let genderFilter = $('#genderFilter').val().toLowerCase();
	    let amenityFilter = $('#amenityFilter').val().toLowerCase();
	    let sortBy = $('#sortBy').val();

	    let visibleCount = 0;

	    $('.pg-card').each(function () {
	        let $card = $(this);

	        // Get data from DOM
	        let name = $card.find('.pg-title').text().toLowerCase();
	        let location = $card.find('.pg-location').text().toLowerCase();
	        let rentText = $card.find('.pg-rent').text().replace(/[^\d]/g, ''); // remove ₹ and /month
	        let rent = parseInt(rentText) || 0;
	        let gender = ($card.data('gender') || '').toLowerCase(); // optional
	        let amenities = [];

	        $card.find('.amenity-tag').each(function () {
	            amenities.push($(this).text().toLowerCase());
	        });

	        // Matching logic
	        let matchesSearch = !searchTerm || name.includes(searchTerm) || location.includes(searchTerm);
	        let matchesLocation = !locationFilter || location.includes(locationFilter);
	        let matchesRent = !rentFilter || rent <= rentFilter;
	        let matchesGender = !genderFilter || gender === genderFilter || gender === 'unisex';
	        let matchesAmenity = !amenityFilter || amenities.includes(amenityFilter);

	        if (matchesSearch && matchesLocation && matchesRent && matchesGender && matchesAmenity) {
	            $card.show();
	            visibleCount++;
	        } else {
	            $card.hide();
	        }
	    });

	    // Sort visible cards
	    sortCards(sortBy);

	    // Update results count and no-results message
	    $('#resultsCount').text(`Showing ${visibleCount} PG${visibleCount === 1 ? '' : 's'}`);

	    if (visibleCount === 0) {
	        $('#noResults').show();
	    } else {
	        $('#noResults').hide();
	    }
	}

	function sortCards(sortBy) {
	    let $container = $('#pgListings');
	    let $cards = $container.find('.pg-card:visible');

	    $cards.sort(function (a, b) {
	        let $a = $(a), $b = $(b);

	        let rentA = parseInt($a.find('.pg-rent').text().replace(/[^\d]/g, '')) || 0;
	        let rentB = parseInt($b.find('.pg-rent').text().replace(/[^\d]/g, '')) || 0;

	        let ratingA = parseFloat($a.find('.pg-rating span:last').text()) || 0;
	        let ratingB = parseFloat($b.find('.pg-rating span:last').text()) || 0;

	        switch (sortBy) {
	            case 'rent-low':
	                return rentA - rentB;
	            case 'rent-high':
	                return rentB - rentA;
	            case 'rating':
	                return ratingB - ratingA;
	            case 'newest':
	                return 0; // Update if you have date/id-based logic
	            default:
	                return 0; // No sorting
	        }
	    });

	    // Re-append sorted cards to container
	    $cards.detach().appendTo($container);
	}

	function viewPG(pgId) {
	    // Redirect to viewPGDetails.jsp with query param
	    window.location.href = 'viewPGDetails?id=' + encodeURIComponent(pgId);
	}