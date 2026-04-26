<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.model.StudentMark" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Display Student Marks</title>
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
            margin-bottom: 30px;
            text-align: center;
        }
        
        .search-box {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            display: flex;
            gap: 10px;
        }
        
        .search-box input {
            flex: 1;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 8px;
        }
        
        .search-box button {
            padding: 10px 20px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
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
        
        .message {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            background: #f8d7da;
            color: #721c24;
        }
        
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            text-align: center;
            width: 100%;
            text-decoration: none;
            color: #667eea;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>👁️ Student Marks Records</h2>
        
        <div class="search-box">
            <form action="DisplayMarksServlet" method="get" style="display: flex; gap: 10px; width: 100%;">
                <input type="number" name="searchId" placeholder="Enter Student ID to search...">
                <button type="submit">Search</button>
                <button type="button" onclick="window.location.href='DisplayMarksServlet'">Show All</button>
            </form>
        </div>
        
        <% if(request.getAttribute("message") != null) { %>
            <div class="message">
                <%= request.getAttribute("message") %>
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
        <% } else if(students != null) { %>
            <div class="message">No records found.</div>
        <% } %>
        
        <a href="index.jsp" class="back-btn">← Back to Dashboard</a>
    </div>
</body>
</html>