<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Tekilleştirilen Yarı Mamüller" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"u") then 'needed level' 
    search_stok_kodu = (request.form("search_madde_kodu")) 
        ' for x=1 to len(search_stok_kodu)
        '     aaa = aaa & (asc(mid(search_stok_kodu,x,1)) & "*")
        ' next
        search_stok_kodu=Replace(search_stok_kodu,vbCrLf, " ")       
        search_stok_kodu=Replace(search_stok_kodu,Chr(9), " ")        
        search_stok_kodu=Replace(search_stok_kodu,Chr(10), " ")        
        search_stok_kodu=Replace(search_stok_kodu,Chr(11), " ")        
        search_stok_kodu=Replace(search_stok_kodu,Chr(12), " ")        
        search_stok_kodu=Replace(search_stok_kodu,Chr(13), " ")        
        search_stok_kodu=Replace(search_stok_kodu,Chr(44), " ")        
        search_stok_kodu=Replace(search_stok_kodu, """", " ")
        search_stok_kodu=Replace(search_stok_kodu, "'", " ")
        search_stok_kodu=Replace(search_stok_kodu, "‚", " ")
    
        i=0
            Do While i<>LEN(search_stok_kodu) ' çift space kontrol
                    i=LEN(search_stok_kodu)
                    search_stok_kodu=Replace(search_stok_kodu, "  ", " ")
            Loop
        search_madde_kodu=trim(search_stok_kodu)        
  %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
        <div class="container-fluid p-4"> <h3></h3>

            
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"><h4>Tekilleştirilen Yarı Mamüller</h4>         
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_madde_kodu"  placeholder="Stok Kodu"  value="<%=search_madde_kodu%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
            
<%
if url_doo="list" then 
%>
                        <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>

            <table class="table table-sm table-striped table-hover align-middle" id="tblData">         <%
                ' SQL   
                                        Netsis_SQL=" SELECT A.[AX_KOD]																														 "
                                        Netsis_SQL=Netsis_SQL+" ,D.[DESCRIPTION]																															 "
                                        Netsis_SQL=Netsis_SQL+" ,A.[NETSIS_KOD]																															 "
                                        Netsis_SQL=Netsis_SQL+" ,B.[STOK_ADI]																															 "
                                        Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[PLT_TEKILLESEN_KODLAR_2022] A																					 "
                                        Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] B ON A.[NETSIS_KOD]=B.[STOK_KODU]																 "
                                        Netsis_SQL=Netsis_SQL+" LEFT JOIN  [MicrosoftDynamicsAX].[dbo].[INVENTTABLE] C ON C.[ITEMID]=A.[AX_KOD]														   	 "
                                        Netsis_SQL=Netsis_SQL+" LEFT JOIN  (SELECT * FROM [MicrosoftDynamicsAX].[dbo].[ECORESPRODUCTTRANSLATION] WHERE [LANGUAGEID]='en-us') D ON D.[PRODUCT]=C.[PRODUCT] "
                                        Netsis_SQL=Netsis_SQL+"	WHERE [AX_KOD] LIKE '%"&search_madde_kodu&"%' OR [NETSIS_KOD] LIKE '%"&search_madde_kodu&"%'"
                                        Netsis_SQL=Netsis_SQL+" ORDER BY [NETSIS_KOD]																													  "


                ' SQL ende
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                    sira=0 
                    do until NetsisRecordSet.EOF 'OR sira>=5000
                        if sira=0 then                         %>
                            <thead><tr> <%
                            Response.Write("<th>Sıra</th>")
                            for each x in  NetsisRecordSet.Fields
                                Response.Write("<th>" & x.name & "</th>")
                            next                    %>
                            </tr></thead>  <%
                        end if 
                        sira=sira+1      
                        Response.Write(" <tr><td>"&sira&"</td>")
                        for each x in  NetsisRecordSet.Fields
                            'Response.Write(x.name)
                            'Response.Write(" = ")
                            Response.Write("<td>" & x.value & "</td>")
                        next
                        NetsisRecordSet.MoveNext
                    loop
                    Response.Write(" </tr> ")
                NetsisRecordSet.close
                Response.Write(" </table> ")

                if sira=0 then response.write ("Kayıt bulunamadı...")     
                if sira=5000 then response.write ("<tr><td colspan=5>Max. 5000 kayıt görüntülendi.</td></tr>")     %> 
            </table> 
            <%
            end if
            %>
        </div>
    </div> <%
else
    Response.Write ("User level?")
end if
%> 
<!-- #include file="./include/footer.asp" -->