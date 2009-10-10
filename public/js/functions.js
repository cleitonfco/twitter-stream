$(document).ready( function() {
	$.ajax({
	  cache: false
	});
	

	var complete;
    $(document).everyTime(30000, function() {
        complete = (ultimoid > 0) ? ultimoid : 0;

		$.getJSON("/"+ key +"/recents/" + complete, function(data) {
			if (data.length > 0) {
				ultimoid = data[data.length-1].id;
			}
			$.each(data, function(i,item) {
				var content = "<li id=\""+ item.id + "\" class=\"twitter" + mention + "\">";
				content = content + '<a href="http://twitter.com/'+item.from_user+'">';
				content = content + '<img src="'+ item.profile_image_url + '" class="photo" title="'+item.from_user+'" />';
				content = content + '</a>';
				content = content + '<img src="/img/arr3.gif" class="arr"/>';
				content = content + '<p id="message-'+item.id+'" class="status">';
				content = content + '<a href="http://twitter.com/'+item.from_user+'" class="from_user">@'+item.from_user+':</a> ' + item.text;
				content = content + '</p>';
				content = content + '<p class="info">enviado em <a href="http://twitter.com/'+item.from_user+'/status/'+item.id+'" class="date">'+item.created_at+'</a> ';
				content = content + '<span class="client">- via '+item.source+'</p>';
				content = content + "</li>";
				$("#content .listing ul").prepend(content);
				$("#content .listing ul .id-" + item.id).hide().show("slow");
			});
		});
		complete = "";
		var tam = $('#content .listing ul').size();
		return true;
	});

  $(document).everyTime(120000, function() {
		$.getJSON("/"+ key +"/users", function(data) {
			var content = ""
			$.each(data, function(i,item) {
				content = content + "<span class=\"vcard\">"
				content = content + "<a class=\"url\" href=\"http://twitter.com/" + item.user + "\" title=\"" + item.user + "\" rel=\"contact\" >"
				content = content + "<img alt=\"" + item.user + ", T:" + item.posts + "\" class=\"photo fn\" height=\"48\" src=\"" + item.profile_image_url + "\" width=\"48\"/>"
				content = content + " </a></span>"
			});
			$(".users").html(content);
		});
		return true;
	});
});

