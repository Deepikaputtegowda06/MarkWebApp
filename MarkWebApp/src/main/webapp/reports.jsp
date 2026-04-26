<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Generate Reports</title>
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
            max-width: 800px;
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
        
        .report-card {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            transition: transform 0.3s;
        }
        
        .report-card:hover {
            transform: translateX(5px);
        }
        
        .report-card h3 {
            color: #764ba2;
            margin-bottom: 15px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        
        input, select {
            width: 100%;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
        }
        
        button {
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
        }
        
        button:hover {
            opacity: 0.9;
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
        <h2>📊 Generate Reports</h2>
        
        <!-- Report 1: Above Marks Threshold -->
        <div class="report-card">
            <h3>1. Students with marks above a specified value</h3>
            <form action="ReportServlet" method="post">
                <input type="hidden" name="reportType" value="aboveMarks">
                <div class="form-group">
                    <label>Marks Threshold:</label>
                    <input type="number" name="threshold" min="0" max="100" required>
                </div>
                <button type="submit">Generate Report</button>
            </form>
        </div>
        
        <!-- Report 2: By Subject -->
        <div class="report-card">
            <h3>2. Students who scored in a specific subject</h3>
            <form action="ReportServlet" method="post">
                <input type="hidden" name="reportType" value="bySubject">
                <div class="form-group">
                    <label>Select Subject:</label>
                    <select name="subject" required>
                        <option value="Mathematics">Mathematics</option>
                        <option value="Physics">Physics</option>
                        <option value="Chemistry">Chemistry</option>
                        <option value="Biology">Biology</option>
                        <option value="Computer Science">Computer Science</option>
                    </select>
                </div>
                <button type="submit">Generate Report</button>
            </form>
        </div>
        
        <!-- Report 3: Top N Students -->
        <div class="report-card">
            <h3>3. Top N students based on marks</h3>
            <form action="ReportServlet" method="post">
                <input type="hidden" name="reportType" value="topN">
                <div class="form-group">
                    <label>Number of Top Students:</label>
                    <input type="number" name="topN" min="1" max="100" required>
                </div>
                <button type="submit">Generate Report</button>
            </form>
        </div>
        
        <a href="index.jsp" class="back-btn">← Back to Dashboard</a>
    </div>
</body>
</html>