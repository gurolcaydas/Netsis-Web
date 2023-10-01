<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Rapor-koda-gore-maliyet-katsayisi-listele" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level'   

    search_stok_kodu = (request.form("search_stok_kodu")) 
        ' for x=1 to len(search_stok_kodu)
        '     aaa = aaa & (asc(mid(search_stok_kodu,x,1)) & "*")
        ' next
        search_stok_kodu=Replace(search_stok_kodu,vbCrLf, " ")       
        search_stok_kodu=Replace(search_stok_kodu,Chr(9), " ")        
        search_stok_kodu=Replace(search_stok_kodu,Chr(10), " ")        
        search_stok_kodu=Replace(search_stok_kodu,Chr(11), " ")        
        search_stok_kodu=Replace(search_stok_kodu,Chr(12), " ")        
        search_stok_kodu=Replace(search_stok_kodu,Chr(13), " ")        
        search_stok_kodu=Replace(search_stok_kodu,Chr(44), " ")        
        search_stok_kodu=Replace(search_stok_kodu, """", " ")
        search_stok_kodu=Replace(search_stok_kodu, "'", " ")
        search_stok_kodu=Replace(search_stok_kodu, "‚", " ")
    
        i=0
            Do While i<>LEN(search_stok_kodu) ' çift space kontrol
                    i=LEN(search_stok_kodu)
                    search_stok_kodu=Replace(search_stok_kodu, "  ", " ")
            Loop
        search_stok_kodu=trim(search_stok_kodu)

        ' aaa=aaa & "*<br>*"
        ' for x=1 to len(search_stok_kodu)
        '     aaa = aaa & (asc(mid(search_stok_kodu,x,1)) & "*")
        ' next 
    
     %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"> <h3>Landed Cost</h3><h5>Koda göre fiyat listesi ve maliyet katsayısı</h3>
                        <div class="input-group">
                            <textarea class="form-control z-depth-1" name="search_stok_kodu" rows="3" placeholder="Stok Kodları"><%=search_stok_kodu%></textarea>
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
        <% 
        
        if LEN(search_stok_kodu)+LEN(search_stok_kodu)>0 then  

        aranacak_stok_kodu=Replace(search_stok_kodu, " ", "','")
        aranacak_stok_kodu="'"+aranacak_stok_kodu+"'"

        %>
        <div class="container-fluid p-4"> 
        <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
            <table class="table table-sm table-striped table-hover align-middle"  id="tblData">         <%
                ' SQL   
                    Netsis_SQL=Netsis_SQL+" SELECT 																																									  "
                    Netsis_SQL=Netsis_SQL+" 	Y.STOK_KODU as 'Stok Kodu'																																			  "
                    Netsis_SQL=Netsis_SQL+" 	,Z.[FIYAT1] as 'Fiyat'																																				  "
                    Netsis_SQL=Netsis_SQL+" 	,Z.[FIYATDOVIZTIPI] AS 'Döviz Tipi'																																	  "
                    Netsis_SQL=Netsis_SQL+" 	,CASE																																								  "
                    Netsis_SQL=Netsis_SQL+" 		WHEN Z.[OLCUBR]=1  THEN Y.[OLCU_BR1]																															  "
                    Netsis_SQL=Netsis_SQL+" 		WHEN Z.[OLCUBR]=2  THEN Y.[OLCU_BR2]																															  "
                    Netsis_SQL=Netsis_SQL+" 		WHEN Z.[OLCUBR]=3  THEN Y.[OLCU_BR3]																															  "
                    Netsis_SQL=Netsis_SQL+" 		ELSE NULL																																						  "
                    Netsis_SQL=Netsis_SQL+" 	END AS 'Fiyat Listesindeki Birim'																																	  "
                    Netsis_SQL=Netsis_SQL+" 	,G.GRUP_ISIM as 'Maliyet Grubu'																																		  "
                    Netsis_SQL=Netsis_SQL+" 	,CS.CARI_KOD as 'Cari Kod'																																			  "
                    Netsis_SQL=Netsis_SQL+" 	,LC.ORAN as 'Maliyet Katsayısı'																																		  "
                    Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].TBLSTSABIT Y																																						  "
                    Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT TOP 1 [FIYAT1],[FIYATDOVIZTIPI],[OLCUBR] FROM ["+currentDB+"].[dbo].[TBLSTOKFIAT] WITH (NOLOCK)  WHERE  Y.STOK_KODU=[STOKKODU] AND [FIYAT1]>0 ORDER BY [BASTAR] DESC) Z "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD4] G WITH (NOLOCK)  ON Y.[KOD_4]=G.[GRUP_KOD]																					   "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLCARISTOK] CS WITH (NOLOCK)  ON Y.STOK_KODU=CS.STOK_KODU AND CS.CARI_KOD is not null													   "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[PLT_LANDING_RATIO] LC WITH (NOLOCK)  ON Y.[KOD_4]=LC.CGI AND  CS.CARI_KOD=LC.CARI_KOD														   "
                    Netsis_SQL=Netsis_SQL+" WHERE Y.STOK_KODU IN ("+aranacak_stok_kodu+") "                    
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
                            if x.name="Döviz Tipi" then
                            Response.Write("<td class='text-nowrap'>" & parabirimi(x.value) &"</td>")

                            else
                            Response.Write("<td class='text-nowrap'>" & x.value &"</td>")
                            end if
                            
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
        <% end if %>        
    </div> <%
else
    Response.Write ("User level?")
end if


function parabirimi(t1)
    parabirimi="---"
    SELECT Case t1
    case 0
    parabirimi="TRL"
    case 1
    parabirimi="USD"
    case 2
    parabirimi="EUR"
    case 3
    parabirimi="JPY"
    case 4
    parabirimi="SEK"
    case 5
    parabirimi="GBP"
    case 6
    parabirimi="CHF"
    case 7
    parabirimi="RMB"
    case 8
    parabirimi="TRL"
    case 9
    parabirimi="TWD"
    end Select
end function

%> 
<!-- #include file="./include/footer.asp" -->