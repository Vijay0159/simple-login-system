package cscorner;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/vijay";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "@Rvm2307mysqlrootpassword";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("txtName");
        String password = request.getParameter("txtPwd");
        String confirmPassword = request.getParameter("txtConfirmPwd");

        // Validate password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // Check if the username already exists
                if (isUsernameTaken(con, username)) {
                    request.setAttribute("error", "Given username has already been taken.");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                } else {
                    registerUser(con, username, password);
                    // Redirect to success page
                    response.sendRedirect("success.jsp");
                }
            }
        } catch (ClassNotFoundException e) {
            out.println("<h3>Error: Unable to load database driver.</h3>");
            e.printStackTrace();
        } catch (SQLException e) {
            out.println("<h3>Error: Database operation failed.</h3>");
            e.printStackTrace();
        }
    }

    private boolean isUsernameTaken(Connection con, String username) throws SQLException {
        String query = "SELECT * FROM login WHERE uname = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // If it returns a result, the username exists
        }
    }

    private void registerUser(Connection con, String username, String password) throws SQLException {
        String insertQuery = "INSERT INTO login (uname, password, role) VALUES (?, ?, 'guest')";
        try (PreparedStatement psInsert = con.prepareStatement(insertQuery)) {
            psInsert.setString(1, username);
            psInsert.setString(2, password);
            psInsert.executeUpdate();
        }
    }
}
