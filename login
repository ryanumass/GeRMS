/**************************************************************************
/* Login screen
/* database has accid, firstname, lastname, password
/* we can change what info we will require later (ex. username, age)
/* 
/* 2.1.2015
/*************************************************************************

import java.sql.*;
import java.util.Properties;
import java.util.Scanner;

public class login {
   // variables needed to make connection with DB
   private static final String dbClassName = "com.mysql.jdbc.Driver";
   private static final String CONNECTION = "jdbc:mysql://localhost/GeRMS";

   public static void main(String[] args) throws ClassNotFoundException,SQLException{
      Class.forName(dbClassName);
      // user/pwd to connect to DB
      Properties p = new Properties();
      p.put("user","root");
      p.put("password","L0cAdm1n");
      
      // DB connection
      Connection conn = DriverManager.getConnection(CONNECTION,p);

      // get username and password from user
      Scanner in = new Scanner(System.in);
      System.out.print("Enter username: ");
      String user = in.nextLine();
      System.out.print("Enter password: ");
      String password = in.nextLine();

      // get firstname and query the users table to get result
      Statement stmt = conn.createStatement();
      String sql;
      sql = "select * from accounts where firstname = '" + user + "'";
      ResultSet rs = stmt.executeQuery(sql);
 
      //if user exists, all fields associate to that user from table
      if (rs.next() == true){
         int id = rs.getInt("accID");
         String fname = rs.getString("firstname");
         String lname = rs.getString("lastname");
         String pwd = rs.getString("accpassword");
         
         //check if password matches with whatever the user entered.
         // if yes, show all info on screen
         if(pwd.equals(password))
         {
            System.out.print("ID: " + id);
            System.out.print(", FirstName: " + fname);
            System.out.print(", LastName: " + lname);
            System.out.println(", Password: " + pwd);
         }else{ // if password did not match, show message
            System.out.println("wrong password");
         }
      }else{ // if user does not exist, show message
         System.out.println("Wrong username");
      }
      // close all connection to DB
      rs.close();
      stmt.close();
      conn.close();
   }
}
