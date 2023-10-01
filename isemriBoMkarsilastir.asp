<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Ürge reçetesi - İş Emri reçetesi" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<script type="text/javascript" src="include/xlsx.full.min.js"></script>
    <script type="text/javascript">

        function html_table_to_excel(type,str,str2)    {  // Excel
            var data = document.getElementById(str2);
            var file = XLSX.utils.table_to_book(data, {sheet: "sheet1"});
            XLSX.write(file, { bookType: type, bookSST: true, type: 'base64' });
            XLSX.writeFile(file, str + '.' + type);
        }
 
    </script>
    <!-- #include file="./subs/dbcon.asp" -->
<%
if instr(UserLevel,"m") then 'needed level' 
    if url_doo="compare" then        
        ' ------------------------------------ karşılaştır ---------------
                search_isemri = BeniKoddanArindir(temizle(request.form("search_isemri")))
                search_bom = BeniKoddanArindir(temizle(request.form("search_bom")))
                isemirleri2=Split(search_isemri) 
                for each herisemri2 in isemirleri2
                    Netsis_SQL = "Select [STOK_KODU]  FROM ["+currentDB+"].[dbo].[TBLISEMRI] WHERE ISEMRINO ='"+herisemri2+"' "
                    'response.write (Netsis_SQL)
                    NetsisRecordSet.Open Netsis_SQL, NetsisConnection   
                        sira=0 
                        do until NetsisRecordSet.EOF OR sira>=1
                            sira=sira+1
                            search_bom = NetsisRecordSet("STOK_KODU") 
                            NetsisRecordSet.MoveNext
                        loop
                    NetsisRecordSet.close
                next
            %>     
            <div class="container-fluid" style="margin-top:80px"> 
                <h3>İş Emri - Ürge Reçete Karşılaştırma</h3>
                <button class="btn btn-success m-2" onclick="html_table_to_excel('xlsx','filename','tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
                
                <h4><%=search_isemri%></h4>
                <h4><%=search_bom%></h4>
                    <table class="table table-sm table-striped table-hover align-middle"  id="tblData">  
                <%
                isemirleri=Split(search_isemri) 
                for each herisemri in isemirleri 
                    Netsis_SQL = " WITH LISTE AS( "
                    Netsis_SQL = Netsis_SQL + " SELECT  T4.HAM_KODU FROM ["+currentDB+"].[dbo].TBLISEMRI AS T1 "
                    Netsis_SQL = Netsis_SQL + "              INNER JOIN ["+currentDB+"].[dbo].TBLISEMRIREC AS T4 ON T1.ISEMRINO = T4.ISEMRINO "
                    Netsis_SQL = Netsis_SQL + "              WHERE  (T1.ISEMRINO = '" + herisemri + "')   AND T4.GEC_FLAG=0 "
                    Netsis_SQL = Netsis_SQL + " UNION ALL "
                    Netsis_SQL = Netsis_SQL + " SELECT t3.HAM_KODU FROM  ["+currentDB+"].[dbo].TBLSTOKURM AS T3 WHERE T3.MAMUL_KODU ='"+search_bom+"' AND T3.GEC_FLAG=0 ) "
                    Netsis_SQL = Netsis_SQL + " SELECT DISTINCT "
                    Netsis_SQL = Netsis_SQL + " K1.GRUP_ISIM as 'Madde Grubu'"
                    Netsis_SQL = Netsis_SQL + "  , A.HAM_KODU as 'Madde Kodu'"
                    Netsis_SQL = Netsis_SQL + " , ST.STOK_ADI as 'Açıklama'"
                    Netsis_SQL = Netsis_SQL + " , T6.ISEMRINO as 'İşemri no'"
                    'Netsis_SQL = Netsis_SQL + " , T6.MAMUL_KODU as 'Mamül' "
                    Netsis_SQL = Netsis_SQL + " , T6.HAM_KODU as 'İşemri BoM'"
                    Netsis_SQL = Netsis_SQL + " , T6.MIKTAR as 'Miktar'"
                    'Netsis_SQL = Netsis_SQL + " , T5.MAMUL_KODU as 'Mamül' "
                    Netsis_SQL = Netsis_SQL + " , T5.HAM_KODU as 'Ürge BoM' "
                    Netsis_SQL = Netsis_SQL + " , T5.MIKTAR as 'Miktar'"
                    Netsis_SQL = Netsis_SQL + " FROM LISTE A "
                    Netsis_SQL = Netsis_SQL + "              LEFT JOIN ["+currentDB+"].[dbo].TBLISEMRIREC AS T6 ON  T6.ISEMRINO = '" + herisemri + "'  AND T6.HAM_KODU=A.HAM_KODU  AND T6.GEC_FLAG=0  "
                    Netsis_SQL = Netsis_SQL + "              LEFT JOIN ["+currentDB+"].[dbo].TBLSTOKURM AS T5 ON T5.HAM_KODU=A.HAM_KODU AND   T5.MAMUL_KODU='"+search_bom+"'  AND T5.GEC_FLAG=0 "
                    Netsis_SQL = Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].TBLSTSABIT AS ST ON A.HAM_KODU=ST.STOK_KODU "
                    Netsis_SQL = Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].TBLSTOKKOD1 as K1 ON K1.GRUP_KOD=ST.KOD_1 "
                    Netsis_SQL = Netsis_SQL + "              WHERE T5.HAM_KODU IS NULL OR T6.HAM_KODU IS NULL ORDER BY A.HAM_KODU "

                    NetsisRecordSet.Open Netsis_SQL, NetsisConnection  
                        sira=0 
                        do until NetsisRecordSet.EOF OR sira>=1000 
                            if sira=0 then                         %>
                                <thead><tr> <%
                                Response.Write("<th>Sıra</th>")
                                for each x in  NetsisRecordSet.Fields
                                    Response.Write("<th>" & x.name & "</th>")
                                next                    %>
                                </tr></thead><tbody>  <%
                            end if 
                            sira=sira+1      
                            Response.Write(" <tr><td>"&sira&"</td>")
                            for each x in  NetsisRecordSet.Fields
                                Response.Write("<td class='text-nowrap '>" & x.value &"</td>")
                            next
                            NetsisRecordSet.MoveNext
                            Response.Write ("</tr>")
                        loop
                    NetsisRecordSet.close            
                next             
                Response.Write ("</tbody></table>")
                if sira=0 then response.write ("Fark bulunamadı...")     
                %>
            </div><%
        ' ------------------------------------ karşılaştır ende ---------------
    else 
        ' ------------------------------------ Reçete liste ---------------
            search_isemri = BeniKoddanArindir(request.form("search_isemri"))
            search_stok_kodu = BeniKoddanArindir(request.form("search_stok_kodu"))
             %>         
            <div class="container-fluid" style="margin-top:80px"> 
                <!-- #include file="./subs/dbcon.asp" -->
                    <form class="form-horizontal" method="POST" action="?doo=list">
                            <div class="container-fluid p-4">     <h3>İş Emri - Ürge Reçete Karşılaştırma</h3>

                                <div class="input-group">
                                    <input class="form-control" type="text" name="search_stok_kodu"  placeholder="SKU#"  value="<%=search_stok_kodu%>">
                                    <input class="form-control" type="text" name="search_isemri"  placeholder="İş Emri No"  value="<%=search_isemri%>">
                                    <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                                </div>
                            </div>                           
                        </form> 
            <%
            if len(search_stok_kodu&search_isemri)>0 then 

            

            %>
                <div class="container-fluid p-4"> 
                <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
                    <form class="form-horizontal" method="POST" action="?doo=compare">
                    <table class="table table-sm table-striped table-hover align-middle" id="tblData">        
                    
                    <%
                        ' SQL    
                            Netsis_SQL= " SELECT [ISEMRINO],[MAMUL_KODU],count(OPNO) as satir "
                            Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLISEMRIREC] "
                            Netsis_SQL=Netsis_SQL+" WHERE 1=1 "
                            if len(search_stok_kodu)>0 then      
                                    Netsis_SQL=Netsis_SQL+" AND MAMUL_KODU = '"&search_stok_kodu&"' "   
                            end if       

                            if len(search_isemri)>0 then     
                                if instr(search_isemri,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                                    Netsis_SQL=Netsis_SQL+" AND ISEMRINO LIKE '"&search_isemri&"' " 
                                else 
                                    Netsis_SQL=Netsis_SQL+" AND ISEMRINO LIKE '%" &search_isemri&"%' " 
                                end if 
                            end if                             
                            Netsis_SQL=Netsis_SQL+" group by  [ISEMRINO] ,[MAMUL_KODU] "
                            Netsis_SQL=Netsis_SQL+" order by ISEMRINO "
                        ' SQL ende            
                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection  
                            sira=0 
                            do until NetsisRecordSet.EOF OR sira>=10000
                                if sira=0 then                         %>
                                    <thead><tr> <%
                                    Response.Write("<th>Sıra</th><th> </th>")
                                    for each x in  NetsisRecordSet.Fields
                                        Response.Write("<th>" & x.name & "</th>")
                                    next                    %>
                                    </tr></thead><tbody>  <%
                                end if 
                                sira=sira+1      
                                Response.Write(" <tr><td>"&sira&"</td>")
                                                %>
                                                <td>
                                                <div class="input-group-text">
                                                    <input class="form-check-input mt-0" type="checkbox" id="search_isemri"  name="search_isemri" value="<%=NetsisRecordSet("ISEMRINO")%>" >
                                                </div>                                                                                
                                                </td>  
                                                <%       
                                for each x in  NetsisRecordSet.Fields
                                    'Response.Write(x.name)
                                    'Response.Write(" = ")
                                    Response.Write("<td>" & x.value & "</td>")
                                next
                                NetsisRecordSet.MoveNext
                            loop
                            Response.Write(" </tr> ")
                        NetsisRecordSet.close
                        %>
                        </tbody></table> 
                        <input class="btn btn-secondary" type="submit"  name="B2" value="Seçili Reçeteleri Karşılaştır">
                        </form> <%
                        if sira=0 then response.write ("Kayıt bulunamadı...")     
                        if sira=10000 then response.write ("<tr><td colspan=5>Max. 10000 kayıt görüntülendi.</td></tr>")     %> 
                    </table> 
                </div>
                <%
                end if
                %>
            </div> <%
        ' ---------------------------------- reçete liste ende
    end if
else
    Response.Write ("User level?")
end if
%> 
<script>
let table = new DataTable('#tblData', {
        "lengthMenu": [[ -1 , 10, 100 ], [ "All" , 10, 100]]
   // options
});

</script>
<!-- #include file="./include/footer.asp" -->