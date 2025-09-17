/*   <script>
        $(document).ready(function() {
            // Initialize DataTable
            var table = $('#pgTable').DataTable({
                "pageLength": 10,
                "lengthMenu": [10, 25, 50, 100],
                "dom": '<"row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>rt<"row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
                "language": {
                    "search": "Filter:",
                    "lengthMenu": "Show _MENU_ entries"
                }
            });
            
            // Update page info
            updatePageInfo();
            
            // Page length change
            $('#pageSize').on('change', function() {
                table.page.len(this.value).draw();
                updatePageInfo();
            });
            
            // Previous page
            $('#prevPage').on('click', function(e) {
                e.preventDefault();
                table.page('previous').draw('page');
                updatePageInfo();
            });
            
            // Next page
            $('#nextPage').on('click', function(e) {
                e.preventDefault();
                table.page('next').draw('page');
                updatePageInfo();
            });
            
            // Update page info function
            function updatePageInfo() {
                var info = table.page.info();
                $('#from').text(info.start + 1);
                $('#to').text(info.end);
                $('#currentPage').text(info.page + 1);
                
                // Enable/disable pagination buttons
                $('#first').toggleClass('disabled', info.page === 0);
                $('#last').toggleClass('disabled', info.page === info.pages - 1);
            }
            
            // Search functionality
            $('#searchInput').on('click', function() {
                var pgName = $('#pgName').val();
                var pgType = $('#pgType').val();
                var city = $('#city').val();
                var basePrice = $('#basePrice').val();
                var genderPreference = $('#genderPreference').val();
                var amenities = $('#amenities').val();
                var contactEmail = $('#contactEmail').val();
                var contactPhone = $('#contactPhone').val();
                
                // Combine all filters
                table.columns(0).search(pgName).draw();
                table.columns(2).search(pgType).draw();
                table.columns(4).search(city).draw();
                
                // For number-based filtering (price), we need a custom approach
                if (basePrice) {
                    // This is a simplified approach - would need more complex logic for proper number filtering
                    table.column(5).search("^" + basePrice + "$", true, false).draw();
                }
                
                table.columns(3).search(genderPreference).draw();
                
                // Note: For more complex filtering (like amenities, which is not directly in the table),
                // you would need to implement a custom filter function
                
                updatePageInfo();
            });
            
            // View Details button click
            $('#pgTable').on('click', '.view-details-btn', function() {
                var pgId = $(this).data('pg-id');
                
                // In a real application, you would fetch the details from the server using this ID
                // For this example, we'll use the first PG in the list
                var pgData = {
                    <c:if test="${not empty pgList}">
                    <c:set var="firstPg" value="${pgList[0]}" />
                    name: "${firstPg.name}",
                    description: "${firstPg.description}",
                    pgType: "${firstPg.pgType}",
                    genderPreference: "${firstPg.genderPreference}",
                    basePrice: "<fmt:formatNumber value='${firstPg.basePrice}' type='currency'/>",
                    address: {
                        line1: "${firstPg.address.line1}",
                        line2: "${firstPg.address.line2}",
                        city: "${firstPg.address.city}",
                        state: "${firstPg.address.state}",
                        country: "${firstPg.address.country}",
                        postalCode: "${firstPg.address.postalCode}"
                    },
                    contactEmail: "${firstPg.contactEmail}",
                    contactPhone: "${firstPg.contactPhone}",
                    amenities: [
                        <c:forEach var="amenity" items="${firstPg.amenities}" varStatus="loop">
                        "${amenity}"<c:if test="${not loop.last}">,</c:if>
                        </c:forEach>
                    ],
                    tags: [
                        <c:forEach var="tag" items="${firstPg.tags}" varStatus="loop">
                        "${tag}"<c:if test="${not loop.last}">,</c:if>
                        </c:forEach>
                    ],
                    rooms: [
                        <c:forEach var="room" items="${firstPg.rooms}" varStatus="loop">
                        {
                            title: "${room.title}",
                            roomType: "${room.roomType}",
                            capacity: "${room.capacity}",
                            price: "<fmt:formatNumber value='${room.price}' type='currency'/>",
                            availableUnits: "${room.availableUnits}",
                            description: "${room.description}",
                            amenities: [
                                <c:forEach var="ra" items="${room.amenities}" varStatus="innerLoop">
                                "${ra}"<c:if test="${not innerLoop.last}">,</c:if>
                                </c:forEach>
                            ]
                        }<c:if test="${not loop.last}">,</c:if>
                        </c:forEach>
                    ]
                    </c:if>
                };
                
                // Populate modal with data
                $('#modalPgName').text(pgData.name);
                $('#modalDescription').text(pgData.description);
                $('#modalPgType').text(pgData.pgType);
                $('#modalGenderPreference').text(pgData.genderPreference);
                $('#modalBasePrice').text(pgData.basePrice);
                $('#modalContactEmail').text(pgData.contactEmail);
                $('#modalContactPhone').text(pgData.contactPhone);
                
                // Format address
                var address = `${pgData.address.line1}, ${pgData.address.line2}, ${pgData.address.city}, ${pgData.address.state}, ${pgData.address.country} - ${pgData.address.postalCode}`;
                $('#modalAddress').text(address);
                
                // Populate amenities
                $('#modalAmenities').empty();
                pgData.amenities.forEach(function(amenity) {
                    $('#modalAmenities').append('<span class="badge bg-secondary">' + amenity + '</span>');
                });
                
                // Populate tags
                $('#modalTags').empty();
                pgData.tags.forEach(function(tag) {
                    $('#modalTags').append('<span class="badge bg-success">' + tag + '</span>');
                });
                
                // Populate rooms
                $('#modalRooms').empty();
                pgData.rooms.forEach(function(room, index) {
                    var roomHtml = `
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="heading${index}">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${index}" aria-expanded="false" aria-controls="collapse${index}">
                                ${room.title} (${room.roomType}) - ${room.price}
                            </button>
                        </h2>
                        <div id="collapse${index}" class="accordion-collapse collapse" aria-labelledby="heading${index}" data-bs-parent="#modalRooms">
                            <div class="accordion-body">
                                <p><strong>Capacity:</strong> ${room.capacity}</p>
                                <p><strong>Available Units:</strong> ${room.availableUnits}</p>
                                <p><strong>Description:</strong> ${room.description}</p>
                                <div class="mt-2">
                                    ${room.amenities.map(amenity => '<span class="badge bg-info me-1">' + amenity + '</span>').join('')}
                                </div>
                            </div>
                        </div>
                    </div>`;
                    $('#modalRooms').append(roomHtml);
                });
                
                // Show the modal
                var modal = new bootstrap.Modal(document.getElementById('viewDetailsModal'));
                modal.show();
            });
            
            // Excel export functionality
            $('#downloadExcel').on('click', function() {
                // Create a new table for export without the action column
                var data = [];
                var headers = [];
                
                // Add headers
                $('#pgTable thead th').each(function() {
                    if ($(this).index() !== 7) { // Skip the actions column
                        headers.push($(this).text());
                    }
                });
                data.push(headers);
                
                // Add data rows
                $('#pgTable tbody tr').each(function() {
                    var row = [];
                    $(this).find('td').each(function() {
                        if ($(this).index() !== 7) { // Skip the actions column
                            row.push($(this).text().trim());
                        }
                    });
                    data.push(row);
                });
                
                // Create worksheet
                var ws = XLSX.utils.aoa_to_sheet(data);
                
                // Create workbook
                var wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, ws, "PG Information");
                
                // Export to file
                XLSX.writeFile(wb, "pg_information.xlsx");
            });
            
            // Update page info when table is redrawn
            table.on('draw', function() {
                updatePageInfo();
            });
        });
    </script>*/
	
	
	$(document).ready(function () {
		//Clear modal content on close
		$('#viewDetailsModal').on('hidden.bs.modal', function () {
		    $('#modalBodyContent').html('');
		    $("#modalPgName, #modalDescription, #modalPgType, #modalGenderPreference, #modalBasePrice, #modalAddress").text('-');
		    $(document.activeElement).blur(); 
		});

		$('#downloadExcel').click(function () {
			console.log("downloadExcel Clicked");
			var inputParams = {
			    username: state.username,
			    counselName: state.counselName,
			    contactNumber: state.contactNumber,
			    emailId: state.emailId,
			    bench: state.bench,
			    pageNumber: 0,
			    pageSize: 100000
			};

		    $.ajax({
		        url: '../adminPanelRest/activeCounsel',
		        method: 'POST',
		        data: JSON.stringify(inputParams),
		        contentType: 'application/json',
		        dataType: 'json',
		        beforeSend: function () {
		            $('#downloadExcel').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Downloading...');
		        },
		        success: function (response) {
		            exportDataToExcel(response.result.content);
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
		        "Sr No.", "RollNumber", "Username", "Counsel Name", 
		        "Contact Number", "Email ID", "Payment", "Amount","Start Date","Expire Date"
		    ]);

		    // Rows
		    $.each(dataList, function (index, item) {
		        worksheetData.push([
		            index + 1,
					item.rollNumber,
					item.username,
		            item.counselName,
					item.contactNumber || '',
					item.emailId || '',
					item.payment || '',
					Number(item.amount) || 0,
					formatDate(item.startDate),
					formatDate(item.expireDate)
		        ]);
		    });

		    // SheetJS export
		    var worksheet = XLSX.utils.aoa_to_sheet(worksheetData);
		    var workbook = XLSX.utils.book_new();
		    XLSX.utils.book_append_sheet(workbook, worksheet, "Counsel Info");
		    XLSX.writeFile(workbook, "ActiveCounselsList.xlsx");
		}

		function formatDate(dateStr) {
		    if (!dateStr) return '';
		    var date = new Date(dateStr);
		    if (isNaN(date)) return dateStr;
		    var day = ("0" + date.getDate()).slice(-2);
		    var month = ("0" + (date.getMonth() + 1)).slice(-2);
		    var year = date.getFullYear();
		    return `${day}-${month}-${year}`;
		}

		// Handle view button click - dynamically created buttons
		$(document).on("click", ".viewBtn", function () {
		    var counselName = $(this).data("counsel-name") || '-';
		    var username = $(this).data("username") || '-';
		    var email = $(this).data("email") || '-';
		    var contact = $(this).data("contact") || '-';
		    var createdBy = $(this).data("createdby") || '-';
		    var createdAt = $(this).data("createdat") || '-';
		    var expireDate = $(this).data("expiredate") || '-';
	        console.log("createdAt:   " + createdAt);
			
		    $("#modalCounselName").text(counselName);
		    $("#modalUsername").text(username);
		    $("#modalEmail").text(email);
		    $("#modalContact").text(contact);
		    $("#modalCreatedBy").text(createdBy);
		    $("#modalCreatedAt").text(createdAt);
		    $("#modalExpireDate").text(expireDate);

		    $('#viewDetailsModal').modal('show');
		});
	    ////console mein yellow box mein error nhi aayega
		$('#myModal').on('shown.bs.modal', function () {
		    $('#myInput').trigger('focus')
		});
		

	    var state = {
	        name: "",
			shortDescription: "",
			basePrice: "",
	        pgType: "",
	        //city: "",
	        pageNumber: 0,
	        pageSize: 10
	    };

	    $('#searchInput').click(function () {
	        var name = $('#pgName').val();
	        var pgType = $('#pgType').val();
	        var shortDescription = $('#shortDescription').val();
	        var basePrice = $('#basePrice').val();

	        state.name = name;
	        state.pgType = pgType;
	        state.shortDescription = shortDescription;
	        state.basePrice = basePrice;
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
			        //renderData(response);
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
	        var fetchUsersDetails = response.result.content;
	        console.log('fetchUsersDetails: ' + JSON.stringify(fetchUsersDetails));

	        var temp = '';
	        var startSerialNo = state.pageNumber * state.pageSize + 1;

			for (let i = 0; i < fetchUsersDetails.length; i++) {
			    var item = fetchUsersDetails[i];

			    temp += `<tr>`;
			    temp += `<td>${startSerialNo++}</td>`;
			    temp += `<td>${item.username}</td>`;
			    temp += `<td class="text-wrap">${item.counselName}</td>`;
			    temp += `<td>${item.contactNumber}</td>`;
			    temp += `<td>${item.emailId}</td>`;

				// Action buttons with proper spacing and alignment
				temp += `<td class="action-info-pannel">`;
				temp += `<a href="updateCounsel?id=${item.id}" class="btn btn-primary" style="margin-right: 5px;"><i class="bi bi-pencil-square"></i></a>`;
				temp += `<button type="button" class="btn btn-primary viewBtn" data-toggle="modal" data-target="#exampleModal"
				            data-counsel-name="${item.counselName || '-'}"
				            data-username="${item.username || '-'}"
				            data-email="${item.emailId || '-'}"
				            data-contact="${item.contactNumber || '-'}"
				            data-createdby="${item.createdBy || '-'}"
				            data-createdat="${formattedCreatedAtDate} ${timePartCreated}"
				            data-expiredate="${formattedExpireDate} ${timePartExpire}"
				            style="margin-right: 5px;">
				            <i class="bi bi-eye"></i>
				         </button>`;
				temp += `<button type="button" class="btn btn-secondary info-1"><i class="bi bi-check2-square"></i></button>`;
				temp += `</td>`;
				temp += `</tr>`;

			}
	        $('#counsel-list').html(temp);

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
