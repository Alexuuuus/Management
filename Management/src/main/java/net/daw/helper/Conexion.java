/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.daw.helper;

/**
 *
 * @author rafa
 */
public class Conexion {

    public static enum Tipo_conexion {

        DataSource,
        DriverManager
    };

    public static Tipo_conexion getConection() {
        return Tipo_conexion.DataSource;
    }

    public static String getDatabaseName() {
        return "management";
    }

    public static String getDatabaseLogin() {
        return "root";
    }

    public static String getDatabasePassword() {
        return "bitnami";
    }

    public static String getDatabasePort() {
        return "";
    }

    public static String getDatabaseHost() {
        return "localhost";
    }
}
