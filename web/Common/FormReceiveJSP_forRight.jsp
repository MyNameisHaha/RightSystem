<%--
  Created by IntelliJ IDEA.
  User: Xirui
  Date: 2015/11/29
  Time: 17:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page  import="com.ins.*" %>
<jsp:useBean id="GF" scope="session" class="com.bean.GeneralFun" />


<%----------- 处理功能用户授权的信息 -----------%>
<%
  String id = request.getParameter("id");//当前操作对象ID
  String choose =request.getParameter("choose");
  String[] beginRight = (String[])session.getAttribute("beginRight");
  String[] endRight = (String[])request.getParameterValues("right");

  //拼delete语句
  String[] deleteSql;
  if(beginRight==null) deleteSql = new String[0];
  else
  {
    deleteSql = new String[beginRight.length];
    for(int i=0;i<beginRight.length;i++)
    {
        if ("1".equals(choose)) { deleteSql[i] = "delete D_R_USERFUN where user_id="+beginRight[i]+" and function_id="+id;}
        else if ("2".equals(choose)) { deleteSql[i] = "delete D_R_FUN_MANAGER where manager_id="+beginRight[i]+" and function_id="+id;}
        else if ("3".equals(choose)) { deleteSql[i] = "delete D_R_ROLE_FUN where role_id="+beginRight[i]+" and function_id="+id;}
        else if ("4".equals(choose)) { deleteSql[i] = "delete D_R_USERMODULE where user_id="+beginRight[i]+" and module_id="+id;}
        else if ("5".equals(choose)) { deleteSql[i] = "delete D_R_ROLE_MODULE where role_id="+beginRight[i]+" and module_id="+id;}
        else if ("6".equals(choose)) { deleteSql[i] = "delete D_R_MODULE_MANAGER where manager_id="+beginRight[i]+" and module_id="+id;}
        else if ("7".equals(choose)) { deleteSql[i] = "delete D_R_ROLE_FUN where function_id="+beginRight[i]+" and role_id="+id;}
        else if ("8".equals(choose)) { deleteSql[i] = "delete D_R_ROLE_MODULE where module_id="+beginRight[i]+" and role_id="+id;}
        else if ("9".equals(choose)) { deleteSql[i] = "delete D_R_USERFUN where function_id="+beginRight[i]+" and user_id="+id;}
        else if ("10".equals(choose)) { deleteSql[i] = "delete D_R_USERMODULE where module_id="+beginRight[i]+" and user_id="+id;}
        else if ("11".equals(choose)) { deleteSql[i] = "delete D_R_FUN_MANAGER where function_id="+beginRight[i]+" and manager_id="+id;}
        else if ("12".equals(choose)) { deleteSql[i] = "delete D_R_MODULE_MANAGER where module_id="+beginRight[i]+" and manager_id="+id;}
        else if ("13".equals(choose)) { deleteSql[i] = "delete D_USER_ROLE where role_id="+beginRight[i]+" and user_id="+id;}
    }
  }
  //拼insert语句
  String[] insertSql;
  if(endRight==null) insertSql = new String[0];
  else
  {
    insertSql  = new String[endRight.length];
    for(int i=0;i<endRight.length;i++)
    {
      if ("1".equals(choose))      { insertSql[i] = "insert into D_R_USERFUN(user_id,function_id) values("+endRight[i]+","+id+")";}
      else if ("2".equals(choose)) { insertSql[i] = "insert into D_R_FUN_MANAGER(manager_id,function_id) values("+endRight[i]+","+id+")";}
      else if ("3".equals(choose)) { insertSql[i] = "insert into D_R_ROLE_FUN(role_id,function_id) values("+endRight[i]+","+id+")";}
      else if ("4".equals(choose)) { insertSql[i] = "insert into D_R_USERMODULE(user_id,module_id) values("+endRight[i]+","+id+")";}
      else if ("5".equals(choose)) { insertSql[i] = "insert into D_R_ROLE_MODULE(role_id,module_id) values("+endRight[i]+","+id+")";}
      else if ("6".equals(choose)) { insertSql[i] = "insert into D_R_MODULE_MANAGER(manager_id,module_id) values("+endRight[i]+","+id+")";}
      else if ("7".equals(choose)) { insertSql[i] = "insert into D_R_ROLE_FUN(function_id,role_id) values("+endRight[i]+","+id+")";}
      else if ("8".equals(choose)) { insertSql[i] = "insert into D_R_ROLE_MODULE(module_id,role_id) values("+endRight[i]+","+id+")";}
      else if ("9".equals(choose)) { insertSql[i] = "insert into D_R_USERFUN(function_id,user_id) values("+endRight[i]+","+id+")";}
      else if ("10".equals(choose)) { insertSql[i] = "insert into D_R_USERMODULE(module_id,user_id) values("+endRight[i]+","+id+")";}
      else if ("11".equals(choose)) { insertSql[i] = "insert into D_R_FUN_MANAGER(function_id,manager_id) values("+endRight[i]+","+id+")";}
      else if ("12".equals(choose)) { insertSql[i] = "insert into D_R_MODULE_MANAGER(module_id,manager_id) values("+endRight[i]+","+id+")";}
      else if ("13".equals(choose)) { insertSql[i] = "insert into D_USER_ROLE(role_id,user_id) values("+endRight[i]+","+id+")";}
    }
  }
%>

<html>
<head>
  <title></title>
  <link rel="stylesheet" href="../style/PageStyle.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" background="../images/background.gif">
<br>
<div align="center">
  <p>
    <%
      try
      {
        exeInsertUpdateDelete iud = new exeInsertUpdateDelete();
        boolean resultInsert = false;
        boolean resultDelete = false;
        resultDelete = iud.execSql(deleteSql);
        resultInsert = iud.execSql(insertSql);
        if (resultInsert || resultDelete){
          out.println("<h5>业务数据提交从成功!</h5>");
          out.println("<p><a href='javascript:history.go(-2);'><h6>返回</h6></a></p>");
        }
        else{
          out.println("<h5>业务数据提交从失败!</h5>");
          out.println("<p><a href='javascript:history.go(-2);'><h6>返回</h6></a></p>");
        }
      }
      catch(Exception e)
      {

      }
    %>
  </p>
</div>
</body>
</html>

