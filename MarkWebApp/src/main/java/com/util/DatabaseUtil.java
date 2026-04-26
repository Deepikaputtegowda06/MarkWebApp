package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {
    // Change these values according to your MySQL setup
    private static final String URL = "jdbc:mysql://localhost:3306/MarkManagementDB?useSSL=false&serverTimezone=UTC";
    private static final String USERNAME = "root";  // Change if different
    private static final String PASSWORD = "thanu2005";  // Change to your MySQL password
    
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL Driver loaded successfully!");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found!");
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException {
        try {
            Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("Database connected successfully!");
            return conn;
        } catch (SQLException e) {
            System.out.println("Database connection failed!");
            System.out.println("Error: " + e.getMessage());
            throw e;
        }
    }
    
    // Test the connection
    public static void main(String[] args) {
        try {
            Connection conn = getConnection();
            if (conn != null) {
                System.out.println("Connection test successful!");
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}