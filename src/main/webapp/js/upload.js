$(document).ready(function () {
    // Preview image before upload
    $("#fileInput").on("change", function () {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                $("#preview").html(`<p>Preview:</p><img src="${e.target.result}" width="300">`);
            };
            reader.readAsDataURL(file);
        } else {
            $("#preview").empty();
        }
    });

    $("#uploadForm").submit(function (e) {
        e.preventDefault();

        const file = $("#fileInput")[0].files[0];
        if (!file) {
            alert("Please select a file.");
            return;
        }

        const formData = new FormData();
        formData.append("file", file);

        $("#loader").show();
        $("button").prop("disabled", true);
        $("#result").empty();

        $.ajax({
            url: "/api/upload",
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            success: function (data) {
                $("#result").html(`
                    <p><strong>Upload successful!</strong></p>
                    <p>Public ID: ${data.public_id}</p>
                    <p><img src="${data.secure_url}" width="300"/></p>
                `);
            },
            error: function (xhr) {
                $("#result").html(`<p style="color:red;">Error: ${xhr.responseText || 'Upload failed!'}</p>`);
            },
            complete: function () {
                $("#loader").hide();
                $("button").prop("disabled", false);
            }
        });
    });
});
