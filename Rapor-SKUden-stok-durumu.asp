<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Stok Durumu" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level'   


    str = temizle(request.form("search_is_emri")) 
    %>         
    <div class="container-fluid" style="margin-top:80px;"> 
        <!-- #include file="./subs/dbcon.asp" -->
        <form class="form-horizontal d-print-none" method="POST" action="?doo=list">
            <div class="container-fluid p-4"> <h3>Stok Durumu</h3>
                <div class="input-group">
                    <textarea class="form-control z-depth-1" name="search_is_emri" rows="3" placeholder="Madde Kodları"><%=str%></textarea>
                    <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                </div>
            </div>                           
        </form>  <%  
        if LEN(str)>0 then   %>
            <div class="container-fluid p-4"  > 
                <table class="table table-sm table-striped table-hover align-middle"  id="tblData"> 
                    <%          


                    Netsis_SQL = " SELECT  [DEPO_KODU]  FROM ["+currentDB+"].[dbo].[TBLSTOKDP] WHERE SUBE_KODU=1 ORDER BY [DEPO_KODU] "
                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                            sira=0 
                            do until NetsisRecordSet.EOF 
                                depolar=depolar & "["&NetsisRecordSet("DEPO_KODU")&"],"
                                NetsisRecordSet.MoveNext
                            loop
                        NetsisRecordSet.close               
                        depolar=left(depolar,len(depolar)-1)             
                    a=Split(str)
                    sira=0 
                    for each xisemri in a
                                    ' SQL
                                        Netsis_SQL=" WITH liste as ( SELECT "
                                        Netsis_SQL=Netsis_SQL+" A.[STOK_KODU] "
                                        'Netsis_SQL=Netsis_SQL+" ,A.[SUBE_KODU] "
                                        ' Netsis_SQL=Netsis_SQL+" ,B.[DEPO_ISMI] " 
                                        'Netsis_SQL=Netsis_SQL+" ,C.[STOK_ADI] " 
                                        Netsis_SQL=Netsis_SQL+" ,B.[DEPO_KODU] " 
                                        ' Netsis_SQL=Netsis_SQL+" ,[CEVRIM] "

                                        Netsis_SQL=Netsis_SQL+" ,sum([TOP_GIRIS_MIK]-[TOP_CIKIS_MIK]) as Toplam "
                                        ' Netsis_SQL=Netsis_SQL+" ,[STOK_DAGITIM] "
                                        ' Netsis_SQL=Netsis_SQL+" ,[MUS_TOP_SIPARIS] "
                                        ' Netsis_SQL=Netsis_SQL+" ,[SAT_TOP_SIPARIS] "
                                        Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSTOKPH] A "
                                        Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] C ON A.[STOK_KODU]=C.[STOK_KODU] " 
                                        Netsis_SQL=Netsis_SQL+" INNER JOIN ["+currentDB+"].[dbo].[TBLSTOKDP] B ON A.[DEPO_KODU]=B.[DEPO_KODU] " 
                                        Netsis_SQL=Netsis_SQL+" WHERE A.[STOK_KODU]='"&xisemri&"' AND A.[SUBE_KODU]=1  "
                                        Netsis_SQL=Netsis_SQL+" GROUP BY   A.[STOK_KODU] , A.[SUBE_KODU], B.[DEPO_ISMI], B.[DEPO_KODU],C.[STOK_ADI]   )"
                                    Netsis_SQL=Netsis_SQL+" SELECT * from liste "
                                    Netsis_SQL=Netsis_SQL+" PIVOT (sum(toplam) FOR [DEPO_KODU] IN ("&depolar&")) as P "                                              
                                    ' SQL ende                                       
                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                                sira2=0
                            do until NetsisRecordSet.EOF OR sira>=1000
                                if sira=0 then                         %>
                                    <thead><tr> <%
                                    Response.Write("<th>Sıra</th>")
                                    for each x in  NetsisRecordSet.Fields
                                        Response.Write("<th>" & x.name & "</th>")
                                    next                    %>
                                    </tr></thead>  <%
                                end if 
                                sira=sira+1   
                                sira2=sira2+1   
                                Response.Write(" <tr><td>"&sira&"</td>")
                                for each x in  NetsisRecordSet.Fields
                                    'Response.Write(x.name)
                                    'Response.Write(" = ")
                                    Response.Write("<td class='text-center'>" & x.value & "</td>")
                                next
                                NetsisRecordSet.MoveNext
                            loop
                        NetsisRecordSet.close
                                if sira2=0 then Stok_yok = Stok_yok & " - " &xisemri   
                    next   %> 
                </table> 
            </div> <% 
            Response.Write ("Stokta yok: " & Stok_yok )
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