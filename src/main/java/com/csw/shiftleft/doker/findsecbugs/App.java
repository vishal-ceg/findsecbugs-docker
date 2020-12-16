/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.csw.shiftleft.doker.findsecbugs;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 *
 * @author Vishal
 */
public class App {

    public static void main(String[] args) {
        //String finalArgs = "spotbugs -maxHeap 3000 -xml:withMessages -output secbugs-output.xml -include C:\\Users\\Vishal\\Downloads\\opt\\include.xml -nested:false -auxclasspath C:\\Users\\Vishal\\Documents\\NetBeansProjects\\jenkins-hello C:\\Users\\Vishal\\Documents\\NetBeansProjects\\jenkins-hello";
        String finalArgs = "java -jar /usr/bin/findbugs/lib/spotbugs.jar -pluginList /usr/bin/findbugs/lib/findsecbugs-plugin.jar -xml:withMessages -output scan/secbugs-output.xml -include /usr/bin/findbugs/lib/include.xml -nested:false -auxclasspath scan scan";

        try {

            Process process = Runtime.getRuntime().exec(new String[]{"/bin/sh", "-c", finalArgs});
            StringBuilder outputErr = new StringBuilder();
            BufferedReader reader1 = new BufferedReader(
                    new InputStreamReader(process.getErrorStream()));

            // error
            String errorStr;
            while ((errorStr = reader1.readLine()) != null) {
                outputErr.append(errorStr + "\n");
            }
            // Out
            StringBuilder output = new StringBuilder();
            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(process.getInputStream()));

            String line;
            while ((line = reader.readLine()) != null) {
                output.append(line + "\n");
            }

            int exitVal = process.waitFor();

            if (exitVal == 0) {
                System.out.println(output);
                System.exit(0);
            } else {
                System.out.println(outputErr);
                System.exit(0);
            }

        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }

}
