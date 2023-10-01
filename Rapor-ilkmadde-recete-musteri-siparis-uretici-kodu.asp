<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Üretici Kodu-Mamül-Sipariş" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"s") then 'needed level' 
        search_madde_kodu = BeniKoddanArindir(request.form("search_madde_kodu"))
  %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
        <div class="container-fluid p-4"> <h3></h3>

            
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"><h4>Üretici koduna göre en üst reçetenin (mamül) müşteri siparişleri</h4>         
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_madde_kodu"  placeholder="Üretici Stok Kodu"  value="<%=search_madde_kodu%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
            
<%
if url_doo="list" then 
%>
            <table class="table table-sm table-striped table-hover align-middle">         <%
                ' SQL   Rapor-CariStokEksik.asp
                    Netsis_SQL=" With Liste as (																		   "
                    Netsis_SQL=Netsis_SQL+" 	SELECT  																			   "
                    Netsis_SQL=Netsis_SQL+" 		CAST(A.[OPNO] as varchar(250)) as SortOrder										   "
                    Netsis_SQL=Netsis_SQL+" 		,CAST(1 AS INT) as LeveL														   "
                    Netsis_SQL=Netsis_SQL+" 		,CAST(A.[MAMUL_KODU] as varchar(250)) as anamamul								   "
                    Netsis_SQL=Netsis_SQL+" 		,A.[MAMUL_KODU] 																   "
                    Netsis_SQL=Netsis_SQL+" 		,A.[HAM_KODU]																	   "
                    Netsis_SQL=Netsis_SQL+" 		,A.[MIKTAR]																		   "
                    Netsis_SQL=Netsis_SQL+" 		,A.[GEC_FLAG]																	   "
                    Netsis_SQL=Netsis_SQL+" 		,A.[STOK_MALIYET]																   "
                    Netsis_SQL=Netsis_SQL+" 	FROM ["+currentDB+"].[dbo].[TBLSTOKURM] A												   "
                    Netsis_SQL=Netsis_SQL+" 	WHERE  [GEC_FLAG]=0																	   "
                    Netsis_SQL=Netsis_SQL+" 	UNION ALL																			   "
                    Netsis_SQL=Netsis_SQL+" 	SELECT  																			   "
                    Netsis_SQL=Netsis_SQL+" 		CAST(C.[SortOrder] +'.'+ B.[OPNO] as varchar(250)) as Sort2						   "
                    Netsis_SQL=Netsis_SQL+" 		, CAST(C.[LeveL]+1 as INT) as Level2											   "
                    Netsis_SQL=Netsis_SQL+" 		,CAST(C.anamamul as varchar(250)) as anamamul2									   "
                    Netsis_SQL=Netsis_SQL+" 		,B.[MAMUL_KODU]																	   "
                    Netsis_SQL=Netsis_SQL+" 		,B.[HAM_KODU]																	   "
                    Netsis_SQL=Netsis_SQL+" 		,B.[MIKTAR]																		   "
                    Netsis_SQL=Netsis_SQL+" 		,B.[GEC_FLAG]																	   "
                    Netsis_SQL=Netsis_SQL+" 		,B.[STOK_MALIYET]																   "
                    Netsis_SQL=Netsis_SQL+" 	FROM ["+currentDB+"].[dbo].[TBLSTOKURM] B												   "
                    Netsis_SQL=Netsis_SQL+" 	JOIN Liste as C on C.[HAM_KODU] = B.[MAMUL_KODU]									   "
                    Netsis_SQL=Netsis_SQL+" 	)																					   "
                    Netsis_SQL=Netsis_SQL+" SELECT 																				   "
                    Netsis_SQL=Netsis_SQL+" 	Y.SortOrder as 'Sort_order'															   "
                    Netsis_SQL=Netsis_SQL+" 	,Y.anamamul																			   "
                    Netsis_SQL=Netsis_SQL+" 	,Y.Level as 'Seviye'																   "
                    Netsis_SQL=Netsis_SQL+" 	,Y.[MAMUL_KODU] as 'Recete'															   "
                    Netsis_SQL=Netsis_SQL+" 	,Y.[HAM_KODU] as 'Madde_kodu'														   "
                    Netsis_SQL=Netsis_SQL+" 	,G.[GRUP_ISIM] as 'Madde_grubu'														   "
                    Netsis_SQL=Netsis_SQL+" 	,E.[STOK_ADI] as 'Stok_Adi'															   "
                    Netsis_SQL=Netsis_SQL+" 	,Y.[MIKTAR] as 'Miktar_'															   "
                    Netsis_SQL=Netsis_SQL+" 	,E.[OLCU_BR1] as 'Birim'															   "
                    Netsis_SQL=Netsis_SQL+" 	,Y.[STOK_MALIYET] as 'isaret'														   "
                    Netsis_SQL=Netsis_SQL+" 	,G2.[STHAR_GCMIK]	as 'Sip. Miktarı'																   "
                    Netsis_SQL=Netsis_SQL+" 	,FORMAT (G2.[IRSALIYE_TARIH], 'dd/MM/yyyy ')as 'Tarih'					   "
                    Netsis_SQL=Netsis_SQL+" 	,G3.[SUBE_KODU]	as 'Şube'														   "
                    Netsis_SQL=Netsis_SQL+" from Liste Y																			   "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] E ON Y.[HAM_KODU]=E.[STOK_KODU]			   "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLOPERATIONS_KATALOG] H ON Y.[HAM_KODU]=H.[OPKODU]	   "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD4] G ON E.[KOD_4]=G.[GRUP_KOD]				   "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSIPATRA] G2 ON G2.STOK_KODU=Y.anamamul 			   "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSIPAMAS] G3 ON G3.FATIRS_NO=G2.FISNO				   "
                    Netsis_SQL=Netsis_SQL+" WHERE  E.URETICI_KODU='"&search_madde_kodu&"' AND G2.[STHAR_GCMIK] is not null AND G3.[SUBE_KODU]=1 "
                    Netsis_SQL=Netsis_SQL+" ORDER BY G2.[IRSALIYE_TARIH] DESC,anamamul "

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