/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logic;

import Controller.GlobalController;
import javax.swing.JFrame;

/**
 *
 * @author juanj
 */
public interface ControllerCompatible {
    public void setController(GlobalController Pcontroller);
    public void ventanaAnterior(JFrame ventana);
}
