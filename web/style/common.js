function load_url(url){
  open(url,"_self");
}

function Conwin(str)
{
    if (confirm(str)) {
      return true;
    }
	else
	  return false;
}
function reflushSelf(){
        location.reload(); 
}
function mySubmit() { 	
	if(!verify()){
	    return false;												
	}	
	setParticipantVar(); 
	document.forms[0].submit();
	return true;
	
}
function myReset() { 
	document.forms[0].reset();
	return true;
}

function isBlank(s){
	for(var i=0;i<s.length;i++){
		var c=s.charAt(i);
		if ((c!='')&&(c!=' ')&&(c!='\n')&&(c!='\t')){
		   return false;
		}   
	}	
	return true;
}
function verify(){
	var f=document.forms[0];
	var msg;
	var empty_fields="";
	var errors="";
	//遍历所有的表单元素,查找所定义了mustFill属性的text以及textarea元素,检查是否为空,
	//另外,如果元素定义了numeric属性,则检查其是否为数字,如果定义了min以及max属性,则检查其是否
	//在范围中,最后把有错误的字段的错误信息集中在一起提示
	for(var i=0;i<f.length;i++){
		var e=f.elements[i];
		if(((e.type == "text")||(e.type == "password")||(e.type == "textarea"))){
			if(e.mustFill){
				if((e.value == null)||(e.value == "")||isBlank(e.value)){
					if(e.promptName){	
						empty_fields=empty_fields+"\n"+e.promptName+"不允许为空!";
					}	
					else{
						empty_fields=empty_fields+"\n"+e.name+"不允许为空!";							
					}		
					break;
				}					
					
			}
			if(e.numeric||(e.min!=null)||(e.max!=null)){
				if(!isBlank(e.value)){
					var v=parseFloat(e.value);
				
					if(isNaN(v)){			
						errors ="\n"+ errors + e.promptName+"应该是数字!";
					}	
					else if((e.min!=null) && (v<e.min)){
						errors +="\n"+e.promptName+"应该不小于"+e.min;
					}
					else if((e.max!=null) && (v>e.max)){
						errors +="\n"+e.promptName+"应该不大于"+e.max;
					}
					break;
				}
			}	
			if(e.isDate){
				if(!isBlank(e.value)){
					var v=e.value;
					var vResult=dateverify(v,'');
					if(vResult==''){
						errors +="\n"+e.promptName+"日期不合法！";
					}
					else{
						e.value=vResult;
					}			
					break;
				}
			}
			if(e.isDateTime){
				if(!isBlank(e.value)){
					var v=e.value;
					var vResult=dateverify(v,"yyyy-mm-dd hh:nn:ss");
					if(vResult==''){
						errors +="\n"+e.promptName+"日期不合法！";
					}
					else{
						e.value=vResult;
					}		
					break;
				}
			}
		}
	}
	if(!empty_fields && !errors) return true;
	msg="";
	if(empty_fields){
		msg+=empty_fields+"\n";
	}
	if(errors) msg+= errors;
	alert(msg);
	return false;
}

//日期的合法性判断，如果日期合法，返回经过处理的日期（yyyy-mm-dd或者yyyy-MM-dd hh:mm:ss）如果不合法，则返回空串
function dateverify(date,format) {
  var format,dateString;
  var tmpString;
  var interString;
  var formatString='ymdhns';
  interString='';
  if (format==null || format=='') format='yyyy-mm-dd';
  for (i0=0;i0<format.length;i0++) {
    if (formatString.indexOf(format.charAt(i0))==-1) interString=interString+format.charAt(i0);
    };
  interString=interString+interString.charAt(0);
  format=format+interString.charAt(0);
  date=date+interString.charAt(0);
  year=0;
  month=0;
  day=0;
  hour=1;
  min=1;
  sec=1;
  dateString='';
  oldIndex=0;
  oldIndex0=0;
  newIndex=0;
  for (i0=0;i0<interString.length;i0++) {
    tmpString0='';
    tmpString='';
    newIndex=date.indexOf(interString.charAt(i0),oldIndex);
    if (newIndex!=-1) {
      tmpString=date.substring(oldIndex,newIndex);
      oldIndex=newIndex+1;
      newIndex=format.indexOf(interString.charAt(i0),oldIndex0);
      for (j=0;j<newIndex-oldIndex0-tmpString.length;j++) tmpString0=tmpString0+'0';
      if (tmpString.length<(newIndex-oldIndex0)) tmpString=tmpString0+tmpString;
      if (tmpString.length>(newIndex-oldIndex0)) tmpString='0';
      dateString=dateString+tmpString;
      if (i0<interString.length-1) dateString=dateString+interString.charAt(i0);
      if (format.charAt(newIndex-1)=='y') year=parseInt(tmpString,10); 
      if (format.charAt(newIndex-1)=='m') month=parseInt(tmpString,10);
      if (format.charAt(newIndex-1)=='d') day=parseInt(tmpString,10);
      if (format.charAt(newIndex-1)=='h') hour=parseInt(tmpString,10);
      if (format.charAt(newIndex-1)=='n') min=parseInt(tmpString,10);
      if (format.charAt(newIndex-1)=='s') sec=parseInt(tmpString,10);
      oldIndex0=newIndex+1;
    } 
    else{
		year=0;
	}	
  };
  var monthDays = new montharr(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
  if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0))  monthDays[1] = 29;
  if (month<1 || month>12  || isNaN(month)) dateString=''
  else if (day<1 || day>monthDays[month-1] || isNaN(day)) dateString=''
  else if (year<1  || isNaN(year)) dateString=''
  else if (hour<0 || hour>23 || isNaN(hour)) dateString=''
  else if (min<0 || min>59 || isNaN(min)) dateString=''
  else if (sec<0 || sec>59 || isNaN(sec)) dateString=''
  return dateString;
}

