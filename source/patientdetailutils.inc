<SCRIPT LANGUAGE="VBSCRIPT" RUNAT="SERVER">
	Function GetGenderName(vsGenderChar)
		If IsBlank(vsGenderChar) Then
			GetGenderName = "Not Available"
		Else
			If vsGenderChar = "M" Then
				GetGenderName = "Male"
			ElseIf  vsGenderChar = "F" Then
				GetGenderName = "Female"
			Else
				GetGenderName = "Unknown : " & vsGenderChar
			End If
		End If
	End Function
	
	Function GetFullName(vsTitle, vsSurname, vsForename)
		GetFullName = AlternateIfBlank(vsTitle,"") & AlternateIfBlank(vsSurname,"") & " " & AlternateIfBlank(vsForename,"")
	End Function
	
	Function GetFullAddress(vsLine1, vsLine2, vsCity, vsPostcode)
		If Not IsBlank(vsLine1) Then
			GetFullAddress = vsLine1 & "<BR>"
		End If
		If Not IsBlank(vsLine2) Then
			GetFullAddress = GetFullAddress & vsLine2 & "<BR>"
		End If
		If Not IsBlank(vsCity) Then
			GetFullAddress = GetFullAddress & vsCity & "<BR>"
		End If
		If Not IsBlank(vsPostcode) Then
			GetFullAddress = GetFullAddress & vsPostcode
		End If
	End Function
	
	Function GetTelephoneDetail(vsHomeNumber, vsOfficeNumber, vsMobileNumber)
		If Not IsBlank(vsHomeNumber) Then
			GetTelephoneDetail = "<B  CLASS=Bolder>Home:</B>" & vsHomeNumber & " "
		End If
		If Not IsBlank(vsOfficeNumber) Then
			GetTelephoneDetail = GetTelephoneDetail & "<B  CLASS=Bolder>Off:</B>" & vsOfficeNumber & " "
		End If
		If Not IsBlank(vsMobileNumber) Then
			GetTelephoneDetail = GetTelephoneDetail & "<B  CLASS=Bolder>Mobile:</B>" & vsMobileNumber 
		End If
	End Function
</SCRIPT>