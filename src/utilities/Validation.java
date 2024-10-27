package utilities;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Scanner;

public class Validation {

    public static final Scanner sc = new Scanner(System.in);

    /**
     * Show message and read a String from keyboard
     * @param mess : String, message needs to show before read keyboard
     * @return String from keyboard
     */
    public static String checkString(String mess) {
        String value;
        while (true) {
            try {
                System.out.print(mess);
                value = sc.nextLine();
                if (value.isEmpty()) {
                    throw new Exception("Please input value!");
                }
                return value;
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }

    public static float checkFloat(String mess) {
        float value;
        while (true) {
            try {
                System.out.print(mess);
                value = Float.parseFloat(sc.nextLine());
                if (value <= 0) {
                    throw new Exception("Please input greater than 0!");
                }
                return value;
            } catch (NumberFormatException e) {
                System.out.println("Please enter a float value!");
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }
    
    public static double checkDouble(String mess) {
        double value;
        while (true) {
            try {
                System.out.print(mess);
                value = Double.parseDouble(sc.nextLine());
                if (value <= 0) {
                    throw new Exception("Please input greater than 0!");
                }
                return value;
            } catch (NumberFormatException e) {
                System.out.println("Please enter a double value!");
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }

    public static int checkInt(String mess, int max) {
        int value;
        while (true) {
            try {
                System.out.print(mess);
                value = Integer.parseInt(sc.nextLine());
                if (value <= 0) {
                    throw new Exception("Please input greater than 0!");
                } else if (value > max) {
                    throw new Exception("Please input again!");
                }
                return value;
            } catch (NumberFormatException e) {
                System.out.println("Please enter a int value!");
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }

    public static int checkInt(String mess) {
        int value;
        while (true) {
            try {
                System.out.print(mess);
                value = Integer.parseInt(sc.nextLine());
                if (value <= 0) {
                    throw new Exception("Please input greater than 0!");
                }
                return value;
            } catch (NumberFormatException e) {
                System.out.println("Please enter a int value!");
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }

    public static boolean checkDate(String date) {
        if (date == null) {
            return false;
        }

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        sdf.setLenient(false);
        try {
            sdf.parse(date);
            return true;
        } catch (ParseException e) {
            return false;
        }

    }

    public static String checkYesNo(String mess) {
        String value;
        while (true) {
            try {
                System.out.print(mess);
                value = sc.nextLine();
                if (value.isEmpty()) {
                    throw new Exception("Please input value!");
                }
                if (value.equalsIgnoreCase("Y") || value.equalsIgnoreCase("N")) {
                    return value;
                } else {
                    throw new Exception("Please input Y = Yes Or N = No!");
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }

    public static boolean checkFileExists(String fileName) {
        File f = new File(fileName);

        try {
            if (f.exists()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
}
