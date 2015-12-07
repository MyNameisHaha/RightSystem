<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page errorPage="error.jsp" %>

<jsp:useBean id="GF" scope="session" class="com.bean.GeneralFun" />

<html>

<head>
<link rel="stylesheet" href="./style/PageStyle.css" type="text/css">
<Script language="javascript" SRC="common.js"></Script>

<title>登录</title>
<script>
function sf(){document.form1.userName.focus();}
</script>
</head>
<%
  request.setCharacterEncoding("utf-8");
  response.setCharacterEncoding("utf-8");
  String userName=request.getParameter("userName");
  userName=(userName==null)?"":userName;
  String password=request.getParameter("password");
  password=(password==null)?"":password;
  password="";
  String showMessage=request.getParameter("showMessage");
  showMessage=(showMessage==null)?"":showMessage;
  showMessage = GF.reStructStr(showMessage);
%>
<body topmargin="0" leftmargin="0" bgcolor="#D7EAF8" background="images/111.gif" onLoad="sf();" 
   onmouseover="self.status='欢 迎 使 用 系 统';return true">

<div align="center">
  <center>
<form name="form1" method="post" action="login_check.jsp">
<br>


  <div align="center">
    <center>
          <table border="0" cellpadding="0" cellspacing="0" width="600">
            <tr> 
              <td valign="middle" align="center" height="493%" background="image/td_bg.gif"> 
                <img border="0" src="images/login3.jpg" width="547" height="300"> 
              </td>
            </tr>
            <tr> 
              <td valign="middle" align="center" height="8" background="images/td_bg.gif"> 
                <p align="center"> <font color="red"> <%=showMessage%></font> 
                  　 
              </td>
            </tr>
            <tr> 
              <td valign="bottom" align="center" height="12" background="image/td_bg.gif"> 
                <div align="center"><b><font color="#000000">用户名：</font></b> 
                  <input type="text" name="userName" value="<%=userName%>" maxlength="20" size="15" mustFill=true promptName="用户名">
                  &nbsp;<font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp; <b>密&nbsp; 
                  码：</b></font> 
                  <input type="password" name="password" value="<%=password%>" maxlength="6" size="15" mustFill=true promptName="密码项">
                  &nbsp;&nbsp;&nbsp;&nbsp; 
                  <input type="image" border="0" name="imageField332" src="images/login-01.gif"  onMouseOut="src='images/login-01.gif'" onMouseOver="src='images/login-02.gif'" onClick="mySubmit();return false;">
                </div>
              </td>
            </tr>
  
          </table>
    </center>
  </div>


  </form>
  </center>
</div>

</body>

</html>
