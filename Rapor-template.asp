<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Rapor-template" %>
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
if instr(UserLevel,"m") then 'needed level'   

    str = (request.form("str")) 
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
                    <div class="container-fluid p-4"> <h3>Template</h3><h5>Template</h3>
                        <div class="input-group">
                            <textarea class="form-control z-depth-1" name="str" rows="3" placeholder="Stok Kodları"><%=str%></textarea>
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
        <% if LEN(str)>0 then  

        aranacak_stok_kodu=Replace(str, " ", "','")
        aranacak_stok_kodu="'"+aranacak_stok_kodu+"'"

      
        %>
        <div class="container-fluid p-4"> 
        <button class="btn btn-success m-2" onclick="html_table_to_excel('xlsx','filename','tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
            <table class="table table-sm table-striped table-hover align-middle"  id="tblData">         <%
                ' SQL   
                    Netsis_SQL=Netsis_SQL+" SELECT 																																									  "
                    Netsis_SQL=Netsis_SQL+" 	Y.STOK_KODU as 'Stok Kodu'																																			  "
                    Netsis_SQL=Netsis_SQL+" 	,Z.[FIYAT1] as 'Fiyat'																																				  "
                    Netsis_SQL=Netsis_SQL+" 	,Z.[FIYATDOVIZTIPI] AS 'Döviz Tipi'																																	  "
                    Netsis_SQL=Netsis_SQL+" 	,CASE																																								  "
                    Netsis_SQL=Netsis_SQL+" 		WHEN Z.[OLCUBR]=1  THEN Y.[OLCU_BR1]																															  "
                    Netsis_SQL=Netsis_SQL+" 		WHEN Z.[OLCUBR]=2  THEN Y.[OLCU_BR2]																															  "
                    Netsis_SQL=Netsis_SQL+" 		WHEN Z.[OLCUBR]=3  THEN Y.[OLCU_BR3]																															  "
                    Netsis_SQL=Netsis_SQL+" 		ELSE NULL																																						  "
                    Netsis_SQL=Netsis_SQL+" 	END AS 'Fiyat Listesindeki Birim'																																	  "
                    Netsis_SQL=Netsis_SQL+" 	,G.GRUP_ISIM as 'Maliyet Grubu'																																		  "
                    Netsis_SQL=Netsis_SQL+" 	,CS.CARI_KOD as 'Cari Kod'																																			  "
                    Netsis_SQL=Netsis_SQL+" 	,LC.ORAN as 'Maliyet Katsayısı'																																		  "
                    Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].TBLSTSABIT Y																																						  "
                    Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT TOP 1 [FIYAT1],[FIYATDOVIZTIPI],[OLCUBR] FROM ["+currentDB+"].[dbo].[TBLSTOKFIAT] WITH (NOLOCK)  WHERE  Y.STOK_KODU=[STOKKODU] ORDER BY [BASTAR] DESC) Z "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD4] G WITH (NOLOCK)  ON Y.[KOD_4]=G.[GRUP_KOD]																					   "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLCARISTOK] CS WITH (NOLOCK)  ON Y.STOK_KODU=CS.STOK_KODU AND CS.CARI_KOD is not null													   "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[PLT_LANDING_RATIO] LC WITH (NOLOCK)  ON Y.[KOD_4]=LC.CGI AND  CS.CARI_KOD=LC.CARI_KOD														   "
                    Netsis_SQL=Netsis_SQL+" WHERE Y.STOK_KODU IN ("+aranacak_stok_kodu+")																																	   "                    
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
                            </tr></thead><tbody>  <%
                        end if 
                        sira=sira+1      
                        Response.Write(" <tr><td>"&sira&"</td>")
                        for each x in  NetsisRecordSet.Fields
                            'Response.Write(x.name)
                            'Response.Write(" = ")
                            Response.Write("<td class='text-nowrap'>" & x.value &"</td>")
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
            if sira=1000 then response.write ("Max. 1000 kayıt görüntülendi.")       
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