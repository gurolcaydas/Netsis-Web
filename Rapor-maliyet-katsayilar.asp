<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Maliyet Katsayıları" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"s") then 'needed level'  
        search_madde_kodu = BeniKoddanArindir(request.form("search_madde_kodu"))
        search_cari = BeniKoddanArindir(request.form("search_cari"))
        search_cari_kod = BeniKoddanArindir(request.form("search_cari_kod"))

 %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->

                <form class="form-horizontal" method="POST" action="?doo=list">
        <div class="container-fluid p-4"> <h3>Maliyet Katsayıları.</h3>
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_madde_kodu"  placeholder="Maliyet Grubu"  value="<%=search_madde_kodu%>">
                            <input class="form-control" type="text" name="search_cari_kod"  placeholder="Cari Hesap Kodu"  value="<%=search_cari_kod%>">
                            <input class="form-control" type="text" name="search_cari"  placeholder="Cari Hesap"  value="<%=search_cari%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 



            <table class="table table-sm table-striped table-hover align-middle">         <%
                ' SQL   Rapor-CariStokEksik.asp
Netsis_SQL=Netsis_SQL+" SELECT 	TOP 1000   												  "
Netsis_SQL=Netsis_SQL+" 	A.[CGI]																  "
Netsis_SQL=Netsis_SQL+" 	,B.GRUP_ISIM														  "
Netsis_SQL=Netsis_SQL+"     ,A.[CARI_KOD]														  "
Netsis_SQL=Netsis_SQL+" 	,C.CARI_ISIM														  "
Netsis_SQL=Netsis_SQL+"     ,A.[ORAN]															  "
Netsis_SQL=Netsis_SQL+"     ,A.[STATUS]															  "
Netsis_SQL=Netsis_SQL+"   FROM ["+currentDB+"].[dbo].[PLT_LANDING_RATIO] A							  "
Netsis_SQL=Netsis_SQL+"   LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD4] B ON B.GRUP_KOD=A.CGI		  "
Netsis_SQL=Netsis_SQL+"   LEFT JOIN ["+currentDB+"].[dbo].[TBLCASABIT] C ON C.CARI_KOD=A.CARI_KOD	  "
Netsis_SQL=Netsis_SQL+"   where B.GRUP_ISIM LIKE '%"&search_madde_kodu&"%' AND C.CARI_KOD LIKE '%"&search_cari_kod&"%'    AND C.CARI_ISIM LIKE '%"&search_cari&"%'                "
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