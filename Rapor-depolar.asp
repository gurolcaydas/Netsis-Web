<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Rapor-Depolar" %>
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
    <h3>Depolar</h3>
        <!-- #include file="./subs/dbcon.asp" -->

        <div class="container-fluid p-4"> 
        <button class="btn btn-success m-2" onclick="html_table_to_excel('xlsx','filename','tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
            <table class="table table-sm table-striped table-hover align-middle"  id="tblData">         <%
                ' SQL   
                    Netsis_SQL= " SELECT * from ["+currentDB+"].[dbo].[TBLSTOKDP] "
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
                            if x.name="SUBE_KODU" and x.value<>"1" then renkli=" bg-warning " else renkli=""
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
            if sira=1000 then response.write ("Max. 1000 kayıt görüntülendi.")       
            ' Response.Write (aaa)      
       %>        
    </div> <%
else
    Response.Write ("User level?")
end if
%> 
<script>
let table = new DataTable('#tblData', {
        "lengthMenu": [[-1, 10, 100], ["All", 10, 100]]
   // options
});

</script>
<!-- #include file="./include/footer.asp" -->