<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Mamül - Yarı Mamül." %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"u") then 'needed level'   

    search_mamul_kodu = BeniKoddanArindir(request.form("search_mamul_kodu"))
    search_yari_mamul_kodu = BeniKoddanArindir(request.form("search_yari_mamul_kodu")) %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"> <h3>Mamül - Yarı Mamül.</h3>
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_mamul_kodu"  placeholder="Mamül Kodu"  value="<%=search_mamul_kodu%>">
                            <input class="form-control" type="text" name="search_yari_mamul_kodu"  placeholder="Yarı Mamül Kodu"  value="<%=search_yari_mamul_kodu%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
        <div class="container-fluid p-4"> 
            <table class="table table-sm table-striped table-hover align-middle">         <%
                ' SQL   Rapor-CariStokEksik.asp
                    Netsis_SQL= "SELECT  top 1000																				 "
                    Netsis_SQL=Netsis_SQL+"       A.[MAMUL_KODU] as 'Mamül Kodu'														  "
                    Netsis_SQL=Netsis_SQL+" 	  ,MM.[STOK_ADI] as 'Mamül Açıklaması'														  "
                    Netsis_SQL=Netsis_SQL+"       ,A.[HAM_KODU]	 as 'Madde Kodu'														  "
                    Netsis_SQL=Netsis_SQL+" 	  ,HM.[STOK_ADI]	as 'Stok Açıklaması'													  "
                    Netsis_SQL=Netsis_SQL+" 	,K1.GRUP_ISIM as 'Madde Grubu' "
                    Netsis_SQL=Netsis_SQL+"       ,A.[MIKTAR] as 'Miktar'											  "
                    Netsis_SQL=Netsis_SQL+"       ,A.[GEC_FLAG] as 'BoMdan Silinmiş'									  "
                    Netsis_SQL=Netsis_SQL+"   FROM ["+currentDB+"].[dbo].[TBLSTOKURM] A WITH (NOLOCK)									  "
                    Netsis_SQL=Netsis_SQL+"   LEFT JOIN  ["+currentDB+"].[dbo].[TBLSTSABIT] HM WITH (NOLOCK) ON HM.STOK_KODU=A.HAM_KODU	  "
                    Netsis_SQL=Netsis_SQL+"   LEFT JOIN  ["+currentDB+"].[dbo].[TBLSTSABIT] MM WITH (NOLOCK) ON MM.STOK_KODU=A.MAMUL_KODU "
                    Netsis_SQL=Netsis_SQL+"   LEFT JOIN   ["+currentDB+"].[dbo].[TBLSTOKKOD1] K1 WITH (NOLOCK) ON K1.GRUP_KOD=HM.KOD_1	  "
                    Netsis_SQL=Netsis_SQL+"   WHERE 1=1 "
                    Netsis_SQL=Netsis_SQL+"   AND ( HAM_KODU='"&search_yari_mamul_kodu&"' OR MAMUL_KODU='"&search_mamul_kodu&"'	)"
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