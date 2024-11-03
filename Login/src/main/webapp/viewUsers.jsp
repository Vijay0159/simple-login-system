<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User List</title>
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

        .table-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            width: 80%;
            max-width: 800px; /* Adjust as necessary */
            overflow-x: auto; /* Allows horizontal scrolling */
            margin-top: 20px;
        }

        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #ff4d4d;
            color: white;
            text-align: center;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2; /* Light grey for even rows */
        }

        tr:hover {
            background-color: #e6e6e6; /* Change color on hover */
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
            text-align: center;
        }

        .no-users {
            text-align: center;
            font-size: 16px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="table-container">
        <h1>User List</h1>
        <%
            List<String[]> users = (List<String[]>) request.getAttribute("userList");
            if (users != null && !users.isEmpty()) {
        %>
            <table>
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Role</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (String[] user : users) {
                    %>
                        <tr>
                            <td><%= user[0] %></td>
                            <td><%= user[1] %></td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <%
            } else {
        %>
            <p class="no-users">No users found.</p>
        <%
            }
        %>
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
