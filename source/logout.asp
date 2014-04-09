<% Option Explicit %>

<!-- #INCLUDE FILE = "pagevariables.inc" -->
<!-- #INCLUDE FILE = "sessioninit.inc" -->

<% 
	msPageName="logout"
	msPageTitle = "Logout"
	msWindowCaption = "Session Ended"
	msPageHeading = "Thank You"
	mbShowStatus = False
	msWindowWidth = "65%"
	mbShowCloseButton = False
	maPageMenu = Array("home","login","help")
%>


<% 
	Session.Abandon
	Call InitSession()
%>

<!-- #INCLUDE FILE = "pageupperpart.inc" -->

	<FORM ACTION="default.asp" METHOD="POST">
	<!-- #INCLUDE FILE="winupperpart.inc" -->

			<TABLE ALIGN="CENTER" VALIGN="MIDDLE" border=0>
			<TR><TD ALIGN="CENTER" VALIGN="MIDDLE">Thank you for using <% =Application("HCF_Name") %>.</TD></TR>
			<TR><TD>&nbsp;</TD></TR>
			<TR><TD ALIGN="CENTER" VALIGN="BOTTOM"><INPUT TYPE="Submit" VALUE="Home" TITLE="Go to the first page of this site"></TD></TR>
			</TABLE>

	<!-- #INCLUDE FILE="winlowerpart.inc" -->
	</FORM>	
	
	<BR><BR><BR><BR>


<!-- #INCLUDE FILE="pagelowerpart.inc" -->