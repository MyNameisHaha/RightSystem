
<%@ page contentType="text/html; charset=utf-8" %>

<%
  String username = (String)session.getAttribute("userName");
%>

<html>
<head>
<title>索创系统</title>
</head>
<FRAMESET cols="30%,70%" rows="*" >
  <frame name="rls" src="funcationTree.jsp">
  <frame name="rhs" src="./welcome/welcome.html">
</FRAMESET>
<noframes>
<body bgcolor="#FFFFFF" text="#000000" onmouseover="self.status=' <%=username%> ：您好！ 欢 迎 使 用 索 创 系 统';return true">
</body>
</noframes>
</html>
