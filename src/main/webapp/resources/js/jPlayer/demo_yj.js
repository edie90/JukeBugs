$(document).ready(function(){
	
	var storage  = window.localStorage,
/*    	playlist = storage.getItem('playlist') || [],
    	setting  = storage.getItem('setting') || {},*/
    	bundle   = false;
	    
  var player = new jPlayerPlaylist({
    jPlayer: "#jplayer_N",
    cssSelectorAncestor: "#jp_container_N"
  }, playlist,
  {
    playlistOptions: {
      enableRemoveControls: true,
    },
    swfPath: "js/jPlayer",
    supplied: "webmv, webma, ogv, oga, m4v, m4a, mp3",
    smoothPlayBar: true,
    keyEnabled: true,
    audioFullScreen: false,
    volume: 0.2
   }
  );
  
  //Jplayer ready-Event
  $('#jplayer').bind($.jPlayer.event.ready, function() {
      if( playlist.length && setting.currentIndex > -1 ){
          player.select(setting.currentIndex);
          $(this).jPlayer("playHead", setting.percent);
          setting.play && $(this).jPlayer("play", setting.currentTime);
          setting.volume && $(this).jPlayer( "volume", setting.volume );
          setting.shuffle && player.shuffle(true);
          updateDisplay();
      }
      setupListener();
    });
  
//setup Listener
  function setupListener(){
    $('#jplayer').bind($.jPlayer.event.timeupdate, function(event){
      setting.currentTime = event.jPlayer.status.currentTime;
      setting.duration = event.jPlayer.status.duration;
      setting.percent = event.jPlayer.status.currentPercentAbsolute;
      setting.currentIndex = player.current;
      setting.shuffle = player.shuffled;
      updateSetting();
    })
    .bind($.jPlayer.event.pause, function(event){
      setting.play = false;
      updateSetting();
      updateDisplay();
      // $(player.cssSelector.jPlayer).jPlayer("stop");
    })
    // .bind($.jPlayer.event.ended, function(event){
    //   $(player.cssSelector.jPlayer).jPlayer("stop");
    // })
    .bind($.jPlayer.event.play, function(){
      setting.play = true;
      updateSetting();
      updateDisplay();
    })
    .bind($.jPlayer.event.repeat, function(event){
      setting.repeat = event.jPlayer.options.loop;
      updateSetting();
    })
    .bind($.jPlayer.event.volumechange, function(event){
      setting.volume = event.jPlayer.options.volume;
      updateSetting();
    });
    
 // remove item from player gui
    $(document).on('click', '.jp-playlist-item-remove', function(e){
      window.setTimeout(updatePlaylist, 500);
    });
  }

  
/*  $(document).on($.jPlayer.event.pause, myPlaylist.cssSelector.jPlayer,  function(){
    $('.musicbar').removeClass('animate');
    $('.jp-play-me').removeClass('active');
    $('.jp-play-me').parent('li').removeClass('active');
  });

  $(document).on($.jPlayer.event.play, myPlaylist.cssSelector.jPlayer,  function(){
    $('.musicbar').addClass('animate');
  });
  */
  //play button click
	 $('.icon-control-play-origin').on('click',function(){
		 alert("111");
		 var songId = $(this).attr("song-id");
		 alert("222 ==> " + songId);
		 var i = inObj(songId, playlist);
		 if( i == -1){
			 $.ajax({
				 url : "doAjax",
				 method : "get",
				 data : "songId="+songId,
				 dataType : "json",
				 contentType: "application/json;charset=utf-8",
				 success : function(obj) {
					 alert("333");
					 alert(typeof obj);
					if(obj == null) {
						alert("444");
						/*player.add(obj[0], true);
						updatePlayList();*/
					}else {
						alert("555");
						alert(obj.songtitle);
						alert("666");
						player.add({
							  title: String(obj.songtitle),
							  artist: String(obj.artist),
							  mp3: String(obj.source),
						},true);
						alert("777");
						updatePlaylist();
						/*player.setPlaylist(obj);
		                player.play(0);
						updatePlaylist();*/
						/*player.setPlayList(obj);
						player.play(0);
						updatePlayList();*/
						//alert("hhh");
					}
				  },
				 error :function(request,status,error){
				        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			       }
				 });
		 }else {
			 if(player.current == i) {
				 setting.play ? player.pause() : player.play();
			 }else {
				 player.play(i);
			 }
		 }
	 });
	 
	 $('#playFormSong').on('click', function() {
		 alert("aaa");
		 var arr = new Array();
		if($('input:checkbox[name="input_check"]').is(":checked")) {
			alert("체크박스 갯수 : "+$('.input_check:checked').length);
			$('.input_check:checked').each(function() {
				arr.push($(this).val());
			})
			for (var i = 0; i < $('.input_check:checked').length; i++) {
				alert("체크박스 값 : " + arr[i]);
			}
			
			//var param = {songids : arr};
			
			jQuery.ajaxSettings.traditional = true;
			
			
			alert("아작스 가기전");
			$.ajax({
				 url : "songList"
				,method : "get"
				,data : {songids : arr}
				,dataType : "json"
				,contentType: "application/json;charset=utf-8"
				,success : function(obj) {
					console.log("성공");
					alert(JSON.stringify(obj));
					/*var data = obj.songIdsList;*/
					/*alert(typeof data);*/
					var data = new Array();
					//data.push({"title":"222","artist":"333","mp3":"resources/js/jPlayer/33.mp3"});
					//player.setPlaylist(data);
					$.each(obj, function(index, item) {
						alert("aa");
						data.push({"title":item.songtitle, "artist":item.artist, "mp3":item.source});
						/*player.setPlaylist([{
							title : String(item.songtitle),
							artist : String(item.artist),
							mp3 : String(item.source)
						}]);*/
						alert(item.songtitle + " :: " + item.artist);
						alert("셋플레이어리스트");
					})
					player.setPlaylist(data);
					/*alert(String(data));
					player.setPlaylist(data);*/
					//player.play(0);
	                updatePlaylist();
				}
				,error : function(request,status,error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			
			})
			
		}else {
			alert("체크박스를 체크해주세요!");
			return;
		}
	});
	 
		 
  /*$(document).on('click','#play-me',function(e){
	  alert('aaa');
  })*/
  /*function playSong() {
	  alert("aaa");
	var songId = $(this).attr("song-id");
	alert(songId);
}*/
  
  // bind click on play-me element.
  /*$(document).on('click', '.jp-play-me', function(e){
    e.preventDefault();
    $(this).attr()
    var $this = $(e.target);
    if (!$this.is('a')) $this = $this.closest('a');

    $('.jp-play-me').not($this).removeClass('active');
    $('.jp-play-me').parent('li').not($this.parent('li')).removeClass('active');

    $this.toggleClass('active');
    $this.parent('li').toggleClass('active');
    if( !$this.hasClass('active') ){
      myPlaylist.pause();
    }else{
      var i = Math.floor(Math.random() * (1 + 7 - 1));
      myPlaylist.play(i);
    }
    
  });*/
	 
	 //update ui
	 function updateDisplay() {
		 alert(this);
		 if( playlist[player.current] ){
			 alert("888");
			var current = $('i[song-id='+playlist[player.current]['id']+']'+', '+'i[song-id='+playlist[player.current]['ids']+']');
			alert("현재 이름: " + current);
	     }
		 alert("999");
	}
	 
	 //update setting
	 function updateSetting() {
		 storage.setItem('setting',setting);
	}
	 
	 
	 //update playlist
	 function updatePlaylist() {
		 alert("aaa");
		updateDisplay();
		alert("bbb");
		playlist = player.playlist;
		alert("ccc");
		storage.setItem('playlist',playlist);
	}
	 
	 // check exist
	 function inObj(id, list) {
	        var i;
	        for (i = 0; i < list.length; i++) {
	            if ( (list[i]['id'] == id) || (list[i]['ids'] == id) ) {
	                return i;
	            }
	        }
	        return -1;
	 }


  // video

/*  $("#jplayer_1").jPlayer({
    ready: function () {
      $(this).jPlayer("setMedia", {
        title: "Big Buck Bunny",
        m4v: "http://flatfull.com/themes/assets/video/big_buck_bunny_trailer.m4v",
        ogv: "http://flatfull.com/themes/assets/video/big_buck_bunny_trailer.ogv",
        webmv: "http://flatfull.com/themes/assets/video/big_buck_bunny_trailer.webm",
        poster: "images/m41.jpg"
      });
    },
    swfPath: "js",
    supplied: "webmv, ogv, m4v",
    size: {
      width: "100%",
      height: "auto",
      cssClass: "jp-video-360p"
    },
    globalVolume: true,
    smoothPlayBar: true,
    keyEnabled: true
  });
*/
});
