package com.servlet;

import com.util.DatabaseUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet("/TestDB")
public class TestDBServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><body>");
        out.println("<h2>Database Connection Test</h2>");
        
        try {
            Connection conn = DatabaseUtil.getConnection();
            if (conn != null) {
                out.println("<p style='color:green'>✓ Database connected successfully!</p>");
                out.println("<p>Connection details: " + conn.toString() + "</p>");
                conn.close();
            } else {
                out.println("<p style='color:red'>✗ Failed to connect to database!</p>");
            }
        } catch (Exception e) {
            out.println("<p style='color:red'>✗ Error: " + e.getMessage() + "</p>");
            out.println("<pre>");
            e.printStackTrace(out);
            out.println("</pre>");
        }
        
        out.println("<br><a href='index.jsp'>Back to Home</a>");
        out.println("</body></html>");
    }
}