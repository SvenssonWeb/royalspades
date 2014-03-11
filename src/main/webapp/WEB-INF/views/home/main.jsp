<script>
	window.location.hash = "p=" + "${pageUid}";
</script>
<h2>
	Mina kassar
</h2>

<p>
<a href="${pageContext.request.contextPath}/home/newgrocerybag" class="link">Ny matkasse</a>
</p>

<fieldset class="allGrocerybags">
	<legend>Kassar</legend>
	<table id="allGroceryListTable" class="listtable">
        <thead>
		<tr>
			<th>
				Datum &darr;
			</th>
			<th>
				Beskrivning &darr;
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
</fieldset>
<script>
    $( document ).ready(function() {

        homeStart("${username}");

    });
</script>
