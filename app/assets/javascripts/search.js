function generate_result_view(pack) {
  var emb = "location.href='./places/"+pack.id+"';"; // 個別ページに飛ぶ時のリンク
  return '<div class="place_member">' + 
         '<img width="200px" height="130" src="'+pack.pic_url+'" class="plist">' + 
         '<div class="place_title">'+pack.name+'</div> '+
         '<span class="place_gps">緯度'+pack.lat+'<br/>経度'+pack.lon+'</span> '+
         '<div class="member_btnk" onclick="'+emb+'">この場所にいる人達を見る</div> '+
         '</div>' +
        '<div style="clear:both;padding-top:10px;"></div>';
}
function get_and_make_view(input) {
    // if($(input_object).val() == "") {
    //   str = "";
    //   $("div#place_main").html("");
    // } else {
      $.ajax({
        "method" : "GET",
        "url" : "/places/search.json", // 検索エンドポイント
        "data" : "query=" + input,
        success : function(payload, status_code) {
          $("div#place_main").html("");
          str = "";
          console.log(payload);
					var res = payload;
          if(res.response == "ok" && res.type == "search") {
            res.data.forEach(function(data, i) {
              if(i <= (res.size - 1)) {
                str += generate_result_view({
                  pic_url : "/places/"+data.id+"/picture",
                  name : data.placeName,
                  lat : data.latitude,
                  lon : data.longitude,
                  id : data.id
                });
              }
            });
            $("div#place_main").html(str);
          }
        }
      });
    // }
}
$(document).ready(function() {
  var str = "";
	get_and_make_view("");
  $("input#search_box").keyup(function() {
		get_and_make_view($(this).val());
  });
});