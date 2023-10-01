<%
url_table = request.querystring("table")
url_function = request.querystring("function")
url_doo = request.querystring("doo")
url_goo = request.querystring("goo")
url_item = BeniKoddanArindir(request.querystring("item"))
url_field = request.querystring("field")
url_edit_item =  request.querystring("edit_item")
url_ID = request.querystring("ID")
url_delete = request.querystring("delete")
url_yil = request.querystring("yil")
if len(url_yil)>0 then 
    Select Case url_yil
    'Netsis yıllara göre farklı DB tutuyor, bu menüden seçim yapılabilir.
        Case 2022 Session("currentDB")="db2022"
        Case 2023 Session("currentDB")="db2023"
        Case Else Session("currentDB")="db2023"
        End Select
    else
        if len(Session("currentDB"))>0 then 
        e=2
        else
        Session("currentDB")="db2023"
        end if
    end if
     currentDB=Session("currentDB")
Function g_database_item_types (f_tip)
                    ' accdb data types
                    Select Case f_tip
                         Case 	0	g_g_database_item_types="	adEmpty	 - 	No value	"
                         Case 	2	g_g_database_item_types="	adSmallInt	 - 	A 2-byte signed integer.	"
                         Case 	3	g_g_database_item_types="	adInteger	 - 	A 4-byte signed integer.	"
                         Case 	4	g_g_database_item_types="	adSingle	 - 	A single-precision floating-point value.	"
                         Case 	5	g_g_database_item_types="	adDouble	 - 	A double-precision floating-point value.	"
                         Case 	6	g_g_database_item_types="	adCurrency	 - 	A currency value	"
                         Case 	7	g_g_database_item_types="	adDate	 - 	The number of days since December 30, 1899 + the fraction of a day.	"
                         Case 	8	g_g_database_item_types="	adBSTR	 - 	A null-terminated character string.	"
                         Case 	9	g_g_database_item_types="	adIDispatch	 - 	A pointer to an IDispatch interface on a COM object. Note: Currently not supported by ADO.	"
                         Case 	10	g_g_database_item_types="	adError	 - 	A 32-bit error code	"
                         Case 	11	g_g_database_item_types="	adBoolean	 - 	A boolean value.	"
                         Case 	12	g_g_database_item_types="	adVariant	 - 	An Automation Variant. Note: Currently not supported by ADO.	"
                         Case 	13	g_g_database_item_types="	adIUnknown	 - 	A pointer to an IUnknown interface on a COM object. Note: Currently not supported by ADO.	"
                         Case 	14	g_g_database_item_types="	adDecimal	 - 	An exact numeric value with a fixed precision and scale.	"
                         Case 	16	g_g_database_item_types="	adTinyInt	 - 	A 1-byte signed integer.	"
                         Case 	17	g_database_item_types="	adUnsignedTinyInt	 - 	A 1-byte unsigned integer.	"
                         Case 	18	g_database_item_types="	adUnsignedSmallInt	 - 	A 2-byte unsigned integer.	"
                         Case 	19	g_database_item_types="	adUnsignedInt	 - 	A 4-byte unsigned integer.	"
                         Case 	20	g_database_item_types="	adBigInt	 - 	An 8-byte signed integer.	"
                         Case 	21	g_database_item_types="	adUnsignedBigInt	 - 	An 8-byte unsigned integer.	"
                         Case 	64	g_database_item_types="	adFileTime	 - 	The number of 100-nanosecond intervals since January 1,1601	"
                         Case 	72	g_database_item_types="	adGUID	 - 	A globally unique identifier (GUID	"
                         Case 	128	g_database_item_types="	adBinary	 - 	A binary value.	"
                         Case 	129	g_database_item_types="	adChar	 - 	A string value.	"
                         Case 	130	g_database_item_types="	adWChar	 - 	A null-terminated Unicode character string.	"
                         Case 	131	g_database_item_types="	adNumeric	 - 	An exact numeric value with a fixed precision and scale.	"
                         Case 	132	g_database_item_types="	adUserDefined	 - 	A user-defined variable.	"
                         Case 	133	g_database_item_types="	adDBDate	 - 	A date value (yyyymmdd.	"
                         Case 	134	g_database_item_types="	adDBTime	 - 	A time value (hhmmss.	"
                         Case 	135	g_database_item_types="	adDBTimeStamp	 - 	A date/time stamp (yyyymmddhhmmss plus a fraction in billionths.	"
                         Case 	136	g_database_item_types="	adChapter	 - 	A 4-byte chapter value that identifies rows in a child rowset	"
                         Case 	138	g_database_item_types="	adPropVariant	 - 	An Automation PROPVARIANT.	"
                         Case 	139	g_database_item_types="	adVarNumeric	 - 	A numeric value (Parameter object only.	"
                         Case 	200	g_database_item_types="	adVarChar	 - 	A string value (Parameter object only.	"
                         Case 	201	g_database_item_types="	adLongVarChar	 - 	A long string value.	"
                         Case 	202	g_database_item_types="	adVarWChar	 - 	A null-terminated Unicode character string.	"
                         Case 	203	g_database_item_types="	adLongVarWChar	 - 	A long null-terminated Unicode string value.	"
                         Case 	204	g_database_item_types="	adVarBinary	 - 	A binary value (Parameter object only.	"
                         Case 	205	g_database_item_types="	adLongVarBinary	 - 	A long binary value.	"
                         Case 	"0x2000"	g_database_item_types="	AdArray	 - 	A flag value combined with another data type constant. Indicates an array of that other data type.	"
                         End Select
end function
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'bunu neden yaptığını unuttun
function g_tarihi_formatla2(bunuYaz)  

                    g_tarihi_formatla= (bunuYaz)

end function

'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function g_tarihi_formatla(bunuYaz)
        if IsDate(bunuYaz) then
                    g_tarihi_formatla=year(bunuYaz)&"-"
                    if month(bunuYaz)<10 then g_tarihi_formatla= g_tarihi_formatla & "0"
                    g_tarihi_formatla= g_tarihi_formatla & month(bunuYaz)&"-"
                    if day(bunuYaz)<10 then g_tarihi_formatla= g_tarihi_formatla & "0"
                    g_tarihi_formatla= g_tarihi_formatla & day(bunuYaz)
        else
            g_tarihi_formatla="1900-01-01"
        end if
end function

'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function g_tarihi_saati_formatla(bunuYaz)
        bunuYaz=left(bunuYaz,19)
        if IsDate(bunuYaz) then
                    g_tarihi_saati_formatla=year(bunuYaz)&"-"
                    if month(bunuYaz)<10 then g_tarihi_saati_formatla= g_tarihi_saati_formatla & "0"
                    g_tarihi_saati_formatla= g_tarihi_saati_formatla & month(bunuYaz)&"-"
                    if day(bunuYaz)<10 then g_tarihi_saati_formatla= g_tarihi_saati_formatla & "0"
                    g_tarihi_saati_formatla= g_tarihi_saati_formatla & day(bunuYaz) & "T" & formatdatetime((bunuYaz),4) &":"
                    if second(bunuYaz)<10 then g_tarihi_saati_formatla= g_tarihi_saati_formatla & "0"
                    g_tarihi_saati_formatla= g_tarihi_saati_formatla & second(bunuYaz)
        else
            g_tarihi_saati_formatla="1900-01-01T00:00:00"
        end if
        'Response.Write (bunuyaz&" ? "&g_tarihi_saati_formatla)
end function
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
' g_Function_Options ----------------------------------- '
function g_Function_Options(f_selected,f_table,f_field,f_select_name)
        Set FunctionRecordSet = Server.CreateObject("ADODB.Recordset")

        FunctionSQL = "SELECT * FROM "&f_table&" ORDER BY "&f_table&"_ID ;"
         f_field_ID=f_table&"_ID"
        FunctionRecordSet.Open FunctionSQL, BomConnection
        g_Function_Options="<select name='"&f_select_name&"'>"
        do until FunctionRecordSet.EOF
             g_Function_Options=g_Function_Options & "<option value='" & (FunctionRecordSet(f_field_ID)) & "'"
             if isnumeric(f_selected) then
                   if Cint(f_selected)=FunctionRecordSet(f_field_ID) then g_Function_Options=g_Function_Options & " selected"
             end if
             g_Function_Options=g_Function_Options & ">" & (FunctionRecordSet(f_field)) & "</option>"
            FunctionRecordSet.MoveNext
        loop
        FunctionRecordSet.Close
        Set FunctionRecordSet = Nothing
        g_Function_Options= g_Function_Options&"</select>"
end function
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
' g_Function_Options_il ----------------------------------- '
function g_Function_Options_il(f_selected,f_table,f_field,f_select_name)
        Set FunctionRecordSet = Server.CreateObject("ADODB.Recordset")

        FunctionSQL = "SELECT * FROM "&f_table&" ;"
         f_field_ID=f_table&"_ID"
        FunctionRecordSet.Open FunctionSQL, BomConnection
        g_Function_Options_il="<select onchange='ildegisti()' id='"&f_select_name&"' name='"&f_select_name&"'>"
        g_Function_Options_il=g_Function_Options_il & "<option value='0'> </option>"
        do until FunctionRecordSet.EOF
             g_Function_Options_il=g_Function_Options_il & "<option value='" & (FunctionRecordSet(f_field_ID)) & "'"
             if isnumeric(f_selected) then
                   if Cint(f_selected)=FunctionRecordSet(f_field_ID) then g_Function_Options_il=g_Function_Options_il & " selected"
             end if
             g_Function_Options_il=g_Function_Options_il & ">" & (FunctionRecordSet(f_field)) & "</option>"
            FunctionRecordSet.MoveNext
        loop
        FunctionRecordSet.Close
        Set FunctionRecordSet = Nothing
        g_Function_Options_il= g_Function_Options_il&"</select>"
end function
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
' g_Function_Options_ilce ----------------------------------- '
function g_Function_Options_ilce(f_selected,f_table,f_field,f_select_name,f_select_sehir)
        Set FunctionRecordSet = Server.CreateObject("ADODB.Recordset")
        if isnull(f_select_sehir) then f_select_sehir=0
        FunctionSQL = "SELECT * FROM "&f_table&" "
        FunctionSQL = FunctionSQL & "WHERE ilce_il_ID="&f_select_sehir&" ORDER BY ilce_ilce ;"
         f_field_ID=f_table&"_ID"
        FunctionRecordSet.Open FunctionSQL, BomConnection
        g_Function_Options_ilce="<select id='"&f_select_name&"' name='"&f_select_name&"'>"
        g_Function_Options_ilce=g_Function_Options_ilce & "<option value='0'> </option>"
        do until FunctionRecordSet.EOF
             g_Function_Options_ilce=g_Function_Options_ilce & "<option value='" & (FunctionRecordSet(f_field_ID)) & "'"
             if isnumeric(f_selected) then
                   if Cint(f_selected)=FunctionRecordSet(f_field_ID) then g_Function_Options_ilce=g_Function_Options_ilce & " selected"
             end if
             g_Function_Options_ilce=g_Function_Options_ilce & ">" & (FunctionRecordSet(f_field)) & "</option>"
            FunctionRecordSet.MoveNext
        loop
        FunctionRecordSet.Close
        Set FunctionRecordSet = Nothing
        g_Function_Options_ilce= g_Function_Options_ilce&"</select>"
end function
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
' g_Choose_Options (aranan_ID,tablo,field) ----------------------------------- '
function g_Choose_Options(f_selected,f_table,f_field)
         if f_selected>0 then
             Set FunctionRecordSet = Server.CreateObject("ADODB.Recordset")
             f_field_ID=f_table&"_ID"
             FunctionSQL = "SELECT * FROM "&f_table&" WHERE "&f_field_ID&"="&f_selected&" ;"
                 'response.write ("<br>-"&FunctionSQL&"-<br>"&f_field)
             FunctionRecordSet.Open FunctionSQL, BomConnection
             g_Choose_Options=""
             do until FunctionRecordSet.EOF
                  if (f_selected)=FunctionRecordSet(f_field_ID) then g_Choose_Options=FunctionRecordSet(f_field)
             FunctionRecordSet.MoveNext
             loop
             FunctionRecordSet.Close
             Set FunctionRecordSet = Nothing
         else
              g_Choose_Options="-none-"
         end if
end function
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&' g_Choose_Options_Count ----------------------------------- '
function g_Choose_Options_count(f_selected,f_table,f_field)
        Set FunctionRecordSet = Server.CreateObject("ADODB.Recordset")
        f_field_ID=f_table&"_ID"
        FunctionSQL = "SELECT * FROM "&f_table&" WHERE "&f_field&"="&f_selected&" ;"
        FunctionRecordSet.Open FunctionSQL, BomConnection
        g_Choose_Options_count=0
        do until FunctionRecordSet.EOF
             g_Choose_Options_count=g_Choose_Options_count+1
        FunctionRecordSet.MoveNext
        loop
        FunctionRecordSet.Close
        Set FunctionRecordSet = Nothing
end function
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function g_type_options(f_selected,f_item_type,f_table,f_input_1,f_input_2,f_input_3)
    if f_selected=f_table&"_ID" then bu_bir_ID=True
    dim f_input_array(3)
    f_input_array(f_input_1)=" selected "
    g_type_options="<select name='"&f_selected&"_1'>"
    g_type_options=g_type_options&"  <option value='0' " & f_input_array(0) & " >Not editable</option>"
    if not(bu_bir_ID) then g_type_options=g_type_options&"  <option value='1' " & f_input_array(1) & " >Value</option>"
    if f_item_type=3 and  not(bu_bir_ID)  then g_type_options=g_type_options&"  <option value='2' " & f_input_array(2) & " >Option</option> "    '*********** sadece integer ise options ekle
    g_type_options=g_type_options&" </select> "
    if f_item_type=3 and  not(bu_bir_ID) then g_type_options=g_type_options&"if option, use table:<input type='text' name='"&f_selected&"_2' value='"&f_input_2&"'> and field:<input type='text' name='"&f_selected&"_3' value='"&f_input_3&"'>"
end function



%>