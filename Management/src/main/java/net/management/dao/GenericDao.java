package net.management.dao;

import java.util.ArrayList;
import java.util.HashMap;
import net.daw.helper.FilterBean;


public interface GenericDao<objeto> {

    public int getPages(int intRegsPerPag, ArrayList<FilterBean> hmFilter, HashMap<String, String> hmOrder) throws Exception;

    public int getCount(ArrayList<FilterBean> hmFilter) throws Exception;

    public ArrayList<objeto> getPage(int intRegsPerPag, int intPage, ArrayList<FilterBean> hmFilter, HashMap<String, String> hmOrder) throws Exception;

    public objeto get(objeto oBean) throws Exception;

    public objeto set(objeto oBean) throws Exception;

    public void remove(objeto oBean) throws Exception;

    public ArrayList<String> getColumnsNames() throws Exception;
}
