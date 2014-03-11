<div id="shopScriptLoader">
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
Du är inte har inte rättigheter till detta.
<br />
</p>
<br />
<fieldset class="allWares">
	<legend>
        <span id="shopProductShow" class="active"><a href="#">Varor</a></span>
        <span id="shopProductCreateNew"><a href="#">Lägg till Varor</a></span>
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
                <p>Produkt:<span></span></p>
                <div id="categorySelect"></div>
                <input type="text" name="price">
                <button>Spara</button>

            </form>
        </div>
    </div>
    <div id="shopSelectNewContainer" style="display: none">
        <div>
            <label for="selectNewProductsBrand">Varumärken</label>
            <select size="6" multiple style="width: 200px" id="selectNewProductsBrand">

            </select>
            <button id="shopNewProductsAdd">Lägg till</button>
            <button>Klart</button>
        </div>
        <div>
            <label for="selectNewProducts">Produkter</label>
            <select size="6" multiple style="width: 200px" id="selectNewProducts">
                <option>Välj ett varumärke</option>
            </select>
        </div>
        <div>
            <form id="shopFormNewProducts">
                <table id="shopTableNewProducts" class="listtable shopTableNewProducts">
                    <thead>
                    <tr>
                        <th>Leverantör</th>
                        <th>Produkt</th>
                        <th>Kategori</th>
                        <th>Pris</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>Spendrups</td>
                        <td>Mineralvatten</td>
                        <td>Läsk</td>
                        <td>9.98</td>
                        <td><i class="fa fa-times shopRemoveRow"></i></td>
                    </tr>
                    </tbody>
                </table>
                <button type="submit">Spara</button>
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
</div>
<script>
    $( document ).ready(function() {
        shopStart('${username}');
    });
</script>
