

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Property Owner Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --primary-solid: #667eea;
            --secondary: #f093fb;
            --accent: #4facfe;
            --dark: #2d3748;
            --light: #f7fafc;
            --white: #ffffff;
            --shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            --shadow-lg: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            --border-radius: 16px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            line-height: 1.6;
        }

        .dashboard-header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            color: white;
            font-size: 1.5rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .user-info {
            color: white;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            display: grid;
            gap: 2rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 1rem;
        }

        .stat-card {
            background: var(--white);
            padding: 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
            transition: var(--transition);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .stat-title {
            font-size: 0.9rem;
            color: #64748b;
            font-weight: 500;
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--accent), var(--secondary));
            color: white;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .stat-change {
            font-size: 0.85rem;
            color: #10b981;
        }

        .section {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            transition: var(--transition);
        }

        .section:hover {
            box-shadow: var(--shadow-lg);
        }

        .section-header {
            padding: 1.5rem 2rem;
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-content {
            padding: 2rem;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.9rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
            box-shadow: 0 4px 14px 0 rgba(102, 126, 234, 0.39);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px 0 rgba(102, 126, 234, 0.5);
        }

        .btn-secondary {
            background: #f1f5f9;
            color: #475569;
            border: 1px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #e2e8f0;
            transform: translateY(-1px);
        }

        .btn-danger {
            background: linear-gradient(135deg, #ff6b6b, #ee5a52);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px 0 rgba(238, 90, 82, 0.4);
        }

        .table-container {
            overflow-x: auto;
            margin-top: 1rem;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th {
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            padding: 1rem 1.5rem;
            text-align: left;
            font-weight: 600;
            color: var(--dark);
            font-size: 0.9rem;
            border-bottom: 2px solid #e2e8f0;
        }

        td {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #f1f5f9;
            color: #64748b;
        }

        tr:hover {
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
        }

        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }

        .status-success {
            background: #dcfce7;
            color: #16a34a;
        }

        .status-warning {
            background: #fef3c7;
            color: #d97706;
        }

        .status-danger {
            background: #fee2e2;
            color: #dc2626;
        }

        .profile-card {
            display: grid;
            grid-template-columns: auto 1fr auto;
            gap: 1.5rem;
            align-items: center;
        }

        .profile-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            font-weight: 700;
        }

        .profile-details h3 {
            color: var(--dark);
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }

        .profile-details p {
            color: #64748b;
            margin-bottom: 0.25rem;
        }

        .notifications-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .notification-item {
            padding: 1rem;
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
            border-radius: 12px;
            border-left: 4px solid var(--primary-solid);
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: var(--transition);
        }

        .notification-item:hover {
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .notification-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .grid-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #64748b;
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }
            
            .header-content {
                padding: 0 1rem;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .grid-2 {
                grid-template-columns: 1fr;
            }
            
            .section-header {
                padding: 1rem;
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .section-content {
                padding: 1rem;
            }
            
            .profile-card {
                grid-template-columns: 1fr;
                text-align: center;
            }
            
            .action-buttons {
                justify-content: center;
            }
        }

        /* Loading animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .section, .stat-card {
            animation: fadeInUp 0.6s ease-out;
        }

        .section:nth-child(2) { animation-delay: 0.1s; }
        .section:nth-child(3) { animation-delay: 0.2s; }
        .section:nth-child(4) { animation-delay: 0.3s; }
    </style>
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
            </div
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
		               <button class="btn btn-primary" onclick="openAddPropertyForm()">
		                   <i class="fas fa-plus"></i>
		                   Add Property
		               </button>
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

    <script>
        // Add smooth scrolling and enhanced interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Add loading animation delay to sections
            const sections = document.querySelectorAll('.section, .stat-card');
            sections.forEach((section, index) => {
                section.style.animationDelay = `${index * 0.1}s`;
            });

            // Add click effects to buttons
            const buttons = document.querySelectorAll('.btn');
            buttons.forEach(button => {
                button.addEventListener('click', function(e) {
                    // Create ripple effect
                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();
                    const size = Math.max(rect.width, rect.height);
                    const x = e.clientX - rect.left - size / 2;
                    const y = e.clientY - rect.top - size / 2;
                    
                    ripple.style.cssText = `
                        position: absolute;
                        width: ${size}px;
                        height: ${size}px;
                        left: ${x}px;
                        top: ${y}px;
                        background: rgba(255, 255, 255, 0.5);
                        border-radius: 50%;
                        transform: scale(0);
                        animation: ripple 0.6s ease-out;
                        pointer-events: none;
                    `;
                    
                    this.style.position = 'relative';
                    this.style.overflow = 'hidden';
                    this.appendChild(ripple);
                    
                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });

            // Add hover effects to table rows
            const tableRows = document.querySelectorAll('tbody tr');
            tableRows.forEach(row => {
                row.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateX(5px)';
                });
                row.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateX(0)';
                });
            });

            // Real-time clock in header (optional enhancement)
            function updateClock() {
                const now = new Date();
                const timeString = now.toLocaleTimeString();
                const clockElement = document.getElementById('clock');
                if (clockElement) {
                    clockElement.textContent = timeString;
                }
            }
            
            // Update clock every second if element exists
            if (document.getElementById('clock')) {
                setInterval(updateClock, 1000);
                updateClock();
            }
        });

        // CSS for ripple animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(2);
                    opacity: 0;
                }
            }
            
            .fade-in {
                opacity: 0;
                animation: fadeIn 0.5s ease-in forwards;
            }
            
            @keyframes fadeIn {
                to {
                    opacity: 1;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
	
	<script src="js/ownerDasboard.js"></script>
</body>
</html>