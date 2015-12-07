package com.ins;

/**
 * Created by Xirui on 2015/11/1.
 */
//import com.ins.Fun;
//import com.ins.ResultAttribute;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.Hashtable;

public class exelnsertUpdateDelete {
    public static final int INSERT = 1;
    public static final int UPDATE = 2;
    public static final int DELETE = 3;
    public static String keyMark = "$";
    public static String nonKeyMark = "_";

    public exelnsertUpdateDelete() {
    }

    private void handleHashtable(String var1, Hashtable var2) {
        ResultAttribute var3 = new ResultAttribute();
        var3.constructSql(var1, var2, keyMark, nonKeyMark);
        var3.makeSqlResult();
        Enumeration var4 = var2.keys();
        int var8 = var3.getArrayLen();

        for(int var9 = 0; var9 < var8; ++var9) {
            int var7 = var3.getIndexType(var9);
            String var5 = (String)var4.nextElement();
            String var6;
            if(var7 != 1 && var7 != 12) {
                var6 = (String)var2.get(var5);
                if(var6.equals("")) {
                    var6 = "NULL";
                }

                var2.put(var5, var6);
            } else {
                var6 = (String)var2.get(var5);
                var6 = "\'" + var6 + "\'";
                var2.put(var5, var6);
            }
        }

    }

    public boolean execSql(String var1, int var2, Hashtable var3) {
        return this.execSql(var1, var2, var3, false);
    }

    public boolean execSql(String var1, int var2, Hashtable var3, boolean var4) {
        if(var3.isEmpty()) {
            return false;
        } else {
            this.handleHashtable(var1, var3);
            switch(var2) {
                case 1:
                    return this.execSqlInsert(var1, var3, var4);
                case 2:
                    return this.execSqlUpdate(var1, var3, var4);
                case 3:
                    return this.execSqlDelete(var1, var3, var4);
                default:
                    return false;
            }
        }
    }

    private boolean execSqlInsert(String var1, Hashtable var2, boolean var3) {
        int var5 = 0;
        String var8 = "insert into " + var1 + "(";
        String var9 = " values(";
        Enumeration var4 = var2.keys();
        int var6 = keyMark.length();
        int var7 = nonKeyMark.length();

        while(var4.hasMoreElements()) {
            String var10 = (String)var4.nextElement();
            String var11 = (String)var2.get(var10);
            if(var10.startsWith(keyMark)) {
                var10 = var10.substring(var6);
                if(var5 == 0) {
                    var8 = var8 + var10;
                    var9 = var9 + var11;
                } else {
                    var8 = var8 + "," + var10;
                    var9 = var9 + "," + var11;
                }

                ++var5;
            } else if(var10.startsWith(nonKeyMark)) {
                var10 = var10.substring(var7);
                if(var5 == 0) {
                    var8 = var8 + var10;
                    var9 = var9 + var11;
                } else {
                    var8 = var8 + "," + var10;
                    var9 = var9 + "," + var11;
                }

                ++var5;
            }
        }

        var8 = var8 + ") ";
        var9 = var9 + ") ";
        return this.execSql((String)(var8 + var9), var3);
    }

    private boolean execSqlUpdate(String var1, Hashtable var2, boolean var3) {
        int var5 = 0;
        int var6 = 0;
        String var9 = "update " + var1 + " set ";
        String var10 = " where ";
        Enumeration var4 = var2.keys();//创建枚举取出Hashtable中的值
        int var7 = keyMark.length();
        int var8 = nonKeyMark.length();

        while(var4.hasMoreElements()) {               //hasMoreElement（）方法判断枚举中是否存在值
            String var11 = (String)var4.nextElement();   //得到表单提交中 name属性的值
            String var12 = (String)var2.get(var11);     //得到对应name表单的value值
            if(var11.startsWith(nonKeyMark)) {
                var11 = var11.substring(var8);
                if(var5 == 0) {
                    var9 = var9 + var11 + "=" + var12;
                } else {
                    var9 = var9 + "," + var11 + "=" + var12;
                }

                ++var5;
            } else if(var11.startsWith(keyMark)) {
                var11 = var11.substring(var7);
                if(var6 == 0) {
                    var10 = var10 + var11 + "=" + var12;
                } else {
                    var10 = var10 + " and " + var11 + "=" + var12;
                }

                ++var6;
            }
        }

        return this.execSql((String)(var9 + var10), var3);
    }

    private boolean execSqlDelete(String var1, Hashtable var2, boolean var3) {
        int var5 = 0;
        String var8 = "delete from  " + var1 + " ";
        String var9 = " where ";
        Enumeration var4 = var2.keys();
        int var6 = keyMark.length();
        int var7 = nonKeyMark.length();

        while(var4.hasMoreElements()) {
            String var10 = (String)var4.nextElement();
            String var11 = (String)var2.get(var10);
            if(var10.startsWith(keyMark)) {
                var10 = var10.substring(var6);
                if(var5 == 0) {
                    var9 = var9 + var10 + "=" + var11;
                } else {
                    var9 = var9 + " and " + var10 + "=" + var11;
                }

                ++var5;
            }
        }

        return this.execSql((String)(var8 + var9), var3);
    }

    public boolean execSql(String var1) {
        return this.execSql((String)var1, false);
    }

    public boolean execSql(String var1, boolean var2) {
        String[] var3 = new String[]{var1};
        return this.execSql((String[])var3, var2);
    }

    public boolean execSql(String[] var1) {
        return this.execSql((String[])var1, false);
    }

    public boolean execSql(String[] var1, boolean var2) {
        if(var1 == null) {
            return false;
        } else if(var1.length == 0) {
            return false;
        } else {
            Connection var3 = null;
            Statement var4 = null;
            byte var5 = 0;

            boolean var7;
            try {
                var3 = Fun.getConn();
                var4 = var3.createStatement();
                var3.setAutoCommit(false);

                for(int var21 = 0; var21 < var1.length; ++var21) {
                    var4.executeUpdate(var1[var21]);
                    if(var2) {
                        System.out.println(var1[var21]);
                    }
                }

                var3.commit();
                var3.close();
                var3 = null;
                boolean var22 = true;
                return var22;
            } catch (Exception var19) {
                Exception var6 = var19;

                try {
                    var3.rollback();
                    if(var5 < var1.length) {
                        System.out.println("-------------------");
                        System.out.println("出现错误：" + var1[var5]);
                        System.out.println("-------------------");
                        var6.printStackTrace();
                    }
                } catch (SQLException var18) {
                    ;
                }

                var7 = false;
            } finally {
                try {
                    var4.close();
                    var3.close();
                    var3 = null;
                } catch (Exception var17) {
                    ;
                }

            }

            return var7;
        }
    }
}
