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
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ConnectionSQL {
    private Connection con;
    private Boolean connectionState;
    
    public ConnectionSQL(int idCreador) { //la conneccion a la base de datos Juan
        switch (idCreador) {
            case 1:
                try{
                    String connectionUrl = "jdbc:sqlserver://JUANJOSESOLANO;databaseName=Empresa;integratedSecurity=true";
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
    

    public void startConnectionTest(String password){        
        try{
            Statement stmt = con.createStatement(); 
            String SQL = "SELECT  * FROM UsuarioAplicacion";
            ResultSet rs = stmt.executeQuery(SQL);
            boolean exist= false;
            // Iterate through the data in the result set and display it.
            while (rs.next()) {
                System.out.println(rs.getString("Contraseña"));
                if(rs.getString("Contraseña") == null ? password == null : rs.getString("Contraseña").equals(password)){
                    exist = true;
                }
            }
            System.out.println("sistemaautomoviles.ConnectionSQL.startConnectionTest()");
            System.out.println(exist);
            //con.close();
            
        }
        // Handle any errors that may have occurred.
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void logInInfo(String email, String password){
        try(CallableStatement cstmt = con.prepareCall("{call dbo.getLogInId (?, ?, ?, ?)}");) {  
        cstmt.setNString(1, email);
        cstmt.setNString(2, password);
        cstmt.registerOutParameter(3, java.sql.Types.INTEGER);  
        cstmt.registerOutParameter(4, java.sql.Types.NVARCHAR);  
        cstmt.execute();  
        System.out.println("BD ID: " + cstmt.getInt(3));
        System.out.println("BD Type: " + cstmt.getNString(4));  
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
    public void closeConnection() throws SQLException{
        con.close();
    }
}