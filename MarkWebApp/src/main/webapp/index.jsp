<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mark Management System</title>
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
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            text-align: center;
            color: white;
            margin-bottom: 50px;
            padding: 40px;
            background: rgba(255,255,255,0.1);
            border-radius: 20px;
            backdrop-filter: blur(10px);
        }
        
        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        
        .header p {
            font-size: 1.1em;
            opacity: 0.9;
        }
        
        .dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
            text-align: center;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }
        
        .card h3 {
            color: #667eea;
            margin-bottom: 15px;
            font-size: 1.5em;
        }
        
        .card p {
            color: #666;
            margin-bottom: 20px;
        }
        
        .card .icon {
            font-size: 3em;
            margin-bottom: 15px;
        }
        
        .btn {
            display: inline-block;
            padding: 10px 25px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            border: none;
            cursor: pointer;
            transition: opacity 0.3s;
        }
        
        .btn:hover {
            opacity: 0.9;
        }
        
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        
        .modal-content {
            background: white;
            padding: 30px;
            border-radius: 15px;
            max-width: 500px;
            width: 90%;
        }
        
        .close {
            float: right;
            cursor: pointer;
            font-size: 25px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 Mark Management System</h1>
            <p>Efficiently manage student examination marks and generate insightful reports</p>
        </div>
        
        <div class="dashboard">
            <div class="card" onclick="window.location.href='markadd.jsp'">
                <div class="icon">➕</div>
                <h3>Add Marks</h3>
                <p>Add new student examination marks to the database</p>
                <span class="btn">Add New Record</span>
            </div>
            
            <div class="card" onclick="window.location.href='markupdate.jsp'">
                <div class="icon">✏️</div>
                <h3>Update Marks</h3>
                <p>Modify existing student marks and information</p>
                <span class="btn">Update Record</span>
            </div>
            
            <div class="card" onclick="window.location.href='markdelete.jsp'">
                <div class="icon">🗑️</div>
                <h3>Delete Marks</h3>
                <p>Remove student records from the database</p>
                <span class="btn">Delete Record</span>
            </div>
            
            <div class="card" onclick="window.location.href='DisplayMarksServlet'">
                <div class="icon">👁️</div>
                <h3>Display Marks</h3>
                <p>View all student records or search by ID</p>
                <span class="btn">View Records</span>
            </div>
            
            <div class="card" onclick="window.location.href='reports.jsp'">
                <div class="icon">📊</div>
                <h3>Reports</h3>
                <p>Generate custom reports and analytics</p>
                <span class="btn">Generate Reports</span>
            </div>
        </div>
    </div>
</body>
</html>