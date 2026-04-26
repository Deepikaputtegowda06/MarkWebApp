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

@WebServlet("/UpdateMarkServlet")
public class UpdateMarkServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        MarkDAO dao = new MarkDAO();
        StudentMark student = dao.getStudentById(studentId);
        
        if (student != null) {
            request.setAttribute("student", student);
            request.getRequestDispatcher("markupdate.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Student not found!");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("markupdate.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int studentId = Integer.parseInt(request.getParameter("studentId"));
            String studentName = request.getParameter("studentName");
            String subject = request.getParameter("subject");
            int marks = Integer.parseInt(request.getParameter("marks"));
            Date examDate = Date.valueOf(request.getParameter("examDate"));
            
            StudentMark student = new StudentMark(studentId, studentName, subject, marks, examDate);
            MarkDAO dao = new MarkDAO();
            
            if (dao.updateStudent(student)) {
                request.setAttribute("message", "Student marks updated successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Failed to update student marks!");
                request.setAttribute("messageType", "error");
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
        }
        
        request.getRequestDispatcher("markupdate.jsp").forward(request, response);
    }
}
