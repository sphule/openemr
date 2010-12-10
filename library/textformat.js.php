<script language="javascript">
// Copyright (C) 2005 Rod Roark <rod@sunsetsystems.com>
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.

// Onkeyup handler for dates.  Converts dates that are keyed in to a
// consistent format, and helps to reduce typing errors.
//
function datekeyup(e, defcc) {
 while(true) {
  var delim = '';
  var arr = new Array(0, 0, 0);
  var ix = 0;
  var v = e.value;

  // Build an array to facilitate error checking.
  for (var i = 0; i < v.length; ++i) {
   var c = v.charAt(i);
   if (c >= '0' && c <= '9') {
    ++arr[ix];
   } else if (c == '-' || c == '/') {
    arr[++ix] = 0;
   } else {
    e.value = v.substring(0, i);
    return;
   }
  }

  // We have finished scanning the string. If there is a problem,
  // drop the last character and repeat the loop.
  if ((ix > 2) ||
      (ix > 1 && arr[1] == 0) ||
      (ix > 0 && arr[0] == 0) ||
      (arr[0] > 8) ||
      (ix > 0 && arr[0] > 2 && (arr[0] != 4 || arr[1] > 2 || arr[2] > 2)) ||
      (arr[2] > 2 && (arr[2] > 4 || arr[0] > 2 || arr[1] > 2)))
  {
   e.value = v.substring(0, v.length - 1);
  } else {
   break;
  }
 }

 if (arr[2] == 4 && defcc == '1') { // mm/dd/yyyy
  e.value  = v.substring(arr[0] + arr[1] + 2) + '-'; // year
  if (arr[0] == 1) e.value += '0';
  e.value += v.substring(0, arr[0]) + '-'; // month
  if (arr[1] == 1) e.value += '0';
  e.value += v.substring(arr[0] + 1, arr[0] + 1 + arr[1]); // day
 }
 else if (arr[2] == 4) { // dd-mm-yyyy
  e.value  = v.substring(arr[0] + arr[1] + 2) + '-'; // year
  if (arr[1] == 1) e.value += '0';
  e.value += v.substring(arr[0] + 1, arr[0] + 1 + arr[1]) + '-'; // month
  if (arr[0] == 1) e.value += '0';
  e.value += v.substring(0, arr[0]); // day
 }
 else if (arr[0] == 4 && arr[2] > 0) { // yyyy-mm-dd
  e.value  = v.substring(0, arr[0]) + '-'; // year
  if (arr[1] == 1) e.value += '0';
  e.value += v.substring(arr[0] + 1, arr[0] + 1 + arr[1]) + '-'; // month
  e.value += v.substring(arr[0] + arr[1] + 2); // day (may be 1 digit)
 }
 else if (arr[0] == 8 && defcc == '1') { // yyyymmdd
  e.value  = v.substring(0, 4) + '-'; // year
  e.value += v.substring(4, 6) + '-'; // month
  e.value += v.substring(6); // day
 }
 else if (arr[0] == 8) { // ddmmyyyy
  e.value  = v.substring(4) + '-'; // year
  e.value += v.substring(2, 4) + '-'; // month
  e.value += v.substring(0, 2); // day
 }
}

// Onblur handler to avoid incomplete entry of dates.
//
function dateblur(e, defcc) {
 var v = e.value;
 if (v.length == 0) return;

 var arr = new Array(0, 0, 0);
 var ix = 0;
 for (var i = 0; i < v.length; ++i) {
  var c = v.charAt(i);
  if (c >= '0' && c <= '9') {
   ++arr[ix];
  } else if (c == '-' || c == '/') {
   arr[++ix] = 0;
  } else {
   alert("<?php xl('Invalid character in date!','e');?>");
   return;
  }
 }

 if (ix != 2 || arr[0] != 4 || arr[1] != 2 || arr[2] < 1) {
  if (confirm("<?php xl('Date entry is incomplete! Try again?','e');?>")) {
   e.focus();
  }
  else {
   e.value = '';
  return;
  }
 }

 if (arr[2] == 1) {
  e.value = v.substring(0, 8) + '0' + v.substring(8);
  v = e.value;
 }

 // don't allow setting dates in past
 if (future_only == true) {
	var now = new Date();
	var month = now.getMonth() + 1;
	var day = now.getDate();
	var year = now.getYear();
	if(year < 2000) { year = year + 1900; }

	var today = parseInt(year*10000 + month*100 + day);
	var cdate = parseInt(v.substring(0,4)*10000 + v.substring(5,7)*100 + v.substring(8,10)*1);
	if(today > cdate) {
		// alert("You cannot schedule a date before today:" + today + " > " +
		// cdate + ".");
		alert("<?php xl('You cannot schedule a date in the past.','e');?>");
		if(month < 10) {
			e.value = year + "-" + "0" + month + "-" + day;
		} else {
			e.value = year + "-" + month + "-" + day;
		}
		e.focus();
	}
 }
}

// Private subroutine for US phone number formatting.
function usphone(v) 
{	
	if (v.length > 0 && v.charAt(0) == '-') v = v.substring(1);
	
	if(isAlphabet(v) || !isAllowedChars(v))
	{
		alert("<?php xl('Please enter digits only.','e');?>");	
		v = v.substring(0, (v.length-1));
	}
	else
	{
		while(!isNumeric(v))
		{				
			v = v.replace('(','');
			v = v.replace(')','');
			v = v.replace('-','');		
		}
		
		var oldlen = v.length;
		 
		for (var i = 0; i < v.length; ++i) 
		{
			var c = v.charAt(i);
			
			if (c < '0' || c > '9') 
			{	 
				v = v.substring(0, i) + v.substring(i + 1);
				--i;
			}
		}
		 
		if (oldlen > 3 && v.length >= 3) 
		{
			v = '('+v.substring(0, 3) + ')' + v.substring(3);
			
			if (oldlen > 6 && v.length >= 8) 			
			{
				v = v.substring(0, 8) + '-' + v.substring(8);
				
				if (v.length > 13) 
				{
					v = v.substring(0, 13);
				}   
			}
		}						
	}	
	
	return v;
}

// Private subroutine for non-US phone number formatting.
function nonusphone(v) {
 for (var i = 0; i < v.length; ++i) {
  var c = v.charAt(i);
  if (c < '0' || c > '9') {
   v = v.substring(0, i) + v.substring(i + 1);
   --i;
  }
 }
 return v;
}

// Telephone country codes that are exactly 2 digits.
var twodigitccs = '/20/30/31/32/33/34/36/39/40/41/43/44/45/46/47/48/49/51/52/53/54/55/56/57/58/60/61/62/63/64/65/66/81/82/84/86/90/91/92/93/94/95/98/';

// Onkeyup handler for phone numbers. Helps to ensure a consistent
// format and to reduce typing errors. defcc is the default telephone
// country code as a string.
//
function postalcodekeyup(e)
{

	if(e.value.length !=0)
		{
			var re5digit= /^\d{5}$/ ;
            var variable = e.value;					
					
			if(variable.search(re5digit)==-1) 
			{
				alert("<?php xl('Required field missing:Please enter a valid 5 digit number inside the postal_code');?>");
				return ;
			 }
		}
}

function phonekeyup(e, defcc) {	
 var v = e.value;
 var oldlen = v.length;

 // Deal with international formatting.
 if (v.length > 0 && v.charAt(0) == '+') {
  var cc = '';
  for (var i = 1; i < v.length; ++i) {
   var c = v.charAt(i);
   if (c < '0' || c > '9') {
    v = v.substring(0, i) + v.substring(i + i);
    --i;
    continue;
   }
   cc += c;
   if (i == 1 && oldlen > 2) {
    if (cc == '1') { // USA
     e.value = '+1-' + usphone(v.substring(2));
     return;
    }
    if (cc == '7') { // USSR
     e.value = '+7-' + nonusphone(v.substring(2));
     return;
    }
   }
   else if (i == 2 && oldlen > 3) {
    if (twodigitccs.indexOf(cc) >= 0) {
     e.value = v.substring(0, 3) + '-' + nonusphone(v.substring(3));
     return;
    }
   }
   else if (i == 3 && oldlen > 4) {
    e.value = v.substring(0, 4) + '-' + nonusphone(v.substring(4));
    return;
   }
  }
  e.value = v;
  return;
 }
 
 if (defcc == '1') {
  e.value = usphone(v);
 } else {
  e.value = nonusphone(v);
 }

 return;
}

// function to check the length of a phone number field, it would not allow
// number larger than 10 characters..
function chkLength(obj)
{
	var v = obj.value;
		
	if(v.length > 13)
	{
		alert('<?php xl('You can not enter more digits as the maximum length allowed is 10 digits.','e');?>');
		obj.value = obj.value.substring(0, 13);
		phonekeyup(obj, mypcc);		
		return false;
	}
	
	phonekeyup(obj, mypcc);
		
}

function isAllowedChars(sText)
{
	var ValidChars = ")(-0123456789";
    var IsAllow=true;
    var Char;
    var len = sText.length;
    
    if(!isNumeric(sText))
    {	
    	for (var i = 0; i < len && IsAllow == true; i++) 
    	{ 
    		Char = sText.charAt(i);     		
    		if (ValidChars.indexOf(Char) == -1) 
    		{
    			IsAllow = false;    			
    		}
    	}
    }	
    
   	return IsAllow;	
}

function isAlphabet(sText)
{
	var ValidChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var IsAlpha=false;
    var Char;
    var len = sText.length;
     
    for (var i = 0; i < len && IsAlpha == false; i++) 
	{ 
	   	Char = sText.charAt(i); 
	   	
	   	if (ValidChars.indexOf(Char) != -1) 
	    {
	   		IsAlpha = true;	   		
	    }
	}
   
   	return IsAlpha;
}

function isNumeric(sText)
{
   	var ValidChars = "0123456789";
    var IsNumber=true;
    var Char;
    var len = sText.length;
 
	for (var i = 0; i < len && IsNumber == true; i++) 
   	{ 
    	Char = sText.charAt(i); 
      	if (ValidChars.indexOf(Char) == -1) 
        {
        	IsNumber = false;
        }
     }

   	return IsNumber;   
}

function validateSSN(ssnObj)
{	
	if(SSNValidation(ssnObj))
	{
		var ssnPart = '';
		var ssnPart2 = '';
		var ssnPart3 = '';
		var ssnValue = ssnObj.value;
		
		while(!isNumeric(ssnValue))
		{
			ssnValue = ssnValue.replace("-", "");
		}
		
		if(ssnValue.length > 9 && isNumeric(ssnValue))
		{
			alert('<?php xl('S.S. can not be any more thssan 9 digits.','e'); ?>');
			ssnValue  = ssnValue.substring(0, 9);				
		}	
	
		if(ssnValue.length >= 3 && isNumeric(ssnValue))
		{
			ssnPart = ssnValue.substring(0, 3);
	
			if(ssnValue.length > 3)
		    {    
		    	ssnPart2 = ssnValue.substring(3, 5);
		    	ssnPart3 = ssnValue.substring(5, ssnValue.length);
		    }
			else
				ssnPart2 = ssnValue.substring(4, ssnValue.length);		
		}       
		
		// alert('ssnPart = '+ssnPart+', ssnPart2 = '+ssnPart2+', ssnPart3 =
		// '+ssnPart3);
	
		if(ssnPart!='')
			ssnObj.value = ssnPart + "-";
		if(ssnPart2!='')
			ssnObj.value += ssnPart2 + "-";
		if(ssnPart3!='')
			ssnObj.value +=	ssnPart3;
	}
}

function SSNValidation(ssnObj) {
	var ssn = ssnObj.value;
	var matchArr = ssn.match(/^(\d{3})-?\d{2}-?\d{4}$/);
	var numDashes = ssn.split('-').length - 1;
	
	if (matchArr == null || numDashes == 1) {
		alert('<?php xl('Invalid SSN. Must be 9 digits or in the form NNN-NN-NNNN.','e'); ?>');		
		ssnObj.focus();
		return false;
	}
	else if (parseInt(matchArr[1],10)==0) {
		alert("<?php xl("Invalid SSN: SSN's can't start with 000.",'e'); ?>");
		ssnObj.focus();
		return false;
	}

	return true;	
}

function stripHtmlTagsFromInput(frmObj)
{
	var len = frmObj.elements.length;
	// alert(len);  return false;
	
	if(len > 0)
	{
	    for(var i=0; i<len; i++)		
	    {
		    if(frmObj.elements[i].type=='text' || frmObj.elements[i].type=='textarea')
		    {
			    var str = frmObj.elements[i].value;
			    var matchArr = str.match(/[<>=]/g);

			    if(matchArr != null) 
			    {
				    alert('<?php xl('Invalid input. No HTML tags or <, >, = allowed.','e'); ?>');		
				    frmObj.elements[i].focus();
				    return false;
			    }
		    }		
	    }	
	}

   	return true;
}

// To show /Hide the div/span [function argument - div/span id]

function showHide(id, more)
{
	var spanstyle = new String();

	spanstyle = document.getElementById(id).style.visibility;
	
	
	if(spanstyle.toLowerCase()=="visible" || spanstyle == "")
	{
		document.getElementById(id).style.visibility = "hidden";
		document.getElementById(id).style.display = "none";
	}
	else
	{
		document.getElementById(id).style.visibility = "visible";
		document.getElementById(id).style.display = "inline";
	}

	if(more){
		moreopenspanstyle = document.getElementById("open").style.visibility;
		moreclosespanstyle = document.getElementById("close").style.visibility;
		
		if(moreopenspanstyle.toLowerCase()=="visible" || spanstyle == "")
		{
			document.getElementById('open').style.visibility = "hidden";
			document.getElementById('open').style.display = "none";
			document.getElementById('close').style.visibility = "visible";
			document.getElementById('close').style.display = "inline";
		}
		else
		{
			document.getElementById('open').style.visibility = "visible";
			document.getElementById('open').style.display = "inline";
			document.getElementById('close').style.visibility = "hidden";
			document.getElementById('close').style.display = "none";
		}

	}	
}
</script>