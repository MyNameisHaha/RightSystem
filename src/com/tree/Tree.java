package com.tree;

/**
 * Created by Xirui on 2015/11/1.
 */

import com.ins.exeQueryResult;
import java.util.Vector;

public class Tree {
    private static int rootNextId = -100;
    private static int offsetId = 0;
    private boolean isRightTree = false;
    protected String nodeTableSql;
    protected String leafTableSql;
    protected String nodeDefaultUrl = "";
    protected String leafDefaultUrl = "";
    protected int nodeIndex;
    protected int upNodeIndex;
    protected int nodeNameIndex;
    protected int nodeUrlIndex = -1;
    protected int nodeOrder;
    protected int nodeTargetIndex;
    protected int nodeRightControlMarkIndex;
    protected int leafIndex;
    protected int parentNodeIndex;
    protected int leafNameIndex;
    protected int leafUrlIndex = -1;
    protected int leafOrder;
    protected int leafTargetIndex;
    protected int leafRightControlMarkIndex;
    protected String roleRightSql;
    protected String leafRightSql;
    protected String nodeRightSql;
    protected int nodeConstrictIndex;
    protected int leafConstrictIndex;
    protected int roleConstrictIndex;
    public TreeObject[] treeObjectArrayReconstruct;
    private TreeObject[] treeObjectArray;
    protected int nodeLen = 0;
    protected int leafLen = 0;
    protected int treeDepth = 0;
    boolean AllRight = false;
    public String leafImage = "treeImage/img-page.gif";
    public String nodeOpenImage = "treeImage/img-folder-open.gif";
    public String nodeCloseImage = "treeImage/img-folder.gif";
    public String midPlusImage = "treeImage/img-plus-end.gif";
    public String midMinusImage = "treeImage/img-minus-end.gif";
    private StringBuffer buf;
    private final String CR = " \n ";

    public Tree() {
    }

    public static int getNextInt() {
        --rootNextId;
        return rootNextId;
    }

    private static TreeObject makeSpecialNode(String var0, String var1, String var2) {
        TreeObject var3 = new TreeObject();
        var3.type = 1;
        var3.id = getNextInt();
        var3.upid = -1;
        var3.name = var0;
        var3.url = var1;
        var3.target = var2;
        var3.isRight = true;
        return var3;
    }

    public boolean addRootToCurrentTree(String var1, String var2, String var3) {
        return this.addRootToCurrentTree(makeSpecialNode(var1, var2, var3));
    }

    private boolean hasCondition() {
        return this.nodeIndex > -1 && this.upNodeIndex > -1 && this.nodeNameIndex > -1 && this.nodeOrder > -1 && this.leafIndex > -1 && this.parentNodeIndex > -1 && this.leafNameIndex > -1 && this.leafOrder > -1;
    }

    private boolean addRootToCurrentTree(TreeObject var1) {
        if(var1 == null) {
            return false;
        } else if(this.treeObjectArrayReconstruct != null && this.treeObjectArrayReconstruct.length != 0) {
            TreeObject var2 = this.treeObjectArrayReconstruct[0];
            var1.addChild(var2);
            var2.parentNode = var1;
            TreeObject[] var3 = new TreeObject[this.treeObjectArrayReconstruct.length + 1];
            var3[0] = var1;

            for(int var4 = 0; var4 < this.treeObjectArrayReconstruct.length; ++var4) {
                var3[var4 + 1] = this.treeObjectArrayReconstruct[var4];
            }

            this.treeObjectArrayReconstruct = var3;
            var3 = null;
            return true;
        } else {
            this.treeObjectArrayReconstruct = new TreeObject[1];
            this.treeObjectArrayReconstruct[0] = var1;
            return true;
        }
    }

    public boolean addSubRootToCurrentTree(TreeObject[] var1, int var2) {
        if(var1 != null && var1.length != 0 && var2 >= 0 && var2 < var1.length) {
            if(this.treeObjectArrayReconstruct != null && this.treeObjectArrayReconstruct.length != 0) {
                TreeObject var3 = this.treeObjectArrayReconstruct[0];
                TreeObject var4 = var1[var2];
                var3.addChild(var4);
                var4.parentNode = var3;
                TreeObject[] var5 = new TreeObject[this.treeObjectArrayReconstruct.length + var1.length - var2];

                int var6;
                for(var6 = 0; var6 < this.treeObjectArrayReconstruct.length; ++var6) {
                    var5[var6] = this.treeObjectArrayReconstruct[var6];
                }

                for(var6 = this.treeObjectArrayReconstruct.length; var6 < this.treeObjectArrayReconstruct.length + var1.length - var2; ++var6) {
                    var5[var6] = var1[var6 - this.treeObjectArrayReconstruct.length + var2];
                }

                this.treeObjectArrayReconstruct = var5;
                var5 = null;
                return true;
            } else {
                this.treeObjectArrayReconstruct = var1;
                return true;
            }
        } else {
            return false;
        }
    }

    public void makeTree() {
        this.makeTree("");
    }

    private String dealEmptyStr(String var1) {
        if(var1.equals("")) {
            var1 = "0";
        }

        return var1;
    }

    public void makeTree(String var1) {
        System.out.println("1:hasCondition()" + this.hasCondition());
        if(this.hasCondition()) {
            System.out.println("2:hasCondition()" + this.hasCondition());

            try {
                exeQueryResult var3 = new exeQueryResult();
                System.out.println("------------------------------------------------------0");
                String[][] var4 = var3.getSelectResultWithStringArray(this.nodeTableSql);
                String[][] var5 = (String[][])null;
                if(this.leafTableSql != null) {
                    System.out.println("-----" + this.leafTableSql);
                    var5 = var3.getSelectResultWithStringArray(this.leafTableSql);
                    if(var5 != null) {
                        this.leafLen = var5.length;
                    }

                    System.out.println("leafLen" + var5[0].length);
                }

                if(var4 == null) {
                    return;
                }

                if(var4.length == 0) {
                    return;
                }

                this.nodeLen = var4.length;
                this.treeObjectArray = new TreeObject[this.nodeLen + this.leafLen];

                TreeObject var2;
                int var6;
                for(var6 = 0; var6 < var4.length; ++var6) {
                    try {
                        var2 = new TreeObject();
                        var2.type = 1;
                        var2.id = Integer.parseInt(this.dealEmptyStr(var4[var6][this.nodeIndex])) + offsetId;
                        if(var6 > 0) {
                            var2.upid = Integer.parseInt(this.dealEmptyStr(var4[var6][this.upNodeIndex])) + offsetId;
                        } else {
                            var2.upid = -1 + offsetId;
                        }

                        var2.name = var4[var6][this.nodeNameIndex].trim();
                        if(!var4[var6][this.nodeOrder].equals("")) {
                            var2.rank_order = Integer.parseInt(this.dealEmptyStr(var4[var6][this.nodeOrder]));
                        } else {
                            var2.rank_order = 0;
                        }

                        var2.url = this.nodeUrlIndex > -1?var4[var6][this.nodeUrlIndex]:this.nodeDefaultUrl;
                        var2.url = var2.url.trim();
                        var2.target = this.nodeTargetIndex > -1?var4[var6][this.nodeTargetIndex]:"";
                        var2.target = var2.target.trim();
                        if(this.nodeRightControlMarkIndex > -1 && this.dealEmptyStr(var4[var6][this.nodeRightControlMarkIndex]).equals("0")) {
                            var2.isRight = true;
                        }

                        if(this.AllRight) {
                            var2.isRight = true;
                        }

                        this.treeObjectArray[var6] = var2;
                    } catch (Exception var9) {
                        var9.printStackTrace();
                    }
                }

                int var7;
                for(var6 = 1; var6 < this.nodeLen; ++var6) {
                    var2 = this.treeObjectArray[var6];

                    for(var7 = 0; var7 < this.nodeLen; ++var7) {
                        if(var2.upid == this.treeObjectArray[var7].id) {
                            this.treeObjectArray[var7].addChild(var2);
                            var2.parentNode = this.treeObjectArray[var7];
                            break;
                        }
                    }
                }

                if(var5 != null) {
                    for(var6 = this.nodeLen; var6 < this.treeObjectArray.length; ++var6) {
                        try {
                            var2 = new TreeObject();
                            var2.type = 2;
                            var2.id = Integer.parseInt(this.dealEmptyStr(var5[var6 - this.nodeLen][this.leafIndex])) + offsetId;
                            var2.upid = Integer.parseInt(this.dealEmptyStr(var5[var6 - this.nodeLen][this.parentNodeIndex])) + offsetId;
                            var2.name = var5[var6 - this.nodeLen][this.leafNameIndex].trim();
                            if(!var5[var6 - this.nodeLen][this.leafOrder].equals("")) {
                                var2.rank_order = Integer.parseInt(this.dealEmptyStr(var5[var6 - this.nodeLen][this.leafOrder]));
                            } else {
                                var2.rank_order = 0;
                            }

                            var2.url = this.leafUrlIndex > -1?var5[var6 - this.nodeLen][this.leafUrlIndex]:this.leafDefaultUrl;
                            var2.url = var2.url.trim();
                            var2.target = this.leafTargetIndex > -1?var5[var6 - this.nodeLen][this.leafTargetIndex]:"";
                            var2.target = var2.target.trim();
                            if(this.leafRightControlMarkIndex > -1 && this.dealEmptyStr(var5[var6 - this.nodeLen][this.leafRightControlMarkIndex]).equals("0")) {
                                var2.isRight = true;
                            }

                            if(this.AllRight) {
                                var2.isRight = true;
                            }

                            this.treeObjectArray[var6] = var2;
                        } catch (Exception var8) {
                            var8.printStackTrace();
                        }
                    }

                    for(var6 = this.nodeLen; var6 < this.treeObjectArray.length; ++var6) {
                        var2 = this.treeObjectArray[var6];

                        for(var7 = 0; var7 < this.nodeLen; ++var7) {
                            if(var2.upid == this.treeObjectArray[var7].id) {
                                this.treeObjectArray[var7].addChild(var2);
                                var2.parentNode = this.treeObjectArray[var7];
                                break;
                            }
                        }
                    }
                }

                if(this.isRightTree) {
                    for(var6 = 0; var6 < this.treeObjectArray.length; ++var6) {
                        if(this.treeObjectArray[var6].type == 1 && this.treeObjectArray[var6].isRight) {
                            this.markParentRight(this.treeObjectArray[var6]);
                            this.markSonRight(this.treeObjectArray[var6]);
                        } else if(this.treeObjectArray[var6].type == 2 && this.treeObjectArray[var6].isRight) {
                            this.markParentRight(this.treeObjectArray[var6]);
                        }
                    }

                    if(this.nodeRightSql != null) {
                        this.assignNodeRight(offsetId);
                    }

                    if(this.leafRightSql != null) {
                        this.assignLeafRight(offsetId);
                    }

                    if(this.roleRightSql != null) {
                        this.assignRoleRight(offsetId);
                    }
                } else {
                    this.markSonRight(this.treeObjectArray[0]);
                }

                this.sort(this.getRoot(true));
                if(var1.equals("")) {
                    this.addSubRootToCurrentTree(this.treeObjectArray, 0);
                } else {
                    TreeObject var11 = this.getByName(var1, true);
                    if(var11 == null) {
                        var7 = 0;
                    } else {
                        var7 = this.findIndex(var11, true);
                    }

                    this.addSubRootToCurrentTree(this.treeObjectArray, var7);
                }

                for(var6 = 0; var6 < this.treeObjectArray.length; ++var6) {
                    if(this.treeObjectArray[var6].getChildSize() == 0) {
                        this.treeObjectArray[var6].type = 2;
                    }
                }

                this.tranversTree(this.treeObjectArray[0]);
                this.nodeIndex = -1;
                this.upNodeIndex = -1;
                this.nodeNameIndex = -1;
                this.nodeOrder = -1;
                this.nodeUrlIndex = -1;
                this.nodeDefaultUrl = "";
                this.nodeTargetIndex = -1;
                this.nodeRightControlMarkIndex = -1;
                this.leafIndex = -1;
                this.parentNodeIndex = -1;
                this.leafNameIndex = -1;
                this.leafOrder = -1;
                this.leafDefaultUrl = "";
                this.leafTargetIndex = -1;
                this.leafRightControlMarkIndex = -1;
                this.isRightTree = false;
            } catch (Exception var10) {
                var10.printStackTrace();
            }

        }
    }

    private void tranversTree(TreeObject var1) {
        ++offsetId;
        if(var1.getChildSize() > 0) {
            TreeObject[] var2 = var1.getChild();

            for(int var3 = 0; var3 < var2.length; ++var3) {
                this.tranversTree(var2[var3]);
            }
        }

    }

    private void assignRoleRight(int var1) {
        exeQueryResult var2 = new exeQueryResult();
        String[][] var3 = var2.getSelectResultWithStringArray(this.roleRightSql);
        if(var3 != null && this.nodeLen != 0) {
            String var5 = this.nodeRightSql;
            String var6 = this.leafRightSql;

            for(int var8 = 0; var8 < var3.length; ++var8) {
                String var4 = var3[var8][this.roleConstrictIndex];
                if(!var4.equals("")) {
                    this.nodeRightSql = "select module_id from D_R_ROLE_MODULE where role_id=\' " + var4 + "\'";
                    this.nodeConstrictIndex = 0;
                    this.assignNodeRight(var1);
                    this.leafRightSql = "select function_id from D_R_ROLE_FUN where role_id=\' " + var4 + "\'";
                    this.leafConstrictIndex = 0;
                    this.assignLeafRight(var1);
                }
            }

            this.nodeRightSql = var5;
            this.leafRightSql = var6;
        }
    }

    private void assignNodeRight(int var1) {
        exeQueryResult var2 = new exeQueryResult();
        String[][] var3 = var2.getSelectResultWithStringArray(this.nodeRightSql);
        if(var3 != null && this.nodeLen != 0) {
            for(int var6 = 0; var6 < var3.length; ++var6) {
                String var4 = var3[var6][this.nodeConstrictIndex];
                if(!var4.equals("")) {
                    try {
                        int var5 = Integer.parseInt(this.dealEmptyStr(var4)) + var1;

                        for(int var7 = 0; var7 < this.nodeLen; ++var7) {
                            if(var5 == this.treeObjectArray[var7].id) {
                                this.markParentRight(this.treeObjectArray[var7]);
                                this.markSonRight(this.treeObjectArray[var7]);
                            }
                        }
                    } catch (Exception var8) {
                        ;
                    }
                }
            }

        }
    }

    private void assignLeafRight(int var1) {
        exeQueryResult var2 = new exeQueryResult();
        String[][] var3 = var2.getSelectResultWithStringArray(this.leafRightSql);
        if(var3 != null && this.leafLen != 0) {
            for(int var6 = 0; var6 < var3.length; ++var6) {
                String var4 = var3[var6][this.leafConstrictIndex];
                if(!var4.equals("")) {
                    try {
                        int var5 = Integer.parseInt(this.dealEmptyStr(var4)) + var1;

                        for(int var7 = this.nodeLen; var7 < this.treeObjectArray.length; ++var7) {
                            if(var5 == this.treeObjectArray[var7].id) {
                                this.markParentRight(this.treeObjectArray[var7]);
                            }
                        }
                    } catch (Exception var8) {
                        ;
                    }
                }
            }

        }
    }

    private void markParentRight(TreeObject var1) {
        if(!var1.isRight) {
            var1.isRight = true;
        }

        if(var1.parentNode != null) {
            this.markParentRight(var1.parentNode);
        }

    }

    private void markSonRight(TreeObject var1) {
        var1.isRight = true;
        if(var1.getChildSize() > 0) {
            TreeObject[] var2 = var1.getChild();

            for(int var3 = 0; var3 < var2.length; ++var3) {
                if(!var2[var3].isRight) {
                    this.markSonRight(var2[var3]);
                }
            }
        }

    }

    private void bubbleSort(Vector var1) {
        boolean var2 = true;

        for(int var3 = var1.size() - 1; var3 > 0 && var2; --var3) {
            var2 = false;

            for(int var5 = 0; var5 < var3; ++var5) {
                TreeObject var6 = (TreeObject)var1.elementAt(var5);
                TreeObject var7 = (TreeObject)var1.elementAt(var5 + 1);
                if(var6.rank_order > var7.rank_order) {
                    var1.setElementAt(var6, var5 + 1);
                    var1.setElementAt(var7, var5);
                    var2 = true;
                }
            }
        }

    }

    private void sort(TreeObject var1) {
        if(var1.getChildSize() > 0) {
            this.bubbleSort(var1.getChildInVector());
            TreeObject[] var2 = var1.getChild();

            for(int var3 = 0; var3 < var2.length; ++var3) {
                this.sort(var2[var3]);
            }
        }

    }

    public void setNodeConditon(String var1, int var2, int var3, int var4, int var5, int var6, String var7, int var8, int var9) {
        this.nodeTableSql = var1;
        this.nodeIndex = var2;
        this.upNodeIndex = var3;
        this.nodeNameIndex = var4;
        this.nodeOrder = var5;
        this.nodeUrlIndex = var6;
        this.nodeDefaultUrl = var7;
        this.nodeTargetIndex = var8;
        this.nodeRightControlMarkIndex = var9;
    }

    public void setLeafCondition(String var1, int var2, int var3, int var4, int var5, int var6, String var7, int var8, int var9) {
        this.leafTableSql = var1;
        this.leafIndex = var2;
        this.parentNodeIndex = var3;
        this.leafNameIndex = var4;
        this.leafOrder = var5;
        this.leafUrlIndex = var6;
        this.leafDefaultUrl = var7;
        this.leafTargetIndex = var8;
        this.leafRightControlMarkIndex = var9;
    }

    public void setNodeRight(String var1, int var2) {
        this.nodeRightSql = var1;
        this.nodeConstrictIndex = var2;
        this.isRightTree = true;
    }

    public void setLeafRight(String var1, int var2) {
        this.leafRightSql = var1;
        this.leafConstrictIndex = var2;
        this.isRightTree = true;
    }

    public void setRoleRight(String var1, int var2) {
        this.roleRightSql = var1;
        this.roleConstrictIndex = var2;
        this.isRightTree = true;
    }

    public void setAllRight(boolean var1) {
        this.AllRight = var1;
    }

    public TreeObject getByIndex(int var1, boolean var2) {
        Object var3 = null;
        TreeObject[] var4;
        if(var2) {
            var4 = this.treeObjectArray;
        } else {
            var4 = this.treeObjectArrayReconstruct;
        }

        return var1 >= 0 && var1 <= var4.length?var4[var1]:null;
    }

    public int findIndex(TreeObject var1, boolean var2) {
        Object var3 = null;
        TreeObject[] var4;
        if(var2) {
            var4 = this.treeObjectArray;
        } else {
            var4 = this.treeObjectArrayReconstruct;
        }

        for(int var5 = 0; var5 < var4.length; ++var5) {
            if(var4[var5] == var1) {
                return var5;
            }
        }

        return -1;
    }

    public TreeObject getById(int var1, boolean var2) {
        TreeObject var3 = null;
        TreeObject[] var4;
        if(var2) {
            var4 = this.treeObjectArray;
        } else {
            var4 = this.treeObjectArrayReconstruct;
        }

        for(int var5 = 0; var5 < var4.length; ++var5) {
            if(var4[var5].id == var1) {
                var3 = var4[var5];
                break;
            }
        }

        return var3;
    }

    public TreeObject getByName(String var1, boolean var2) {
        TreeObject var3 = null;
        TreeObject[] var4;
        if(var2) {
            var4 = this.treeObjectArray;
        } else {
            var4 = this.treeObjectArrayReconstruct;
        }

        for(int var5 = 0; var5 < var4.length; ++var5) {
            if(var4[var5].name.equals(var1)) {
                var3 = var4[var5];
                break;
            }
        }

        return var3;
    }

    public TreeObject getRoot(boolean var1) {
        return var1?(this.treeObjectArray == null?null:this.treeObjectArray[0]):(this.treeObjectArrayReconstruct == null?null:this.treeObjectArrayReconstruct[0]);
    }

    private void searchTreeDepthAndWriteFormatIndent(TreeObject var1, int var2) {
        if(var2 > this.treeDepth) {
            this.buf.append(".Outline" + String.valueOf(var2) + " {");
            this.buf.append("FONT-SIZE: 9pt; MARGIN-LEFT: ");
            this.buf.append(String.valueOf(15 + 14 * this.treeDepth));
            this.buf.append("pt; TEXT-INDENT: -");
            this.buf.append(String.valueOf(28 + 14 * this.treeDepth));
            this.buf.append("pt; LINE-HEIGHT: 15pt; FONT-FAMILY: \"宋体\"; TEXT-DECORATION: none} \n ");
            this.treeDepth = var2;
        }

        if(var1.getChildSize() > 0) {
            TreeObject[] var3 = var1.getChild();
            ++var2;

            for(int var4 = 0; var4 < var3.length; ++var4) {
                this.searchTreeDepthAndWriteFormatIndent(var3[var4], var2);
            }
        }

    }

    private void makeVisible(TreeObject var1, int var2) {
        ++var2;
        if(var2 < 2) {
            var1.isVisible = true;
        }

        if(var1.getChildSize() > 0) {
            TreeObject[] var3 = var1.getChild();
            ++var2;

            for(int var4 = 0; var4 < var3.length; ++var4) {
                this.makeVisible(var3[var4], var2);
            }
        }

    }

    public String beginTrack(TreeObject var1) {
        if(var1 == null) {
            return null;
        } else {
            this.buf = new StringBuffer();
            this.buf.append("<STYLE type=text/css> \n ");
            this.treeDepth = 0;
            this.searchTreeDepthAndWriteFormatIndent(var1, 1);
            this.buf.append("</STYLE> \n ");
            this.buf.append("<SCRIPT language=JavaScript> \n <!-- \n function clickHandler() \n {var targetId; \n ");
            this.buf.append("var srcElement = window.event.srcElement; \n var targetElement; \n ");
            this.buf.append("if (srcElement.className.substr(0,7) == \"Outline\") \n {if(srcElement.id.substr(0,4)!=\'Leaf\'&& srcElement.id.indexOf(\"Image\")>=0){ \n ");
            this.buf.append("targetId = srcElement.id.substr(0,srcElement.id.indexOf(\'Image\')) + \"Details\"; \n ");
            this.buf.append("targetElement = document.all(targetId); \n if (targetElement.style.display == \"none\") { \n ");
            this.buf.append("targetElement.style.display = \"\"; \n } \n else { \n targetElement.style.display = \"none\"; \n } \n ");
            this.buf.append("targetId = srcElement.id.substr(0,srcElement.id.indexOf(\'Image\')) + \"Image\"; \n targetElement = document.all(targetId); \n ");
            this.buf.append("if (targetElement.src.indexOf(\'" + this.midPlusImage + "\') >= 0) {" + " \n " + "targetElement.src = \'" + this.midMinusImage + "\';" + " \n " + "}" + " \n " + "else {" + " \n ");
            this.buf.append("targetElement.src = \'" + this.midPlusImage + "\';" + " \n " + "}" + " \n ");
            this.buf.append("targetId = srcElement.id.substr(0,srcElement.id.indexOf(\'Image\')) + \"Image1\"; \n ");
            this.buf.append("targetElement = document.all(targetId); \n ");
            this.buf.append("if (targetElement.src.indexOf(\'" + this.nodeOpenImage + "\') >= 0) { " + " \n ");
            this.buf.append("targetElement.src = \'" + this.nodeCloseImage + "\'; } " + " \n ");
            this.buf.append("else { targetElement.src = \'" + this.nodeOpenImage + "\'; } " + " \n ");
            this.buf.append("} \n } \n } \n document.onclick = clickHandler; \n //-->  \n </SCRIPT> \n ");
            this.makeVisible(var1, 0);
            this.rightChect(var1, 0);
            return this.buf.toString();
        }
    }

    private void rightChect(TreeObject var1, int var2) {
        if(var1.isRight) {
            this.dispalyTree(var1, var2);
        }

    }

    private void dispalyTree(TreeObject var1, int var2) {
        ++var2;
        if(var1.type == 1) {
            this.buf.append("<DIV class=Outline" + var2 + " id=Node" + var1.id + " onmouseover=\"this.style.color=\'red\';this.style.cursor=\'hand\'\" onmouseout=\"this.style.color=\'black\'\">" + " \n ");
            if(var1.isVisible) {
                this.buf.append("<IMG class=Outline" + var2 + " id=Node" + var1.id + "Image style=\"CURSOR: hand\" src=\"" + this.midMinusImage + "\" width=\"12\" height=\"12\">" + " \n ");
                this.buf.append("<IMG id=Node" + var1.id + "Image1 style=\"CURSOR: hand\" src=\"" + this.nodeOpenImage + "\" width=\"12\" height=\"12\">" + " \n ");
                this.linkPre(var1.url, var1.target);
                this.buf.append(var1.name);
                this.linkSuf(var1.url);
                this.buf.append(" \n </DIV> \n ");
                this.buf.append("<DIV id=Node" + var1.id + "Details style=\"DISPLAY: \">" + " \n ");
            } else {
                this.buf.append("<IMG class=Outline" + var2 + " id=Node" + var1.id + "Image style=\"CURSOR: hand\" src=\"" + this.midPlusImage + "\" width=\"12\" height=\"12\">" + " \n ");
                this.buf.append("<IMG id=Node" + var1.id + "Image1 style=\"CURSOR: hand\" src=\"" + this.nodeCloseImage + "\" width=\"12\" height=\"12\">" + " \n ");
                this.linkPre(var1.url, var1.target);
                this.buf.append(var1.name);
                this.linkSuf(var1.url);
                this.buf.append(" \n </DIV> \n ");
                this.buf.append("<DIV id=Node" + var1.id + "Details style=\"DISPLAY: none\">" + " \n ");
            }

            if(var1.getChildSize() > 0) {
                TreeObject[] var3 = var1.getChild();

                for(int var4 = 0; var4 < var3.length; ++var4) {
                    this.rightChect(var3[var4], var2);
                }
            }

            this.buf.append("</DIV> \n ");
        } else if(var1.type == 2) {
            this.buf.append("<DIV class=Outline" + var2 + " onmouseover=\"this.style.color=\'red\';this.style.cursor=\'hand\'\"  onmouseout=\"this.style.color=\'black\'\">" + " \n ");
            this.buf.append("<IMG class=Outline" + var2 + " id=Leaf" + var1.id + " src=\"" + this.leafImage + "\" width=\"12\" height=\"14\">" + " \n ");
            this.linkPre(var1.url, var1.target);
            this.buf.append(var1.name);
            this.linkSuf(var1.url);
            this.buf.append("</DIV> \n ");
        }

    }

    private void linkPre(String var1, String var2) {
        if(var1 != null) {
            if(!var1.equals("")) {
                this.buf.append("<a href=" + var1 + " ");
                if(var2 != null && !var2.equals("")) {
                    this.buf.append("target=" + var2);
                }

                this.buf.append("> ");
            }

        }
    }

    private void linkSuf(String var1) {
        if(var1 != null) {
            if(!var1.equals("")) {
                this.buf.append("</A> \n ");
            }

        }
    }

    public void repaire_for_comuser(String var1) {
        String var2 = "select module_id,up_module_id,module_name,module_order,MODULE_CONTROL from d_module order by module_id ";
        this.setNodeConditon(var2, 0, 1, 2, 3, -1, "", -1, 4);
        var2 = "select function_id,module_id,function_name,function_order,function_url,function_target,FUNCTION_CONTROL from d_function";
        this.setLeafCondition(var2, 0, 1, 2, 3, 4, "", 5, 6);
        var2 = "select module_id from D_R_USERMODULE where user_id=\'" + var1 + "\'";
        this.setNodeRight(var2, 0);
        var2 = "select function_id from D_R_USERFUN where user_id=\'" + var1 + "\'";
        this.setLeafRight(var2, 0);
        var2 = "select role_id from d_user_role where user_id=\'" + var1 + "\'";
        this.setRoleRight(var2, 0);
        this.setAllRight(false);
        this.makeTree();
    }

    public void repaire_for_manager(String var1, String var2) {
        String var3 = "select module_id,up_module_id,module_name,module_order,\'./Module/module.jsp?moduleId=\'+convert(char,module_id),\'rhs\' from d_module where MODULE_CONTROL =\'1\' order by module_id ";
        this.setNodeConditon(var3, 0, 1, 2, 3, 4, "", 5, -1);
        var3 = "select function_id,module_id,function_name,function_order,\'./Function/function.jsp?functionId=\'+convert(char,function_id),\'rhs\' from d_function  where FUNCTION_CONTROL =\'1\' order by function_id";
        this.setLeafCondition(var3, 0, 1, 2, 3, 4, "", 5, -1);
        var3 = "select module_id from D_R_MODULE_MANAGER where MANAGER_ID=\'" + var1 + "\'";
        this.setNodeRight(var3, 0);
        var3 = "select function_id from D_R_FUN_MANAGER where MANAGER_ID=\'" + var1 + "\'";
        this.setLeafRight(var3, 0);
        this.setAllRight(true);
        this.makeTree();
        this.addRootToCurrentTree("系统管理", "http", "url");
        var3 = "select ORG_ID,UP_ORG_ID,ORG_NAME,ORG_ORDER,\'./Dep/dep.jsp?depid=\'+convert(char,org_id),\'rhs\' from d_org order by org_id ";
        this.setNodeConditon(var3, 0, 1, 2, 3, 4, "", 5, -1);
        var3 = "select role_ID,ORG_ID,role_NAME,role_ORDER,\'Role/role.jsp?roleId=\'+convert(char,role_id),\'rhs\' from D_role union select MANAGER_ID,ORG_ID,MANAGER_NAME,MANAGER_ORDER,\'Manager/manager.jsp?managerId=\'+convert(char,manager_id),\'rhs\' from D_MANAGER union select USER_ID,ORG_ID,USER_NAME,USER_ORDER,\'User/user.jsp?userId=\'+convert(char,user_id),\'rhs\' from D_USER ";
        this.setLeafCondition(var3, 0, 1, 2, 3, 4, "", 5, -1);
        this.makeTree(var2);
    }
}
