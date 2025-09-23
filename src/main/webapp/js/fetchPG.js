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
    let searchTerm = $('#searchInput').val().toLowerCase().trim();
    let locationFilter = $('#locationFilter').val().toLowerCase();
    let rentFilter = parseInt($('#rentFilter').val()) || null;
    let genderFilter = $('#genderFilter').val().toLowerCase();
    let amenityFilter = $('#amenityFilter').val().toLowerCase();
    let sortBy = $('#sortBy').val();

    let visibleCount = 0;

    $('.pg-card').each(function () {
        let $card = $(this);

        let name = $card.find('.pg-title').text().toLowerCase();
        let location = $card.find('.pg-location').text().toLowerCase();
        let rentText = $card.find('.pg-rent').text().replace(/[^\d]/g, '');
        let rent = parseInt(rentText) || 0;
        let gender = ($card.data('gender') || '').toLowerCase();
        let amenities = [];

        $card.find('.amenity-tag').each(function () {
            amenities.push($(this).text().toLowerCase());
        });

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

    sortCards(sortBy);

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
                return 0; // Assuming no date info
            default:
                return 0;
        }
    });

    $cards.detach().appendTo($container);
}
