package de.dhbw.StudentForum;

import java.sql.*;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.sql.Connection;
import java.sql.DriverManager;


/*
 *     Project name:
 *     Assignment:
 *     Author:              Fabian, Janick, Daniel, Andreas
 *     Student number:
 *     Source  file:///Users/fabian/Downloads/MySQLDatabase.java.html 5.10.2017
 *
 *     Description:    Used to create connection to the database.
 *
 *                     Singleton Database class
 *                     Only one instance can be instatiatet.
 *               
 **************************************************************************                    
 *                     													*
 *                     ::::::: REQUIREMENTS ::::::						*
 *                     													*
 *                     													*
 *         Datenbank auf der es die Database >forum< aufgespielt ist 		*
 *         Referenz in der Entwicklungsumgebung für jdbc Treiber			*
 *         mysqladmin : User:= root  Password:= root						* 
 *         																*
 **************************************************************************        
 *         
 */



public class MySQLDatabase
{
    

    private Connection connection;
    private static String dbURL = "localhost:3306/forum";
    private static String dbUser = "root";
    private static String dbPass = "root";
  
    private static MySQLDatabase mySQLDatabase = new MySQLDatabase(dbURL, dbUser, dbPass);
    
    
    private MySQLDatabase(String dbURL, String dbUser, String dbPass)
    {
        
        MySQLDatabase.dbURL = dbURL;
        MySQLDatabase.dbUser = dbUser;
        MySQLDatabase.dbPass = dbPass;
        
        // Driver init
        try
        {
            // Edit Driverinfo
            System.out.println("* Treiber laden");
      	    Class.forName("com.mysql.jdbc.Driver").newInstance();
      	    
        } catch (Exception e){
            e.printStackTrace();}
        
    }
    
    /*
     This method returns the instance of the class.
     */
    public static MySQLDatabase getInstance()
    {
        return mySQLDatabase;
    }
    
    /*
     Creates and returns a connection to MySQL.
     */
    public Connection getConnection()
    {
        try
        {
            this.connection = DriverManager.getConnection("jdbc:mysql://"+dbURL+"?verifyServerCertificate=false&useSSL=true", dbUser,dbPass);
        }catch (Exception e){e.printStackTrace();}
        return this.connection;
    }
    
}
