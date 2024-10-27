package viewer;

import java.util.Collections;
import controller.CompanyManagement;
import model.*;
import utilities.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {

    CompanyManagement cm = new CompanyManagement();

    public static void main(String[] args) throws Exception {
        // Menu options
        String[] options = {"Show the Employee list",
            "Add Employee", "Update Employee ",
            "Search Employee", "Save",
            "Sort Employees", "Exit"};
        Main main = new Main();

        int choice = 0;
        System.out.println(
                "Note: \nAll employee's salary based on the actual salary after multiply with the bonus and casted into integer!!!");
        do {
            System.out.println("\nCompany Employee Management Program");
            choice = Menu.getChoice(options); // show Menu options
            switch (choice) {
                case 1:
                    main.printList();
                    break;
                case 2:
                    main.addEmployee();
                    break;
                case 3:
                    main.updateEmployee();
                    break;
                case 4:
                    //main.searchEmployee();
                    break;
                case 5:
                    main.save();
                    break;
                case 6:
                    //main.sort();
                    break;
                default:
                    System.out.println("Good bye!");
            }
        } while (choice > 0 && choice < options.length);
    }

    private void addTester() {
        boolean check;
        String code;
        do {
            code = Inputter.inputNonBlankStr("Enter new Tester ID: ");
            check = cm.isExistCode(code);
            if (check) {
                System.out.println("Employee ID is exist, re-enter please!");
            }
        } while (check);
        String name = Inputter.inputStr("Enter new Tester name: ");
        double baseSal = Inputter.inputDouble("Enter new Tester base salary: ");
        double bonus = Inputter.inputDouble("Enter new Tester bonus rate: ");
        String type = Inputter.inputNonBlankStr("Enter new Tester type");
        Tester emp = new Tester(code, name, baseSal, bonus, type);
        cm.addEmployee(emp);
    }

    private void addDeveloper() {
        boolean check;
        String code;
        do {
            code = Inputter.inputNonBlankStr("Enter new Developer ID: ");
            check = cm.isExistCode(code);
            if (check) {
                System.out.println("Employee ID is exist, re-enter please!");
            }
        } while (check);
        String name = Inputter.inputStr("Enter new Developer name: ");
        double baseSal = Inputter.inputDouble("Enter new Developer base salary: ");
        String teamName = Inputter.inputNonBlankStr("Enter new Developer team name: ");
        String programLang = Inputter.inputNonBlankStr("Enter new Developer programming languages (eg: C,C++,Python): ");
        String[] str = programLang.split(",");
        List<String> programmingLanguage = new ArrayList<>();
        programmingLanguage.addAll(Arrays.asList(str));

        int expYear = Inputter.inputInt("Enter new Developer number of years of experience: ");

        Developer emp = new Developer(code, name, baseSal, teamName, programmingLanguage, expYear);

        cm.addEmployee(emp);
    }

    private void addTeamLeader() {
        boolean check;
        String code;
        do {
            code = Inputter.inputNonBlankStr("Enter new Team Leader ID: ");
            check = cm.isExistCode(code);
            if (check) {
                System.out.println("Employee ID is exist, re-enter please!");
            }
        } while (check);
        String name = Inputter.inputStr("Enter new Team Leader name: ");
        double baseSal = Inputter.inputDouble("Enter new Team Leader base salary: ");
        String teamName;
        do {
            teamName = Inputter.inputNonBlankStr("Enter new Team Leader team name: ");
            check = cm.isExistTeamLeader(teamName);
        } while (check);
        String programLang = Inputter.inputNonBlankStr("Enter new Team Leader programming languages (eg: C,C++,Python): ");
        String[] str = programLang.split(",");
        List<String> programmingLanguage = new ArrayList<>();
        programmingLanguage.addAll(Arrays.asList(str));
        double bonus = Inputter.inputDouble("Enter new Team Leader bonus rate: ");

        int expYear = Inputter.inputInt("Enter new Developer number of years of experience: ");

        TeamLeader emp = new TeamLeader(code, name, baseSal, teamName, programmingLanguage, expYear, bonus);
        cm.addEmployee(emp);
    }

    private void addEmployee() {
        String options[] = {"Add new Tester", "Add new Developer",
             "Add new Team Leader", "Return to Main Menu"};
        int choice = 0;
        do {
            choice = Menu.getChoice(options);
            switch (choice) {
                case 1:
                    addTester();
                    break;
                case 2:
                    addDeveloper();
                    break;
                case 3:
                    addTeamLeader();
                    break;
                default:
                    System.out.println("Returning to Main Menu!");

            }
        } while (choice > 0 && choice < options.length);
    }

    private void updateTester() {
        String code = Inputter.inputNonBlankStr("Enter updated Tester ID: ");
        Employee emp = cm.getEmployee(code);
        if (emp == null) {
            System.out.println("Employee ID is none exist!");
        } else if (emp.getClass().getSimpleName().equals("Tester")) {
            Tester tester = (Tester)emp;
            String name = Inputter.inputStr("Enter updated Tester name: ");
            double baseSal = Inputter.inputDouble("Enter updated Tester base salary: ");
            double bonus = Inputter.inputDouble("Enter updated Tester bonus rate: ");
            String type = Inputter.inputNonBlankStr("Enter updated Tester type");
            tester.setEmpName(name);
            tester.setBaseSal(baseSal);
            tester.setBonusRate(bonus);
            tester.setType(type);
            cm.updateEmployee(tester);
        }
    }

    private void updateDeveloper() {
        String code = Inputter.inputNonBlankStr("Enter updated Developer ID: ");
        Employee emp = cm.getEmployee(code);
        if (emp == null) {
            System.out.println("Employee ID is none exist!");
        } else if (emp.getClass().getSimpleName().equals("Developer")) {
            Developer dev = (Developer)emp;
            String name = Inputter.inputStr("Enter updated Developer name: ");
            double baseSal = Inputter.inputDouble("Enter updated Developer base salary: ");
            String team = Inputter.inputNonBlankStr("Enter updated Developer team");
            String pl = Inputter.inputNonBlankStr("Enter updated Developer Programming languages: ");
            List<String> listPL = Arrays.asList(pl.split(","));
            int expYear = Inputter.inputInt("Enter updated Developer experience year: ");
            dev.setEmpName(name);
            dev.setBaseSal(baseSal);
            dev.setTeamName(team);
            dev.setProgrammingLanguages(listPL);
            dev.setExpYear(expYear);
            cm.updateEmployee(dev);
        }
    }

    private void updateTeamLeader() {
        String code = Inputter.inputNonBlankStr("Enter updated Team Leader ID: ");
        Employee emp = cm.getEmployee(code);
        if (emp == null) {
            System.out.println("Employee ID is none exist!");
        } else if (emp.getClass().getSimpleName().equals("Team Leader")) {
            TeamLeader tl = (TeamLeader)emp;
            String name = Inputter.inputStr("Enter updated Team Leader name: ");
            double baseSal = Inputter.inputDouble("Enter updated Team Leader base salary: ");
            String team = Inputter.inputNonBlankStr("Enter updated Team Leader team");
            String pl = Inputter.inputNonBlankStr("Enter updated Team Leader Programming languages: ");
            List<String> listPL = Arrays.asList(pl.split(","));
            int expYear = Inputter.inputInt("Enter updated Team Leader experience year: ");
            double bonus = Inputter.inputDouble("Enter updated Team Leader bonus rate: ");
            tl.setEmpName(name);
            tl.setBaseSal(baseSal);
            tl.setTeamName(team);
            tl.setProgrammingLanguages(listPL);
            tl.setExpYear(expYear);
            tl.setBonusRate(bonus);
            cm.updateEmployee(tl);
        }
    }

    private void updateEmployee() {
        String options[] = {"Update Tester", "Update Developer",
            "Update Team Leader", "Return to Main Menu"};
        int choice = 0;
        do {
            choice = Menu.getChoice(options);
            switch (choice) {
                case 1:
                    updateTester();
                    break;
                case 2:
                    updateDeveloper();
                    break;
                case 3:
                    updateTeamLeader();
                    break;
                default:
                    System.out.println("Returning to Main Menu!");
            }
        } while (choice > 0 && choice < options.length);
    }

    private void save() {
        if (cm.save()) {
            System.out.println("Save Successfully!");
        } else {
            System.out.println("Save Failed!");
        }
    }

    private void printList(List<Employee> empList) {
        int i = 0;
        for (Employee emp : empList) {
            System.out.println((++i)+emp.toFileString());
        }
    }

    private void printList() {
        List<Employee> empList = cm.getAllEmployees();
        printList(empList);
    }

}
