<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Stok kartı - Cari hesap bağlantısı" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"a") then 'needed level'   %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
        <div class="container-fluid p-4"> <h5>Grup Kodu: CO1 olan,<br>Stok kodu ilk karakter 'Y' olmayan ve<br>KOD 2: 'Accell' olmayan.</h5>
           <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
            <table class="table table-sm table-striped table-hover align-middle" id="tblData">         <%
                ' SQL   Rapor-CariStokEksik.asp
                    Netsis_SQL= "SELECT  top 1000																				 "
                    Netsis_SQL=Netsis_SQL+" A.[STOK_KODU]																	 "
                    Netsis_SQL=Netsis_SQL+" ,B.[STOK_ADI]																		 "
                    Netsis_SQL=Netsis_SQL+" ,A.[CARI_KOD]																	 "
                    Netsis_SQL=Netsis_SQL+" ,A.[CARISTOK_KODU]																 "
                    Netsis_SQL=Netsis_SQL+" ,B.KOD_2																			 "
                    Netsis_SQL=Netsis_SQL+" ,G.[GRUP_ISIM]																	 "
                    Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLCARISTOK] A											 "
                    Netsis_SQL=Netsis_SQL+" RIGHT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] B ON B.STOK_KODU=A.STOK_KODU			 "
                    Netsis_SQL=Netsis_SQL+" RIGHT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD2] G ON G.GRUP_KOD=B.KOD_2				 "
                    Netsis_SQL=Netsis_SQL+" WHERE   LEFT(A.STOK_KODU,1) !='Y' AND B.GRUP_KODU='CO1' AND G.[GRUP_ISIM]!='Accell' "
                    Netsis_SQL=Netsis_SQL+" AND A.STOK_KODU IN (																 "
                    Netsis_SQL=Netsis_SQL+" SELECT 																			 "
                    Netsis_SQL=Netsis_SQL+" A.[STOK_KODU]																	 "
                    Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLCARISTOK] A											 "
                    Netsis_SQL=Netsis_SQL+" RIGHT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] B ON B.STOK_KODU=A.STOK_KODU			 "
                    Netsis_SQL=Netsis_SQL+" WHERE   LEFT(A.STOK_KODU,1) !='Y' AND B.GRUP_KODU='CO1'							 "
                    Netsis_SQL=Netsis_SQL+" GROUP BY A.[STOK_KODU]																 "
                    Netsis_SQL=Netsis_SQL+" HAVING COUNT (A.[STOK_KODU])=1														 "
                    Netsis_SQL=Netsis_SQL+" )	ORDER BY A.STOK_KODU																				 "
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