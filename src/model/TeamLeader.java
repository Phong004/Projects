/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.List;

/**
 *
 * @author phong
 */
public class TeamLeader extends Developer {

    private double bonus_rate;

    public TeamLeader(String empID, String empName, double baseSal,
            String teamName, List<String> programmingLanguages, int expYear,
            double bonus_rate) {
        super(empID, empName, baseSal, teamName, programmingLanguages, expYear);
        this.bonus_rate = bonus_rate;
    }

    public double getBonusRate() {
        return bonus_rate;
    }

    public void setBonusRate(double bonus_rate) {
        this.bonus_rate = bonus_rate;
    }

    @Override
    public double getSalary() {
        return super.getSalary() + bonus_rate * super.getSalary();
    }
    
    @Override
    public String toFileString() {
        return String.format("%s_%.2f", super.toFileString(), bonus_rate);
    }
}
