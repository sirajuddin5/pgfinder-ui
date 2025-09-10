$(document).ready(function () {
    alert("Welcome to login page!!");

    // Toggle password visibility
    $("#togglePassword").on("click", function () {
        var passwordField = $("#passwordHash");
        var type = passwordField.attr("type") === "password" ? "text" : "password";
        console.log("Toggling password visibility. New type:", type);
        passwordField.attr("type", type);
        $(this).toggleClass("fa-eye fa-eye-slash");
    });

    // Submit login form
    $("#loginForm").on("submit", function (event) {
        console.log("Login form submitted.");
        event.preventDefault();

        var identifier = $("#username").val().trim(); // can be username or email
        var password = $("#passwordHash").val().trim();

        console.log("Identifier entered:", identifier);
        console.log("Password length:", password.length);

        if (identifier === "") {
            console.warn("Validation failed: Identifier is empty");
            showError("Username or Email is required.");
            $("#identifier").focus();
            return;
        }

        if (password === "") {
            console.warn("Validation failed: Password is empty");
            showError("Password is required.");
            $("#passwordHash").focus();
            return;
        }

        var inputParams = {
            usernameOrEmail: identifier,
            password: password,
        };

        console.log("Sending login request with inputParams:", inputParams);

        var submitBtn = $("#submitBtn");
        var spinner = $(".loading-spinner");
        var buttonText = submitBtn.find("span");

        submitBtn.prop("disabled", true);
        spinner.show();
        buttonText.text("Logging In...");

        $.ajax({
            type: "POST",
            url: "pgFinderRest/login",
            data: JSON.stringify(inputParams),
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                console.log("AJAX login response received:", response);

                submitBtn.prop("disabled", false);
                spinner.hide();
                buttonText.text("Login");

                if (response.success && response.data && response.data.roles) {
                    showSuccess("Login successful!");
                    console.log("Login success. User roles:", response.data.roles);

                    // ✅ Clear input fields after success
                    $("#username").val("");
                    $("#passwordHash").val("");

                    var userRoles = response.data.roles;

                    setTimeout(() => {
                        if (userRoles.includes("OWNER")) {
                            console.log("Redirecting to ownerDasboard");
                            window.location.href = "ownerDasboard";
                        } else if (userRoles.includes("USER") || userRoles.includes("TENANT")) {
                            console.log("Redirecting to tenantDashboard");
                            window.location.href = "tenantDashboard";
                        } else if (userRoles.includes("ADMIN")) {
                            console.log("Redirecting to adminDashboard");
                            window.location.href = "adminDashboard";
                        } else {
                            console.log("Redirecting to /dashboard");
                            window.location.href = "/dashboard";
                        }
                    }, 1500);
                } else {
                    console.warn("Login failed with message:", response.message);
                    showError(response.message || "Login failed. Invalid credentials.");
                }
            },
            error: function (xhr, status, error) {
                submitBtn.prop("disabled", false);
                spinner.hide();
                buttonText.text("Login");

                let errorMessage = "Login failed. Please try again.";
                if (xhr.responseJSON && xhr.responseJSON.message) {
                    errorMessage = xhr.responseJSON.message;
                } else if (error) {
                    errorMessage = error;
                }

                console.error("AJAX login error:", {
                    status: status,
                    error: error,
                    xhr: xhr
                });

                showError(errorMessage);
            }
        });
    });

    // Floating animation for background particles
    $(".particle").each(function (index) {
        console.log("Setting animation delay for particle", index);
        $(this).css("animation-delay", index * 0.5 + "s");
    });

    // Success Notification
    function showSuccess(message) {
        console.log("Showing success message:", message);
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
        }, 3000);
    }

    // Error Notification
    function showError(message) {
        console.log("Showing error message:", message);
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
        }, 5000);
    }
});
