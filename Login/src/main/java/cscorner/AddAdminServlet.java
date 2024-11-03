package cscorner;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/AddAdminServlet")
public class AddAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("addAdmin.jsp").forward(request, response);
            return;
        }

        boolean userExists = false;
        boolean validCredentials = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vijay", "root", "@Rvm2307mysqlrootpassword");

            // Check if the username already exists
            PreparedStatement ps = con.prepareStatement("SELECT uname FROM login WHERE uname=?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                userExists = true;
            }

            // If username exists, check if the password also matches
            if (userExists) {
                PreparedStatement ps2 = con.prepareStatement("SELECT uname FROM login WHERE uname=? AND password=?");
                ps2.setString(1, username);
                ps2.setString(2, password);
                ResultSet rs2 = ps2.executeQuery();
                if (rs2.next()) {
                    validCredentials = true;
                }
            }

            if (validCredentials) {
                request.setAttribute("errorMessage", "User with the given credentials already exists.");
                request.getRequestDispatcher("addAdmin.jsp").forward(request, response);
            } else if (userExists) {
                request.setAttribute("errorMessage", "Given username has already been taken.");
                request.getRequestDispatcher("addAdmin.jsp").forward(request, response);
            } else {
                // Add new user to the database
                PreparedStatement insertPs = con.prepareStatement("INSERT INTO login (uname, password, role) VALUES (?, ?, 'admin')");
                insertPs.setString(1, username);
                insertPs.setString(2, password);
                insertPs.executeUpdate();

                // Redirect to success.jsp after successful registration
                response.sendRedirect("success.jsp");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while adding the admin.");
            request.getRequestDispatcher("addAdmin.jsp").forward(request, response);
        }
    }
}
