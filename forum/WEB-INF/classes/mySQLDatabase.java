import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;



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
 */



public class MySQLDatabase
{
    
    
    private static MySQLDatabase mySQLDatabase; //Wird im Konstruktor gesetzt davor direkt initialisiert // festcodiert
    
    private Connection connection;
    private String dbURL;
    private String dbUser;
    private String dbPass;
    
    
    private MySQLDatabase(String dbURL, String dbUser, String dbPass, String DatabaseUrl, String rootUser, String rootPw)
    {
        
        this.dbURL = dbURL;
        this.dbUser = dbUser;
        this.dbPass = dbPass;
        
        //Driver init
        try
        {
            // Edit Driverinfo
            Class.forName("com.mysql.jdbc.Driver");
            
            mySQLDatabase = new MySQLDatabase(DatabaseUrl, rootUser, rootPw);
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
            this.connection = DriverManager.getConnection(this.dbURL, this.dbUser, this.dbPass);
        }catch (Exception e){e.printStackTrace();}
        return this.connection;
    }
    
}
