package com.servlet;

import com.dao.MarkDAO;
import com.model.StudentMark;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DisplayMarksServlet")
public class DisplayMarksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String searchId = request.getParameter("searchId");
        MarkDAO dao = new MarkDAO();
        
        if (searchId != null && !searchId.isEmpty()) {
            try {
                int studentId = Integer.parseInt(searchId);
                StudentMark student = dao.getStudentById(studentId);
                if (student != null) {
                    request.setAttribute("students", List.of(student));
                } else {
                    request.setAttribute("message", "Student not found!");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("message", "Invalid Student ID!");
            }
        } else {
            List<StudentMark> students = dao.getAllStudents();
            request.setAttribute("students", students);
        }
        
        request.getRequestDispatcher("markdisplay.jsp").forward(request, response);
    }
}
