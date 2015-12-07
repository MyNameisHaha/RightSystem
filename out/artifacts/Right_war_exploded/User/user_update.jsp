<%--
  Created by IntelliJ IDEA.
  User: Xirui
  Date: 2015/11/12
  Time: 22:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.ins.*" %>
<jsp:useBean id="GF" scope="session" class="com.bean.GeneralFun" />
<script language="JavaScript">
  function check() {
    var re =/^[A-Za-zd]+([-_.][A-Za-zd]+)*@([A-Za-zd]+[-.])+[A-Za-zd]{2,5}$/;
    var txt = document.forms[0]._e_mail.value;
    if (re.test(txt)){}
    else{
      alert("邮箱地址错误，请重新输入")
      form1._e_mail.focus();
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
  String re[][] = r.getSelectResultWithStringArray("select user_id,user_name,org_id,password,address,mail,e_mail,age,user_tel from d_user where user_id="+id);//二维String数组中

%>
<form name="form1" method="post" action="../Common/FormReceiveJSP.jsp" onsubmit="return check()">
  <TABLE cellSpacing=0 cellPadding=0  width="100%" align=center border=0><!--DWLayoutTable-->
    <TBODY>
    <tr>
      <TD width="90%" height=53 background="../../images/333.gif">
        <div align="center"><b><h1>当前用户名：<%=re[0][1]%> </h1></B></DIV></TD>
      <TD width="10%" height=53 background="../../images/333.gif"><img border="0" src="../../images/xtgl.gif"> </TD>
    </TR>
    </TBODY>
  </TABLE>
  <HR color="#D7EAF8" size="6" noshade>

  <table width="50%" border="1" align="center" height="40" cellpadding="0" cellspacing="0"  bordercolordark="#FFFFFF" bordercolorlight="#102884">
    <input type="hidden" name="$user_id" value="<%=id%>" size="50" maxlength="20">
    <input type="hidden" name="tableName" value="d_user" >
    <input type="hidden" name="tableAction" value="2" >
    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >用户所属单位编号</td>
      <td width="83%" >
          <input type="text" name="_org_id" value="<%=re[0][2]%>" size="20" maxlength="20"><%=GF.getDepNameFromDepid(re[0][2])%>
      </td>
    </tr>
    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >用户姓名</td>
      <td width="83%" >
        <input type="text" name="_user_name" value="<%=re[0][1]%>" size="20" maxlength="30">
      </td>
    </tr>

    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >地址:</td>
      <td width="83%"  >
        <input type="text" name="_address" value="<%=re[0][4]%>" size="20" maxlength="30">
      </td>
    </tr>

    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >邮编:</td>
      <td width="83%"  >
        <input type="text" name="_mail" value="<%=re[0][5]%>" size="20" maxlength="6">
      </td>
    </tr>

    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >邮箱:</td>
      <td width="83%"  >
        <input type="text" name="_e_mail" value="<%=re[0][6]%>" size="20" maxlength="20">
      </td>
    </tr>

    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >年龄:</td>
      <td width="83%"  >
        <input type="text" name="_age" value="<%=re[0][7]%>" size="20" maxlength="3">
      </td>
    </tr>

    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >电话:</td>
      <td width="83%"  >
        <input type="text" name="_user_tel" value="<%=re[0][8]%>" size="20" maxlength="11">
      </td>
    </tr>

  </table>
  <div align="center">
    <input type="image" border="0" name="imageField34" src="../images/ok.gif"  onmouseout="src='../images/ok.gif'" onmouseover="src='../images/ok1.gif'" onclick="">
    <input type="image" border="0" name="imageField32" src="../images/cancel.gif"  onmouseout="src='../images/cancel.gif'" onmouseover="src='../images/cancel1.gif'" onclick="form1.reset(); return false;">
  </div>
</form>
</body>
</html>
