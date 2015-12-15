<%--
  Created by IntelliJ IDEA.
  User: Xirui
  Date: 2015/11/17
  Time: 21:08
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
  String id=request.getParameter("managerId");
  String loginid = (String) session.getAttribute("userId");
%>

<form name="form1" method="post" action="sa_delete.jsp?aHref=../sa_tree.jsp&_oid=<%=id%>&_downid=<%=id%>">
  <TABLE cellSpacing=0 cellPadding=0  width="100%" align=center border=0>
    <TBODY>
    <tr>
      <TD width="90%" height=53 background="../images/333.gif">
        <div align="center"><span style="letter-spacing: 2pt"><b><h1>管理员管理</h1></B></SPAN></DIV></TD>
      <TD width="10%" height=53 background="../images/333.gif"><img border="0" src="../images/xtgl.gif"> </TD>
    </TR>
    </TBODY>
  </TABLE>
  <HR color="#D7EAF8" size="6" noshade>
  <br>
  <table width="80%" border="1" align="center" height="40" cellpadding="0" cellspacing="0"  bordercolordark="#FFFFFF" bordercolorlight="#102884">
     <tr >
       <td colspan="2"  nowrap bgcolor="#C4CAE1" height="44" align="center">
        <div align="center">当前管理员姓名：<%=GF.getManagerName(id)%> <font color="red"  ></font></div>
      </td>
     </tr>

    <tr >
      <td width="50%"  bgcolor="#C4CAE1" height="33" align="center"><a href="manager_update.jsp?id=<%=id%>">编辑管理员</a></td>

      <td width="257"  bgcolor="#C4CAE1" height="30" align="center"><a href="manager_password.jsp?id=<%=id%>">管理员密码查询</a></td>
    </tr>

    <tr>
      <% if ( id.equals(loginid) ){%>
          <td width="50%"  bgcolor="#C4CAE1"  height="30" align="center"><a href="manager_right.jsp?id=<%=id%>">管理员拥有权限查看</a></td>
          <td width="257"  bgcolor="#C4CAE1" height="30" align="center"><a href=""></a></td>
      <%}
        else  {
      %>
      <td width="50%"  bgcolor="#C4CAE1"  height="30" align="center"><a href="manager_module_right.jsp?id=<%=id%>">管理员模块授权</a></td>
      <td width="257"  bgcolor="#C4CAE1" height="30" align="center"><a href="manager_fun_right.jsp?id=<%=id%>">管理员功能授权</a></td>
      <%}%>

    </tr>

    <tr >
      <%--自身登录不能删自己--%>
      <td width="257"  bgcolor="#C4CAE1" height="33"  align="center"><a href="../Common/FormReceiveJSP.jsp?tableName=d_manager&tableAction=3&$manager_id=<%=id%>" onClick="return Conwin('确定要删除吗？');"><%if ( !id.equals(loginid) ){ %>删除管理员<%}%></a></td>
      <td width="257"  bgcolor="#C4CAE1" height="30" align="center"><a href=""></a></td>
    </tr>
  </table>
</form>
<br>
<hr width="95%" noshade size="6" color=#1B4B81>
</body>
</html>
