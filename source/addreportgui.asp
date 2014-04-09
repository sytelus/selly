<!-- #INCLUDE FILE = "checklogin.inc" -->
<!-- #INCLUDE FILE = "pagevariables.inc" -->

<% 
	msPageName="add_report"
	msPageTitle = "Add Report"
	msPageHeading = "Add New Report"
	mbShowStatus = True
	msWindowCaption = "Add New Report"
	msWindowWidth = "0%"
	mbShowCloseButton = True
	maPageMenu = Array("home","logout","find_patient","report_list", "external_report_list","help")		
%>

<!-- #INCLUDE FILE = "pageupperpart.inc" -->
		
	<!-- #INCLUDE FILE="winupperpart.inc" -->
		<TABLE BGCOLOR="#ffffca">
		<FORM ACTION="addreportresult.asp" METHOD="post">
		<TR>
		</TR>
		</TABLE>
				<TABLE WIDTH="100%" BGCOLOR="#66b3ff">
  
  <TR>
    <TD><STRONG><FONT FACE="Arial" SIZE="2">Report 
      ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></STRONG></TD>
    <TD><FONT FACE="Arial" SIZE="1"><INPUT NAME="ReportId"></FONT></TD></TR>
  <TR>
    <TD><STRONG><FONT FACE="Arial" SIZE="2">Heading:</FONT></STRONG></TD>
    <TD><FONT FACE="Arial" SIZE="1"><INPUT NAME="heading"></FONT></TD></TR><TR>
					<TD><STRONG><FONT FACE="Arial" SIZE="2">Abstract:</FONT></STRONG></TD>
					<TD><FONT FACE="Arial" SIZE="1"><INPUT NAME="abstract"></FONT></TD>
				</TR>
				</TABLE></TR>
		<TR>
			<TD>
				<TABLE WIDTH="100%" BGCOLOR="#ffffca">
				<TR><TD COLSPAN="2" BGCOLOR="gray"><FONT FACE="Arial" SIZE="3" COLOR="white"><B>Complaint</B></FONT></TD></TR>
				<TR>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ff8000"><FONT FACE="Arial" SIZE="2"><B>Type:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </B></FONT></TD><TD BGCOLOR="#ffff62" BORDERCOLOR="#ff8000"><INPUT NAME="complaint_type"></TD></TR>
				<TR>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#88c4ff"><FONT FACE="Arial" SIZE="2"><B>Nature Of Pain: </B></FONT></TD><TD BORDERCOLOR="#88c4ff" BGCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><INPUT NAME="complaint_nature_of_pain"></FONT></TD></TR>
				<TR>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><B>Severity:</B></FONT></TD><TD BORDERCOLOR="#ffff62" BGCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><INPUT NAME="complaint_severity"></FONT></TD></TR>
				<TR>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><B>Duration: </B></FONT></TD><TD BORDERCOLOR="#ffff62" BGCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><INPUT NAME="complaint_duration"></FONT></TD></TR>	
				<TR>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><B>Radiation: </B></FONT></TD><TD BORDERCOLOR="#ffff62" BGCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><INPUT NAME="complaint_radiation"></FONT></TD></TR>	
				<TR>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><B>Notes:</B></FONT></TD><TD BORDERCOLOR="#ffff62" BGCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><INPUT NAME="complaint_notes"></FONT></TD></TR>	
				</TABLE>			
			</TD>
		</TR>
		<TR><TD><HR ALIGN="center" SIZE="2" WIDTH="100%"></TD></TR>
		<TR>
			<TD>
				<TABLE WIDTH="100%" BGCOLOR="#ffffca">
				<TR><TD COLSPAN="2" BGCOLOR="gray"><FONT FACE="Arial" SIZE="3" COLOR="white"><B>Symptom</B></FONT></TD></TR>
        <TR>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><B>Symptoms1 Description: </B></FONT></TD>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><INPUT NAME="symptomt_description1"></TD></TR>
				<TR>
					<TD BORDERCOLOR="#ffff62" BGCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><B><FONT FACE="Arial" SIZE="2"><B>Symptoms2 </B></FONT>Description: </B></FONT></TD>
					<TD BORDERCOLOR="#ffff62" BGCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><INPUT NAME="symptomt_description2"></FONT></TD>
				</TR>
				</TABLE>			
			</TD>
		</TR>
		<TR><TD><HR ALIGN="center" SIZE="2" WIDTH="100%"></TD></TR>
		<TR>
			<TD>
				<TABLE WIDTH="100%" BGCOLOR="#ffffca">
				<TR><TD COLSPAN="2" BGCOLOR="gray"><FONT FACE="Arial" SIZE="3" COLOR="white"><B>Examination</B></FONT></TD></TR>
        <TR>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><B>Type:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </B></FONT></TD>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><INPUT NAME="examinations_type"></FONT></TD></TR>
        <TR>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><B>Result: </B></FONT></TD>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><INPUT NAME="examinations_result"></FONT></TD></TR>
        <TR>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><B>Exhibit: </B></FONT></TD>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><INPUT NAME="examinations_exibit"></FONT></TD></TR>
        <TR>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><B>Notes: </B></FONT></TD>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><INPUT NAME="examinations_notes"></FONT></TD></TR>
				</TABLE>			
			</TD>
		</TR>
		<TR><TD><HR ALIGN="center" SIZE="2" WIDTH="100%"></TD></TR>
		<TR>
			<TD>
				<TABLE WIDTH="100%" BGCOLOR="#ffffca">
				<TR><TD COLSPAN="2" BGCOLOR="gray"><FONT FACE="Arial" SIZE="3" COLOR="white"><B>Action Taken: </B></FONT></TD></TR>
		        <TR>
		          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><B>Notes:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </B></FONT></TD>
		          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><INPUT NAME="action_taken"></TD></TR>
				</TABLE>			
			</TD>
		</TR>
		<TR><TD><HR ALIGN="center" SIZE="2" WIDTH="100%"></TD></TR>
		<TR>
			<TD>
				<TABLE WIDTH="100%" BGCOLOR="#ffffca">
				<TR><TD COLSPAN="2" BGCOLOR="gray"><FONT FACE="Arial" SIZE="3" COLOR="white"><B>Exhibit</B></FONT></TD></TR>
        <TR>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><B>Media:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            &nbsp;&nbsp;&nbsp;&nbsp; 
            </B></FONT></TD>
          <TD BGCOLOR="#ffff62" BORDERCOLOR="#ffff62"><INPUT NAME="exibits_media"></TD></TR>
				<TR>
					<TD BORDERCOLOR="#ffff62" BGCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><B>Type: </B></FONT></TD>
					<TD BORDERCOLOR="#ffff62" BGCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2">
        				  <SELECT name=exibits_type> <OPTION selected 
						  value=1>Image (JPG)</OPTION><OPTION value=2>Image 
						  (GIF)</OPTION><OPTION value=3>Video (AVI)</OPTION><OPTION value=4>Sound 
						  (WAV)</OPTION><OPTION value=5>Other (MP3, RA, MOV, etc)</OPTION></SELECT>
					</FONT></TD>
				</TR>
				<TR>
					<TD BORDERCOLOR="#ffff62" BGCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><B>Notes: </B></FONT></TD>
					<TD BORDERCOLOR="#ffff62" BGCOLOR="#ffff62"><FONT FACE="Arial" SIZE="2"><INPUT NAME="exibits_notes"></FONT></TD>
				</TR>
				</TABLE>			
	      </TD>
		</TR>
		<TR><TD><HR ALIGN="center" SIZE="2" WIDTH="100%"></TD></TR>
        <TR>
          <TD ALIGN="RIGHT" BORDERCOLOR="#FFFF62" BGCOLOR1="#FFFF62"><FONT FACE="Arial" SIZE="2">
			<INPUT TYPE="submit" VALUE="Save Report" ALIGN="right">
          </FONT></TD>
		</TR></FORM></TABLE>
	<!-- #INCLUDE FILE="winlowerpart.inc" -->
	<BR><BR><BR><BR>


<!-- #INCLUDE FILE="pagelowerpart.inc" -->