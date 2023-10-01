<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Parçadan Parça Bul" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level'   

    search_desc = BeniKoddanArindir(request.form("search_desc"))
    search_stok_kodu = BeniKoddanArindir(request.form("search_stok_kodu")) %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"> <h3>Parçadan Parça Bul</h3>
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_stok_kodu"  placeholder="Stok Kodu"  value="<%=search_stok_kodu%>">
                            <input class="form-control" type="text" name="search_desc"  placeholder="Madde Grubu"  value="<%=search_desc%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
    <%
    if len(search_stok_kodu&search_desc)>0 then 
    %>
        <div class="container-fluid p-4"> 
            
                    <%
                ' SQL   
                hepsi=""

Netsis_SQL = " With Liste as ( SELECT A.[MAMUL_KODU] ,A.[HAM_KODU]  "
Netsis_SQL = Netsis_SQL + " ,CAST(A.[MAMUL_KODU]  as varchar(250)) as agac	 "
Netsis_SQL = Netsis_SQL + " FROM ["+currentDB+"].[dbo].[TBLSTOKURM] A WHERE A.[GEC_FLAG]=0 AND A.[HAM_KODU] = '29-1040-00011' UNION ALL SELECT B.[MAMUL_KODU] ,B.[HAM_KODU]  "
Netsis_SQL = Netsis_SQL + " ,CAST(C.[agac]  as varchar(250)) as agac2   "
Netsis_SQL = Netsis_SQL + " FROM ["+currentDB+"].[dbo].[TBLSTOKURM] B JOIN Liste as C on C.[HAM_KODU] = B.[MAMUL_KODU] WHERE B.[GEC_FLAG]=0 )  "
Netsis_SQL = Netsis_SQL + " SELECT DISTINCT Y.agac from Liste Y  "


Netsis_SQL = " 		SELECT DISTINCT X.[MAMUL_KODU] FROM ["+currentDB+"].[dbo].[TBLSTOKURM] X WHERE X.[GEC_FLAG]=0 AND X.HAM_KODU LIKE '"&search_stok_kodu&"' "

                NetsisRecordSet.Open Netsis_SQL, NetsisConnection  
                    sira=0  
                    do until NetsisRecordSet.EOF OR sira>=1000
                        hepsi=hepsi+"'"+NetsisRecordSet("MAMUL_KODU")+"',"

                        NetsisRecordSet.MoveNext
                    loop 
                NetsisRecordSet.close 
                hepsi=left(hepsi,len(hepsi)-1)
                'Response.Write hepsi
                'response.end
' **********************************************************************'

Netsis_SQL =              " With Liste as ( "
Netsis_SQL = Netsis_SQL + " 		SELECT   "
Netsis_SQL = Netsis_SQL + " 		CAST('_'+A.[OPNO] as varchar(250)) as SortOrder "
Netsis_SQL = Netsis_SQL + " 		,CAST(1 AS INT) as LeveL "
Netsis_SQL = Netsis_SQL + " 		,A.[MAMUL_KODU]  "
Netsis_SQL = Netsis_SQL + " 		,A.[HAM_KODU] "
Netsis_SQL = Netsis_SQL + " 		,A.[MIKTAR] "
Netsis_SQL = Netsis_SQL + " 		,CAST(A.[MAMUL_KODU]  as varchar(250)) as agac	 "
Netsis_SQL = Netsis_SQL + " 		,A.[GEC_FLAG] "
Netsis_SQL = Netsis_SQL + " 		FROM ["+currentDB+"].[dbo].[TBLSTOKURM] A "
Netsis_SQL = Netsis_SQL + " 		WHERE A.[GEC_FLAG]=0  "
Netsis_SQL = Netsis_SQL + " 		AND   A.[MAMUL_KODU] IN (  "

Netsis_SQL = Netsis_SQL + " 		 "+hepsi+"  "
Netsis_SQL = Netsis_SQL + " 			) "
Netsis_SQL = Netsis_SQL + " 	UNION ALL "
Netsis_SQL = Netsis_SQL + " 		SELECT   "
Netsis_SQL = Netsis_SQL + " 			CAST(C.[SortOrder] +'.'+ B.[OPNO] as varchar(250)) as Sort2 "
Netsis_SQL = Netsis_SQL + " 			, CAST(C.[LeveL]+1 as INT) as Level2 "
Netsis_SQL = Netsis_SQL + " 			,B.[MAMUL_KODU] "
Netsis_SQL = Netsis_SQL + " 			,B.[HAM_KODU] "
Netsis_SQL = Netsis_SQL + " 			,B.[MIKTAR] "
Netsis_SQL = Netsis_SQL + " 			,CAST(C.[agac]  as varchar(250)) as agac2     "
Netsis_SQL = Netsis_SQL + " 			,B.[GEC_FLAG] "
Netsis_SQL = Netsis_SQL + " 		FROM ["+currentDB+"].[dbo].[TBLSTOKURM] B "
Netsis_SQL = Netsis_SQL + " 		JOIN Liste as C on C.[HAM_KODU] = B.[MAMUL_KODU] "
Netsis_SQL = Netsis_SQL + " 		WHERE B.[GEC_FLAG]=0  "
Netsis_SQL = Netsis_SQL + " ) "
Netsis_SQL = Netsis_SQL + " SELECT  "
Netsis_SQL = Netsis_SQL + " 	Y.agac as 'mamulkodu' "
Netsis_SQL = Netsis_SQL + " 	,E2.[STOK_ADI] as 'bisiklet' "
Netsis_SQL = Netsis_SQL + " 	,Y.[MAMUL_KODU] as 'Recete' "
Netsis_SQL = Netsis_SQL + " 	,Y.[HAM_KODU] as 'hamkodu' "
Netsis_SQL = Netsis_SQL + " 	,G.[GRUP_ISIM] as 'maddegrubu' "
Netsis_SQL = Netsis_SQL + " 	,G2.[GRUP_ISIM] as 'marka'  "
Netsis_SQL = Netsis_SQL + " 	,E.[STOK_ADI] as 'parca'  "
Netsis_SQL = Netsis_SQL + " 	,Y.[MIKTAR] as 'miktar'  "
Netsis_SQL = Netsis_SQL + " 	,E.[OLCU_BR1] as 'Birim' "
Netsis_SQL = Netsis_SQL + " 	,Y.GEC_FLAG "
Netsis_SQL = Netsis_SQL + " 	,Z.[FIYAT1] as 'FL_Birim_fiyat'  "
Netsis_SQL = Netsis_SQL + " 	,CASE "
Netsis_SQL = Netsis_SQL + " 		WHEN Z.[FIYATDOVIZTIPI]=0  THEN 'TRY' "
Netsis_SQL = Netsis_SQL + " 		WHEN Z.[FIYATDOVIZTIPI]=1  THEN 'USD' "
Netsis_SQL = Netsis_SQL + " 		WHEN Z.[FIYATDOVIZTIPI]=2  THEN 'EUR' "
Netsis_SQL = Netsis_SQL + " 		WHEN Z.[FIYATDOVIZTIPI]=3  THEN 'YEN' "
Netsis_SQL = Netsis_SQL + " 		WHEN Z.[FIYATDOVIZTIPI]=7  THEN 'RMB' "
Netsis_SQL = Netsis_SQL + " 		WHEN Z.[FIYATDOVIZTIPI]=9  THEN 'TWD' "
Netsis_SQL = Netsis_SQL + " 		ELSE 'missing' "
Netsis_SQL = Netsis_SQL + " 		END AS 'Currency' "
Netsis_SQL = Netsis_SQL + " from Liste Y "
Netsis_SQL = Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] E ON Y.[HAM_KODU]=E.[STOK_KODU] "
Netsis_SQL = Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] E2 ON Y.Agac=E2.[STOK_KODU]  "
Netsis_SQL = Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] G ON E.[KOD_1]=G.[GRUP_KOD] "
Netsis_SQL = Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD2] G2 ON E.[KOD_2]=G2.[GRUP_KOD] "
Netsis_SQL = Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD4] G4 ON E.[KOD_4]=G4.[GRUP_KOD] "
Netsis_SQL = Netsis_SQL + " OUTER APPLY (SELECT TOP 1 [FIYAT1],[FIYATDOVIZTIPI],[OLCUBR] FROM ["+currentDB+"].[dbo].[TBLSTOKFIAT] WITH (NOLOCK)  WHERE  Y.HAM_KODU=[STOKKODU] ORDER BY [BASTAR] DESC) Z "
Netsis_SQL = Netsis_SQL + " WHERE G.GRUP_ISIM LIKE '"&search_desc&"' AND Y.GEC_FLAG=0 "
Netsis_SQL = Netsis_SQL + " ORDER BY Y.agac ,Y.[HAM_KODU] "
' Response.Write Netsis_SQL
' response.end
                ' SQL ende            
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection  
                    sira=0  
                    do until NetsisRecordSet.EOF OR sira>=1000
                 
                        if sira=0 then                         %>
                        <table class="table table-sm table-striped table-hover align-middle nowrap" > 
                            <thead><tr>
                            <th>Sıra</th>
                            <th>Mamül</th>
                            <th>Mamül</th>
                            <th>Ham Madde</th>
                            <th>Ham Madde</th>
                            <th>Miktar</th>
                            <th>Madde Grubu</th>
                            <th>Marka</th> 
                            </tr></thead>  <%
                        end if 
                        sira=sira+1       
                        
                        %>                        
                            <tr><td><%=sira%></td> 
                            <td><%=NetsisRecordSet("mamulkodu")%></td>
                            <td><% 
                            if len(NetsisRecordSet("bisiklet"))>20 then Response.Write (left(NetsisRecordSet("bisiklet"),20)&"...") else Response.Write (NetsisRecordSet("bisiklet"))
                            
                            %></td>
                            <td><%=NetsisRecordSet("hamkodu")%></td>
                            <td <%=renk%>><%=NetsisRecordSet("parca")%></td>
                            <td><%=NetsisRecordSet("miktar")%></td>  
                            <td><%=NetsisRecordSet("maddegrubu")%></td> 
                            <td><%=NetsisRecordSet("marka")%></td></tr> 
                            <% 

                        NetsisRecordSet.MoveNext
                    loop 
                NetsisRecordSet.close
                Response.Write(" </table> ")

                if sira=0 then response.write ("Kayıt bulunamadı...")     
                if sira=1000 then response.write ("<tr><td colspan=5>Max. 1000 kayıt görüntülendi.</td></tr>")     %> 
            </table> 
        </div>
        <%
        end if
        %>
    </div> <%
else
    Response.Write ("User level?")
end if
%> 

<!-- #include file="./include/footer.asp" -->