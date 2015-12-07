

/**
 * Created by Xirui on 2015/11/1.
 */
//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.tree;

import java.util.Vector;

public class TreeObject {
    public boolean isRight = false;
    public boolean isVisible = false;
    public int type;
    public int id;
    public int upid;
    public int rank_order;
    public String name = "";
    public String url = "";
    public String target = "";
    public TreeObject parentNode = null;
    protected Vector vc;
    public static final int NODE = 1;
    public static final int LEAF = 2;

    public TreeObject() {
    }

    public void addChild(TreeObject var1) {
        if(this.vc == null) {
            this.vc = new Vector();
        }

        this.vc.addElement(var1);
    }

    public int getChildSize() {
        return this.vc == null?0:this.vc.size();
    }

    public TreeObject[] getChild() {
        if(this.vc == null) {
            return null;
        } else {
            Object[] var1 = this.vc.toArray();
            TreeObject[] var2 = new TreeObject[var1.length];

            for(int var3 = 0; var3 < var1.length; ++var3) {
                var2[var3] = (TreeObject)var1[var3];
            }

            return var2;
        }
    }

    public Vector getChildInVector() {
        return this.vc;
    }
}
