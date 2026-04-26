package com.dao;

import com.model.StudentMark;
import com.util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MarkDAO {
    
    // Get next available Student ID (Auto-generation)
    public int getNextAvailableId() {
        String query = "SELECT MAX(StudentID) FROM StudentMarks";
        
        System.out.println("Getting next available Student ID...");
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            if (rs.next()) {
                int maxId = rs.getInt(1);
                // If no records exist, rs.getInt(1) returns 0
                if (maxId == 0) {
                    System.out.println("No records found. Starting with ID: 100");
                    return 100; // Starting ID
                }
                int nextId = maxId + 1;
                System.out.println("Next available ID is: " + nextId);
                return nextId;
            }
            
        } catch (SQLException e) {
            System.out.println("SQL Error while getting next ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 100; // Default starting ID if no records exist or error occurs
    }
    
    // Add new student marks
    public boolean addStudent(StudentMark student) {
        String query = "INSERT INTO StudentMarks (StudentID, StudentName, Subject, Marks, ExamDate) VALUES (?, ?, ?, ?, ?)";
        
        System.out.println("Attempting to add student with ID: " + student.getStudentId());
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, student.getStudentId());
            pstmt.setString(2, student.getStudentName());
            pstmt.setString(3, student.getSubject());
            pstmt.setInt(4, student.getMarks());
            pstmt.setDate(5, student.getExamDate());
            
            System.out.println("Executing query: " + pstmt.toString());
            
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("Error Code: " + e.getErrorCode());
            
            // Check for duplicate entry error
            if (e.getErrorCode() == 1062) { // Duplicate entry error code
                System.out.println("Duplicate Student ID detected!");
            }
            e.printStackTrace();
            return false;
        }
    }
    
    // Add student with auto-generated ID
    public boolean addStudentWithAutoId(StudentMark student) {
        int nextId = getNextAvailableId();
        student.setStudentId(nextId);
        System.out.println("Auto-assigned Student ID: " + nextId);
        return addStudent(student);
    }
    
    // Update existing marks
    public boolean updateStudent(StudentMark student) {
        String query = "UPDATE StudentMarks SET StudentName=?, Subject=?, Marks=?, ExamDate=? WHERE StudentID=?";
        
        System.out.println("Attempting to update student with ID: " + student.getStudentId());
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, student.getStudentName());
            pstmt.setString(2, student.getSubject());
            pstmt.setInt(3, student.getMarks());
            pstmt.setDate(4, student.getExamDate());
            pstmt.setInt(5, student.getStudentId());
            
            System.out.println("Executing update query: " + pstmt.toString());
            
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("SQL Error while updating: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete student record
    public boolean deleteStudent(int studentId) {
        String query = "DELETE FROM StudentMarks WHERE StudentID=?";
        
        System.out.println("Attempting to delete student with ID: " + studentId);
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, studentId);
            
            System.out.println("Executing delete query: " + pstmt.toString());
            
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("SQL Error while deleting: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Get all students
    public List<StudentMark> getAllStudents() {
        List<StudentMark> students = new ArrayList<>();
        String query = "SELECT * FROM StudentMarks ORDER BY StudentID";
        
        System.out.println("Fetching all students");
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }
            
            System.out.println("Found " + students.size() + " students");
            
        } catch (SQLException e) {
            System.out.println("SQL Error while fetching all students: " + e.getMessage());
            e.printStackTrace();
        }
        
        return students;
    }
    
    // Get student by ID
    public StudentMark getStudentById(int studentId) {
        String query = "SELECT * FROM StudentMarks WHERE StudentID=?";
        
        System.out.println("Searching for student with ID: " + studentId);
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, studentId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                StudentMark student = extractStudentFromResultSet(rs);
                System.out.println("Student found: " + student.getStudentName());
                return student;
            } else {
                System.out.println("No student found with ID: " + studentId);
            }
            
        } catch (SQLException e) {
            System.out.println("SQL Error while searching by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Report: Students with marks above threshold
    public List<StudentMark> getStudentsAboveMarks(int threshold) {
        List<StudentMark> students = new ArrayList<>();
        String query = "SELECT * FROM StudentMarks WHERE Marks >= ? ORDER BY Marks DESC";
        
        System.out.println("Fetching students with marks above: " + threshold);
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, threshold);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }
            
            System.out.println("Found " + students.size() + " students with marks above " + threshold);
            
        } catch (SQLException e) {
            System.out.println("SQL Error in above marks report: " + e.getMessage());
            e.printStackTrace();
        }
        
        return students;
    }
    
    // Report: Students by subject
    public List<StudentMark> getStudentsBySubject(String subject) {
        List<StudentMark> students = new ArrayList<>();
        String query = "SELECT * FROM StudentMarks WHERE Subject=? ORDER BY Marks DESC";
        
        System.out.println("Fetching students for subject: " + subject);
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, subject);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }
            
            System.out.println("Found " + students.size() + " students in " + subject);
            
        } catch (SQLException e) {
            System.out.println("SQL Error in subject report: " + e.getMessage());
            e.printStackTrace();
        }
        
        return students;
    }
    
    // Report: Top N students by marks
    public List<StudentMark> getTopNStudents(int n) {
        List<StudentMark> students = new ArrayList<>();
        String query = "SELECT * FROM StudentMarks ORDER BY Marks DESC LIMIT ?";
        
        System.out.println("Fetching top " + n + " students");
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, n);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }
            
            System.out.println("Retrieved top " + students.size() + " students");
            
        } catch (SQLException e) {
            System.out.println("SQL Error in top N report: " + e.getMessage());
            e.printStackTrace();
        }
        
        return students;
    }
    
    // Check if student exists
    public boolean studentExists(int studentId) {
        String query = "SELECT COUNT(*) FROM StudentMarks WHERE StudentID=?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, studentId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
            
        } catch (SQLException e) {
            System.out.println("SQL Error while checking student existence: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Get total number of students
    public int getTotalStudentCount() {
        String query = "SELECT COUNT(*) FROM StudentMarks";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.out.println("SQL Error while getting student count: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Get average marks of all students
    public double getAverageMarks() {
        String query = "SELECT AVG(Marks) FROM StudentMarks";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            if (rs.next()) {
                return rs.getDouble(1);
            }
            
        } catch (SQLException e) {
            System.out.println("SQL Error while getting average marks: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    // Helper method to extract StudentMark from ResultSet
    private StudentMark extractStudentFromResultSet(ResultSet rs) throws SQLException {
        StudentMark student = new StudentMark();
        student.setStudentId(rs.getInt("StudentID"));
        student.setStudentName(rs.getString("StudentName"));
        student.setSubject(rs.getString("Subject"));
        student.setMarks(rs.getInt("Marks"));
        student.setExamDate(rs.getDate("ExamDate"));
        return student;
    }
}