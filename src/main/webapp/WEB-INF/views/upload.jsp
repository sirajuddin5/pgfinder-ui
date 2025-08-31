<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Upload Image to Cloudinary</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="upload.js"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 30px;
        }

        h2 {
            color: #333;
        }

        #uploadForm {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            width: 400px;
            margin-bottom: 20px;
        }

        input[type="file"] {
            display: none;
        }

        label.custom-file-upload {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            display: inline-block;
            cursor: pointer;
            border-radius: 5px;
            margin-right: 10px;
        }

        button {
            padding: 10px 20px;
            border: none;
            background-color: #28a745;
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }

        button:disabled {
            background-color: #aaa;
            cursor: not-allowed;
        }

        #preview {
            margin-top: 15px;
        }

        #preview img {
            max-width: 100%;
            border-radius: 5px;
        }

        #result {
            margin-top: 20px;
        }

        .loader {
            display: none;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <h2>Upload Image to Cloudinary</h2>

    <form id="uploadForm">
        <label for="fileInput" class="custom-file-upload">Choose Image</label>
        <input type="file" name="file" id="fileInput" accept="image/*" required />
        <button type="submit">Upload</button>
        <div class="loader" id="loader">Uploading...</div>

        <div id="preview"></div>
    </form>

    <div id="result"></div>
	<script src="js/upload.js"></script>
</body>
</html>
