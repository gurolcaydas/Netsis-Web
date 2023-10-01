<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Tekerlek Yarı Mamül Listesi" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"p") then 'needed level'   

    search_mamul_kodu = BeniKoddanArindir(request.form("search_mamul_kodu"))
    search_yari_mamul_kodu = BeniKoddanArindir(request.form("search_yari_mamul_kodu")) %>      
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
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"> <h3>Tekerlek Yarı Mamül Listesi</h3>
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_yari_mamul_kodu"  placeholder="Yarı Mamül"  value="<%=search_yari_mamul_kodu%>">
                            <input class="form-control" type="text" name="search_mamul_kodu"  placeholder="Mamül"  value="<%=search_mamul_kodu%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
        <% if LEN(search_mamul_kodu)+LEN(search_yari_mamul_kodu)>0 then  %>
        <div class="container-fluid p-4"> 
                <button class="btn btn-success m-2" onclick="html_table_to_excel('xlsx','filename','tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>        
            <table class="table table-sm table-striped table-hover align-middle"  id="tblData">         <%
                ' SQL   Rapor-CariStokEksik.asp


                    Netsis_SQL= " SELECT TOP 10000 "
                    Netsis_SQL=Netsis_SQL+"       A.[HAM_KODU] "
                    Netsis_SQL=Netsis_SQL+" 	, B.STOK_ADI "
                    Netsis_SQL=Netsis_SQL+" 	, A.[MAMUL_KODU] "
                    Netsis_SQL=Netsis_SQL+" 	, C.STOK_ADI "
                    Netsis_SQL=Netsis_SQL+" 	, K1.GRUP_ISIM "
                    Netsis_SQL=Netsis_SQL+"     FROM ["+currentDB+"].[dbo].[TBLSTOKURM] A "
                    Netsis_SQL=Netsis_SQL+" 	LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] B ON B.STOK_KODU=A.HAM_KODU "
                    Netsis_SQL=Netsis_SQL+" 	LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] C ON C.STOK_KODU=A.MAMUL_KODU "
                    Netsis_SQL=Netsis_SQL+" 	LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] K1 ON K1.GRUP_KOD=B.KOD_1 "
                    
                   
                   Netsis_SQL=Netsis_SQL+"    WHERE  [GEC_FLAG]=0  AND  ( [HAM_KODU] LIKE '%-F23' OR [HAM_KODU] LIKE '%-R23' ) "
                   
                    if LEN(search_yari_mamul_kodu)>0 then 
                        if instr(search_yari_mamul_kodu,"%") then 
                        Netsis_SQL=Netsis_SQL+"   AND A.HAM_KODU LIKE '"&search_yari_mamul_kodu&"' "
                        else
                        Netsis_SQL=Netsis_SQL+"   AND A.HAM_KODU LIKE '%"&search_yari_mamul_kodu&"%' "
                        end if
                    end if
                    
                    if LEN(search_mamul_kodu)>0 then 
                        if instr(search_mamul_kodu,"%") then 
                        Netsis_SQL=Netsis_SQL+"   AND A.MAMUL_KODU LIKE '"&search_mamul_kodu&"' "
                        else
                        Netsis_SQL=Netsis_SQL+"   AND MAMUL_KODU LIKE '%"&search_mamul_kodu&"%' "
                        end if
                    end if
                    Netsis_SQL=Netsis_SQL+" ORDER BY  A.[HAM_KODU]   					  "
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
                            Response.Write("<td class='text-nowrap'>" & x.value & "</td>")
                        next
                        NetsisRecordSet.MoveNext
                    loop
                    Response.Write(" </tr> ")
                NetsisRecordSet.close
                Response.Write(" </table> ")

                if sira=0 then response.write ("Kayıt bulunamadı...")     
                if sira=1000 then response.write ("<tr><td colspan=5>Max. 10000 kayıt görüntülendi.</td></tr>")     %> 
            </table> 
        </div>
        <% end if %>        
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