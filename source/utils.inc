<SCRIPT LANGUAGE="VBSCRIPT" RUNAT="SERVER">

Function GetSQLSafeString(vsString)
	GetSQLSafeString = Replace(vsString,"'","''")
End Function

Function FormateDateTimeX(vdtDateTime, vboolFormateDate, vboolFormateTime)
	FormateDateTimeX = "Date not avail"
	If Not IsNull(vdtDateTime) Then
		If vboolFormateDate = True Then
			FormateDateTimeX = Day(vdtDateTime) & " " & MonthName(Month(vdtDateTime), True) & " " & Year(vdtDateTime)
		End If
		
		If vboolFormateTime = True Then
			FormateDateTimeX = FormateDateTimeX & " " & Hour(vdtDateTime) & ":" & Minute(vdtDateTime)
		End If
	End If
End Function

Function IsBlank(vvValue)
	If Not IsNull(vvValue) Then
		If vvValue <> "" Then
			IsBlank = False
		Else
			IsBlank = True
		End If
	Else
		IsBlank = True
	End If
End Function

Function AlternateIfBlank(vvValue, vvAlternate)
	If (Not IsNull(vvValue)) And (Not IsEmpty(vvValue)) Then
		If vvValue <> "" Then
			AlternateIfBlank = CStr(vvValue)
		Else
			AlternateIfBlank  = vvAlternate
		End If
	Else
		AlternateIfBlank  = CStr(vvAlternate)	
	End If
End Function

Function GetCommaConcatedStr(vaValuesToConcate)
	Dim vValue, sReturn
	sReturn = ""
	For Each vValue In vaValuesToConcate
		If not IsBlank(vValue) Then
			If sReturn <> "" Then
				sReturn = sReturn & ", "
			End If		
			sReturn = sReturn & vValue
		End If
	Next
	GetCommaConcatedStr = sReturn
End Function


</SCRIPT>