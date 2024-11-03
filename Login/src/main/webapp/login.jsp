<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #fff;
            padding: 2em;
            width: 350px;
            border-radius: 8px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 1em;
        }

        .form-group {
            margin-bottom: 1em;
        }

        .form-group label {
            display: block;
            color: #555;
            font-size: 0.9em;
            margin-bottom: 0.3em;
        }

        .form-group input {
            width: 100%;
            padding: 0.8em;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 0.95em;
        }

        input[type="submit"] {
            width: 100%;
            padding: 0.8em;
            border: none;
            background-color: #007bff;
            color: #fff;
            font-size: 1em;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error {
            color: #d9534f;
            font-size: 0.9em;
            text-align: center;
            margin-bottom: 1em;
        }

        .create-account {
            display: block;
            text-align: center;
            margin-top: 1em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        
        <!-- Display error message if login fails -->
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="error"><%= errorMessage %></div>
        <%
            }
        %>

        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" name="txtName" id="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" name="txtPwd" id="password" required>
            </div>
            <input type="submit" value="Login">
        </form>
        
        <a href="register.jsp" class="create-account">New User? Create Account Here</a>
    </div>
</body>
</html>
