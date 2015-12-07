
<%@ page import="java.util.*,com.ins.*" %>

<%@ page contentType="text/html; charset=utf-8" %>
<%@ page errorPage="../error.jsp" %>
<jsp:useBean id="GF" scope="session" class="com.bean.GeneralFun" />


<%----------- 处理客户端提交的信息 -----------%>
<%
  //将jsp的提交的过程相关数据及其值放入哈希表commonParams中。
  Hashtable commonParams=new Hashtable();
  Enumeration e=request.getParameterNames();
  String para_name="";
  String para_value="";
  String tableName=request.getParameter("tableName");
  String tableAction=request.getParameter("tableAction"); 
  int    tableActionInt = Integer.parseInt(tableAction);
  
  while(e.hasMoreElements())
  {
    para_name=(String)e.nextElement();    
    para_value=GF.reStructStr(request.getParameter(para_name));   
	//System.out.println(para_value);
	if(para_name.startsWith(exelnsertUpdateDelete.keyMark)||para_name.startsWith(exelnsertUpdateDelete.nonKeyMark)){
		commonParams.put(para_name,para_value);
	}
  }    
%>

<html>
<head>
<title></title>
<link rel="stylesheet" href="../style/PageStyle.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" background="../images/background.gif">
<br>
<div align="center">
<p>
     <%
	    exelnsertUpdateDelete iud = new exelnsertUpdateDelete();
		boolean result ;
	    result = iud.execSql(tableName,tableActionInt,commonParams,false);
		if (result){
			out.println("<h5>业务数据提交从成功!</h5>");
			out.println("<p><a href='javascript:history.back();'><h6>返回</h6></a></p>");
		}
		else{
			out.println("<h5>业务数据提交从失败!</h5>");
			out.println("<p><a href='javascript:history.back();'><h6>返回</h6></a></p>");
		}		
	 %>
</p>
</div>
</body>
</html>
