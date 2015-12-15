<%--
  Created by IntelliJ IDEA.
  User: Xirui
  Date: 2015/12/3
  Time: 19:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ins.*, com.tree.*"%>

<html >
<head>
  <title>无标题文档</title>
  <style type="text/css">
    <!--
    .style10 {	color: #000000;
      font-family: "隶书";
      font-size: 24px;
    }
    .style12 {	color: #000000;
      font-family: "隶书";
      font-size: 36px;
    }
    .style30 {	font-size: 16px;
      font-weight: bold;
      color: #020000;
    }
    -->
  </style>
  <SCRIPT LANGUAGE="JavaScript">
    function de(){
      var len=document.form1.left.options.length;
      for(var i=0;i<len;i++){

        //alert(document.form1.left.options[0].text);
        if(document.form1.left.options[i].selected==true){
          var oOption = document.createElement("option");
          oOption.text=document.form1.left.options[i].text;


          oOption.value=document.form1.left.options[i].value;
          document.form1.right.add(oOption);
          document.form1.left.remove(i);
          i=i-1;
        }
      }
    }

    function sa(){
      for(var i=0;i<document.form1.right.options.length;i++){
        if(document.form1.right.options[i].selected==true){
          //alert("true");
          //alert(document.form1.right.options[i].text);
          var oOption = document.createElement("option");
          oOption.text=document.form1.right.options[i].text;
          oOption.value=document.form1.right.options[i].value;
          document.form1.left.add(oOption);
          document.form1.right.remove(i);
          i=i-1;
        }
      }
    }

    function tijiao()
    {
      var len=document.form1.right.options.length;
      for(var i=0;i<len;i++)
      {
        document.form1.right.options[i].selected = true;
      }
    }
  </SCRIPT>
</head>
<%
  String userDep = (String)session.getAttribute("userDep");
  String id=request.getParameter("id");
  String sql="select function_name from d_function where function_id="+id;
  exeQueryResult e = new exeQueryResult();
  String functionname[][]=e.getSelectResultWithStringArray(sql);
  sql="select manager_id,manager_name from d_manager where org_id >"+userDep+" and manager_id not in(select d_manager.manager_id from d_manager,D_R_FUN_MANAGER where d_manager.manager_id=D_R_FUN_MANAGER.manager_id and function_id="+id+" and org_id>"+userDep+")";
  String noFunManager[][]=e.getSelectResultWithStringArray(sql);
  sql="select d_manager.manager_id,manager_name from d_manager,D_R_FUN_MANAGER where d_manager.manager_id=D_R_FUN_MANAGER.manager_id and function_id="+id+" and org_id!="+userDep;
  String haveFunManager[][]=e.getSelectResultWithStringArray(sql);
  String[] beginRight = null;
  if(haveFunManager!=null)
  {
    beginRight = new String[haveFunManager.length];
    for(int i=0;i<haveFunManager.length;i++)
    {
      beginRight[i] = haveFunManager[i][0];
    }
  }
  session.setAttribute("beginRight",beginRight);
%>
<body>
<table width="667" border="0" align="center" >
  <tr>
    <td width="657" height="116" background="../images/333.gif">      <h1 align="center" class="style12">权限管理系统</h1>      <p align="center" class="style10"> --管理员模块管理</p></td></tr>
</table>
<form action="../Common/FormReceiveJSP_forRight.jsp?choose=2" method="post" name="form1">
  <input type="hidden" name="id" value=<%=id%>>
  <div align="center">
    <p class="style30">当前功能:<%=functionname[0][0]%></p>
    <table width="383" border="0" bgcolor="#C4CAE1">
      <input type="hidden" name="modulefunctionid" value="function_id">
      <tr>
        <td width="154" height="47"><div align="center">
          <p align="left"><strong>没有功能权限的管理员</strong></p>
        </div></td>
        <td width="53">&nbsp;</td>
        <td width="154"><div align="center">
          <p align="left"><strong>拥有功能权限的管理员</strong></p>
        </div></td>
      </tr>
      <tr>
        <td height="119" rowspan="2">
          <select name="left" size="18" multiple style="width:80pt">
            <%
              if(noFunManager!=null)
              {
                for(int i=0;i<noFunManager.length;i++)
                {
            %>
            <option value="<%=noFunManager[i][0]%>"><%=noFunManager[i][1]%></option>
            <%
                }
              }
            %>
          </select></td>
        <td height="123"><img src="../images/arrowrA.gif" width="32" height="34" onmouseout="src='../images/arrowrA.gif'" onmouseover="src='../images/arrowr.gif'" onclick="de();" />&nbsp;</td>
        <td rowspan="2">
          <select name="right" size="18" multiple="multiple" style="width:80pt">
            <%
              if(haveFunManager!=null)
              {
                for(int j=0;j<haveFunManager.length;j++)
                {
            %>
            <option value="<%=haveFunManager[j][0]%>"><%=haveFunManager[j][1]%></option>
            <%
                }
              }
            %>
          </select></td>
      </tr>
      <tr>
        <td height="103"><img src="../images/arrowlA.gif" width="32" height="34" onmouseout="src='../images/arrowlA.gif'" onmouseover="src='../images/arrowl.gif'" onclick="sa();"/>&nbsp;</td>
      </tr>
    </table>
    <table width="172" border="0">
      <tr>
        <td width="57" height="42"><input name="imageField" type="image" src="../images/ok.gif" width="57" height="22" border="0" onclick="tijiao()"/></td>
        <td width="57"><input name="imageField" type="image" src="../images/return.gif" width="57" height="22" border="0" onclick="javascript:history.back()" /></td>
      </tr>
    </table>
</html>
