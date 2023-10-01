<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Mükerrer Fiyat Listesi Satırları" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"f") then 'needed level'   %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
        <div class="container-fluid p-4"> <h3>Mükerrer Fiyat Listesi Satırları</h3>
            <table class="table table-sm table-striped table-hover align-middle">         <%
                ' SQL   Rapor-CariStokEksik.asp
Netsis_SQL= " SELECT    																							 "
Netsis_SQL=Netsis_SQL+" A.[FIYATLISTEKODU]     																				 "
Netsis_SQL=Netsis_SQL+" ,A.[STOKKODU]     																					 "
Netsis_SQL=Netsis_SQL+" ,E.[GRUP_ISIM]     																					 "
Netsis_SQL=Netsis_SQL+" ,D.[STOK_ADI]     																					 "
Netsis_SQL=Netsis_SQL+" ,C.[CARI_ISIM]     																					 "
Netsis_SQL=Netsis_SQL+" ,COUNT(A.STOKKODU) as toplam																		 "
Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSTOKFIAT] A     														 "
Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLFIATGRUP] B ON B.[FGRUP]=A.[FIYATGRUBU]     						 "
Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLCASABIT] C ON B.[FGRUP]=C.[CARI_KOD]     							 "
Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] D ON D.[STOK_KODU]=A.[STOKKODU]     						 "
Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] E ON D.[KOD_1]=E.[GRUP_KOD]     							 "
Netsis_SQL=Netsis_SQL+" WHERE   A.BITTAR is null AND A.A_S='A' 																 "
Netsis_SQL=Netsis_SQL+" GROUP BY A.[FIYATLISTEKODU],A.[STOKKODU] ,C.[CARI_ISIM]         ,E.[GRUP_ISIM]     ,D.[STOK_ADI]     "
Netsis_SQL=Netsis_SQL+" HAVING  COUNT(A.STOKKODU)>1 																		 "
Netsis_SQL=Netsis_SQL+" ORDER BY A.FIYATLISTEKODU, A.STOKKODU																 "
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