
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Portfolio</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .section {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 16px;
            padding: 32px;
            margin-bottom: 24px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 2px solid #e5e7eb;
        }

        .section-title {
            font-size: 28px;
            font-weight: 700;
            color: #1f2937;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            text-decoration: none;
            font-size: 14px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #6b7280;
            color: white;
        }

        .btn-secondary:hover {
            background: #4b5563;
        }

        .btn-success {
            background: #10b981;
            color: white;
        }

        .btn-success:hover {
            background: #059669;
        }

        .table-container {
            overflow-x: auto;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        th, td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }

        th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.5px;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .status-success {
            background: #d1fae5;
            color: #065f46;
        }

        .status-warning {
            background: #fef3c7;
            color: #92400e;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6b7280;
        }

        .empty-state i {
            font-size: 64px;
            margin-bottom: 16px;
            color: #d1d5db;
        }

        .empty-state h3 {
            font-size: 24px;
            margin-bottom: 8px;
        }

        .form-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            overflow-y: auto;
        }

        .form-modal.active {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .form-container {
            background: white;
            border-radius: 16px;
            padding: 32px;
            width: 100%;
            max-width: 800px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.25);
        }

        .form-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 2px solid #e5e7eb;
        }

        .form-title {
            font-size: 24px;
            font-weight: 700;
            color: #1f2937;
        }

        .close-btn {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: #6b7280;
            padding: 8px;
        }

        .close-btn:hover {
            color: #ef4444;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #374151;
        }

        input, select, textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .checkbox-group {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 12px;
            margin-top: 8px;
        }

        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .checkbox-item input[type="checkbox"] {
            width: auto;
        }

        .room-section {
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            background: #f9fafb;
        }

        .room-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 16px;
        }

        .room-title {
            font-size: 18px;
            font-weight: 600;
            color: #1f2937;
        }

        .add-room-btn {
            background: #10b981;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 12px;
        }

        .remove-room-btn {
            background: #ef4444;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 12px;
        }

        .form-actions {
            display: flex;
            gap: 16px;
            justify-content: flex-end;
            margin-top: 32px;
            padding-top: 24px;
            border-top: 2px solid #e5e7eb;
        }

        .error {
            color: #ef4444;
            font-size: 12px;
            margin-top: 4px;
        }
    </style>
</head>
<body>
	 <div class="form-modal" id="addPropertyModal">
	        <div class="form-container">
	            <div class="form-header">
	                <h3 class="form-title">Add New Property</h3>
	                <button class="close-btn" onclick="closeAddPropertyForm()">
	                    <i class="fas fa-times"></i>
	                </button>
	            </div>
	            
	            <form id="addPropertyForm" onsubmit="handleSubmit(event)">
	                <div class="form-grid">
	                    <!-- Basic Information -->
	                    <div class="form-group">
	                        <label for="name">Property Name *</label>
	                        <input type="text" id="name" name="name" required>
	                    </div>

	                    <div class="form-group">
	                        <label for="pgType">Property Type *</label>
	                        <select id="pgType" name="pgType" required>
	                            <option value="">Select Type</option>
	                            <option value="ENTIRE_PROPERTY">Entire Property</option>
	                            <option value="SHARED_ROOMS">Shared Rooms</option>
	                            <option value="PRIVATE_ROOMS">Private Rooms</option>
	                        </select>
	                    </div>

	                    <div class="form-group">
	                        <label for="genderPreference">Gender Preference</label>
	                        <select id="genderPreference" name="genderPreference">
	                            <option value="ANY">Any</option>
	                            <option value="MALE">Male</option>
	                            <option value="FEMALE">Female</option>
	                        </select>
	                    </div>

	                    <div class="form-group">
	                        <label for="basePrice">Base Price  *</label>
	                        <input type="number" id="basePrice" name="basePrice" min="0" required>
	                    </div>

	                    <div class="form-group full-width">
	                        <label for="shortDescription">Short Description</label>
	                        <input type="text" id="shortDescription" name="shortDescription" maxlength="100">
	                    </div>

	                    <div class="form-group full-width">
	                        <label for="description">Full Description</label>
	                        <textarea id="description" name="description" rows="4"></textarea>
	                    </div>
	                </div>

	                <!-- Address Section -->
	                <h4 style="margin: 24px 0 16px; color: #1f2937; font-size: 18px;">Address Information</h4>
	                <div class="form-grid">
	                    <div class="form-group">
	                        <label for="addressLine1">Address Line 1 *</label>
	                        <input type="text" id="addressLine1" name="address.line1" required>
	                    </div>

	                    <div class="form-group">
	                        <label for="addressLine2">Address Line 2</label>
	                        <input type="text" id="addressLine2" name="address.line2">
	                    </div>

	                    <div class="form-group">
	                        <label for="city">City *</label>
	                        <input type="text" id="city" name="address.city" required>
	                    </div>

	                    <div class="form-group">
	                        <label for="state">State *</label>
	                        <input type="text" id="state" name="address.state" required>
	                    </div>

	                    <div class="form-group">
	                        <label for="country">Country *</label>
	                        <input type="text" id="country" name="address.country" value="India" required>
	                    </div>

	                    <div class="form-group">
	                        <label for="postalCode">Postal Code *</label>
	                        <input type="text" id="postalCode" name="address.postalCode" required>
	                    </div>
	                </div>

	                <!-- Location Section -->
	                <h4 style="margin: 24px 0 16px; color: #1f2937; font-size: 18px;">Geo Location</h4>
	                <div class="form-grid">
	                    <div class="form-group">
	                        <label for="latitude">Latitude</label>
	                        <input type="number" id="latitude" name="geoLocation.latitude" step="any">
	                    </div>

	                    <div class="form-group">
	                        <label for="longitude">Longitude</label>
	                        <input type="number" id="longitude" name="geoLocation.longitude" step="any">
	                    </div>

	                    <div class="form-group full-width">
	                        <label for="placeId">Google Place ID</label>
	                        <input type="text" id="placeId" name="geoLocation.placeId">
	                    </div>
	                </div>

	                <!-- Contact Information -->
	                <h4 style="margin: 24px 0 16px; color: #1f2937; font-size: 18px;">Contact Information</h4>
	                <div class="form-grid">
	                    <div class="form-group">
	                        <label for="contactEmail">Contact Email</label>
	                        <input type="email" id="contactEmail" name="contactEmail">
	                    </div>

	                    <div class="form-group">
	                        <label for="contactPhone">Contact Phone</label>
	                        <input type="tel" id="contactPhone" name="contactPhone">
	                    </div>
	                </div>

	                <!-- Amenities Section -->
	                <h4 style="margin: 24px 0 16px; color: #1f2937; font-size: 18px;">Property Amenities</h4>
	                <div class="checkbox-group">
	                    <div class="checkbox-item">
	                        <input type="checkbox" id="amenity_ac" name="amenities" value="AC">
	                        <label for="amenity_ac">Air Conditioning</label>
	                    </div>
	                    <div class="checkbox-item">
	                        <input type="checkbox" id="amenity_wifi" name="amenities" value="WIFI">
	                        <label for="amenity_wifi">Wi-Fi</label>
	                    </div>
	                    <div class="checkbox-item">
	                        <input type="checkbox" id="amenity_parking" name="amenities" value="PARKING">
	                        <label for="amenity_parking">Parking</label>
	                    </div>
	                    <div class="checkbox-item">
	                        <input type="checkbox" id="amenity_kitchen" name="amenities" value="KITCHEN">
	                        <label for="amenity_kitchen">Kitchen</label>
	                    </div>
	                    <div class="checkbox-item">
	                        <input type="checkbox" id="amenity_laundry" name="amenities" value="LAUNDRY">
	                        <label for="amenity_laundry">Laundry</label>
	                    </div>
	                    <div class="checkbox-item">
	                        <input type="checkbox" id="amenity_gym" name="amenities" value="GYM">
	                        <label for="amenity_gym">Gym</label>
	                    </div>
	                </div>

	                <!-- Rooms Section -->
	                <h4 style="margin: 24px 0 16px; color: #1f2937; font-size: 18px;">Rooms</h4>
	                <div id="roomsContainer">
	                    <div class="room-section">
	                        <div class="room-header">
	                            <h5 class="room-title">Room 1</h5>
	                        </div>
	                        <div class="form-grid">
	                            <div class="form-group">
	                                <label>Room Title *</label>
	                                <input type="text" name="rooms[0].title" required>
	                            </div>
	                            <div class="form-group">
	                                <label>Room Type *</label>
	                                <select name="rooms[0].roomType" required>
	                                    <option value="">Select Type</option>
	                                    <option value="SINGLE">Single</option>
	                                    <option value="DOUBLE">Double</option>
	                                    <option value="TRIPLE">Triple</option>
	                                    <option value="DORMITORY">Dormitory</option>
	                                </select>
	                            </div>
	                            <div class="form-group">
	                                <label>Capacity *</label>
	                                <input type="number" name="rooms[0].capacity" min="1" required>
	                            </div>
	                            <div class="form-group">
	                                <label>Price (₹) *</label>
	                                <input type="number" name="rooms[0].price" min="0" required>
	                            </div>
	                            <div class="form-group">
	                                <label>Available Units</label>
	                                <input type="number" name="rooms[0].availableUnits" min="0" value="1">
	                            </div>
	                            <div class="form-group full-width">
	                                <label>Room Description</label>
	                                <textarea name="rooms[0].description" rows="3"></textarea>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <button type="button" class="add-room-btn" onclick="addRoom()">
	                    <i class="fas fa-plus"></i> Add Another Room
	                </button>

	                <!-- Tags Section -->
	                <h4 style="margin: 24px 0 16px; color: #1f2937; font-size: 18px;">Tags</h4>
	                <div class="form-group">
	                    <label for="tags">Tags (comma separated)</label>
	                    <input type="text" id="tags" name="tags" placeholder="e.g., Near Metro, Furnished, Pet Friendly">
	                </div>

	                <div class="form-actions">
	                    <button type="button" class="btn btn-secondary" onclick="closeAddPropertyForm()">
	                        Cancel
	                    </button>
	                    <button type="submit" class="btn btn-success">
	                        <i class="fas fa-save"></i>
	                        Save Property
	                    </button>
	                </div>
	            </form>
	        </div>
	    </div>

	    <script>
	        let roomCount = 1;

	        function openAddPropertyForm() {
	            document.getElementById('addPropertyModal').classList.add('active');
	            document.body.style.overflow = 'hidden';
	        }

	        function closeAddPropertyForm() {
	            document.getElementById('addPropertyModal').classList.remove('active');
	            document.body.style.overflow = 'auto';
	            document.getElementById('addPropertyForm').reset();
	        }

	        function addRoom() {
	            const roomsContainer = document.getElementById('roomsContainer');
	            const roomSection = document.createElement('div');
	            roomSection.className = 'room-section';
	            roomSection.innerHTML = `
	                <div class="room-header">
	                    <h5 class="room-title">Room ${roomCount + 1}</h5>
	                    <button type="button" class="remove-room-btn" onclick="removeRoom(this)">
	                        <i class="fas fa-trash"></i> Remove
	                    </button>
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
	            `;
	            roomsContainer.appendChild(roomSection);
	            roomCount++;
	        }

	        function removeRoom(button) {
	            const roomSection = button.closest('.room-section');
	            roomSection.remove();
	        }

	        function handleSubmit(event) {
	            event.preventDefault();
	            
	            const formData = new FormData(event.target);
	            const propertyData = {
	                name: formData.get('name'),
	                shortDescription: formData.get('shortDescription'),
	                description: formData.get('description'),
	                pgType: formData.get('pgType'),
	                ownerId: "owner123", // You can set this dynamically
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
	                tags: formData.get('tags') ? formData.get('tags').split(',').map(tag => tag.trim()) : []
	            };

	            // Collect rooms data
	            const roomElements = document.querySelectorAll('.room-section');
	           /* roomElements.forEach((roomElement, index) => {
	                const inputs = roomElement.querySelectorAll('input, select, textarea');
	                const room = {
	                    title: '',
	                    roomType: '',
	                    capacity: 1,
	                    price: 0,
	                    availableUnits: 0,
	                    description: '',
	                    amenities: []
	                };

	               /* inputs.forEach(input => {
	                    const name = input.name;
	                    if (name.includes(`rooms[${index}]`)) {
	                        const field = name.split('.')[1];
	                        room[field] = input.type === 'number' ? parseFloat(input.value) || 0 : input.value;
	                    }
	                });*/
					
					/*inputs.forEach(input => {
					    const match = input.name.match(/rooms\[\d+\]\.(\w+)/);
					    if (match) {
					        const field = match[1];
					        room[field] = input.type === 'number' ? parseFloat(input.value) || 0 : input.value;
					    }
					});


	                propertyData.rooms.push(room);
	            });*/
				
				roomElements.forEach((roomElement) => {
				    const inputs = roomElement.querySelectorAll('input, select, textarea');
				    const room = {
				        title: '',
				        roomType: '',
				        capacity: 1,
				        price: 0,
				        availableUnits: 0,
				        description: '',
				        amenities: []
				    };

				    inputs.forEach(input => {
				        const match = input.name.match(/rooms\[\d+\]\.(\w+)/);
				        if (match) {
				            const field = match[1];
				            room[field] = input.type === 'number' ? parseFloat(input.value) || 0 : input.value.trim();
				        }
				    });

				    // Only push room if title and roomType are filled
				    if (room.title && room.roomType) {
				        propertyData.rooms.push(room);
				    }
				});


	            console.log('Property Data:', JSON.stringify(propertyData, null, 2));
	            alert('Property data collected! Check console for JSON output.');
	            
	            // Here you would typically send the data to your server
	            // Example: fetch('/api/properties', { method: 'POST', body: JSON.stringify(propertyData) })
	            
	            closeAddPropertyForm();
	        }

	        // Close modal on outside click
	        document.getElementById('addPropertyModal').addEventListener('click', function(e) {
	            if (e.target === this) {
	                closeAddPropertyForm();
	            }
	        });
	    </script>
	</body>
	</html>