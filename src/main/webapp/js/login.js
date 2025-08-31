$(document).ready(function () {
   alert("login page")
    // Toggle password visibility
    $("#togglePassword").on("click", function () {
        const passwordField = $("#passwordHash");
        const type = passwordField.attr("type") === "password" ? "text" : "password";
        passwordField.attr("type", type);
        $(this).toggleClass("fa-eye fa-eye-slash");
    });

    // Submit login form
    $("#loginForm").on("submit", function (event) {
        event.preventDefault();

        const identifier = $("#username").val().trim(); // can be username or email
        const password = $("#passwordHash").val().trim();
       
        if (identifier === "") {
            showError("Username or Email is required.");
            $("#identifier").focus();
            return;
        }

        if (password === "") {
            showError("Password is required.");
            $("#passwordHash").focus();
            return;
        }

        const inputParams = {
            usernameOrEmail: identifier,
            password: password,
           
        };

       

        const submitBtn = $("#submitBtn");
        const spinner = $(".loading-spinner");
        const buttonText = submitBtn.find("span");

        submitBtn.prop("disabled", true);
        spinner.show();
        buttonText.text("Logging In...");

        $.ajax({
            type: "POST",
            url: "pgFinderRest/login",
            data: JSON.stringify(inputParams),
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                submitBtn.prop("disabled", false);
                spinner.hide();
                buttonText.text("Login");

                if (response.success && response.data && response.data.roles) {
                    showSuccess("Login successful!");

					const userRoles = response.data.roles;
				  

					setTimeout(() => {
					        if (userRoles.includes("OWNER")) {
					            window.location.href = "ownerDasboard";
					        } else if (userRoles.includes("USER") || userRoles.includes("TENANT")) {
					            window.location.href = "tenantDashboard";
					        } else if (userRoles.includes("ADMIN")) {
					            window.location.href = "adminDashboard";
					        } else {
					            window.location.href = "/dashboard";
					        }
					    }, 1500);
                } else {
                    showError(response.message || "Login failed. Invalid credentials.");
                }
            },
            error: function (xhr, status, error) {
                submitBtn.prop("disabled", false);
                spinner.hide();
                buttonText.text("Login");

                const errorMessage = xhr.responseJSON?.message || error || "Login failed. Please try again.";
                showError(errorMessage);
            }
        });
    });

    // Floating animation for background particles
    $(".particle").each(function (index) {
        $(this).css("animation-delay", index * 0.5 + "s");
    });

    // Success toast
    function showSuccess(message) {
        $(".notification").remove();

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

        $("body").append(notification);

        notification.find(".notification-close").on("click", function () {
            notification.css("transform", "translateX(100%)");
            setTimeout(() => notification.remove(), 300);
        });

        setTimeout(() => {
            notification.css("transform", "translateX(0)");
        }, 100);

        setTimeout(() => {
            notification.css("transform", "translateX(100%)");
            setTimeout(() => notification.remove(), 300);
        }, 3000);
    }

    // Error toast
    function showError(message) {
        $(".notification").remove();

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

        $("body").append(notification);

        notification.find(".notification-close").on("click", function () {
            notification.css("transform", "translateX(100%)");
            setTimeout(() => notification.remove(), 300);
        });

        setTimeout(() => {
            notification.css("transform", "translateX(0)");
        }, 100);

        setTimeout(() => {
            notification.css("transform", "translateX(100%)");
            setTimeout(() => notification.remove(), 300);
        }, 5000);
    }
});
