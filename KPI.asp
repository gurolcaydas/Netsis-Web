<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="KPI" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"a") then 'needed level'   %>         
    <div class="container-fluid" style="margin-top:80px"> <%
        %>
        <!-- #include file="./subs/dbcon.asp" -->
        <%


        if url_doo="" or url_doo="list" then

            %>
            <%
        end if
        if url_doo="urge"  then 'alanlar boş ise sakın arama'
            %>
            <div class="container-fluid p-4"><h3>KPI</h3>
    
                    <div class="container-fluid p-4"><h4>Ürün Ağacı Satırları / Ay </h4>
                        <table class="table table-sm table-striped table-hover align-middle">  
                            <thead>
                                <tr>
                                <th>İş</th> 
                                <th>1</th><th>2</th><th>3</th><th>4</th><th>5</th><th>6</th><th>7</th><th>8</th><th>9</th><th>10</th><th>11</th><th>12</th>
                                </tr>      
                            </thead>                      
                            <%
                            ' SQL 
                                Netsis_SQL=" with liste as (																															"
                                Netsis_SQL=Netsis_SQL+" Select COUNT(A.STOK_KODU) as toplam , YEAR( B.KAYITTARIHI) as Yil,  MONTH( B.KAYITTARIHI) as Ayy,  'Stok Kartı' as recete		"
                                Netsis_SQL=Netsis_SQL+" from ["+currentDB+"].[dbo].[TBLSTSABIT] A																									"
                                Netsis_SQL=Netsis_SQL+" left join ["+currentDB+"].[dbo].[TBLSTSABITEK] B ON B.STOK_KODU=A.STOK_KODU																	"
                                Netsis_SQL=Netsis_SQL+" GROUP BY YEAR( B.KAYITTARIHI), MONTH( B.KAYITTARIHI)																				"
                                Netsis_SQL=Netsis_SQL+" UNION ALL																																"
                                Netsis_SQL=Netsis_SQL+"             SELECT COUNT(MAMUL_KODU) as toplam , YEAR(KAYITTARIHI) as Yil,  MONTH( KAYITTARIHI) as Ayy,  'Recete Satırı' as recete"
                                Netsis_SQL=Netsis_SQL+"           FROM ["+currentDB+"].[dbo].[TBLSTOKURM]		   																					"
                                Netsis_SQL=Netsis_SQL+"           GROUP BY YEAR(KAYITTARIHI),MONTH( KAYITTARIHI)																			"
                                Netsis_SQL=Netsis_SQL+" 		  )																																	"
                                Netsis_SQL=Netsis_SQL+" select * from liste L																													"
                                Netsis_SQL=Netsis_SQL+" PIVOT (sum(Toplam) FOR Ayy IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS P												"
                                Netsis_SQL=Netsis_SQL+" WHERE yil='"&right(currentDB,4)&"'			"

                                ' Netsis_SQL="SELECT COUNT(MAMUL_KODU) as toplam , YEAR(KAYITTARIHI) as Yil, DATEPART(WEEK,KAYITTARIHI) as Hafta"
                                
                                ' Netsis_SQL=Netsis_SQL+"  FROM ["+currentDB+"].[dbo].[TBLSTOKURM]		   "
                                ' Netsis_SQL=Netsis_SQL+" WHERE YEAR(KAYITTARIHI) = '"&YEAR(NOW())&"'														  "
                                ' Netsis_SQL=Netsis_SQL+"  GROUP BY YEAR(KAYITTARIHI),DATEPART(WEEK,KAYITTARIHI) "
                                ' Netsis_SQL=Netsis_SQL+"  ORDER BY YEAR(KAYITTARIHI),DATEPART(WEEK,KAYITTARIHI) "

                            ' SQL ende
                            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                                sira=0 
                                do until NetsisRecordSet.EOF OR sira>=250
                                    sira=sira+1                                     %>
                                    <tr>
                                        <td><%=NetsisRecordSet("recete")%></td>
                                        <td><%=NetsisRecordSet("1")%></td> <td><%=NetsisRecordSet("2")%></td> <td><%=NetsisRecordSet("3")%></td> <td><%=NetsisRecordSet("4")%></td> <td><%=NetsisRecordSet("5")%></td> <td><%=NetsisRecordSet("6")%></td> <td><%=NetsisRecordSet("7")%></td> <td><%=NetsisRecordSet("8")%></td> <td><%=NetsisRecordSet("9")%></td> <td><%=NetsisRecordSet("10")%></td> <td><%=NetsisRecordSet("11")%></td> <td><%=NetsisRecordSet("12")%></td> 
                                    </tr>                             <%
                                    NetsisRecordSet.movenext
                                Loop                                                
                            NetsisRecordSet.close  
                            if sira=250 then response.write ("<tr><td colspan=5>Max. 250 kayıt görüntülendi.</td></tr>")     %> 
                        </table> 
                    </div>
                    <div class="container-fluid p-4"><h4>Ürün Ağacı Satırları / Hafta </h4>
                        <table class="table table-sm table-striped table-hover align-middle">  
                            <thead>
                                <tr>
                                <th>İş</th> 
                                <th>1</th><th>2</th><th>3</th><th>4</th><th>5</th><th>6</th><th>7</th><th>8</th><th>9</th><th>10</th><th>11</th><th>12</th><th>13</th><th>14</th><th>15</th><th>16</th><th>17</th><th>18</th><th>19</th><th>20</th><th>21</th><th>22</th><th>23</th><th>24</th><th>25</th><th>26</th><th>27</th><th>28</th><th>29</th><th>30</th><th>31</th><th>32</th><th>33</th><th>34</th><th>35</th><th>36</th><th>37</th><th>38</th><th>39</th><th>40</th><th>41</th><th>42</th><th>43</th><th>44</th><th>45</th><th>46</th><th>47</th><th>48</th><th>49</th><th>50</th><th>51</th><th>52</th><th>53</th>
                                </tr>      
                            </thead>                      
                            <%
                            ' SQL 
                                Netsis_SQL=" with liste as (																															"
                                Netsis_SQL=Netsis_SQL+" Select COUNT(A.STOK_KODU) as toplam , YEAR( B.KAYITTARIHI) as Yil, DATEPART(WEEK, B.KAYITTARIHI) as Hafta, 'Stok Kartı' as recete		"
                                Netsis_SQL=Netsis_SQL+" from ["+currentDB+"].[dbo].[TBLSTSABIT] A																									"
                                Netsis_SQL=Netsis_SQL+" left join ["+currentDB+"].[dbo].[TBLSTSABITEK] B ON B.STOK_KODU=A.STOK_KODU																	"
                                Netsis_SQL=Netsis_SQL+" GROUP BY YEAR( B.KAYITTARIHI), DATEPART(WEEK, B.KAYITTARIHI)																				"
                                Netsis_SQL=Netsis_SQL+" UNION ALL																																"
                                Netsis_SQL=Netsis_SQL+"             SELECT COUNT(MAMUL_KODU) as toplam , YEAR(KAYITTARIHI) as Yil, DATEPART(WEEK,KAYITTARIHI) as Hafta, 'Recete Satırı' as recete"
                                Netsis_SQL=Netsis_SQL+"           FROM ["+currentDB+"].[dbo].[TBLSTOKURM]		   																					"
                                Netsis_SQL=Netsis_SQL+"           GROUP BY YEAR(KAYITTARIHI),DATEPART(WEEK,KAYITTARIHI)																			"
                                Netsis_SQL=Netsis_SQL+" 		  )																																	"
                                Netsis_SQL=Netsis_SQL+" select * from liste L																													"
                                Netsis_SQL=Netsis_SQL+" PIVOT (sum(Toplam) FOR hafta IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31],[32],[33],[34],[35],[36],[37],[38],[39],[40],[41],[42],[43],[44],[45],[46],[47],[48],[49],[50],[51],[52],[53])) AS P												"
                                Netsis_SQL=Netsis_SQL+" WHERE yil='"&right(currentDB,4)&"'			"

                                ' Netsis_SQL="SELECT COUNT(MAMUL_KODU) as toplam , YEAR(KAYITTARIHI) as Yil, DATEPART(WEEK,KAYITTARIHI) as Hafta"
                                
                                ' Netsis_SQL=Netsis_SQL+"  FROM ["+currentDB+"].[dbo].[TBLSTOKURM]		   "
                                ' Netsis_SQL=Netsis_SQL+" WHERE YEAR(KAYITTARIHI) = '"&YEAR(NOW())&"'														  "
                                ' Netsis_SQL=Netsis_SQL+"  GROUP BY YEAR(KAYITTARIHI),DATEPART(WEEK,KAYITTARIHI) "
                                ' Netsis_SQL=Netsis_SQL+"  ORDER BY YEAR(KAYITTARIHI),DATEPART(WEEK,KAYITTARIHI) "

                            ' SQL ende
                            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                                sira=0 
                                do until NetsisRecordSet.EOF OR sira>=250
                                    sira=sira+1                                     %>
                                    <tr>
                                        <td><%=NetsisRecordSet("recete")%></td>
                                        <td><%=NetsisRecordSet("1")%></td> <td><%=NetsisRecordSet("2")%></td> <td><%=NetsisRecordSet("3")%></td> <td><%=NetsisRecordSet("4")%></td> <td><%=NetsisRecordSet("5")%></td> <td><%=NetsisRecordSet("6")%></td> <td><%=NetsisRecordSet("7")%></td> <td><%=NetsisRecordSet("8")%></td> <td><%=NetsisRecordSet("9")%></td> <td><%=NetsisRecordSet("10")%></td> <td><%=NetsisRecordSet("11")%></td> <td><%=NetsisRecordSet("12")%></td> <td><%=NetsisRecordSet("13")%></td> <td><%=NetsisRecordSet("14")%></td> <td><%=NetsisRecordSet("15")%></td> <td><%=NetsisRecordSet("16")%></td> <td><%=NetsisRecordSet("17")%></td> <td><%=NetsisRecordSet("18")%></td> <td><%=NetsisRecordSet("19")%></td> <td><%=NetsisRecordSet("20")%></td> <td><%=NetsisRecordSet("21")%></td> <td><%=NetsisRecordSet("22")%></td> <td><%=NetsisRecordSet("23")%></td> <td><%=NetsisRecordSet("24")%></td> <td><%=NetsisRecordSet("25")%></td> <td><%=NetsisRecordSet("26")%></td> <td><%=NetsisRecordSet("27")%></td> <td><%=NetsisRecordSet("28")%></td> <td><%=NetsisRecordSet("29")%></td> <td><%=NetsisRecordSet("30")%></td> <td><%=NetsisRecordSet("31")%></td> <td><%=NetsisRecordSet("32")%></td> <td><%=NetsisRecordSet("33")%></td> <td><%=NetsisRecordSet("34")%></td> <td><%=NetsisRecordSet("35")%></td> <td><%=NetsisRecordSet("36")%></td> <td><%=NetsisRecordSet("37")%></td> <td><%=NetsisRecordSet("38")%></td> <td><%=NetsisRecordSet("39")%></td> <td><%=NetsisRecordSet("40")%></td> <td><%=NetsisRecordSet("41")%></td> <td><%=NetsisRecordSet("42")%></td> <td><%=NetsisRecordSet("43")%></td> <td><%=NetsisRecordSet("44")%></td> <td><%=NetsisRecordSet("45")%></td> <td><%=NetsisRecordSet("46")%></td> <td><%=NetsisRecordSet("47")%></td> <td><%=NetsisRecordSet("48")%></td> <td><%=NetsisRecordSet("49")%></td> <td><%=NetsisRecordSet("50")%></td> <td><%=NetsisRecordSet("51")%></td> <td><%=NetsisRecordSet("52")%></td> <td><%=NetsisRecordSet("53")%></td> 
                                    </tr>                             <%
                                    NetsisRecordSet.movenext
                                Loop                                                
                            NetsisRecordSet.close  
                            if sira=250 then response.write ("<tr><td colspan=5>Max. 250 kayıt görüntülendi.</td></tr>")     %> 
                        </table> 
                    </div>                    
                    <div class="container-fluid p-4"><h4>Stok  Kartı Açılışları </h4>
                        <table class="table table-sm table-striped table-hover align-middle"> 
                            <thead>              <tr>
                                <th>Kullanıcı</th> 
                                <th>Ocak</th> 
                                <th>Şubat</th> 
                                <th>Mart</th> 
                                <th>Nisan</th> 
                                <th>Mayıs</th> 
                                <th>Haziran</th> 
                                <th>Temmuz</th> 
                                <th>Ağustos</th> 
                                <th>Eylül</th> 
                                <th>Ekim</th> 
                                <th>Kasım</th> 
                                <th>Aralık</th> 
                                </tr>     
                            </thead> 
                            <%
                            Netsis_SQL=" SELECT * FROM (																			  "
                            Netsis_SQL=Netsis_SQL+" Select MONTH( B.KAYITTARIHI) as Ayy,B.KAYITYAPANKUL as Kullan,COUNT(A.STOK_KODU) as toplam		  "
                            Netsis_SQL=Netsis_SQL+" from ["+currentDB+"].[dbo].[TBLSTSABIT] A													  "
                            Netsis_SQL=Netsis_SQL+" left join ["+currentDB+"].[dbo].[TBLSTSABITEK] B ON B.STOK_KODU=A.STOK_KODU				  "
                            Netsis_SQL=Netsis_SQL+" WHERE YEAR( B.KAYITTARIHI) = '"&right(currentDB,4)&"'														  "
                            Netsis_SQL=Netsis_SQL+" GROUP BY YEAR( B.KAYITTARIHI) , MONTH( B.KAYITTARIHI) ,B.KAYITYAPANKUL					  "
                            Netsis_SQL=Netsis_SQL+" ) AS S																					  "
                            Netsis_SQL=Netsis_SQL+" PIVOT (sum(Toplam) FOR Ayy IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS P"
                            Netsis_SQL=Netsis_SQL+" ORDER BY Kullan "
                            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                                sira=0 
                                do until NetsisRecordSet.EOF OR sira>=250
                                    sira=sira+1                                     %>
                                    <tr>
                                        <td><%=NetsisRecordSet("Kullan")%></td> 
                                        <td><%=NetsisRecordSet("1")%></td> 
                                        <td><%=NetsisRecordSet("2")%></td> 
                                        <td><%=NetsisRecordSet("3")%></td> 
                                        <td><%=NetsisRecordSet("4")%></td> 
                                        <td><%=NetsisRecordSet("5")%></td> 
                                        <td><%=NetsisRecordSet("6")%></td> 
                                        <td><%=NetsisRecordSet("7")%></td> 
                                        <td><%=NetsisRecordSet("8")%></td> 
                                        <td><%=NetsisRecordSet("9")%></td> 
                                        <td><%=NetsisRecordSet("10")%></td> 
                                        <td><%=NetsisRecordSet("11")%></td> 
                                        <td><%=NetsisRecordSet("12")%></td> 
                                    </tr>                             <%
                                    NetsisRecordSet.movenext
                                Loop                                                
                            NetsisRecordSet.close  
                            if sira=250 then response.write ("<tr><td colspan=5>Max. 250 kayıt görüntülendi.</td></tr>")     %> 
                        </table> 
                    </div>   
                    <div class="container-fluid p-4"> <h4>Müşteri-Satıcı-Stok Kayıtları</h4>
                        <table class="table table-sm table-striped table-hover align-middle">         <%
                            ' SQL            
                                Netsis_SQL=" SELECT  [KAYITYAPANKUL],COUNT([INCKEYNO]) as toplam "
                                Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLCARISTOK] "
                                Netsis_SQL=Netsis_SQL+" WHERE CARI_KOD IS NOT NULL "
                                Netsis_SQL=Netsis_SQL+" GROUP BY  [KAYITYAPANKUL]    "   
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
                    <div class="container-fluid p-4"> <h4>Müşteri-Satıcı-Stok Kayıtları</h4>
                        <table class="table table-sm table-striped table-hover align-middle">         <%
                            ' SQL     
                                Netsis_SQL="SELECT * FROM (																			  	 "
                                Netsis_SQL=Netsis_SQL+"  SELECT  																					 "
                                Netsis_SQL=Netsis_SQL+"       MONTH( B.KAYITTARIHI) as Ayy,															 "
                                Netsis_SQL=Netsis_SQL+"	   (CASE																					 "
                                Netsis_SQL=Netsis_SQL+"	   WHEN B.[KAYITYAPANKUL] IS NULL  THEN 'Null'												 "
                                Netsis_SQL=Netsis_SQL+"	   ELSE B.[KAYITYAPANKUL] END) as Kullan													 "
                                Netsis_SQL=Netsis_SQL+"	   ,COUNT(B.[INCKEYNO]) as toplam															 "
                                Netsis_SQL=Netsis_SQL+"     																						 "
                                Netsis_SQL=Netsis_SQL+"    FROM ["+currentDB+"].[dbo].[TBLCARISTOK] B													 "
                                Netsis_SQL=Netsis_SQL+"	WHERE CARI_KOD IS NOT NULL AND YEAR( B.KAYITTARIHI) = '"&right(currentDB,4)&"'								"						  
                                Netsis_SQL=Netsis_SQL+" GROUP BY YEAR( B.KAYITTARIHI) , MONTH( B.KAYITTARIHI) ,B.KAYITYAPANKUL					  	 "
                                Netsis_SQL=Netsis_SQL+" ) AS S																					  	 "
                                Netsis_SQL=Netsis_SQL+" PIVOT (sum(Toplam) FOR Ayy IN ([0],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS P "
                                Netsis_SQL=Netsis_SQL+" ORDER BY Kullan 																			  "
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
                

            </div><%
        end if  	

        if url_doo="urgedepo"  then 'alanlar boş ise sakın arama'

            Netsis_SQL=Netsis_SQL+"SELECT "
            Netsis_SQL=Netsis_SQL+"A.[STOK_KODU] "
            Netsis_SQL=Netsis_SQL+",C.[STOK_ADI]"
            Netsis_SQL=Netsis_SQL+",A.[SUBE_KODU] "
            Netsis_SQL=Netsis_SQL+",B.[DEPO_ISMI]  "
            Netsis_SQL=Netsis_SQL+",B.[DEPO_KODU]  "
            Netsis_SQL=Netsis_SQL+",[CEVRIM] "
            Netsis_SQL=Netsis_SQL+",[TOP_GIRIS_MIK]  "              
            Netsis_SQL=Netsis_SQL+",[TOP_CIKIS_MIK] "
            Netsis_SQL=Netsis_SQL+",[STOK_DAGITIM] "
            Netsis_SQL=Netsis_SQL+",[MUS_TOP_SIPARIS] "
            Netsis_SQL=Netsis_SQL+",[SAT_TOP_SIPARIS] "
            Netsis_SQL=Netsis_SQL+"FROM ["+currentDB+"].[dbo].[TBLSTOKPH] A "
            Netsis_SQL=Netsis_SQL+"INNER JOIN ["+currentDB+"].[dbo].[TBLSTOKDP] B ON A.[DEPO_KODU]=B.[DEPO_KODU] "
            Netsis_SQL=Netsis_SQL+"INNER JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] C ON A.[STOK_KODU]=C.[STOK_KODU]"
            Netsis_SQL=Netsis_SQL+"WHERE A.[DEPO_KODU]=67 AND [TOP_GIRIS_MIK]+[TOP_CIKIS_MIK]!=0 "

            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
            sira=0 
                do until NetsisRecordSet.EOF OR sira>=250
                    if sira=0 then %>
                        <div class="container-fluid p-4"><h4>Tasarım Merkezi Depo Miktarları </h4>
                        <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
                        <table class="table table-sm table-striped table-hover align-middle" id="tblData"> 
                        <thead>              <tr>
                        <th>Kod</th> 
                        <th>Açıklama</th> 
                        <th>Depo</th> 
                        <th>Giriş</th> 
                        <th>Çıkış</th> 
                        <th>Kalan</th> 
                    </tr>     </thead> <%
                    end if 
                    sira=sira+1                                     %>
                    <tr>
                        <td><%=NetsisRecordSet("STOK_KODU")%></td> 
                        <td><%=NetsisRecordSet("STOK_ADI")%></td> 
                        <td><%=NetsisRecordSet("DEPO_ISMI")%></td> 
                        <td><%=NetsisRecordSet("TOP_GIRIS_MIK")%></td> 
                        <td><%=NetsisRecordSet("TOP_CIKIS_MIK")%></td> 
                        <td><b><%=CDbl(NetsisRecordSet("TOP_GIRIS_MIK"))-CDbl(NetsisRecordSet("TOP_CIKIS_MIK"))%></b></td>
                    </tr>                             <%
                    NetsisRecordSet.movenext
                Loop                                                
            NetsisRecordSet.close  
            if sira=250 then response.write ("<tr><td colspan=5>Max. 250 kayıt görüntülendi.</td></tr>")     %> 
            </table> </div><%





        end if 

        if url_doo="tekzimbadepo"  then 'alanlar boş ise sakın arama'
            %>
            <div class="accordion accordion-flush" id="accordionFlushExample">
            <div class="accordion-item">
                <h2 class="accordion-header" id="flush-headingOne">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                SKU Bazında Tek Zımba Depo Miktarları
                </button>
                </h2>
                <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                <div class="accordion-body">
                    <%
                    ' bolum 1
                        Netsis_SQL="SELECT "
                        Netsis_SQL=Netsis_SQL+"A.[STOK_KODU] "
                        Netsis_SQL=Netsis_SQL+",C.[STOK_ADI]"
                        Netsis_SQL=Netsis_SQL+",A.[SUBE_KODU] "
                        Netsis_SQL=Netsis_SQL+",B.[DEPO_ISMI]  "
                        Netsis_SQL=Netsis_SQL+",B.[DEPO_KODU]  "
                        Netsis_SQL=Netsis_SQL+",[CEVRIM] "
                        Netsis_SQL=Netsis_SQL+",[TOP_GIRIS_MIK]  "              
                        Netsis_SQL=Netsis_SQL+",[TOP_CIKIS_MIK] "
                        Netsis_SQL=Netsis_SQL+",[STOK_DAGITIM] "
                        Netsis_SQL=Netsis_SQL+",[MUS_TOP_SIPARIS] "
                        Netsis_SQL=Netsis_SQL+",[SAT_TOP_SIPARIS] "
                        Netsis_SQL=Netsis_SQL+",D.[GRUP_ISIM] "
                        Netsis_SQL=Netsis_SQL+"FROM ["+currentDB+"].[dbo].[TBLSTOKPH] A WITH (NOLOCK) "
                        Netsis_SQL=Netsis_SQL+"INNER JOIN ["+currentDB+"].[dbo].[TBLSTOKDP] B  WITH (NOLOCK) ON A.[DEPO_KODU]=B.[DEPO_KODU] "
                        Netsis_SQL=Netsis_SQL+"INNER JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] C  WITH (NOLOCK) ON A.[STOK_KODU]=C.[STOK_KODU]"
                        Netsis_SQL=Netsis_SQL+"INNER JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] D  WITH (NOLOCK)  ON C.[KOD_1]=D.[GRUP_KOD]"
                        Netsis_SQL=Netsis_SQL+"WHERE A.[DEPO_KODU]=10 AND [TOP_GIRIS_MIK]-[TOP_CIKIS_MIK]!=0 "
                        Netsis_SQL=Netsis_SQL+"ORDER BY C.GRUP_KODU, A.STOK_KODU "

                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                        sira=0 
                            do until NetsisRecordSet.EOF OR sira>=1000
                                if sira=0 then 
                                %>

                                    <div class="container-fluid p-4">
                                    <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
                                    <table class="table table-sm table-striped table-hover align-middle" id="tblData">  
                                    <thead>              <tr>
                                    <th>Madde Grubu</th> 
                                    <th>Kod</th> 
                                    <th></th> 
                                    <th>Açıklama</th> 
                                    <th>Depo</th> 
                                    <th>Giriş</th> 
                                    <th>Çıkış</th> 
                                    <th>Kalan</th> 
                                </tr>     </thead> <%

                                end if 
                                sira=sira+1                                     %>
                                <tr>
                                    <td><%=NetsisRecordSet("GRUP_ISIM")%></td> 
                                    <td><%=NetsisRecordSet("STOK_KODU")%></td>
                                    <td>   
                                    <!-- Button trigger modal -->
                                        <div class="badge badge-pill bg-primary" data-bs-toggle="modal" data-bs-target="#tekzimbaModal" onclick="showtekzimba('<%=NetsisRecordSet("STOK_KODU")%>')">
                                            <i class="bi bi-search"></i>
                                        </div>                    <!-- Modal -->   
                                        <div class="modal fade" id="tekzimbaModal" tabindex="-1" aria-labelledby="tekzimbaModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-xl">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title"  id="tekzimbabaslik"></h5>
                                                    </div>
                                                    <div class="modal-body" id="tekzimba">
                                                        ... 
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Kapat</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>   
                                
                                
                                    </td>  
                                    <td><%=NetsisRecordSet("STOK_ADI")%></td> 
                                    <td><%=NetsisRecordSet("DEPO_ISMI")%></td> 
                                    <td><%=NetsisRecordSet("TOP_GIRIS_MIK")%></td> 
                                    <td><%=NetsisRecordSet("TOP_CIKIS_MIK")%></td> 
                                    <td><b><%=CDbl(NetsisRecordSet("TOP_GIRIS_MIK"))-CDbl(NetsisRecordSet("TOP_CIKIS_MIK"))%></b></td>
                                </tr> 

                                                            <%
                                NetsisRecordSet.movenext
                            Loop                                                
                        NetsisRecordSet.close  
                        if sira=1000 then response.write ("<tr><td colspan=5>Max. 1000 kayıt görüntülendi.</td></tr>")     %> 
                        </table> </div>
                        <%
                    ' bolum 1 end
                    %>                
                
                </div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header" id="flush-headingTwo">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
                Madde Grubuna Göre Tek Zımba Depo Miktarları
                </button>
                </h2>
                <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
                <div class="accordion-body">
                    <%
                    ' bolum 2 start
                        Netsis_SQL="SELECT 																	  "
                        Netsis_SQL=Netsis_SQL+"SUM([TOP_GIRIS_MIK]  ) as gtop											  "
                        Netsis_SQL=Netsis_SQL+",SUM([TOP_CIKIS_MIK] ) as ctop											  "
                        Netsis_SQL=Netsis_SQL+",D.[GRUP_ISIM] 															  "
                        Netsis_SQL=Netsis_SQL+",C.GRUP_KODU 															  "
                        Netsis_SQL=Netsis_SQL+"FROM ["+currentDB+"].[dbo].[TBLSTOKPH] A  WITH (NOLOCK) 									  "
                        Netsis_SQL=Netsis_SQL+"INNER JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] C  WITH (NOLOCK) ON A.[STOK_KODU]=C.[STOK_KODU]"
                        Netsis_SQL=Netsis_SQL+"INNER JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] D  WITH (NOLOCK) ON C.[KOD_1]=D.[GRUP_KOD]	  "
                        Netsis_SQL=Netsis_SQL+"WHERE A.[DEPO_KODU]=10 AND [TOP_GIRIS_MIK]+[TOP_CIKIS_MIK]!=0 			  "
                        Netsis_SQL=Netsis_SQL+"GROUP BY D.[GRUP_ISIM] , C.GRUP_KODU 									  "
                        Netsis_SQL=Netsis_SQL+"ORDER BY  C.GRUP_KODU ,D.[GRUP_ISIM]										  "
            
                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                        sira=0 
                            do until NetsisRecordSet.EOF OR sira>=1000
                                if sira=0 then %>
                                    <div class="container-fluid p-4">
                                    <table class="table table-sm table-striped table-hover align-middle"> 
                                    <thead>              <tr>
                                    <th>Madde Grubu</th> 
                                    <th>Miktar</th> 
                                </tr>     </thead> <%
                                end if 
                                sira=sira+1                                     %>
                                <tr>
                                    <td><%=NetsisRecordSet("GRUP_ISIM")%></td> 
                                    <td><b><%=CDbl(NetsisRecordSet("gtop"))-CDbl(NetsisRecordSet("ctop"))%></b></td>
                                </tr>                             <%
                                NetsisRecordSet.movenext
                            Loop                                                
                        NetsisRecordSet.close  
                        if sira=1000 then response.write ("<tr><td colspan=5>Max. 1000 kayıt görüntülendi.</td></tr>")     %> 
                        </table> </div><%
                    ' bolum 2 end
                    %>                
                
                </div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header" id="flush-headingThree">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
                    Mamül/Hammaddeye Göre Tek Zımba Depo Miktarları
                </button>
                </h2>
                <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
                <div class="accordion-body">
                    <%
                    ' bolum 3 start
                        Netsis_SQL=" "
                        Netsis_SQL=Netsis_SQL+"SELECT 																	  "
                        Netsis_SQL=Netsis_SQL+"SUM([TOP_GIRIS_MIK]  ) as gtop											  "
                        Netsis_SQL=Netsis_SQL+",SUM([TOP_CIKIS_MIK] ) as ctop											  "
                        Netsis_SQL=Netsis_SQL+",C.GRUP_KODU 															  "
                        Netsis_SQL=Netsis_SQL+"FROM ["+currentDB+"].[dbo].[TBLSTOKPH] A WITH (NOLOCK)									  "
                        Netsis_SQL=Netsis_SQL+"INNER JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] C  WITH (NOLOCK)	 ON A.[STOK_KODU]=C.[STOK_KODU] "
                        Netsis_SQL=Netsis_SQL+"INNER JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] D  WITH (NOLOCK)	 ON C.[KOD_1]=D.[GRUP_KOD]	   "
                        Netsis_SQL=Netsis_SQL+"WHERE A.[DEPO_KODU]=10 AND [TOP_GIRIS_MIK]+[TOP_CIKIS_MIK]!=0 			   "
                        Netsis_SQL=Netsis_SQL+"GROUP BY  C.GRUP_KODU 													   "
                        Netsis_SQL=Netsis_SQL+"ORDER BY  C.GRUP_KODU													   "


                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                        sira=0 
                            do until NetsisRecordSet.EOF OR sira>=1000
                                if sira=0 then %>
                                    <div class="container-fluid p-4">
                                    <table class="table table-sm table-striped table-hover align-middle"> 
                                    <thead>              <tr>
                                    <th>Madde Grubu</th> 
                                    <th>Miktar</th> 
                                </tr>     </thead> <%
                                end if 
                                sira=sira+1                                     %>
                                <tr>
                                    <td><%=NetsisRecordSet("GRUP_KODU")%></td> 
                                    <td><b><%=CDbl(NetsisRecordSet("gtop"))-CDbl(NetsisRecordSet("ctop"))%></b></td>
                                </tr>                             <%
                                NetsisRecordSet.movenext
                            Loop                                                
                        NetsisRecordSet.close  
                        if sira=1000 then response.write ("<tr><td colspan=5>Max. 1000 kayıt görüntülendi.</td></tr>")     %> 
                        </table> </div><%
                    ' bolum 3 end
                    %>                
                
                </div>
                </div>
            </div>
            </div>
            <%



        end if %>
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
    parabirimi="---"
    case 9
    parabirimi="TWD"
    end Select
end function

%> 
<!-- #include file="./include/footer.asp" -->