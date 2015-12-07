<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.ins.*" %>
<jsp:useBean id="GF" scope="session" class="com.bean.GeneralFun" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../style/PageStyle.css" type="text/css">
</head>

<body topmargin="0" bgcolor="#FFFFFF" text="#000000" >
<%  
  String id=request.getParameter("id");
  exeQueryResult r = new exeQueryResult();
  String re[][] = r.getSelectResultWithStringArray("select org_id,org_name,org_order from d_org where org_id="+id);

%>
<form name="form1" method="post" action="../Common/FormReceiveJSP.jsp">
 <TABLE cellSpacing=0 cellPadding=0  width="100%" align=center border=0><!--DWLayoutTable-->
	  <TBODY>  
		  <tr>
		    <TD width="90%" height=53 background="../../images/333.gif">
		      <div align="center"><b><h1>当前部门名：<%=GF.getDepNameFromDepid(id)%> </h1></B></DIV></TD>
		    <TD width="10%" height=53 background="../../images/333.gif"><img border="0" src="../../images/xtgl.gif"> </TD>
		  </TR>
	  </TBODY>
 </TABLE>
<HR color="#D7EAF8" size="6" noshade>

  <table width="50%" border="1" align="center" height="40" cellpadding="0" cellspacing="0"  bordercolordark="#FFFFFF" bordercolorlight="#102884">
    <input type="hidden" name="$org_id" value="<%=id%>" size="50" maxlength="20">	
	<input type="hidden" name="tableName" value="d_org" >
	<input type="hidden" name="tableAction" value="2" >
     <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >上级单位</td>
      <td width="83%" >        
		<select size="1" name="_up_org_id">				
				<%				  
				  String up_org_id = GF.getUpDepIdFromDepid(id);
				  exeQueryResult eqr = new exeQueryResult();
				  String e[][] = eqr.getSelectResultWithStringArray("select org_id,org_name from d_org ");
				  //System.out.println("++++++++++++++"+up_org_id);
				  if (e!=null){
					  for(int i=0;i<e.length;i++){
						  System.out.println("----------------"+e[i][0]);
						  if(e[i][0].equals(up_org_id)){
							  out.println("<option  value="+e[i][0]+"  selected>"+e[i][1]+"</option>");
						  }
						  else{
                              if(e[i][0].equals(id)){
                                  continue;
                              }
							  out.println("<option  value="+e[i][0]+" >"+e[i][1]+"</option>");
						  }
					  }
				  }                  
				
				%>	
		</select>
      </td>
    </tr>
    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >单位名称</td>
      <td width="83%" > 
        <input type="text" name="_org_name" value="<%=re[0][1]%>" size="50" maxlength="20">
        </td>
    </tr>
    <tr >
      <td width="17%"  nowrap bgcolor="#C4CAE1" >顺序号</td>
      <td width="83%"  > 
        <input type="text" name="_org_order" value="<%=re[0][2]%>" size="50" maxlength="10">
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
