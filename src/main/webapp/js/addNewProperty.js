/*$(document).ready(function () {
  let roomCount = 0;

  // Initialize form content
  function resetForm() {
    $('#addPropertyForm')[0].reset();
    $('#roomsContainer').empty();
    roomCount = 0;
    addRoom(); // Ensure at least 1 room
  }

  // Add a new room
  window.addRoom = function () {
    const roomHTML = `
      <div class="room-section">
        <div class="room-header">
          <h5 class="room-title">Room ${roomCount + 1}</h5>
          ${roomCount > 0 ? `
            <button type="button" class="remove-room-btn">
              <i class="fas fa-trash"></i> Remove
            </button>` : ''}
        </div>
        <div class="form-grid">
          <div class="form-group">
            <label>Room Title *</label>
            <input type="text" name="rooms[${roomCount}].title" required>
          </div>
          <div class="form-group">
            <label>Room Type *</label>
            <select name="rooms[${roomCount}].roomType" required>
              <option value="">Select Type</option>
              <option value="SINGLE">Single</option>
              <option value="DOUBLE">Double</option>
              <option value="TRIPLE">Triple</option>
              <option value="DORMITORY">Dormitory</option>
            </select>
          </div>
          <div class="form-group">
            <label>Capacity *</label>
            <input type="number" name="rooms[${roomCount}].capacity" min="1" required>
          </div>
          <div class="form-group">
            <label>Price (₹) *</label>
            <input type="number" name="rooms[${roomCount}].price" min="0" required>
          </div>
          <div class="form-group">
            <label>Available Units</label>
            <input type="number" name="rooms[${roomCount}].availableUnits" min="0" value="1">
          </div>
          <div class="form-group full-width">
            <label>Room Description</label>
            <textarea name="rooms[${roomCount}].description" rows="3"></textarea>
          </div>
        </div>
      </div>
    `;

    const $room = $(roomHTML);
    // Attach remove handler if needed
    $room.find('.remove-room-btn').on('click', function () {
      $room.remove();
    });

    $('#roomsContainer').append($room);
    roomCount += 1;
  };

  // Handle form submission
  $('#addPropertyForm').on('submit', function (event) {
    event.preventDefault();

    const formData = new FormData(this);
    const propertyData = {
      name: formData.get('name'),
      shortDescription: formData.get('shortDescription'),
      description: formData.get('description'),
      pgType: formData.get('pgType'),
      ownerId: 'owner123', // Customize as needed
      genderPreference: formData.get('genderPreference'),
      address: {
        line1: formData.get('address.line1'),
        line2: formData.get('address.line2'),
        city: formData.get('address.city'),
        state: formData.get('address.state'),
        country: formData.get('address.country'),
        postalCode: formData.get('address.postalCode')
      },
      geoLocation: {
        latitude: parseFloat(formData.get('geoLocation.latitude')) || 0,
        longitude: parseFloat(formData.get('geoLocation.longitude')) || 0,
        placeId: formData.get('geoLocation.placeId')
      },
      basePrice: parseFloat(formData.get('basePrice')),
      amenities: formData.getAll('amenities'),
      rooms: [],
      contactEmail: formData.get('contactEmail'),
      contactPhone: formData.get('contactPhone'),
      tags: formData.get('tags')
        ? formData.get('tags').split(',').map(tag => tag.trim())
        : []
    };

    // Collect rooms data
    $('.room-section').each(function () {
      const inputs = $(this).find('input, select, textarea');
      const room = {
        title: '',
        roomType: '',
        capacity: 1,
        price: 0,
        availableUnits: 0,
        description: ''
      };

      inputs.each(function () {
        const name = $(this).attr('name');
        const match = name.match(/rooms\[\d+\]\.(\w+)/);
        if (match) {
          const field = match[1];
          const val = $(this).val();
          room[field] =
            $(this).attr('type') === 'number'
              ? parseFloat(val) || 0
              : val.trim();
        }
      });

      if (room.title && room.roomType) {
        propertyData.rooms.push(room);
      }
    });

    console.log('Property Data:', JSON.stringify(propertyData, null, 2));
    alert('Property data collected! Check console for JSON output.');

    closeAddPropertyForm();
  });

  // Click outside modal to close
  $('#addPropertyModal').on('click', function (e) {
    if (e.target === this) {
      closeAddPropertyForm();
    }
  });

  // Initialize with one room
  resetForm();
});
*/


/*$(document).ready(function () {
    // Submit Property Button Click
    $('#submitProperty').click(function (e) {
        console.log("submitProperty Button Clicked");
        e.preventDefault();

        var inputParams = {};

        // Basic Info
        inputParams['name'] = $('#propertyName').val();
        inputParams['shortDescription'] = $('#shortDescription').val();
        inputParams['description'] = $('#description').val();
        inputParams['pgType'] = $('#pgType').val();
        inputParams['genderPreference'] = $('#genderPreference').val();
        inputParams['basePrice'] = parseFloat($('#basePrice').val());
        inputParams['ownerId'] = '5d058fff-aa28-4f0f-9d28-9c4041191c51';

        if (!inputParams.name || !inputParams.shortDescription || !inputParams.pgType || !inputParams.genderPreference) {
            showAlert('Error', 'Please fill all required fields.');
            return;
        }

        // Address
        inputParams['address'] = {
            'line1': $('#addressLine1').val(),
            'line2': $('#addressLine2').val(),
            'city': $('#city').val(),
            'state': $('#state').val(),
            'country': $('#country').val(),
            'postalCode': $('#postalCode').val()
        };

        // Geo Location
        inputParams['geoLocation'] = {
            'latitude': parseFloat($('#latitude').val()) || 0,
            'longitude': parseFloat($('#longitude').val()) || 0,
            'placeId': $('#placeId').val()
        };

        // Amenities
        inputParams['amenities'] = [];
        if ($('#amenity_ac').is(':checked')) inputParams['amenities'].push('AC');
        if ($('#amenity_wifi').is(':checked')) inputParams['amenities'].push('WIFI');
        if ($('#amenity_parking').is(':checked')) inputParams['amenities'].push('PARKING');
        if ($('#amenity_kitchen').is(':checked')) inputParams['amenities'].push('KITCHEN');
        if ($('#amenity_laundry').is(':checked')) inputParams['amenities'].push('LAUNDRY');
        if ($('#amenity_gym').is(':checked')) inputParams['amenities'].push('GYM');

        // Rooms
        inputParams['rooms'] = [{
            'title': $('#roomTitle').val(),
            'roomType': $('#roomType').val() || 'SINGLE',
            'capacity': parseInt($('#roomCapacity').val()) || 1,
            'price': parseFloat($('#roomPrice').val()) || 0,
            'availableUnits': parseInt($('#roomAvailableUnits').val()) || 0,
            'description': $('#roomDescription').val(),
            'amenities': []
        }];

        // Contact
        inputParams['contactEmail'] = $('#contactEmail').val();
        inputParams['contactPhone'] = $('#contactPhone').val();

        // Tags
        inputParams['tags'] = $('#tags').val().split(',').map(tag => tag.trim()).filter(tag => tag !== '');

        console.log('inputParams:', inputParams);
        $('#loader').show();

        // ✅ Step 1: Login first
        $.ajax({
            type: "POST",
            url: "../pgFinderRest/login",
            data: JSON.stringify({ usernameOrEmail: "admin", password: "admin123" }),
            contentType: 'application/json',
            success: function (response) {
                if (response.success) {
                    let token = response.data.tokenResponse;
                    localStorage.setItem("token", token);
                    console.log("✅ Saved Token:", token);

                    // ✅ Step 2: Create Property after login success
                    $.ajax({
                        type: "POST",
                        url: "../pgFinderRest/createProperty",
                        data: JSON.stringify(inputParams),
                        contentType: 'application/json',
                        headers: {
                            "Authorization": "Bearer " + token
                        },
                        success: function (resp) {
                            console.log("✅ Property Created:", resp);
                            if (resp.success) {
                                alert("Property created successfully!");
                            } else {
                                showAlert("Error", "Property creation failed: " + (resp.message || "Unknown error"));
                            }
                        },
                        error: function (err) {
                            console.error("❌ Create Property Failed:", err);
                            showAlert("Error", "Create property request failed");
                        }
                    });
                } else {
                    showAlert("Error", "Login failed!");
                }
            },
            error: function (err) {
                console.error("❌ Login Failed:", err);
                showAlert("Error", "Login request failed");
            }
        });

    });

    // Reset Button
    $('#reset').click(function (e) {
        e.preventDefault();
        resetForm();
    });
	
	function showAlert(status, message) {
	    $('.modal-title').text(status);
	    $('.modal-body').text(message);
	    $('#alert').css("display", "block");
	}


    // Close Modal
    $('.close-modal').click(function () {
        $('#alert').css("display", "none");
    });
});*/


/*$(document).ready(function() {
    $('#submitProperty').click(function(e) {
        console.log("Submit Button Clicked");
        e.preventDefault();

        var inputParams = {};

        // Static Data
        inputParams['name'] = 'Hilltop Retreat';
        inputParams['shortDescription'] = 'A cozy homestay amidst the hills of Himachal';
        inputParams['description'] = 'Hilltop Retreat offers a peaceful stay in the scenic hills of Shimla, perfect for nature lovers and adventure seekers. Enjoy the cool mountain air and breathtaking views right from your room.';
        inputParams['pgType'] = 'ENTIRE_PROPERTY';
        inputParams['genderPreference'] = 'ANY';
        inputParams['basePrice'] = 3500;
        inputParams['ownerId'] = '5d058fff-aa28-4f0f-9d28-9c4041191c51';

        // Address (Static)
        inputParams['address'] = {
            'line1': 'Himachal Pradesh Tourism Complex',
            'line2': 'Near Mall Road',
            'city': 'Shimla',
            'state': 'Himachal Pradesh',
            'country': 'India',
            'postalCode': '171001'
        };

        // Geo Location (Static)
        inputParams['geoLocation'] = {
            'latitude': 31.1048,
            'longitude': 77.1708,
            'placeId': 'ChIJ3WqfoBd6BjkR8mGeH2Hx0ws'
        };

        // Amenities (Static)
        inputParams['amenities'] = ['AC'];

        // Rooms (Static)
        inputParams['rooms'] = [{
            'title': 'Mountain View Room',
            'roomType': 'SINGLE',
            'capacity': 1,
            'price': 2500,
            'availableUnits': 3,
            'description': 'A charming room with a private balcony offering stunning views of the surrounding hills.',
            'amenities': ['AC']
        }, {
            'title': 'Family Room',
            'roomType': 'DOUBLE',
            'capacity': 4,
            'price': 5000,
            'availableUnits': 2,
            'description': 'A spacious room with two double beds, perfect for families, with large windows that let in natural light.',
            'amenities': ['AC']
        }];

        // Contact (Static)
        inputParams['contactEmail'] = 'hilltopretreat.shimla@example.com';
        inputParams['contactPhone'] = '9876543210';

        // Tags (Static)
        inputParams['tags'] = ['Nature Stay', 'Shimla Homestay', 'Mountain View', 'Pet Friendly'];

        console.log('inputParams : ' + JSON.stringify(inputParams));

        $('#loading').css("display", "block");
        var token = localStorage.getItem("token");
        console.log('token : ' + token);

        $.ajax({
            type: "POST",
            url: "../pgFinderRest/createProperty",
            data: JSON.stringify(inputParams),
            contentType: 'application/json',
            dataType: 'json',
            beforeSend: function () {
                $('#loader').show(); 
            },
            headers: {
                'Authorization': 'Bearer ' + token
            },
            success: function(response) {
                if (response.status == 'success') {
                    console.log('response : ' + JSON.stringify(response));
                    showAlert(response.status, response.message);
                } else {
                    showAlert(response.status, response.message);
                }
            },
            error: function (xhr, status, error) {
                console.error("Error:", error);
                showAlert('Error', 'Failed to register Counsel.');
            },
            complete: function () {
                $('#loader').hide();
            }
        });
    });

    $('.close-modal').click(function() {
        $('#alert').css("display", "none");
    });
});

function showAlert(status, message) {
    $('.modal-title').text(status);
    $('.modal-body').text(message);
    $('#alert').css("display", "block");
}*/

$(document).ready(function () {
    $('#submitProperty').click(function (e) {
        e.preventDefault();

        var token = $('#token').val();
        if (!token || token === "null") {
            alert("You must be logged in to create a property. Token is missing.");
            return;
        }

        var ownerId = $('#ownerId').val();
//"pgType": "ENTIRE_PROPERTY", "genderPreference": "ANY",  "amenities": ["AC"], "title": "Shared Room", "roomType": "SINGLE"---> Compulsory to create PG


        var inputParams = {};

        inputParams.name = $('#propertyName').val();
        inputParams.pgType = $('#pgType').val();
        inputParams.genderPreference = $('#genderPreference').val();
        inputParams.basePrice = Number($('#basePrice').val());
        inputParams.shortDescription = $('#shortDescription').val();
        inputParams.description = $('#description').val();
        inputParams.ownerId = $('#ownerId').val();

        inputParams.address = {
            line1: $('#addressLine1').val(),
            line2: $('#addressLine2').val(),
            city: $('#city').val(),
            state: $('#state').val(),
            country: $('#country').val(),
            postalCode: $('#postalCode').val()
        };

        // GeoLocation (ensure the latitude and longitude are within valid ranges)
        inputParams.geoLocation = {
            latitude: Math.min(90, Math.max(-90, parseFloat($('#latitude').val()))) || null,
            longitude: Math.min(180, Math.max(-180, parseFloat($('#longitude').val()))) || null,
            placeId: $('#placeId').val()
        };

        // Amenities (add only "AC" as per your example)
        inputParams.amenities = [];
        $('input[name="amenities"]:checked').each(function() {
            var amenity = $(this).val();
            if (amenity === "AC") {
                inputParams.amenities.push(amenity); // Only add AC
            }
        });

        // Rooms - iterate through room sections dynamically
        inputParams.rooms = [];
        $('#roomsContainer .room-section').each(function(index, element) {
            var room = {};
            room.title = $(element).find('input[name="rooms['+index+'].title"]').val();
            room.roomType = $(element).find('select[name="rooms['+index+'].roomType"]').val() || "SINGLE";  // Default to SINGLE if no value
            room.capacity = Number($(element).find('input[name="rooms['+index+'].capacity"]').val());
            room.price = Number($(element).find('input[name="rooms['+index+'].price"]').val());
            room.availableUnits = Number($(element).find('input[name="rooms['+index+'].availableUnits"]').val());
            room.description = $(element).find('textarea[name="rooms['+index+'].description"]').val();

            // Add the amenities for the room (if any selected)
            room.amenities = [];
            // Only add 'AC' to room's amenities
            if ($('input[name="amenities"]:checked').val() === "AC") {
                room.amenities.push("AC");
            }

            inputParams.rooms.push(room);
        });

        // Additional properties
        inputParams.contactEmail = $('#contactEmail').val();
        inputParams.contactPhone = $('#contactPhone').val();

        inputParams.tags = $('#tags').val() ? $('#tags').val().split(',').map(t => t.trim()) : [];

        // Log the final inputParams to verify the structure
        console.log('Input Parameters:', JSON.stringify(inputParams, null, 2));

        // Send the AJAX request to create the property
        $.ajax({
            type: "POST",
            url: "../pgFinderRest/createProperty",  // Ensure this URL is correct
            data: JSON.stringify(inputParams),
            contentType: 'application/json',
            dataType: 'json',
            beforeSend: function () {
                $('#loader').show();
            },
            headers: {
                'Authorization': 'Bearer ' + token
            },
            success: function (response) {
                // Log the response to check for issues
                console.log('Response:', response);

                if (response.success === true) {
                    showAlert('Success', response.message);
                } else {
                    showAlert('Error', response.message);
                }
            },
            error: function (xhr, status, error) {
                console.log('Error Response:', xhr.responseText);  // Log the error response from server
                showAlert('Error', 'Failed to create property.');
            },
            complete: function () {
                $('#loader').hide();
            }
        });
    });

    // Close modal alert
    $('.close-modal').click(function () {
        $('#alert').css("display", "none");
    });
});

// Function to show success/error modal alert
function showAlert(status, message) {
    $('.modal-title').text(status);
    $('.modal-body').text(message);
    $('#alert').css("display", "block");
}
