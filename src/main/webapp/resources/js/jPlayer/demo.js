var accessauthorityCheck = false;
var userId = null;
var storage  = window.localStorage,
bundle = false;
var userPlayList = "";
var userSetting= "";
var playlist = [];
var setting = {};
var player = null;
var logs_EndedSongCount = 0;
$.ajax({
    url : "accessauthorityCheck",
    method : "post",
    dataType : "json",
    contentType: "application/json;charset=utf-8",
    success : function(obj) {
        	accessauthorityCheck = obj.authorityCheck;
        	userId = obj.loginId;
        	
        	userPlayList = userId +"playList";
        	userSetting = userId +"setting";
        	
        	var getPlaylist_ByStorage = storage.getItem(userPlayList);
        	//alert(getPlaylist_ByStorage + "||" + userPlayList)
        	if(getPlaylist_ByStorage!=null){
        		playlist = JSON.parse(getPlaylist_ByStorage);
        	}else if(getPlaylist_ByStorage==null){
        		//alert(getPlaylist_ByStorage)
        		if(userPlayList!="GuestplayList"){
        			var guestPlayList = storage.getItem("GuestplayList");
        			if(guestPlayList!=null){
        				playlist = JSON.parse(guestPlayList);
        				storage.setItem("GuestplayList",null);
        			}
        		}
        	}
        	var getSetting_ByStorage = storage.getItem(userSetting);
        	//alert(getSetting_ByStorage);
        	if(getSetting_ByStorage!=null){
        		setting = JSON.parse(getSetting_ByStorage);
        	}else if(getSetting_ByStorage==null){
        		if(userSetting!="Guestsetting"){
        			guestSetting = storage.getItem("Guestsetting");
        			if(guestSetting!=null){
        				setting = JSON.parse(guestSetting);
        				storage.setItem("Guestsetting",null);
        			}
        		}
        	}
        	
        	if(playlist==null){
        		player = playerSetting([], {});
        		playlist = [];
        		setting = {};
        	}else{
        		player = playerSetting(playlist, setting);
        		if(playlist!=null && setting !=null){
        			updateSetting();
        			updatePlaylist();
        		}
        	}
        		
    	}
    });


$(document).ready(setReady);

function setReady(){
	
  //play button click
    $('.icon-control-play-origin').on('click',function(){
       var songId = $(this).attr("song-id");
       var i = inObj(songId, playlist);
       if( i == -1){
          $.ajax({
             url : "doAjax",
             method : "get",
             data : "songId="+songId,
             dataType : "json",
             contentType: "application/json;charset=utf-8",
             success : function(obj) {
               if(obj == null) {
               }else {
                  player.add({
                       title: String(obj.songtitle),
                       artist: String(obj.artist),
                       mp3: String(obj.source),
                       ImgUrl:String(obj.albumimgurl),
	           		   songid:String(obj.songid),
                  },true);
                  updatePlaylist();
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
       var arr = new Array();
      if($('input:checkbox[name="input_check"]').is(":checked")) {
         alert("체크박스 갯수 : "+$('.input_check:checked').length);
         $('.input_check:checked').each(function() {
            arr.push($(this).val());
         })
         for (var i = 0; i < $('.input_check:checked').length; i++) {
            alert("체크박스 값 : " + arr[i]);
         }
         
         jQuery.ajaxSettings.traditional = true;
         
         $.ajax({
             url : "songList"
            ,method : "get"
            ,data : {songids : arr}
            ,dataType : "json"
            ,contentType: "application/json;charset=utf-8"
            ,success : function(obj) {
            	if(obj == null) {
                }else {
                	var check = false;
                	if(player.playlist.length==0){
                		check = true;
                	}
                	for(var cnt in obj){
                		player.add({
                			title: String(obj[cnt].songtitle),
                			artist: String(obj[cnt].artist),
                			mp3: String(obj[cnt].source),
                			ImgUrl:String(obj[cnt].albumimgurl),
                			songid:String(obj[cnt].songid),
                		},check);
                	}
                	updatePlaylist();
                	setTimeout(function () {
                 	   var getplayList = player.playlist;
                 	   showListenPlayList();
 					
                    },1000)
                		
                }
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
    
    
    setEventAll();
    
    Event_Listen_addALBList();
    
    
    /**
     * 체크박스로 재생목록 접근.
     * 
     */
    function Event_Listen_addALBList() {
    	$('#overDiv').off('click')
    	$('#overDiv').on('click',function(){
    		var check = false;
    		if(player.playlist.length==0){
        		check = true;
        	}
    		$(":checkbox[name='listen_LikeCheckBox_toPlayCheck']:checked").each(function(){
        		player.add({
        			title: $(this).attr("title"),
        			artist: $(this).attr("artist"),
        			mp3: $(this).attr("mp3"),
        			ImgUrl:$(this).attr("ImgUrl"),
        			songid:$(this).attr("songid"),
        		},check);
    		})
    		updatePlaylist();
    		showListenPlayList();
    	})
    
    }

}

function playerSetting(playlist, setting) {
	
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
	    $('#jplayer_N').bind($.jPlayer.event.ready, function() {
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
	      $('#jplayer_N').bind($.jPlayer.event.timeupdate, function(event){
	    	  if(accessauthorityCheck){
	    		  setting.currentTime = event.jPlayer.status.currentTime;
	    		  setting.duration = event.jPlayer.status.duration;
	    		  setting.percent = event.jPlayer.status.currentPercentAbsolute;
	    		  setting.currentIndex = player.current;
	    		  setting.shuffle = player.shuffled;
	    		  if(event.jPlayer.status.currentTime>60){
	    			  if(player.current==(player.playlist.length-1)){
	    				  $(this).jPlayer('stop');
	    			  }
	    			  else{
	    				  player.next();
	    			  }
	    		  }
	    	  }else{
	    		  setting.currentTime = event.jPlayer.status.currentTime;
	    		  setting.duration = event.jPlayer.status.duration;
	    		  setting.percent = event.jPlayer.status.currentPercentAbsolute;
	    		  setting.currentIndex = player.current;
	    		  setting.shuffle = player.shuffled;
	    	  }
	    	  updateSetting();
	      })
	      .bind($.jPlayer.event.pause, function(event){
	        setting.play = false;
	        updateSetting();
	        updateDisplay();
	      })
	      .bind($.jPlayer.event.play, function(){
	        setting.play = true;
	        updateSetting();
	        updateDisplay();
	        var count = setting.currentIndex; 
	        logs_EndedSongCount = count; 
			changeNowOnPlayDiv(count);
	      })
	      .bind($.jPlayer.event.ended, function(){
	        updateSetting();
	        updateDisplay();
	        endedInsertLog();
	        if(logs_EndedSongCount<playlist.length-1){
	        	endedCheckFunction();
	        }
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
	        window.setTimeout(showListenPlayList, 500);
	      });
	    }
	    
	    player.shuffleOnFunc(showListenPlayList());
	    player.shuffleOffFunc(showListenPlayList());
	    
	    return player;
	
}
/**
 * 기존 메서드.
 */

 
//update ui
function updateDisplay() {
   if( playlist[player.current] ){
     var current = $('i[song-id='+playlist[player.current]['id']+']'+', '+'i[song-id='+playlist[player.current]['ids']+']');
    }
}

//update playlist
function updatePlaylist() {
  updateDisplay();
  playlist = player.playlist;
  storage.setItem(userPlayList,JSON.stringify(playlist));
}

// 	update setting 
function updateSetting(){
	storage.setItem(userSetting,JSON.stringify(setting));
}

function endedInsertLog(){
	var nowPlay = player.playlist[logs_EndedSongCount].songid;
	$.ajax({
        url : "putLog",
        method : "post",
        data : nowPlay,
        contentType: "application/json;charset=utf-8",
        success : function() {}
        });
}

function endedCheckFunction(){
	var RelLog ={};
	var nowPlay = player.playlist[logs_EndedSongCount].songid;
	var nextPlay = player.playlist[player.getPlayCount].songid;
	
	RelLog.nowPlay = nowPlay;
	RelLog.nextPlay = nextPlay;
	RelLog = JSON.stringify(RelLog);
	
	$.ajax({
        url : "listenEndedSong",
        method : "post",
        data : RelLog,
        dataType : "json",
        contentType: "application/json;charset=utf-8",
        success : function(obj) {}
        });
}

function changeNowOnPlayDiv(count) {
	var nowOnPlay = $(".now_OnPlay");
	var getplayList = player.playlist;
	var htmlStr = 
		'<div class="top text-right">'+
		'<h2 style="margin-left:10px" class="pull-left">Now On Play</h2>'+
	    '<span class="musicbar animate bg-success bg-empty inline m-r-lg m-t" style="width:25px;height:30px">'+
	    '<span class="bar1 a3 lter"></span><span class="bar2 a5 lt"></span>'+
	    '<span class="bar3 a1 bg"></span><span class="bar4 a4 dk"></span>'+
	    '<span class="bar5 a2 dker"></span></span></div>'+
   
	    '<div class="bottom gd bg-info wrapper-lg">'+
	    	'<span class="h4 font-thin pull-right ">'+
	    	getplayList[count].title+'<br></span>'+
	    	'<span class="h2 font-thin"> Artist : '+
	    	getplayList[count].artist+'</span>'+
	    '</div>'+
	    '<img class="img-full" src="'+getplayList[count].ImgUrl+'" ' + 
	    'onerror="this.src='+"'"+'resources/images/defaultAlbumImg.jpg'+"'"+'">';
	nowOnPlay.html(htmlStr);
}


//Footer의 PlayList를 가지고 오는 메서드
function showListenPlayList() {
	setTimeout(function(){
		var getplayList;
		getplayList = player.playlist;
		var listen_PlayList = $("#listen_PlayList");
    	if(listen_PlayList==null){
    		return;
    	}
    	else if(getplayList.length==0){
    		return;
    	}
    	var count = player.getPlayCount;
    	var htmlStr ='';
    	htmlStr +=	
    	'<div class="now_OnPlay m-t-n-xxs item pos-rlt">'+
        '<div class="top text-right">'+
        '<h2 style="margin-left:10px" class="pull-left">Now On Play</h2>'+
        '<span class="musicbar animate bg-success bg-empty inline m-r-lg m-t" style="width:25px;height:30px">'+
            '<span class="bar1 a3 lter"></span><span class="bar2 a5 lt"></span>'+
            '<span class="bar3 a1 bg"></span><span class="bar4 a4 dk"></span>'+
            '<span class="bar5 a2 dker"></span></span></div>'+
           
        '<div class="bottom gd bg-info wrapper-lg">'+
          '<span class="h4 font-thin pull-right ">'+getplayList[count].title+'<br></span>'+
          '<span class="h2 font-thin"> Artist : '+getplayList[count].artist+'</span>'+
        '</div>'+
        '<img class="img-full" src="'+getplayList[count].ImgUrl+'"' + 'onerror="this.src='+"'"+'resources/images/defaultAlbumImg.jpg'+"'"+'">'+
      '</div>'+
      
      '<ul class="list-group list-group-lg no-radius no-border no-bg m-t-n-xxs m-b-none auto">';
    	for(var song in getplayList){
    		htmlStr+= 
    		'<li class="list-group-item">'+
	          '<div class="pull-right m-l">'+
	          //Listen Page에서의 삭제 버튼
	            '<a href="#"><i class="icon-close listen_Remove" playCount='+song+'></i></a>'+
	          '</div>'+
	          //Listen Page에서의 재생 버튼
	          '<a href="#" class="jp-play-me m-r-sm pull-left listen_List_Play" playCount='+song+'>'+
	            '<i class="icon-control-play text"></i>'+
	            '<i class="icon-control-pause text-active"></i>'+
	          '</a>'+
	          '<div class="clear text-ellipsis hv_Songs" songId = "'+
	          getplayList[song].songid+'" >'+
	            '<span>'+getplayList[song].title+'</span>'+
	          '</div>'+
	        '</li>';
    		
    	} 
    	htmlStr += '</ul>';
    	
    	listen_PlayList.html(htmlStr);
    	player._refresh(!0);
    	addEvent();
	},500)
	
}


function addEvent() {
	addPlayEvent();
	addDeleteEvent();
}



//Listen 페이지 재생 이벤트

function addPlayEvent() {
	$('.listen_List_Play').off('click');
	$('.listen_List_Play').on('click',function(){
		var playcount = $(this).attr("playCount");
		var footerPlayId = $("#footerListPlay_"+playcount);
		footerPlayId.trigger('click'); 
	});
}
//Listen 페이지 삭제 이벤트
function addDeleteEvent(){
	$('.listen_Remove').off('click');
	$('.listen_Remove').on('click',function(){
		var playcount = $(this).attr("playCount");
		
		var footerRemoveId = $("#footerListRemove_"+playcount);
		footerRemoveId.trigger('click'); 
		
		updatePlaylist();
		showListenPlayList();
		
	 });
}


/*
 * MakeAlbumList의 곡 추가

 */
function Event_listenAddMKALBList() {
	$('.listenAddMKALBList').off('click');
	$('.listenAddMKALBList').on('click',function(){
        var mkAlbumId = $(this).attr("mkAlbumId");
        var i = inObj(mkAlbumId, playlist);
        if( i == -1){
           $.ajax({
              url : "getMakeAlbumSongs",
              method : "post",
              data : mkAlbumId,
              dataType : "json",
              contentType: "application/json;charset=utf-8",
              success : function(obj) {
                if(obj == null) {
                }else {
                	var check = false;
                	if(player.playlist.length==0){
                		check = true;
                	}
                	for(var cnt in obj){
                		player.add({
                			title: String(obj[cnt].songtitle),
                			artist: String(obj[cnt].artist),
                			mp3: String(obj[cnt].source),
                			ImgUrl:String(obj[cnt].albumimgurl),
                			songid:String(obj[cnt].songid),
                		},check);
                	}
                	updatePlaylist();
                	setTimeout(function () {
                 	   var getplayList = player.playlist;
                 	   showListenPlayList();
 					
                    },1000)
                		
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
              player.play(playlist.length-1);
           }
        }
        updatePlaylist();
        setTimeout(function () {
     	   var getplayList = player.playlist;
     	   showListenPlayList();
			
        },1000)
     });
}


/*
 * MakeAlbumList의 곡 재생 
 */
function Event_listenPlayMKALBList(){
	$('.listenPlayMKALBList').off('click')
	$('.listenPlayMKALBList').on('click',function(){
        var mkAlbumId = $(this).attr("mkAlbumId");
        var i = inObj(mkAlbumId, playlist);
        if( i == -1){
           $.ajax({
              url : "getMakeAlbumSongs",
              method : "post",
              data : mkAlbumId,
              dataType : "json",
              contentType: "application/json;charset=utf-8",
              success : function(obj) {
                if(obj == null) {
                }else {
                	var data = new Array();
                	$.each(obj, function(index, item) {
                		data.push(
                				{
                					"title":item.songtitle, 
	                				"artist":item.artist, 
	                				"mp3":item.source,
	                				"ImgUrl":item.albumimgurl,
	                				"songid":item.songid
                				});
                	})
                    player.setPlaylist(data);
                	updatePlaylist();
                	player.play(0);
                	setTimeout(function () {
                  	   var getplayList = player.playlist;
                  	   showListenPlayList();
  					
                     },1000)
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
              player.play(playlist.length-1);
           }
        }
     });
}

/**
 * Listen의 LikeMusic 추가 부분
 * 
 * and 곡 1개 추가. 
 */
function Evnet_LikeMusicPlus() {
	$('.likeMusicPlus').off('click')
	$('.likeMusicPlus').on('click',function(){
        var songId = $(this).attr("songid");
        var i = inObj(songId, playlist);
        if( i == -1){
           $.ajax({
              url : "listenAddLMSelectOne",
              method : "post",
              data : songId,
              dataType : "json",
              contentType: "application/json;charset=utf-8",
              success : function(obj) {
                if(obj == null) {
                }else {
                	var check = false;
                	if(player.playlist.length==0){
                		check = true;
                	}
                   player.add({
                	   	title: String(obj.songtitle),
	           			artist: String(obj.artist),
	           			mp3: String(obj.source),
	           			ImgUrl:String(obj.albumimgurl),
	           			songid:String(obj.songid),
                        
                   },check);
                   updatePlaylist();
                   showListenPlayList();
					
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
              player.play(playlist.length-1);
           }
        }
        //updatePlaylist();
        setTimeout(function () {
     	   var getplayList = player.playlist;
     	   showListenPlayList();
			
        },1000)
     });
}

/*
 * Album의 곡 추가
 */
function Event_addALBList() { 
	$('.addALBList').off('click')
	$('.addALBList').on('click',function(){
        var albumId = $(this).attr("albumId");
        var i = inObj(albumId, playlist);
        if( i == -1){
           $.ajax({
              url : "getAlbumSongs",
              method : "post",
              data : albumId,
              dataType : "json",
              contentType: "application/json;charset=utf-8",
              success : function(obj) {
                if(obj == null) {
                }else {
                	var check = false;
                	if(player.playlist.length==0){
                		check = true;
                	}
                	for(var cnt in obj){
                		player.add({
                			title: String(obj[cnt].songtitle),
                			artist: String(obj[cnt].artist),
                			mp3: String(obj[cnt].source),
                			ImgUrl:String(obj[cnt].albumimgurl),
                			songid:String(obj[cnt].songid),
                		},check);
                	}
                	updatePlaylist();
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
              player.play(playlist.length-1);
           }
        }
        updatePlaylist();
        showListenPlayList();
     });
}

//check exist
function inObj(id, list) {
       var i;
       for (i = 0; i < list.length; i++) {
           if ( (list[i]['id'] == id) || (list[i]['ids'] == id) ) {
               return i;
           }
       }
       return -1;
}


function setEventAll() {
	Event_addALBList();
	Event_listenAddMKALBList();
	Event_listenPlayMKALBList();
	Evnet_LikeMusicPlus();
}