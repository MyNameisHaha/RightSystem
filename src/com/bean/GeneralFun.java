package com.bean;

import com.ins.exelnsertUpdateDelete;
import com.ins.exeQueryResult;




/**
 * Created by Xirui on 2015/11/1.
 *
 * 代码相当冗余 可以用switch语句重构
 */

public class GeneralFun {
    public GeneralFun() {
    }

    public String reStructStr(String var1) throws Exception {
        return this.reStructStr(var1, "ISO8859-1");
    }

    public String reStructStr(String var1, String var2) throws Exception {
        return new String(var1.getBytes(var2),"utf-8");
    }

    public String getDepNameFromUserid(String var1) {
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select org_name from d_user a,d_org b where a.org_id =b.org_id and a.user_id = \'" + var1 + "\'";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }
    public String getRoleNumber() {
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select count(role_id) from d_role";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }

    public String getRoleName(String var1) {
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select role_name from d_role  where role_id =\'" + var1 + "\'";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }


    public String getManagerNumber() {
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select count(MANAGER_ID) from D_MANAGER";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }

    public String getManagerName(String var1) {
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select manager_name from d_manager  where manager_id =\'" + var1 + "\'";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }

    public String getManagerOrgid(String var1){
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select org_id from d_manager  where manager_id =\'" + var1 + "\'";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }

    public String getManagerPassword(String var1) {
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select manager_pwd from d_manager  where manager_id =\'" + var1 + "\'";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }

    public String getUserNumber() {
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select count(USER_ID) from D_USER";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }

    public String getUserName(String var1) {
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select user_name from d_user  where user_id =\'" + var1 + "\'";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }

    public String getUserPassword(String var1) {
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select password from d_user  where user_id =\'" + var1 + "\'";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }

    public String getDepNameFromDepid(String var1) {
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select org_name from d_org  where org_id =\'" + var1 + "\'";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }

    public String getUpDepIdFromDepid(String var1) {
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select up_org_id from d_org  where org_id =\'" + var1 + "\'";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }

    public String getUpModuleIdFromModule(String var1) {
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select up_module_id from d_module  where module_id =\'" + var1 + "\'";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }

    public String getModuleNameFromModuleId(String var1) {
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select module_name from d_module  where module_id =\'" + var1 + "\'";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }

    public String getUpFunctionIdFromFunction(String var1) {
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select module_id from d_function  where function_id =\'" + var1 + "\'";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }

    public String getFunctionNameFromFunctionid(String var1){
        exeQueryResult var2 = new exeQueryResult();
        String var3 = "select function_name from d_function  where function_id =\'" + var1 + "\'";
        String[][] var4 = var2.getSelectResultWithStringArray(var3);
        return var4 != null?var4[0][0]:null;
    }

    public int getSeq(String var1) throws Exception {
        String[] var2 = new String[]{"select seq from d_seq where table_name=\'" + var1 + "\'", "update d_seq set seq=seq+1 where table_name=\'" + var1 + "\'"};
        exeQueryResult var3 = new exeQueryResult();
        String[][] var4 = var3.getSelectResultWithStringArray(var2[0]);
        exelnsertUpdateDelete var5 = new exelnsertUpdateDelete();
        var5.execSql(var2[1]);
        return var4 != null?Integer.parseInt(var4[0][0]) + 1:-1;
    }
}
