<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Stok kartı - Cari hesap bağlantısı" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"u") then 'needed level'   %>         
    <div class="container-fluid" style="margin-top:80px"> <%
        %>
        <!-- #include file="./subs/dbcon.asp" -->
        <%
        search_bisiklet = BeniKoddanArindir(request.form("search_bisiklet"))
        search_bisiklet_kodu = BeniKoddanArindir(request.form("search_bisiklet_kodu"))
        search_maliyet = BeniKoddanArindir(request.form("search_maliyet"))
        search_cari = BeniKoddanArindir(request.form("search_cari"))

        if url_doo="" or url_doo="list" then

            %>
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"><h4>Stok kartı - Tedarikçi bağlantısı</h4>         
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_bisiklet_kodu" placeholder="Stok kodu"  value="<%=search_bisiklet_kodu%>">
                            <input class="form-control" type="text" name="search_bisiklet"  placeholder="Açıklama"  value="<%=search_bisiklet%>">
                            <input class="form-control" type="text" name="search_maliyet"  placeholder="Maliyet Grubu"  value="<%=search_maliyet%>">
                            <input class="form-control" type="text" name="search_cari"  placeholder="Cari"  value="<%=search_cari%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
            <%
        end if

        if url_doo="list" then 'Sadece cari ve liste numaması ile arama'
            ' SQL 
            Netsis_SQL= "	SELECT 		TOP 1000																										"
            Netsis_SQL=Netsis_SQL + "	A.[STOK_KODU] , A.[URETICI_KODU]																										"
            Netsis_SQL=Netsis_SQL + "	,STOK_ADI 																											"
            Netsis_SQL=Netsis_SQL + "	,A.GRUP_KODU																										"
            Netsis_SQL=Netsis_SQL + "	,B1.[GRUP_ISIM] as Madde_grup																						"
            Netsis_SQL=Netsis_SQL + "	,B2.[GRUP_ISIM] as Marka																							"
            Netsis_SQL=Netsis_SQL + "	,B4.[GRUP_ISIM] as Maliyet_grup																						"
            Netsis_SQL=Netsis_SQL + "	,B.CARI_KOD																											"
            Netsis_SQL=Netsis_SQL + "	,C.CARI_ISIM																										"
            Netsis_SQL=Netsis_SQL + "	,AX.PRIMARYVENDORID	"
            Netsis_SQL=Netsis_SQL + "	,AX.PRIMARYVENDORNAME	"
            Netsis_SQL=Netsis_SQL + "	,AX.DS_VENDID	"
            Netsis_SQL=Netsis_SQL + "	,AX.DS_VENDIDNAME	"
            Netsis_SQL=Netsis_SQL + "	FROM ["+currentDB+"].[dbo].[TBLSTSABIT] A																				"
            Netsis_SQL=Netsis_SQL + "	LEFT JOIN  ["+currentDB+"].[dbo].[TBLSTOKKOD1] B1 ON B1.GRUP_KOD=KOD_1													"
            Netsis_SQL=Netsis_SQL + "	LEFT JOIN  ["+currentDB+"].[dbo].[TBLSTOKKOD2] B2 ON B2.GRUP_KOD=KOD_2													"
            Netsis_SQL=Netsis_SQL + "	LEFT JOIN  ["+currentDB+"].[dbo].[TBLSTOKKOD4] B4 ON B4.GRUP_KOD=KOD_4													"
            Netsis_SQL=Netsis_SQL + "	LEFT JOIN (SELECT * FROM ["+currentDB+"].[dbo].[TBLCARISTOK] WHERE CARI_KOD is not null) B ON B.Stok_KODU=A.Stok_KODU	"
            Netsis_SQL=Netsis_SQL + "	LEFT JOIN ["+currentDB+"].[dbo].[TBLCASABIT] C ON C.CARI_KOD=B.CARI_KOD												"
            Netsis_SQL=Netsis_SQL + "	LEFT JOIN MicrosoftDynamicsAX.dbo.INVENTTABLE AX ON AX.ITEMID=A.STOK_KODU"
            Netsis_SQL=Netsis_SQL + "    WHERE 1=1 																											"

                if len(search_cari)>0 then     
                    if instr(search_cari,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND [CARI_ISIM] LIKE '" &search_cari&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND [CARI_ISIM] LIKE '%" &search_cari&"%' " 
                    end if 
                end if 
                if len(search_bisiklet)>0 then     
                    if instr(search_bisiklet,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND [STOK_ADI] LIKE '" &search_bisiklet&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND [STOK_ADI] LIKE '%" &search_bisiklet&"%' " 
                    end if 
                end if 
                if len(search_bisiklet_kodu)>0 then     
                    if instr(search_bisiklet_kodu,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND A.[STOK_KODU] LIKE '" &search_bisiklet_kodu&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND A.[STOK_KODU] LIKE '%" &search_bisiklet_kodu&"%' " 
                    end if 
                end if 
                if len(search_maliyet)>0 then     
                    if instr(search_maliyet,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND B4.[GRUP_ISIM] LIKE '" &search_maliyet&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND B4.[GRUP_ISIM] LIKE '%" &search_maliyet&"%' " 
                    end if 
                end if                 
            ' SQL ende
            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
            sira=0 
                do until NetsisRecordSet.EOF OR sira>=1000
                    if sira=0 then %>
                        <div class="container-fluid p-4"> 
                        <table class="table table-sm table-striped table-hover align-middle">
                        <thead><tr>
                        <th>Sıra</th>
                        <th>Stok Kodu</th>
                        <th>Üretici Kodu</th>
                        <th>Açıklama</th>
                        <th>Grup Kodu</th>
                        <th>Madde Grubu<br>Kod 1</th>
                        <th>Kod 2</th>
                        <th>Maliyet Grubu<br>Kod 4</th>
                        <th>Cari Kod</th>
                        <th>Cari</th>
                        <th><span style="color:red;">AX 1.Cari</span></th>
                        <th><span style="color:red;">AX 1.Cari</span></th>
                        <th><span style="color:red;">AX 2.Cari</span></th>
                        <th><span style="color:red;">AX 2.Cari</span></th>
                        </tr></thead>  <%
                    end if 
                    sira=sira+1                                     %>
                    <tr>
                        <td class="text-secondary"><%=sira%></td>
                        <td ><strong><%=NetsisRecordSet("STOK_KODU")%></strong></td>
                        <td class="small"><%=NetsisRecordSet("URETICI_KODU")%></td>
                        <td class="small"><%=NetsisRecordSet("STOK_ADI")%></td>
                        <td class="small"><%=NetsisRecordSet("GRUP_KODU")%></td>
                        <td class="small"><%=NetsisRecordSet("Madde_grup")%></td>
                        <td class="small"><%=NetsisRecordSet("Marka")%></td>
                        <td class="small"><%=NetsisRecordSet("Maliyet_grup")%></td>
                        <td class="small"><%=NetsisRecordSet("CARI_KOD")%></td>
                        <td class="small"><strong><%=NetsisRecordSet("CARI_ISIM")%></strong></td>
                        <td class="small"><span style="color:red;"><%=NetsisRecordSet("PRIMARYVENDORID")%></span></td>
                        <td class="small"><span style="color:red;"><%=NetsisRecordSet("PRIMARYVENDORNAME")%></span></td>
                        <td class="small"><span style="color:red;"><%=NetsisRecordSet("DS_VENDID")%></span></td>
                        <td class="small"><span style="color:red;"><%=NetsisRecordSet("DS_VENDIDNAME")%></span></td>
		                        
                    </tr>                             <%
                    NetsisRecordSet.movenext
                Loop                                                
            NetsisRecordSet.close  
            if sira=0 then response.write ("Kayıt bulunamadı...")     
            if sira=1000 then response.write ("<tr><td colspan=5>Max. 1000 kayıt görüntülendi.</td></tr>")     %> 
            </table> </div><%
        end if  	
        %> 

    </div> <%
else
    Response.Write ("User level?")
end if
%> 
<!-- #include file="./include/footer.asp" -->