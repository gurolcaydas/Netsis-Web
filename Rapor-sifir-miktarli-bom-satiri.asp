<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Sıfır Miktarlı BoM Satırları" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level'   %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
        <div class="container-fluid p-4"> <h3>Grup Kodu: CO1 olan,<br>Stok kodu ilk karakter 'Y' olan ve</br>KOD 2: 'Accell' olmayan.</h3>
            <table class="table table-sm table-striped table-hover align-middle">         <%
                ' SQL   Rapor-CariStokEksik.asp
                    Netsis_SQL="  SELECT TOP (1000) [INCKEYNO]		   "
                    Netsis_SQL=Netsis_SQL+"      ,[MAMUL_KODU]					   "
                    Netsis_SQL=Netsis_SQL+"      ,[HAM_KODU]					   "
                    Netsis_SQL=Netsis_SQL+"      ,[MIKTAR]						   "
                    Netsis_SQL=Netsis_SQL+"      ,[STOK_MALIYET]				   "
                    Netsis_SQL=Netsis_SQL+"      ,[KAYITYAPANKUL]				   "
                    Netsis_SQL=Netsis_SQL+"      ,[KAYITTARIHI]					   "
                    Netsis_SQL=Netsis_SQL+"      ,[DUZELTMEYAPANKUL]			   "
                    Netsis_SQL=Netsis_SQL+"      ,[DUZELTMETARIHI]				   "
                    Netsis_SQL=Netsis_SQL+"  FROM ["+currentDB+"].[dbo].[TBLSTOKURM]  "
                    Netsis_SQL=Netsis_SQL+"  WHERE MIKTAR=0 AND GEC_FLAG=0		   "
                    Netsis_SQL=Netsis_SQL+"  ORDER BY MAMUL_KODU, HAM_KODU 		   "
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