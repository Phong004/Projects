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
public class Developer extends Employee {

    private String teamName;
    private List<String> programmingLanguages;
    private int expYear;

    public Developer(String empID, String empName, double baseSal,
            String teamName, List<String> programmingLanguages, int expYear) {
        super(empID, empName, baseSal);
        this.teamName = teamName;
        this.programmingLanguages = programmingLanguages;
        this.expYear = expYear;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public void setProgrammingLanguages(List<String> programmingLanguages) {
        this.programmingLanguages = programmingLanguages;
    }

    public void setExpYear(int expYear) {
        this.expYear = expYear;
    }
    
    public String getTeamName() {
        return teamName;
    }
    
    public List<String> getProgrammingLangs() {
        return programmingLanguages;
    }
    
    @Override
    public double getSalary() {
        double salary = getBaseSalary();
        if (expYear >= 5) {
            salary += expYear * 2000000;
        } else if (expYear >= 3) {
            salary += expYear * 1000000;
        }
        return salary;
    }

    @Override
    public String toString() {
        return String.format("%s_%s_%d", super.toString(), teamName, expYear);
    }
    
    @Override
    public String toFileString() {
        return String.format("%s_%s", toString(), programmingLanguages);
    }
}
