<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML=" " %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level'
%>
    <div class="container-fluid" style="margin-top:80px">
        <div class="container-fluid m-3 pt-2"><h4>Reçete Karşılaştırma</h4>
            <div class="row row-cols-2">
                <div class="col">
                    <p><span class="h5" id="BoM1">BoM1: </span></p>
                    <div class="input-group mb-3 d-print-none">                        
                        <input type="text"  class="form-control" id='ara1'  placeholder="Stok Kodu"   onkeyup="showSKUlist('txtHint1','txtBoM1')">
                        <input type="text"  class="form-control" id='ara2'  placeholder="Stok Adı"  onkeyup="showSKUlist('txtHint1','txtBoM1')">
                        <input type="text"  class="form-control" id='ara3'  placeholder="KOD1"   onkeyup="showSKUlist('txtHint1','txtBoM1')">
                    </div>              
                    <p class="d-print-none"><span id="txtHint1"></span></p>    
                    <p><span id="txtBoM1"></span></p>
                </div>
                <div class="col">
                    <p><span class="h5" id="BoM2">BoM2: </span></p>
                    <div class="input-group mb-3 d-print-none">                 
                        <input type="text"  class="form-control" id='ara4' placeholder="Stok Kodu"  onkeyup="showSKUlist2('txtHint2','txtBoM2')">
                        <input type="text"  class="form-control" id='ara5' placeholder="Stok Adı"  onkeyup="showSKUlist2('txtHint2','txtBoM2')">
                        <input type="text"  class="form-control" id='ara6'  placeholder="KOD1" onkeyup="showSKUlist2('txtHint2','txtBoM2')">
                        <input type="button" class="btn btn-secondary"   title="Karşılaştır"  value="Karşılaştır" onclick="compare2SKU('txtCompare')"/>
                    </div>
                    <p class="d-print-none"><span id="txtHint2"></span></p>     
                    <p><span id="txtBoM2"></span></p>
                </div>
            </div>
        </div>

        <div class="container-fluid m-3 pt-2">
            <p><span id="txtCompare"></span></p>
        </div>
    </div>
	<%

else

end if
%> 

<!-- #include file="./include/footer.asp" -->
