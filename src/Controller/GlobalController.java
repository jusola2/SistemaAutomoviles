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
    
    public void CommandAplicator(String command, String source){
        if(command.equals((String) "test")){
            serverConnection.startConnectionTest(source);
        }
    }
    
    public void logIn(String email, String password){
        serverConnection.logInInfo(email, password);
    }
    
    public ArrayList<String> users(){
        return serverConnection.getUser();
    }
    
}
