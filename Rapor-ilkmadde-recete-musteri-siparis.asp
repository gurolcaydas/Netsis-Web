<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="İlk madde-Mamül-Sipariş" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"r") then 'needed level' 
    search_madde_kodu = BeniKoddanArindir(request.form("search_madde_kodu"))   %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
        <div class="container-fluid p-4"> <h3></h3>

            
            <form class="form-horizontal" method="POST" action="?doo=list">
                <div class="container-fluid p-4"><h4>İlk maddeye göre en üst reçetenin (mamül) müşteri siparişleri</h4>         
                    <div class="input-group">
                        <input class="form-control" type="text" name="search_madde_kodu"  placeholder="Stok Kodu"  value="<%=search_madde_kodu%>">
                        <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                    </div>
                </div>                           
            </form> 
            
            <%
            if url_doo="list" then 
                %>
                <strong>Mamüller <a class="badge bg-success" href="#demo" data-bs-toggle="collapse"><i class="bi bi-box-arrow-down-right"></i></a></strong>
                <div id="demo" class="collapse">            


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
                            Netsis_SQL=Netsis_SQL+" 	FROM ["+currentDB+"].[dbo].[TBLSTOKURM] A  WITH (NOLOCK) 												   "
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
                            Netsis_SQL=Netsis_SQL+" 	FROM ["+currentDB+"].[dbo].[TBLSTOKURM] B	 WITH (NOLOCK) 											   "
                            Netsis_SQL=Netsis_SQL+" 	JOIN Liste as C on C.[HAM_KODU] = B.[MAMUL_KODU]									   "
                                    Netsis_SQL=Netsis_SQL+" WHERE B.[GEC_FLAG]=0"

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
                            Netsis_SQL=Netsis_SQL+" 	,IE.KAPALI "
                            Netsis_SQL=Netsis_SQL+" from Liste Y	 WITH (NOLOCK) 																		   "
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] E  WITH (NOLOCK)  ON Y.[HAM_KODU]=E.[STOK_KODU]			   "
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLOPERATIONS_KATALOG] H  WITH (NOLOCK)  ON Y.[HAM_KODU]=H.[OPKODU]	   "
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD4] G  WITH (NOLOCK)  ON E.[KOD_4]=G.[GRUP_KOD]				   "
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSIPATRA] G2  WITH (NOLOCK)  ON G2.STOK_KODU=Y.anamamul 			   "
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSIPAMAS] G3  WITH (NOLOCK)  ON G3.FATIRS_NO=G2.FISNO				   "
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLISEMRI]  IE  WITH (NOLOCK)  ON IE.STOK_KODU=Y.anamamul AND G2.FISNO=IE.SIPARIS_NO " 
                            Netsis_SQL=Netsis_SQL+" WHERE  Y.HAM_KODU='"&search_madde_kodu&"' AND G2.[STHAR_GCMIK] is not null AND G3.[SUBE_KODU]=1 "
                            Netsis_SQL=Netsis_SQL+" ORDER BY G2.[IRSALIYE_TARIH] ,anamamul "

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

                <strong>Siparişler <a class="badge bg-success" href="#demo2" data-bs-toggle="collapse"><i class="bi bi-box-arrow-down-right"></i></a></strong>
                <div id="demo2" class="collapse">            

                    <table class="table table-sm table-striped table-hover align-middle">  <%
                        ' SQL
        
                            Netsis_SQL= " SELECT A.[STOK_KODU]" 
                            Netsis_SQL=Netsis_SQL+" ,A.[FISNO]" 
                            Netsis_SQL=Netsis_SQL+" ,B.[KAPALI]" 
                            Netsis_SQL=Netsis_SQL+" ,A.[STHAR_GCMIK]" 
                            Netsis_SQL=Netsis_SQL+" ,A.[STHAR_GCKOD] " 
                            Netsis_SQL=Netsis_SQL+" ,A.[SUBE_KODU]  " 
                            Netsis_SQL=Netsis_SQL+" ,A.[STHAR_DOVFIAT]  " 
                            Netsis_SQL=Netsis_SQL+" ,A.[STHAR_CARIKOD]   " 
                            Netsis_SQL=Netsis_SQL+" ,A.[IRSALIYE_TARIH]   " 
                            Netsis_SQL=Netsis_SQL+" ,C.[ACIKLAMA1] "
                            Netsis_SQL=Netsis_SQL+" ,A.[STHAR_TESTAR]   " 
                            Netsis_SQL=Netsis_SQL+" ,A.[OLCUBR] " 
                            Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSIPATRA] A WITH (NOLOCK) " 
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN (SELECT * FROM ["+currentDB+"].[dbo].[TBLISEMRI] WITH (NOLOCK) WHERE STOK_KODU='"&search_madde_kodu&"') B ON FISNO=SIPARIS_NO " 
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSSATIRAC] C  WITH (NOLOCK)  ON C.INCKEYNO=A.INCKEYNO "
                            Netsis_SQL=Netsis_SQL+" WHERE A.STOK_KODU ='"&search_madde_kodu&"' AND A.SUBE_KODU=1 ORDER BY A.STHAR_TESTAR " 
                        ' SQL ende
                        sira=0
                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                            do until NetsisRecordSet.EOF OR sira>=1000

                                if sira=0 then 'başlık yaz '                                     %>
                                    <tr>
                                        <th>Sıra</th>
                                        <th>Şube</th>
                                        <th>Yükleme Tarihi</th>
                                        <th>Teslim Tarihi</th>
                                        <th>Sipariş No</th>
                                        <th>Ax. Sip. No</th>
                                        <th>Cari</th>
                                        <th>Stok Kartı</th>
                                        <th>G/Ç</th>
                                        <th>Miktar</th>
                                        <th>Birim</th>
                                        <th>Fiyat</th>
                                    </tr><%
                                end if
                                if NetsisRecordSet("KAPALI")="E" then kapali=" class='alert alert-success' " else kapali=""
                                Sira=sira+1 %>  
                                <tr <%=kapali%>>
                                    <td><%=Sira%></td>
                                    <td><%=NetsisRecordSet("SUBE_KODU")%></td>
                                    <td><%=NetsisRecordSet("IRSALIYE_TARIH")%></td>
                                    <td><%=NetsisRecordSet("STHAR_TESTAR")%></td>
                                    <td><%=NetsisRecordSet("FISNO")%></td>
                                    <td><%=NetsisRecordSet("ACIKLAMA1")%></td>
                                    <td><%=NetsisRecordSet("STHAR_CARIKOD")%></td>
                                    <td><%=NetsisRecordSet("STOK_KODU")%></td>
                                    <td><%=NetsisRecordSet("STHAR_GCKOD")%></td>
                                    <td><%=NetsisRecordSet("STHAR_GCMIK")%></td>
                                    <td><%=NetsisRecordSet("OLCUBR")%></td>
                                    <td><%=NetsisRecordSet("STHAR_DOVFIAT")%></td>
                                </tr>        
                                <%
                                NetsisRecordSet.movenext
                            Loop
                        NetsisRecordSet.close
                        if sira=0 then Response.write("null") 
                        if sira=1000 then Response.write("<tr><td colspan=3>Max. 1000 kayıt gösterilmiştir. </td></tr>") 
                        %>
                    </table>
                </div>     <%
            end if
            %>
        </div>
    </div> <%
else
    Response.Write ("User level?")
end if
%> 
<!-- #include file="./include/footer.asp" -->