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
public class Tester extends Employee {

    private double bonusRate;
    private String type;

    public Tester(String empID, String empName, double baseSal,
            double bonusRate, String type) {
        super(empID, empName, baseSal);
        this.bonusRate = bonusRate;
        this.type = type;
    }

    public double getBonusRate() {
        return bonusRate;
    }

    public void setBonusRate(double bonusRate) {
        this.bonusRate = bonusRate;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
    @Override
    public double getSalary() {
        return getBaseSalary() + bonusRate * getBaseSalary();
    }
    
    @Override
    public String toFileString() {
        return String.format("%s_%.2f_%s", super.toFileString(), bonusRate, type);
    }
}
