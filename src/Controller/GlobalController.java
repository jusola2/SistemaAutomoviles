/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Logic.Caracteristica;
import Logic.Cliente;
import Logic.Combustible;
import Logic.ModeloVehiculo;
import Logic.OrdenPago;
import Logic.TipoModelo;
import Logic.UserData;
import java.util.ArrayList;
import sistemaautomoviles.ConnectionSQL;

/**
 *
 * @author juanj
 */
public class GlobalController {
    
    protected ConnectionSQL serverConnection;
    
    private UserData ActualUser;
    
    public GlobalController(){
        serverConnection = new ConnectionSQL(1);
    }
    
    public void CommandAplicator(String command, String source){
        if(command.equals((String) "test")){
            serverConnection.startConnectionTest(source);
        }
    }
    
    public String logIn(String email, String password){
        String result = null;
        ActualUser = serverConnection.logInInfo(email, password);
        if(ActualUser!= null){
            if("Empleado".equals(ActualUser.getUserType())){
                ActualUser.setEmployeeType(serverConnection.getTypeOfEmployee(ActualUser.getBDId()));
                result = ActualUser.getEmployeeType();
            }else{
                result = "Cliente";
            }
        }
        return result;
    }
    
    public ArrayList<String> users(){
        return serverConnection.getUser();
    }
    
    public Cliente getSpecClient(int id){
    return serverConnection.getSpecificCliente(id);
    }
    
    public ArrayList<OrdenPago> ordenesPago(){
        return serverConnection.getOrdenesPago();
    }
    
    public ArrayList<Combustible> getCombustibles(){
        return serverConnection.combustibles();
    }

    public ArrayList<Caracteristica> getCaracteristicas() {
        return serverConnection.caracteristicas();
    }

    public ArrayList<TipoModelo> getTiposVehiculo() {
        return serverConnection.tiposVehiculos();
    }

    public boolean insertarModelo(ModeloVehiculo nuevoModelo) {
        return serverConnection.nuevoModelo(nuevoModelo);
    }
    
}
