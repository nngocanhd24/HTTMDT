package com.ngocanh.httmdt.dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    private static final String SERVER = "localhost";
    private static final String PORT = "1433";
    private static final String DATABASE = "QL_Du_Lich_v2";
    private static final String USER = "sa";
    private static final String PASSWORD = "123456";

    private static final String URL = "jdbc:sqlserver://" + SERVER + ":" + PORT + ";databaseName=" + DATABASE
            + ";encrypt=true;trustServerCertificate=true;characterEncoding=UTF-8";

    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

