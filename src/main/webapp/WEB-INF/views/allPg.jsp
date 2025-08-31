<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StayZen - Premium PG Booking</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header */
        header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            transition: all 0.3s ease;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
        }

        .logo {
            font-size: 2rem;
            font-weight: 800;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 2rem;
        }

        .nav-links a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            transition: color 0.3s ease;
            position: relative;
        }

        .nav-links a:hover {
            color: #667eea;
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -5px;
            left: 0;
            background: #667eea;
            transition: width 0.3s ease;
        }

        .nav-links a:hover::after {
            width: 100%;
        }

        .user-menu {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.6);
        }

        .btn-secondary {
            background: transparent;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-secondary:hover {
            background: #667eea;
            color: white;
        }

        /* Hero Section */
        .hero {
            padding: 120px 0 80px;
            text-align: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            animation: float 20s infinite linear;
        }

        @keyframes float {
            0% { transform: translateY(0px) translateX(0px); }
            33% { transform: translateY(-10px) translateX(5px); }
            66% { transform: translateY(5px) translateX(-5px); }
            100% { transform: translateY(0px) translateX(0px); }
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero h1 {
            font-size: 4rem;
            font-weight: 800;
            margin-bottom: 1rem;
            animation: slideUp 1s ease-out;
        }

        .hero p {
            font-size: 1.3rem;
            margin-bottom: 2rem;
            opacity: 0.9;
            animation: slideUp 1s ease-out 0.2s both;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Search Section */
        .search-section {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            margin-top: -50px;
            position: relative;
            z-index: 10;
            backdrop-filter: blur(10px);
        }

        .search-form {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr auto;
            gap: 1rem;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #555;
        }

        .form-group input, .form-group select {
            padding: 1rem;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            background: white;
        }

        .search-btn {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            height: fit-content;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        /* Features Section */
        .features {
            padding: 80px 0;
            background: #f8f9fa;
        }

        .section-title {
            text-align: center;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 3rem;
            color: #333;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }

        .feature-card {
            background: white;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(45deg, #667eea, #764ba2);
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
        }

        .feature-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.5rem;
            color: white;
        }

        .feature-card h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: #333;
        }

        /* Properties Section */
        .properties {
            padding: 80px 0;
        }

        .properties-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .property-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            position: relative;
        }

        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
        }

        .property-image {
            height: 200px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            position: relative;
            overflow: hidden;
        }

        .property-image::after {
            content: '🏠';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 3rem;
            opacity: 0.3;
        }

        .property-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: rgba(255, 255, 255, 0.9);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            color: #667eea;
        }

        .property-details {
            padding: 1.5rem;
        }

        .property-title {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .property-location {
            color: #666;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .property-amenities {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
            margin-bottom: 1rem;
        }

        .amenity {
            background: #f0f2f5;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            color: #555;
        }

        .property-price {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .price {
            font-size: 1.5rem;
            font-weight: 700;
            color: #667eea;
        }

        /* Dashboard Section */
        .dashboard {
            padding: 80px 0;
            background: #f8f9fa;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 2rem;
            margin-top: 2rem;
        }

        .dashboard-sidebar {
            background: white;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            height: fit-content;
        }

        .sidebar-menu {
            list-style: none;
        }

        .sidebar-menu li {
            padding: 1rem;
            cursor: pointer;
            border-radius: 8px;
            margin-bottom: 0.5rem;
            transition: all 0.3s ease;
            color: #555;
        }

        .sidebar-menu li:hover, .sidebar-menu li.active {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
        }

        .dashboard-content {
            background: white;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 1.5rem;
            border-radius: 12px;
            text-align: center;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        /* Footer */
        footer {
            background: #1a1a1a;
            color: white;
            padding: 50px 0 20px;
            text-align: center;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
            text-align: left;
        }

        .footer-section h3 {
            margin-bottom: 1rem;
            color: #667eea;
        }

        .footer-section a {
            color: #ccc;
            text-decoration: none;
            display: block;
            margin-bottom: 0.5rem;
            transition: color 0.3s ease;
        }

        .footer-section a:hover {
            color: #667eea;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.8);
            z-index: 2000;
            backdrop-filter: blur(5px);
        }

        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 2rem;
            border-radius: 16px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }

        .close {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #666;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            
            .hero h1 {
                font-size: 2.5rem;
            }
            
            .search-form {
                grid-template-columns: 1fr;
            }
            
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-on-scroll {
            opacity: 0;
            animation: fadeInUp 0.8s ease-out forwards;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <nav class="container">
            <div class="logo">StayZen</div>
            <ul class="nav-links">
                <li><a href="#home">Home</a></li>
                <li><a href="#properties">Properties</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#dashboard">Dashboard</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
            <div class="user-menu">
                <button class="btn btn-secondary" onclick="openModal('loginModal')">Login</button>
                <button class="btn btn-primary" onclick="openModal('signupModal')">Sign Up</button>
            </div>
        </nav>
    </header>

    <!-- Hero Section -->
    <section class="hero" id="home">
        <div class="container hero-content">
            <h1>Find Your Perfect Stay</h1>
            <p>Discover premium PG accommodations with world-class amenities and unmatched comfort</p>
        </div>
    </section>

    <!-- Search Section -->
    <section class="container">
        <div class="search-section">
            <form class="search-form" onsubmit="searchProperties(event)">
                <div class="form-group">
                    <label for="location">Location</label>
                    <input type="text" id="location" placeholder="Enter city or area" required>
                </div>
                <div class="form-group">
                    <label for="checkin">Check-in Date</label>
                    <input type="date" id="checkin" required>
                </div>
                <div class="form-group">
                    <label for="budget">Budget Range</label>
                    <select id="budget" required>
                        <option value="">Select Budget</option>
                        <option value="0-10000">Under ₹10,000</option>
                        <option value="10000-20000">₹10,000 - ₹20,000</option>
                        <option value="20000-30000">₹20,000 - ₹30,000</option>
                        <option value="30000+">Above ₹30,000</option>
                    </select>
                </div>
                <button type="submit" class="search-btn">🔍 Search</button>
            </form>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features" id="services">
        <div class="container">
            <h2 class="section-title">Why Choose StayZen?</h2>
            <div class="features-grid">
                <div class="feature-card animate-on-scroll">
                    <div class="feature-icon">🏆</div>
                    <h3>Premium Quality</h3>
                    <p>Handpicked properties with verified amenities and top-notch facilities for your comfort</p>
                </div>
                <div class="feature-card animate-on-scroll">
                    <div class="feature-icon">⚡</div>
                    <h3>Instant Booking</h3>
                    <p>Book your ideal PG in just a few clicks with our streamlined booking process</p>
                </div>
                <div class="feature-card animate-on-scroll">
                    <div class="feature-icon">🔒</div>
                    <h3>Secure & Safe</h3>
                    <p>All properties are security verified with 24/7 support and safe payment options</p>
                </div>
                <div class="feature-card animate-on-scroll">
                    <div class="feature-icon">💰</div>
                    <h3>Best Prices</h3>
                    <p>Competitive pricing with exclusive deals and no hidden charges guaranteed</p>
                </div>
                <div class="feature-card animate-on-scroll">
                    <div class="feature-icon">📱</div>
                    <h3>Smart Technology</h3>
                    <p>AI-powered recommendations and virtual tours to help you find the perfect match</p>
                </div>
                <div class="feature-card animate-on-scroll">
                    <div class="feature-icon">🎯</div>
                    <h3>Personalized Service</h3>
                    <p>Dedicated support team to assist you throughout your stay and beyond</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Properties Section -->
    <section class="properties" id="properties">
        <div class="container">
            <h2 class="section-title">Featured Properties</h2>
            <div class="properties-grid" id="propertiesGrid">
                <!-- Properties will be loaded dynamically -->
            </div>
        </div>
    </section>

    <!-- Dashboard Section -->
    <section class="dashboard" id="dashboard">
        <div class="container">
            <h2 class="section-title">User Dashboard</h2>
            <div class="dashboard-grid">
                <div class="dashboard-sidebar">
                    <h3 style="margin-bottom: 1rem; color: #333;">Quick Actions</h3>
                    <ul class="sidebar-menu">
                        <li class="active" onclick="showDashboardSection('overview')">📊 Overview</li>
                        <li onclick="showDashboardSection('bookings')">🏠 My Bookings</li>
                        <li onclick="showDashboardSection('favorites')">❤️ Favorites</li>
                        <li onclick="showDashboardSection('payments')">💳 Payments</li>
                        <li onclick="showDashboardSection('profile')">👤 Profile</li>
                        <li onclick="showDashboardSection('support')">🆘 Support</li>
                    </ul>
                </div>
                <div class="dashboard-content" id="dashboardContent">
                    <!-- Dashboard content will be loaded dynamically -->
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer id="contact">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3>StayZen</h3>
                    <p>Your trusted partner in finding the perfect PG accommodation with premium amenities and unmatched service.</p>
                </div>
                <div class="footer-section">
                    <h3>Quick Links</h3>
                    <a href="#home">Home</a>
                    <a href="#properties">Properties</a>
                    <a href="#services">Services</a>
                    <a href="#dashboard">Dashboard</a>
                </div>
                <div class="footer-section">
                    <h3>Support</h3>
                    <a href="#">Help Center</a>
                    <a href="#">Contact Us</a>
                    <a href="#">Terms & Conditions</a>
                    <a href="#">Privacy Policy</a>
                </div>
                <div class="footer-section">
                    <h3>Connect With Us</h3>
                    <a href="#">📧 info@stayzen.com</a>
                    <a href="#">📞 +91 98765 43210</a>
                    <a href="#">📍 Mumbai, Maharashtra</a>
                </div>
            </div>
            <div style="border-top: 1px solid #333; padding-top: 1rem; margin-top: 2rem;">
                <p>&copy; 2025 StayZen. All rights reserved. Designed with ❤️ for the best user experience.</p>
            </div>
        </div>
    </footer>

    <!-- Login Modal -->
    <div id="loginModal" class="modal">
        <div class="modal-content">
            <button class="close" onclick="closeModal('loginModal')">&times;</button>
            <h2 style="margin-bottom: 1rem; color: #333;">Welcome Back!</h2>
            <form onsubmit="handleLogin(event)">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" required>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Login</button>
            </form>
            <p style="text-align: center; margin-top: 1rem; color: #666;">
                Don't have an account? <a href="#" onclick="closeModal('loginModal'); openModal('signupModal')" style="color: #667eea;">Sign up</a>
            </p>
        </div>
    </div>

    <!-- Signup Modal -->
    <div id="signupModal" class="modal">
        <div class="modal-content">
            <button class="close" onclick="closeModal('signupModal')">&times;</button>
            <h2 style="margin-bottom: 1rem; color: #333;">Join StayZen!</h2>
            <form onsubmit="handleSignup(event)">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" required>
                </div>
                <div class="form-group">
                    <label for="signupEmail">Email</label>
                    <input type="email" id="signupEmail" required>
                </div>
                <div class="form-group">
                    <label for="signupPassword">Password</label>
                    <input type="password" id="signupPassword" required>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Sign Up</button>
            </form>
            <p style="text-align: center; margin-top: 1rem; color: #666;">
                Already have an account? <a href="#" onclick="closeModal('signupModal'); openModal('loginModal')" style="color: #667eea;">Login</a>
            </p>
        </div>
    </div>

    <script>
        // Sample data
        const properties = [
            {
                id: 1,
                title: "Luxury PG in Bandra",
                location: "Bandra West, Mumbai",
                price: "₹25,000",
                badge: "Premium",
                amenities: ["WiFi", "AC", "Laundry", "Food", "Gym"]
            },
            {
                id: 2,
                title: "Modern Stay in Koramangala",
                location: "Koramangala, Bangalore",
                price: "₹18,000",
                badge: "Popular",
                amenities: ["WiFi", "AC", "Food", "Security"]
            },
            {
                id: 3,
                title: "Comfortable PG in Gurgaon",
                location: "Sector 14, Gurgaon",
                price: "₹22,000",
                badge: "New",
                amenities: ["WiFi", "AC", "Laundry", "Food", "Parking"]
            },
            {
                id: 4,
                title: "Budget Friendly in Pune",
                location: "Kothrud, Pune",
                price: "₹12,000",
                badge: "Budget",
                amenities: ["WiFi", "Food", "Security", "Laundry"]
            }
        ];

        // Load properties
      

        // Dashboard sections
        const dashboardSections = {
            overview: `
                <h3>Dashboard Overview</h3>
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-number">3</div>
                        <div>Active Bookings</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">12</div>
                        <div>Favorite Properties</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">₹45,000</div>
                        <div>Total Spent</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">4.8</div>
                        <div>Average Rating</div>
                    </div>
                </div>
                <div style="margin-top: 2rem;">
                    <h4 style="margin-bottom: 1rem;">Recent Activity</h4>
                    <div style="background: #f8f9fa; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                        <strong>Booking Confirmed</strong> - Luxury PG in Bandra<br>
                        <small style="color: #666;">2 hours ago</small>
                    </div>
                    <div style="background: #f8f9fa; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                        <strong>Payment Successful</strong> - ₹25,000 for March 2025<br>
                        <small style="color: #666;">1 day ago</small>
                    </div>
                    <div style="background: #f8f9fa; padding: 1rem; border-radius: 8px;">
                        <strong>Property Added to Favorites</strong> - Modern Stay in Koramangala<br>
                        <small style="color: #666;">3 days ago</small>
                    </div>
                </div>
            `,
            bookings: `
                <h3>My Bookings</h3>
                <div style="display: grid; gap: 1rem; margin-top: 1rem;">
                    <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 12px; border-left: 4px solid #28a745;">
                        <div style="display: flex; justify-content: space-between; align-items: start;">
                            <div>
                                <h4 style="color: #333; margin-bottom: 0.5rem;">Luxury PG in Bandra</h4>
                                <p style="color: #666; margin-bottom: 0.5rem;">📍 Bandra West, Mumbai</p>
                                <p style="color: #666; margin-bottom: 0.5rem;">📅 March 1, 2025 - March 31, 2025</p>
                                <span style="background: #28a745; color: white; padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.8rem;">Active</span>
                            </div>
                            <div style="text-align: right;">
                                <div style="font-size: 1.2rem; font-weight: bold; color: #667eea;">₹25,000</div>
                                <button class="btn btn-secondary" style="margin-top: 0.5rem; padding: 0.5rem 1rem;">View Details</button>
                            </div>
                        </div>
                    </div>
                    <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 12px; border-left: 4px solid #ffc107;">
                        <div style="display: flex; justify-content: space-between; align-items: start;">
                            <div>
                                <h4 style="color: #333; margin-bottom: 0.5rem;">Modern Stay in Koramangala</h4>
                                <p style="color: #666; margin-bottom: 0.5rem;">📍 Koramangala, Bangalore</p>
                                <p style="color: #666; margin-bottom: 0.5rem;">📅 April 1, 2025 - April 30, 2025</p>
                                <span style="background: #ffc107; color: white; padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.8rem;">Pending</span>
                            </div>
                            <div style="text-align: right;">
                                <div style="font-size: 1.2rem; font-weight: bold; color: #667eea;">₹18,000</div>
                                <button class="btn btn-primary" style="margin-top: 0.5rem; padding: 0.5rem 1rem;">Pay Now</button>
                            </div>
                        </div>
                    </div>
                    <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 12px; border-left: 4px solid #dc3545;">
                        <div style="display: flex; justify-content: space-between; align-items: start;">
                            <div>
                                <h4 style="color: #333; margin-bottom: 0.5rem;">Budget PG in Pune</h4>
                                <p style="color: #666; margin-bottom: 0.5rem;">📍 Kothrud, Pune</p>
                                <p style="color: #666; margin-bottom: 0.5rem;">📅 February 1, 2025 - February 28, 2025</p>
                                <span style="background: #dc3545; color: white; padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.8rem;">Completed</span>
                            </div>
                            <div style="text-align: right;">
                                <div style="font-size: 1.2rem; font-weight: bold; color: #667eea;">₹12,000</div>
                                <button class="btn btn-secondary" style="margin-top: 0.5rem; padding: 0.5rem 1rem;">Rate & Review</button>
                            </div>
                        </div>
                    </div>
                </div>
            `,
            favorites: `
                <h3>My Favorite Properties</h3>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1rem; margin-top: 1rem;">
                    <div style="background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                        <div style="height: 120px; background: linear-gradient(45deg, #667eea, #764ba2); position: relative;">
                            <div style="position: absolute; top: 1rem; right: 1rem; background: rgba(255,255,255,0.9); padding: 0.3rem 0.8rem; border-radius: 15px; font-size: 0.8rem; color: #667eea; font-weight: 600;">Premium</div>
                            <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 2rem;">🏠</div>
                        </div>
                        <div style="padding: 1rem;">
                            <h4 style="margin-bottom: 0.5rem;">Luxury PG in Bandra</h4>
                            <p style="color: #666; margin-bottom: 0.5rem;">📍 Bandra West, Mumbai</p>
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <span style="font-weight: bold; color: #667eea;">₹25,000/month</span>
                                <button class="btn btn-primary" style="padding: 0.5rem 1rem;">Book Now</button>
                            </div>
                        </div>
                    </div>
                    <div style="background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                        <div style="height: 120px; background: linear-gradient(45deg, #667eea, #764ba2); position: relative;">
                            <div style="position: absolute; top: 1rem; right: 1rem; background: rgba(255,255,255,0.9); padding: 0.3rem 0.8rem; border-radius: 15px; font-size: 0.8rem; color: #667eea; font-weight: 600;">Popular</div>
                            <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 2rem;">🏢</div>
                        </div>
                        <div style="padding: 1rem;">
                            <h4 style="margin-bottom: 0.5rem;">Modern Stay in Koramangala</h4>
                            <p style="color: #666; margin-bottom: 0.5rem;">📍 Koramangala, Bangalore</p>
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <span style="font-weight: bold; color: #667eea;">₹18,000/month</span>
                                <button class="btn btn-primary" style="padding: 0.5rem 1rem;">Book Now</button>
                            </div>
                        </div>
                    </div>
                </div>
            `,
            payments: `
                <h3>Payment History</h3>
                <div style="margin-top: 1rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                        <h4>Recent Transactions</h4>
                        <button class="btn btn-primary">Download Statement</button>
                    </div>
                    <div style="background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                        <div style="background: #f8f9fa; padding: 1rem; border-bottom: 1px solid #e9ecef; font-weight: 600; display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 1rem;">
                            <div>Description</div>
                            <div>Amount</div>
                            <div>Date</div>
                            <div>Status</div>
                        </div>
                        <div style="padding: 1rem; border-bottom: 1px solid #f0f0f0; display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 1rem; align-items: center;">
                            <div>
                                <div style="font-weight: 500;">Luxury PG in Bandra - March 2025</div>
                                <div style="font-size: 0.8rem; color: #666;">Monthly Rent Payment</div>
                            </div>
                            <div style="font-weight: bold; color: #667eea;">₹25,000</div>
                            <div>Mar 1, 2025</div>
                            <div><span style="background: #28a745; color: white; padding: 0.3rem 0.8rem; border-radius: 15px; font-size: 0.8rem;">Success</span></div>
                        </div>
                        <div style="padding: 1rem; border-bottom: 1px solid #f0f0f0; display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 1rem; align-items: center;">
                            <div>
                                <div style="font-weight: 500;">Security Deposit - Luxury PG</div>
                                <div style="font-size: 0.8rem; color: #666;">One-time Security Deposit</div>
                            </div>
                            <div style="font-weight: bold; color: #667eea;">₹50,000</div>
                            <div>Feb 28, 2025</div>
                            <div><span style="background: #28a745; color: white; padding: 0.3rem 0.8rem; border-radius: 15px; font-size: 0.8rem;">Success</span></div>
                        </div>
                        <div style="padding: 1rem; display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 1rem; align-items: center;">
                            <div>
                                <div style="font-weight: 500;">Budget PG in Pune - February 2025</div>
                                <div style="font-size: 0.8rem; color: #666;">Monthly Rent Payment</div>
                            </div>
                            <div style="font-weight: bold; color: #667eea;">₹12,000</div>
                            <div>Feb 1, 2025</div>
                            <div><span style="background: #28a745; color: white; padding: 0.3rem 0.8rem; border-radius: 15px; font-size: 0.8rem;">Success</span></div>
                        </div>
                    </div>
                </div>
            `,
            profile: `
                <h3>My Profile</h3>
                <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 2rem; margin-top: 1rem;">
                    <div style="background: white; padding: 1.5rem; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); text-align: center;">
                        <div style="width: 80px; height: 80px; background: linear-gradient(45deg, #667eea, #764ba2); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; font-size: 2rem; color: white;">👤</div>
                        <h4 style="margin-bottom: 0.5rem;">Rahul Kumar</h4>
                        <p style="color: #666; margin-bottom: 1rem;">Premium Member</p>
                        <button class="btn btn-secondary" style="width: 100%;">Change Photo</button>
                    </div>
                    <div style="background: white; padding: 1.5rem; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                        <h4 style="margin-bottom: 1rem;">Personal Information</h4>
                        <div style="display: grid; gap: 1rem;">
                            <div class="form-group">
                                <label for="fullName">Full Name</label>
                                <input type="text" id="fullName" value="Rahul Kumar" style="padding: 0.8rem; border: 2px solid #e1e5e9; border-radius: 8px; width: 100%;">
                            </div>
                            <div class="form-group">
                                <label for="profileEmail">Email</label>
                                <input type="email" id="profileEmail" value="rahul@example.com" style="padding: 0.8rem; border: 2px solid #e1e5e9; border-radius: 8px; width: 100%;">
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone</label>
                                <input type="tel" id="phone" value="+91 98765 43210" style="padding: 0.8rem; border: 2px solid #e1e5e9; border-radius: 8px; width: 100%;">
                            </div>
                            <div class="form-group">
                                <label for="occupation">Occupation</label>
                                <input type="text" id="occupation" value="Software Engineer" style="padding: 0.8rem; border: 2px solid #e1e5e9; border-radius: 8px; width: 100%;">
                            </div>
                            <button class="btn btn-primary" style="margin-top: 1rem;">Update Profile</button>
                        </div>
                    </div>
                </div>
            `,
            support: `
                <h3>Support Center</h3>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem; margin-top: 1rem;">
                    <div style="background: white; padding: 1.5rem; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); text-align: center;">
                        <div style="font-size: 2rem; margin-bottom: 1rem;">📞</div>
                        <h4 style="margin-bottom: 0.5rem;">Call Support</h4>
                        <p style="color: #666; margin-bottom: 1rem;">Get instant help from our support team</p>
                        <button class="btn btn-primary" onclick="alert('Calling +91 98765 43210...')">Call Now</button>
                    </div>
                    <div style="background: white; padding: 1.5rem; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); text-align: center;">
                        <div style="font-size: 2rem; margin-bottom: 1rem;">💬</div>
                        <h4 style="margin-bottom: 0.5rem;">Live Chat</h4>
                        <p style="color: #666; margin-bottom: 1rem;">Chat with our support representatives</p>
                        <button class="btn btn-primary" onclick="alert('Opening chat window...')">Start Chat</button>
                    </div>
                    <div style="background: white; padding: 1.5rem; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); text-align: center;">
                        <div style="font-size: 2rem; margin-bottom: 1rem;">📧</div>
                        <h4 style="margin-bottom: 0.5rem;">Email Support</h4>
                        <p style="color: #666; margin-bottom: 1rem;">Send us an email with your query</p>
                        <button class="btn btn-primary" onclick="window.location.href='mailto:support@stayzen.com'">Send Email</button>
                    </div>
                </div>
                <div style="background: white; padding: 1.5rem; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); margin-top: 2rem;">
                    <h4 style="margin-bottom: 1rem;">Frequently Asked Questions</h4>
                    <div style="border: 1px solid #e9ecef; border-radius: 8px; overflow: hidden;">
                        <div style="padding: 1rem; border-bottom: 1px solid #e9ecef; cursor: pointer;" onclick="toggleFAQ(1)">
                            <strong>How do I cancel my booking?</strong>
                        </div>
                        <div id="faq1" style="display: none; padding: 1rem; background: #f8f9fa; border-bottom: 1px solid #e9ecef;">
                            You can cancel your booking by going to 'My Bookings' section and clicking on 'Cancel Booking'. Please check our cancellation policy for refund details.
                        </div>
                        <div style="padding: 1rem; border-bottom: 1px solid #e9ecef; cursor: pointer;" onclick="toggleFAQ(2)">
                            <strong>What amenities are included?</strong>
                        </div>
                        <div id="faq2" style="display: none; padding: 1rem; background: #f8f9fa; border-bottom: 1px solid #e9ecef;">
                            Amenities vary by property but typically include WiFi, AC, meals, laundry, housekeeping, and security. Check individual property details for specific amenities.
                        </div>
                        <div style="padding: 1rem; cursor: pointer;" onclick="toggleFAQ(3)">
                            <strong>How do I make payments?</strong>
                        </div>
                        <div id="faq3" style="display: none; padding: 1rem; background: #f8f9fa;">
                            We accept all major credit cards, debit cards, UPI, and net banking. Payments are secured with 256-bit SSL encryption.
                        </div>
                    </div>
                </div>
            `
        };

        // Functions
        function openModal(modalId) {
            document.getElementById(modalId).style.display = 'block';
        }

        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
        }

        function searchProperties(event) {
            event.preventDefault();
            const location = document.getElementById('location').value;
            const checkin = document.getElementById('checkin').value;
            const budget = document.getElementById('budget').value;
            
            if (location && checkin && budget) {
                alert(`🔍 Searching for properties in ${location} from ${checkin} within budget ${budget}...\n\nFound ${properties.length} matching properties!`);
                document.getElementById('properties').scrollIntoView({ behavior: 'smooth' });
            }
        }

        function showDashboardSection(section) {
            // Remove active class from all sidebar items
            document.querySelectorAll('.sidebar-menu li').forEach(item => {
                item.classList.remove('active');
            });
            
            // Add active class to clicked item
            event.target.classList.add('active');
            
            // Update dashboard content
            document.getElementById('dashboardContent').innerHTML = dashboardSections[section];
        }

        function viewProperty(propertyId) {
            const property = properties.find(p => p.id === propertyId);
            if (property) {
                alert(`🏠 Viewing: ${property.title}\n📍 Location: ${property.location}\n💰 Price: ${property.price}/month\n🏷️ Amenities: ${property.amenities.join(', ')}\n\nWould you like to book this property?`);
            }
        }

        function handleLogin(event) {
            event.preventDefault();
            const email = document.getElementById('email').value;
            alert(`✅ Welcome back! Logged in successfully as ${email}`);
            closeModal('loginModal');
        }

        function handleSignup(event) {
            event.preventDefault();
            const name = document.getElementById('name').value;
            const email = document.getElementById('signupEmail').value;
            alert(`🎉 Welcome to StayZen, ${name}! Account created successfully with email: ${email}`);
            closeModal('signupModal');
        }

        function toggleFAQ(faqNumber) {
            const faq = document.getElementById(`faq${faqNumber}`);
            faq.style.display = faq.style.display === 'none' ? 'block' : 'none';
        }

        // Animation on scroll
        function animateOnScroll() {
            const elements = document.querySelectorAll('.animate-on-scroll');
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.animationDelay = Math.random() * 0.5 + 's';
                        entry.target.style.opacity = '1';
                        entry.target.style.animation = 'fadeInUp 0.8s ease-out forwards';
                    }
                });
            });

            elements.forEach(element => {
                observer.observe(element);
            });
        }

        // Header scroll effect
        function handleHeaderScroll() {
            const header = document.querySelector('header');
            if (window.scrollY > 100) {
                header.style.background = 'rgba(255, 255, 255, 0.98)';
                header.style.boxShadow = '0 2px 20px rgba(0, 0, 0, 0.1)';
            } else {
                header.style.background = 'rgba(255, 255, 255, 0.95)';
                header.style.boxShadow = 'none';
            }
        }

        // Initialize
        window.addEventListener('load', () => {
            loadProperties();
            showDashboardSection('overview');
            animateOnScroll();
        });

        window.addEventListener('scroll', handleHeaderScroll);

        // Smooth scrolling for navigation links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Close modal when clicking outside
        window.addEventListener('click', (event) => {
            if (event.target.classList.contains('modal')) {
                event.target.style.display = 'none';
            }
        });

        // Set minimum date to today
        document.getElementById('checkin').min = new Date().toISOString().split('T')[0];
    </script>
</body>
</html>