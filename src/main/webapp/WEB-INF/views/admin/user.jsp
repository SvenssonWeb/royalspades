﻿<script>
	window.location.hash = "p=" + '${pageUid}';
</script>
<h2> 
	Användare
</h2>
<br />
<table id="dataTable" class="userTable listtable">
	<thead>
		<tr>
			<th>
				Användarnamn
			</th>
			<th>
				Behörighet
			</th>
			<th>
				Email
			</th>
			<th>
				Förnamn
			</th>
			<th>
				Efternamn
			</th>
			<th>
				Begärd behörighet
			</th>
			<th>
				
			</th>
		</tr>	
	</thead>
</table>
<br />
<div class="error"></div>

<script>

var oTable;

function getData(url){
	$.ajax({
		type: "GET",
		url: url,
		headers: {
			'Accept':"application/json",
			'Content-Type':"application/json"
		},
		dataType: "json",
		success: function (data, textStatus, jqXHR) {
			var element = $(".userTable");
            var html = "<tbody>";
			for(var i = 0; i < data.length; i++){
				var row = "<tr id=" + data[i].id + ">" + "<td>";
				row += data[i].username;
				row += '</td><td style="text-align:right;">';
				row += data[i].role;
				row += "</td><td>";
				row += data[i].email;
				row += "</td><td>";
				row += data[i].firstName;
				row += "</td><td>";
				row += data[i].lastName;
				row += "</td><td>";
				row += data[i].requestedAuthority;
				row += '</td><td style="text-align:center;">';
				row += '<a class="link" href="editUser/?id=' + data[i].id + '"><i class="fa fa-pencil black"></i></a>';
				row += '&nbsp;<a class="no_refresh" href="#" onclick="deleteUser(event, ' + data[i].id + ')"><i class="fa fa-times red"></i></a>';
				row += "</td></tr>";
                html += row;
			}
            html += "</tbody>";
            element.append(html);
			
			oTable = $('.userTable').dataTable({
				"aLengthMenu": [
		            [25, 50, 100, -1],
		            [25, 50, 100, "All"]],
				"iDisplayLength" : -1,
		        "bScrollInfinite": true,
		        "bScrollCollapse": false,
		        "sScrollY": "300px",
				"oLanguage": {
					"sLengthMenu": "Visar _MENU_ användare per sida",
					"sZeroRecords": "Hittade inget - tyvärr",
					"sInfo": "Visar _START_ till _END_ av _TOTAL_ användare",
					"sInfoEmpty": "Visar 0 av 0 användare",
					"sInfoFiltered": "(filtrerat från _MAX_ användare)",
					"sSearch": "Filtrera: "
				}		
			});
		},
		error: function (data, textStatus, jqXHR) {
			alert("Error: " + textStatus + ", " + jqXHR);
		}
	});
}


// delete user
function deleteUser(event, id){
	$('.error').text("");
	
	if (confirm('Är du säker på att du vill ta bort denna användare?')) {
   
		$.ajax({
			url:baseUrl + '/api/admin/remove_user/' + id,
			type:'DELETE',
  		  	contentType:'application/json',
		  	accept:'application/json',
		  	processData:false,
			complete: function(response) {
	    		
	    		if(response.status == 200){
	    			// user was removed
		    		// remove from table
	    			var pos = oTable.fnGetPosition( $('#' + id)[0]);
	    	        oTable.fnDeleteRow(pos);
	    			$('#' + id).remove();
	    		} else {
	    			// can't remove that user
	    			$('.error').text(response.responseText);
	    		}
	    		
			},
			error: function (response, data, textStatus, jqXHR) {
				if(response.status != 200){
					$('.error').text("Error: " + textStatus + ", " + jqXHR);
				}
			}
	    });
    }
	return false;
}	


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
	
	getData(baseUrl + "/api/admin/user/all/");
    
});
</script>