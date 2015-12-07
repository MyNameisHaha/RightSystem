<%--
  Created by IntelliJ IDEA.
  User: Xirui
  Date: 2015/11/17
  Time: 19:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="GF" scope="session" class="com.bean.GeneralFun" />
<script language="JavaScript">
  function check() {
    if (form1._manager_name.value == ""){
      alert("管理员姓名不能为空，请输入管理员姓名！");
      form1._manager_name.focus();
      return false;
    }
    if (form1._manager_login.value == ""){
      alert("登陆名不能为空，请输入登陆名！");
      form1._manager_login.focus();
      return false;
    }
    if (form1._manager_login.value.substring(0,1) != "_") {
      alert("管理员登陆名必须是 _ 开头");
      form1._manager_login.focus();
      return false;
    }
    if (form1._manager_pwd.value == ""){
      alert("用户密码不能为空，请输入密码！");
      form1._manager_pwd.focus();
      return false;
    }
    if (form1.repassword.value == ""){
      alert("用户确认密码不能为空，请输入密码！");
      form1.repassword.focus();
      return false;
    }
    if (form1._manager_pwd.value != form1.repassword.value){
      alert("密码与确认密码不同");
      form1._manager_pwd.focus();
      return false;
    }
  }
</script>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link rel="stylesheet" href="../style/PageStyle.css" type="text/css">
</head>
<%
  String org_id=request.getParameter("id");
  int managerid = Integer.parseInt(GF.getManagerNumber()) + 100;
%>

<body topmargin="0" bgcolor="#FFFFFF" text="#000000" >
<form name="form1" method="post" action="../Common/FormReceiveJSP.jsp" onsubmit="return check()">
  <TABLE cellSpacing=0 cellPadding=0  width="100%" align=center border=0><!--DWLayoutTable-->
    <TBODY>
    <tr>
      <TD width="90%" height=53 background="../../images/333.gif">
        <div align="center"><b><h1>当前部门名：<%=GF.getDepNameFromDepid(org_id)%> </h1></B></DIV></TD>
      <TD width="10%" height=53 background="../../images/333.gif"><img border="0" src="../../images/xtgl.gif"> </TD>
    </TR>
    </TBODY>
  </TABLE>
  <HR color="#D7EAF8" size="6" noshade>

  <table width="50%" border="1" align="center" height="40" cellpadding="0" cellspacing="0"  bordercolordark="#FFFFFF" bordercolorlight="#102884">
    <input type="hidden" name="$manager_id" value="<%=GF.getSeq("d_manager")%>">
    <input type="hidden" name="_org_id" value="<%=org_id%>" size="50" maxlength="20">
    <input type="hidden" name="tableName" value="d_manager" >
    <input type="hidden" name="tableAction" value="1" >

    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >管理员姓名:</td>
      <td width="83%" >
        <input type="text" name="_manager_name" value="" size="20" maxlength="20">
      </td>
    </tr>

    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >管理员登陆名</td>
      <td width="83%"  >
        <input type="text" name="_manager_login" value="" size="20" maxlength="20">
      </td>
    </tr>

    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >登陆密码:</td>
      <td width="83%"  >
        <%--<input type="text" name="_password" value="" size="50" maxlength="10"> --%>
        <input type="password" name="_manager_pwd" size="20" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
      </td>
    </tr>

    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >重复登陆密码:</td>
      <td width="83%"  >
        <%--<input type="text" name="repassword" value="" size="50" maxlength="10">--%>
        <input type="password" name="repassword" size="20" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
      </td>
    </tr>
    <input type="hidden" name="_manager_order" value="1" >

  </table>
  <div align="center">
    <input type="image" border="0" name="imageField34" src="../images/ok.gif"  onmouseout="src='../images/ok.gif'" onmouseover="src='../images/ok1.gif'" onclick="">
    <input type="image" border="0" name="imageField32" src="../images/cancel.gif"  onmouseout="src='../images/cancel.gif'" onmouseover="src='../images/cancel1.gif'" onclick="form1.reset(); return false;">
  </div>
</form>
</body>
</html>