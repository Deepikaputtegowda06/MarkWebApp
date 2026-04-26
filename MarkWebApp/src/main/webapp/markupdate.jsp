<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.StudentMark" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Student Marks</title>
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
            max-width: 600px;
            margin: 50px auto;
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        
        h2 {
            color: #667eea;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }
        
        input, select {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
        }
        
        button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            cursor: pointer;
        }
        
        .message {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }
        
        .search-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
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
        <h2>✏️ Update Student Marks</h2>
        
        <% if(request.getAttribute("message") != null) { %>
            <div class="message <%= request.getAttribute("messageType") %>">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <div class="search-section">
            <h3>Search Student by ID</h3>
            <form action="UpdateMarkServlet" method="get">
                <div class="form-group">
                    <label>Enter Student ID:</label>
                    <input type="number" name="studentId" required>
                </div>
                <button type="submit">Search Student</button>
            </form>
        </div>
        
        <% 
        StudentMark student = (StudentMark) request.getAttribute("student");
        if(student != null) {
        %>
        <form action="UpdateMarkServlet" method="post">
            <div class="form-group">
                <label>Student ID:</label>
                <input type="text" value="<%= student.getStudentId() %>" readonly>
                <input type="hidden" name="studentId" value="<%= student.getStudentId() %>">
            </div>
            
            <div class="form-group">
                <label>Student Name:</label>
                <input type="text" name="studentName" value="<%= student.getStudentName() %>" required>
            </div>
            
            <div class="form-group">
                <label>Subject:</label>
                <select name="subject" required>
                    <option value="Mathematics" <%= student.getSubject().equals("Mathematics") ? "selected" : "" %>>Mathematics</option>
                    <option value="Physics" <%= student.getSubject().equals("Physics") ? "selected" : "" %>>Physics</option>
                    <option value="Chemistry" <%= student.getSubject().equals("Chemistry") ? "selected" : "" %>>Chemistry</option>
                    <option value="Biology" <%= student.getSubject().equals("Biology") ? "selected" : "" %>>Biology</option>
                    <option value="Computer Science" <%= student.getSubject().equals("Computer Science") ? "selected" : "" %>>Computer Science</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>Marks (0-100):</label>
                <input type="number" name="marks" value="<%= student.getMarks() %>" min="0" max="100" required>
            </div>
            
            <div class="form-group">
                <label>Exam Date:</label>
                <input type="date" name="examDate" value="<%= student.getExamDate() %>" required>
            </div>
            
            <button type="submit">Update Record</button>
        </form>
        <% } %>
        
        <a href="index.jsp" class="back-btn">← Back to Dashboard</a>
    </div>
</body>
</html>