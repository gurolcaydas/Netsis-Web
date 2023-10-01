<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<% BaslikHTML="Recete Listeleri" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level' 

    search_madde_kodu = BeniKoddanArindir(temizle(request.form("search_madde_kodu")))
    search_madde_ad = BeniKoddanArindir(temizle(request.form("search_madde_ad")))
    %> 
    <script type="text/javascript" src="include/xlsx.full.min.js"></script>
    <script type="text/javascript">
        function html_table_to_excel(type,str,str2) { // Excel
            var data = document.getElementById(str2);
            var file = XLSX.utils.table_to_book(data, {sheet: "sheet1"});
            XLSX.write(file, { bookType: type, bookSST: true, type: 'base64' });
            XLSX.writeFile(file, str + '.' + type);
        }
    </script>
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
        <div class="container-fluid p-4"> <h3></h3>


            <form class="form-horizontal" method="POST" action="?doo=list">
                <div class="container-fluid p-4"><h4>Reçete Göster</h4> 
                    <div class="input-group">
                        <input class="form-control" type="text" name="search_madde_kodu" placeholder="Stok Kodu" value="<%=search_madde_kodu%>">
                        <input class="form-control" type="text" name="search_madde_ad" placeholder="Stok Adı" value="<%=search_madde_ad%>">
                                              
                        <input class="btn btn-secondary" type="submit" name="B1" value="Ara">
                    </div>
                </div> 
            </form>  
            <%
            if url_doo="list" then 
                %>
                                        <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel eski</button>
                <button class="btn btn-success m-2" onclick="html_table_to_excel('xlsx','filename','tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
                <table class="table table-sm table-striped table-hover align-middle" id="tblData"> 
                                <thead><tr> 

                                <th>İş Emri No</th>
                                <th>Mamül Kodu</th>

                                <th>Mamül</th>

                                <th>Tarih</th>
                                <th>Miktar</th>
                                <th>Reçete Satırları</th>

                                </tr></thead> 
                            <%
                a1=Split(search_madde_kodu)
                for each search_madde_kodu2 in a1
                    ' SQL 
                        Netsis_SQL=""
                        Netsis_SQL=Netsis_SQL+" SELECT A.[ISEMRINO] "
                        Netsis_SQL=Netsis_SQL+" ,A.[MAMUL_KODU] "
                        Netsis_SQL=Netsis_SQL+" ,C.STOK_ADI "
                        Netsis_SQL=Netsis_SQL+" ,CAST(B.TARIH as date) as Tarih  "
                        Netsis_SQL=Netsis_SQL+" ,B.MIKTAR "
                        Netsis_SQL=Netsis_SQL+" ,COUNT(MAMUL_KODU) as satirsayisi "
                        Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLISEMRIREC] A "
                        Netsis_SQL=Netsis_SQL+" LEFT JOIN  ["+currentDB+"].[dbo].[TBLISEMRI] B ON B.ISEMRINO=A.ISEMRINO "
                        Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] C ON C.STOK_KODU=A.MAMUL_KODU "
                        Netsis_SQL=Netsis_SQL+" WHERE 1=1 "
                        ' madde adına göre ara
                            y=0
                            if len(search_madde_ad)=0 then search_madde_ad="%"
                            if instr(search_madde_ad," ") then 
                                Netsis_SQL=Netsis_SQL+" AND ("
                                a3=Split(search_madde_ad)
                                for each x in a3
                                    if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                    Netsis_SQL=Netsis_SQL+" C.STOK_ADI LIKE '"+x+"'"
                                    y=1
                                next
                                Netsis_SQL=Netsis_SQL+") "
                            else
                            Netsis_SQL=Netsis_SQL+" AND C.STOK_ADI LIKE '"&search_madde_ad&"' "
                            end if
                        ' end madde adına göre

                        ' madde koduna göre ara
                            y=0
                            if len(search_madde_kodu)>0 then 
                                if instr(search_madde_kodu," ") then 
                                    Netsis_SQL=Netsis_SQL+" AND ("
                                    a2=Split(search_madde_kodu)
                                    for each x in a2
                                        if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                        Netsis_SQL=Netsis_SQL+" A.[MAMUL_KODU] LIKE '"+x+"'"
                                        y=1
                                    next
                                    Netsis_SQL=Netsis_SQL+") "
                                else
                                Netsis_SQL=Netsis_SQL+" AND A.[MAMUL_KODU] LIKE '"&search_madde_kodu&"' "
                                end if
                            end if 
                        ' end madde koduna göre
                        Netsis_SQL=Netsis_SQL+"    GROUP BY A.[ISEMRINO] "
                        Netsis_SQL=Netsis_SQL+"        ,A.[MAMUL_KODU] "
                        Netsis_SQL=Netsis_SQL+"  	  ,B.TARIH  "
                        Netsis_SQL=Netsis_SQL+"  	  ,B.MIKTAR "
                        Netsis_SQL=Netsis_SQL+"  	  ,C.STOK_ADI "
                        Netsis_SQL=Netsis_SQL+"    ORDER BY B.TARIH "

                    ' SQL ende
                    'Response.Write (Netsis_SQL)
                    NetsisRecordSet.Open Netsis_SQL, NetsisConnection 
                        sira=0 
                        do until NetsisRecordSet.EOF OR sira>=5000

                                sira=sira+1 
                                Response.Write(" <tr>")
                                Response.Write("<td>"& NetsisRecordSet("ISEMRINO") &"</td>") ' # karekteri exceli yarıda kesiyor
                                Response.Write("<td>"& NetsisRecordSet("MAMUL_KODU") &" </td>") ' # karekteri exceli yarıda kesiyor
                                Response.Write("<td>"&replace(NetsisRecordSet("STOK_ADI"), "#", "&bull;")&"</td>") ' # karekteri exceli yarıda kesiyor
                                Response.Write("<td>"& NetsisRecordSet("TARIH") &"</td>") ' # karekteri exceli yarıda kesiyor
                                Response.Write("<td>"& NetsisRecordSet("MIKTAR") &"</td>") ' # karekteri exceli yarıda kesiyor
                                Response.Write("<td>"& NetsisRecordSet("satirsayisi") &"</td>") ' # karekteri exceli yarıda kesiyor
                                Response.Write(" </tr> ")
                            NetsisRecordSet.MoveNext
                        loop
                    NetsisRecordSet.close
                next 
                    %> 
                </table> 
                <%
                if sira=0 then response.write ("Kayıt bulunamadı...") 
                if sira=5000 then response.write ("Max. 5000 kayıt görüntülendi.") 
            end if
            %>
        </div>
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