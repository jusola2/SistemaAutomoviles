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
import Logic.Caracteristica;
import Logic.Combustible;
import Logic.ModeloVehiculo;
import Logic.TipoModelo;
import Logic.UserData;
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
    
    public String getTypeOfEmployee(int IdEmpleado){
        String tempType = null;
        try(CallableStatement cstmt = con.prepareCall("{call dbo.getEmployeeType  (?, ?)}");) {  
        cstmt.setInt(1, IdEmpleado);
        cstmt.registerOutParameter(2, java.sql.Types.NVARCHAR);  
        cstmt.execute();
        tempType = cstmt.getNString(2);  
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tempType;
    }
    
    public UserData logInInfo(String email, String password){
        int tempID = 0;
        String tempType = null;
        try(CallableStatement cstmt = con.prepareCall("{call dbo.getLogInId (?, ?, ?, ?)}");) {  
        cstmt.setNString(1, email);
        cstmt.setNString(2, password);
        cstmt.registerOutParameter(3, java.sql.Types.INTEGER);  
        cstmt.registerOutParameter(4, java.sql.Types.NVARCHAR);  
        cstmt.execute();
        tempID = cstmt.getInt(3);
        tempType = cstmt.getNString(4);  
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(tempID !=0){
            return new UserData(tempID, tempType);
        }else{
            return null;
        }
    }
    
    
    public void closeConnection() throws SQLException{
        con.close();
    }

    public ArrayList<String> getOrdenesPago() {
        ArrayList<String> list = new ArrayList<>();
        try(CallableStatement cstmt = con.prepareCall("{call dbo.getOrdenesPagoPendientes ()}");) {  
        ResultSet rs = cstmt.executeQuery();
        while (rs.next()) {
                list.add(Integer.toString(rs.getInt(1)));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public ArrayList<Combustible> combustibles() { 
        ArrayList<Combustible> list = new ArrayList<>();
        try(CallableStatement cstmt = con.prepareCall("{call dbo.getCombusType ()}");) {  
        ResultSet rs = cstmt.executeQuery();
        while (rs.next()) {
                list.add(new Combustible(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public ArrayList<Caracteristica> caracteristicas() {
        ArrayList<Caracteristica> list = new ArrayList<>();
        try(CallableStatement cstmt = con.prepareCall("{call dbo.getCaract()}");) {  
        ResultSet rs = cstmt.executeQuery();
        while (rs.next()) {
                list.add(new Caracteristica(rs.getInt(1), rs.getString(2), rs.getDouble(3)));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public ArrayList<TipoModelo> tiposVehiculos() {
        ArrayList<TipoModelo> list = new ArrayList<>();
        try(CallableStatement cstmt = con.prepareCall("{call dbo.getVehTypes()}");) {  
        ResultSet rs = cstmt.executeQuery();
        while (rs.next()) {
                list.add(new TipoModelo(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public boolean nuevoModelo(ModeloVehiculo nuevoModelo) {
        boolean resultado = true;
        try(CallableStatement cstmt = con.prepareCall("{call dbo.IngresarModelo  (?, ?, ?, ?)}");) {  
        cstmt.setNString(1, nuevoModelo.getName());
        cstmt.setInt(2, nuevoModelo.getAnoo());
        cstmt.setInt(3, (int)nuevoModelo.getPreciobase()); 
        cstmt.registerOutParameter(4, java.sql.Types.INTEGER);  
        cstmt.execute();
        if(cstmt.getInt(4)!=0){
            int idModelo = getModelID(nuevoModelo.getName());
            System.out.println("sistemaautomoviles.ConnectionSQL.nuevoModelo()");
            System.out.println("id del modelo "+idModelo); 
            for(TipoModelo tipo:nuevoModelo.getTipos()){
                insertarTipoDeModelo(idModelo, tipo.getId());
            }
        }
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
        return resultado;
    }
    
    public int getModelID(String NombreModelo){
        int idModelo = 0;
        try(CallableStatement cstmt = con.prepareCall("{call dbo.getModelIdByName  (?, ?)}");) {  
        cstmt.setNString(1, NombreModelo);
        cstmt.registerOutParameter(2, java.sql.Types.INTEGER);  
        cstmt.execute();
        idModelo=cstmt.getInt(2);
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
        return idModelo;
    }
    
    public void insertarTipoDeModelo(int idModelo,int idTipo){
        boolean resultado = false;
        try(CallableStatement cstmt = con.prepareCall("{call dbo.InsertTipoXModelo  (?, ?, ?)}");) {  
        cstmt.setInt(1, idModelo);
        cstmt.setInt(2, idTipo);
        cstmt.registerOutParameter(3, java.sql.Types.INTEGER);  
        cstmt.execute();
            System.out.println(cstmt.getInt(3));
        /*if(cstmt.getInt(3)!=1){
            resultado=true;
        }*/
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
        //return resultado;
    }

}