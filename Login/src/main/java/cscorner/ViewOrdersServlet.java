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
import javax.servlet.http.HttpSession;

@WebServlet("/ViewOrdersServlet")
public class ViewOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        String role = (String) session.getAttribute("role");

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Orders List</title>");
        out.println("<style>");
        out.println("body { font-family: Arial, sans-serif; background-color: #f4f4f9; color: #333; text-align: center; }");
        out.println("h2 { color: #4d79ff; }");
        out.println(".orders-table { margin: 20px auto; width: 80%; border-collapse: collapse; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }");
        out.println(".orders-table th, .orders-table td { padding: 12px 15px; border: 1px solid #ddd; text-align: center; }");
        out.println(".orders-table th { background-color: #4d79ff; color: #ffffff; }");
        out.println(".orders-table tr:nth-child(even) { background-color: #f9f9f9; }");
        out.println(".message { margin-top: 20px; color: #ff4d4d; font-weight: bold; }");
        out.println("</style></head><body>");

        // Allow access for both 'guest' and 'admin' roles
        if (role != null && (role.equalsIgnoreCase("guest") || role.equalsIgnoreCase("admin"))) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vijay", "root", "@Rvm2307mysqlrootpassword");

                PreparedStatement ps = con.prepareStatement("SELECT * FROM orders");
                ResultSet rs = ps.executeQuery();

                out.println("<h2>Orders List</h2>");
                out.println("<table class='orders-table'><tr><th>ID</th><th>Item</th><th>Price</th></tr>");

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String item = rs.getString("item");
                    double price = rs.getDouble("price");

                    out.println("<tr><td>" + id + "</td><td>" + item + "</td><td>$" + String.format("%.2f", price) + "</td></tr>");
                }
                out.println("</table>");

                con.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                out.println("<p class='message'>Error retrieving orders. Please try again later.</p>");
            }
        } else {
            out.println("<p class='message'>Unauthorized access. You do not have permission to view this page.</p>");
        }

        out.println("</body></html>");
    }
}
