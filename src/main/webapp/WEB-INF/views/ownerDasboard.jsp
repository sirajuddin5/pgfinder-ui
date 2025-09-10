<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Property Owner Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Style.css -->
    <link rel="stylesheet" type="text/css" href="css/ownerDashboard.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
</head>
<body>
	<jsp:include page="addPropertyModal.jsp" />
	
	<div class="dashboard-header">
	    <div class="header-content">
	        <div class="logo">
	            <i class="fas fa-building"></i>
	            PropertyHub 
	        </div>
	        <div class="user-info">
	            <i class="fas fa-user-circle fa-lg"></i>
	            <span>Welcome, ${response.data.fullName}</span>
	        </div>
	    </div>
	</div>

    <div class="container">
        <!-- Stats Overview -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-title">Total Properties</div>
                    <div class="stat-icon">
                        <i class="fas fa-home"></i>
                    </div>
                </div>
                <div class="stat-value">${ownedProperties.size()}</div>
                <div class="stat-change">
                    <i class="fas fa-arrow-up"></i> Active properties
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-title">Occupied Units</div>
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
                <div class="stat-value">
                    <c:set var="occupiedCount" value="0" />
                    <c:forEach var="property" items="${ownedProperties}">
                        <c:if test="${property.tenantAssigned}">
                            <c:set var="occupiedCount" value="${occupiedCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${occupiedCount}
                </div>
                <div class="stat-change">
                    <i class="fas fa-chart-line"></i> Occupancy rate
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-title">Active Requests</div>
                    <div class="stat-icon">
                        <i class="fas fa-tools"></i>
                    </div>
                </div>
                <div class="stat-value">
                    <c:choose>
                        <c:when test="${not empty propertyRequests}">
                            ${propertyRequests.size()}
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </div>
                <div class="stat-change">
                    <i class="fas fa-clock"></i> Pending review
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-title">Notifications</div>
                    <div class="stat-icon">
                        <i class="fas fa-bell"></i>
                    </div>
                </div>
                <div class="stat-value">
                    <c:choose>
                        <c:when test="${not empty notifications}">
                            ${notifications.size()}
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </div>
                <div class="stat-change">
                    <i class="fas fa-envelope"></i> New messages
                </div>
            </div>
        </div>

        <!-- Profile Section -->
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-user"></i>
                    Profile Overview
                </h2>
                <form action="editProfile" method="get">
                    <button class="btn btn-primary" type="submit">
                        <i class="fas fa-edit"></i>
                        Edit Profile
                    </button>
                </form>
            </div>
            <div class="section-content">
                <div class="profile-card">
                    <div class="profile-avatar">
                        ${response.data.fullName.substring(0,1).toUpperCase()}
                    </div>
                    <div class="profile-details">
                        <h3>${response.data.fullName}</h3>
                        <p><i class="fas fa-envelope"></i> ${response.data.email}</p>
                        <p><i class="fas fa-phone"></i> ${response.data.phone}</p>
                        <p><i class="fas fa-tag"></i> Owner</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Properties Section -->
		
		<div class="section">
		       <div class="section">
		           <div class="section-header">
		               <h2 class="section-title">
		                   <i class="fas fa-building"></i>
		                   Property Portfolio
		               </h2>
						<a href="addNewProperty" class="btn btn-primary">
						    <i class="fas fa-plus"></i>
						    Add Property
						</a>
		           </div>
		           <div class="section-content">
		               <div class="empty-state">
		                   <i class="fas fa-home"></i>
		                   <h3>No Properties Yet</h3>
		                   <p>Start by adding your first property to the portfolio</p>
		               </div>
		           </div>
		       </div>
		   </div>
		
     
        <!-- Tenant Management -->
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-users"></i>
                    Tenant Management
                </h2>
            </div>
            <div class="section-content">
                <c:choose>
                    <c:when test="${not empty ownedProperties}">
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Property Address</th>
                                        <th>Tenant Information</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="property" items="${ownedProperties}">
                                        <tr>
                                            <td><strong>${property.address}</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${property.tenantAssigned}">
                                                        <div>
                                                            <strong>${property.tenant.name}</strong><br>
                                                            <small>${property.tenant.email}</small>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: #64748b;">No tenant assigned</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${property.tenantAssigned}">
                                                        <span class="status-badge status-success">
                                                            <i class="fas fa-check"></i> Active
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-warning">
                                                            <i class="fas fa-exclamation"></i> Vacant
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <c:choose>
                                                        <c:when test="${property.tenantAssigned}">
                                                            <form action="editTenant" method="get">
                                                                <input type="hidden" name="tenantId" value="${property.tenant.id}" />
                                                                <button class="btn btn-secondary" type="submit">
                                                                    <i class="fas fa-edit"></i> Edit
                                                                </button>
                                                            </form>
                                                            <form action="removeTenant" method="post">
                                                                <input type="hidden" name="tenantId" value="${property.tenant.id}" />
                                                                <button class="btn btn-danger" type="submit">
                                                                    <i class="fas fa-user-minus"></i> Remove
                                                                </button>
                                                            </form>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <form action="assignTenant" method="get">
                                                                <input type="hidden" name="propertyId" value="${property.propertyId}" />
                                                                <button class="btn btn-primary" type="submit">
                                                                    <i class="fas fa-user-plus"></i> Assign Tenant
                                                                </button>
                                                            </form>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-users"></i>
                            <h3>No Properties Available</h3>
                            <p>Add properties first to manage tenants</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Grid Layout for Requests and Billing -->
        <div class="grid-2">
            <!-- Requests Section -->
            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">
                        <i class="fas fa-tools"></i>
                        Service Requests
                    </h2>
                    <form action="raiseRequest" method="get">
                        <button class="btn btn-primary" type="submit">
                            <i class="fas fa-plus"></i>
                            New Request
                        </button>
                    </form>
                </div>
                <div class="section-content">
                    <c:choose>
                        <c:when test="${not empty propertyRequests}">
                            <div class="table-container">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Request ID</th>
                                            <th>Property</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="request" items="${propertyRequests}">
                                            <tr>
                                                <td>
                                                    <span class="status-badge status-success">
                                                        #${request.id}
                                                    </span>
                                                </td>
                                                <td>${request.property.address}</td>
                                                <td>
                                                    <span class="status-badge status-warning">
                                                        ${request.status}
                                                    </span>
                                                </td>
                                                <td>
                                                    <form action="viewRequest" method="get">
                                                        <input type="hidden" name="requestId" value="${request.id}" />
                                                        <button class="btn btn-secondary" type="submit">
                                                            <i class="fas fa-eye"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-tools"></i>
                                <h3>No Active Requests</h3>
                                <p>All service requests are up to date</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Billing Section -->
            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">
                        <i class="fas fa-credit-card"></i>
                        Billing & Payments
                    </h2>
                    <form action="generateInvoice" method="get">
                        <button class="btn btn-primary" type="submit">
                            <i class="fas fa-file-invoice"></i>
                            Generate Invoice
                        </button>
                    </form>
                </div>
                <div class="section-content">
                    <c:choose>
                        <c:when test="${not empty billingHistory}">
                            <div class="table-container">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Amount</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="payment" items="${billingHistory}">
                                            <tr>
                                                <td>${payment.date}</td>
                                                <td><strong>$${payment.amount}</strong></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${payment.paid}">
                                                            <span class="status-badge status-success">
                                                                <i class="fas fa-check"></i> Paid
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-badge status-danger">
                                                                <i class="fas fa-clock"></i> Unpaid
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:if test="${!payment.paid}">
                                                        <form action="payDue" method="post">
                                                            <input type="hidden" name="paymentId" value="${payment.id}" />
                                                            <button class="btn btn-primary" type="submit">
                                                                <i class="fas fa-credit-card"></i> Pay
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-credit-card"></i>
                                <h3>No Billing History</h3>
                                <p>Payment records will appear here</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Notifications Section -->
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-bell"></i>
                    Recent Notifications
                </h2>
            </div>
            <div class="section-content">
                <c:choose>
                    <c:when test="${not empty notifications}">
                        <div class="notifications-list">
                            <c:forEach var="notif" items="${notifications}">
                                <div class="notification-item">
                                    <div class="notification-icon">
                                        <i class="fas fa-info"></i>
                                    </div>
                                    <div class="notification-content">
                                        <p>${notif.message}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-bell"></i>
                            <h3>No New Notifications</h3>
                            <p>You're all caught up! New notifications will appear here.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

	<script src="js/ownerDasboard.js"></script>
</body>
</html>