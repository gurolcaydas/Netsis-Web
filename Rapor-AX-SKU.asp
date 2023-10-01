<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<% BaslikHTML="Axapta Stok Kartları" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level' 
    search_madde_kodu = BeniKoddanArindir(request.form("search_madde_kodu"))
    search_madde_ad = BeniKoddanArindir(request.form("search_madde_ad"))
    search_madde = BeniKoddanArindir(request.form("search_madde")) %> 
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
                <div class="container-fluid p-4"><h4>Axapta Stok Kartları</h4> 
                    <div class="input-group">
                        <input class="form-control" type="text" name="search_madde_kodu" placeholder="SKU" value="<%=search_madde_kodu%>">
                        <input class="form-control" type="text" name="search_madde_ad" placeholder="Item Group ID" value="<%=search_madde_ad%>">
                        <input class="form-control" type="text" name="search_madde" placeholder="Description (TR)" value="<%=search_madde%>">
                        <input class="btn btn-secondary" type="submit" name="B1" value="Ara">
                    </div>
                </div> 
            </form>  
            <%
            if url_doo="list" and len(search_madde_kodu&search_madde_ad&search_madde) then 
                %>
                <button class="btn btn-success m-2" onclick="html_table_to_excel('xlsx','filename','tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
                <table class="table table-sm table-striped table-hover align-middle" id="tblData"> <%
                    ' SQL 
                        Netsis_SQL = Netsis_SQL +" SELECT A.ITEMID, A.COSTGROUPID, A.ITEMGROUPID, A.PRIMARYVENDORNAME, A.DS_VENDIDNAME, A.ERPPORTID, A.UNGTIP , D2.NAME as 'TR', D3.NAME as 'EN' "
                        Netsis_SQL = Netsis_SQL +" FROM [MicrosoftDynamicsAX].[dbo].[INVENTTABLE] A "
                        Netsis_SQL = Netsis_SQL +" LEFT JOIN  [MicrosoftDynamicsAX].[dbo].[INVENTTABLE] C2 ON C2.[ITEMID]=A.[ITEMID]						 "
                        Netsis_SQL = Netsis_SQL +" LEFT JOIN  (SELECT * FROM [MicrosoftDynamicsAX].[dbo].[ECORESPRODUCTTRANSLATION] WHERE LANGUAGEID='tr' ) D2 ON D2.[PRODUCT]=C2.[PRODUCT]  "
                        Netsis_SQL = Netsis_SQL +" LEFT JOIN  (SELECT * FROM [MicrosoftDynamicsAX].[dbo].[ECORESPRODUCTTRANSLATION] WHERE LANGUAGEID='en-us'  ) D3 ON D3.[PRODUCT]=C2.[PRODUCT]  "
                        Netsis_SQL = Netsis_SQL+"  WHERE  1=1 "                     
                        ' Mamul koduna göre ara
                            y=0
                            if len(search_madde_kodu)=0 then search_madde_kodu="%"
                            if instr(search_madde_kodu,"%")=0 then yuzde="%" else yuzde=""
                            if instr(search_madde_kodu," ") then 
                                Netsis_SQL=Netsis_SQL+" AND ("
                                a=Split(search_madde_kodu)
                                for each x in a
                                    if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                    Netsis_SQL=Netsis_SQL+" A.[ITEMID] LIKE '"+yuzde+x+yuzde+"'"
                                    y=1
                                next
                                Netsis_SQL=Netsis_SQL+") "
                            else
                            Netsis_SQL=Netsis_SQL+" AND A.[ITEMID] LIKE '"+yuzde+search_madde_kodu+yuzde+"' "
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
                                    Netsis_SQL=Netsis_SQL+" A.ITEMGROUPID LIKE '"+yuzde+x+yuzde+"'"
                                    y=1
                                next
                                Netsis_SQL=Netsis_SQL+") "
                            else
                            Netsis_SQL=Netsis_SQL+" AND A.ITEMGROUPID LIKE '"+yuzde+search_madde_ad+yuzde+"' "
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
                                    Netsis_SQL=Netsis_SQL+" D2.NAME LIKE '"+yuzde+x+yuzde+"'"
                                    y=1
                                next
                                Netsis_SQL=Netsis_SQL+") "
                            else
                            Netsis_SQL=Netsis_SQL+" AND D2.NAME LIKE '"+yuzde+search_madde+yuzde+"' "
                            end if
                        ' end madde koduna göre

                        Netsis_SQL=Netsis_SQL+"  ORDER BY A.ITEMGROUPID "
                    ' SQL ende
                    'Response.Write (Netsis_SQL)
                    NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                        sira=0 
                        do until NetsisRecordSet.EOF OR sira>=5000
                            if sira=0 then %>
                                <thead><tr> <%
                                Response.Write("<th>Sıra</th>")
                                for each x in NetsisRecordSet.Fields
                                    Response.Write("<th>" & x.name & "</th>")
                                next %>
                                </tr></thead> <%
                            end if 
                            sira=sira+1 
                            Response.Write(" <tr><td>"&sira&"</td>")
                            for each x in NetsisRecordSet.Fields
                                'Response.Write(x.name) 
                                'Response.Write(" = ")
                                Response.Write("<td>") ' # karekteri exceli yarıda kesiyor
                                if len(x.value)>0 then Response.Write(Replace(x.value, "#", "&bull;")) ' # karekteri exceli yarıda kesiyor
                                Response.Write("</td>") ' # karekteri exceli yarıda kesiyor
                            next
                            NetsisRecordSet.MoveNext
                        loop
                        Response.Write(" </tr> ")
                    NetsisRecordSet.close
                    Response.Write(" </table> ")

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
    "lengthMenu": [[ 20, 100 , -1], [  20, 100 , "All"]]
   // options
});

</script>
<!-- #include file="./include/footer.asp" -->