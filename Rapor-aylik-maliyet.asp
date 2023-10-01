<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Rapor-Stok Maliyetleri Raporu" %>
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
    
<%
if instr(UserLevel,"s") then 'needed level'   

    str = (request.form("str")) 
    date1 = (request.form("date1")) 
    date2 = (request.form("date2")) 
        ' for x=1 to len(str)
        '     aaa = aaa & (asc(mid(str,x,1)) & "*")
        ' next
        str=Replace(str,vbCrLf, " ")       
        str=Replace(str,Chr(9), " ")        
        str=Replace(str,Chr(10), " ")        
        str=Replace(str,Chr(11), " ")        
        str=Replace(str,Chr(12), " ")        
        str=Replace(str,Chr(13), " ")        
        str=Replace(str,Chr(44), " ")        
        str=Replace(str, """", " ")
        str=Replace(str, "'", " ")
        str=Replace(str, "‚", " ")
    
        i=0
            Do While i<>LEN(str) ' çift space kontrol
                    i=LEN(str)
                    str=Replace(str, "  ", " ")
            Loop
        str=trim(str)

        ' aaa=aaa & "*<br>*"
        ' for x=1 to len(str)
        '     aaa = aaa & (asc(mid(str,x,1)) & "*")
        ' next 
    
    
    %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"> <h5>Stok Maliyetleri Raporu</h3>
                        <div class="input-group">
                            <textarea class="form-control z-depth-1" name="str" rows="1" placeholder="Stok Kodları"><%=str%></textarea>
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
        <% 
        if LEN(str)>0 then  
        aranacak_stok_kodu=Replace(str, " ", "','")
        aranacak_stok_kodu="'"+aranacak_stok_kodu+"'"

      
            %>
            <div class="container-fluid p-4"> 
            <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel eski</button>                
            <button class="btn btn-success m-2" onclick="html_table_to_excel('xlsx','filename','tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
                <table class="table table-sm table-striped table-hover align-middle"  id="tblData">         <%
                    ' SQL   
                        Netsis_SQL =              " select * from ( "
                        Netsis_SQL = Netsis_SQL + " 	SELECT DISTINCT  "
                        Netsis_SQL = Netsis_SQL + " 		A.STOK_KODU as 'Stok', "
                        Netsis_SQL = Netsis_SQL + " 		A.STHAR_GCKOD as 'Islem', "
                        Netsis_SQL = Netsis_SQL + " 		CASE  "
                        Netsis_SQL = Netsis_SQL + " 			when A.STHAR_GCKOD='C' then A.STHAR_IAF  "
                        Netsis_SQL = Netsis_SQL + " 			else A.STHAR_NF  "
                        Netsis_SQL = Netsis_SQL + " 			end as 'Fiyat' , "
                        Netsis_SQL = Netsis_SQL + " 		month(A.STHAR_TARIH) as 'Ay' "
                        Netsis_SQL = Netsis_SQL + " 	FROM ["+currentDB+"].[dbo].[TBLSTHAR] A "
                        Netsis_SQL = Netsis_SQL + " 	WHERE 1=1  " 
                        Netsis_SQL = Netsis_SQL + " 	AND A.STOK_KODU IN ("+aranacak_stok_kodu+")  " 
                        Netsis_SQL = Netsis_SQL + " 		AND (A.STHAR_HTUR not in ('B') OR STHAR_ACIKLAMA='050-ACCELL' OR STHAR_ACIKLAMA='DAT-001') "
                        Netsis_SQL = Netsis_SQL + " 		AND (SUBE_KODU = 1 OR SUBE_KODU = 2) "
                        Netsis_SQL = Netsis_SQL + " 		AND (A.STHAR_IAF>0 OR ( A.STHAR_GCKOD='G' and A.STHAR_NF>0)) "
                        Netsis_SQL = Netsis_SQL + " 	GRoUP BY  "
                        Netsis_SQL = Netsis_SQL + " 		A.STOK_KODU, "
                        Netsis_SQL = Netsis_SQL + " 		A.STHAR_GCKOD, "
                        Netsis_SQL = Netsis_SQL + " 		A.STHAR_IAF , "
                        Netsis_SQL = Netsis_SQL + " 		A.STHAR_NF , "
                        Netsis_SQL = Netsis_SQL + " 		month(A.STHAR_TARIH)	 "
                        Netsis_SQL = Netsis_SQL + " ) as liste "
                        Netsis_SQL = Netsis_SQL + " PIVOT (min(Fiyat) FOR Ay IN  (  [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) pivot_table "
                        Netsis_SQL = Netsis_SQL + " ORDER BY Stok "
                                                                                            
                    ' SQL ende

                    NetsisRecordSet.Open Netsis_SQL, NetsisConnection  
                        sira=0 
                        do until NetsisRecordSet.EOF  
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
                            renkli="" 
                                if x.value="G" then renkli=" bg-warning "
                                'Response.Write(" = ")
                                Response.Write("<td class='text-nowrap "&renkli&"'>" & x.value &"</td>")
                            next
                            NetsisRecordSet.MoveNext
                        loop
                        Response.Write(" </tr> ")
                    NetsisRecordSet.close
                    %> 
                </tbody>
                </table> 
            </div>
            <% 
            if sira=0 then response.write ("Kayıt bulunamadı...")     
            ' Response.Write (aaa)      
        end if %>        
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