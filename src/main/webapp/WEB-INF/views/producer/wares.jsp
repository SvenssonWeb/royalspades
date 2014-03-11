<script>
	window.location.hash = "p=" + "${pageUid}";
</script>
<h2>
	Varor
</h2>
<p>
	Här kan du uppdatera dina varor.
</p>
<fieldset class="allWares brandContainer">
	<legend>Alla varor</legend>
	<table class="listtable brandAllProductsTable">
        <thead>
		<tr>
			<th>
				Namn
			</th>
			<th>
				Kategori
			</th>
			<th>

			</th>
		</tr>
        </thead>
        <tbody>
        </tbody>
	</table>
</fieldset>
<fieldset class="newWare brandContainer">
    <legend>Ny vara</legend>
    <form id="brandAddNewProduct" name="addWare" action="#" method="post">
        <input type="hidden" name="id">
        <table class="formtable">
            <tr>
                <td>
                    <label for="name">Namn: </label>
                </td>
                <td>
                    <input type="text" name="name" id="name">
                </td>
            </tr>
            <tr>
                <td>
                    <label for="volume">Volym: </label>
                </td>
                <td>
                    <input type="text" name="volume" id="volume">
                </td>
            </tr>
            <tr>
                <td>
                    <label for="unit">Enhet: </label>
                </td>
                <td>
                    <input type="text" name="unit" id="unit">
                </td>
            </tr>
            <tr>
                <td>
                    <label for="category">Kategori: </label>
                </td>
                <td>
                    <select id="category" name="category">
                        <option value="mej">Mejeri</option>
                        <option value="fog">Frukt o Grönt</option>
                        <option value="kot">Kött</option>
                        <option value="las">Läskeblask</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="brandSubmit" type="Submit" value="Lägg till">
                </td>
                <td>
                    <input id="clearEdit" type="submit" value="Rensa" style="display: none">
                </td>
            </tr>
        </table>
    </form>
</fieldset>
<script>
    $(document).ready(function(){
        groceryStart('${username}');

    });
</script>