<script>
	window.location.hash = "p=" + "${pageUid}";
</script>
<h2>
	Mina kassar
</h2>

<fieldset class="allGrocerybags">
	<legend>Kassar</legend>
	<table id="allGroceryListTable" class="listtable">
        <thead>
		<tr>
			<th>
				Datum
			</th>
			<th>
				Beskrivning
			</th>
			<th>
				Antal varor
			</th>
		    <th>
				&nbsp;
			</th>
		    <th>
				&nbsp;
			</th>
		</tr>
        </thead>
        <tbody>
		<tr>
			<td>
				2014-01-22 09:45
			</td>
			<td>
				Veckohandling
			</td>
			<td>
				7
			</td>
			<td>
				<a href="#"><img src="http://i.imgur.com/vwJIAvn.png" width="20"></a>
			</td>
		</tr>
        </tbody>
	</table>
    <form id="newGroceryForm" style="display: none">
        <input type="text" name="name" placeholder = "Skriv in namnet på din nya matkasse." >
        <button id="toggleCatBtn">Spara</button>
    </form>
    <button id="newGroceryBtn">Ny Matkasse</button><br>

</fieldset>
<script>

    $( document ).ready(function() {
        bindGroceryListMain();
        showMyGroceryLists("${username}");

    });
</script>
