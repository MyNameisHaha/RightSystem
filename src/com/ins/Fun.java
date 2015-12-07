package com.ins;

/**
 * Created by Xirui on 2015/11/1.
 */
import java.sql.Connection;
import java.sql.DriverManager;

class Fun {
    Fun() {
    }

    public static Connection getConn() {
        Connection var0;
        Connection var2;
        try {
            //String var1 = "jdbc:mysql://localhost/test1?useUnicode=true&characterEncoding=UTF-8";
            //Class.forName("com.mysql.jdbc.Driver");
            //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            //String var1 = "jdbc:odbc:practice";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String var1 = "jdbc:sqlserver://localhost:1433;DatabaseName=practice";
            var0 = DriverManager.getConnection(var1, "sa", "123");
            var2 = var0;
            return var2;
        } catch (Exception var6) {
            var6.printStackTrace();
            var2 = null;
        } finally {
            var0 = null;
        }

        return var2;
    }
}