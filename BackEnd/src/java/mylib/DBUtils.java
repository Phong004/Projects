/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mylib;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBUtils {
//    Do not change this code
    private static final String DB_NAME = "FPTEventManagement";
    private static final String DEFAULT_USER = "SA";
    private static final String DEFAULT_PASSWORD = "Admin12345!";
    private static final String DEFAULT_HOST = "host.docker.internal";
    private static final String DEFAULT_PORT = "1433";

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Connection conn = null;
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String serverName = System.getenv("DB_HOST");
        if (serverName == null || serverName.isEmpty()) {
            serverName = DEFAULT_HOST;
        }
        String db_port = System.getenv("DB_PORT");
        if (db_port == null || db_port.isEmpty()) {
            db_port = DEFAULT_PORT;
        }
        String db_user = System.getenv("DB_USER");
        if (db_user == null || db_user.isEmpty()) {
            db_user = DEFAULT_USER;
        }
        String db_pass = System.getenv("DB_PASSWORD");
        if (db_pass == null || db_pass.isEmpty()) {
            db_pass = DEFAULT_PASSWORD;
        }
        String url = String.format("jdbc:sqlserver://%s:%s;databaseName=%s", serverName, db_port, DB_NAME);
        conn = DriverManager.getConnection(url, db_user, db_pass);
        return conn;
    }
}
