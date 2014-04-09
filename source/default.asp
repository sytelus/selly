<% Option Explicit %>

<!-- #INCLUDE FILE = "pagevariables.inc" -->
<!-- #INCLUDE FILE="sessioninit.inc" -->

<% Call InitSession() %>

<% 
	msPageName="home"
	msPageTitle = "Home"
	msPageHeading = "Welcome"
	mbShowStatus = False
	maPageMenu = Array("home","login","help")
%>


<!-- #INCLUDE FILE = "pageupperpart.inc" -->

			<TABLE BORDER="0" ALIGN="CENTER" VALIGN="TOP">
			<TR><TD ALIGN="LEFT" VALIGN="TOP"><FONT FACE="Arial" SIZE="-1"><FONT FACE="Arial" SIZE="5" COLOR="#FF8000"><B><I>W</I></B></FONT>elcome to the <% = Application("HCF_Name") %> system. This site features full <B><FONT FACE="" COLOR="Navy">multimedia</FONT></B>  patient record capabilities including images, sound recordings or even captured movies.<BR>
			Use the Help menu available on each page to view help related to the perticular page.<BR>
			<BR>
			This site also features <FONT FACE="" COLOR="Navy"><B>distributed database access</B></FONT> stored on other web servers acrosss the Internet by the use of server side XML. You can search the patient records stored on servers of other health care facilities as well as view it regarless of server's physical location, operating system or internal database implementation.<BR>
			<BR>
	     	This site is fully <FONT FACE="" COLOR="Navy"><B>browser and platform independnt</B></FONT>. However if you are using Microsoft Internet Explorer 5.0 or higher you can view extra special effects.			</FONT></TD></TR>
			<TR><TD><BR></TD></TR>			
			<TR><TD><HR></TD></TR>
			<TR><TD>&nbsp;</TD></TR>
			<TR><TD><BR></TD></TR>
			<TR><TD ALIGN="CENTER" VALIGN="TOP"><A HREF="login.asp"><IMG ALIGN="MIDDLE" SRC="login.jpg" TITLE="Login to the system" WIDTH=109 HEIGHT=41 BORDER=0 ALT=""></A></TD></TR>
			</TABLE>
	
	<BR><BR><BR><BR>


<!-- #INCLUDE FILE="pagelowerpart.inc" -->