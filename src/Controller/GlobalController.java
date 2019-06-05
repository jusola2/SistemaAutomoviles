/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.util.ArrayList;
import sistemaautomoviles.ConnectionSQL;

/**
 *
 * @author juanj
 */
public class GlobalController {
    
    protected ConnectionSQL serverConnection;
    
    public GlobalController(){
        serverConnection = new ConnectionSQL(1);
    }
    
    public void CommandAplicator(String command){
        if(command.equals((String) "test")){
            serverConnection.startConnectionTest();
        }
    }
    
    public ArrayList<String> users(){
        return serverConnection.getUser();
    }
    
}
