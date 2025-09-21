	$(document).ready(function () {
		/*$(document).on("click", ".view-details-btn", function () {
		    var pgName = $(this).data("pgname") || "-";
		    var description = $(this).data("description") || "-";
		    var pgType = $(this).data("pgtype") || "-";
		    var genderPreference = $(this).data("city") || "-"; // Assuming city as gender for demo
		    var basePrice = $(this).data("baseprice") || "-";
		    var address = $(this).data("address") || "-";

		    // Set modal content
		    $("#modalPgName").text(pgName);
		    $("#modalDescription").text(description);
		    $("#modalPgType").text(pgType);
		    $("#modalGenderPreference").text(genderPreference); // This should be actual gender in real use
		    $("#modalBasePrice").text(basePrice);
		    $("#modalAddress").text(address);
		});

		// Optional: Clear modal on close
		$('#viewDetailsModal').on('hidden.bs.modal', function () {
		    $("#modalPgName, #modalDescription, #modalPgType, #modalGenderPreference, #modalBasePrice, #modalAddress").text("-");
		});*/
		
		    $(".view-details-btn").click(function () {
		        // Get data attributes from button
		        var data = $(this).data();

		        $("#modalPgName").text(data.pgname || "-");
		        $("#modalDescription").text(data.description || "-");
		        $("#modalPgType").text(data.pgtype || "-");
		        $("#modalBasePrice").text(data.baseprice || "-");
		        $("#modalAvailability").text(data.availability || "-");
		        $("#modalVerified").text(data.verified ? "Yes" : "No");

		        $("#modalAddress").text(data.address || "-");
		        $("#modalLatitude").text(data.latitude || "-");
		        $("#modalLongitude").text(data.longitude || "-");
		        $("#modalPlaceId").text(data.placeid || "-");

		        $("#modalAmenities").text(data.amenities || "-");
		        $("#modalRating").text(data.rating || "N/A");
		        $("#modalReviews").text(data.reviews || "0");
		    });

		    // Reset modal on close
		    $('#viewDetailsModal').on('hidden.bs.modal', function () {
		        $('#viewDetailsModal span').text('-');
		    });

		$('#downloadExcel').click(function () {
			console.log("downloadExcel Clicked");
			var inputParams = {
			    name: state.name,
			    pgType: state.pgType,
			    shortDescription: state.shortDescription,
			    basePrice: state.basePrice,
			    city: state.city,
			    genderPreference: state.genderPreference,
			    amenities: state.amenities,
			    contactEmail: state.contactEmail,
			    contactPhone: state.contactPhone,
			    pageNumber: 0,
			    pageSize: 100000
			};

		    $.ajax({
		        url: '../adminPanelRest/getAllPGList',
		        method: 'POST',
		        data: JSON.stringify(inputParams),
		        contentType: 'application/json',
		        dataType: 'json',
		        beforeSend: function () {
		            $('#downloadExcel').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Downloading...');
		        },
		        success: function (response) {
					if (response.result && response.result.content) {
					    exportDataToExcel(response.result.content);
					} else {
					    showAlert('Error', 'No data available for export');
					}
		        },
		        error: function (xhr, status, error) {
		            console.error("Error fetching data for Excel:", error);
		            showAlert('Error', 'Failed to fetch data for Excel download');
		        },
		        complete: function () {
		            $('#downloadExcel').prop('disabled', false).html('<i class="fas fa-download"></i>');
		        }
		    });
		});

		// Helper to export to Excel
		function exportDataToExcel(dataList) {
		    var worksheetData = [];

		    // Header row
		    worksheetData.push([
				"Sr No.", "PG Name", "Description", "PG Type", "City",
				"Base Price", "Availability", "Verified", "Amenities",
				"Rating", "Reviews", "Address", "Latitude", "Longitude", "Place ID"
		    ]);

		    // Rows
		    $.each(dataList, function (index, item) {
		        worksheetData.push([
					index + 1,
					item.name || '',
					item.shortDescription || '',
					item.address.city || '',
					item.basePrice || 0,
					item.availabilityStatus || '',
					item.avgRating != null ? item.avgRating : "N/A",
					item.reviewCount || 0,
					`${item.address.line1 || ''} ${item.address.line2 || ''}, ${item.address.city || ''}, ${item.address.state || ''}, ${item.address.country || ''}`,
					item.geoLocation.latitude || '',
					item.geoLocation.longitude || '',
					item.geoLocation.placeId || ''
		        ]);
		    });

		    // SheetJS export
		    var worksheet = XLSX.utils.aoa_to_sheet(worksheetData);
		    var workbook = XLSX.utils.book_new();
		    XLSX.utils.book_append_sheet(workbook, worksheet, "Counsel Info");
		    XLSX.writeFile(workbook, "PG_List.xlsx");
		}

		/* -------------------- Search + Pagination -------------------- */
		var state = {
		    name: "",
		    pgType: "",
		    shortDescription: "",
		    basePrice: "",
		    city: "",
		    genderPreference: "",
		    amenities: "",
		    contactEmail: "",
		    contactPhone: "",
		    pageNumber: 0,
		    pageSize: 10
		};

	    $('#searchInput').click(function () {
			state.name = $('#pgName').val();
			state.pgType = $('#pgType').val();
			state.shortDescription = $('#shortDescription').val();
			state.basePrice = $('#basePrice').val();
			state.city = $('#city').val();
			state.genderPreference = $('#genderPreference').val();
			state.amenities = $('#amenities').val();
			state.contactEmail = $('#contactEmail').val();
			state.contactPhone = $('#contactPhone').val();
			state.pageNumber = 0;

	        var inputParams = {};
	        inputParams['name'] = state.name;
	        inputParams['pgType'] = state.pgType;
	        inputParams['shortDescription'] = state.shortDescription;
	        inputParams['basePrice'] = state.basePrice;
	        inputParams['pageNumber'] = state.pageNumber;
	        inputParams['pageSize'] = state.pageSize;

	        console.log('inputParams : ' + JSON.stringify(inputParams));
	        fetchData(inputParams);
	    });

	    $("#pageSize").change(function () {
	        console.log("Page size changed");

	        state.pageSize = $(this).val();
	        state.pageNumber = 0;
	        console.log(state);

	        var inputParams = {};
			inputParams['name'] = state.name;
			inputParams['pgType'] = state.pgType;
			inputParams['shortDescription'] = state.shortDescription;
			inputParams['basePrice'] = state.basePrice;
			inputParams['pageNumber'] = state.pageNumber;
			inputParams['pageSize'] = state.pageSize;

	        console.log('inputParams : ' + JSON.stringify(inputParams));
	        fetchData(inputParams);
	    });

	    $('#prevPage').click(function () {
	        if (state.pageNumber > 0) {
	            state.pageNumber--;
	        }
	        console.log(state);

	        var inputParams = {};
			inputParams['name'] = state.name;
			inputParams['pgType'] = state.pgType;
			inputParams['shortDescription'] = state.shortDescription;
			inputParams['basePrice'] = state.basePrice;
			inputParams['pageNumber'] = state.pageNumber;
			inputParams['pageSize'] = state.pageSize;

	        console.log('inputParams : ' + JSON.stringify(inputParams));
	        fetchData(inputParams);
	    });

	    $('#nextPage').click(function () {
	        console.log("Next page");
	        state.pageNumber++;
	        console.log(state);

	        var inputParams = {};
			inputParams['name'] = state.name;
			inputParams['pgType'] = state.pgType;
			inputParams['shortDescription'] = state.shortDescription;
			inputParams['basePrice'] = state.basePrice;
			inputParams['pageNumber'] = state.pageNumber;
			inputParams['pageSize'] = state.pageSize;
			
	        console.log('inputParams : ' + JSON.stringify(inputParams));
	        fetchData(inputParams);
	    });

	    function fetchData(inputParams) {
			$('#loader').show();
			
			$.ajax({
			    url: '../pgFinderRest/getAllPGList',
			    method: 'POST',
			    data: JSON.stringify(inputParams),
			    contentType: 'application/json',
			    dataType: 'json',
			    beforeSend: function () {
			        $('#loader').show(); 
			    },
			    success: function (response) {
			        console.log('response: ' + response);
			        renderData(response);
			    },
			    error: function (xhr, status, error) {
			        console.error("Error fetching data:", error);
					showAlert('Error', 'Failed to fetch data for Active Counsel List');
			    },
			    complete: function () {
			        $('#loader').hide(); 
			    }
			});
	    }

	    function renderData(response) {
	        var fetchPGDetails = response.result.content;
	        console.log('fetchUsersDetails: ' + JSON.stringify(fetchUsersDetails));

	        var temp = '';
	        var startSerialNo = state.pageNumber * state.pageSize + 1;

			for (let i = 0; i < fetchUsersDetails.length; i++) {
			    var item = fetchUsersDetails[i];

			    temp += `<tr>`;
			    temp += `<td>${startSerialNo++}</td>`;
			    temp += `<td>${item.name}</td>`;
			    temp += `<td>${item.shortDescription || '-'}</td>`;
			    temp += `<td><span class="badge bg-primary">${item.pgType || '-'}</span></td>`;
				temp += `<td>${item.address.city || '-'}</td>`;
				temp += `<td>${item.basePrice || '-'}</td>`;
				temp += `<td>${item.address.line1 || ''} ${item.address.line2 || ''}, ${item.address.city || ''}, ${item.address.state || ''}, ${item.address.country || ''}</td>`;

				// Action buttons with proper spacing and alignment
				temp += `<td class="action-info-pannel">`;
				temp += `				<button type="button"
				                        class="btn btn-sm btn-primary view-details-btn"
				                        data-bs-toggle="modal"
				                        data-bs-target="#viewDetailsModal"
				                        data-pgname="${item.name}"
				                        data-description="${item.shortDescription}"
				                        data-pgtype="${item.pgType}"
				                        data-baseprice="${item.basePrice}"
				                        data-availability="${item.availabilityStatus}"
				                        data-address="${item.address.line1 || ''}, ${item.address.line2 || ''}, ${item.address.city || ''}, ${item.address.state || ''}, ${item.address.country || ''}"
				                        data-latitude="${item.geoLocation.latitude || ''}"
				                        data-longitude="${item.geoLocation.longitude || ''}"
				                        data-placeid="${item.geoLocation.placeId || ''}"
				                        data-amenities="${(item.amenities || []).join(', ')}"
				                        data-rating="${item.avgRating != null ? item.avgRating : 'N/A'}"
				                        data-reviews="${item.reviewCount || 0}"
				                        data-verified="${item.verified}">
				                        <i class="bi bi-eye"></i> View
				                    </button>`;
				temp += `</td>`;
				temp += `</tr>`;

			}
	        $('#pgTable tbody').html(temp);

	        var from = state.pageNumber * state.pageSize + 1;
	        var to = Math.min((state.pageNumber + 1) * state.pageSize, response.result.totalElements);
	        $('#from').html(from);
	        $('#to').html(to);
	        $('#currentPage').html(state.pageNumber + 1);

	        var first = response.result.first;
			console.log("first:   " + first);
	        if (first) {
	            $('#first').addClass('disabled');
	        } else {
	            $('#first').removeClass('disabled');
	        }

	        var last = response.result.last;
	        console.log("last:   " + last);
	        if (last) {
	            $('#last').addClass('disabled');
	        } else {
	            $('#last').removeClass('disabled');
	        }
	    }

		/*	---------------close Error or success message in modal---------------------*/
		$('.close-modal').click(function() {
		    $('#alert').css("display", "none");
		});
	});

	/*	---------------Show Error or success message in modal---------------------*/
	function showAlert(status, message) {
	    $('.modal-title').text(status);
	    $('.modal-body').text(message);
	    $('#alert').css("display", "block");
	}
