<%--
  Created by IntelliJ IDEA.
  User: Xirui
  Date: 2015/11/17
  Time: 21:34
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
  String id = request.getParameter("id");
%>
<TABLE cellSpacing=0 cellPadding=0  width="100%" align=center border=0>
  <TBODY>
  <tr>
    <TD width="90%" height=53 background="../images/333.gif">
      <div align="center"><span style="letter-spacing: 2pt"><b><h1></h1></B></SPAN></DIV></TD>
    <TD width="10%" height=53 background="../images/333.gif"><img border="0" src="../images/xtgl.gif"> </TD>
  </TR>
  </TBODY>
</TABLE>

<table width="80%" border="1" align="center" height="40" cellpadding="0" cellspacing="0"  bordercolordark="#FFFFFF" bordercolorlight="#102884">
  <tr >
    <td colspan="2"  nowrap bgcolor="#C4CAE1" height="44" align="center">
      <div align="center">密码是：<%=GF.getManagerPassword(id)%> <font color="red"  ></font></div>
    </td>
  </tr>
  <tr>
    <td width="57"><div align="center"><input name="imageField" type="image" src="../images/return.gif" width="57" height="22" border="0"  onclick="javascript:history.back()" /></div></td>
  </tr>
</table>
</body>
</html>
