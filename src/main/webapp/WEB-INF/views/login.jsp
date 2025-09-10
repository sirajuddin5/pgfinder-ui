<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Account - PgFinder</title>
    
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Style.css -->
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
</head>
<body>
    <!-- Floating particles for visual appeal -->
    <div class="particle" style="top: 10%; left: 10%; width: 6px; height: 6px; animation-delay: 0s;"></div>
    <div class="particle" style="top: 20%; right: 20%; width: 8px; height: 8px; animation-delay: 2s;"></div>
    <div class="particle" style="bottom: 10%; left: 30%; width: 4px; height: 4px; animation-delay: 4s;"></div>
    <div class="particle" style="bottom: 30%; right: 10%; width: 10px; height: 10px; animation-delay: 1s;"></div>

    <div class="registration-container">
        <!-- Header -->
        <div class="form-header">
            <div class="logo-icon">
                <i class="fas fa-building"></i>
            </div>
            <h2>Join PgFinder</h2>
            <p>Create your account to get started</p>
        </div>

        <!-- Form Body -->
        <div class="form-body">
            <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
                <!-- Username -->
                <div class="form-group">
                    <label for="username">Username or Email</label>
                    <div class="input-wrapper">
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" id="username" name="username" class="form-input" 
                               required minlength="3" maxlength="64" 
                               placeholder="Enter your username"/>
                        <i class="fas fa-check success-icon"></i>
                    </div>
                    <div class="error-message">Username must be 3-64 characters long</div>
                </div>

                <!-- Password -->
                <div class="form-group">
                    <label for="passwordHash">Password</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="passwordHash" name="passwordHash" class="form-input" 
                               required placeholder="Create a strong password"/>
                        <i class="fas fa-eye" id="togglePassword" style="position: absolute; right: 12px; top: 50%; transform: translateY(-50%); cursor: pointer; color: #64748b;"></i>
                    </div>
                    <div class="password-strength">
                        <div class="strength-bar"></div>
                    </div>
                    <div class="error-message">Password must be at least 6 characters long</div>
                </div>

               
                <!-- Submit Button -->
                <button type="submit" class="submit-btn" id="submitBtn">
                    <div class="loading-spinner"></div>
                    <span>Login Account</span>
                </button>
            </form>
        </div>

        <!-- Footer -->
        <div class="form-footer">
            <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Sign up here</a></p>
        </div>
    </div>
	<script src="js/login.js"></script>
</body>
</html>