<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
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
            background: linear-gradient(135deg, #ff4d4d, #ff6666);
            color: #333;
        }

        .admin-container {
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

        button, input[type="submit"] {
            background-color: #ff4d4d;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin: 10px 0;
            width: 100%;
        }

        button:hover, input[type="submit"]:hover {
            background-color: #e63939;
        }

        .credential-form {
            display: none;
            margin-top: 15px;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .credential-form input[type="text"],
        .credential-form input[type="password"] {
            width: calc(100% - 20px); /* Full width minus padding */
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>

    <script>
        // JavaScript function to toggle the visibility of the credential form
        function toggleCredentialForm() {
            const form = document.getElementById('credentialForm');
            form.style.display = form.style.display === 'none' ? 'block' : 'none';
        }
    </script>
</head>
<body>
    <div class="admin-container">
        <%
            // Get the username and role from session
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            if (username == null || role == null || !"admin".equals(role)) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <h1>Welcome, <%= username %>!</h1>
        <p>Role: <%= role %></p>

        <!-- Button to view orders -->
        <form action="ViewOrdersServlet" method="post">
            <input type="submit" value="View Orders">
        </form>

        <!-- Button to toggle credential form -->
        <button type="button" onclick="toggleCredentialForm()">View Users</button>

        <!-- Credential form to enter username and password -->
        <form id="credentialForm" class="credential-form" action="ViewUsersServlet" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Submit">
        </form>
        <!-- Button to add a new admin -->
<button type="button" onclick="window.location.href='addAdmin.jsp'">Add New Admin</button>
        

        <!-- Logout button -->
        <form action="LogoutServlet" method="get">
            <button type="submit">Logout</button>
        </form>

        <!-- Display error message if any -->
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <p class="error-message"><%= errorMessage %></p>
        <%
            }
        %>
    </div>
</body>
</html>
