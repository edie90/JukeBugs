<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html class="app">
<head>  
  <meta charset=UTF-8"/>
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
  <link rel="stylesheet" href="resources/css2/aydvcar4t1.css" type="text/css" />
    <!--[if lt IE 9]>
    <script src="js/ie/html5shiv.js"></script>
    <script src="js/ie/respond.min.js"></script>
    <script src="js/ie/excanvas.js"></script>
  <![endif]-->
  <script type="text/javascript">
  
	  function radioGoArtistName(content) {
		  alert("aaa");
		  alert(content);
			location.href = "goTotalArtistNameSongList?content=" + content;
		}
	  
	  function radioGoSongName(content) {
		alert("bbb");
		alert(content);
			location.href = "goTotalSongNameSongList?content=" + content;
	  }
	  
	  function radioGoAlbumName(content) {
		alert("ccc");
		alert(content);
			location.href = "goTotalAlbumNameSongList?content=" + content;
	}
	  
  </script>
  <script src="resources/js/jquery-2.2.2.min.js"></script>
  
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
		
		});
  
  
	function likeClick(songId) {
		var aaa = $("#heart"+songId).attr('class');
		alert(aaa);
		if(aaa == 'fa fa-heart-o') {
			$('#heart'+songId).removeClass('fa fa-heart-o');
			$('#heart'+songId).addClass('fa fa-heart');
			alert(songId);
			/* $.ajax({
				url : "iLike"
				, method : "get"
				, data : "songId="+ songId
				, dataType : "json"
				, contentType: "application/json;charset=utf-8"
				, success : function(obj) {
					alert
				}
			}) */
		} else {
			$('#heart'+songId).removeClass('fa fa-heart');
			$('#heart'+songId).addClass('fa fa-heart-o');
		}
	}
  	
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
					
				}else {
					var str = '';
					$.each(obj, function(index, item) {
						alert("for-each문 시작");
						str += "<div class='playlist-list-item padder-v b-b clearfix'>";
						str += "<div class='row'>";
						str += "<div class='col-xs-12 .col-sm-6 .col-md-8' style='width: 78%;'>";
			            str += "<a href='#' id='playlist-title' class='font-bold'>" + item.makealbumname + "</a>";
			            str += "<div id='playlist-count' class='text-muted'>" + item.count + "</div>";
			            str += "</div>";
			            str += "<div class='.col-xs-6 .col-md-4'>";
			            str += "<button  id='playlist-add' style='display: inline-block; margin-top: 10px;' onclick='listInsertAlbum("+item.makealbumname+")'>Add to playlist</button>";
			            str += "<button id='playlist-remove' class='playlist-remove' title='Remove' onclick='removeAlbum("+item.makealbumname+")'><i class='fa fa-times' style='margin-top: 10px; margin-left: 12px;'></i></button>";
			            str += "</div>";
			            str += "</div>";
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
				alert(obj[0].userid);
				alert(obj.length);
					var str = '';
				$.each(obj, function(index, item) {
					alert("for-each문 시작");
					str += "<div class='playlist-list-item padder-v b-b clearfix'>";
					str += "<div class='row'>";
					str += "<div class='col-xs-12 .col-sm-6 .col-md-8' style='width: 78%;'>";
		            str += "<a href='#' id='playlist-title' class='font-bold' album-name='"+item.makealbumname+"'>" + item.makealbumname + "</a>";
		            str += "<div id='playlist-count' class='text-muted'>" + item.count + "</div>";
		            str += "</div>";
		            str += "<div class='.col-xs-6 .col-md-4'>";
		            str += "<button id='playlist-add' style='display: inline-block; margin-top: 10px;' ";
		            str +=  'onclick="listInsertAlbum('+"'"+item.makealbumname+"'"+','+"'"+songId+"'"+')">';
		            str += "Add to playlist</button>";
		            str += "<button id='playlist-remove' class='playlist-remove' title='Remove' onclick='removeAlbum("+item.makealbumname+")'><i class='fa fa-times' style='margin-top: 10px; margin-left: 12px;'></i></button>";
		            str += "</div>";
		            str += "</div>";
		            str += "</div>";
				});
				alert("성공");
				$('#playlist-list').html(str);
				$('#myModal').modal();
            		$('#saveButton').on('click',function() {
            			var title = $('#playlist-new-title').val();
            			alert("title : " + title);
            			alert("songid : " + songId);
            			$.ajax({
            				url : "myAlbumAdd"
            				, method : "get"
            				, data : "songId="+songId+"&title="+title
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
            		})
            		
				/* $('.playlist-remove').on('click',function() {
					alert("nnn");
					alert($('.font-bold').attr('album-name');
					alert("타이틀 :: "+title);
					$.ajax({
						url : "removeAlbum"
						, method : "get"
						, data : "title=" + title
						, dataType : "json"
						, contentType: "application/json;charset=utf-8"
						, success : function() {
							list();
						}
						, error : function(request,status,error){
        		        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					})
				}) */
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
			$.ajax({
				url : "selectAlbumAdd"
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
		 })
		 
	  	}else {
			alert("체크박스를 체크해주세요!");
			return;
		}
		
 	 });
	  
});
  
  function listInsertAlbum(title,songId) {
		alert("title :: " + title);
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
        <a href="#" class = "navbar-brand text-lt linkToPage" movePage = "main" >
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
      <c:if test="${sessionScope.loginId ne null}">
      
      
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
              	<c:if test="${sessionScope.loginId ne null}">
                <img src="upload/${sessionScope.userprofileimgurl }" style="height: 40px; width: 40px;">
                </c:if>
                <c:if test="${sessionScope.loginId eq null}">
                <img src="upload/noArtist.jpg" style="height: 40px; width: 40px;">
                </c:if>
              </span>
              ${sessionScope.userNick }<b class="caret"></b>
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
                <a href="logout" >Logout</a>
              </li>
            </ul>
          </li>
        </ul>
      </div>
      </c:if>      
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
                      <!-- <li>
                        <span class="arrow bottom hidden-nav-xs"></span>
                        <a href="#">Settings</a>
                      </li> -->
                      <li>
                        <a href="profile">Profile</a>
                      </li>
                      <li>
                       <!--  <a href="#">
                          <span class="badge bg-danger pull-right">3</span>
                          Notifications
                        </a> -->
                      </li>
                      <!-- <li>
                        <a href="docs.html"></a>
                      </li> -->
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
                  
                  
                  
                  <!-- //앨범 기본 정보 -->
					<!-- 수록곡 -->
                  <div class="row" style="z-index: 9999">
                  <div class="section_contin">
						<h2 class="font-thin m-b">Library </h2>
						
						
							
								<!-- 수록곡_CD번호 표시 -->
	<form id="frm" name="frm">
	<div class="tb_list d_song_list">
		<h4 class="title arr" style="margin-top: 30px;">History &nbsp;&nbsp;(${total })</h4>
		<div class="wrap_btn_tb">
		</div>
		<table border="1" style="width: 100%;" >
			<thead>
				<tr>
					<th scope="col" style="width: 25%; border-bottom-color: #DDE7E9;"><div class="wrap">Title</div></th>
					<th scope="col" class="t_left" style="width: 12%; border-bottom-color: #DDE7E9;"><div class="wrap">Artist</div></th>
					<th scope="col" class="t_left" style="width: 10%; border-bottom-color: #DDE7E9;"><div class="wrap" >Album</div></th>
					<th scope="col" class="t_left" style="width: 7%; border-bottom-color: #DDE7E9;"><div class="wrap right_none" >Date</div></th>
					<th scope="col" style="width: 4%; border-bottom-color: #DDE7E9;"><div class="wrap pd_none left" >Del</div></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="m" items="${logList}">
				<tr style="border-bottom-color: #DDE7E9;">
					<td style="text-align: left;">${m.songtitle }</td>
					<td style="text-align: left;"><a data-toggle="tooltip" class="white-tooltip" title="<img src='upload/${m.artistimgurl }' style='height:80px; width:80px;'>" style="color: #788188">${m.artistname }</a></td>
					<td style="text-align: left;"><a data-toggle="tooltip" class="white-tooltip" title="<img src='upload/${m.albumimgurl }' style='height:80px; width:80px;'>" style="color: #788188">${m.albumtitle }</a></td>
					<td style="text-align: left;">${m.accesslog }</td>
					<td style="text-align: left;"></td>
				</tr>
				</c:forEach>
			</tbody>
						
		</table>
		
		<%-- <table border="1">
			<thead>
				<tr>
					<th scope="col" style="width: 30%"><div class="wrap">Title</div></th>
					<th scope="col" class="t_left" style="width: 14%"><div class="wrap">Artist</div></th>
					<th scope="col" class="t_left" style="width: 13%"><div class="wrap" >Album</div></th>
					<th scope="col" class="t_left" style="width: 7%"><div class="wrap right_none" >Date</div></th>
					<th scope="col" style="width: 4%"><div class="wrap pd_none left" >Del</div></th>
				</tr>
			</thead>
			<tbody>
			 <c:forEach var="m" items="${searchBasedOnArtistNameSongList }" varStatus="status">
				<tr >
					<td><div class="wrap pd_none left">
						<input type="checkbox" title="Bag It Up 곡 선택" class="input_check" name="input_check" value="${m.songid }" />
					</div></td>
					<td class="no"><div class="wrap">${status.count }</div></td>
					<td class="t_left"><div class="wrap pd_none" style="padding-left: 15px">
						<div class="ellipsis" style="max-width:100%">
							<!-- <button type="button" class="btn_icon play" title="재생" onClick="melon.play.playSong('28010101',1934827);"><span class="odd_span">재생</span></button>
							<button type="button" class="btn_icon add" title="담기" onClick="melon.play.addPlayList('1934827');"><span class="odd_span">담기</span></button>
							<a href="javascript:melon.link.goSongDetail('1934827');" title="곡정보 보기" class="btn btn_icon_detail"><span class="odd_span">Bag It Up 상세정보 페이지 이동</span></a> -->
							
							<a href="javascript:melon.play.playSong('28010101',1934827);" title="Bag It Up">${m.songtitle }</a>
						</div>
					</div></td>
					<td class="t_left"><div class="wrap">
						<div id="artistName" class="ellipsis" style="max-width:188px">
							<a href="javascript:melon.link.goArtistDetail('104369');" title="Oasis - 페이지 이동" class="fc_mgray">${m.artist}</a><span class="checkEllipsis" style="display:none"><a href="javascript:melon.link.goArtistDetail('104369');" title="Oasis - 페이지 이동" class="fc_mgray">${m.artist }</a></span>
						</div>
						
					</div></td>
					<td class="t_left"><div class="wrap">
						<div id="artistName" class="ellipsis" style="max-width:188px">
							<a href="javascript:melon.link.goArtistDetail('104369');" title="Oasis - 페이지 이동" class="fc_mgray">${m.albumtitle}</a><span class="checkEllipsis" style="display:none"><a href="javascript:melon.link.goArtistDetail('104369');" title="Oasis - 페이지 이동" class="fc_mgray">${m.albumtitle }</a></span>
						</div>
						
					</div></td>
					<td class="t_left"><div class="wrap right_none">
						<!-- <button type="button" class="btn_icon like" title="좋아요" data-song-no="1934827" data-song-menuId="28010101"> -->
						<i id="heart${m.songid }" class="fa fa-heart-o" onclick="javascript:likeClick('${m.songid }')"></i>
						<!-- <i id="redheart" class="fa fa-heart"></i> -->
							<!-- <span class="odd_span"></span> -->
							<!-- <span class="cnt"><span class="none"></span> 269</span> -->
						<!-- </button> -->
					</div></td>
					<td><div class="wrap pd_none left">
						<button type="button" id="xxx" class="btn_icon play" title="재생" song-id="${m.songid }" ><span class="odd_span">재생</span></button>
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
					</div></td>
				</tr>
			 </c:forEach>
			 
			</tbody>
		</table> --%>
	</div>
	<br />
	</form>

						
					</div>
                  </div>      
          <div class="paging-position" style="margin-left: 37%">          
           <input type="hidden" id="currentPage" value="${pagenavi.currentPage}">
            <!-- 페이징 처리 -->
             <ul class="pagination pagination"> <!-- **************  -->
              
              <li><a href="logInfo?currentPage=${pagenavi.currentPage-1}"><i class="fa fa-chevron-left"></i></a></li>
              
               <c:forEach var="counter" begin="${pagenavi.startPageGroup}" end="${pagenavi.endPageGroup}">
               
               	<c:choose>
             	  	 	<c:when test="${pagenavi.currentPage == counter}">
             			 	<li class="active"><a href="logInfo?currentPage=${counter}">${counter}</a></li> <!-- **** -->
               	 	</c:when>
              		 	<c:otherwise>
							<li><a href="logInfo?currentPage=${counter}">${counter}</a></li>                        
               	 	</c:otherwise>
               	</c:choose>
               	
               </c:forEach>
               
              <li><a href="logInfo?currentPage=${pagenavi.currentPage+1}"><i class="fa fa-chevron-right"></i></a></li>
              
            </ul>
    	   </div>


                  
                  	
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
                              <a class="jp-shuffle" title="shuffle"><i class="icon-shuffle text-muted"></i></a>
                              <a class="jp-shuffle-off hid" title="shuffle off"><i class="icon-shuffle text-lt"></i></a>
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
            <!-- side content -->
            <!-- <aside class="aside-md bg-light dk" id="sidebar">
              <section class="vbox animated fadeInRight">
                <section class="w-f-md scrollable hover">
                  <h4 class="font-thin m-l-md m-t">Connected</h4>
                  <ul class="list-group no-bg no-borders auto m-t-n-xxs">
                    <li class="list-group-item">
                      <span class="pull-left thumb-xs m-t-xs avatar m-l-xs m-r-sm">
                        <img src="resources/images/a1.png" alt="..." class="img-circle">
                        <i class="on b-light right sm"></i>
                      </span>
                      <div class="clear">
                        <div><a href="#">Chris Fox</a></div>
                        <small class="text-muted">New York</small>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <span class="pull-left thumb-xs m-t-xs avatar m-l-xs m-r-sm">
                        <img src="resources/images/a2.png" alt="...">
                        <i class="on b-light right sm"></i>
                      </span>
                      <div class="clear">
                        <div><a href="#">Amanda Conlan</a></div>
                        <small class="text-muted">France</small>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <span class="pull-left thumb-xs m-t-xs avatar m-l-xs m-r-sm">
                        <img src="resources/images/a3.png" alt="...">
                        <i class="busy b-light right sm"></i>
                      </span>
                      <div class="clear">
                        <div><a href="#">Dan Doorack</a></div>
                        <small class="text-muted">Hamburg</small>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <span class="pull-left thumb-xs m-t-xs avatar m-l-xs m-r-sm">
                        <img src="resources/images/a4.png" alt="...">
                        <i class="away b-light right sm"></i>
                      </span>
                      <div class="clear">
                        <div><a href="#">Lauren Taylor</a></div>
                        <small class="text-muted">London</small>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <span class="pull-left thumb-xs m-t-xs avatar m-l-xs m-r-sm">
                        <img src="resources/images/a5.png" alt="..." class="img-circle">
                        <i class="on b-light right sm"></i>
                      </span>
                      <div class="clear">
                        <div><a href="#">Chris Fox</a></div>
                        <small class="text-muted">Milan</small>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <span class="pull-left thumb-xs m-t-xs avatar m-l-xs m-r-sm">
                        <img src="resources/images/a6.png" alt="...">
                        <i class="on b-light right sm"></i>
                      </span>
                      <div class="clear">
                        <div><a href="#">Amanda Conlan</a></div>
                        <small class="text-muted">Copenhagen</small>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <span class="pull-left thumb-xs m-t-xs avatar m-l-xs m-r-sm">
                        <img src="resources/images/a7.png" alt="...">
                        <i class="busy b-light right sm"></i>
                      </span>
                      <div class="clear">
                        <div><a href="#">Dan Doorack</a></div>
                        <small class="text-muted">Barcelona</small>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <span class="pull-left thumb-xs m-t-xs avatar m-l-xs m-r-sm">
                        <img src="resources/images/a8.png" alt="...">
                        <i class="away b-light right sm"></i>
                      </span>
                      <div class="clear">
                        <div><a href="#">Lauren Taylor</a></div>
                        <small class="text-muted">Tokyo</small>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <span class="pull-left thumb-xs m-t-xs avatar m-l-xs m-r-sm">
                        <img src="resources/images/a9.png" alt="..." class="img-circle">
                        <i class="on b-light right sm"></i>
                      </span>
                      <div class="clear">
                        <div><a href="#">Chris Fox</a></div>
                        <small class="text-muted">UK</small>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <span class="pull-left thumb-xs m-t-xs avatar m-l-xs m-r-sm">
                        <img src="resources/images/a1.png" alt="...">
                        <i class="on b-light right sm"></i>
                      </span>
                      <div class="clear">
                        <div><a href="#">Amanda Conlan</a></div>
                        <small class="text-muted">Africa</small>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <span class="pull-left thumb-xs m-t-xs avatar m-l-xs m-r-sm">
                        <img src="resources/images/a2.png" alt="...">
                        <i class="busy b-light right sm"></i>
                      </span>
                      <div class="clear">
                        <div><a href="#">Dan Doorack</a></div>
                        <small class="text-muted">Paris</small>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <span class="pull-left thumb-xs m-t-xs avatar m-l-xs m-r-sm">
                        <img src="resources/images/a3.png" alt="...">
                        <i class="away b-light right sm"></i>
                      </span>
                      <div class="clear">
                        <div><a href="#">Lauren Taylor</a></div>
                        <small class="text-muted">Brussels</small>
                      </div>
                    </li>
                  </ul>
                </section>
                <footer class="footer footer-md bg-black">
                  <form class="" role="search">
                    <div class="form-group clearfix m-b-none">
                      <div class="input-group m-t m-b">
                        <span class="input-group-btn">
                          <button type="submit" class="btn btn-sm bg-empty text-muted btn-icon"><i class="fa fa-search"></i></button>
                        </span>
                        <input type="text" class="form-control input-sm text-white bg-empty b-b b-dark no-border" placeholder="Search members">
                      </div>
                    </div>
                  </form>
                </footer>
              </section>              
            </aside> -->
            <!-- / side content -->
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
        	<label for="usrname" style="font-size: 15pt; margin-bottom: 2%;"> Create New</label>
        	<br />
        		<label for="usrname" style="padding-bottom: 7px;"> Playlist title</label>
        		<br />
        		<!-- <input type="text" id="albumTitle" placeholder="My Album Title"> -->
        		<input type="text" class="form-control input-sm text-md" id="playlist-new-title">
        	</div>
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