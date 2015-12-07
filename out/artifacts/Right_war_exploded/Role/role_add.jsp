<%--
  Created by IntelliJ IDEA.
  User: Xirui
  Date: 2015/11/17
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="GF" scope="session" class="com.bean.GeneralFun" />
<script language="JavaScript">
  function check() {
    if (form1._role_name.value == ""){
      alert("角色名不能为空，请输入角色名！");
      form1._role_name.focus();
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
  int roleid = Integer.parseInt(GF.getRoleNumber()) + 1;
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
    <input type="hidden" name="$role_id" value="<%=GF.getSeq("d_role")%>">
    <input type="hidden" name="_org_id" value="<%=org_id%>" >
    <input type="hidden" name="tableName" value="d_role" >
    <input type="hidden" name="tableAction" value="1" >

    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >角色姓名:</td>
      <td width="83%" >
        <input type="text" name="_role_name" value="" size="20" maxlength="20">
      </td>
    </tr>

    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >角色描述:</td>
      <td width="83%" >
        <input type="text" name="_role_describe" value="" size="20" maxlength="20">
      </td>
    </tr>

    <input type="hidden" name="_role_order" value="1" >

  </table>
  <div align="center">
    <input type="image" border="0" name="imageField34" src="../images/ok.gif"  onmouseout="src='../images/ok.gif'" onmouseover="src='../images/ok1.gif'" onclick="">
    <input type="image" border="0" name="imageField32" src="../images/cancel.gif"  onmouseout="src='../images/cancel.gif'" onmouseover="src='../images/cancel1.gif'" onclick="form1.reset(); return false;">
  </div>
</form>
</body>
</html>