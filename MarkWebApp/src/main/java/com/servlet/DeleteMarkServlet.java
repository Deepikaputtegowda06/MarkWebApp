package com.servlet;

import com.dao.MarkDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteMarkServlet")
public class DeleteMarkServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int studentId = Integer.parseInt(request.getParameter("studentId"));
            MarkDAO dao = new MarkDAO();
            
            if (dao.deleteStudent(studentId)) {
                request.setAttribute("message", "Student record deleted successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Failed to delete student record!");
                request.setAttribute("messageType", "error");
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
        }
        
        request.getRequestDispatcher("markdelete.jsp").forward(request, response);
    }
}
