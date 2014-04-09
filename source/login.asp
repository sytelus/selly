<% Option Explicit %>

<!-- #INCLUDE FILE = "dblib.inc" -->
<!-- #INCLUDE FILE = "utils.inc" --> 
<!-- #INCLUDE FILE = "pagevariables.inc" -->
<!-- #INCLUDE FILE="sessioninit.inc" -->

<% Call InitSession() %>

<% 
	msPageName="login"
	msPageTitle = "System Login"
	msPageHeading = "System Login"
	mbShowStatus = False
	msWindowCaption = "System Login"
	msWindowWidth = "0%"
	mbShowCloseButton = True
	maPageMenu = Array("home","help")
%>

<% 

	Const mlREASON_LOGIN_FAILED = "1"		'User entered incorrect login info
	Const mlREASON_DIRECT_ACCESS = "2"	'Secure Page in site was accessed without doing login first

	'Only if this page was posted from form
	If Request.QueryString("reason") = mlREASON_LOGIN_FAILED Then

			Session("UserID") = ""
			Session("UserName") = ""
			Session("UserType") = ""
			Session("UserTypeName") = ""
	
			Dim sSQL, rsLogin, bLoginFailed
			sSQL = "SELECT PERSON.*, USER_TYPE.NAME AS USER_TYPE_NAME FROM PERSON, USER_TYPE WHERE "
			sSQL = sSQL & "USER_ID = '" & GetSQLSafeString(Request("UserID")) & "' AND PASSWORD = '" & GetSQLSafeString(Request("Password")) & "'"
			sSQL = sSQL & " " & " AND PERSON.TYPE_ID = USER_TYPE.ID"
			
			OpenRecordset sSQL, rsLogin, True
			If IsRecordsetEmpty(rsLogin) = True Then
				Session.Abandon		'Login failed, clear all state
			Else
				Session("UserID") = rsLogin("USER_ID")
				Session("UserName") = NullCheckedVal(rsLogin("TITLE"),"") & " " & NullCheckedVal(rsLogin("FORENAME"),"") & " " & NullCheckedVal(rsLogin("SURNAME"),"")
				Session("UserType") = rsLogin("TYPE_ID")
				Session("UserTypeName") = rsLogin("USER_TYPE_NAME")
				Response.Redirect "patientsearch.asp"
			End If
	End If
%>

<!-- #INCLUDE FILE = "pageupperpart.inc" -->


	<!-- If execution came here it means login was failed -->
	<% 
		If Request.QueryString("reason") = mlREASON_LOGIN_FAILED Then
	%>
	<CENTER><FONT FACE="Arial" COLOR="Red">Login Failed: </FONT>
			<FONT FACE="Arial" COLOR="Maroon">You have entered invalid User ID or Password. Please try again.</FONT><BR>
			<BR><BR>
	</CENTER>	
	<% 
		ElseIf Request.QueryString("reason") = mlREASON_DIRECT_ACCESS Then
	%>
	<CENTER><FONT FACE="Arial" COLOR="Red">Please Login: </FONT>
			<FONT FACE="Arial" COLOR="Maroon">Before you can access secured pages on this site you must do the System Login.</FONT><BR>
			<BR><BR>
	</CENTER>	
	<%
		End If
	%>


		
	<!-- #INCLUDE FILE="winupperpart.inc" -->

		<FORM ACTION="login.asp?reason=<% = mlREASON_LOGIN_FAILED %>" METHOD="POST">
			<TR><TD>User Id:</TD><TD><INPUT TYPE="Text" NAME="UserId" VALUE="<% =request("UserID") %>" MAXLENGTH="12"></TD></TR>
			<TR><TD>Password:</TD><TD><INPUT TYPE="Password" NAME="Password" MAXLENGTH="12"></TD></TR>
			<TR><TD COLSPAN="2" ALIGN="RIGHT"><HR><INPUT TYPE="Submit" VALUE="Login"></TD></TR>
		</FORM>	

	<!-- #INCLUDE FILE="winlowerpart.inc" -->
	<BR><BR><BR><BR><BR><BR>	


	
<!-- #INCLUDE FILE="pagelowerpart.inc" -->