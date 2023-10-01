<% if instr(Userlevel,"u") then  %>

<nav class="navbar fixed-top navbar-expand-md navbar-dark bg-dark d-print-none">

    <div class="container-fluid">
        <a class="navbar-brand" href="default.asp"><span class="badge bg-secondary"><img height=40 src="img/logo.png"></span></a>
 


        <button data-bs-toggle="collapse" class="navbar-toggler" data-bs-target="#navcol-1"><span class="visually-hidden">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse " id="navcol-1">
            <ul class="navbar-nav navbar-nav-scroll ms-auto">
                <li class="nav-item dropdown "><a class="nav-link dropdown-toggle" href="default.asp" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <%=currentDB%> 
                    </a>
                     <ul class="dropdown-menu dropdown-menu-end"  aria-labelledby="navbarDropdown">  
                        <%
                            gelenURL=Request.QueryString
                            if instr(gelenURL,"yil") then 
                            gelenURL=right(gelenURL,len(gelenURL)-instr(gelenURL,"&"))
                            end if
                        %>
                        <li><a class="dropdown-item" href='?yil=2022&<%=gelenURL%>'><span><div class="badge badge-pill bg-info"><i class="bi bi-binoculars-fill"></i></div> 2022</span> </a></li>
                        <li><a class="dropdown-item" href='?yil=2023&<%=gelenURL%>'><span><div class="badge badge-pill bg-info"><i class="bi bi-binoculars-fill"></i></div> 2023</span> </a></li>
                        </ul>
                    </li>
                    

                <li class="nav-item dropdown ">
                    <a class="nav-link dropdown-toggle" href="default.asp" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Ürge 
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end"  aria-labelledby="navbarDropdown">  
                        <li><a class="dropdown-item" href='NetsisBom.asp'><span><div class="badge badge-pill bg-info"><i class="bi bi-binoculars-fill"></i></div> Reçete, İlk madde detaylı arama</span> </a></li>
                        <li><a class="dropdown-item" href='NetsisBom.asp?doo=kullanimyeri'><span><div class="badge badge-pill bg-warning"><i class="bi bi-search"></i></div> Stok Kartı Detayları</span></a></li>
                        <li><a class="dropdown-item" href='NetsisBom.asp?doo=bomlist'><span><div class="badge badge-pill bg-primary"><i class="bi bi-journal-text"></i></div> Reçeteler</span></a></li>
                        <div class="dropdown-divider"></div>
                        <li><a class="dropdown-item" href='Rapor-parcadan-parcabul.asp'><span><div class="badge badge-pill bg-dark"><i class="bi bi-binoculars-fill"></i></div> Parçadan Parça Bul</span></a></li>
                        <div class="dropdown-divider"></div>

                        <li><a class="dropdown-item" href='Rapor-malzeme-siparis-degerlendirme.asp'><span><div class="badge badge-pill bg-danger"><i class="bi bi-binoculars-fill"></i></div> Malzeme Sipariş Değerlendirme</span></a></li>
                        <li><a class="dropdown-item" href='Rapor-malzeme-siparis-degerlendirme2.asp'><span><div class="badge badge-pill bg-danger"><i class="bi bi-journal-text"></i></div> Malzeme Sipariş Değerlendirme <div class="badge badge-pill bg-danger">Toplu</div></span></a></li>
                        <li><a class="dropdown-item" href='AX.asp'><span><div class="badge badge-pill bg-dark">AX</div> Reçeteler</span></a></li>
                        <li><a class="dropdown-item" href='Rapor-tekillestirme.asp'><span>Tekilleştirilen Yarı Mamüller</span></a></li>
                        <li><a class="dropdown-item" href='Rapor-Yari-Mamul-listesi.asp'><span>Mamül-Yarı Mamül</span></a></li>
                        <% if instr(Userlevel,"m")   then       %>
                            <li><a class="dropdown-item" href='CompareBoM.asp'><span><div class="badge badge-pill bg-success"><i class="bi bi-card-checklist"></i></div> İki Reçete Karşılaştır</span></a></li>
                            <li><a class="dropdown-item" href='Rapor-sifir-miktarli-bom-satiri.asp'><span>Sıfır Miktarlı BoM Satırları</span></a></li>
                            <li><a class="dropdown-item" href='Rapor-AX-SKU.asp'><span><div class="badge badge-pill bg-dark">AX</div> Axapta Stok Kartları</span></a></li>                          <li><a class="dropdown-item" href='Rapor-yalin-recete.asp'><span>Reçete</span></a></li>                         
                            <li><a class="dropdown-item" href='Rapor-AX-Netsis-recete-kontrol.asp'><span><div class="badge badge-pill bg-dark">AX</div> AX-Netsis Reçete Satırı Birim Kontrol</span></a></li>
                        <%  end if  %>
                        <% if instr(Userlevel,"s")   then       %>

                        <li><a class="dropdown-item" href='urge-jobs-done.asp'  target="_blank"><span><div class="badge badge-pill bg-danger">KPI</div> Jobs Done!</span></a></li>

                        
                        <%  end if  %>
                        <% if instr(Userlevel,"x")   then       %>
                                <div class="dropdown-divider"></div>
                                <li><a class="dropdown-item" href='KPI.asp?doo=urge'><span><div class="badge badge-pill bg-info"><i class="bi bi-graph-up-arrow"></i></div> İstatistikler</span></a></li>
                                <li><a class="dropdown-item" href='KPI.asp?doo=urgedepo'><span><div class="badge badge-pill bg-secondary"><i class="bi bi-box-seam"></i></div> Ürge Depo Miktarları</span></a></li>
                                <li><a class="dropdown-item" href='KPI.asp?doo=tekzimbadepo'><span><div class="badge badge-pill bg-secondary"><i class="bi bi-box-seam"></i></div> Tek Zımba Depo Miktarları</span></a></li>
                                <li><a class="dropdown-item" href='Rapor-sube-eksi-bir.asp'><span>İşletme ve Şube Kodu</span></a></li>

                        <%  end if  %>
                    </ul>
                </li>

                <li class="nav-item dropdown ">
                    <a class="nav-link dropdown-toggle" href="default.asp" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Planlama
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end"  aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href='Stok-Tedarikci.asp'><span>Stok Kartı - Tedarikçi Bilgileri</span></a></li>
                        <% if instr(Userlevel,"m")   then       %>
                            <div class="dropdown-divider"></div>
                            <li><a class="dropdown-item" href='Rapor-MusteriSiparisleri.asp'><span>Müşteri Siparişleri</span></a></li>
                            <li><a class="dropdown-item" href='Rapor-acik-siparisler.asp'><span>Açık Siparişler</span></a></li>                            
                            <li><a class="dropdown-item" href='Rapor-kod2-caristok.asp'><span>Stok Kod2 ve Cari-Stok Bağlantısı</span></a></li>
                            
                        <%  end if  %>
                        <% if instr(Userlevel,"s")   then       %>

                            <li><a class="dropdown-item" href='Rapor-TML.asp'><span>TML (ham veri)</span></a></li>
                            <li><a class="dropdown-item" href='Rapor-ilkmadde-recete-musteri-siparis-uretici-kodu.asp'><span>Üretici koduna göre Müşteri Mamül Siparişleri</span></a></li>
                            <li><a class="dropdown-item" href='Chart-isemirleri.asp' target="_blank"><span><div class="badge badge-pill bg-danger"><i class="bi bi-bar-chart"></i></div> İş Emirleri Chart MY</span></a></li>
                            <li><a class="dropdown-item" href='Chart-isemirleri2.asp' target="_blank"><span><div class="badge badge-pill bg-danger"><i class="bi bi-bar-chart"></i></div> İş Emirleri Chart Marka</span></a></li>

                        <%  end if  %>
                        <% if instr(Userlevel,"r")   then       %>
                            <li><a class="dropdown-item" href='Rapor-ilkmadde-recete-musteri-siparis.asp'><span>İlk Maddeye göre Müşteri Mamül Siparişleri</span></a></li>
                        <%  end if  %>
                        <% if instr(Userlevel,"x")   then       %>
                                <li><a class="dropdown-item" href='Rapor-CariStokEksik.asp'><span>Müşteri-Satıcı-Stok Kayıt Eksikleri</span></a></li>
                                <li><a class="dropdown-item" href='Rapor-SKUden-stok-durumu.asp'><span>Stok Durumu</span></a></li>
                        <%  end if  %>
                    </ul>
                </li>

                <li class="nav-item dropdown ">
                    <a class="nav-link dropdown-toggle" href="default.asp" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Üretim
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end"  aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href='Rapor-mamul-yarimamul.asp'><span>Mamül - Yari Mamül Bağlantısı</span></a></li>
                        <% if instr(Userlevel,"m")   then       %>
                            <li><a class="dropdown-item" href='Rapor-isemri-depo-bakiye.asp'><span>İş Emri Depo Bakiye</span></a></li>
                            <li><a class="dropdown-item" href='Rapor-isemri-recete-toplu.asp'><span>İş Emri Reçete Toplu Basım</span></a></li>
                            <li><a class="dropdown-item" href='Rapor-Isemri-bul.asp'><span><div class="badge badge-pill bg-danger"><i class="bi bi-search"></i></div> İş Emri Bul (Madde kodu yada İşemri no)</span></a></li>
                            <li><a class="dropdown-item" href='isemriBoMkarsilastir.asp'><span>İş Emri BoM Karşılaştır</span></a></li>
                        <%  end if  %>
                        <% if instr(Userlevel,"p")   then       %>
                            <li><a class="dropdown-item" href='Rapor-uretimler.asp'><span><div class="badge badge-pill bg-danger"><i class="bi bi-search"></i></div> Üretimler</span></a></li>
                            <li><a class="dropdown-item" href='chart-uretimler.asp' target="_blank"><span><div class="badge badge-pill bg-danger"><i class="bi bi-bar-chart"></i></div> Üretimler Chart</span></a></li>
                            <li><a class="dropdown-item" href='Rapor-teker-yarimamul.asp'><span>Mamül - Tekerlek Yarı Mamül Bağlantısı</span></a></li>
                        <%  end if  %>
                        <% if instr(Userlevel,"s")   then       %>
                            <li><a class="dropdown-item" href='rapor-depolar.asp'><span>Depolar</span></a></li>
                            
                        <%  end if  %>
                    </ul>
                </li>

                <% if instr(Userlevel,"s")   then       %>
                    <li class="nav-item dropdown ">
                        <a class="nav-link dropdown-toggle" href="default.asp" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Maliyet
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end"  aria-labelledby="navbarDropdown">
                            <% if instr(Userlevel,"s")   then       %>
                            
                                <li><a class="dropdown-item" href='Rapor-isemri-maliyet.asp'><div class="badge badge-pill bg-success"><i class="bi bi-currency-exchange"></i></div><span> İşemri Maliyetleri</span></a></li>
                                <li><a class="dropdown-item" href='Rapor-recete-fiyatli.asp'><span>Reçete Fiyatlı en</span></a></li>
                                <li><a class="dropdown-item" href='FiyatListeleri.asp'><div class="badge badge-pill bg-warning"><i class="bi bi-currency-exchange"></i></div><span> Tüm Fiyat Listeleri</span></a></li>
                                <li><a class="dropdown-item" href='Rapor-maliyet-katsayilar.asp'><span>Maliyet Katsayıları</span></a></li>
                                <li><a class="dropdown-item" href='Rapor-koda-gore-maliyet-katsayisi-listele.asp'><span>Landed Cost</span></a></li>
                                <li><a class="dropdown-item" href='Rapor-mamul-bilgileri.asp'><span>Mamül Bilgilari - Önceki Kod</span></a></li>
                                <li><a class="dropdown-item" href='Rapor-aylik-maliyet.asp'><span>Stok Maliyetleri Raporu</span></a></li>
                                <div class="dropdown-divider"></div>
                                <li><a class="dropdown-item" href='AX.asp?doo=costsearch'><span><div class="badge badge-pill bg-dark">AX</div> Maliyet Katsayı Analiz Raporu</span></a></li>
                            <%  end if  %>
                        </ul>
                    </li>
                <%  end if  %>
                
                <% if instr(Userlevel,"f")   then       %>
                    <li class="nav-item dropdown ">
                        <a class="nav-link dropdown-toggle" href="default.asp" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Satınalma
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end"  aria-labelledby="navbarDropdown">
                            <% if instr(Userlevel,"m")   then       %>
                            <%  end if  %>
                            <% if instr(Userlevel,"s")   then       %>
                            <%  end if  %>
                            <% if instr(Userlevel,"f")   then       %>
                                <li><a class="dropdown-item" href='FiyatListeleriSA.asp'><div class="badge badge-pill bg-secondary"><i class="bi bi-currency-exchange"></i></div><span> Satınalma Fiyat Listeleri</span></a></li>
                                <li><a class="dropdown-item" href='Rapor-fiyat-listesi-cift-fiyat-satiri.asp'><span>Fiyat Listesi - Çift Fiyat Satırı</span></a></li>
                            <%  end if  %>
                            <% if instr(Userlevel,"x")   then       %>
                            <%  end if  %>
                        </ul>
                    </li>
                <%  end if  %>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <%=Session("Username")%>
                    </a>
                    <ul class="dropdown-menu  dropdown-menu-end"  aria-labelledby="navbarDropdown">
                        <% if instr(Userlevel,"a") then  %>
                                <li><a class="dropdown-item" href='users.asp'><span>Kullanıcılar</span></a> </li>
                        <%  end if        %>
                        <li><a class="dropdown-item" href='user.asp?function=view'><span>Profil</span></a> </li>
                        <li><a class="dropdown-item" href='default.asp?mode=logout'><span>LogOut</span></a> </li>
                    </ul>
                </li>

            </ul>
        </div>
    </div>
                <form method='get'  action="NetsisBom.asp">
                <div class="container-fluid input-group d-print-none">  
                    <input type='hidden' name='doo' value='kullanimyeri'>          
                    <input type="text" class="form-control" name='item' value='<%=url_item%>'  placeholder="SKU#" aria-label="SKU#" aria-describedby="button-addon2">
                    <button class="btn btn-secondary"  type="submit"  name="B1"  id="button-addon2"><i class="bi bi-arrow-return-left"></i></button>
                </div>                                  
            </form>   
</nav>
<% end if %>

