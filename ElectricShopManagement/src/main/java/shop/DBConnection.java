package shop;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {

        Connection con = null;

        try {

            System.out.println("Step 1");

            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("Step 2");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/electricshop",
                "root",
                ""
            );

            System.out.println("DB Connected");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}