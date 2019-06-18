/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logic;

/**
 *
 * @author juanj
 */
public class OrdenPago {
    
    private int id;
    private int idVehiculo;
    private int idCliente;
    private int idSucursal;
    private Cliente cliente;

    public OrdenPago(int id, int idVehiculo, int idCliente, int idSucursal) {
        this.id = id;
        this.idVehiculo = idVehiculo;
        this.idCliente = idCliente;
        this.idSucursal = idSucursal;
    }

    public OrdenPago(int id, int idVehiculo, int idCliente, int idSucursal, Cliente cliente) {
        this.id = id;
        this.idVehiculo = idVehiculo;
        this.idCliente = idCliente;
        this.idSucursal = idSucursal;
        this.cliente = cliente;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdVehiculo() {
        return idVehiculo;
    }

    public void setIdVehiculo(int idVehiculo) {
        this.idVehiculo = idVehiculo;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getIdSucursal() {
        return idSucursal;
    }

    public void setIdSucursal(int idSucursal) {
        this.idSucursal = idSucursal;
    }
    
       
    
}
