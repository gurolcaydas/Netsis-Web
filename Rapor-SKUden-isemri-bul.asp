<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="İş Emri Reçeteleri Toplu Gösterim" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level'   


    str = temizle(request.form("search_is_emri")) 
    %>         
    <div class="container-fluid" style="margin-top:80px;"> 
        <!-- #include file="./subs/dbcon.asp" -->
        <form class="form-horizontal d-print-none" method="POST" action="?doo=list">
            <div class="container-fluid p-4"> <h3>SKU'dan İşemri bul</h3>
                <div class="input-group">
                    <textarea class="form-control z-depth-1" name="search_is_emri" rows="3" placeholder="Madde Kodları"><%=str%></textarea>
                    <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                </div>
            </div>                           
        </form>  <%  
        if LEN(str)>0 then   %>
            <div class="container-fluid p-4"  > 
                    <form class="form-horizontal" method="POST" action="Rapor-isemri-recete-toplu.asp?doo=list">
                <table class="table table-sm table-striped table-hover align-middle"  id="tblData"> 
                    <thead><tr>
                        <th>Sıra</th>
                        <th>Tarih</th>
                        <th>Kapalı</th>
                        <th>Reçete</th>
                        <th>Açıklama</th>
                        <th>İş Emri</th>
                        <th>Miktar</th>
                        <th>Seç</th>
                        <th>Üst Reçete</th>
                        <th>Sipariş</th>
                        <th>Ref. İş Emri</th>
                    </tr> </thead><%           
                    a=Split(str)
                    for each xisemri in a
                        ' SQL
                            Netsis_SQL= " SELECT TOP 5000 "
                            Netsis_SQL=Netsis_SQL+" [ISEMRINO] "
                            Netsis_SQL=Netsis_SQL+" ,[SIPARIS_NO] "
                            Netsis_SQL=Netsis_SQL+" ,[TARIH] "
                            Netsis_SQL=Netsis_SQL+" ,[KAPALI] "
                            Netsis_SQL=Netsis_SQL+" ,A.[STOK_KODU] "
                            Netsis_SQL=Netsis_SQL+" ,B.[STOK_ADI] "
                            Netsis_SQL=Netsis_SQL+" ,A.[MIKTAR] "
                            Netsis_SQL=Netsis_SQL+" ,[REFISEMRINO] "
                            Netsis_SQL=Netsis_SQL+" ,[TEPEMAM] "
                            Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLISEMRI] A WITH (NOLOCK) "
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] B ON B.STOK_KODU=A.STOK_KODU "
                            Netsis_SQL=Netsis_SQL+" WHERE A.STOK_KODU LIKE '"&xisemri&"'  ORDER BY A.[STOK_KODU], TARIH "
                        ' SQL ende                        
                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                            sira=0 
                            do until NetsisRecordSet.EOF OR sira>=5000
                                if NetsisRecordSet("KAPALI")="E" then kapali=" class='bg-success' " else kapali=""
                                if NetsisRecordSet("KAPALI")="H" OR instr(UserLevel,"s")  then 
                                    Sira=sira+1 %>  
                                    <tr >
                                    <td><%=Sira%></td>
                                    <td><%=NetsisRecordSet("TARIH")%></td>
                                    <td <%=kapali%>><%=NetsisRecordSet("KAPALI")%></td>
                                    <td><%=NetsisRecordSet("STOK_KODU")%></td>
                                    <td><%=NetsisRecordSet("STOK_ADI")%></td>
                                    <td><%=NetsisRecordSet("ISEMRINO")%> <a href="Rapor-isemri-depo-bakiye.asp?doo=tekisemri&isemri=<%=NetsisRecordSet("ISEMRINO")%>"><i class="bi bi-binoculars"></i></a></td>
                                    <td><%=NetsisRecordSet("MIKTAR")%></td>
                                    <td>
                                        <div class="input-group-text">
                                            <input class="form-check-input mt-0" type="checkbox" id="search_is_emri"  name="search_is_emri" value="<%=NetsisRecordSet("ISEMRINO")%>" >
                                        </div>                                
                                    </td>
                                    <td><%=NetsisRecordSet("TEPEMAM")%></td>
                                    <td><%=NetsisRecordSet("SIPARIS_NO")%> <a href="Rapor-isemri-depo-bakiye.asp?doo=siparis&siparis=<%=NetsisRecordSet("SIPARIS_NO")%>"><i class="bi bi-binoculars"></i></a></td>
                                    <td><%=NetsisRecordSet("REFISEMRINO")%></td>
                                    </tr>        
                                    <%
                                end if 
                                NetsisRecordSet.movenext
                            Loop
                        NetsisRecordSet.close
                        if sira=0 then response.write ("<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>"&xisemri&"</td><td>Kayıt bulunamadı...</td></tr>")     
                    next   %> 
                </table> 
                <input class="btn btn-secondary" type="submit"  name="B1" value="Seçili İş Emirlerini Listele">
                </form>
            </div> <% 
        end if %>        
    </div> <%
else
    Response.Write ("User level?")
end if
%> 
    <script>
let table = new DataTable('#tblData', {
    "lengthMenu": [[-1, 10, 20, 100], [ "All" ,10, 20, 100]]
   // options
});

</script>
<!-- #include file="./include/footer.asp" -->