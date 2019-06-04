/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sistemaautomoviles;

import GUI.LogIn;
import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;

/**
 *
 * @author juanj
 */
public class SistemaAutomoviles extends Application {
    private ConnectionSQL conect;
    @Override
    public void start(Stage primaryStage) {
        LogIn window = new LogIn();
        window.setVisible(true);
       
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        launch(args);
    }
    
}
