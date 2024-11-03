package cscorner;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/ViewUsersServlet")
public class ViewUsersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String role = (String) session.getAttribute("role");

        if (session == null || !"admin".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get username and password from the request
        String enteredUsername = request.getParameter("username");
        String enteredPassword = request.getParameter("password");

        boolean validCredentials = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vijay", "root", "@Rvm2307mysqlrootpassword");

            // Check if the entered credentials match an admin user
            PreparedStatement ps = con.prepareStatement("SELECT uname FROM login WHERE uname=? AND password=? AND role='admin'");
            ps.setString(1, enteredUsername);
            ps.setString(2, enteredPassword);
            ResultSet rs = ps.executeQuery();

            validCredentials = rs.next();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (validCredentials) {
            // If valid, retrieve the user list
            List<String[]> userList = new ArrayList<>();
            try {
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vijay", "root", "@Rvm2307mysqlrootpassword");
                PreparedStatement ps = con.prepareStatement("SELECT uname, role FROM login");
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    String[] user = { rs.getString("uname"), rs.getString("role") };
                    userList.add(user);
                }
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error retrieving users");
            }

            // Forward the user list to viewUsers.jsp
            request.setAttribute("userList", userList);
            request.getRequestDispatcher("viewUsers.jsp").forward(request, response);
        } else {
            // If invalid, set an error message and redirect back to admin.jsp
            request.setAttribute("errorMessage", "Invalid credentials. Please try again.");
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        }
    }
}
