<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="TML" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"s") then 'needed level'   

    search_mamul_kodu = BeniKoddanArindir(request.form("search_mamul_kodu"))
    search_yari_mamul_kodu = BeniKoddanArindir(request.form("search_yari_mamul_kodu")) %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"> <h3>TML (ham halidir)</h3>
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_mamul_kodu"  placeholder="Mamül"  value="<%=search_mamul_kodu%>">
                            <input class="form-control" type="text" name="search_yari_mamul_kodu"  placeholder="Hammadde"  value="<%=search_yari_mamul_kodu%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
        <% if LEN(search_mamul_kodu)+LEN(search_yari_mamul_kodu)>0 then  %>
        <div class="container-fluid p-4"> 
            <table class="table table-sm table-striped table-hover align-middle">         <%
                ' SQL   Rapor-CariStokEksik.asp
                    Netsis_SQL=" SELECT TOP (1000) [TEDARIKCI]				  "
                    Netsis_SQL=Netsis_SQL+"       ,[TEDARIKCI_ADI]						  "
                    Netsis_SQL=Netsis_SQL+"       ,[MUSTERI_KODU]						  "
                    Netsis_SQL=Netsis_SQL+"       ,[MUSTERI_ADI]						  "
                    Netsis_SQL=Netsis_SQL+"       ,[MPS_TIP]							  "
                    Netsis_SQL=Netsis_SQL+"       ,[CIKSIRA]							  "
                    Netsis_SQL=Netsis_SQL+"       ,[CIKTIP]								  "
                    Netsis_SQL=Netsis_SQL+"       ,[NO]									  "
                    Netsis_SQL=Netsis_SQL+"       ,[HAMKOD]								  "
                    Netsis_SQL=Netsis_SQL+"       ,[HAM_ADI]							  "
                    Netsis_SQL=Netsis_SQL+"       ,[MALZEME_GRUBU]						  "
                    Netsis_SQL=Netsis_SQL+"       ,[HAMMIK]								  "
                    Netsis_SQL=Netsis_SQL+"       ,[TEPESIPNO]							  "
                    Netsis_SQL=Netsis_SQL+"       ,[TEPESIPKONT]						  "
                    Netsis_SQL=Netsis_SQL+"       ,[TEPEMAM]							  "
                    Netsis_SQL=Netsis_SQL+"       ,[MAMUL_ADI]							  "
                    Netsis_SQL=Netsis_SQL+"       ,[MAMTAR]								  "
                    Netsis_SQL=Netsis_SQL+"       ,[TEPETAR]							  "
                    Netsis_SQL=Netsis_SQL+"       ,[GIRSIRA]							  "
                    Netsis_SQL=Netsis_SQL+"       ,[GIRTIP]								  "
                    Netsis_SQL=Netsis_SQL+"       ,[MIKTAR]								  "
                    Netsis_SQL=Netsis_SQL+"       ,[TESTAR]								  "
                    Netsis_SQL=Netsis_SQL+"       ,[SATINALMA_SIP]						  "
                    Netsis_SQL=Netsis_SQL+"       ,[SATINALMA_SIRA]						  "
                    Netsis_SQL=Netsis_SQL+"       ,[DOSYANO]							  "
                    Netsis_SQL=Netsis_SQL+"   FROM ["+currentDB+"].[dbo].[PLV_TML_DETAY_RPR] "
                    Netsis_SQL=Netsis_SQL+"   WHERE 1=1 "
                    if LEN(search_yari_mamul_kodu)>0 then 
                        if instr(search_yari_mamul_kodu,"%") then 
                        Netsis_SQL=Netsis_SQL+"   AND HAMKOD LIKE '"&search_yari_mamul_kodu&"' "
                        else
                        Netsis_SQL=Netsis_SQL+"   AND HAMKOD LIKE '%"&search_yari_mamul_kodu&"%' "
                        end if
                    end if
                    
                    if LEN(search_mamul_kodu)>0 then 
                        if instr(search_mamul_kodu,"%") then 
                        Netsis_SQL=Netsis_SQL+"   AND TEPEMAM LIKE '"&search_mamul_kodu&"' "
                        else
                        Netsis_SQL=Netsis_SQL+"   AND TEPEMAM LIKE '%"&search_mamul_kodu&"%' "
                        end if
                    end if
                    Netsis_SQL=Netsis_SQL+" ORDER BY  [TEPETAR]   					  "
                ' SQL ende

                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                    sira=0 
                    do until NetsisRecordSet.EOF OR sira>=1000
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
                            Response.Write("<td class='text-nowrap'>" & x.value & "</td>")
                        next
                        NetsisRecordSet.MoveNext
                    loop
                    Response.Write(" </tr> ")
                NetsisRecordSet.close
                Response.Write(" </table> ")

                if sira=0 then response.write ("Kayıt bulunamadı...")     
                if sira=1000 then response.write ("<tr><td colspan=5>Max. 1000 kayıt görüntülendi.</td></tr>")     %> 
            </table> 
        </div>
        <% end if %>        
    </div> <%
else
    Response.Write ("User level?")
end if
%> 
<!-- #include file="./include/footer.asp" -->