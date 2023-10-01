<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Stok Kod2 ve Cari-Stok Bağlantısı." %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level'   

    search_kod2 = BeniKoddanArindir(request.form("search_kod2"))
    search_stok_kodu = BeniKoddanArindir(request.form("search_stok_kodu")) 
    search_stok_cari = BeniKoddanArindir(request.form("search_stok_cari")) %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"> <h3>Stok Kod2 ve Cari-Stok Bağlantısı.</h3>
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_stok_kodu"  placeholder="Stok Kodu"  value="<%=search_stok_kodu%>">
                            <input class="form-control" type="text" name="search_kod2"  placeholder="Kod 2"  value="<%=search_kod2%>">
                            <input class="form-control" type="text" name="search_stok_cari"  placeholder="Cari"  value="<%=search_stok_cari%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
    <%
    if len(search_stok_kodu&search_kod2&search_stok_cari)>0 then 
    %>
        <div class="container-fluid p-4"> 
        <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>

            <table class="table table-sm table-striped table-hover align-middle" id="tblData">         <%
                ' SQL   Rapor-CariStokEksik.asp
                    Netsis_SQL=  "SELECT  "
                    Netsis_SQL=Netsis_SQL + "S.STOK_KODU "
                    Netsis_SQL=Netsis_SQL + ",S.URETICI_KODU "
                    Netsis_SQL=Netsis_SQL + ",S.STOK_ADI "
                    Netsis_SQL=Netsis_SQL + ",E.INGISIM "
                    Netsis_SQL=Netsis_SQL + ",S2.GRUP_ISIM AS 'KOD2' "
                    Netsis_SQL=Netsis_SQL + ",FF.CARI_KOD "
                    Netsis_SQL=Netsis_SQL + ",CR.CARI_ISIM "
                    Netsis_SQL=Netsis_SQL + "FROM ["+currentDB+"].[dbo].TBLSTSABIT S "
                    Netsis_SQL=Netsis_SQL + "LEFT JOIN ["+currentDB+"].[dbo].TBLSTSABITEK E ON S.STOK_KODU=E.STOK_KODU "
                    Netsis_SQL=Netsis_SQL + "LEFT JOIN ["+currentDB+"].[dbo].TBLSTOKKOD1 S1 ON S1.GRUP_KOD=S.KOD_1 "
                    Netsis_SQL=Netsis_SQL + "LEFT JOIN ["+currentDB+"].[dbo].TBLSTOKKOD2 S2 ON S2.GRUP_KOD=S.KOD_2 "
                    Netsis_SQL=Netsis_SQL + "LEFT JOIN ["+currentDB+"].[dbo].TBLSTOKKOD3 S3 ON S3.GRUP_KOD=S.KOD_3 "
                    Netsis_SQL=Netsis_SQL + "LEFT JOIN ["+currentDB+"].[dbo].TBLSTOKKOD4 S4 ON S4.GRUP_KOD=S.KOD_4 "
                    Netsis_SQL=Netsis_SQL + "LEFT JOIN (SELECT * FROM ["+currentDB+"].[dbo].[TBLCARISTOK] CS WHERE  CARI_KOD IS NOT NULL ) FF ON S.STOK_KODU=FF.STOK_KODU "
                    Netsis_SQL=Netsis_SQL + "LEFT JOIN  ["+currentDB+"].[dbo].[TBLCASABIT] CR ON FF.CARI_KOD=CR.CARI_KOD                     "
                    Netsis_SQL=Netsis_SQL+"   WHERE 1=1 "
                    if len(search_stok_kodu)>0 then Netsis_SQL=Netsis_SQL+"   AND S.STOK_KODU LIKE '"&search_stok_kodu&"' "
                    if len(search_kod2)>0 then Netsis_SQL=Netsis_SQL+"   AND  S2.GRUP_ISIM LIKE '"&search_kod2&"' "
                    if len(search_stok_cari)>0 then Netsis_SQL=Netsis_SQL+"   AND CR.CARI_ISIM LIKE '"&search_stok_cari&"' "
                ' SQL ende            
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                    sira=0 
                    do until NetsisRecordSet.EOF OR sira>=10000
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
                if sira=10000 then response.write ("<tr><td colspan=5>Max. 10000 kayıt görüntülendi.</td></tr>")     %> 
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
<script>
let table = new DataTable('#tblData', {
        "lengthMenu": [[10, 100 , -1], [ 10, 100, "All"]]
   // options
});

</script>
<!-- #include file="./include/footer.asp" -->