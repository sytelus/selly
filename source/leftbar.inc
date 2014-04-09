<TD WIDTH="15%" ALIGN="LEFT" VALIGN="TOP" BGCOLOR="Silver">
<TABLE WIDTH="100%" BORDER="1" VALIGN="TOP" HEIGHT="100%">
<TR><TD HEIGHT="0%" ALIGN="CENTER" VALIGN="TOP" NOWRAP BGCOLOR="Blue"><FONT FACE="MS Sans Serif" SIZE="-1" COLOR="White">Menu</FONT></TD></TR>
<TR><TD HEIGHT="100%" ALIGN="LEFT" VALIGN="TOP">
	<BR>
	<FONT FACE="Arial" SIZE="2" COLOR="Blue">
	<B>
		<% 
			dim sMenuName, vaMenuProperties, sMenuURL, sMenuCaption,sMenuTooltip, sMenuHTML
			For Each sMenuName In maPageMenu
		%>
		<span class="wordsglow">		
		<%
				vaMenuProperties = Session("Menus").Item(sMenuName)
				sMenuURL = vaMenuProperties(0)
				If sMenuName = "help" Then
					sMenuURL = sMenuURL & "?topic=" & msPageName
				End If				
				sMenuCaption = vaMenuProperties(1)
				sMenuTooltip = vaMenuProperties(2) 
				sMenuHTML = "<A Class=""" & "NoLine""" & " HREF=""" & sMenuURL & """" & " TITLE=""" & sMenuTooltip & """" & " CLASS=ActiveLink" & "> &nbsp;&nbsp;&nbsp;&nbsp;" & sMenuCaption & "&nbsp; </A>"
				Response.write sMenuHTML
		%>
		</span> <BR><BR>
		<%
			Next		
		%>
	</B>
	</FONT>
</TD></TR>
</TABLE>
</TD>
<TD WIDTH="%10"><FONT FACE="Arial" SIZE="-3" COLOR="Red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></TD>