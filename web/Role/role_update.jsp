<%--
  Created by IntelliJ IDEA.
  User: Xirui
  Date: 2015/11/17
  Time: 22:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ins.*" %>
<jsp:useBean id="GF" scope="session" class="com.bean.GeneralFun" />
<script language="JavaScript">
  function check() {
    if (form1._role_name.value == ""){
      alert("角色名称不能为空，请输入角色名称！");
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

<body topmargin="0" bgcolor="#FFFFFF" text="#000000" >
<%
  String id=request.getParameter("id");
  exeQueryResult r = new exeQueryResult();
  String re[][] = r.getSelectResultWithStringArray("select org_id,role_name,role_describe from d_role where role_id="+id);//二维String数组中

%>
<form name="form1" method="post" action="../Common/FormReceiveJSP.jsp" onsubmit="return check()">
  <TABLE cellSpacing=0 cellPadding=0  width="100%" align=center border=0><!--DWLayoutTable-->
    <TBODY>
    <tr>
      <TD width="90%" height=53 background="../../images/333.gif">
        <div align="center"><b><h1>当前角色名称：<%=re[0][1]%> </h1></B></DIV></TD>
      <TD width="10%" height=53 background="../../images/333.gif"><img border="0" src="../../images/xtgl.gif"> </TD>
    </TR>
    </TBODY>
  </TABLE>
  <HR color="#D7EAF8" size="6" noshade>

  <table width="50%" border="1" align="center" height="40" cellpadding="0" cellspacing="0"  bordercolordark="#FFFFFF" bordercolorlight="#102884">
    <input type="hidden" name="$role_id" value="<%=id%>">
    <input type="hidden" name="tableName" value="d_role" >
    <input type="hidden" name="tableAction" value="2" >
    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >角色所属单位编号</td>

      <td width="83%" ><input type="text" name="_org_id" value="<%=re[0][0]%>" size="20" maxlength="20"><%=GF.getDepNameFromDepid(re[0][0])%></td>

    </tr>
    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >角色名称</td>

      <td width="83%" ><input type="text" name="_role_name" value="<%=re[0][1]%>" size="20" maxlength="30"></td>

    </tr>

    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >角色描述</td>

      <td width="83%" ><input type="text" name="_role_describe" value="<%=re[0][2]%>" size="20" maxlength="50"></td>

    </tr>

  </table>
  <div align="center">
    <input type="image" border="0" name="imageField34" src="../images/ok.gif"  onmouseout="src='../images/ok.gif'" onmouseover="src='../images/ok1.gif'" onclick="">
    <input type="image" border="0" name="imageField32" src="../images/cancel.gif"  onmouseout="src='../images/cancel.gif'" onmouseover="src='../images/cancel1.gif'" onclick="form1.reset(); return false;">
  </div>
</form>
</body>
</html>
