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
public class UserData {
    
   private int BDId;
   private String UserType;
   
   private String employeeType;//is not null if the UserType is Empleado

    public UserData(int BDId, String UserType) {
        this.BDId = BDId;
        this.UserType = UserType;
    }

    public int getBDId() {
        return BDId;
    }

    public void setBDId(int BDId) {
        this.BDId = BDId;
    }

    public String getUserType() {
        return UserType;
    }

    public void setUserType(String UserType) {
        this.UserType = UserType;
    }

    public String getEmployeeType() {
        return employeeType;
    }

    public void setEmployeeType(String employeeType) {
        this.employeeType = employeeType;
    }
   
}
