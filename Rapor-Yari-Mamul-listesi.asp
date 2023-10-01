<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<% BaslikHTML="Yarı Mamül Yakala" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level' 


    search_madde_kodu = temizle(BeniKoddanArindir(request.form("search_madde_kodu")))
    search_madde_ad = temizle(BeniKoddanArindir(request.form("search_madde_ad")))
    search_madde = temizle(BeniKoddanArindir(request.form("search_madde")))
    
    if url_doo="detay" then
        search_madde_ad = temizle(request.querystring("maddekodu"))
        search_madde_kodu = temizle(request.querystring("mamulkodu"))
    end if
    
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
                <div class="container-fluid p-4"><h4>Yarı Mamül Yakala</h4> 
                    <div class="input-group">
                        <input class="form-control" type="text" name="search_madde_kodu" placeholder="Mamül Kodu" value="<%=search_madde_kodu%>">
                        <input class="form-control" type="text" name="search_madde_ad" placeholder="Yarı Mamül Kodu" value="<%=search_madde_ad%>">
                        <input class="form-control" type="text" name="search_madde" placeholder="Açıklama" value="<%=search_madde%>">
                        <input class="btn btn-secondary" type="submit" name="B1" value="Ara">
                    </div>
                </div> 
            </form>  
            <%
            if url_doo="list" OR url_doo="detay" then 
                %>
                <button class="btn btn-success m-2" onclick="html_table_to_excel('xlsx','filename','tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
                <table class="table table-sm table-striped table-hover align-middle" id="tblData"> <%
                    ' SQL Rapor-CariStokEksik.asp
                        Netsis_SQL=Netsis_SQL+" SELECT A.[MAMUL_KODU] 'Mamul' "
                        Netsis_SQL=Netsis_SQL+"  ,B2.STOK_ADI as 'MamulAdi' "
                        Netsis_SQL=Netsis_SQL+"  ,A.[HAM_KODU] as 'HamMadde' "
                        Netsis_SQL=Netsis_SQL+"  ,B.STOK_ADI as 'StokAdi' "
                        Netsis_SQL=Netsis_SQL+"  ,A.[MIKTAR] as 'Miktar' "
                        Netsis_SQL=Netsis_SQL+"  ,Z.toplam as 'BomSatiri' "
                        Netsis_SQL=Netsis_SQL+"  FROM ["+currentDB+"].[dbo].[TBLSTOKURM] A "
                        Netsis_SQL=Netsis_SQL+"  LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] B ON B.STOK_KODU = A.HAM_KODU "
                        Netsis_SQL=Netsis_SQL+"  LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] B2 ON B2.STOK_KODU = A.MAMUL_KODU "
                        Netsis_SQL=Netsis_SQL+"  OUTER APPLY (SELECT COUNT(*) as toplam FROM ["+currentDB+"].[dbo].[TBLSTOKURM] WHERE [MAMUL_KODU]=A.[HAM_KODU] AND GEC_FLAG=0) Z "
                        Netsis_SQL=Netsis_SQL+"  WHERE  A.HAM_KODU LIKE 'Y%' AND Z.Toplam>0 AND GEC_FLAG=0 AND  B2.GRUP_KODU = 'FP1' "                     

                        ' Mamul koduna göre ara
                            y=0
                            if len(search_madde_kodu)=0 then search_madde_kodu="%"
                            if instr(search_madde_kodu,"%")=0 then yuzde="%" else yuzde=""
                            if instr(search_madde_kodu," ") then 
                                Netsis_SQL=Netsis_SQL+" AND ("
                                a=Split(search_madde_kodu)
                                for each x in a
                                    if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                    Netsis_SQL=Netsis_SQL+" A.[MAMUL_KODU] LIKE '"+yuzde+x+yuzde+"'"
                                    y=1
                                next
                                Netsis_SQL=Netsis_SQL+") "
                            else
                            Netsis_SQL=Netsis_SQL+" AND A.[MAMUL_KODU] LIKE '"+yuzde+search_madde_kodu+yuzde+"' "
                            end if
                        ' end 

                        ' madde adına göre ara
                            y=0
                            if len(search_madde_ad)=0 then search_madde_ad="%"
                            if instr(search_madde_ad,"%")=0 then yuzde="%" else yuzde=""
                            if instr(search_madde_ad," ") then 
                                Netsis_SQL=Netsis_SQL+" AND ("
                                a=Split(search_madde_ad)
                                for each x in a
                                    if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                    Netsis_SQL=Netsis_SQL+" A.HAM_KODU LIKE '"+yuzde+x+yuzde+"'"
                                    y=1
                                next
                                Netsis_SQL=Netsis_SQL+") "
                            else
                            Netsis_SQL=Netsis_SQL+" AND A.HAM_KODU LIKE '"+yuzde+search_madde_ad+yuzde+"' "
                            end if
                        ' end madde adına göre

                        ' madde koduna göre ara
                            y=0
                            if len(search_madde)=0 then search_madde="%"
                            if instr(search_madde,"%")=0 then yuzde="%" else yuzde=""
                            if instr(search_madde," ") then 
                                Netsis_SQL=Netsis_SQL+" AND ("
                                a=Split(search_madde)
                                for each x in a
                                    if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                    Netsis_SQL=Netsis_SQL+" B.STOK_ADI LIKE '"+yuzde+x+yuzde+"'"
                                    y=1
                                next
                                Netsis_SQL=Netsis_SQL+") "
                            else
                            Netsis_SQL=Netsis_SQL+" AND B.STOK_ADI LIKE '"+yuzde+search_madde+yuzde+"' "
                            end if
                        ' end madde koduna göre

                        Netsis_SQL=Netsis_SQL+"  ORDER BY A.MAMUL_KODU																											   "
                    ' SQL ende
                    'Response.Write (Netsis_SQL)
                    NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                        sira=0 
                        do until NetsisRecordSet.EOF OR sira>=1000
                            if sira=0 then %>
                                <thead><tr><th>Sıra</th>
                                     <th> Mamul</th>
                                     <th> Açıklama</th>
                                     <th> Yarı Mamül</th>
                                     <th> Açıklama</th>
                                     <th> Miktar</th>
                                     <th> Bom Satırı</th>
                                </tr></thead> <%
                            end if 
                            sira=sira+1 
                            Response.Write(" <tr><td>"&sira&"</td>")
                            Response.Write("<td>" & NetsisRecordSet("Mamul") )
                            Response.Write(" <a href='NetsisBom.asp?doo=bomlist&item="&NetsisRecordSet("Mamul")&"'><div class='badge badge-pill bg-primary'><i class='bi bi-journal-text'></i></div></a></td>")
                            Response.Write("<td>" &NetsisRecordSet("MamulAdi") & "</td>")
                            Response.Write("<td><a href='?doo=detay&maddekodu="&NetsisRecordSet("HamMadde")&"'><i class='bi bi-binoculars'></i></a> " &NetsisRecordSet("HamMadde") )
                            Response.Write(" <a href='NetsisBom.asp?doo=bomlist&item="&NetsisRecordSet("HamMadde")&"'><div class='badge badge-pill bg-primary'><i class='bi bi-journal-text'></i></div></a></td>")
                            Response.Write("<td>" &NetsisRecordSet("StokAdi") & "</td>")
                            Response.Write("<td>" &NetsisRecordSet("Miktar") & "</td>")
                            Response.Write("<td>" &NetsisRecordSet("BomSatiri") & "</td>")
                            if url_doo="detay" then  hepsi=hepsi+" "+NetsisRecordSet("Mamul")
                            NetsisRecordSet.MoveNext
                        loop
                        Response.Write(" </tr> ")
                    NetsisRecordSet.close
                    Response.Write(" </table> ")

                    %> 
                </table> 
                <%
                if url_doo="detay" then Response.Write("<h2><a href='?doo=detay&mamulkodu=" & hepsi & "'><i class='bi bi-binoculars'></i></a> </h2>")

                if sira=0 then response.write ("Kayıt bulunamadı...") 
                if sira=1000 then response.write ("Max. 1000 kayıt görüntülendi.") 
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