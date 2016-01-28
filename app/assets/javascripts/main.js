function generate_user_view(pack) {
	return  '<div class="member_desc">'+
		'<img src="http://www.paper-glasses.com/api/twipi/'+pack.tw_id+'/normal" class="imagec" width="46" height="46">'+
	'<span class="member_name">'+pack.u_id+'</span><br>'+
		'<span class="member_tw_link">@'+pack.tw_id+'</span>'+
		'<div style="clear:both;"></div>'+
		'</div>';
}
function main() {
	$.ajax({
		method : "GET",
		// URLにIDをくっつける
		url : location.href + ".json", // url : "http://localhost:9998/main_test/:id" みたいな
		success : function(payload, status_code) {
			s = "";
			var res = (typeof payload == "string" ? JSON.parse(payload) : payload);
			// var res = payload;
			if(res.response == "ok" && res.type == "main") {
				$("span#beacon_uuid").text(res.data.beacon.uuid);
				$("span#beacon_loc").text(res.data.beacon.name);
				$("div.main_content_txt_lcd").text(res.joined_size);
				res.data.joined_user.forEach(function(x,i) {
					s += generate_user_view({ tw_id : x.twitter.slice(1, x.twitter.length), u_id : x.personName }); 
				});
			}
			$("div#member_main").html(s);
		}
	});
}

$(document).ready(function() {
	// var lat = 35.004212;
	// var lon = 135.869105;
	// var google_map = $("<iframe></iframe>", {
	// 	src : "https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d15077988.692759968!2d146.8615125!3d22.685474840143335!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sja!2sjp!4v1453374481981",
	// 	width: "2000",
	// 	height : "1000",
	// 	frameborder: "0",
	// }).css({
	// 	"z-index":-1,
	// 	"position": "absolute",
	// 	"margin-top":"20px"
	// });
	// $("body").prepend(google_map);

	var s = "";
	main();
	setInterval(main, 3000);
});