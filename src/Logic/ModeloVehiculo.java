/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logic;

import java.util.ArrayList;

/**
 *
 * @author juanj
 */
public class ModeloVehiculo {
    
    private ArrayList<Combustible> combustibles;
    private ArrayList<TipoModelo> tipos;
    private ArrayList<Caracteristica> caracteristicas;
    
    private String name;
    private int anoo;
    private int preciobase;

    public ModeloVehiculo() {
        combustibles = new ArrayList<>();
        tipos = new  ArrayList<>();
        caracteristicas = new ArrayList<>();        
    }
    
    public void addCombustible(Combustible entrante){
        if(!combustibles.contains(entrante)){
            combustibles.add(entrante);
        }
    }
    
    public void addTipo(TipoModelo entrante){
        if(!tipos.contains(entrante)){
            tipos.add(entrante);
        }
    }
    
    public void addCaracteristica(Caracteristica entrante){
        if(!caracteristicas.contains(entrante)){
            caracteristicas.add(entrante);
        }
    }

    public ArrayList<Combustible> getCombustibles() {
        return combustibles;
    }

    public void setCombustibles(ArrayList<Combustible> combustibles) {
        this.combustibles = combustibles;
    }

    public ArrayList<TipoModelo> getTipos() {
        return tipos;
    }

    public void setTipos(ArrayList<TipoModelo> tipos) {
        this.tipos = tipos;
    }

    public ArrayList<Caracteristica> getCaracteristicas() {
        return caracteristicas;
    }

    public void setCaracteristicas(ArrayList<Caracteristica> caracteristicas) {
        this.caracteristicas = caracteristicas;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAnoo() {
        return anoo;
    }

    public void setAnoo(int anoo) {
        this.anoo = anoo;
    }

    public double getPreciobase() {
        return preciobase;
    }

    public void setPreciobase(int preciobase) {
        this.preciobase = preciobase;
    }
    
    
}
