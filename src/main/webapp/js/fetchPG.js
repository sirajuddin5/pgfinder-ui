$(document).ready(function () {

	$('#viewDetailsModal').on('show.bs.modal', function (event) {
	    var button = $(event.relatedTarget); // Button that triggered the modal

	    // Extract info from data-* attributes
	    var pgName = button.data('pgname');
	    var description = button.data('description');
	    var pgType = button.data('gender');
	    var basePrice = button.data('baseprice');
	    var availability = button.data('availability');
	    var verified = button.data('verified');
	    var address = button.data('address');
	    var latitude = button.data('latitude');
	    var longitude = button.data('longitude');
	    var placeId = button.data('placeid');
	    var amenities = button.data('amenities');
	    var rating = button.data('rating');
	    var reviews = button.data('reviews');

	    // Update the modal content
	    $('#modalPgName').text(pgName || '-');
	    $('#modalDescription').text(description || '-');
	    $('#modalPgType').text(pgType || '-');
	    $('#modalBasePrice').text(basePrice || '-');
	    $('#modalAvailability').text(availability || '-');
	    $('#modalVerified').text(verified ? 'Yes' : 'No');
	    $('#modalAddress').text(address || '-');
	    $('#modalLatitude').text(latitude || '-');
	    $('#modalLongitude').text(longitude || '-');
	    $('#modalPlaceId').text(placeId || '-');
	    $('#modalAmenities').text(amenities || '-');
	    $('#modalRating').text(rating || '-');
	    $('#modalReviews').text(reviews || '0');
	});


    // Your existing filterAndSortPGs function here
    $('#searchInput, #locationFilter, #rentFilter, #genderFilter, #amenityFilter, #sortBy').on('input change', function () {
        filterAndSortPGs();
    });

    filterAndSortPGs();

});

function filterAndSortPGs() {
    var searchTerm = $('#searchInput').val().toLowerCase().trim();
    var locationFilter = $('#locationFilter').val().toLowerCase();
    var rentFilter = parseInt($('#rentFilter').val()) || null;
    var genderFilter = $('#genderFilter').val().toLowerCase();
    var amenityFilter = $('#amenityFilter').val().toLowerCase();
    var sortBy = $('#sortBy').val();

    var visibleCount = 0;

    $('.pg-card').each(function () {
        var $card = $(this);

        var name = $card.find('.pg-title').text().toLowerCase();
        var location = $card.find('.pg-location').text().toLowerCase();
        var rentText = $card.find('.pg-rent').text().replace(/[^\d]/g, '');
        var rent = parseInt(rentText) || 0;
        var gender = ($card.data('gender') || '').toLowerCase();
        var amenities = [];

        $card.find('.amenity-tag').each(function () {
            amenities.push($(this).text().toLowerCase());
        });

        var matchesSearch = !searchTerm || name.includes(searchTerm) || location.includes(searchTerm);
        var matchesLocation = !locationFilter || location.includes(locationFilter);
        var matchesRent = !rentFilter || rent <= rentFilter;
        var matchesGender = !genderFilter || gender === genderFilter || gender === 'unisex';
        var matchesAmenity = !amenityFilter || amenities.includes(amenityFilter);

        if (matchesSearch && matchesLocation && matchesRent && matchesGender && matchesAmenity) {
            $card.show();
            visibleCount++;
        } else {
            $card.hide();
        }
    });

    sortCards(sortBy);

    $('#resultsCount').text(`Showing ${visibleCount} PG${visibleCount === 1 ? '' : 's'}`);

    if (visibleCount === 0) {
        $('#noResults').show();
    } else {
        $('#noResults').hide();
    }
}

function sortCards(sortBy) {
    var $container = $('#pgListings');
    var $cards = $container.find('.pg-card:visible');

    $cards.sort(function (a, b) {
        var $a = $(a), $b = $(b);

        var rentA = parseInt($a.find('.pg-rent').text().replace(/[^\d]/g, '')) || 0;
        var rentB = parseInt($b.find('.pg-rent').text().replace(/[^\d]/g, '')) || 0;

        var ratingA = parseFloat($a.find('.pg-rating span:last').text()) || 0;
        var ratingB = parseFloat($b.find('.pg-rating span:last').text()) || 0;

        switch (sortBy) {
            case 'rent-low':
                return rentA - rentB;
            case 'rent-high':
                return rentB - rentA;
            case 'rating':
                return ratingB - ratingA;
            case 'newest':
                return 0; // Assuming no date info
            default:
                return 0;
        }
    });

    $cards.detach().appendTo($container);
}
