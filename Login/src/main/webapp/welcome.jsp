<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome Page</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #4d79ff, #809fff);
            color: #333;
        }

        .welcome-container {
            background-color: #ffffff;
            padding: 40px;
            width: 350px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        h1 {
            color: #333;
            font-size: 24px;
            margin-bottom: 10px;
        }

        p {
            font-size: 18px;
            color: #666;
            margin-bottom: 20px;
        }

        input[type="submit"] {
            background-color: #4d79ff;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 15px;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #3a5ec7;
        }
    </style>
</head>
<body>
    <div class="welcome-container">
        <%
            // Get the username and role from session
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
        %>
        <h1>Welcome, <%= username %>!</h1>
        <p>Role: <%= role %></p>

        <% if ("guest".equalsIgnoreCase(role)) { %>
            <!-- Button to View Orders -->
            <form action="ViewOrdersServlet" method="post">
                <input type="submit" value="View Orders">
            </form>
            <form action="LogoutServlet" method="get">
        <input type="submit" value="Logout">
    </form>
        <% } %>
    </div>
</body>
</html>
