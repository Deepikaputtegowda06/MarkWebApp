<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.model.StudentMark" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Results</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 50px auto;
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        
        h2 {
            color: #667eea;
            margin-bottom: 10px;
            text-align: center;
        }
        
        .report-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #eee;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        tr:hover {
            background: #f5f5f5;
        }
        
        .marks-high {
            color: #28a745;
            font-weight: bold;
        }
        
        .marks-medium {
            color: #ffc107;
            font-weight: bold;
        }
        
        .marks-low {
            color: #dc3545;
            font-weight: bold;
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
        }
        
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            margin-right: 10px;
            padding: 10px 20px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 8px;
        }
        
        .back-btn:hover {
            background: #764ba2;
        }
        
        .btn-group {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="report-header">
            <h2>📈 Report Results</h2>
            <p style="color: #666; margin-top: 10px;"><%= request.getAttribute("reportTitle") != null ? request.getAttribute("reportTitle") : "" %></p>
        </div>
        
        <% if(request.getAttribute("error") != null) { %>
            <div class="error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <%
        List<StudentMark> students = (List<StudentMark>) request.getAttribute("students");
        if(students != null && !students.isEmpty()) {
        %>
        <table>
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Subject</th>
                    <th>Marks</th>
                    <th>Exam Date</th>
                </tr>
            </thead>
            <tbody>
                <% for(StudentMark s : students) { 
                    String marksClass = "";
                    if(s.getMarks() >= 75) marksClass = "marks-high";
                    else if(s.getMarks() >= 50) marksClass = "marks-medium";
                    else marksClass = "marks-low";
                %>
                <tr>
                    <td><%= s.getStudentId() %></td>
                    <td><%= s.getStudentName() %></td>
                    <td><%= s.getSubject() %></td>
                    <td class="<%= marksClass %>"><%= s.getMarks() %></td>
                    <td><%= s.getExamDate() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <div class="stats" style="margin-top: 20px; padding: 15px; background: #f8f9fa; border-radius: 8px;">
            <strong>Statistics:</strong><br>
            Total Students: <%= students.size() %><br>
            Average Marks: 
            <% 
                double avg = 0;
                for(StudentMark s : students) {
                    avg += s.getMarks();
                }
                avg = students.size() > 0 ? avg / students.size() : 0;
            %>
            <%= String.format("%.2f", avg) %><br>
            Highest Marks: 
            <% 
                int max = 0;
                for(StudentMark s : students) {
                    if(s.getMarks() > max) max = s.getMarks();
                }
            %>
            <%= max %>
        </div>
        
        <% } else if(students != null) { %>
            <div class="no-data">
                <p>No records found for this report criteria.</p>
            </div>
        <% } %>
        
        <div class="btn-group">
            <a href="reports.jsp" class="back-btn">Generate Another Report</a>
            <a href="index.jsp" class="back-btn">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>