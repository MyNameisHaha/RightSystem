<%--
  Created by IntelliJ IDEA.
  User: Xirui
  Date: 2015/11/17
  Time: 15:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="GF" scope="session" class="com.bean.GeneralFun" />
<script language="JavaScript">
  function check() {
    if (form1._login_user.value == ""){
      alert("登陆用户名不能为空，请输入登陆用户名！");
      form1._login_user.focus();
      return false;
    }
    if (form1._password.value == ""){
      alert("用户密码不能为空，请输入密码！");
      form1._password.focus();
      return false;
    }
    if (form1.repassword.value == ""){
      alert("用户确认密码不能为空，请输入密码！");
      form1.repassword.focus();
      return false;
    }
    if (form1._password.value != form1.repassword.value){
      alert("密码与确认密码不同");
      form1._password.focus();
      return false;
    }
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
<%
  String org_id=request.getParameter("id");
  int userid = Integer.parseInt(GF.getUserNumber()) + 1;
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
        <input type="hidden" name="$user_id" value="<%=GF.getSeq("d_user")%>">
        <input type="hidden" name="_org_id" value="<%=org_id%>" size="50" maxlength="20">
        <input type="hidden" name="tableName" value="d_user" >
        <input type="hidden" name="tableAction" value="1" >

        <tr >
          <td width="17%"  nowrap bgcolor="#C4CAE1" >员工姓名:</td>
          <td width="83%" >
            <input type="text" name="_user_name" value="" size="20" maxlength="20">
          </td>
        </tr>

        <tr >
          <td width="17%"  nowrap bgcolor="#C4CAE1" >员工登陆用户名</td>
          <td width="83%"  >
            <input type="text" name="_login_user" value="" size="20" maxlength="10">
          </td>
        </tr>

        <tr >
          <td width="17%"  nowrap bgcolor="#C4CAE1" >登陆密码:</td>
          <td width="83%"  >
            <%--<input type="text" name="_password" value="" size="50" maxlength="10"> --%>
            <input type="password" name="_password" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
          </td>
        </tr>

        <tr >
          <td width="17%"  nowrap bgcolor="#C4CAE1" >重复登陆密码:</td>
          <td width="83%"  >
            <%--<input type="text" name="repassword" value="" size="50" maxlength="10">--%>
              <input type="password" name="repassword" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
          </td>
        </tr>

        <tr >
          <td width="17%"  nowrap bgcolor="#C4CAE1" >性别:</td>
          <td width="83%"  >
            <label><input type="radio" name="_gender" value="男">男</label>
            <label><input type="radio" name="_gender" value="女">女</label>提交后不能修改
          </td>
        </tr>

        <tr >
          <td width="17%"  nowrap bgcolor="#C4CAE1" >地址:</td>
          <td width="83%"  >
            <input type="text" name="_address" value="" size="20" maxlength="20">
          </td>
        </tr>

        <tr >
          <td width="17%"  nowrap bgcolor="#C4CAE1" >邮编:</td>
          <td width="83%"  >
            <input type="text" name="_mail" value="" size="20" maxlength="10">
          </td>
        </tr>

        <tr >
          <td width="17%"  nowrap bgcolor="#C4CAE1" >邮箱:</td>
          <td width="83%"  >
            <input type="text" name="_e_mail" value="" size="20" maxlength="20">
          </td>
        </tr>

        <tr >
          <td width="17%"  nowrap bgcolor="#C4CAE1" >年龄:</td>
          <td width="83%"  >
            <input type="text" name="_age" value="" size="20" maxlength="3">
          </td>
        </tr>

        <tr >
          <td width="17%"  nowrap bgcolor="#C4CAE1" >电话:</td>
          <td width="83%"  >
            <input type="text" name="_user_tel" value="" size="20" maxlength="11">
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
