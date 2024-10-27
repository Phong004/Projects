package controller;

import fileio.IFileReadWrite;
import model.*;
import fileio.*;
import utilities.Inputter;
import viewer.Menu;

import java.util.ArrayList;
import java.util.List;
import java.util.Collections;

public class CompanyManagement {

    private List<Employee> empList;
    
    public CompanyManagement() {
        empList = load();
        if (empList == null || empList.isEmpty()) {
            empList = new ArrayList<>();
        } 
    }
    
    private List<Employee> load() {
        try {
            IFileReadWrite file = new EmployeeFileText();
            return file.read();
        } catch (Exception e) {
            return null;
        }
    }

    public void addEmployee(Employee emp) {
        if (empList == null) {
            empList = new ArrayList<>();
        }
        try {
            if (isExistCode(emp.getEmpID())) {
                throw new Exception("The code existed!");
            } else if (emp == null) {
                throw new Exception("The Employee is null!");
            } 
            else {
                empList.add(emp);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void updateEmployee(Employee updateEmp) {
        try {
            int index = empList.indexOf(updateEmp.getEmpID());
            if (index < 0) {
                throw new Exception("Employee does not exist!");
            }
            else {
                empList.set(index, updateEmp);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public List<Employee> searchByName(String name) {
        List<Employee> list = new ArrayList<>();
        for (Employee emp : empList) {
            if (emp.getEmpName().toLowerCase().contains(name.trim().toLowerCase())) {
                list.add(emp);
            }
        }
        return list;
    }

    public Employee searchByID(String id) {
        for (Employee emp : empList) {
            if (emp.getEmpID().equals(id)) {
                return emp;
            }
        }
        return null;
    }

    public List<Employee> searchTesterHighestSalary() {
        double highestSal = 0;
        List<Employee> list = new ArrayList<>();
        for (Employee emp : empList) {
            if (!(emp.getClass().getSimpleName().equals("Tester"))) {
                continue;
            }
            Tester te = (Tester) emp;
            if (highestSal < te.getSalary()) {
                highestSal = te.getSalary();
            }
        }
        for (Employee emp : empList) {
            Tester te = (Tester) emp;
            if (te.getSalary() == highestSal) {
                list.add(te);
            }
        }
        return list;
    }

    public List<Developer> searchByPL(String pl) {
        String[] str = pl.split(",");
        List<String> pLang = new ArrayList<>();
        List<Developer> list = new ArrayList<>();
        Collections.addAll(pLang, str);
        for (Employee emp : empList) {
            if (!(emp instanceof Developer)) {
                continue;
            }
            Developer dev = (Developer) emp;
            List<String> pLangList = dev.getProgrammingLangs();
            if (pLangList.containsAll(pLang)) {
                list.add(dev);
            }
        }
        return list;
    }

    public List<Employee> getAllEmployees() {
        return empList;
    }

    public Employee getEmployee(String code) {
        try {
            if (empList == null) {
                throw new Exception("Employee List is null");
            }
            if (code.trim().isEmpty()) {
                throw new Exception("Code is null");
            }
            for (Employee emp : empList) {
                if (emp.getEmpID().equalsIgnoreCase(code)) {
                    return emp;
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public List<Employee> getAllEmployee() {
        return empList;
    }

    public boolean isExistCode(String code) {
        return (searchByID(code) != null);
    }

    public boolean isExistTeamLeader(String name) {
        for (Employee emp : empList) {
            if (!(emp instanceof TeamLeader)) {
                continue;
            }
            TeamLeader t1 = (TeamLeader) emp;
            if (t1.getTeamName().equals(name)) {
                return true;
            }
        }
        return false;
    }
    
    public boolean save() {
        try {
            IFileReadWrite file = new EmployeeFileText();
            return file.write(empList);
        } catch (Exception e) {
            return false;
        }
    }
}
