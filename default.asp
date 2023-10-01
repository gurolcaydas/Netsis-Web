<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Main" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"u") then 'needed level'
    	%>
	  <div class="container p-1" style="margin-top:80px;">
      <div class="container">
      <p class="h1">Netsis</p> 
      </div>
            <div class="row">

              <div class="col-sm-4">
                        <div class="card p-1 text-center" style="margin:20px;">
                          <div class="card-body">
                            <h5 class="card-title"><i class="bi bi-bicycle p-4"></i>Reçeteler ve ilk maddeler</h5>
                            <p class="card-text">Reçeteleri yada ilk maddeleri filtre ile aramak için.</p>
                            <!--<a href='NetsisBom.asp' class="btn btn-secondary"><i class="bi bi-bicycle p-2 h3"></i></a> -->
                                        <form method='get'  action="NetsisBom.asp">
                                            <div class="input-group mb-3 d-print-none">  
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text bg-secondary"><i class="bi bi-search"></i></span>
                                                </div>
                                                <input type='hidden' name='doo' value='bikelist'>          
                                                <input class="form-control" type="text" name="search_bisiklet"  placeholder="Madde Açıklaması"  value="<%=search_bisiklet%>">
                                                <button class="btn btn-secondary"  type="submit"  name="B1"  id="button-addon2"><i class="bi bi-arrow-return-left"></i></button>
                                            </div>                                  
                                        </form>      
                          </div>
                        </div>
              </div>
              <div class="col-sm-4">
                        <div class="card p-1 text-center" style="margin:20px;">
                          <div class="card-body">
                            <h5 class="card-title"><i class="bi bi-folder p-4"></i></i>Stok kartı detayları</h5>
                            <p class="card-text">Stok kartı bilgileri, stok durumları ve bağlı fiyat listeleri.</p>
                            <!--<a href='NetsisBom.asp?doo=kullanimyeri' class="btn btn-warning"><i class="bi bi-folder p-2 h3"></i></a>-->
                                        <form method='get'  action="NetsisBom.asp">
                                            <div class="input-group mb-3 d-print-none">  
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text bg-warning"><i class="bi bi-search"></i></span>
                                                </div>
                                                <input type='hidden' name='doo' value='kullanimyeri'>          
                                                <input type="text" class="form-control" name='item' value='<%=url_item%>'  placeholder="SKU#" aria-label="Madde Kodu" aria-describedby="button-addon2">
                                                <button class="btn btn-secondary"  type="submit"  name="B1"  id="button-addon2"><i class="bi bi-arrow-return-left"></i></button>
                                            </div>                                  
                                        </form>                            
                          </div>
                        </div>
              </div>
              <div class="col-sm-4">
                <div class="card p-1 text-center" style="margin:20px;">
                  <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-bar-chart-steps p-4"></i>Reçete detayları</h5>
                    <p class="card-text">Reçeteyi detaylı inceleme.</p>
                    <!--<a href='NetsisBom.asp?doo=bomlist' class="btn btn-primary"><i class="bi bi-bar-chart-steps p-2 h3"></i></a>-->
                      <form method='get'  action="NetsisBom.asp">
                          <div class="input-group  mb-3 d-print-none">  
                              <div class="input-group-prepend">
                                  <span class="input-group-text bg-primary text-white"><i class="bi bi-search"></i></span>
                              </div>
                              <input type='hidden' name='doo' value='bomlist'>          
                              <input type="text" class="form-control" name='item' value='<%=url_item%>'  placeholder="Madde Kodu" aria-label="SKU#" aria-describedby="button-addon2">
                              <button class="btn btn-secondary"  type="submit"  name="B1"  id="button-addon2"><i class="bi bi-arrow-return-left"></i></button>
                          </div>                                  
                      </form>                            
                  </div>
                </div>
              </div>
              <% if instr(UserLevel,"m") then 'needed level'   %>                 
              <div class="col-sm-4">
                        <div class="card p-1 text-center" style="margin:20px;">
                          <div class="card-body">
                            <h5 class="card-title"><i class="bi bi-body-text p-4"></i>Reçete karşılaştırma</h5>
                            <p class="card-text">İki reçeteyi detaylı karşılaştırma.</p>
                            <a href='CompareBoM.asp' class="btn btn-secondary"><i class="bi bi-body-text p-2 h3"></i></a>
                          </div>
                        </div>
              </div>
                <div class="col-sm-4">
                          <div class="card p-1 text-center" style="margin:20px;">
                            <div class="card-body">
                              <h5 class="card-title"><i class="bi bi-currency-exchange p-4"></i>Satınalma Fiyat Listeleri</h5>
                              <p class="card-text">Filtreli fiyat listesi raporu.</p>
                              <a href='FiyatListeleriSA.asp' class="btn btn-secondary"><i class="bi bi-currency-exchange p-2 h3"></i></a>
                            </div>
                          </div>
                </div> 
              <% end if %>
              <% if instr(UserLevel,"s") then 'needed level'   %>                 
                <div class="col-sm-4">
                          <div class="card p-1 text-center" style="margin:20px;">
                            <div class="card-body">
                              <h5 class="card-title"><i class="bi bi-currency-exchange p-4"></i>Tüm Fiyat Listeleri</h5>
                              <p class="card-text">Satınalma ve Satış filtreli fiyat listesi raporu.</p>
                              <a href='FiyatListeleri.asp' class="btn btn-warning"><i class="bi bi-currency-exchange p-2 h3"></i></a>
                            </div>
                          </div>
                </div> 
              <% end if %>
              <% if instr(UserLevel,"a") then 'needed level'   %>                 
              <div class="col-sm-4">
                        <div class="card p-1 text-center" style="margin:20px;">
                          <div class="card-body">
                            <h5 class="card-title"><i class="bi bi-pie-chart-fill p-4"></i>İstatistikler</h5>
                            <p class="card-text">Deneysel</p>
                            <a href='KPI.asp?doo=urge' class="btn btn-danger"><i class="bi bi-pie-chart-fill p-2 h3"></i></a>
                          </div>
                        </div>
              </div>           
              <div class="col-sm-4">
                        <div class="card p-1 text-center" style="margin:20px;">
                          <div class="card-body">
                            <h5 class="card-title"><i class="bi bi-pie-chart-fill p-4"></i>Üretim</h5>
                            <p class="card-text">Deneysel</p>
                            <a href='chart-uretimler.asp' class="btn btn-danger"  target="_blank"><i class="bi bi-graph-up-arrow p-2 h3"></i></a>
                          </div>
                        </div>
              </div>                          
              <% end if %>
            </div>  
    </div>  
  <%
else

end if
%> 

<!-- #include file="./include/footer.asp" -->