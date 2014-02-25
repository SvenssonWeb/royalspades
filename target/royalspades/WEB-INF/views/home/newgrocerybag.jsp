<script>
	window.location.hash = "p=" + "${pageUid}";
</script>
<h2>
Ny matkasse
</h2>
<br />
<table>
	<tr>
		<td>
			<label for="name">Namn:</label>
		</td>
		<td>
			<input name="name" type="text" />
		</td>
	</tr>
	<tr>
		<td>
			<label for="date">Skapad:</label>
		</td>
		<td>
			<input name="date" type="text" />
		</td>
	</tr>
</table>
<br />

<table id="dataTable" class="groceryTable listtable">
	<thead>
		<tr>
			<th>
				Varunamn
			</th>
			<th>
				Mängd
			</th>
			<th>
				Mått
			</th>
			<th>
				Leverantör
			</th>
			<!--<th>
				Leverantör Org.nr
			</th>
			<th>
				Leverantör address
			</th>
			<th>
				Leverantör telefonnummer
			</th>-->
			<th>
				Kategori
			</th>
			<th>
				Lägg till
			</th>
		</tr>	
	</thead>
</table>
<input type="submit" value="Lägg till">

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
		//url: "http://172.16.6.175:8080/royalspades/api/product/all/",
		url: "/royalspades/api/product/all/",
		dataType: "text",
		success: function (data, textStatus, jqXHR) {
		var arr = JSON.parse(data);
		
		$(".groceryTable").append("<tbody>");
		for(var i = 0; i < arr.length; i++){
			var row = "<tr><td>";
			row += arr[i].name;
			row += '</td><td style="text-align:right;">';
			row += arr[i].volume;
			row += "</td><td>";
			row += arr[i].unit;
			row += "</td><td>";
			
			if($.isNumeric(arr[i].brand)){
				for(var j = 0; j < arr.length; j++){
					if(arr[j].brand['@id'] == arr[i].brand){
						arr[i].brand = arr[j].brand;
						row += arr[i].brand.name;
					}
				}
			} else {
				row += arr[i].brand.name;
			}
			row += "</td><td>";
			/*row += arr[i].company.orgNumber;
			row += "</td><td>";
			row += arr[i].company.address;
			row += "</td><td>";
			row += arr[i].company.phone;
			row += "</td><td>";*/
			if($.isNumeric(arr[i].category)){
				for(var j = 0; j < arr.length; j++){
					if(arr[j].category['@id'] == arr[i].category){
						arr[i].category = arr[j].category;
						row += arr[i].category.name;
					}
				}
			} else {
				row += arr[i].category.name;
			}
			row += '</td><td style="text-align:center;">';
			row += '<input type="checkbox">';
			row += "</td></tr>";
			$(".groceryTable").append(row);
		}
		
		$(".groceryTable").append("</tbody>");
		
		$('.groceryTable').dataTable({
		"aLengthMenu": [
            [25, 50, 100, -1],
            [25, 50, 100, "All"]],
		"iDisplayLength" : -1,
        "bScrollInfinite": true,
        "bScrollCollapse": false,
        "sScrollY": "300px",
		"oLanguage": {
			"sLengthMenu": "Visar _MENU_ produkter per sida",
			"sZeroRecords": "Hittade inget - tyvärr",
			"sInfo": "Visar _START_ till _END_ av _TOTAL_ varor",
			"sInfoEmpty": "Visar 0 av 0 varor",
			"sInfoFiltered": "(filtrerat från _MAX_ varor)",
			"sSearch": "Filtrera: "
		}		
		});
		},
		error: function (data, textStatus, jqXHR) {
			alert("Error: " + textStatus + ", " + jqXHR);
		}
	});
});
</script>