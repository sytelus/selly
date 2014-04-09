<TR><TD COLSPAN="3" VALIGN="BOTTOM">
	<BR>
	<% If mbShowStatus = True Then %>
		<FONT FACE="ARIAL" SIZE="-1">
		<TABLE WIDTH="100%" BORDER="0" BORDERCOLORLIGHT="#FF8040" BORDERCOLORDARK="#FF8000">
		<TR BGCOLOR="#66CDFF">
		<TD>User ID</TD><TD>User Name</TD><TD>User Type</TD><TD>Patient</TD><TD>Time</TD>
		</TR>
		<TR BGCOLOR="#FFFFCE">
		<TD><% = Session("UserID") %></TD><TD><% = Session("UserName") %></TD><TD><% = Session("UserTypeName") %></TD><TD><% = Session("NHS_ID") %></TD><TD><% = FormateDateTimeX(Now,True,True) %></TD>
		</TR>
		</TABLE>
		</FONT>
	<% End If %>
</TD></TR>
