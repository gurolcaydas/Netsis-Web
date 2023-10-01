<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="AX-Netsis Reçete Satır Kontrol" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level' 
        search_madde_kodu = BeniKoddanArindir(request.form("search_madde_kodu"))
        search_mamul_kodu = BeniKoddanArindir(request.form("search_mamul_kodu"))
  %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
        <div class="container-fluid p-4"> <h3></h3>

            
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"><h4>Reçete Satırı Birim Karşılaştır</h4>         
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_madde_kodu"  placeholder="Stok Kodu"  value="<%=search_madde_kodu%>">
                            <input class="form-control" type="text" name="search_mamul_kodu"  placeholder="Mamul Kodu"  value="<%=search_mamul_kodu%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
            
<%
if url_doo="list" then 
%>
                        <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>

            <table class="table table-sm table-striped table-hover align-middle" id="tblData">         <%
                ' SQL   Rapor-CariStokEksik.asp
                    Netsis_SQL=" Select CAST (Y.[HAM_KODU]+' '+Y.[MAMUL_KODU] as varchar(255)) as uniknetsis				   "
                    Netsis_SQL=Netsis_SQL+" 	,Y.[HAM_KODU],Y.[MAMUL_KODU],Y.[MIKTAR] as 'Recete_Miktari'														   "
                    Netsis_SQL=Netsis_SQL+" 	,E.[OLCU_BR1] as 'Birim'															   "
                    Netsis_SQL=Netsis_SQL+" 	,BOMQTY																				   "
                    Netsis_SQL=Netsis_SQL+" 	,UNITID																				   "
                    Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSTOKURM] Y													   "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] E ON Y.[HAM_KODU]=E.[STOK_KODU]				   "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN (																				   "
                    Netsis_SQL=Netsis_SQL+" 		SELECT CAST (BOM.ITEMID+' '+BV.ITEMID as varchar(255)) as unik ,BOMQTY,UNITID	   "
                    Netsis_SQL=Netsis_SQL+" 		  FROM [MicrosoftDynamicsAX].[dbo].[BOM] BOM 									   "
                    Netsis_SQL=Netsis_SQL+" 		  LEFT JOIN [MicrosoftDynamicsAX].[dbo].[BOMVERSION] BV ON BV.BOMID=BOM.BOMID	   "
                    Netsis_SQL=Netsis_SQL+" 		  WHERE BOM.ITEMID LIKE '"&search_madde_kodu&"' 										   "
                    Netsis_SQL=Netsis_SQL+" 		) LJ ON CAST (Y.[HAM_KODU]+' '+Y.[MAMUL_KODU] as varchar(255))=LJ.unik 			   "
                    Netsis_SQL=Netsis_SQL+" WHERE 1=1                                                    "
                    if LEN(search_madde_kodu)>0 THEN 
                        if instr(search_madde_kodu,"%") then 
                            Netsis_SQL=Netsis_SQL+" AND HAM_KODU LIKE '"&search_madde_kodu&"' "
                        else
                            Netsis_SQL=Netsis_SQL+" AND HAM_KODU LIKE '%"&search_madde_kodu&"%' "
                        end if 
                    end if
                    if LEN(search_mamul_kodu)>0 THEN 
                        if instr(search_madde_kodu,"%") then 
                        Netsis_SQL=Netsis_SQL+" AND MAMUL_KODU LIKE '"&search_mamul_kodu&"' "
                        else
                        Netsis_SQL=Netsis_SQL+" AND MAMUL_KODU LIKE '%"&search_mamul_kodu&"%' "
                        end if                     
                    end if
                ' SQL ende
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                    sira=0 
                    do until NetsisRecordSet.EOF OR sira>=1000
                        if sira=0 then                         %>
                            <thead><tr>
                            <th colspan=4></th>
                            <th colspan=2>Netsis</th>
                            <th colspan=2>Axapta</th>
                            </tr><tr> <%
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
            <%
            end if
            %>
        </div>
    </div> <%
else
    Response.Write ("User level?")
end if
%> 
<!-- #include file="./include/footer.asp" -->