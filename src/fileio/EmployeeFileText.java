/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fileio;

import model.*;
import java.util.List;
import java.util.ArrayList;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

/**
 *
 * @author phong
 */
public class EmployeeFileText implements IFileReadWrite<Employee> {
    private final String FILE_NAME =  "./Employee.txt";
    
    @Override
    public List<Employee> read() throws Exception {
        List<Employee> list = new ArrayList<>();
        File f;
        FileInputStream fileIn;
        BufferedReader myInput;
        try {
            f = new File(FILE_NAME);
            String fullPath = f.getAbsolutePath();
            fileIn = new FileInputStream(fullPath);
            myInput = new BufferedReader(new InputStreamReader(fileIn));
            String line;
            while ((line = myInput.readLine()) != null) {
                if (line.trim().isEmpty()) {
                    continue;
                }
                String[] sArr = line.split(" ");
                switch (sArr.length) {
                    case 6:
                        String code = sArr[1].trim();
                        String name = sArr[2].trim();
                        double baseSal = Double.parseDouble(sArr[3].trim());
                        double bonus = Double.parseDouble(sArr[4].trim());
                        String type = sArr[5].trim();
                        list.add(new Tester(code, name, baseSal, bonus, type));
                        break;
                    case 7:
                        code = sArr[1].trim();
                        name = sArr[2].trim();
                        baseSal = Double.parseDouble(sArr[3].trim());
                        String team = sArr[4].trim();
                        int expYear = Integer.parseInt(sArr[5].trim());
                        String pl = sArr[6].trim().substring(1, sArr[6].trim().length()-1);
                        List<String> listPL = new ArrayList<>();
                        for (String s: pl.split(",")) {
                            listPL.add(s.trim());
                        }
                        list.add(new Developer(code, name, baseSal, team, listPL, expYear));
                        break;
                    case 8:
                        code = sArr[1].trim();
                        name = sArr[2].trim();
                        baseSal = Double.parseDouble(sArr[3].trim());
                        team = sArr[4].trim();
                        expYear = Integer.parseInt(sArr[5].trim());
                        pl = sArr[6].trim().substring(1, sArr[6].trim().length()-1);
                        listPL = new ArrayList<>();
                        for (String s: pl.split(",")) {
                            listPL.add(s.trim());
                        }
                        bonus = Double.parseDouble(sArr[7].trim());
                        list.add(new TeamLeader(code, name, baseSal, team, listPL, expYear, bonus));
                        break;
                }
            }
            myInput.close();
            
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    @Override
    public boolean write(List<Employee> list) throws Exception {
        if (list.isEmpty()) {
            return false;
        }
        File f;
        FileOutputStream fileOut;
        BufferedWriter myOutput;
        try {
            f = new File(FILE_NAME);
            String fullPath = f.getAbsolutePath();
            fileOut = new FileOutputStream(fullPath);
            myOutput = new BufferedWriter(new OutputStreamWriter(fileOut));
            int i = 0;
            for (Employee emp : list) {
                if (i > 0) {
                    myOutput.newLine();
                }
                myOutput.write((++i) + "_" + emp.toFileString());
            }
            myOutput.close();
        } catch (Exception e) {
            throw e;
        }
        return true;
    }
}
