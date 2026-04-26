package com.servlet;

import com.dao.MarkDAO;
import com.model.StudentMark;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/AddMarkServlet")
public class AddMarkServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set character encoding
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        try {
            // Get parameters
            int studentId = Integer.parseInt(request.getParameter("studentId"));
            String studentName = request.getParameter("studentName");
            String subject = request.getParameter("subject");
            int marks = Integer.parseInt(request.getParameter("marks"));
            Date examDate = Date.valueOf(request.getParameter("examDate"));
            
            // Validate marks range
            if (marks < 0 || marks > 100) {
                throw new Exception("Marks must be between 0 and 100");
            }
            
            MarkDAO dao = new MarkDAO();
            
            // Check if student ID already exists
            if (dao.studentExists(studentId)) {
                request.setAttribute("message", "Student ID " + studentId + " already exists! Please use a different ID or update the existing record.");
                request.setAttribute("messageType", "error");
            } else {
                // Create student object
                StudentMark student = new StudentMark(studentId, studentName, subject, marks, examDate);
                
                // Try to add student
                boolean result = dao.addStudent(student);
                
                if (result) {
                    request.setAttribute("message", "Student marks added successfully!");
                    request.setAttribute("messageType", "success");
                } else {
                    request.setAttribute("message", "Failed to add student marks! Please try again.");
                    request.setAttribute("messageType", "error");
                }
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid number format! Please enter valid numbers.");
            request.setAttribute("messageType", "error");
        } catch (IllegalArgumentException e) {
            request.setAttribute("message", "Invalid date format! Please use YYYY-MM-DD format.");
            request.setAttribute("messageType", "error");
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
        }
        
        // Forward back to the add page
        request.getRequestDispatcher("markadd.jsp").forward(request, response);
    }
}