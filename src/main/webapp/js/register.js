		$(document).ready(function() {
		    // Role field visibility handler - updated for modern design
		    function handleRoleChange() {
		        var role = $("#roles").val();
		        var ownerField = $("#ownerIdField");
		        var tenantField = $("#tenantIdField");
		        
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
		        var passwordField = $('#passwordHash');
		        var type = passwordField.attr('type') === 'password' ? 'text' : 'password';
		        passwordField.attr('type', type);
		        $(this).toggleClass('fa-eye fa-eye-slash');
		    });

		    // Password strength indicator
		    $('#passwordHash').on('input', function() {
		        var password = $(this).val();
		        var strengthBar = $('.strength-bar');
		        var strengthContainer = $('.password-strength');
		        
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
		        var username = $("#username").val().trim();
		        var email = $("#email").val().trim();
		        var password = $("#passwordHash").val().trim();
		        var fullName = $("#fullName").val().trim();
		        var phone = $("#phone").val().trim();
		        var role = $("#roles").val();

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
		        var submitBtn = $('#submitBtn');
		        var spinner = $('.loading-spinner');
		        var buttonText = submitBtn.find('span');
		        
		        submitBtn.prop('disabled', true);
		        spinner.show();
		        buttonText.text('Creating Account...');

		        // Prepare data for API
		        var inputParams = {
		            username: username,
		            email: email,
		            password: password,
		            fullName: fullName,
		            phone: phone,
		            roles: [role] // API expects array
		        };

		        // Include role-specific IDs if provided
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
		                    var userRoles = response.data.user.roles;
		                    
		                    if (userRoles && userRoles.length > 0) {
		                        var firstRole = userRoles[0];
		                        
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
						let errorMessage = "Registration failed. Please try again.";
						if (xhr.responseJSON && xhr.responseJSON.message) {
						    errorMessage = xhr.responseJSON.message;
						} else if (error) {
						    errorMessage = error;
						}
		                showError("Registration failed: " + errorMessage);
		            }
		        });
		    });

		    // Field validation function
		    function validateField($field) {
		        var value = $field.val().trim();
		        var fieldName = $field.attr('name');
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
		                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
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
		                var phoneRegex = /^\+?[\d\s\-\(\)]+$/;
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

			function showSuccess(message) {
			    $(".notification").remove();

			    var notification = $('<div/>', { class: 'notification success-notification' })
			        .append($('<i/>', { class: 'fas fa-check-circle', style: 'font-size: 1.2rem;' }))
			        .append($('<span/>').text(message))
			        .append($('<button/>', { class: 'notification-close', html: '&times;' }));

			    $("body").append(notification);

			    notification.find(".notification-close").on("click", function () {
			        notification.css("transform", "translateX(100%)");
			        setTimeout(() => notification.remove(), 300);
			    });

			    setTimeout(() => notification.css("transform", "translateX(0)"), 100);
			    setTimeout(() => {
			        notification.css("transform", "translateX(100%)");
			        setTimeout(() => notification.remove(), 300);
			    }, 3000); // auto hide in 3 sec
			}

			function showError(message) {
			    $(".notification").remove();

			    var notification = $('<div/>', { class: 'notification error-notification' })
			        .append($('<i/>', { class: 'fas fa-exclamation-circle', style: 'font-size: 1.2rem;' }))
			        .append($('<span/>').text(message))
			        .append($('<button/>', { class: 'notification-close', html: '&times;' }));

			    $("body").append(notification);

			    notification.find(".notification-close").on("click", function () {
			        notification.css("transform", "translateX(100%)");
			        setTimeout(() => notification.remove(), 300);
			    });

			    setTimeout(() => notification.css("transform", "translateX(0)"), 100);
			    setTimeout(() => {
			        notification.css("transform", "translateX(100%)");
			        setTimeout(() => notification.remove(), 300);
			    }, 5000); // auto hide in 5 sec
			}


		    // Add floating animation to particles
		    $('.particle').each(function(index) {
		        $(this).css('animation-delay', (index * 0.5) + 's');
		    });
		});