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
                case 3:
                    Scanner scanner2 = new Scanner(System.in);
                    while (true) {
                        // create the property and add it to the property relation
                        System.out.print("> Enter 1 to upload a property, or press q to quit:\n> ");
                        input = scanner2.nextLine();
                        if (input.equals("q"))
                            break;
                        String query = "insert into property(property_id,street_address,city,province, " +
                                "property_type,room_type,accommodates,amenities,bathrooms,bedrooms,beds, " +
                                "host_id,branch_id) values (?,?,?,?,?,?,?,?,?,?,?,?,?);";
                        PreparedStatement ps = conn.prepareStatement(query);

                        System.out.print("> Enter the property ID: ");
                        int propertyId = Integer.parseInt(scanner2.nextLine());
                        ps.setInt(1,propertyId);

                        System.out.print("> Enter the street address: ");
                        ps.setString(2,scanner2.nextLine());

                        System.out.print("> Enter the city: ");
                        ps.setString(3,scanner2.nextLine());

                        System.out.print("> Enter the province (e.g. ON, QC, MB): ");
                        ps.setString(4,scanner2.nextLine());

                        System.out.print("> Enter the property type: ");
                        ps.setString(5,scanner2.nextLine());

                        System.out.print("> Enter the room type (entire, shared or private): ");
                        ps.setString(6,scanner2.nextLine());

                        System.out.print("> Enter the number of bathrooms: ");
                        ps.setInt(9,Integer.parseInt(scanner2.nextLine()));

                        System.out.print("> Enter the number of bedrooms: ");
                        ps.setInt(10,Integer.parseInt(scanner2.nextLine()));

                        System.out.print("> The rest of the property information is optional. " +
                                "Press ENTER to bypass them.\n" +
                                "> Enter the number of people accommodated: ");
                        input = scanner2.nextLine();
                        if(input.equals(""))
                            ps.setNull(7, Types.INTEGER);
                        else
                            ps.setInt(7, Integer.parseInt(input));

                        System.out.print("> Describe the amenities: ");
                        input = scanner2.nextLine();
                        if(input.equals(""))
                            ps.setNull(8, Types.VARCHAR);
                        else
                            ps.setString(8, input);

                        System.out.print("> Describe the beds: ");
                        input = scanner2.nextLine();
                        if(input.equals(""))
                            ps.setNull(11, Types.VARCHAR);
                        else
                            ps.setString(11, input);

                        System.out.print("> Enter the ID of the host that owns this property: ");
                        input = scanner2.nextLine();
                        if(input.equals(""))
                            ps.setNull(12, Types.INTEGER);
                        else
                            ps.setInt(12, Integer.parseInt(input));

                        System.out.print("> Enter the ID of the branch that oversees this property: ");
                        input = scanner2.nextLine();
                        if(input.equals(""))
                            ps.setNull(13, Types.INTEGER);
                        else
                            ps.setInt(13, Integer.parseInt(input));

                        int result = ps.executeUpdate();
                        System.out.println("> The property was created successfully.");
                        System.out.println("> The command modified " + result + " rows.");
                        ps.close();

                        // create the listing for the property and add it to the pricing relation
                        query = "insert into pricing(property_id, pricing_id, price, num_guests, rules) " +
                                "values (?,?,?,?,?);";
                        ps = conn.prepareStatement(query);
                        ps.setInt(1,propertyId);

                        System.out.print("> You will now create the listing.\n> Enter the listing ID: ");
                        ps.setInt(2,Integer.parseInt(scanner2.nextLine()));

                        System.out.print("> Enter the price(per day): ");
                        ps.setDouble(3,Double.parseDouble(scanner2.nextLine()));

                        System.out.print("> Enter the number of guests: ");
                        ps.setInt(4,Integer.parseInt(scanner2.nextLine()));

                        System.out.print("> (Optional: Press ENTER to bypass) Describe the rules for the property: ");
                        input = scanner2.nextLine();
                        if(input.equals(""))
                            ps.setNull(5, Types.VARCHAR);
                        else
                            ps.setString(5, input);

                        result = ps.executeUpdate();
                        System.out.println("> The listing for the property was uploaded successfully.");
                        System.out.println("> The command modified " + result + " rows.");
                        ps.close();
                    }
                    break;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
