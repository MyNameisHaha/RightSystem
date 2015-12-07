package com.ins;

/**
 * Created by Xirui on 2015/11/1.
 */

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;

public class exeQueryResult {
    public exeQueryResult() {
    }

    public String[][] getSelectResultWithStringArray(String var1) {
        try {
            Object[][] var2 = this.getSelectResultWithObjectArray(var1);
            if(var2 == null) {
                return (String[][])null;
            } else {
                String[][] var3 = new String[var2.length][var2[0].length];

                for(int var4 = 0; var4 < var2.length; ++var4) {
                    for(int var5 = 0; var5 < var2[0].length; ++var5) {
                        if(var2[var4][var5] != null) {
                            var3[var4][var5] = var2[var4][var5].toString().trim();
                        } else {
                            var3[var4][var5] = "";
                        }
                    }
                }

                return var3;
            }
        } catch (Exception var6) {
            var6.printStackTrace();
            return (String[][])null;
        }
    }

    private Object[][] getSelectResultWithObjectArray(String var1) {
        Connection con = Fun.getConn();
        if(con == null) {
            return (Object[][])null;
        } else {
            Statement s = null;
            ResultSet rs = null;

            try {
                s = con.createStatement(1004, 1007);
                rs = s.executeQuery(var1);
                if(rs == null) {
                    System.out.println(var1 + ": 没有取回相应的结果集.");
                    Object[][] var29 = (Object[][])null;
                    return var29;
                } else {
                    ResultAttribute var5 = new ResultAttribute(var1);
                    var5.makeSqlResult();
                    ResultSetMetaData var30 = rs.getMetaData();
                    int var7 = var5.getArrayLen();
                    boolean var8 = false;
                    rs.last();
                    int var31 = rs.getRow();
                    rs.first();
                    if(var31 == 0 || var7 == 0) {
                        Object[][] var32 = (Object[][])null;
                        return var32;
                    } else {
                        Object[][] var10 = new Object[var31][var7];

                        for(int var12 = 0; var12 < var31; ++var12) {
                            for(int var13 = 0; var13 < var7; ++var13) {
                                Object var9 = rs.getObject(var13 + 1);
                                int var11 = var5.getIndexType(var13);
                                switch(var11) {
                                    case 91:
                                        Date var14 = (Date)var9;
                                        if(var14 != null) {
                                            var10[var12][var13] = var14.toString();
                                        }
                                        break;
                                    case 92:
                                        Time var15 = (Time)var9;
                                        if(var15 != null) {
                                            var10[var12][var13] = var15.toString();
                                        }
                                        break;
                                    case 93:
                                        Timestamp var16 = (Timestamp)var9;
                                        if(var16 != null) {
                                            var10[var12][var13] = var16.toString();
                                        }
                                        break;
                                    default:
                                        var10[var12][var13] = var9;
                                }
                            }

                            rs.next();
                        }

                        rs.close();
                        rs = null;
                        Object[][] var33 = var10;
                        return var33;
                    }
                }
            } catch (Exception var27) {
                System.out.println("-------------------");
                System.out.println("出现错误：" + var1);
                System.out.println("-------------------");
                var27.printStackTrace();
                Object[][] var6 = (Object[][])null;
                return var6;
            } finally {
                try {
                    rs.close();
                    s.close();
                    con.close();
                    con = null;
                } catch (Exception var26) {
                    ;
                }

            }
        }
    }
}