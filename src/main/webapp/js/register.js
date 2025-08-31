/*
$(document).ready(function () {
    // Role field par visibility toggle karna
    function handleRoleChange() {
        var role = $("#roles").val();
        if (role === "OWNER") {
            $("#ownerIdField").show();
            $("#tenantIdField").hide();
        } else if (role === "USER") {
            $("#ownerIdField").hide();
            $("#tenantIdField").show();
        } else {
            $("#ownerIdField").hide();
            $("#tenantIdField").hide();
        }
    }

    // Initial visibility set
    handleRoleChange();

    // Change handler for role dropdown
    $("#roles").change(function () {
        handleRoleChange();
    });

    // Form submission handler
    $("form").submit(function (event) {
        event.preventDefault();

        var username = $("#username").val().trim();
        var email = $("#email").val().trim();
        var password = $("#password").val().trim();
        var fullName = $("#fullName").val().trim();
        var phone = $("#phone").val().trim();
        var role = $("#roles").val();

        // Validation
        if (username.length < 3) {
            alert("Username must be at least 3 characters.");
            $("#username").focus();
            return;
        }

        if (email.length === 0) {
            alert("Email is required.");
            $("#email").focus();
            return;
        }

        if (password.length === 0) {
            alert("Password is required.");
            $("#password").focus();
            return;
        }

        handleRoleChange(); // re-check visibility

        // Prepare data
        var inputParams = {
            username: username,
            email: email,
            password: password,
            fullName: fullName,
            phone: phone,
            roles: [role] // API expects array
        };

        // Optional: Include ownerId/tenantId if visible
        if (role === "OWNER") {
            var ownerId = $("#ownerId").val().trim();
            if (ownerId) {
                inputParams.ownerId = parseInt(ownerId);
            }
        } else if (role === "USER") {
            var tenantId = $("#tenantId").val().trim();
            if (tenantId) {
                inputParams.tenantId = parseInt(tenantId);
            }
        }

        console.log("Sending data:", inputParams);
        $("#loading").show();

        // AJAX call
        $.ajax({
            type: "POST",
            url: "pgFinderRest/register",
            data: JSON.stringify(inputParams),
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                $("#loading").hide();
                console.log("Success:", response);
                alert("Registration successful!");
                $("form")[0].reset();
                handleRoleChange(); // Reset fields visibility
            },
            error: function (xhr, status, error) {
                $("#loading").hide();
                console.error("Error:", error);
                alert("Registration failed: " + (xhr.responseJSON?.message || error));
            }
        });
    });
});
*/

/*
$(document).ready(function() {
            // Role field visibility handler - updated for modern design
            function handleRoleChange() {
                const role = $("#roles").val();
                const ownerField = $("#ownerIdField");
                const tenantField = $("#tenantIdField");
                
                // Hide all conditional fields first with smooth animation
                ownerField.removeClass('show');
                tenantField.removeClass('show');
                
                // Show appropriate field based on role with delay for smooth transition
                if (role === "OWNER") {
                    setTimeout(() => ownerField.addClass('show'), 100);
                } else if (role === "USER") {
                    setTimeout(() => tenantField.addClass('show'), 100);
                }
            }

            // Initial setup
            handleRoleChange();

            // Role change handler
            $("#roles").on('change', function() {
                handleRoleChange();
            });

            // Password visibility toggle
            $('#togglePassword').on('click', function() {
                const passwordField = $('#passwordHash');
                const type = passwordField.attr('type') === 'password' ? 'text' : 'password';
                passwordField.attr('type', type);
                $(this).toggleClass('fa-eye fa-eye-slash');
            });

            // Password strength indicator
            $('#passwordHash').on('input', function() {
                const password = $(this).val();
                const strengthBar = $('.strength-bar');
                const strengthContainer = $('.password-strength');
                
                if (password.length > 0) {
                    strengthContainer.addClass('show');
                    
                    let strength = 0;
                    if (password.length >= 6) strength++;
                    if (password.match(/[a-z]/)) strength++;
                    if (password.match(/[A-Z]/)) strength++;
                    if (password.match(/[0-9]/)) strength++;
                    if (password.match(/[^a-zA-Z0-9]/)) strength++;
                    
                    strengthBar.removeClass('strength-weak strength-fair strength-good strength-strong');
                    
                    if (strength <= 2) {
                        strengthBar.addClass('strength-weak');
                    } else if (strength <= 3) {
                        strengthBar.addClass('strength-fair');
                    } else if (strength <= 4) {
                        strengthBar.addClass('strength-good');
                    } else {
                        strengthBar.addClass('strength-strong');
                    }
                } else {
                    strengthContainer.removeClass('show');
                }
            });

            // Real-time validation on blur
            $('.form-input').on('blur', function() {
                validateField($(this));
            });

            // Form submission - updated with your backend logic
            $('#registrationForm').on('submit', function(event) {
                event.preventDefault();

                // Get form values
                const username = $("#username").val().trim();
                const email = $("#email").val().trim();
                const password = $("#passwordHash").val().trim();
                const fullName = $("#fullName").val().trim();
                const phone = $("#phone").val().trim();
                const role = $("#roles").val();

                // Client-side validation
                if (username.length < 3) {
                    showError("Username must be at least 3 characters.");
                    $("#username").focus();
                    return;
                }

                if (email.length === 0) {
                    showError("Email is required.");
                    $("#email").focus();
                    return;
                }

                if (password.length === 0) {
                    showError("Password is required.");
                    $("#passwordHash").focus();
                    return;
                }

                // Show loading state
                const submitBtn = $('#submitBtn');
                const spinner = $('.loading-spinner');
                const buttonText = submitBtn.find('span');
                
                submitBtn.prop('disabled', true);
                spinner.show();
                buttonText.text('Creating Account...');

                // Prepare data for API
                const inputParams = {
                    username: username,
                    email: email,
                    password: password,
                    fullName: fullName,
                    phone: phone,
                    roles: [role] // API expects array
                };

                // Include role-specific IDs if provided
                if (role === "OWNER") {
                    const ownerId = $("#ownerId").val().trim();
                    if (ownerId) {
                        inputParams.ownerId = parseInt(ownerId);
                    }
                } else if (role === "USER") {
                    const tenantId = $("#tenantId").val().trim();
                    if (tenantId) {
                        inputParams.tenantId = parseInt(tenantId);
                    }
                }

                console.log("Sending data:", inputParams);

                // AJAX call to backend
                $.ajax({
                    type: "POST",
                    url: "pgFinderRest/register",
                    data: JSON.stringify(inputParams),
                    contentType: "application/json; charset=utf-8",
                    success: function(response) {
                        // Hide loading state
                        submitBtn.prop('disabled', false);
                        spinner.hide();
                        buttonText.text('Create Account');

                        console.log("Success:", response);
                        showSuccess("Registration successful! Welcome to PropertyHub!");
                        
                        // Reset form
                        $("#registrationForm")[0].reset();
                        handleRoleChange(); // Reset field visibility
                        
                        // Reset all validation states
                        $('.form-input').removeClass('error success');
                        $('.error-message').hide();
                        $('.password-strength').removeClass('show');
                    },
                    error: function(xhr, status, error) {
                        // Hide loading state
                        submitBtn.prop('disabled', false);
                        spinner.hide();
                        buttonText.text('Create Account');

                        console.error("Error:", error);
                        const errorMessage = xhr.responseJSON?.message || error || "Registration failed. Please try again.";
                        showError("Registration failed: " + errorMessage);
                    }
                });
            });

            // Field validation function
            function validateField($field) {
                const value = $field.val().trim();
                const fieldName = $field.attr('name');
                let isValid = true;
                
                // Remove previous states
                $field.removeClass('error success');
                $field.siblings('.error-message').hide();
                
                // Required field check
                if ($field.prop('required') && !value) {
                    isValid = false;
                }
                
                // Specific validations
                switch (fieldName) {
                    case 'username':
                        if (value && (value.length < 3 || value.length > 64)) {
                            isValid = false;
                        }
                        break;
                    case 'email':
                        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                        if (value && !emailRegex.test(value)) {
                            isValid = false;
                        }
                        break;
                    case 'passwordHash':
                        if (value && value.length < 6) {
                            isValid = false;
                        }
                        break;
                    case 'phone':
                        const phoneRegex = /^\+?[\d\s\-\(\)]+$/;
                        if (value && !phoneRegex.test(value)) {
                            isValid = false;
                        }
                        break;
                }
                
                // Apply validation state
                if (isValid && value) {
                    $field.addClass('success');
                } else if (!isValid) {
                    $field.addClass('error');
                    $field.siblings('.error-message').show();
                }
                
                return isValid;
            }

            // Modern notification functions
            function showError(message) {
                // Create modern error notification
                const notification = $(`
                    <div class="notification error-notification" style="
                        position: fixed;
                        top: 20px;
                        right: 20px;
                        background: linear-gradient(135deg, #ff6b6b, #ee5a52);
                        color: white;
                        padding: 1rem 1.5rem;
                        border-radius: 12px;
                        box-shadow: 0 10px 25px rgba(239, 68, 68, 0.3);
                        z-index: 1000;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                        transform: translateX(100%);
                        transition: transform 0.3s ease;
                    ">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>${message}</span>
                    </div>
                `);
                
                $('body').append(notification);
                
                // Animate in
                setTimeout(() => {
                    notification.css('transform', 'translateX(0)');
                }, 100);
                
                // Auto remove after 5 seconds
                setTimeout(() => {
                    notification.css('transform', 'translateX(100%)');
                    setTimeout(() => notification.remove(), 300);
                }, 5000);
            }

            function showSuccess(message) {
                // Create modern success notification
                const notification = $(`
                    <div class="notification success-notification" style="
                        position: fixed;
                        top: 20px;
                        right: 20px;
                        background: linear-gradient(135deg, #10b981, #059669);
                        color: white;
                        padding: 1rem 1.5rem;
                        border-radius: 12px;
                        box-shadow: 0 10px 25px rgba(16, 185, 129, 0.3);
                        z-index: 1000;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                        transform: translateX(100%);
                        transition: transform 0.3s ease;
                    ">
                        <i class="fas fa-check-circle"></i>
                        <span>${message}</span>
                    </div>
                `);
                
                $('body').append(notification);
                
                // Animate in
                setTimeout(() => {
                    notification.css('transform', 'translateX(0)');
                }, 100);
                
                // Auto remove after 5 seconds
                setTimeout(() => {
                    notification.css('transform', 'translateX(100%)');
                    setTimeout(() => notification.remove(), 300);
                }, 5000);
            }

            // Add floating animation to particles
            $('.particle').each(function(index) {
                $(this).css('animation-delay', (index * 0.5) + 's');
            });
        });*/
		
		$(document).ready(function() {
		    // Role field visibility handler - updated for modern design
		    function handleRoleChange() {
		        const role = $("#roles").val();
		        const ownerField = $("#ownerIdField");
		        const tenantField = $("#tenantIdField");
		        
		        // Hide all conditional fields first with smooth animation
		        ownerField.removeClass('show');
		        tenantField.removeClass('show');
		        
		        // Show appropriate field based on role with delay for smooth transition
		        if (role === "OWNER") {
		            setTimeout(() => ownerField.addClass('show'), 100);
		        } else if (role === "USER") {
		            setTimeout(() => tenantField.addClass('show'), 100);
		        }
		    }

		    // Initial setup
		    handleRoleChange();

		    // Role change handler
		    $("#roles").on('change', function() {
		        handleRoleChange();
		    });

		    // Password visibility toggle
		    $('#togglePassword').on('click', function() {
		        const passwordField = $('#passwordHash');
		        const type = passwordField.attr('type') === 'password' ? 'text' : 'password';
		        passwordField.attr('type', type);
		        $(this).toggleClass('fa-eye fa-eye-slash');
		    });

		    // Password strength indicator
		    $('#passwordHash').on('input', function() {
		        const password = $(this).val();
		        const strengthBar = $('.strength-bar');
		        const strengthContainer = $('.password-strength');
		        
		        if (password.length > 0) {
		            strengthContainer.addClass('show');
		            
		            let strength = 0;
		            if (password.length >= 6) strength++;
		            if (password.match(/[a-z]/)) strength++;
		            if (password.match(/[A-Z]/)) strength++;
		            if (password.match(/[0-9]/)) strength++;
		            if (password.match(/[^a-zA-Z0-9]/)) strength++;
		            
		            strengthBar.removeClass('strength-weak strength-fair strength-good strength-strong');
		            
		            if (strength <= 2) {
		                strengthBar.addClass('strength-weak');
		            } else if (strength <= 3) {
		                strengthBar.addClass('strength-fair');
		            } else if (strength <= 4) {
		                strengthBar.addClass('strength-good');
		            } else {
		                strengthBar.addClass('strength-strong');
		            }
		        } else {
		            strengthContainer.removeClass('show');
		        }
		    });

		    // Real-time validation on blur
		    $('.form-input').on('blur', function() {
		        validateField($(this));
		    });

		    // Form submission - updated with role-based redirect logic
		    $('#registrationForm').on('submit', function(event) {
		        event.preventDefault();

		        // Get form values
		        const username = $("#username").val().trim();
		        const email = $("#email").val().trim();
		        const password = $("#passwordHash").val().trim();
		        const fullName = $("#fullName").val().trim();
		        const phone = $("#phone").val().trim();
		        const role = $("#roles").val();

		        // Client-side validation
		        if (username.length < 3) {
		            showError("Username must be at least 3 characters.");
		            $("#username").focus();
		            return;
		        }

		        if (email.length === 0) {
		            showError("Email is required.");
		            $("#email").focus();
		            return;
		        }

		        if (password.length === 0) {
		            showError("Password is required.");
		            $("#passwordHash").focus();
		            return;
		        }

		        // Show loading state
		        const submitBtn = $('#submitBtn');
		        const spinner = $('.loading-spinner');
		        const buttonText = submitBtn.find('span');
		        
		        submitBtn.prop('disabled', true);
		        spinner.show();
		        buttonText.text('Creating Account...');

		        // Prepare data for API
		        const inputParams = {
		            username: username,
		            email: email,
		            password: password,
		            fullName: fullName,
		            phone: phone,
		            roles: [role] // API expects array
		        };

		        // Include role-specific IDs if provided
		        if (role === "OWNER") {
		            const ownerId = $("#ownerId").val().trim();
		            if (ownerId) {
		                inputParams.ownerId = parseInt(ownerId);
		            }
		        } else if (role === "USER") {
		            const tenantId = $("#tenantId").val().trim();
		            if (tenantId) {
		                inputParams.tenantId = parseInt(tenantId);
		            }
		        }

		        console.log("Sending data:", inputParams);

		        // AJAX call to backend
		        $.ajax({
		            type: "POST",
		            url: "pgFinderRest/register",
		            data: JSON.stringify(inputParams),
		            contentType: "application/json; charset=utf-8",
		            success: function(response) {
		                // Hide loading state
		                submitBtn.prop('disabled', false);
		                spinner.hide();
		                buttonText.text('Create Account');

		                console.log("Success:", response);
		                
		                // Check if registration was successful
		                if (response.success && response.data && response.data.user) {
		                    showSuccess("Registration successful! Welcome to PropertyHub!");
		                    
		                    // Extract user roles from response
		                    const userRoles = response.data.user.roles;
		                    
		                    if (userRoles && userRoles.length > 0) {
		                        const firstRole = userRoles[0];
		                        
		                        // Show redirect message
		                        showSuccess("Redirecting to your dashboard...");
		                        
		                        // Redirect based on role after a short delay
		                        setTimeout(() => {
		                            if (firstRole === "OWNER") {
		                                window.location.href = "ownerDasboard";
		                            } else if (firstRole === "USER" || firstRole === "TENANT") {
		                                window.location.href = "tenantDashboard";
		                            } else if (firstRole === "ADMIN") {
		                                window.location.href = "adminDashboard";
		                            } else {
		                                // Default redirect
		                                window.location.href = "/dashboard";
		                            }
		                        }, 2000); // 2 second delay to show success message
		                    } else {
		                        // No roles found, redirect to default dashboard
		                        setTimeout(() => {
		                            window.location.href = "/dashboard";
		                        }, 2000);
		                    }
		                } else {
		                    // Registration failed
		                    showError("Registration failed: " + (response.message || "Unknown error occurred"));
		                }
		            },
		            error: function(xhr, status, error) {
		                // Hide loading state
		                submitBtn.prop('disabled', false);
		                spinner.hide();
		                buttonText.text('Create Account');

		                console.error("Error:", error);
		                const errorMessage = xhr.responseJSON?.message || error || "Registration failed. Please try again.";
		                showError("Registration failed: " + errorMessage);
		            }
		        });
		    });

		    // Field validation function
		    function validateField($field) {
		        const value = $field.val().trim();
		        const fieldName = $field.attr('name');
		        let isValid = true;
		        
		        // Remove previous states
		        $field.removeClass('error success');
		        $field.siblings('.error-message').hide();
		        
		        // Required field check
		        if ($field.prop('required') && !value) {
		            isValid = false;
		        }
		        
		        // Specific validations
		        switch (fieldName) {
		            case 'username':
		                if (value && (value.length < 3 || value.length > 64)) {
		                    isValid = false;
		                }
		                break;
		            case 'email':
		                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		                if (value && !emailRegex.test(value)) {
		                    isValid = false;
		                }
		                break;
		            case 'passwordHash':
		                if (value && value.length < 6) {
		                    isValid = false;
		                }
		                break;
		            case 'phone':
		                const phoneRegex = /^\+?[\d\s\-\(\)]+$/;
		                if (value && !phoneRegex.test(value)) {
		                    isValid = false;
		                }
		                break;
		        }
		        
		        // Apply validation state
		        if (isValid && value) {
		            $field.addClass('success');
		        } else if (!isValid) {
		            $field.addClass('error');
		            $field.siblings('.error-message').show();
		        }
		        
		        return isValid;
		    }

		    // Modern notification functions with enhanced styling
		    function showError(message) {
		        // Remove any existing notifications
		        $('.notification').remove();
		        
		        // Create modern error notification
		        const notification = $(`
		            <div class="notification error-notification" style="
		                position: fixed;
		                top: 20px;
		                right: 20px;
		                background: linear-gradient(135deg, #ff6b6b, #ee5a52);
		                color: white;
		                padding: 1rem 1.5rem;
		                border-radius: 12px;
		                box-shadow: 0 10px 25px rgba(239, 68, 68, 0.3);
		                z-index: 1000;
		                display: flex;
		                align-items: center;
		                gap: 0.5rem;
		                transform: translateX(100%);
		                transition: transform 0.3s ease;
		                max-width: 400px;
		                word-wrap: break-word;
		            ">
		                <i class="fas fa-exclamation-circle" style="font-size: 1.2rem;"></i>
		                <span>${message}</span>
		                <button class="notification-close" style="
		                    background: none;
		                    border: none;
		                    color: white;
		                    cursor: pointer;
		                    margin-left: auto;
		                    padding: 0;
		                    font-size: 1.2rem;
		                ">&times;</button>
		            </div>
		        `);
		        
		        $('body').append(notification);
		        
		        // Close button handler
		        notification.find('.notification-close').on('click', function() {
		            notification.css('transform', 'translateX(100%)');
		            setTimeout(() => notification.remove(), 300);
		        });
		        
		        // Animate in
		        setTimeout(() => {
		            notification.css('transform', 'translateX(0)');
		        }, 100);
		        
		        // Auto remove after 5 seconds
		        setTimeout(() => {
		            notification.css('transform', 'translateX(100%)');
		            setTimeout(() => notification.remove(), 300);
		        }, 5000);
		    }

		    function showSuccess(message) {
		        // Remove any existing notifications
		        $('.notification').remove();
		        
		        // Create modern success notification
		        const notification = $(`
		            <div class="notification success-notification" style="
		                position: fixed;
		                top: 20px;
		                right: 20px;
		                background: linear-gradient(135deg, #10b981, #059669);
		                color: white;
		                padding: 1rem 1.5rem;
		                border-radius: 12px;
		                box-shadow: 0 10px 25px rgba(16, 185, 129, 0.3);
		                z-index: 1000;
		                display: flex;
		                align-items: center;
		                gap: 0.5rem;
		                transform: translateX(100%);
		                transition: transform 0.3s ease;
		                max-width: 400px;
		                word-wrap: break-word;
		            ">
		                <i class="fas fa-check-circle" style="font-size: 1.2rem;"></i>
		                <span>${message}</span>
		                <button class="notification-close" style="
		                    background: none;
		                    border: none;
		                    color: white;
		                    cursor: pointer;
		                    margin-left: auto;
		                    padding: 0;
		                    font-size: 1.2rem;
		                ">&times;</button>
		            </div>
		        `);
		        
		        $('body').append(notification);
		        
		        // Close button handler
		        notification.find('.notification-close').on('click', function() {
		            notification.css('transform', 'translateX(100%)');
		            setTimeout(() => notification.remove(), 300);
		        });
		        
		        // Animate in
		        setTimeout(() => {
		            notification.css('transform', 'translateX(0)');
		        }, 100);
		        
		        // Auto remove after 3 seconds (shorter for success messages)
		        setTimeout(() => {
		            notification.css('transform', 'translateX(100%)');
		            setTimeout(() => notification.remove(), 300);
		        }, 3000);
		    }

		    // Add floating animation to particles
		    $('.particle').each(function(index) {
		        $(this).css('animation-delay', (index * 0.5) + 's');
		    });
		});