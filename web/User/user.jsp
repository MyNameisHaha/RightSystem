<%--
  Created by IntelliJ IDEA.
  User: Xirui
  Date: 2015/11/12
  Time: 20:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="GF" scope="session" class="com.bean.GeneralFun" />

<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link rel="stylesheet" href="../style/PageStyle.css" type="text/css">
  <Script language="javascript" SRC="../style/common.js"></Script>
</head>


<body topmargin="0" bgcolor="#FFFFFF" text="#000000" background="" >
<%
  String id=request.getParameter("userId");
%>

<form name="form1" method="post" action="sa_delete.jsp?aHref=../sa_tree.jsp&_oid=<%=id%>&_downid=<%=id%>">
  <TABLE cellSpacing=0 cellPadding=0  width="100%" align=center border=0>
    <TBODY>
    <tr>
      <TD width="90%" height=53 background="../images/333.gif">
        <div align="center"><span style="letter-spacing: 2pt"><b><h1>用户管理</h1></B></SPAN></DIV></TD>
      <TD width="10%" height=53 background="../images/333.gif"><img border="0" src="../images/xtgl.gif"> </TD>
    </TR>
    </TBODY>
  </TABLE>
  <HR color="#D7EAF8" size="6" noshade>
  <br>
  <table width="80%" border="1" align="center" height="40" cellpadding="0" cellspacing="0"  bordercolordark="#FFFFFF" bordercolorlight="#102884">
    <tr >
      <td colspan="2"  nowrap bgcolor="#C4CAE1" height="44" align="center">
        <div align="center">当前用户姓名：<%=GF.getUserName(id)%> <font color="red"  ></font></div>
      </td>
    </tr>
    <tr >
      <td width="50%"  bgcolor="#C4CAE1" height="33" align="center">
        <a href="user_update.jsp?id=<%=id%>">编辑员工</a></td>
      <td width="257"  bgcolor="#C4CAE1" height="33"  align="center">
        <a href="../Common/FormReceiveJSP.jsp?tableName=d_user&tableAction=3&$user_id=<%=id%>"
           onClick="return Conwin('确定要删除吗？');">删除员工</a></td>
    </tr>
    <tr >
      <td width="50%"  bgcolor="#C4CAE1"  height="30" align="center">
        <a href="user_role.jsp?id=<%=id%>">员工角色</a></td>
      <td width="257"  bgcolor="#C4CAE1" height="30" align="center">
        <a href="user_password.jsp?id=<%=id%>">密码查询</a></td>
    </tr>
    <tr >
      <td width="50%"  bgcolor="#C4CAE1"  height="30" align="center">
        <a href="user_module_right.jsp?id=<%=id%>">员工模块授权</a></td>
      <td width="257"  bgcolor="#C4CAE1" height="30" align="center">
        <a href="user_fun_right.jsp?id=<%=id%>">员工功能授权</a></td>
    </tr>
  </table>
</form>
<br>
<hr width="95%" noshade size="6" color=#1B4B81>
</body>
</html>
