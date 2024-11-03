<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
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
            background-color: #ffffff;
            padding: 2em;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            width: 350px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .form-group {
            margin-bottom: 1em;
        }

        .form-group label {
            display: block;
            color: #555;
            margin-bottom: 0.5em;
        }

        .form-group input {
            width: 100%;
            padding: 0.8em;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1em;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: 100%;
            padding: 0.8em;
            border: none;
            background-color: #007bff;
            color: white;
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

        .link {
            text-align: center;
            margin-top: 1em;
        }

        .link a {
            color: #007bff;
            text-decoration: none;
        }

        .link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Create Account</h2>

        <!-- Display error message if registration fails -->
        <%
            String errorMessage = (String) request.getAttribute("error");
            if (errorMessage != null) {
        %>
            <div class="error"><%= errorMessage %></div>
        <%
            }
        %>

        <form action="RegisterServlet" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" name="txtName" id="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" name="txtPwd" id="password" required>
            </div>
            <div class="form-group">
                <label for="confirm-password">Confirm Password:</label>
                <input type="password" name="txtConfirmPwd" id="confirm-password" required>
            </div>
            <input type="submit" value="Register">
            <div class="link">
                <p>Already have an account? <a href="login.jsp">Login</a></p>
            </div>
        </form>
    </div>
</body>
</html>
