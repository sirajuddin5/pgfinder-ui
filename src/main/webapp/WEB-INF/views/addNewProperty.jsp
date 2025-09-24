<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Property Details</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/addNewProperty.css">
</head>
<body>
    <input type="hidden" value="${token}" id="token">
    <input type="hidden" value="${response.data.id}" id="ownerId">

    <div class="form-modal" id="addPropertyModal">
        <div class="form-container">
            <div class="form-header">
                <h3 class="form-title">Add New Property</h3>
            </div>

            <form id="addPropertyForm">
                <%-- BASIC INFO --%>
                <div class="form-grid">
                    <div class="form-group">
                        <label for="name">Property Name *</label>
                        <input type="text" id="propertyName" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="pgType">Property Type *</label>
                        <select id="pgType" name="pgType" required>
                            <option value="">Select Type</option>
                            <option value="ENTIRE_PROPERTY">Entire Property</option>
                            <option value="SINGLE_ROOM">Single Room</option>
                            <option value="SEAT_IN_DORM">Seat in Dorms</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="genderPreference">Gender Preference</label>
                        <select id="genderPreference" name="genderPreference">
                            <option value="ANY">Any</option>
                            <option value="MALE_ONLY">Male</option>
                            <option value="FEMALE_ONLY">Female</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="basePrice">Base Price *</label>
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

                <%-- ADDRESS SECTION --%>
                <h4 class="section-heading">Address Information</h4>
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

                <%-- GEO LOCATION --%>
                <h4 class="section-heading">Geo Location</h4>
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

                <%-- CONTACT INFO --%>
                <h4 class="section-heading">Contact Information</h4>
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

                <%-- AMENITIES --%>
                <h4 class="section-heading">Property Amenities</h4>
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

                <%-- ROOMS --%>
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
                                    <option value="DORM_BED">Dormitory</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Capacity *</label>
                                <input type="number" name="rooms[0].capacity" min="1" required>
                            </div>
                            <div class="form-group">
                                <label>Price (â¹) *</label>
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

                <%-- TAGS --%>
                <h4 class="section-heading">Tags</h4>
                <div class="form-group">
                    <label for="tags">Tags (comma separated)</label>
                    <input type="text" id="tags" name="tags" placeholder="e.g., Near Metro, Furnished, Pet Friendly">
                </div>

                <%-- FORM ACTIONS --%>
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="closeAddPropertyForm()">Cancel</button>
                    <button type="submit" id="submitProperty" class="btn btn-success">
                        <i class="fas fa-save"></i> Save Property
                    </button>
                </div>
            </form>

            <!-- ✅ Modal Alert Box -->
            <div id="alert" style="display:none; position: fixed; top: 30%; left: 50%; transform: translate(-50%, -50%);
                                    background: white; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.3); 
                                    width: 300px; z-index: 9999; padding: 20px; text-align: center;">
                <h4 class="modal-title" style="margin-bottom: 10px; color: #222;"></h4>
                <p class="modal-body" style="margin-bottom: 20px;"></p>
                <button class="close-modal" style="padding: 8px 16px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;">
                    OK
                </button>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="js/addNewProperty.js"></script>
</body>
</html>
