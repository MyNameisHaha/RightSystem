package com.ins;

/**
 * Created by Xirui on 2015/11/1.
 */
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.Hashtable;

public class ResultAttribute {
    private String sql;
    public static final int Oracle = 1;
    public static final int SqlServer = 2;
    public static int databaseType = 0;
    private ColumnAttribute[] col = null;

    public ResultAttribute() {
    }

    public ResultAttribute(String var1) {
        if(var1 != null) {
            if(databaseType == 2) {
                var1.replaceFirst("select", "select top 1 ");
            }

            if(databaseType == 1) {
                var1 = var1 + " where rownum<2  ";
            }
        }

        this.sql = var1;
    }

    private void selectContent(Hashtable var1, String var2, String var3) {
        Enumeration var4 = var1.keys();
        int var5 = 0;
        int var7 = var2.length();

        for(int var8 = var3.length(); var4.hasMoreElements(); ++var5) {
            String var6 = (String)var4.nextElement();
            if(var6.startsWith(var2)) {
                var6 = var6.substring(var7);
            }

            if(var6.startsWith(var3)) {
                var6 = var6.substring(var8);
            }

            if(var5 > 0) {
                this.sql = this.sql + "," + var6;
            } else {
                this.sql = this.sql + " " + var6;
            }
        }

    }

    public void constructSql(String var1, Hashtable var2, String var3, String var4) {
        if(var2 != null) {
            this.sql = "select ";
            if(databaseType == 2) {
                this.sql = this.sql + " top 1 ";
            }

            this.selectContent(var2, var3, var4);
            this.sql = this.sql + "  from " + var1;
            if(databaseType == 1) {
                this.sql = this.sql + " where rownum<2  ";
            }

        }
    }

    public void makeSqlResult() {
        if(!this.sql.equals("")) {
            Connection var1 = Fun.getConn();
            if(var1 != null) {
                Statement var2 = null;
                ResultSet var3 = null;

                try {
                    var2 = var1.createStatement();
                    var3 = var2.executeQuery(this.sql);
                    if(var3 != null) {
                        ResultSetMetaData var4 = var3.getMetaData();
                        int var5 = var4.getColumnCount();
                        if(var5 <= 0) {
                            return;
                        }

                        this.col = new ColumnAttribute[var5];

                        for(int var7 = 0; var7 < var5; ++var7) {
                            ColumnAttribute var6 = new ColumnAttribute();
                            var6.col_name = var4.getColumnName(var7 + 1);
                            var6.dataType = var4.getColumnType(var7 + 1);
                            this.col[var7] = var6;
                            if(var6.dataType == 2004 || var6.dataType == 2005) {
                                System.out.println(this.sql + ": 含有图像结果集.");
                                return;
                            }
                        }

                        return;
                    }

                    System.out.println(this.sql + ": 没有取回相应的结果集.");
                } catch (Exception var20) {
                    var20.printStackTrace();
                    return;
                } finally {
                    try {
                        var3.close();
                        var2.close();
                        var1.close();
                        var1 = null;
                    } catch (Exception var19) {
                        ;
                    }

                }

            }
        }
    }

    public int getIndexType(int var1) {
        return var1 < this.getArrayLen()?this.col[var1].dataType:-1;
    }

    public int getArrayLen() {
        return this.col == null?0:this.col.length;
    }
}
