<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html class="app">
<head>  
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Musik | Web Application</title>
  <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <link rel="stylesheet" href="resources/js/jPlayer/jplayer.flat.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/animate.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/font.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/app.css" type="text/css" />  
  <link rel="stylesheet" href="resources/css2/melonweb_search.css" type="text/css" />
  <!-- <link rel="stylesheet" href="resources/css/melonweb_layout.css" type="text/css" /> -->
  <link rel="stylesheet" href="resources/css2/melonweb_comm.css" type="text/css" /> 
  <link rel="stylesheet" href="resources/css2/aydvcar4t1.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/ktwzk0vhtx.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/melonweb_album.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/uoybmjacd1.css" type="text/css" />
  <!-- <link rel="stylesheet" href="resources/css2/modal.css" type="text/css" /> -->
  <!-- <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> -->
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script> -->
  <!-- <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script> -->
  
    <!--[if lt IE 9]>
    <script src="js/ie/html5shiv.js"></script>
    <script src="js/ie/respond.min.js"></script>
    <script src="js/ie/excanvas.js"></script>
  <![endif]-->
    <style type="text/css">
  .btn {
  display: inline-block;
  padding: 6px 12px;
  margin-bottom: 0;
  font-size: 14px;
  font-weight: normal;
  line-height: 1.42857143;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
}
.btn-danger {
  color: #fff;
  background-color: #d9534f;
  border-color: #d43f3a;
}
</style>

  <script type="text/javascript">
	  function goSearch(content) {
		  alert("hhh");
		  alert(content);
		  	  location.href = "search?content=" + content;
	  }
  </script>

  <script src="resources/js/jquery.min.js"></script>
  <script>
  	$(document).ready(function() {
  		var btnAllchk = $("#songListAllChk");//전체선택
		var tblNochk = $(".tb_list table th input:checkbox:enabled:visible"); 
		var tblInpChk = $(".tb_list table td input:checkbox:enabled:visible");
		//전체선택 클릭시
		btnAllchk.click(function(e){
			e.stopPropagation();
			if(btnAllchk.is('.on')){
				btnAllchk.removeClass('on');
				$(".tb_list table tbody tr").removeClass('on');
				tblNochk.each(function(){
					this.checked = false;
				})
				tblInpChk.each(function(){
					this.checked = false;
				})
			}else{
				btnAllchk.addClass('on');
				$(".tb_list table tbody tr").addClass('on');
				tblNochk.each(function(){
					this.checked = 'checked'
				})
				tblInpChk.each(function(){
					this.checked = 'checked'
				})
			}
		})
		
		
		$("body").on('click', '.fa.fa-heart-o', function(){
			var state = $(this).attr('class');
			var songid = $(this).attr('data-songid');
			alert(songid);
				var sendData = {"songId" : songid}
				sendData = JSON.stringify(sendData);
					$.ajax({
					  url : "likeMusic"
					, method : "POST"
					, data : sendData
					, dataType : "json"
					, contentType: "application/json;charset=utf-8"
					, success : function(resp) {
						$('#'+songid).text(resp);	
					}
					
				})
				$(this).attr('class', 'fa fa-heart');
		});
		
		$("body").on('click', '.fa.fa-heart', function(){
			var state = $(this).attr('class');
			var songid = $(this).attr('data-songid');
				var sendData = {"songId" : songid}
				sendData = JSON.stringify(sendData);
					$.ajax({
					url : "deleteLike"
					, method : "POST"
					, data : sendData
					, dataType : "json"
					, contentType: "application/json;charset=utf-8"
					, success : function(resp) {
						$('#'+songid).text(resp);
					}
					
				}) 
			$(this).attr('class', 'fa fa-heart-o');
		});
		var songid;
		 $("#reportModal").on('show.bs.modal', function(event){
			 var atag = $(event.relatedTarget);
 			 songid = atag.data("index");
		 });
		 $("#report").on('click', function(){
	 			var dat = {"songid" : songid,
	 							"reason" : $("#reportReasonSong").val()}
	 			dat = JSON.stringify(dat);
	 			$.ajax({
	 				 url: "reportSong" 
	 				, method: "POST"
	 				, data : dat
	 				, contentType: "application/json; charset=UTF-8"
	 				, success : function(){
	 					window.location.reload();
	 				}
	 			});
	 			$("#reportModal").modal("hide");
	 		 });
		 
	var albumid;
	 $("#reportAlbumModal").on('show.bs.modal', function(event){
		 var atag = $(event.relatedTarget);
		 albumid = atag.data("index");
	 });
	 
	 $("#reportAlbum").on('click', function(){
			var dat = {"albumid" : albumid,
							"reason" : $("#reportReasonAlbum").val()}
			dat = JSON.stringify(dat);
			$.ajax({
				 url: "reportAlbum" 
				, method: "POST"
				, data : dat
				, contentType: "application/json; charset=UTF-8"
				, success : function(){
					window.location.reload();
				}
			});
			$("#reportAlbumModal").modal("hide");
		 });
	});
		
		
  	
  	
	function list() {
  		
		$.ajax({
			url : "searchAlbumList"
			, method : "POST"
			, dataType : "json"
			, contentType: "application/json;charset=utf-8"
			, success : function(obj) {
				alert(obj[0].userid);
				alert(obj.length);
				if(obj.length == 0) {
					return;
				}else {
					var str = '';
					$.each(obj, function(index, item) {
						alert("for-each문 시작");
						str += "<div class='playlist-list-item padder-v b-b clearfix'>";
						str += 	 "<div class='row'>";
						str +=	   "<a href='javascript'>";
						str +=     "<div class='col-xs-2'><img src='upload/"+item.savedfile+"' style='height:60px; width:60px;'></div>";
						str += 	 	"<div class='col-xs-7' style='margin-top: 10px;'>";
			            str += 		  "<a href='#' id='playlist-title' class='font-bold'>" + item.makealbumname + "</a>";
			            str += 		 "<div id='playlist-count' class='text-muted'>" + item.count + "</div>";
			            str +=	   "</a>";
			            str += 	   	 "</div>";
			            str +=      "<div class='.col-xs-6 .col-md-4' style='margin-top: 10px;'>";
			            str += 		"<button  id='playlist-add' style='display: inline-block; margin-top: 10px;' onclick='listInsertAlbum("+'"'+item.makealbumname+'"'+")'>Add to playlist</button>";
			            str += 		"<button id='playlist-remove' class='playlist-remove' title='Remove' onclick='removeAlbum("+'"'+item.makealbumname+'"'+")'><i class='fa fa-times' style='margin-top: 10px; margin-left: 12px;'></i></button>";
			            str += 	  "</div>";
			            str += 	"</div>";
			            str += "</div>";
					});
						alert("성공");
				}
				$('#playlist-list').html(str);
				$('#playlist-new-title').val("");
		}
	});
		
  	}
  	
  	
  	
function addList(songId) {
	alert(songId);
	$("#save-text").prop('style', 'display:block');		
	$.ajax({
		url : "searchAlbumList"
		, method : "POST"
		, dataType : "json"
		, contentType: "application/json;charset=utf-8"
		, success : function(obj) {
			/* alert(obj[0].userid);
			alert(obj.length); */
				var str = '';
			alert(JSON.stringify(obj));
			$.each(obj, function(index, item) {
				alert("for-each문 시작");
				str += "<div class='playlist-list-item padder-v b-b clearfix'>";
				str += 	"<div class='row'>";
				str +=     "<div class='col-xs-2'><img src='upload/"+item.savedfile+"' style='height:60px; width:60px;'></div>";
				str += 	 	"<div class='col-xs-7' style='margin-top: 10px;'>";
	            str +=     	  "<a href='#' id='playlist-title' class='font-bold' album-name='"+item.makealbumname+"'>" + item.makealbumname + "</a>";
	            str +=       "<div id='playlist-count' class='text-muted'>" + item.count + "</div>";
	            str +=      "</div>";
	            str +=     "<div class='.col-xs-6 .col-md-4' style='margin-top: 10px;'>";
	            str +=     "<button id='playlist-add' style='display: inline-block; margin-top: 10px;' ";
	            str +=      'onclick="listInsertAlbum('+"'"+item.makealbumname+"'"+','+"'"+songId+"'"+')">';
	            str +=      "Add to playlist</button>";
	            str +=     "<button id='playlist-remove' class='playlist-remove' title='Remove' onclick='removeAlbum("+'"'+item.makealbumname+'"'+")'><i class='fa fa-times' style='margin-top: 10px; margin-left: 12px;'></i></button>";
	            str +=    "</div>";
	            str +=  "</div>";
	            str += "</div>";
			});
			alert("성공");
			$('#playlist-list').html(str);
			$('#myModal').modal();
        		$('#saveButton').on('click',function() {
        			var data = {};
        			var title = $('#playlist-new-title').val();
        			var savedFileName = $('#savedFileHidden').val();
 		    	  	var originalFileName = $('#originalFileHidden').val();
 		    	  	data.title = title;
 		    	  	data.savedFileName = savedFileName;
 		    	  	data.originalFileName = originalFileName;
 		    	  	data.songId = songId;
 		    	  	data = JSON.stringify(data);
        			alert("title : " + title);
        			alert("songid : " + songId);
        			$.ajax({
        				url : "myAlbumAdd"
        				, method : "post"
        				, data : data
        				//, data : "songId="+songId+"&title="+title+"&savedFileName="+savedFileName+"&originalFileName="+originalFileName
        				, contentType: "application/json;charset=utf-8"
        				, success : function() {
							list();
							$("#save-text").prop('style', 'display:none');
						}
        				, error : function(request,status,error){
        		        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        		    	
        				}
        			})
        		})
        		
			
		}
		, error : function(request,status,error){
	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    }
	})
 }
    	
		function removeAlbum(title) {
			alert("타이틀 :: " + title);
			
			 $.ajax({
				url : "removeAlbum"
				, method : "get"
				, data : "title=" + title
				, dataType : "text"
				, contentType: "application/json;charset=utf-8"
				, success : function() {
					list();
				}
				, error : function(request,status,error){
		        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			}) 
		}
    	
		 
  </script>
  
  <script>
  $(document).ready(function() {
	  $('#selectAlbumAdd').on('click',function() {
 		 alert("ppp");
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
			
			$("#save-text").prop('style', 'display:block');	
			list();
			$('#myModal').modal();
			$('#saveButton').on('click',function() {
    			var title = $('#playlist-new-title').val();
    			var savedFileName = $('#savedFileHidden').val();
		    	var originalFileName = $('#originalFileHidden').val();
			$.ajax({
				url : "selectAlbumAdd"
				, method : "get"
				, data : {"songIds" : arr, "title" : title, "savedFileName" : savedFileName, "originalFileName" : originalFileName }
				, contentType: "application/json;charset=utf-8"
				, success : function() {
					list();
					$("#save-text").prop('style', 'display:none');
				}
				, error : function(request,status,error){
		        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			})
		 })
		 
	  	}else {
			alert("체크박스를 체크해주세요!");
			return;
		}
		
 	 });
	  
});
  
  function listInsertAlbum(title,songId) {
		alert("title :: " + title);
		alert("송아이디 :: " + songId);
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
				url : "selectAddList"
				, method : "get"
				, data : {"songIds" : arr, "title" : title }
				, dataType : "text"
				, contentType: "application/json;charset=utf-8"
				, success : function() {
					list();
					$("#save-text").prop('style', 'display:none');
				}
				, error : function(request,status,error){
		        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			})
			
			}else {
				alert("체크박스 없이");
				alert("노래아이디 넘어오긴하나? :: " + songId);
				$.ajax({
					url : "selectAddOne"
					, method : "get"
					, data : {"songIds" : songId, "title" : title }
					, dataType : "text"
					, contentType: "application/json;charset=utf-8"
					, success : function() {
						list();
						$("#save-text").prop('style', 'display:none');
					}
					, error : function(request,status,error){
			        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				})
			}
		
	}
  
  </script>
  
  <script>
  	function imageClick() {
		$('#file').trigger('click');
	}
  	
  	
  	function albumCoverUpload() {
		alert("파일 업로드");
		
		var stringData = new FormData($('#goForm')[0]);
	    alert(typeof stringData);
	    alert("시작");
	       
		    $.ajax({
		       url : 'albumCoverUpload',
		       method : 'post',
		       data : stringData,
		       processData : false,
	           contentType : false,
		       success : function(obj){
			    	alert("==> " + obj.originalfile);
			    	alert("==> " + obj.savedfile);
		    	   $('#albumCover').prop('src','upload/'+obj.savedfile);
		    	   $('#savedFileHidden').val(obj.savedfile);
		    	   $('#originalFileHidden').val(obj.originalfile);
		       }
		       , error : function(request,status,error){
	        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    	
			   }
		    })
		
	}
  </script>
  
  <script>
  	$(document).ready(function() {
  		$('[data-toggle="tooltip"]').tooltip({
  		    animated: 'fade',	
  		    placement: 'top',
  		    html: true
  		});
	})
  </script>
  
</head>
<body class="">
  <section class="vbox">
    <header class="bg-white-only header header-md navbar navbar-fixed-top-xs">
      <div class="navbar-header aside bg-info nav-xs">
        <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen,open" data-target="#nav,html">
          <i class="icon-list"></i>
        </a>
        <a href="index.html" class="navbar-brand text-lt">
          <i class="icon-earphones"></i>
          <img src="resources/images/logo.png" alt="." class="hide">
          <span class="hidden-nav-xs m-l-sm">Musik</span>
        </a>
        <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".user">
          <i class="icon-settings"></i>
        </a>
      </div>      <ul class="nav navbar-nav hidden-xs">
        <li>
          <a href="#nav,.navbar-header" data-toggle="class:nav-xs,nav-xs" class="text-muted">
            <i class="fa fa-indent text"></i>
            <i class="fa fa-dedent text-active"></i>
          </a>
        </li>
      </ul>
      <form class="navbar-form navbar-left input-s-lg m-t m-l-n-xs hidden-xs" method="get" action="search" role="search">
        <div class="form-group">
          <div class="input-group">
            <span class="input-group-btn">
              <button type="submit" id="btn_search" class="btn btn-sm bg-white btn-icon rounded"><i class="fa fa-search"></i></button>
            </span>
            <input type="text" class="form-control input-sm no-border rounded" name="content" placeholder="Search songs, albums...">
          </div>
        </div>
      </form>
      <div class="navbar-right ">
        <ul class="nav navbar-nav m-n hidden-xs nav-user user">
          <li class="hidden-xs">
            <a href="#" class="dropdown-toggle lt" data-toggle="dropdown">
              <i class="icon-bell"></i>
              <span class="badge badge-sm up bg-danger count">2</span>
            </a>
            <section class="dropdown-menu aside-xl animated fadeInUp">
              <section class="panel bg-white">
                <div class="panel-heading b-light bg-light">
                  <strong>You have <span class="count">2</span> notifications</strong>
                </div>
                <div class="list-group list-group-alt">
                  <a href="#" class="media list-group-item">
                    <span class="pull-left thumb-sm">
                      <img src="resources/images/a0.png" alt="..." class="img-circle">
                    </span>
                    <span class="media-body block m-b-none">
                      Use awesome animate.css<br>
                      <small class="text-muted">10 minutes ago</small>
                    </span>
                  </a>
                  <a href="#" class="media list-group-item">
                    <span class="media-body block m-b-none">
                      1.0 initial released<br>
                      <small class="text-muted">1 hour ago</small>
                    </span>
                  </a>
                </div>
                <div class="panel-footer text-sm">
                  <a href="#" class="pull-right"><i class="fa fa-cog"></i></a>
                  <a href="#notes" data-toggle="class:show animated fadeInRight">See all the notifications</a>
                </div>
              </section>
            </section>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle bg clear" data-toggle="dropdown">
              <span class="thumb-sm avatar pull-right m-t-n-sm m-b-n-sm m-l-sm">
                <img src="resources/images/a0.png" alt="...">
              </span>
              ${userNick} <b class="caret"></b>
            </a>
            <ul class="dropdown-menu animated fadeInRight">            
              <li>
                <span class="arrow top"></span>
                <a href="#">Settings</a>
              </li>
              <li>
                <a href="profile.html">Profile</a>
              </li>
              <li>
                <a href="#">
                  <span class="badge bg-danger pull-right">3</span>
                  Notifications
                </a>
              </li>
              <li>
                <a href="docs.html">Help</a>
              </li>
              <li class="divider"></li>
              <li>
                <a href="modal.lockme.html" data-toggle="ajaxModal" >Logout</a>
              </li>
            </ul>
          </li>
        </ul>
      </div>      
    </header>
    
    <section>
      <section class="hbox stretch">
        <!-- .aside -->
        <aside class="bg-black dk nav-xs aside hidden-print" id="nav">          
          <section class="vbox">
            <section class="w-f-md scrollable">
              <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="10px" data-railOpacity="0.2">
                
                <!-- nav -->                 
                <nav class="nav-primary hidden-xs">
                  <ul class="nav bg clearfix">
                    <c:if test="${not empty loginId }">
                    <li>
                      <a href="#" class = "linkToPage" movePage = "home">
                        <i class="icon-disc icon text-success"></i>
                        <span class="font-bold">What's new</span>
                      </a>
                    </li>
                    </c:if>
                    <li>
                      <a href="#" class = "linkToPage" movePage = "All">
                        <i class="icon-music-tone-alt icon text-info"></i>
                        <span class="font-bold">Genres</span>
                      </a>
                    </li>
                    <li>
                      <a href="#" class = "linkToPage" movePage = "listen">
                        <i class="icon-list icon  text-info-dker"></i>
                        <span class="font-bold">Listen</span>
                      </a>
                    </li>
                    <c:if test="${not empty loginId }">
                    <li>
                      <a href="#" class = "linkToPage" movePage = "logInfo" 
                      data-target="#content" data-el="#bjax-el" data-replace="true">
                        <i class="icon-screen-desktop icon"></i>
                        <span class="font-bold">Log</span>
                      </a>
                    </li>
                    </c:if>
                    <li>
                   	 <a href="#" class="auto linkToPage" movePage = "musicRecognition">       
                        <i class="icon-microphone"></i>
                        <span class="font-bold">Music Recognition</span>
                      </a>
                    </li>
                  </ul>
                  <c:if test="${empty loginId }">
                  <ul class="nav" data-ride="collapse">
                    <li >
                      <a href="#" class="auto">
                        <span class="pull-right text-muted">
                          <i class="fa fa-angle-left text"></i>
                          <i class="fa fa-angle-down text-active"></i>
                        </span>
                        <i class="icon-settings">
                        </i>
                        <span>Setting</span>
                      </a>
                      <ul class="nav dk text-sm">
                        <li >
                          <a href="#" class="auto linkToPage" movePage = "signin" >                                                        
                            <i class="fa fa-angle-right text-xs"></i>
                            <span>Sign in</span>
                          </a>
                        </li>
                        <li >
                          <a href="#" class="auto linkToPage" movePage = "join">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Sign up</span>
                          </a>
                        </li>
                      </ul>
                    </li>
                  </ul>
                  </c:if>
                </nav>
                <!-- / nav -->
              </div>
            </section>
            
            <c:if test="${ not empty loginId }">    
            <footer class="footer hidden-xs no-padder text-center-nav-xs">
              <div class="bg hidden-xs ">
                  <div class="dropdown dropup wrapper-sm clearfix">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                      <span class="thumb-sm avatar pull-left m-l-xs">                        
                        <img src="resources/images/a3.png" class="dker" alt="...">
                        <i class="on b-black"></i>
                      </span>
                      <span class="hidden-nav-xs clear">
                        <span class="block m-l">
                          <strong class="font-bold text-lt">${userNick}</strong> 
                          <b class="caret"></b>
                        </span>
                        <span class="text-muted text-xs block m-l"></span>
                      </span>
                    </a>
                    <ul class="dropdown-menu animated fadeInRight aside text-left">                      
                      <li>
                        <a href="profile">Profile</a>
                      </li>
                      <li>
                      </li>
                      <li class="divider"></li>
                      <li>
                        <a href="logout" >Logout</a>
                      </li>
                    </ul>
                  </div>
                </div>            </footer>
               </c:if>
          </section>
        </aside>
        
        <!-- /.aside -->
        <section id="content">
          <section class="hbox stretch">
            <section>
              <section class="vbox">
                <section class="scrollable padder-lg w-f-md" id="bjax-target">
                  <!-- <a href="#" class="pull-right text-muted m-t-lg" data-toggle="class:fa-spin" ><i class="icon-refresh i-lg  inline" id="refresh"></i></a>
                  <h2 class="font-thin m-b">Album <span class="musicbar animate inline m-l-sm" style="width:20px;height:20px">
                    <span class="bar1 a1 bg-primary lter"></span>
                    <span class="bar2 a2 bg-info lt"></span>
                    <span class="bar3 a3 bg-success"></span>
                    <span class="bar4 a4 bg-warning dk"></span>
                    <span class="bar5 a5 bg-danger dker"></span>
                  </span></h2> -->
                  
                  
			<div id="cont_wrap" class="clfix">
		<div id="conts_section" class="my_fold">
			<!-- contents -->
			
				<div id="conts" class="clfix ban"> <!-- 띠배너일때 ban 클래스 추가 -->
					<h2 class="f_tit">앨범 정보</h2>
					<!-- 띠배너 -->
					
					<!-- //띠배너 -->
					<!-- 앨범 기본 정보 -->
					
			<div class="wrap_dtl_album" style="border: none;">
				<div class="dtl_album clfix">
					<h3 class="none">앨범 기본정보</h3>
					<div class="wrap_thumb">
						<a href="#d_almumcover" title="Dig Out Your Soul 앨범이미지" class="thumb" data-control="modal">
							<span class="thumb_frame"></span>
							<span><img onerror="WEBPOCIMG.defaultPhotoImg(this);" height="216" width="216" src="upload/${artistAlbum.albumimgurl }" alt="Dig Out Your Soul 앨범이미지"/></span>
							<span id="albumImgArea" style="display: none;"><img onerror="WEBPOCIMG.defaultPhotoImg(this,200);" src="http://cdnimg.melon.co.kr/cm/album/images/003/98/548/398548.jpg" alt=""/></span>
						</a>
						<div class="l_popup album_prev" id="d_almumcover" style="left:56px; top:132px; width:530px;display:none;">
							<div class="cntt">
								<a href="javascript:;" title="이미지 확대보기" class="wrap_prev photoDetailThumb">
									<img onerror="WEBPOCIMG.defaultPhotoImg(this);" height="496" width="496" org_src="/cm/album/images/003/98/548/398548_org.jpg" src="upload/${artistAlbum.albumimgurl }">
									<span class="prev_frame"></span>
									<span class="icon_viewlk_image"></span>
								</a>
							</div>
							<button type="button" title="Dig Out Your Soul 앨범이미지 닫기" class="btn_close d_close"><span class="odd_span">닫기</span></button>
							<span class="shadow"></span>
						</div>
						<!-- //[DP] 앨범보기 -->
						<div class="wrap_btn">
							<!-- <button type="button"  title="Dig Out Your Soul 앨범재생" class="btn_album_lstn " onclick="javascript:melon.play.playAlbum('28010101','398548');"><span class="odd_span">앨범듣기</span></button>
							<button type="button"  title="Dig Out Your Soul 앨범다운로드" class="btn_album_dl " onClick="javascript:melon.buy.goBuyProduct('frm','398548','3B0001','','0','28010101','1');"><span class="odd_span">앨범다운로드</span></button> -->
						</div>
					</div><!-- //class="wrap_thumb" -->
					<div class="wrap_album_info">
						<p class="albumname">
							<strong class="none">앨범명</strong>
							<span class="gubun">[정규]</span>
							${artistAlbum.albumtitle }
						</p>
						<dl class="song_info clfix">
							<dt>아티스트</dt>
							<dd>
								<a href="javascript:melon.link.goArtistDetail('104369')" title="Oasis" class="atistname"><span>${artistName }</span><span class="thumb_atist"><img onerror="WEBPOCIMG.defaultArtistImg(this);" src="upload/${artistAlbum.albumimgurl }" width="52" height="52"></span></a>
							</dd>
							<dt>발매일</dt>
							<dd>${artistAlbum.albumrelease }</dd>
							<dt>발매사</dt>
							<dd></dd>
							<dt>기획사</dt>
							<dd></dd>
							<dt>장르</dt>
							<dd></dd>
						</dl>
						<dl class="song_sns clfix">
							<dt><!-- 공유하기 --></dt>
							<dd>
								<span class="wrap_btn_sns">
									<!-- <button type="button" title="친구에게 앨범 추천하기" class="btn_sns frend" onclick="javascript:melon.link.goMultiMessagePop('album','398548');"><span class="odd_span">친구</span></button>
									<button type="button" title="페이스북" id="albumFacebook" class="btn_sns facebook" data-menuId="28010101"><span class="odd_span">페이스북</span></button>
									<button type="button" title="트위터" id="albumTwitter" class="btn_sns twitter" data-menuId="28010101"><span class="odd_span">트위터</span></button> -->
								</span>
							</dd>
						</dl>
						<dl class="song_gift clfix">
							<dt><!-- 선물하기 --></dt>
							<dd>
								<!-- <button type="button"  onclick="javascript:melon.buy.goPresentForAlbum('398548','frm','28010101');" title="이 앨범을 친구에게 선물하기" class="btn_song_gift "><span class="odd_span">이 앨범을 친구에게 선물하기</span></button> -->
							</dd>
						</dl>
						<!-- 다른버전 앨범 [] -->
						
						<!-- //다른버전앨범 버튼 -->
					</div><!-- //class="wrap_album_info" -->
					<div class="wrap_intst">
						<div class="pull-right">
							<a class="reportAlbum" data-toggle="modal" data-target="#reportAlbumModal" data-index="${albumid}">
			        	<i class="icon-flag"></i></a>
						<!-- 평점 -->
						<!-- //평점 -->
						
						<!-- 리뷰 -->
						<!-- //리뷰 -->
						
						<!-- 좋아요 -->
						<!-- //좋아요 -->
					</div><!-- //class="wrap_intst" -->
				</div>
				
				<!-- 구매 안내 문구 -->
				
				<!-- //구매 안내 문구 -->
			</div>




					<!-- //앨범 기본 정보 -->
					<!-- 수록곡 -->
					<div class="section_contin">
						<h3 class="title first arr">TotalSong <span class="no">${count }</span></h3>
						
							
								<!-- 수록곡_CD번호 표시 -->
	<form id="frm" name="frm">
	<div class="tb_list d_song_list" style="width:1008px;">
		
		<div class="wrap_btn_tb top">
			<button type="button" title="곡 목록 전체 선택" id="songListAllChk" class="btn_base short check_all d_checkall"><span class="odd_span"><span class="even_span">SelectAll</span></span></button>
			<button type="button" title="선택된 곡 재생 - 새 창" class="btn_base short play d_listen" id="playFormSong"><span class="odd_span"><span class="even_span">Play</span></span></button>
			<button type="button" title="선택된 곡 담기 - 새 창" class="btn_base short scrap d_scrap" id="selectAlbumAdd"><span class="odd_span"><span class="even_span">Add</span></span></button>
		</div>
		
		
		<table border="1" style="width:100%">
			<caption>CD1 <span class="none">트랙 리스트</span></caption>
			<colgroup><col style="width:29px" /><col style="width:48px" /><col /><col style="width:217px" /><col style="width:89px" /><col style="width:43px" /><col style="width:27px" /><col style="width:45px" /></colgroup>
			<thead>
				<tr>
					<th scope="col"><div class="wrap pd_none left">
						<input type="checkbox" title="CD1 곡 목록 전체선택" class="input_check d_checkall" />
					</div></th>
					<th scope="col"><div class="wrap">NO</div></th>
					<th scope="col"><div class="wrap">곡명</div></th>
					<th scope="col" class="t_left"><div class="wrap">아티스트</div></th>
					<th scope="col" class="t_left"><div class="wrap right_none">좋아요</div></th>
					<th scope="col"><div class="wrap pd_none left">재생</div></th>
					<th scope="col"><div class="wrap pd_none">담기</div></th>
					<th scope="col"><div class="wrap pd_none">신고</div></th>
				</tr>
			</thead>
			<tbody>
			 <c:forEach var="m" items="${songList }">
				<tr >
					<td><div class="wrap pd_none left">
						<input type="checkbox" title="" class="input_check" name="input_check" value="${m.songid }" />
					</div></td>
					<td class="no"><div class="wrap">${m.tracknumber }</div></td>
					<td class="t_left"><div class="wrap pd_none" style="padding-left: 15px">
						<div class="ellipsis" style="max-width:100%">
							<!-- <button type="button" class="btn_icon play" title="재생" onClick="melon.play.playSong('28010101',1934827);"><span class="odd_span">재생</span></button>
							<button type="button" class="btn_icon add" title="담기" onClick="melon.play.addPlayList('1934827');"><span class="odd_span">담기</span></button>
							<a href="javascript:melon.link.goSongDetail('1934827');" title="곡정보 보기" class="btn btn_icon_detail"><span class="odd_span">Bag It Up 상세정보 페이지 이동</span></a> -->
							
							<a href="#" title="">${m.songtitle }</a>
						</div>
					</div></td>
					<td class="t_left"><div class="wrap">
						<div id="artistName" class="ellipsis" style="max-width:188px">
							<a href="javascript:goSearch('${m.artist}');" title="<img src='upload/${m.artistimgurl }' style='height:80px; width:80px;'>" data-toggle="tooltip" class="white-tooltip" style="color: #788188">${m.artist}</a>
						</div>
						
					</div></td>
					<td class="t_left"><div class="wrap right_none">
						<!-- <button type="button" class="btn_icon like" title="좋아요" data-song-no="1934827" data-song-menuId="28010101"> -->
						<c:if test="${m.like}">
						<i id="heart${m.songid }" class="fa fa-heart" data-songid="${m.songid}"></i>
						</c:if>
						<c:if test="${not m.like}">
						<i id="heart${m.songid }" class="fa fa-heart-o" data-songid="${m.songid}"></i>
						</c:if>
						<!-- <i id="redheart" class="fa fa-heart"></i> -->
							<!-- <span class="odd_span"></span> -->
							<span class="cnt" id="${m.songid}">${m.count}</span>
						<!-- </button> -->
					</div></td>
					<td><div class="wrap pd_none left">
						<%-- <button type="button" id="xxx" class="btn_icon play" title="재생" song-id="${m.songid }" ><span class="odd_span">재생</span></button> --%>
						<!-- <div class="col-md-3 col-sm-4"> -->
		                    <i id="play-me" class="icon-control-play-origin" song-id="${m.songid }"></i>
		                <!-- </div> -->
						</div>
					</td>
					<td><div class="wrap pd_none">
						<!-- <button type="button" class="btn_icon add" title="담기" onClick="melon.play.addPlayList('1934827');"><span class="odd_span">담기</span></button> -->
						<i id="on-list${m.songid }" class="icon-list-origin" onclick="javascript:addList('${m.songid }')" song-id="${m.songid }"></i>
					</div></td>
					<td><div class="wrap pd_none right">
						<!-- <button type="button"  class="btn_icon sendlk1" title="폰 다운" onClick="melon.buy.popPhoneDecorate('1110000000000000','1934827')"><span class="odd_span">폰 다운</span></button> -->
						<a class="reportSong" data-toggle="modal" data-target="#reportModal" data-index="${m.songid }">
			        	<i class="icon-flag"></i></a>
					</div></td>
				</tr>
			 </c:forEach>
			</tbody>
		</table>
		
	</div>
	</form>

						
					</div>
					<!-- //수록곡 -->
					<!-- 앨범소개 -->
					
					<div class="section_albuminfo">
						<h3 class="title line arr_2">앨범소개</h3>
						<div class="cont_albuminfo">
							<!-- 앨범소개글 140128_수정 height:203 -->
							<div class="dtl_albuminfo" style="height:auto;" id="d_video_summary"><!-- height:auto; 로 변경시, 확장됨 -->
								<!-- 앨범소개 썸네일 -->
								<div class="wrap_albuminfo">
									<span class="thumb">
										<span class="thumb_frame"></span>
										<img onerror="WEBPOCIMG.defaultAlbumImg(this);" height="136" width="136" src="upload/${artistAlbum.albumimgurl }" alt="Dig Out Your Soul 앨범 이미지"/>
									</span>
								</div>
								<!-- //앨범소개 썸네일 -->
								${artistAlbum.albumdiscription}
							</div>
							<!-- //앨범소개글 -->

						</div>
					</div>
					
					<!-- 리뷰  -->
					<!-- <div id="section_rvew" class="section_rvew">
						<h3 class="title arr_2">리뷰</h3>
						
						<div class='cmt_area' id='d_cmtpgn' data-sqwidget='templateType:pc-summary-type;textareaType:large-size;pageType:generic-page' data-sqwidget-settings='cmtPocType:pc.web;pocId:WP10;menuId:28010101;chnlSeq:102;contsRefValue:398548;listPageUrl:http://www.melon.com//album/detail.htm?albumId=398548'></div>
					</div>
					//리뷰 
					연관 앨범 
					
					//연관 앨범 
					수록 곡이 포함된 DJ 플레이리스트 
					
					<div class="section_playlist">
						<h3 class="title line arr_2">수록 곡이 포함된 DJ 플레이리스트</h3>
						<div class="list_dj_play">
							<ul class="clfix">
								
								<li>
									<div class="box_dj_play">
										<a href="javascript:melon.link.goDjPlaylistDetail('0', 'Y', 'N', '406361020');" title="한껏 가라앉고 싶을 때 (몽환, 우울, 새벽감성)" class="thumb">
											<span class="thumb_frame"></span>
												<img onerror="WEBPOCIMG.defaultPlaylistImg(this);" height="130" width="130" src="http://image.melon.co.kr/svc/user_images/plylst/83/100/406361020_190.jpg?tm=1460461574767" alt=""/>
										</a>
										<div class="dj_songinfo">
											<dl>
												<dt>
													<strong class="none">플레이리스트명</strong>
													<a href="javascript:melon.link.goDjPlaylistDetail('0', 'Y', 'N', '406361020');" title="한껏 가라앉고 싶을 때 (몽환, 우울, 새벽감성)">한껏 가라앉고 싶을 때 (몽환, 우울, 새벽감성)</a>
												</dt>
												<dd class="atistname">
													<span class="ico_dj">DJ</span>
													<strong class="none">DJ닉네임</strong>
													<a href="javascript:melon.link.goMyMusic('8299590');" title="Hyeyaaa">Hyeyaaa</a>
												</dd>
												<dd class="cnt_song">
													<strong class="none">수록곡수</strong>
													<span>총 208곡</span>
												</dd>
												<dd class="cnt_themalk">
													
														테마 : 비오는 날, 밤/새벽
													
													
												</dd>
												<dd class="wrap_btn d_djcol_list">
													<a href="javascript;" title="한껏 가라앉고 싶을 때 (몽환, 우울, 새벽감성) 좋아요" class="btn_like  d_btn" data-play-no="406361020" data-djcol-no="406361020" data-djcol-menuId="28010101">class="on" 추가시 활성
														<span class="icon">좋아요</span>
														<strong class="none">총건수</strong>645
													</a>
												</dd>
											</dl>
											<div class="dj_songlist">
												<strong class="none">DJ 플레이리스트 곡목록</strong>
												<ul>
												
													
													<li>
													<a href="javascript:;" title="A Case Of You 재생" class="btn_play_song " onClick="javascript:melon.play.playSong('28010101', '3568649')">
														<span class="icon_play">곡재생</span>
														
														
														
														<span class="songname11">A Case Of You</span>
													</a>
													</li>
													
												
													
													<li>
													<a href="javascript:;" title="Inside And Out (Album Ver.) 재생" class="btn_play_song " onClick="javascript:melon.play.playSong('28010101', '1560273')">
														<span class="icon_play">곡재생</span>
														
														
														
														<span class="songname11">Inside And Out (Album Ver.)</span>
													</a>
													</li>
													
												
												</ul>
											</div>
										</div>
									</div>
								</li>
								
								<li>
									<div class="box_dj_play">
										<a href="javascript:melon.link.goDjPlaylistDetail('0', 'Y', 'N', '411485108');" title="노래 들을때 영드&amp;미드 주인공이 된것 같은 기분이 드는 곡 list" class="thumb">
											
											
												
												<span class="thumb_frame"></span>
												
												
											
											
												
													<img onerror="WEBPOCIMG.defaultPlaylistImg(this);" height="130" width="130" src="http://image.melon.co.kr/svc/user_images/plylst/303/80/411485108_190.jpg?tm=1460461574768" alt=""/>
												
												
											
											
										</a>
										<div class="dj_songinfo">
											<dl>
												<dt>
													<strong class="none">플레이리스트명</strong>
													<a href="javascript:melon.link.goDjPlaylistDetail('0', 'Y', 'N', '411485108');" title="노래 들을때 영드&amp;미드 주인공이 된것 같은 기분이 드는 곡 list">노래 들을때 영드&amp;미드 주인공이 된것 같은 기분이 드는 곡 list</a>
												</dt>
												<dd class="atistname">
													<span class="ico_dj">DJ</span>
													<strong class="none">DJ닉네임</strong>
													<a href="javascript:melon.link.goMyMusic('30279915');" title="보song">보song</a>
												</dd>
												<dd class="cnt_song">
													<strong class="none">수록곡수</strong>
													<span>총 38곡</span>
												</dd>
												<dd class="cnt_themalk">
													
														테마 : 기분전환, 매장음악
													
													
												</dd>
												<dd class="wrap_btn d_djcol_list">
													<a href="javascript;" title="노래 들을때 영드&amp;미드 주인공이 된것 같은 기분이 드는 곡 list 좋아요" class="btn_like  d_btn" data-play-no="411485108" data-djcol-no="411485108" data-djcol-menuId="28010101">class="on" 추가시 활성
														<span class="icon">좋아요</span>
														<strong class="none">총건수</strong>393
													</a>
												</dd>
											</dl>
											<div class="dj_songlist">
												<strong class="none">DJ 플레이리스트 곡목록</strong>
												<ul>
												
													
													<li>
													<a href="javascript:;" title="Yesterdays 재생" class="btn_play_song " onClick="javascript:melon.play.playSong('28010101', '5650820')">
														<span class="icon_play">곡재생</span>
														
														
														
														<span class="songname11">Yesterdays</span>
													</a>
													</li>
													
												
													
													<li>
													<a href="javascript:;" title="Midnight City 재생" class="btn_play_song " onClick="javascript:melon.play.playSong('28010101', '3637275')">
														<span class="icon_play">곡재생</span>
														
														
														
														<span class="songname11">Midnight City</span>
													</a>
													</li>
													
												
												</ul>
											</div>
										</div>
									</div>
								</li>
								
								<li>
									<div class="box_dj_play">
										<a href="javascript:melon.link.goDjPlaylistDetail('0', 'Y', 'N', '101417496');" title="들을수록 좋은 팝송들~&hearts;" class="thumb">
											
											
												
												<span class="thumb_frame"></span>
												
												
											
											
												
													<img onerror="WEBPOCIMG.defaultPlaylistImg(this);" height="130" width="130" src="http://image.melon.co.kr/files/users/images/open/offer/1_002.JPG?tm=1460461574768" alt=""/>
												
												
											
											
										</a>
										<div class="dj_songinfo">
											<dl>
												<dt>
													<strong class="none">플레이리스트명</strong>
													<a href="javascript:melon.link.goDjPlaylistDetail('0', 'Y', 'N', '101417496');" title="들을수록 좋은 팝송들~&hearts;">들을수록 좋은 팝송들~&hearts;</a>
												</dt>
												<dd class="atistname">
													<span class="ico_dj">DJ</span>
													<strong class="none">DJ닉네임</strong>
													<a href="javascript:melon.link.goMyMusic('68007');" title="theway16">theway16</a>
												</dd>
												<dd class="cnt_song">
													<strong class="none">수록곡수</strong>
													<span>총 25곡</span>
												</dd>
												<dd class="cnt_themalk">
													
													
														장르 : 록/메탈
													
												</dd>
												<dd class="wrap_btn d_djcol_list">
													<a href="javascript;" title="들을수록 좋은 팝송들~&hearts; 좋아요" class="btn_like  d_btn" data-play-no="101417496" data-djcol-no="101417496" data-djcol-menuId="28010101">class="on" 추가시 활성
														<span class="icon">좋아요</span>
														<strong class="none">총건수</strong>20
													</a>
												</dd>
											</dl>
											<div class="dj_songlist">
												<strong class="none">DJ 플레이리스트 곡목록</strong>
												<ul>
												
													
													<li>
													<a href="javascript:;" title="Stand By Me 재생" class="btn_play_song " onClick="javascript:melon.play.playSong('28010101', '358229')">
														<span class="icon_play">곡재생</span>
														
														
														
														<span class="songname11">Stand By Me</span>
													</a>
													</li>
													
												
													
													<li>
													<a href="javascript:;" title="My Immortal 재생" class="btn_play_song " onClick="javascript:melon.play.playSong('28010101', '451978')">
														<span class="icon_play">곡재생</span>
														
														
														
														<span class="songname11">My Immortal</span>
													</a>
													</li>
													
												
												</ul>
											</div>
										</div>
									</div>
								</li>
								
							</ul>
						</div>
					</div>
					
					//수록 곡이 포함된 DJ 플레이리스트 
					좋아요 한 사람 
					
					<div class="section_intst">
						<h3 class="title line arr_2">좋아요 한 사람</h3>
						<div class="wrap_list_intst">
							
			<ul class="list_userlk02">
			
				
				
				<li>
					<div class="box_userlk02">
						<a href="javascript:melon.link.goMyMusic(11484045)" title="K.Composer" class="thumb">
							<span class="thumb_frame"></span>
							<img onerror="WEBPOCIMG.defaultArtistImg(this);" height="72" width="72" src="http://image.melon.co.kr/svc/user_images/user/115/85/11484045_86.jpg?tm=1460461574768" alt=""/>
						</a>
						<dl>
							<dt>
								<span class="ellipsis"><span class="ico_dj">DJ</span>
								<a href="javascript:melon.link.goMyMusic(11484045)" title="K.Composer">K.Composer</a></span>
							</dt>
							<dd class="gnr"><span class="ellipsis"><span class="ico_gnr">장르</span>Rock</span></dd>
							<dd class="play_co">
								<span class="ico_play_dj">DJ컬렉션수</span> 7개
								
							</dd>
							<dd class="play_song">
								<div class="ellipsis">
								
									
									<a href="javascript:;" onclick="javascript:melon.play.playSong('28010101', '359326');" title="With Or Without You 재생" class="btn btn_play_song ">
										<span class="icon_play">곡재생</span>
										
										
										
										<span class="songname11">With Or Without You</span>
									</a>
									<span class="hyphen">-</span>
									
									
									
										<a href="javascript:melon.link.goArtistDetail(100329)" title="U2" class="play_artist"><span>U2</span></a>
									
									
									
								
								</div>
							</dd>
						</dl>
					</div>
				</li>
				
			
			
			
				
				
				<li>
					<div class="box_userlk02">
						<a href="javascript:melon.link.goMyMusic(24750241)" title="론리롤리" class="thumb">
							<span class="thumb_frame"></span>
							<img onerror="WEBPOCIMG.defaultArtistImg(this);" height="72" width="72" src="http://image.melon.co.kr/svc/user_images/user/248/51/24750241_86.jpg?tm=1460461574768" alt=""/>
						</a>
						<dl>
							<dt>
								<span class="ellipsis"><span class="ico_dj">DJ</span>
								<a href="javascript:melon.link.goMyMusic(24750241)" title="론리롤리">론리롤리</a></span>
							</dt>
							<dd class="gnr"><span class="ellipsis"><span class="ico_gnr">장르</span>Pop</span></dd>
							<dd class="play_co">
								<span class="ico_play_dj">DJ컬렉션수</span> 1개
								
							</dd>
							<dd class="play_song">
								<div class="ellipsis">
								
									
									<a href="javascript:;" onclick="javascript:melon.play.playSong('28010101', '4478169');" title="지구가 태양을 네 번 재생" class="btn btn_play_song ">
										<span class="icon_play">곡재생</span>
										
										
										
										<span class="songname11">지구가 태양을 네 번</span>
									</a>
									<span class="hyphen">-</span>
									
									
									
										<a href="javascript:melon.link.goArtistDetail(101094)" title="넬" class="play_artist"><span>넬</span></a>
									
									
									
								
								</div>
							</dd>
						</dl>
					</div>
				</li>
				
			
			
			
				
				
				<li>
					<div class="box_userlk02">
						<a href="javascript:melon.link.goMyMusic(29329074)" title="underwatersquad" class="thumb">
							<span class="thumb_frame"></span>
							<img onerror="WEBPOCIMG.defaultArtistImg(this);" height="72" width="72" src="http://image.melon.co.kr/svc/user_images/user/294/30/29329074_86.jpg?tm=1460461574768" alt=""/>
						</a>
						<dl>
							<dt>
								<span class="ellipsis"><span class="ico_dj">DJ</span>
								<a href="javascript:melon.link.goMyMusic(29329074)" title="underwatersquad">underwatersquad</a></span>
							</dt>
							<dd class="gnr"><span class="ellipsis"><span class="ico_gnr">장르</span>Rap / Hip-hop</span></dd>
							<dd class="play_co">
								<span class="ico_play_dj">DJ컬렉션수</span> 0개
								
							</dd>
							<dd class="play_song">
								<div class="ellipsis">
								
									
									<a href="javascript:;" onclick="javascript:melon.play.playSong('28010101', '5728892');" title="Dead Inside 재생" class="btn btn_play_song ">
										<span class="icon_play">곡재생</span>
										
										
										
										<span class="songname11">Dead Inside</span>
									</a>
									<span class="hyphen">-</span>
									
									
									
										<a href="javascript:melon.link.goArtistDetail(100545)" title="Muse" class="play_artist"><span>Muse</span></a>
									
									
									
								
								</div>
							</dd>
						</dl>
					</div>
				</li>
				
			
			
			
				
				
				<li>
					<div class="box_userlk02">
						<a href="javascript:melon.link.goMyMusic(14661447)" title="뉴나왜귤터진거줘여" class="thumb">
							<span class="thumb_frame"></span>
							<img onerror="WEBPOCIMG.defaultArtistImg(this);" height="72" width="72" src="http://image.melon.co.kr/svc/user_images/user/147/62/14661447_86.jpg?tm=1460461574768" alt=""/>
						</a>
						<dl>
							<dt>
								<span class="ellipsis"><span class="ico_dj">DJ</span>
								<a href="javascript:melon.link.goMyMusic(14661447)" title="뉴나왜귤터진거줘여">뉴나왜귤터진거줘여</a></span>
							</dt>
							<dd class="gnr"><span class="ellipsis"><span class="ico_gnr">장르</span>Rock</span></dd>
							<dd class="play_co">
								<span class="ico_play_dj">DJ컬렉션수</span> 1개
								
							</dd>
							<dd class="play_song">
								<div class="ellipsis">
								
									
									
									<a href="javascript:;" class="btn btn_play_song disabled">
										<span class="icon_play">곡재생</span>
										<span class="songname11"> - </span>
									</a>
									
								
								</div>
							</dd>
						</dl>
					</div>
				</li>
				
			
			</ul>
						</div>
						<div class="wrap_page">
							<ul class="list_sort withListOrderLayedr">
								<li class="first_child on"><a href="#;" id="MELONDJ_YN" class="orderClass" title="좋아요 한 사람 활동순으로 정렬">활동순</a></li>
								<li ><a href="#;" id="UPDT_DATE" class="orderClass" title="좋아요 한 사람 최신순으로 정렬">최신순</a></li>
							</ul>
							<div class="page">
								<span class="page_num">
									<span class="none">현재 페이지</span><strong class="d_now_page">1</strong>
									/
									<span class="none">전체 페이지</span><span class="d_total_page">5</span>
								</span>
								<span class="wrap_btn">
									<a href="#;" title="이전" class="btn btn_pre d_btn withLikeBtnTmp" id="withLikeBtnTmp1" data-orderby-type="MELONDJ_YN" data-limit-count="13" data-view-type="withLikeUser" data-view-contsId="398548"><span class="odd_span">이전</span></a>
									<a href="#;" title="다음" class="btn btn_next d_btn withLikeBtnTmp" id="withLikeBtnTmp2" data-orderby-type="MELONDJ_YN" data-limit-count="13" data-view-type="withLikeUser" data-view-contsId="398548"><span class="odd_span">다음</span></a>
								</span>
							</div>
						</div>
					</div>
					
					//좋아요 한 사람 
				</div> -->
<!-- C. 전체 공통 스크립트 -->



	</div>
	</div>
	</div>
	</div>
		                  
                  
                  
                  
                  
                  
                  
                  <%-- 
                  <c:if test="${ArtistAlbum ne null}">
                  <div class="row row-sm">
                    <div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
                      <div class="item">
                        <div class="pos-rlt">
                          <div class="item-overlay opacity r r-2x bg-black ">
                            <div class="text-info padder m-t-sm text-sm">
                              <i class="fa fa-star"></i>
                              <i class="fa fa-star"></i>
                              <i class="fa fa-star"></i>
                              <i class="fa fa-star-o text-muted"></i>
                              <i class="fa fa-star-o text-muted"></i>
                            </div>
                            <div class="center text-center m-t-n">
                              <a href="#" data-toggle="class">
                                <i class="icon-control-play i-2x text"></i>
                                <i class="icon-control-pause i-2x text-active"></i>
                              </a>
                            </div>
                            <div class="bottom padder m-b-sm">
                              <a href="#" class="pull-right active" data-toggle="class">
                                <i class="fa fa-heart-o text"></i>
                                <i class="fa fa-heart text-active text-danger"></i>
                              </a>
                              <a href="#" data-toggle="class">
                                <i class="fa fa-plus-circle text"></i>
                                <i class="fa fa-check-circle text-active text-info"></i>
                              </a>
                            </div>
                          </div>
                          <a href="#"><img src="upload/${Artist.artistimgurl }" alt="" class="r r-2x img-full" ></a>
                        </div>
                        <div class="padder-v">
                          <a href="#" class="text-ellipsis">${ArtistAlbum.albumtitle }</a>
                          <a href="#" class="text-ellipsis text-xs text-muted">${ArtistAlbum.albumdiscription }</a>
                        </div>
                      </div>
                    </div>
                    <div class="artist_info">
                     <div class="artist_info2">
                     	<table>
                     		<tr>
                     			<td width="85px">이름</td>
                     			<td>${Artist.artistname }</td>
                     		</tr>
                     		<tr>
                     			<td width="85px">데뷔날짜</td>
                     			<td>${Artist.artistdebut }</td>
                     		</tr>
                     		<tr>
                     			<td width="85px">생일</td>
                     			<td>${Artist.artistbirthday }</td>
                     		</tr>
                     		<tr>
                     			<td width="85px">포지션</td>
                     			<td>${Artist.artistposition }</td>
                     		</tr>
                     		<tr>
                     			<td width="85px">활동</td>
                     			<c:if test="${Artist.artistactive }=='true'">
                     			<td>현재 쉬는중</td>
                     			</c:if>
                     			<c:if test="${Artist.artistactive }=='false'"></c:if>
                     			<td>현재 활동중</td>
                     		</tr>
                     	</table>
                     	<!-- <b>데뷔날짜</b><b>2016.04.08</b><br />
                     	<b>생일</b>&nbsp;&nbsp;<b>2016.04.08</b><br />
                     	<b>혈액형</b>&nbsp;&nbsp;<b>2016.04.08</b><br />
                     	<b>활동</b>&nbsp;&nbsp;<b>2016.04.08</b><br /> -->
                     </div>
                    </div>
                    
                    <c:if test="${fn:length(ArtistList) gt 7}">
                    <c:forEach var="m" items="${ArtistList }" begin="1" end="7">
                    <div class="col-xs-6 col-sm-3">
                          <div class="item">
                            <div class="pos-rlt">
                              <div class="item-overlay opacity r r-2x bg-black">
                                <div class="center text-center m-t-n">
                                  <a href="#"><i class="fa fa-play-circle i-2x"></i></a>
                                </div>
                              </div>
                              
                              <a href="#"><img src="upload/${m.artistimgurl }" alt="" class="r r-2x img-full" ></a>
                            </div>
                            <div class="padder-v">
                              <a href="#" class="text-ellipsis">${m.artistname }</a>
                              <c:if test="${m.artistactive eq 'true'}">
                              <a href="#" class="text-ellipsis text-xs text-muted">탈퇴</a>
                              </c:if>
                              <c:if test="${m.artistactive eq 'false'}">
                              <a href="#" class="text-ellipsis text-xs text-muted">현재 참여중</a>
                              </c:if>
                            </div>
                          </div>
                  	</div>
                    </c:forEach>
                    <div class="clearfix visible-xs"></div>
                    
                    </c:if>
                   </div>
                   
                   <hr />
                   
                    <div class="btn_link">
                   <!--  <script type="text/javascript">
                    alert('${Artist.artistid}'+"ddddd");
                    </script> -->
                    	<a href="javascript:goTotalArtistSearch('${Artist.artistid}')">아티스트 전체보기</a>
                    </div> --%>
                    
                   
                  
                </section>
                <footer class="footer bg-dark">
                  <div id="jp_container_N">
                    <div class="jp-type-playlist">
                      <div id="jplayer_N" class="jp-jplayer hide"></div>
                      <div class="jp-gui">
                        <div class="jp-video-play hide">
                          <a class="jp-video-play-icon">play</a>
                        </div>
                        <div class="jp-interface">
                          <div class="jp-controls">
                            <div><a class="jp-previous"><i class="icon-control-rewind i-lg"></i></a></div>
                            <div>
                              <a class="jp-play"><i class="icon-control-play i-2x"></i></a>
                              <a class="jp-pause hid"><i class="icon-control-pause i-2x"></i></a>
                            </div>
                            <div><a class="jp-next"><i class="icon-control-forward i-lg"></i></a></div>
                            <div class="hide"><a class="jp-stop"><i class="fa fa-stop"></i></a></div>
                            <div><a class="" data-toggle="dropdown" data-target="#playlist"><i class="icon-list"></i></a></div>
                            <div class="jp-progress hidden-xs">
                              <div class="jp-seek-bar dk">
                                <div class="jp-play-bar bg-info">
                                </div>
                                <div class="jp-title text-lt">
                                  <ul>
                                    <li></li>
                                  </ul>
                                </div>
                              </div>
                            </div>
                            <div class="hidden-xs hidden-sm jp-current-time text-xs text-muted"></div>
                            <div class="hidden-xs hidden-sm jp-duration text-xs text-muted"></div>
                            <div class="hidden-xs hidden-sm">
                              <a class="jp-mute" title="mute"><i class="icon-volume-2"></i></a>
                              <a class="jp-unmute hid" title="unmute"><i class="icon-volume-off"></i></a>
                            </div>
                            <div class="hidden-xs hidden-sm jp-volume">
                              <div class="jp-volume-bar dk">
                                <div class="jp-volume-bar-value lter"></div>
                              </div>
                            </div>
                            <div>
								<a class="jp-shuffle" title="shuffle">
								<i class="icon-shuffle text-muted"></i></a>
								<a class="jp-shuffle-off hid" title="shuffle off">
								<i class="icon-shuffle text-lt"></i></a>
							</div>
                            <div>
                              <a class="jp-repeat" title="repeat"><i class="icon-loop text-muted"></i></a>
                              <a class="jp-repeat-off hid" title="repeat off"><i class="icon-loop text-lt"></i></a>
                            </div>
                            <div class="hide">
                              <a class="jp-full-screen" title="full screen"><i class="fa fa-expand"></i></a>
                              <a class="jp-restore-screen" title="restore screen"><i class="fa fa-compress text-lt"></i></a>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="jp-playlist dropup" id="playlist">
                        <ul class="dropdown-menu aside-xl dker">
                          <!-- The method Playlist.displayPlaylist() uses this unordered list -->
                          <li class="list-group-item"></li>
                        </ul>
                      </div>
                      <div class="jp-no-solution hide">
                        <span>Update Required</span>
                        To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
                      </div>
                    </div>
                  </div>
                </footer>
              </section>
            </section>
            
          </section>
          <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
        </section>
      </section>
    </section> 
  </section>
  
  
  

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 style="color:red;"><i class="fa fa-plus"></i> <b style="font-size: 13pt;">Add to List</b></h4>
        </div>
        <div class="modal-body" style="padding-bottom: 6px; padding-left: 30px; padding-right: 30px;">
         <div id="playlist-list" class="m-b">
          <!-- <div id="myList" class="playlist-list-item padder-v b-b clearfix" pid="1698">
          
          </div> -->
         </div>
          <form role="form">
            <!-- <div class="form-group"> -->
              <!-- <label for="usrname"><span class="glyphicon glyphicon-user"></span> Username</label>
              <input type="text" class="form-control" id="usrname" placeholder="Enter email"> -->
            <!-- </div> -->
            <!-- <div class="form-group"> -->
             <!--  <label for="psw"><span class="glyphicon glyphicon-eye-open"></span> Password</label>
              <input type="text" class="form-control" id="psw" placeholder="Enter password"> -->
            <!-- </div> -->
            <!-- <div class="checkbox">
              <label><input type="checkbox" value="" checked>Remember me</label>
            </div> -->
            <!-- <button type="submit" class="btn btn-default btn-success btn-block"><span class="glyphicon glyphicon-off"></span> Login</button> -->
          	
          </form>
        </div>
        <div class="modal-body" id="save-text" style="padding-bottom: 20px; padding-top: 10px; display: block; padding-left: 30px; padding-right: 30px;" >
        	<div class="form-group">
        	<div class="col-xs-12 col-md-8">
        	<label for="usrname" style="font-size: 15pt; margin-bottom: 2%;"> Create New</label>
        	<br />
        		<label for="usrname" style="padding-bottom: 7px;"> Playlist title</label>
        		<br />
        		<!-- <input type="text" id="albumTitle" placeholder="My Album Title"> -->
        	</div><!-- form-group end -->
        	<div class="col-xs-3 col-md-1" style="margin-right:20px;">
        		<form id="goForm" method="POST" enctype="multipart/form-data">
	        		<input type="file" name="file" id="file" onchange="javascript:albumCoverUpload()" style="margin-top:13px; color: #fff !important; background-color: #6CF050;
	    			border-color: #6FF050; width: 60px; height: 30px; border-radius: 4px; display: none;">
    			</form>
        		<!-- <button type="" class="green-button" id="uploadButton" 
        		style="margin-top:13px; color: #fff !important; background-color: #6CF050;
    			border-color: #6FF050; width: 60px; height: 30px; border-radius: 4px;">Upload</button> -->
        	</div>
        	<div class="col-xs-3 col-md-2" style="margin-bottom:10px; margin-left: 15px;">
        		<a onclick="imageClick();"><img id="albumCover" src="" style="height:60px; width:60px; cursor: pointer;"></a>
        		<input type="hidden" id="savedFileHidden">
        		<input type="hidden" id="originalFileHidden">
        	</div>
        	<br />
        	<br />
        	</div>
        	<input type="text" class="form-control input-sm text-md" id="playlist-new-title">
        	<button type="button" class="red-button" 
        	id="saveButton">Save</button>
        </div>
        <!-- <div class="modal-footer">
          <button type="submit" class="btn btn-default btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
          <p>Not a member? <a href="#">Sign Up</a></p>
          <p>Forgot <a href="#">Password?</a></p>
        </div> -->
      </div>
    </div>
  </div> 
  
  
  <div class="modal fade" id="reportModal" role="dialog">
	<div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Report this song</h4>
        </div>
        
        <div class="modal-body">
				<div class="form-group">
					<h4 class="modal-title">Why are you reporting this song?: </h4>
					<input type="text" class="form-control round" id="reportReasonSong">
   							</div>
        </div>
        <div class="modal-footer">
      						<button type="button" id="report" class="btn btn-danger">Report</button>
        </div>
      </div>
      
    </div>
  </div>
  
  
  <div class="modal fade" id="reportAlbumModal" role="dialog">
				<div class="modal-dialog">

     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal">&times;</button>
         <h4 class="modal-title">Report this album</h4>
       </div>
       
       <div class="modal-body">
			<div class="form-group">
				<h4 class="modal-title">Why are you reporting this album?: </h4>
				<input type="text" class="form-control round" id="reportReasonAlbum">
  							</div>
       </div>
       <div class="modal-footer">
     						<button type="button" id="reportAlbum" class="btn btn-danger">Report</button>
       </div>
     </div>
     
   </div>
 </div>
  
  
  
  
<!--   <div class="modal fade" tabindex="-1" role="dialog" id="playlists">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="inline m-r-xs m-t-xs">&times;</span></button>
        <h4 class="modal-title font-bold">Add to playlist</h4>
      </div>
      <div class="modal-body">
        <div class="padder">
          <div id="playlist-list" class="m-b">

          </div>

          <div id="playlist-new">
            <h4 class="m-b-md">Create new</h4>
            <div class="form-group">
              <label>Playlist title</label>
              <input type="text" class="form-control input-sm text-md" id="playlist-new-title">
            </div>
            <button type="button" class="btn btn-sm btn-default m-b-md font-bold btn-danger" id="playlist-new-save">Save</button>
          </div>

          <div id="playlist-error" class="hide">
            <h4>Someting went wrong, try later</h4>
          </div>
        </div>
        <div class="hide" id="playlist-list-item">
          <div class="playlist-list-item padder-v b-b clearfix">
            <div class="pull-right m-t-xs">
              <button class="btn btn-sm btn-default" id="playlist-add">Add to playlist</button>
              <button class="btn btn-sm btn-danger" id="playlist-del" style="display:none">Added</button>
              <button class="btn btn-sm btn-link" id="playlist-remove" title="Remove"><i class="fa fa-remove"></i></button>
            </div>
            <a href="#" class="pull-left m-r" id="playlist-thumb"><img width="40"></a>
            <div class="clear">
              <a href="#" id="playlist-title" class="font-bold"></a>
              <div id="playlist-count" class="text-muted"></div>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>
 -->

 

  <!-- Bootstrap -->
  <script src="resources/js/bootstrap.js"></script>
  <!-- App -->
  <script src="resources/js/app.js"></script>  
  <script src="resources/js/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="resources/js/app.plugin.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/jquery.jplayer.min.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/add-on/jplayer.playlist.min.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/demo.js"></script>
  <script type="text/javascript">
	  $(document).ready(function(){
			$(".linkToPage").on("click",function(){
				var targetPage = $(this).attr("movePage")
				$(location).attr('href',targetPage);
			});
		});
  </script>
</body>
</html>