<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Template" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"s") then 'needed level'   %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
        <div class="container-fluid p-4"> <h3>Şube kodu veya İşletme kodu -1 olmayanlar</h3>
            <table class="table table-sm table-striped table-hover align-middle">         <%
                ' SQL   Rapor-CariStokEksik.asp

                    Netsis_SQL=" SELECT TOP (1000) A.SUBE_KODU, A.ISLETME_KODU  ,A.STOK_KODU,A.STOK_ADI,B.KAYITTARIHI, B.KAYITYAPANKUL,B.DUZELTMETARIHI,B.DUZELTMEYAPANKUL "
                    Netsis_SQL=Netsis_SQL+"   FROM ["+currentDB+"].[dbo].[TBLSTSABIT] A 																								  "
                    Netsis_SQL=Netsis_SQL+"   LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] B ON A.STOK_KODU=B.STOK_KODU																  "
                    Netsis_SQL=Netsis_SQL+"   WHERE A.SUBE_KODU!=-1 OR A.ISLETME_KODU!=-1																													  "

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
                            </tr></thead>  <%
                        end if 
                        sira=sira+1      
                        Response.Write(" <tr><td>"&sira&"</td>")
                        for each x in  NetsisRecordSet.Fields
                            'Response.Write(x.name)
                            'Response.Write(" = ")
                            Response.Write("<td>" & x.value & "</td>")
                        next
                        NetsisRecordSet.MoveNext
                    loop
                    Response.Write(" </tr> ")
                NetsisRecordSet.close
                Response.Write(" </table> ")

                if sira=0 then response.write ("Kayıt bulunamadı...")     
                if sira=1000 then response.write ("<tr><td colspan=5>Max. 1000 kayıt görüntülendi.</td></tr>")     %> 
            </table> 
        </div>
    </div> <%
else
    Response.Write ("User level?")
end if
%> 
<!-- #include file="./include/footer.asp" -->