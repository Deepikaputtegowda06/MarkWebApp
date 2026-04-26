<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Student Marks</title>
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
            transition: border-color 0.3s;
        }
        
        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
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
            transition: opacity 0.3s;
            margin-bottom: 10px;
        }
        
        button:hover {
            opacity: 0.9;
        }
        
        .btn-secondary {
            background: #6c757d;
        }
        
        .message {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            text-align: center;
            width: 100%;
            text-decoration: none;
            color: #667eea;
        }
        
        .back-btn:hover {
            text-decoration: underline;
        }
        
        .note {
            background: #e7f3ff;
            padding: 10px;
            border-radius: 5px;
            margin-top: 20px;
            font-size: 12px;
            color: #0066cc;
        }
        
        .existing-ids {
            background: #f8f9fa;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
            font-size: 12px;
            max-height: 100px;
            overflow-y: auto;
        }
        
        .suggestion {
            font-size: 12px;
            color: #28a745;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>➕ Add New Student Marks</h2>
        
        <% if(request.getAttribute("message") != null) { %>
            <div class="message <%= request.getAttribute("messageType") %>">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <div class="info" style="padding: 10px; margin-bottom: 20px; border-radius: 5px;">
            💡 <strong>Tip:</strong> Each Student ID must be unique. Check existing IDs below before adding.
        </div>
        
        <form action="AddMarkServlet" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label>Student ID:</label>
                <input type="number" name="studentId" id="studentId" required 
                       placeholder="Enter unique Student ID (e.g., 101)">
                <div class="suggestion" id="idSuggestion"></div>
            </div>
            
            <div class="form-group">
                <label>Student Name:</label>
                <input type="text" name="studentName" id="studentName" required 
                       placeholder="Enter full name">
            </div>
            
            <div class="form-group">
                <label>Subject:</label>
                <select name="subject" id="subject" required>
                    <option value="">Select Subject</option>
                    <option value="Mathematics">Mathematics</option>
                    <option value="Physics">Physics</option>
                    <option value="Chemistry">Chemistry</option>
                    <option value="Biology">Biology</option>
                    <option value="Computer Science">Computer Science</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>Marks (0-100):</label>
                <input type="number" name="marks" id="marks" min="0" max="100" required 
                       placeholder="Enter marks between 0-100">
            </div>
            
            <div class="form-group">
                <label>Exam Date:</label>
                <input type="date" name="examDate" id="examDate" required>
            </div>
            
            <button type="submit">Add Student Record</button>
            <button type="button" class="btn-secondary" onclick="window.location.href='DisplayMarksServlet'">
                View All Records
            </button>
        </form>
        
        <div class="note">
            <strong>Note:</strong> 
            <ul style="margin-left: 20px; margin-top: 5px;">
                <li>Student ID must be unique (cannot duplicate existing IDs)</li>
                <li>Marks should be between 0 and 100</li>
                <li>Exam Date should be in YYYY-MM-DD format</li>
            </ul>
        </div>
        
        <a href="index.jsp" class="back-btn">← Back to Dashboard</a>
    </div>
    
    <script>
        function validateForm() {
            var studentId = document.getElementById("studentId").value;
            var studentName = document.getElementById("studentName").value;
            var subject = document.getElementById("subject").value;
            var marks = document.getElementById("marks").value;
            var examDate = document.getElementById("examDate").value;
            
            if (studentId == "" || studentId <= 0) {
                alert("Please enter a valid Student ID");
                return false;
            }
            
            if (studentName == "") {
                alert("Please enter Student Name");
                return false;
            }
            
            if (subject == "") {
                alert("Please select a Subject");
                return false;
            }
            
            if (marks == "" || marks < 0 || marks > 100) {
                alert("Please enter marks between 0 and 100");
                return false;
            }
            
            if (examDate == "") {
                alert("Please select Exam Date");
                return false;
            }
            
            // Check if ID is a positive integer
            if (!Number.isInteger(parseFloat(studentId)) || studentId <= 0) {
                alert("Student ID must be a positive number");
                return false;
            }
            
            return true;
        }
        
        // Real-time validation for Student ID
        document.getElementById("studentId").addEventListener('input', function() {
            var id = this.value;
            var suggestion = document.getElementById("idSuggestion");
            
            if (id && !isNaN(id)) {
                // This is where you could make an AJAX call to check if ID exists
                suggestion.innerHTML = "ID: " + id + " - Make sure this ID is not already used";
                suggestion.style.color = "#ffc107";
            } else {
                suggestion.innerHTML = "";
            }
        });
    </script>
</body>
</html>