<% 
	'Check If user has logged on. If not, go to login page
	If Session("UserID") = "" Then
		Response.Redirect "login.asp?reason=2"
	End If
%>