<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>登录验证</title>
</head>
<link rel="stylesheet" href="./style/PageStyle.css" type="text/css">

<Script language="javascript" SRC="./style/common.js"></Script>

<jsp:useBean id="login" scope="page" class="com.bean.LoginBean" />


<%
  String UserMark;//用户类型：管理员级——1/一般用户——0
  String userName="";
  String password="";
  String url="";

  userName=request.getParameter("userName");
  userName=(userName==null)?null:userName.trim();
  password=request.getParameter("password");

 
/********************************************************
	//authen
	0(0没有此用户,1为正确);
	1(1表示密码正确，0表示错误);
	2为用户类型（0表示普通用户,1表示管理员）
	3为用户id
	4为用户名称
	5为用户所在部门号
	6为用户是否受权限表控制,0不受,1受
********************************************************/
  String[] authen=login.authenticate(userName,password);
  
  String showMessage="";
  
    if (authen == null){//系统有误
      showMessage="网络有误,请稍后再登录";
      url="login.jsp?showMessage="+showMessage+"&userName="+userName;
    }
	else{
      if (authen[0].equals("0")){//无此用户名
        showMessage="无此用户名";
        url="login.jsp?showMessage="+showMessage+"&userName="+userName;
      }
	  else{
        if (authen[1].equals("0")){//密码有误
          showMessage="密码错误";
          url="login.jsp?showMessage="+showMessage+"&userName="+userName;
        }else{
          url="loginSuccess.jsp";//登录成功jsp            

          session.setAttribute("userType",authen[2]);//用户类型          
		  session.setAttribute("userId",authen[3]);//用户id
		  session.setAttribute("userName",authen[4]);//用户名
		  session.setAttribute("userDep",authen[5]);//用户所在部门
		  session.setAttribute("userRightControl",authen[6]);//为用户是否受权限表控制		  
          session.setMaxInactiveInterval(1800);//session时间,30分钟                   
        }
      }
    }
%>
<body  onLoad="window.location.href='<%=url%>'">

</body>
</html>