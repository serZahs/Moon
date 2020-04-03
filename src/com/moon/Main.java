package com.moon;

import java.io.InputStream;
import java.sql.*;
import java.util.HashMap;
import java.util.Properties;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        // load db connection parameters from properties file
        Properties config = new Properties();
        try {
            InputStream configStream = Main.class.getClassLoader().getResourceAsStream("config.properties");
            config.load(configStream);
        } catch (Exception e) {
            System.out.println("Could not load config file.");
        }

        // connect to db
        String url = config.getProperty("db.url");
        Properties props = new Properties();
        props.setProperty("user",config.getProperty("db.user"));
        props.setProperty("password",config.getProperty("db.password"));
        props.setProperty("ssl","false");
        props.setProperty("currentSchema", config.getProperty("db.schema"));
        try {
            Connection conn = DriverManager.getConnection(url, props);

            Scanner scanner = new Scanner(System.in);
            String input;
            int currentUser = 0;
            boolean leave = false;
            HashMap<Integer, String> usertype = new HashMap<>();
            usertype.put(1,"DB Admin");
            usertype.put(2,"Guest");
            usertype.put(3,"Host");
            usertype.put(4,"Branch employee");

            while (!leave) {
                System.out.print("> What would you like to login as? " +
                        "(1) DB Admin (2) Guest (3) Host (4) Branch employee\n> ");
                input = scanner.next();
                if (input.equals("1") || input.equals("2") || input.equals("3") || input.equals("4")) {
                    currentUser = Integer.parseInt(input);
                    leave = true;
                }
            }
            System.out.println("> Logged in as " + usertype.get(currentUser));
            switch (currentUser) {
                case 1:
                    leave = false;
                    while (!leave) {
                        System.out.print("> Which type of SQL operation would you like to perform? " +
                                "(1) Query e.g. SELECT (2) Update the db e.g. INSERT, UPDATE\n> ");
                        Scanner scanner2 = new Scanner(System.in);
                        input = scanner2.nextLine();
                        if (input.equals("1")) {
                            while (true) {
                                System.out.print("> Enter a query (SELECT) on the database, or q to quit:\n> ");
                                input = scanner2.nextLine();
                                if (input.equals("q"))
                                    break;
                                Statement st3 = conn.createStatement();
                                ResultSet rs3 = st3.executeQuery(input);
                                ResultSetMetaData md = rs3.getMetaData();

                                // print result set column names
                                for (int i = 1; i <= md.getColumnCount(); i++) {
                                    if (i != md.getColumnCount())
                                        System.out.print(md.getColumnName(i) + ",");
                                    else
                                        System.out.println(md.getColumnName(i));
                                }

                                // print result set data
                                while (rs3.next()) {
                                    for (int i = 1; i <= md.getColumnCount(); i++) {
                                        if (i != md.getColumnCount())
                                            System.out.print(rs3.getString(i) + ",");
                                        else
                                            System.out.println(rs3.getString(i));
                                    }
                                }
                                rs3.close();
                                st3.close();
                            }
                            leave = true;
                        } else if (input.equals("2")) {
                            while (true) {
                                System.out.print("> Enter an update command on the database, or q to quit:\n> ");
                                input = scanner2.nextLine();
                                if (input.equals("q"))
                                    break;
                                Statement st3 = conn.createStatement();
                                int result = st3.executeUpdate(input);
                                System.out.println("> The command modified " + result + " rows.");
                                st3.close();
                            }
                            leave = true;
                        }
                    }
                    break;
                case 2:
                    // print the addresses and rates of properties that have listings,
                    // and which dates they're booked if they have been booked
                    System.out.println("> Current Listings");

                    Statement st = conn.createStatement();
                    ResultSet rs = st.executeQuery("select property_id, street_address, city, province, " +
                            "property_type, room_type, price from property natural join pricing");
                    while (rs.next())
                    {
                        System.out.print(rs.getString(2) + ", "
                                + rs.getString(3) + ", " + rs.getString(4) + "\n");
                        System.out.print(rs.getString(5) + ", "
                                + rs.getString(6) + " | ");
                        System.out.println("\uD83D\uDCB0 " + rs.getString(7) + "/day");
                        Statement st2 = conn.createStatement();
                        ResultSet rs2 = st2.executeQuery("select property_id, start_date, end_date " +
                                "from pricing natural join rentalagreement " +
                                "where property_id = " + rs.getString(1) + ";");
                        while (rs2.next()) {
                            System.out.println("\uD83D\uDCC5 " + rs2.getString(2) +
                                    " to " + rs2.getString(3));
                        }
                        rs2.close();
                        st2.close();
                        System.out.println("=============================================================");
                    }
                    rs.close();
                    st.close();
                    break;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
