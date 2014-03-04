<script>

	window.location.hash = "p=" + "${pageUid}";
</script>
<h2>
	Min butik
</h2>
<br />
<h3 id="shopName">
</h3>
<p id="shopAddress">
Du �r inte satt som administrat�r f�r n�gon butik?
<br />
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
                <th></th>
            </tr></thead>
            <tbody></tbody>
        </table>
        <div id="shopEditContainer" style="float: right; display: none">
            <form>
                <p>Product:<span>Here</span></p>
                <div id="categorySelect"></div>
                <input type="text" name="price">
                <button>Spara</button>

            </form>
        </div>
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
    var currentStore;
    $( document ).ready(function() {

        $.ajax({
            type: "GET",
            url: '/api/store/all/',
            headers: {
                'Accept':"application/json",
                'Content-Type':"application/json"
            },
            dataType: "text",
            success: function (data) {
                var stores = parseJSON(data);
                for(var i = 0; i < stores.length; i++){
                    var store = stores[i];
                    var user = store['user'];
                    if('${username}' == user['username']){
                            currentStore = store;
                    }
                }
                setStoreAllProducts();

                setStoreProductTable(currentStore.id);

                setStoreNewProductBrandSelect();

                setStoreCategoriesTable();
            },
            error: function (data, textStatus, jqXHR) {
                alert("Error: " + textStatus + ", " + jqXHR);
            }
        });


    });

</script>
