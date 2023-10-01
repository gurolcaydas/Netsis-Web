function AcKapa(p1) {
  let element = document.getElementById(p1);
  let hidden = element.getAttribute("hidden");
  if (hidden) {
    element.removeAttribute("hidden");
  } else {
    element.setAttribute("hidden", "hidden");
  }
}

function doStuff(p1, p2) {
  for (var i = p2; i <= 200; i++) {
    document.getElementById("degerler").innerHTML =
      document.getElementById("degerler").innerHTML + " " + i;
    let el = document.getElementById(p1 + "" + i);
    let hidden = el.getAttribute("hidden");
    if (hidden) {
      el.removeAttribute("hidden");
    } else {
      el.setAttribute("hidden", "hidden");
    }
  }
}

function showHint(str) {
  if (str.length == 0) {
    document.getElementById("fiyatlar").innerHTML = "";
    return;
  }
  document.getElementById("fiyatlarbaslik").innerHTML = "Fiyatlar <br>" + str;
  document.getElementById("fiyatlar").innerHTML =
    "<div class='d-flex justify-content-center'><div class='spinner-grow spinner-grow-sm' role='status'><span class='sr-only'></span></div></div>";
  const xhttp = new XMLHttpRequest();
  xhttp.onload = function () {
    document.getElementById("fiyatlar").innerHTML = this.responseText;
  };
  xhttp.open("GET", "subs/fiyatlar.asp?item=" + str);
  xhttp.send();
}

function showtekzimba(str) {
  document.getElementById("tekzimba").innerHTML = "ddddddd";
  if (str.length == 0) {
    document.getElementById("tekzimba").innerHTML = "";
    return;
  }
  document.getElementById("tekzimbabaslik").innerHTML = "Tek Zımba <br>" + str;
  document.getElementById("tekzimba").innerHTML =
    "<div class='d-flex justify-content-center'><div class='spinner-grow spinner-grow-sm' role='status'><span class='sr-only'></span></div></div>";
  const xhttp = new XMLHttpRequest();
  xhttp.onload = function () {
    document.getElementById("tekzimba").innerHTML = this.responseText;
  };
  xhttp.open("GET", "subs/tekzimba.asp?item=" + str);
  xhttp.send();
}

function showStokKart(str) {
  if (str.length == 0) {
    document.getElementById("fiyatlar2").innerHTML = "";
    return;
  }
  document.getElementById("fiyatlarbaslik2").innerHTML =
    "Stok Kartı Detayları <br>" + str;
  document.getElementById("fiyatlar2").innerHTML =
    "<div class='d-flex justify-content-center'><div class='spinner-grow spinner-grow-sm' role='status'><span class='sr-only'></span></div></div>";
  const xhttp = new XMLHttpRequest();
  xhttp.onload = function () {
    document.getElementById("fiyatlar2").innerHTML = this.responseText;
  };
  xhttp.open("GET", "subs/SKUdetails.asp?item=" + str);
  xhttp.send();
}

function showAltBom(str) {
  if (str.length == 0) {
    document.getElementById("fiyatlar3").innerHTML = "";
    return;
  }
  document.getElementById("fiyatlarbaslik3").innerHTML =
    "Üretim Emri Reçete Listesi <br>" + str;
  document.getElementById("fiyatlar3").innerHTML =
    "<div class='d-flex justify-content-center'><div class='spinner-grow spinner-grow-sm' role='status'><span class='sr-only'></span></div></div>";
  const xhttp = new XMLHttpRequest();
  xhttp.onload = function () {
    document.getElementById("fiyatlar3").innerHTML = this.responseText;
  };
  xhttp.open("GET", "subs/AltBomList.asp?item=" + str);
  xhttp.send();
}

function showAltBomList(str, str2) {
  if (str.length == 0) {
    document.getElementById("fiyatlar3").innerHTML = "";
    return;
  }
  document.getElementById("fiyatlarbaslik3").innerHTML =
    "Üretim Emri Reçete Listesi <br>" + str + " *" + str2 + "*";
  document.getElementById("fiyatlar3").innerHTML =
    "<div class='d-flex justify-content-center'><div class='spinner-grow spinner-grow-sm' role='status'><span class='sr-only'></span></div></div>";
  const xhttp = new XMLHttpRequest();
  xhttp.onload = function () {
    document.getElementById("fiyatlar3").innerHTML = this.responseText;
  };
  xhttp.open("GET", "subs/isemriBom.asp?item=" + str + "&isemri=" + str2);
  xhttp.send();
}

var exampleModal = document.getElementById("exampleModal");
exampleModal.addEventListener("show.bs.modal", function (event) {
  // Button that triggered the modal
  var button = event.relatedTarget;
  // Extract info from data-bs-* attributes
  var recipient = button.getAttribute("data-bs-whatever");
  // If necessary, you could initiate an AJAX request here
  // and then do the updating in a callback.
  //
  // Update the modal's content.
  var modalTitle = exampleModal.querySelector(".modal-title");
  var modalBodyInput = exampleModal.querySelector(".modal-body input");

  modalTitle.textContent = "New message to " + recipient;
  modalBodyInput.value = recipient;
});

// Compare BOM

function showSKUlist(alan, alan2) {
  document.getElementById(alan).innerHTML =
    "<div class='d-flex justify-content-center'><div class='spinner-grow spinner-grow-sm' role='status'><span class='sr-only'></span></div></div>";
  document.getElementById(alan2).innerHTML = "";
  str1 = document.getElementById("ara1").value;
  str2 = document.getElementById("ara2").value;
  str3 = document.getElementById("ara3").value;
  if (str1.length == 0) {
    document.getElementById(alan).innerHTML = "";
    return;
  } else {
    const xmlhttp = new XMLHttpRequest();
    xmlhttp.onload = function () {
      document.getElementById(alan).innerHTML = this.responseText;
    };
    xmlhttp.open(
      "GET",
      "subs/SKUlist.asp?q=" + str1 + "&r=" + str2 + "&p=" + str3 + "&s=" + alan2
    );
    xmlhttp.send();
  }
}
function showSKUlist2(alan, alan2) {
  document.getElementById(alan).innerHTML =
    "<div class='d-flex justify-content-center'><div class='spinner-grow spinner-grow-sm' role='status'><span class='sr-only'></span></div></div>";
  document.getElementById(alan2).innerHTML = "";
  str1 = document.getElementById("ara4").value;
  str2 = document.getElementById("ara5").value;
  str3 = document.getElementById("ara6").value;
  if (str1.length == 0) {
    document.getElementById(alan).innerHTML = "";
    return;
  } else {
    const xmlhttp = new XMLHttpRequest();
    xmlhttp.onload = function () {
      document.getElementById(alan).innerHTML = this.responseText;
    };
    xmlhttp.open(
      "GET",
      "subs/SKUlist.asp?q=" + str1 + "&r=" + str2 + "&p=" + str3 + "&s=" + alan2
    );
    xmlhttp.send();
  }
}

function showBOMlist(urlink, divID) {
  document.getElementById(divID).innerHTML =
    "<div class='d-flex justify-content-center'><div class='spinner-grow spinner-grow-sm' role='status'><span class='sr-only'></span></div></div>";
  document.getElementById("txtCompare").innerHTML = "";

  if (urlink.length == 0) {
    document.getElementById(divID).innerHTML = "";
    return;
  }
  const xhttp = new XMLHttpRequest();
  xhttp.onload = function () {
    document.getElementById(divID).innerHTML = this.responseText;
  };
  xhttp.open("GET", urlink);
  xhttp.send();
}
function compare2SKU(divID) {
  document.getElementById("txtBoM1").innerHTML = "";
  document.getElementById("txtBoM2").innerHTML = "";
  var my_data = document.getElementsByName("radiotxtBoM1"); // array
  flag = 0;
  for (i = 0; i < my_data.length; i++) {
    if (my_data[i].checked) {
      var str1 = my_data[i].value;
      flag = 1;
    }
  }

  var my_data2 = document.getElementsByName("radiotxtBoM2"); // array
  flag = 0;
  for (i = 0; i < my_data2.length; i++) {
    if (my_data2[i].checked) {
      var str2 = my_data2[i].value;
      flag = 1;
    }
  }
  document.getElementById("BoM1").innerHTML = str1;
  document.getElementById("BoM2").innerHTML = str2;
  str3 =
    "<div class='d-flex justify-content-center'><div class='spinner-grow spinner-grow-sm' role='status'><span class='sr-only'></span></div></div>";
  // str3 = " compare2SKU.asp?sku1=" + str1 + "&sku2=" + str2;
  document.getElementById(divID).innerHTML = str3;
  if (divID.length == 0) {
    document.getElementById(divID).innerHTML = "";
    return;
  }
  const xhttp = new XMLHttpRequest();
  xhttp.onload = function () {
    document.getElementById(divID).innerHTML = this.responseText;
  };
  xhttp.open("GET", "subs/compare2SKU.asp?sku1=" + str1 + "&sku2=" + str2);
  xhttp.send();
}

// Compare Job BOM

function showJoblist(alan, alan2) {
  document.getElementById(alan).innerHTML =
    "<div class='d-flex justify-content-center'><div class='spinner-grow spinner-grow-sm' role='status'><span class='sr-only'></span></div></div>";
  document.getElementById(alan2).innerHTML = "";
  str1 = document.getElementById("ara1").value;
  str2 = document.getElementById("ara2").value;
  str3 = document.getElementById("ara3").value;
  if (str1.length == 0) {
    document.getElementById(alan).innerHTML = "";
    return;
  } else {
    const xmlhttp = new XMLHttpRequest();
    xmlhttp.onload = function () {
      document.getElementById(alan).innerHTML = this.responseText;
    };
    xmlhttp.open(
      "GET",
      "subs/JOBlist.asp?q=" + str1 + "&r=" + str2 + "&p=" + str3 + "&s=" + alan2
    );
    xmlhttp.send();
  }
}
function showJoblist2(alan, alan2) {
  document.getElementById(alan).innerHTML =
    "<div class='d-flex justify-content-center'><div class='spinner-grow spinner-grow-sm' role='status'><span class='sr-only'></span></div></div>";
  document.getElementById(alan2).innerHTML = "";
  str1 = document.getElementById("ara4").value;
  str2 = document.getElementById("ara5").value;
  str3 = document.getElementById("ara6").value;
  if (str1.length == 0) {
    document.getElementById(alan).innerHTML = "";
    return;
  } else {
    const xmlhttp = new XMLHttpRequest();
    xmlhttp.onload = function () {
      document.getElementById(alan).innerHTML = this.responseText;
    };
    xmlhttp.open(
      "GET",
      "subs/JOBlist.asp?q=" + str1 + "&r=" + str2 + "&p=" + str3 + "&s=" + alan2
    );
    xmlhttp.send();
  }
}

function compare2JobBom(divID) {
  document.getElementById("txtBoM1").innerHTML = "";
  document.getElementById("txtBoM2").innerHTML = "";
  var my_data = document.getElementsByName("radiotxtBoM1"); // array
  flag = 0;
  for (i = 0; i < my_data.length; i++) {
    if (my_data[i].checked) {
      var str1 = my_data[i].value;
      flag = 1;
    }
  }

  var my_data2 = document.getElementsByName("radiotxtBoM2"); // array
  flag = 0;
  for (i = 0; i < my_data2.length; i++) {
    if (my_data2[i].checked) {
      var str2 = my_data2[i].value;
      flag = 1;
    }
  }
  document.getElementById("BoM1").innerHTML = str1;
  document.getElementById("BoM2").innerHTML = str2;
  str3 =
    "<div class='d-flex justify-content-center'><div class='spinner-grow spinner-grow-sm' role='status'><span class='sr-only'></span></div></div>";
  // str3 = " compare2SKU.asp?sku1=" + str1 + "&sku2=" + str2;
  document.getElementById(divID).innerHTML = str3;
  if (divID.length == 0) {
    document.getElementById(divID).innerHTML = "";
    return;
  }
  const xhttp = new XMLHttpRequest();
  xhttp.onload = function () {
    document.getElementById(divID).innerHTML = this.responseText;
  };
  xhttp.open("GET", "subs/compare2SKU.asp?sku1=" + str1 + "&sku2=" + str2);
  xhttp.send();
}

// EXCEL *******************************************************************************************************************************************************
function exportTableToExcel(tableID, filename = "") {
  var downloadLink;
  var dataType = "application/vnd.ms-excel";
  var tableSelect = document.getElementById(tableID);
  var tableHTML = tableSelect.outerHTML.replace(/ /g, "%20");

  // Specify file name
  filename = filename ? filename + ".xls" : "excel_data.xls";

  // Create download link element
  downloadLink = document.createElement("a");

  document.body.appendChild(downloadLink);

  if (navigator.msSaveOrOpenBlob) {
    var blob = new Blob(["\ufeff", tableHTML], {
      type: dataType,
    });
    navigator.msSaveOrOpenBlob(blob, filename);
  } else {
    // Create a link to the file
    downloadLink.href = "data:" + dataType + ", " + tableHTML;

    // Setting the file name
    downloadLink.download = filename;

    //triggering the function
    downloadLink.click();
  }
}
