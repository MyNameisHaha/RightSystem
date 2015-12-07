package com.bean;

/**
 * Created by Xirui on 2015/11/1.
 */
import com.ins.exeQueryResult;

public class LoginBean {
    public LoginBean() {
    }

    public String[] authenticate(String var1, String var2) {
        String var3 = "";
        boolean var4 = true;
        if(var1.startsWith("_")) {
            var3 = "select MANAGER_ID,ORG_ID,MANAGER_NAME,MANAGER_PWD,MANAGER_CONTROL from d_manager where MANAGER_LOGIN=\'" + var1 + "\'";
            var4 = false;
        } else {
            var3 = "select USER_ID,ORG_ID,USER_NAME,PASSWORD,USER_CONTROL from D_USER where LOGIN_USER=\'" + var1 + "\'";
        }

        return this.exeSql(var3, var2, var4);
    }

    private boolean verifyPwd(String var1, String var2) {
        var1 = var1.toLowerCase().trim();
        var2 = var2.toLowerCase().trim();
        return var1.equals(var2);
    }

    private String[] exeSql(String var1, String var2, boolean var3) {
        String[] var4 = new String[7];
        exeQueryResult var6 = new exeQueryResult();
        String[][] var5 = var6.getSelectResultWithStringArray(var1);
        if(var5 != null && var5.length != 0) {
            var4[0] = "1";
            if(this.verifyPwd(var2, var5[0][3])) {
                var4[1] = "1";
                if(var3) {
                    var4[2] = "0";
                } else {
                    var4[2] = "1";
                }

                var4[3] = var5[0][0];
                var4[4] = var5[0][2];
                var4[5] = var5[0][1];
                var4[6] = var5[0][4];
            } else {
                var4[1] = "0";
            }
        } else {
            var4[0] = "0";
        }

        return var4;
    }
}
