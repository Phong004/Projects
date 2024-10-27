/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author phong
 */
public abstract class Employee {

    private String empID;
    private String empName;
    private double baseSal;
    
    private String capitalizeString(String string) {
        char[] chars = string.toLowerCase().toCharArray();
        boolean found = false;
        for (int i = 0; i < chars.length; i++) {
            if (!found && Character.isLetter(chars[i])) {
                chars[i] = Character.toUpperCase(chars[i]);
                found = true;
            } else if (Character.isWhitespace(chars[i])) {
                found = false;
            }
        }
        return String.valueOf(chars).trim();
    }

    public Employee(String empID, String empName, double baseSal) {
        this.empID = empID;
        this.empName = capitalizeString(empName);
        this.baseSal = baseSal;
    }

    public void setEmpName(String empName) {
        this.empName = capitalizeString(empName);
    }

    public void setBaseSal(double baseSal) {
        this.baseSal = baseSal;
    }
    
    public String getEmpID() {
        return empID;
    }
    
    public String getEmpName() {
        return empName;
    }
    
    double getBaseSalary() {
        return baseSal;
    }

    public abstract double getSalary();

    @Override
    public String toString() {
        return String.format("%s_%s_%.2f", empID, empName, baseSal);
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        else if (obj == null) {
            return false;
        }
        else if (getClass() != obj.getClass()) {
            return false;
        }
        return true;
    }
    
    public String toFileString() {
        return toString();
    }
}
