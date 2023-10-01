<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="İşemirlerine göre Maliyetler" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level'   

    search_desc = BeniKoddanArindir(request.form("search_desc"))
    search_stok_kodu = BeniKoddanArindir(request.form("search_stok_kodu")) %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"> <h3>İşemirlerine göre maliyetler.</h3>
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_stok_kodu"  placeholder="Stok Kodu"  value="<%=search_stok_kodu%>">
                            <input class="form-control" type="text" name="search_desc"  placeholder="Fiş No"  value="<%=search_desc%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
    <%
    if len(search_stok_kodu&search_desc)>0 then 
    %>
        <div class="container-fluid p-4"> 
            
                    <%
                ' SQL   



Netsis_SQL="SELECT  "
' **********************************************************************'
Netsis_SQL=Netsis_SQL+" 	 A.STHAR_SIPNUM "
Netsis_SQL=Netsis_SQL+" 	,A.STOK_KODU "
Netsis_SQL=Netsis_SQL+" 	,B.STOK_ADI "
Netsis_SQL=Netsis_SQL+" 	,A.FISNO "
Netsis_SQL=Netsis_SQL+" 	,A.STHAR_GCMIK "
Netsis_SQL=Netsis_SQL+" 	,A.STHAR_GCKOD  "
Netsis_SQL=Netsis_SQL+" 	,A.STHAR_TARIH "
Netsis_SQL=Netsis_SQL+" 	,A.STHAR_NF "
Netsis_SQL=Netsis_SQL+" 	,A.DEPO_KODU "
Netsis_SQL=Netsis_SQL+" 	,A.STHAR_ACIKLAMA "
Netsis_SQL=Netsis_SQL+" 	,A.STHAR_HTUR "
Netsis_SQL=Netsis_SQL+" 	,A.STHAR_BGTIP "
Netsis_SQL=Netsis_SQL+" 	,A.STHAR_CARIKOD "
Netsis_SQL=Netsis_SQL+" 	,A.SUBE_KODU  "
Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSTHAR] A WITH (NOLOCK) "
Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] B WITH (NOLOCK) ON B.STOK_KODU=A.STOK_KODU "
Netsis_SQL=Netsis_SQL+" WHERE STHAR_SIPNUM IN (  "
Netsis_SQL=Netsis_SQL+" 	SELECT DISTINCT STHAR_SIPNUM   "
Netsis_SQL=Netsis_SQL+" 	FROM ["+currentDB+"].[dbo].[TBLSTHAR] WITH (NOLOCK)  "
Netsis_SQL=Netsis_SQL+" 	WHERE 1=1  "




if len(search_stok_kodu)>0 then Netsis_SQL=Netsis_SQL+"   AND STOK_KODU = '"&search_stok_kodu&"' "
if len(search_desc)>0 then Netsis_SQL=Netsis_SQL+"   AND  A.FISNO LIKE '"&search_desc&"' "

Netsis_SQL=Netsis_SQL+" 	AND STHAR_SIPNUM IS NOT NULL AND LEN(STHAR_SIPNUM)>0  "
Netsis_SQL=Netsis_SQL+"  ) "
Netsis_SQL=Netsis_SQL+" ORDER BY A.FISNO,A.STHAR_SIPNUM,A.STHAR_TARIH,A.STHAR_HTUR,A.STOK_KODU "

                ' SQL ende            
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                    sira=0 
                    eski=""
                    do until NetsisRecordSet.EOF OR sira>=1000
                            if eski<>NetsisRecordSet("FISNO") and len(eski)>0 then 
                                sira=0
                                Response.Write ("</table>")
                            end if
                            eski=NetsisRecordSet("FISNO")                    
                        if sira=0 then                         %>
                        <table class="table table-sm table-striped table-hover align-middle nowrap" > 
                            <thead><tr>
                            <th>Sıra</th>
                            <th>Tarih</th>
                            <th>Fiş no</th>
                            <th>İşemri no</th>
                            <th>Stok Kodu</th>
                            <th>Stok Açıklaması</th>
                            <th>Tüketim</th>
                            <th>Üretim</th>
                            <th>Birim Maliyet</th>
                            </tr></thead>  <%
                        end if 
                        sira=sira+1      
                        if NetsisRecordSet("STOK_KODU")=search_stok_kodu then renk=" class='bg-warning'  title=' Bu! ' " else renk=""  
                        
                        %>                        
                            <tr><td><%=sira%></td> 
                            <td><%=NetsisRecordSet("STHAR_TARIH")%></td>
                            <td><%=NetsisRecordSet("FISNO")%></td>
                            <td><%=NetsisRecordSet("STHAR_SIPNUM")%> <a href="Rapor-isemri-depo-bakiye.asp?doo=tekisemri&isemri=<%=NetsisRecordSet("STHAR_SIPNUM")%>"><i class="bi bi-binoculars"></i></a></td>
                            <td <%=renk%>><%=NetsisRecordSet("STOK_KODU")%></td>
                            <td><%=NetsisRecordSet("STOK_ADI")%></td>
                            <%
                            if NetsisRecordSet("STHAR_GCKOD")="G" then %>
                            <td></td><td><%=NetsisRecordSet("STHAR_GCMIK")%></td>                            
                            <% else %>
                            <td><%=NetsisRecordSet("STHAR_GCMIK")%></td><td></td>                            
                            <% end if  %> 
                            <td><%=NetsisRecordSet("STHAR_NF")%></td> 
                            <% 

                        NetsisRecordSet.MoveNext
                    loop
                    Response.Write(" </tr> ")
                NetsisRecordSet.close
                Response.Write(" </table> ")

                if sira=0 then response.write ("Kayıt bulunamadı...")     
                if sira=1000 then response.write ("<tr><td colspan=5>Max. 1000 kayıt görüntülendi.</td></tr>")     %> 
            </table> 
        </div>
        <%
        end if
        %>
    </div> <%
else
    Response.Write ("User level?")
end if
%> 

<!-- #include file="./include/footer.asp" -->