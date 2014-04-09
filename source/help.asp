<% Option Explicit %>

<!-- #INCLUDE FILE = "utils.inc" -->
<!-- #INCLUDE FILE = "pagevariables.inc" -->
<!-- #INCLUDE FILE="sessioninit.inc" -->

<% Call InitSession() %>

<% 
	msPageTitle = "Help"
	msPageHeading = "Help"
	msWindowCaption = "Help"
	mbShowStatus = False
	maPageMenu = Array("home")
%>


<!-- #INCLUDE FILE = "pageupperpart.inc" -->
	
	<!-- #INCLUDE FILE="winupperpart.inc" -->
		<% 
			Dim sTopic, sPageCaption, sHelptext, sBackURL
			sTopic = AlternateIfBlank(Request.QueryString("topic"),"")
			If sTopic <> "" Then
				sPageCaption = Session("Menus").Item(sTopic)(1)
				sHelpText = Session("Menus").Item(sTopic)(2)
				sBackURL = Session("Menus").Item(sTopic)(0)
		%>
				<B><FONT FACE="Verdana" SIZE="2" COLOR="Blue"><% =sPageCaption %> :</FONT></B> <BR>
				<BR>
				<FONT FACE="Verdana" SIZE="-1" ><% =sHelpText  %></FONT></B>
		<%
			Else
		%>
				This is <% =Application("HCF_Name") %> Help System. Go to any page and click on the page to view the help menu for that page.
		<%
			End If
		%>
		<BR>
		<HR>
		<%
			If Not IsBlank(sBackURL) Then
		%>
			<FORM  ACTION="<% =sBackURL %>" Method="POST">
				<CENTER><INPUT TYPE="Submit" VALUE="Back to <% =(" " & sPageCaption) & """" %>></CENTER>				
			</FORM>
		<%
			End If
		%>	
		
	<!-- #INCLUDE FILE="winlowerpart.inc" -->
	<BR><BR><BR><BR><BR><BR>	

	
<!-- #INCLUDE FILE="pagelowerpart.inc" -->