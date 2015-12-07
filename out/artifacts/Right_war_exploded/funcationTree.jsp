
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*,com.ins.*,com.tree.*" %>
<jsp:useBean id="GF" scope="session" class="com.bean.GeneralFun" />
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

	<link rel="stylesheet" href="./style/PageStyle.css" type="text/css">

</head>
<%
	String userId=(String)session.getAttribute("userId");
	String userType=(String)session.getAttribute("userType");
	String userName=(String)session.getAttribute("userName");
	String userDepId=(String)session.getAttribute("userDep");
	String userDepName = GF.getDepNameFromDepid(userDepId);
	String userRightControl=(String)session.getAttribute("userRightControl");
%>
<body leftmargin="0" bgcolor="#D7EAF8" background="images/111.gif" onmouseover="self.status = ' <%=userName%> ：您好！ 欢 迎 使 用 索 创 系 统 ';return true">
<form name="form1" method="post" action="">
	<table width=151 border=0 cellspacing=0 cellpadding=0 align="left" height="28">
		<tbody>
		<tr>
			<td>
				<%
					Tree t = new Tree();
					if(userType.equals("0"))  //是普通用户
						t.repaire_for_comuser(userId);
					else                      //是管理员
						t.repaire_for_manager(userId,userDepName);
					out.println(t.beginTrack(t.getRoot(false)));
				%>
			</td>
		</tr>
	</TABLE>
	<input type="hidden" name="reloadMark" value="0">
</form>
</BODY>
</HTML>
