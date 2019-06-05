 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sistemaautomoviles;

/**
 *
 * @author juanj
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class ConnectionSQL {
    private Connection con;
    private Boolean connectionState;
    
    public ConnectionSQL(int idCreador) { //la conneccion a la base de datos Juan
        switch (idCreador) {
            case 1:
                try{
                    String connectionUrl = "jdbc:sqlserver://JUANJOSESOLANO;databaseName=Person;integratedSecurity=true";
                    con = DriverManager.getConnection(connectionUrl);
                    connectionState = true;
                }catch(SQLException e){
                    con = null;
                    connectionState = false;
                }break;
            case 2://aqui pones el tuvo steph
                try{
                    String connectionUrl = "jdbc:sqlserver://JUANJOSESOLANO;databaseName=Person;integratedSecurity=true";//cambias tus datos de la base 
                    con = DriverManager.getConnection(connectionUrl);
                    connectionState = true;
                }catch(SQLException e){
                    con = null;
                    connectionState = false;
                }break;
            default:
                connectionState = false;
                break;
        }
    }

    public Connection getCon() {
        return con;
    }

    public Boolean getConnectionState() {
        return connectionState;
    }
    
    public ArrayList<String> getUser(){
        ArrayList<String> list = new ArrayList<>();
        try{
            Statement stmt = con.createStatement(); 
            String SQL = "SELECT  * FROM Contact";
            ResultSet rs = stmt.executeQuery(SQL);
            
            // Iterate through the data in the result set and display it.
            while (rs.next()) {
                list.add(rs.getString("FirstName") + " " + rs.getString("LastName")); 
                System.out.println(rs.getString("FirstName") + " " + rs.getString("LastName"));
            }
            //con.close();
            
        }
        // Handle any errors that may have occurred.
        catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    

    public void startConnectionTest(){        
        try{
            Statement stmt = con.createStatement(); 
            String SQL = "SELECT  * FROM Contact";
            ResultSet rs = stmt.executeQuery(SQL);

            // Iterate through the data in the result set and display it.
            while (rs.next()) {
                System.out.println(rs.getString("FirstName") + " " + rs.getString("LastName"));
            }
            //con.close();
            
        }
        // Handle any errors that may have occurred.
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void closeConnection() throws SQLException{
        con.close();
    }
}