/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.management.dao;

import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;
import net.daw.data.MysqlData;
import net.daw.helper.Conexion;
import net.daw.helper.FilterBean;
import java.text.SimpleDateFormat;

/**
 *
 * @author rafa
 * @param <TIPO_OBJETO>
 *
 */
public class GenericDaoImplementation<TIPO_OBJETO> implements GenericDao<TIPO_OBJETO> {

    protected final MysqlData oMysql;
    protected final Conexion.Tipo_conexion enumTipoConexion;
    protected final String strTabla;

    public GenericDaoImplementation(Conexion.Tipo_conexion tipoConexion, String tabla) throws Exception {
        oMysql = new MysqlData();
        enumTipoConexion = tipoConexion;
        strTabla = tabla;
    }

    @Override
    public int getPages(int intRegsPerPag, ArrayList<FilterBean> hmFilter, HashMap<String, String> hmOrder) throws Exception {
        int pages;
        try {
            oMysql.conexion(enumTipoConexion);
            pages = oMysql.getPages(strTabla, intRegsPerPag, hmFilter, hmOrder);
            oMysql.desconexion();
            return pages;
        } catch (Exception e) {
            throw new Exception("GenericDao.getPages: Error: " + e.getMessage());
        }
    }

    @Override
    public int getCount(ArrayList<FilterBean> hmFilter) throws Exception {
        int pages;
        try {
            oMysql.conexion(enumTipoConexion);
            pages = oMysql.getCount(strTabla, hmFilter);
            oMysql.desconexion();
            return pages;
        } catch (Exception e) {
            throw new Exception("GenericDao.getCount: Error: " + e.getMessage());
        }

    }

    @Override
    public ArrayList<TIPO_OBJETO> getPage(int intRegsPerPag, int intPage, ArrayList<FilterBean> hmFilter, HashMap<String, String> hmOrder) throws Exception {
        Class<TIPO_OBJETO> tipo = (Class<TIPO_OBJETO>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        Method metodo_setId = tipo.getMethod("setId", Integer.class);
        ArrayList<Integer> arrId;
        ArrayList<TIPO_OBJETO> arrCliente = new ArrayList<>();
        try {
            oMysql.conexion(enumTipoConexion);
            arrId = oMysql.getPage(strTabla, intRegsPerPag, intPage, hmFilter, hmOrder);
            Iterator<Integer> iterador = arrId.listIterator();
            while (iterador.hasNext()) {
                Object oBean = Class.forName(tipo.getName()).newInstance();
                metodo_setId.invoke(oBean, iterador.next());
                arrCliente.add(this.get((TIPO_OBJETO) oBean));
            }
            oMysql.desconexion();
            return arrCliente;
        } catch (Exception e) {
            throw new Exception("GenericDao.getPage: Error: " + e.getMessage());
        }

    }

    @Override
    public TIPO_OBJETO get(TIPO_OBJETO oBean) throws Exception {
        Class<TIPO_OBJETO> tipo = (Class<TIPO_OBJETO>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        Method metodo_getId = tipo.getMethod("getId");
        Method metodo_setId = tipo.getMethod("setId", Integer.class);
        if ((Integer) metodo_getId.invoke(oBean) > 0) {
            try {
                oMysql.conexion(enumTipoConexion);
                if (!oMysql.existsOne(strTabla, (Integer) metodo_getId.invoke(oBean))) {
                    metodo_setId.invoke(oBean, 0);
                } else {
                    for (Method method : tipo.getMethods()) {
                        if (!method.getName().substring(3).equalsIgnoreCase("id")) {
                            if (method.getName().substring(0, 3).equalsIgnoreCase("set")) {
                                final Class<?> strTipoParamMetodoSet = method.getParameterTypes()[0];
                                String strValor = oMysql.getOne(strTabla, method.getName().substring(3).toLowerCase(Locale.ENGLISH), (Integer) metodo_getId.invoke(oBean));
                                if (strValor != null) {
                                    switch (strTipoParamMetodoSet.getName()) {
                                        case "java.lang.Double":
                                            method.invoke(oBean, Double.parseDouble(strValor));
                                            break;
                                        case "java.lang.Integer":
                                            method.invoke(oBean, Integer.parseInt(strValor));
                                            break;
                                        case "java.lang.Boolean":
                                            if (Integer.parseInt(strValor) == 1) {
                                                method.invoke(oBean, true);
                                            } else {
                                                method.invoke(oBean, false);
                                            }
                                            break;
                                        case "java.util.Date":
                                            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                                            method.invoke(oBean, format.parse(strValor));
                                            break;
                                        default:
                                            method.invoke(oBean, strValor);
                                            break;
                                    }
                                }
                            }
                        }
                    }
                }
            } catch (Exception e) {
                throw new Exception("GenericDao.get: Error: " + e.getMessage());
            } finally {
                oMysql.desconexion();
            }
        } else {
            metodo_setId.invoke(oBean, 0);
        }
        return oBean;

    }

    @Override
    public TIPO_OBJETO set(TIPO_OBJETO oBean) throws Exception {
        Class<TIPO_OBJETO> tipo = (Class<TIPO_OBJETO>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        Method metodo_getId = tipo.getMethod("getId");
        Method metodo_setId = tipo.getMethod("setId", Integer.class);
        try {
            oMysql.conexion(enumTipoConexion);
            oMysql.initTrans();
            if ((Integer) metodo_getId.invoke(oBean) == 0) {
                metodo_setId.invoke(oBean, oMysql.insertOne(strTabla));
            }
            for (Method method : tipo.getMethods()) {
                if (!method.getName().substring(3).equalsIgnoreCase("id")) {
                    if (method.getName().substring(0, 3).equalsIgnoreCase("get")) {
                        if (!method.getName().equals("getClass")) {
                            final Class<?> strTipoDevueltoMetodoGet = method.getReturnType();
                            String value = (String) method.invoke(oBean).toString();
                            switch (strTipoDevueltoMetodoGet.getName()) {
                                case "java.util.Date":
                                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                                    value = format.format(method.invoke(oBean));
                                    break;
                                case "java.lang.Boolean":
                                    if ("true".equals(value)) {
                                        value = "1";
                                    } else {
                                        value = "0";
                                    }
                                    break;
                            }
                            String strCampo = method.getName().substring(3).toLowerCase(Locale.ENGLISH);
                            oMysql.updateOne((Integer) metodo_getId.invoke(oBean), strTabla, strCampo, value);

                        }
                    }
                }
            }
            oMysql.commitTrans();
        } catch (Exception e) {
            oMysql.rollbackTrans();
            throw new Exception("GenericDao.set: Error: " + e.getMessage());
        } finally {
            oMysql.desconexion();
        }
            return oBean;
    }

    @Override
    public void remove(TIPO_OBJETO oBean) throws Exception {
        Class<TIPO_OBJETO> tipo = (Class<TIPO_OBJETO>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        Method metodo_getId = tipo.getMethod("getId");
        try {
            oMysql.conexion(enumTipoConexion);
            oMysql.removeOne((Integer) metodo_getId.invoke(oBean), strTabla);
            oMysql.desconexion();
        } catch (Exception e) {
            throw new Exception("GenericDao.remove: Error: " + e.getMessage());
        } finally {
            oMysql.desconexion();
        }
    }

    @Override
    public ArrayList<String> getColumnsNames() throws Exception {
        ArrayList<String> alColumns = null;
        try {
            oMysql.conexion(enumTipoConexion);
            alColumns = oMysql.getColumnsName(strTabla, Conexion.getDatabaseName());
            oMysql.desconexion();

        } catch (Exception e) {
            throw new Exception("GenericDao.remove: Error: " + e.getMessage());
        } finally {
            oMysql.desconexion();
        }
        return alColumns;
    }
}
