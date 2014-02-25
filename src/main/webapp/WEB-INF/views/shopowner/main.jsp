<script>

	window.location.hash = "p=" + "${pageUid}";
</script>
<h2>
	Min butik
</h2>
<br />
<h3 id="shopName">
	Ica Kvantum Norremark
</h3>
<p id="shopAddress">
	Norremarksv�gen 5<br />
	35245 V�xj�<br />
</p>
<a href="#"><i class="fa fa-edit"></i></a>
<br />
<fieldset class="allWares">
	<legend>
        <span id="shopProductShow" class="active"><a href="#">Varor</a></span>
        <span id="shopProductCreateNew"><a href="#">L�gg till Varor</a></span>
    </legend>
    <div class="shopProductPage">
        <table style="float: left" class="listtable productTable">
            <thead><tr>
                <th></th>
                <th></th>
                <th>
                    Namn <i class="fa fa-sort-down"></i>
                </th>
                <th>
                    Kategori <i class="fa fa-sort-down"></i>
                </th>
                <th>
                    Pris <i class="fa fa-sort-down"></i>
                </th>
                <th></th>
            </tr></thead>
            <tbody></tbody>
        </table>
    </div>
    <div id="shopSelectNewContainer" style="display: none">
        <div>
            <label for="selectNewProductsBrand">Brands</label>
            <select size="6" multiple style="width: 200px" id="selectNewProductsBrand">

            </select>
            <button id="shopNewProductsAdd">L�gg till</button>
            <button>Klart</button>
        </div>
        <div>
            <label for="selectNewProducts">Producter</label>
            <select size="6" multiple style="width: 200px" id="selectNewProducts">
                <option>V�lj ett Brand</option>
            </select>
        </div>
        <div>
            <form id="shopFormNewProducts">
                <table id="shopTableNewProducts" class="listtable shopTableNewProducts">
                    <thead>
                    <tr>
                        <th>Brand</th>
                        <th>Produkt</th>
                        <th>Categori</th>
                        <th>Pris</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>Spendrups</td>
                        <td>Mineralvatten</td>
                        <td>L�sk</td>
                        <td>9.98</td>
                        <td><i class="fa fa-times shopRemoveRow"></i></td>
                    </tr>
                    </tbody>
                </table>
                <button type="submit">Submit</button>
            </form>
        </div>
    </div>
</fieldset>


<fieldset class="allCategories">
	<legend>Kategorier</legend>
	<table class="listtable categoryTable">
		<thead><tr>
			<th></th>
			<th></th>
			<th>
				Namn <i class="fa fa-sort-down"></i>
			</th>
		</tr></thead>
		<tbody></tbody>
	</table>
</fieldset>
<script>
    $( document ).ready(function() {
        function preZero(s){
            s += "";
            if(s.length < 2){
                s = "0" + s;
            }
            return s;
        }
        var d = new Date();
        $("input[name$='date']").val(d.getFullYear() + "-" + preZero(d.getMonth()+1) + "-" + preZero(d.getDate()) + " " + preZero(d.getHours()) + ":" + preZero(d.getMinutes())).prop('disabled', true);

        $.ajax({
            type: "GET",
            url: "/api/product/all/",
            headers: {
                'Accept':"application/json",
                'Content-Type':"application/json"
            },
            dataType: "text",
            success: function (data, textStatus, jqXHR) {
                allProducts = parseJSON(data);
            },
            error: function (data, textStatus, jqXHR) {
                alert("Error: " + textStatus + ", " + jqXHR);
            }
        });
        $.ajax({
            type: "GET",
            url: "/api/store/2/",
            headers: {
                'Accept':"application/json",
                'Content-Type':"application/json"
            },
            dataType: "text",
            success: function (data, textStatus, jqXHR) {
                data = parseJSON(data);
                var arr = data["storeProduct"];
                $("#shopName").html(data["name"]);
                $("#shopAddress").html(data["address"]);

                //$(".shopTable").append("<tbody>");
                $(".productTable tbody").empty();
                for(var i = 0; i < arr.length; i++){
                    var row = '<tr>' +
                            '<td><a href="#"><i class="fa fa-sort-down"></i></a></td>' +
                            '<td><a href="#"><i class="fa fa-sort-up"></i></a></td>' +
                            '<td>';
                    row += arr[i]["product"]["name"];
                    row +=  '</td><td>';
                    row +=  arr[i]["category"]["name"];
                    row +=  '</td><td>';
                    row +=  arr[i]["price"];
                    row +=  '</td><td>' +
                            '<a href="editShop/?id=' + arr[i].id + '"><i class="fa fa-edit"></i></a>' +
                            '</td></tr>';

                    $(".productTable tbody").append(row);
                }
            },
            error: function (data, textStatus, jqXHR) {
                alert("Error: " + textStatus + ", " + jqXHR);
            }
        });
        $.ajax({
            type: "GET",
            url: "/api/brand/all/",
            headers: {
                'Accept':"application/json",
                'Content-Type':"application/json"
            },
            dataType: "text",
            success: function (data, textStatus, jqXHR) {
                data = parseJSON(data);
                //console.log(data);
                //var arr = JSON.parse([data]);

                //$(".shopTable").append("<tbody>");
                $("#selectNewProductsBrand").empty();
                for(var i = 0; i < data.length; i++){
                    var row = '<option value="'+data[i]['id']+'">';
                    row +=  data[i]["name"];
                    row +=  '</option>';

                    $("#selectNewProductsBrand").append(row);
                }

                $(document).on("click", "#selectNewProductsBrand option", function(event){
                    //console.log(event.currentTarget.value);
                    for (var i = 0; i < data.length; i++){
                        var d = data[i];
                        if(d['id'] == event.currentTarget.value){
                            $("#selectNewProducts").empty();
                            if (d['brandProducts'].length == 0) {
                                $("#selectNewProducts").append('<option>Inga Producter</option>');
                                return;
                            }
                            for (var i = 0; i < d['brandProducts'].length; i++) {
                                var row = '<option value="'+d['brandProducts'][i]['id']+'">';
                                row +=  d['brandProducts'][i]["name"];
                                row +=  '</option>';

                                $("#selectNewProducts").append(row);
                                row = undefined;
                            }
                            return;
                        }
                    }
                });

            },
            error: function (data, textStatus, jqXHR) {
                alert("Error: " + textStatus + ", " + jqXHR);
            }
        });
        $.ajax({
            type: "GET",
            url: "/api/category/all/",
            headers: {
                'Accept':"application/json",
                'Content-Type':"application/json"
            },
            dataType: "json",
            success: function (data, textStatus, jqXHR) {
                allCategories = data;
                //console.log(data);
                //data = parseJSON(data);
            }
        });
        setStoreAllProducts();
        setStoreProductTable(2);
        setStoreNewProductBrandSelect();
        setStoreCategoriesTable();
    });

</script>
