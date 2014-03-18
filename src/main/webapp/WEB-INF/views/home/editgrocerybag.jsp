<script>
	window.location.hash = "p=" + "${pageUid}";
</script>
<div id="newGroceryListView">
    <h2>Redigera matkasse</h2>
    <br />
    <table>
        <tr>
            <td>
                <label for="groceryName">Namn:</label>
            </td>
            <td>
                <input id="groceryName"  name="name" type="text" />
                <input id="groceryListId"  name="listId" type="hidden" />
            </td>
        </tr>
        <tr>
            <td>
                <label for="groceryDate">Skapad:</label>
            </td>
            <td>
                <input id="groceryDate" name="date" type="text" />
            </td>
        </tr>
    </table>
    <br />
    <div class="groceryListTableContainer">
        <div class="groceryListAddedProducts">
            <table id="groceryListAddedProducts" class="groceryTable listtable">
                <thead>
                <tr>
                    <th></th>
                    <th>Varunamn</th>
                    <th>Mängd</th>
                    <th>Mått</th>
                    <th>Leverantör</th>
                    <th>Kategori</th>
                    <th>Antal</th>
                    <th></th>
                </tr>
                </thead>
            </table>
        </div>
        <div class="groceryListAllProducts">
            <table id="groceryListAllProducts" class="groceryTable listtable">
                <thead>
                <tr>
                    <th></th>
                    <th>Varunamn</th>
                    <th>Mängd</th>
                    <th>Mått</th>
                    <th>Leverantör</th>
                    <th>Kategori</th>
                    <th>Antal</th>
                    <th></th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
    <input type="submit" id="save" value="Spara matkasse">
    <br />
    <br />
    <div class="error"></div>
    <div class="response"></div>
</div>
<script>
$( document ).ready(function() {
    showProductsTables("${username}");
});
</script>
