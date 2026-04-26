package com.servlet;

import com.dao.MarkDAO;
import com.model.StudentMark;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String reportType = request.getParameter("reportType");
        MarkDAO dao = new MarkDAO();
        List<StudentMark> students = null;
        String reportTitle = "";
        
        try {
            switch (reportType) {
                case "aboveMarks":
                    int threshold = Integer.parseInt(request.getParameter("threshold"));
                    students = dao.getStudentsAboveMarks(threshold);
                    reportTitle = "Students with marks above " + threshold;
                    break;
                    
                case "bySubject":
                    String subject = request.getParameter("subject");
                    students = dao.getStudentsBySubject(subject);
                    reportTitle = "Students who scored in " + subject;
                    break;
                    
                case "topN":
                    int n = Integer.parseInt(request.getParameter("topN"));
                    students = dao.getTopNStudents(n);
                    reportTitle = "Top " + n + " Students";
                    break;
            }
            
            request.setAttribute("students", students);
            request.setAttribute("reportTitle", reportTitle);
            request.setAttribute("reportType", reportType);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error generating report: " + e.getMessage());
        }
        
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
}