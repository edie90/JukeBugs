(function() {
	var WEB_PLAYER_POPUP;
	var WEB_PLAYER_CTRL;
	var WEB_PLAYER_STATE = false;
	var WEB_PLAYER_LIST = [];
	var WEB_PLAYER_CNT = 0;
			MELON.WEBSVC.POC = {
				popupErrorMsg : "\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주셔야만 팝업창이보입니다.\n※ 윈도우 XP SP2 사용자일 경우에는 브라우저 상단의 노란색[알림표시줄]에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다.\n",
				melonDomain : "melon.com",
				httpMelonWww : "http://www.melon.com",
				httpMelonLive : "http://live.melon.com",
				httpMelonVod : "http://vod.melon.com",
				setPocId : function() {
					var pocId = getCookie("POC");
					if (pocId == "" || typeof pocId == "undefined") {
						$.getJSON("/common/useragent_info.json",
								function(data) {
									setCookie("POC", data.pocId, 0, "/",
											MELON.WEBSVC.POC.melonDomain)
								})
					}
				},
				getPocId : function() {
					var pocId = getCookie("POC");
					return pocId
				},
				isTablet : function() {
					var userAgent = navigator.userAgent;
					var isTablet = false;
					if (userAgent.indexOf("Android") > 0
							&& userAgent.indexOf("Mobile") == -1) {
						isTablet = true
					} else {
						if (userAgent.indexOf("iPad") > 0) {
							isTablet = true
						}
					}
					return isTablet
				},
				tabletGuidePop : function() {
					window
							.open(
									"http://www.melon.com/error_page/error_tabletTypeB.html",
									"tabletPopTypeB",
									"scrollbars=no, resizable=no, location=no, width=560, height=273")
				},
				play : {
					playSong : function(menuId, songIds, itemFlag) {
						if (MELON.WEBSVC.POC.isTablet()) {
							MELON.WEBSVC.POC.tabletGuidePop();
							return
						}
						if (songIds == null || songIds == "") {
							alert("대표곡 정보를 준비중입니다.");
							return
						}
						var isMac = (navigator.userAgent.indexOf("Mac") > 0);
						if (isMac) {
							MELON.WEBSVC.POC.play.goWebplyer(menuId, songIds,
									itemFlag)
						} else {
							if (typeof itemFlag == "undefined") {
								itemFlag = 1
							}
							if (isMelonLogin()) {
								var itemFlagArray = new Array();
								var itemIdArray = new Array();
								if (songIds instanceof Array) {
									var tempArray = songIds;
									for (var i = 0; i < tempArray.length; i++) {
										if (tempArray[i] != "") {
											itemFlagArray[i] = itemFlag;
											itemIdArray[i] = tempArray[i]
										}
									}
								} else {
									itemFlagArray[0] = itemFlag;
									itemIdArray[0] = songIds
								}
								player.ocxPlay(menuId, itemFlagArray,
										itemIdArray)
							} else {
								MELON.WEBSVC.POC.play.goWebplyer(menuId,
										songIds, itemFlag)
							}
						}
					},
					playHighMv : function(menuId, mvId, itemFlag) {
						if (mvId == null || mvId == "") {
							alert("occur error.");
							return
						}
						var isMac = (navigator.userAgent.indexOf("Mac") > 0);
						if (isMac) {
							alert("맥에서는 고화질 플레이어 준비중~")
						} else {
							if (typeof itemFlag == "undefined") {
								itemFlag = 21
							}
							if (isMelonLogin()) {
								var itemFlagArray = new Array();
								var itemIdArray = new Array();
								itemFlagArray[0] = itemFlag;
								itemIdArray[0] = mvId;
								player.ocxPlay(menuId, itemFlagArray,
										itemIdArray)
							} else {
								MELON.WEBSVC.POC.login.loginPopupLayerd("");
								return
							}
						}
					},
					playFormSong : function(menuId, formId, checkBoxName) {
						if (MELON.WEBSVC.POC.isTablet()) {
							MELON.WEBSVC.POC.tabletGuidePop();
							return
						}
						var songIds = new Array();
						if (typeof checkBoxName == "undefined") {
							checkBoxName = "input_check"
						}
						$("#" + formId).find(
								"input[name='" + checkBoxName + "']:checked")
								.each(function() {
									if (!isNaN(this.value)) {
										songIds.push($(this).val())
									}
								});
						if (songIds.length == 0) {
							alert("곡을 선택해 주세요.")
						} else {
							MELON.WEBSVC.POC.play.playSong(menuId, songIds)
						}
					},
					playAlbum : function(menuId, albumId) {
						if (MELON.WEBSVC.POC.isTablet()) {
							MELON.WEBSVC.POC.tabletGuidePop();
							return
						}
						var isMac = (navigator.userAgent.indexOf("Mac") > 0);
						if (isMac) {
							MELON.WEBSVC.POC.play.goWebplyerByAlbum(menuId,
									albumId)
						} else {
							if (isMelonLogin()) {
								itemFlagArray = new Array();
								itemIdArray = new Array();
								itemFlagArray[0] = 2;
								itemIdArray[0] = albumId;
								player.ocxPlay(menuId, itemFlagArray,
										itemIdArray)
							} else {
								MELON.WEBSVC.POC.play.goWebplyerByAlbum(menuId,
										albumId)
							}
						}
					},
					playPlayList : function(menuId, plylstId, playListType,
							targetMemberKey) {
						if (MELON.WEBSVC.POC.isTablet()) {
							MELON.WEBSVC.POC.tabletGuidePop();
							return
						}
						var isMac = (navigator.userAgent.indexOf("Mac") > 0);
						if (typeof targetMemberKey == "undefined") {
							targetMemberKey = getMemberKey() == "" ? 0
									: getMemberKey()
						}
						if (isMac) {
							MELON.WEBSVC.POC.play.goWebplyerByPlayList(menuId,
									plylstId)
						} else {
							if (isMelonLogin()) {
								var itemFlag;
								switch (playListType) {
								case "dj":
									itemFlag = 6;
									break;
								case "server":
									itemFlag = 23;
									break;
								case "artist":
									itemFlag = 26;
									break;
								default:
									itemFlag = 6
								}
								itemFlagArray = new Array();
								itemIdArray = new Array();
								itemFlagArray[0] = itemFlag;
								itemIdArray[0] = plylstId;
								player.ocxPlay(menuId, itemFlagArray,
										itemIdArray, targetMemberKey)
							} else {
								MELON.WEBSVC.POC.play.goWebplyerByPlayList(
										menuId, plylstId)
							}
						}
					},
					playFormStudy : function(menuId, formId, checkBoxName) {
						if (MELON.WEBSVC.POC.isTablet()) {
							MELON.WEBSVC.POC.tabletGuidePop();
							return
						}
						var songIds = new Array();
						if (typeof checkBoxName == "undefined") {
							checkBoxName = "input_check"
						}
						$("#" + formId).find(
								"input[name=" + checkBoxName + "]:checked")
								.each(function() {
									if (!isNaN(this.value)) {
										songIds.push($(this).val())
									}
								});
						if (songIds.length == 0) {
							alert("강의를 선택해 주세요.")
						} else {
							if (isMelonLogin()) {
								MELON.WEBSVC.POC.play.playSong(menuId, songIds,
										4)
							} else {
								alert("어학 컨텐츠는 1분 미리듣기가 제공되지 않습니다.\n              로그인 후 이용해 주세요");
								return
							}
						}
					},
					playStudy : function(menuId, songId) {
						if (MELON.WEBSVC.POC.isTablet()) {
							MELON.WEBSVC.POC.tabletGuidePop();
							return
						}
						if (isMelonLogin()) {
							MELON.WEBSVC.POC.play.playSong(menuId, songId, 4)
						} else {
							alert("어학 컨텐츠는 1분 미리듣기가 제공되지 않습니다.\n              로그인 후 이용해 주세요");
							return
						}
					},
					playMv : function(menuId, mvId) {
						alert("준비중 재생ID : " + mvId)
					},
					goWebplyer : function(menuId, songIds, contsType) {
						try {
							console.log(" >> " + WEB_PLAYER_STATE)
						} catch (e) {
						}
						if (WEB_PLAYER_STATE) {
							return
						}
						if (typeof contsType === "undefined"
								|| contsType.length < 1 || contsType == null
								|| contsType == 1) {
							contsType = "S"
						}
						if (contsType == 4) {
							contsType = "E"
						}
						MELON.WEBSVC.POC.play.webPlayerInit(menuId, songIds,
								contsType)
					},
					webPlayerInit : function(menuId, songIds, contsType) {
						try {
							console.log(" webPlayerInit In > ")
						} catch (e) {
						}
						WEB_PLAYER_LIST = [];
						if (typeof songIds === "number"
								|| typeof songIds === "string") {
							WEB_PLAYER_LIST[0] = [ songIds, "|^", menuId, "|^",
									contsType ].join("")
						} else {
							$.each(songIds, function(i, v) {
								WEB_PLAYER_LIST[i] = [ v, "|^", menuId, "|^",
										contsType ].join("")
							})
						}
						var ua = navigator.userAgent;
						if (_FLASH_INSTALLED == true
								|| _FLASH_INSTALLED == "true") {
							WEB_PLAYER_CTRL = $("#mpCtrl")[0];
							if (!WEB_PLAYER_CTRL || WEB_PLAYER_CTRL.length == 0) {
								var ctrl;
								var isMSIE = false;
								var swfParam = "";
								if (ua.indexOf("rv:11.0") > -1
										|| ua.indexOf("MSIE") > -1) {
									isMSIE = true
								}
								if (isMSIE) {
									swfParam = "?init=MELON.WEBSVC.POC.play.webPlayerCtrlInit&browserName="
											+ getBrowserName();
									ctrl = [
											'<object id="mpCtrl" height="1" width="1" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"  type="application/x-shockwave-flash">',
											'<param name="movie" value="http://www.melon.com/resource/script/player/melonCtrl.swf'
													+ swfParam + '">',
											'<param name="wmode" value="opaque"/>',
											'<param name="allowScriptAccess" value="always" />',
											'<param name="allowFullScreen" value="true" />',
											'<param name="allowNetworking" value="all" />',
											"</object>" ].join("")
								} else {
									if (ua.indexOf("Firefox") > -1) {
										ctrl = [
												'<object id="mpCtrl" height="1" width="1" data="http://www.melon.com/resource/script/player/melonCtrl.swf'
														+ swfParam
														+ '" type="application/x-shockwave-flash">',
												'<param name="wmode" value="window"/>',
												'<param name="allowScriptAccess" value="always" />',
												'<param name="allowFullScreen" value="true" />',
												'<param name="allowNetworking" value="all" />',
												"</object>" ].join("")
									} else {
										ctrl = [
												'<object id="mpCtrl" height="1" width="1" type="application/x-shockwave-flash">',
												'<param name="movie" value="http://www.melon.com/resource/script/player/melonCtrl.swf'
														+ swfParam + '">',
												'<param name="wmode" value="window"/>',
												'<param name="allowScriptAccess" value="always" />',
												'<param name="allowFullScreen" value="true" />',
												'<param name="allowNetworking" value="all" />',
												"</object>" ].join("")
									}
								}
								$("body")
										.append(
												"<div id='mpController' style='width:1px; height:1px;'></div>");
								$("#mpController").html(ctrl);
								if (!isMSIE) {
									var callback = {};
									callback.init = "MELON.WEBSVC.POC.play.webPlayerCtrlInit";
									callback.browserName = getBrowserName();
									setTimeout(
											MELON.WEBSVC.POC.play.webPlayerCtrlParam,
											200, callback)
								}
							} else {
								MELON.WEBSVC.POC.play.webPlayerCtrlInit()
							}
						} else {
							webPlayerFlashAlert();
							return
						}
					},
					webPlayerCtrlParam : function(param) {
						var player = document.getElementById("mpCtrl");
						if (player && player.setParam) {
							WEB_PLAYER_CNT = 0;
							player.setParam(param)
						} else {
							if (WEB_PLAYER_CNT > 5) {
								WEB_PLAYER_CNT = 0;
								alert("웹플레이어 구동 중 에러가 발생했습니다.");
								return
							} else {
								WEB_PLAYER_CNT++;
								setTimeout(
										MELON.WEBSVC.POC.play.webPlayerCtrlParam,
										200, param)
							}
						}
					},
					webPlayerCtrlInit : function() {
						try {
							console.log(" webPlayerCtrlInit In > ")
						} catch (e) {
						}
						try {
							WEB_PLAYER_CTRL = document.getElementById("mpCtrl");
							WEB_PLAYER_CTRL.setList({
								list : WEB_PLAYER_LIST
							});
							WEB_PLAYER_CTRL
									.playerCheck("MELON.WEBSVC.POC.play.webPlayerLoad")
						} catch (e) {
							alert("웹플레이어 구동 중 에러가 발생했습니다.");
							return
						}
					},
					webPlayerLoad : function(openFlag) {
						try {
							console.log(" webPlayerLoad In > " + openFlag)
						} catch (e) {
						}
						WEB_PLAYER_STATE = false;
						if (!openFlag) {
							var url = "http://www.melon.com/webplayer/index.htm";
							var pW = 730;
							var pH = 525;
							var pL = parseInt((window.screen.width - pW) / 2);
							var pT = parseInt((window.screen.height - pH) / 2);
							var pProp = "width=" + pW + ",height=" + pH
									+ ",scrollbars=yes,resizable=0,left=" + pL
									+ ",top=" + pT
									+ ",directories=no,status=no,menubar=no";
							var ua = navigator.userAgent;
							if (ua.indexOf("MSIE 6") > 0
									|| ua.indexOf("MSIE 7") > 0
									|| ua.indexOf("MSIE 8") > 0
									|| ua.indexOf("Edge") > 0) {
								WEB_PLAYER_POPUP = window.open("",
										"WEB_PLAYER_POPUP", pProp);
								var f = document.createElement("FORM");
								f.action = url;
								f.method = "get";
								f.target = "WEB_PLAYER_POPUP";
								document.body.appendChild(f);
								f.submit()
							} else {
								if (ua.indexOf("Safari") > 0
										&& ua.indexOf("Mac") > 0) {
									WEB_PLAYER_POPUP = window.open(url,
											"WEB_PLAYER_POPUP", pProp)
								} else {
									WEB_PLAYER_POPUP = window.open("",
											"WEB_PLAYER_POPUP", pProp);
									try {
										WEB_PLAYER_POPUP.location.href = url
									} catch (err) {
									}
								}
							}
							if (!WEB_PLAYER_POPUP) {
								alert("차단된 팝업창을 허용해 주세요.")
							}
						}
						if (window.focus) {
							setTimeout(function() {
								try {
									WEB_PLAYER_POPUP.focus()
								} catch (err) {
								}
							}, 1000)
						}
					},
					goWebplyerByAlbum : function(menuId, albumId) {
						MELON.WEBSVC.POC.play.goWebplyer(menuId, albumId, "A")
					},
					goWebplyerByPlayList : function(menuId, plylstId) {
						MELON.WEBSVC.POC.play.goWebplyer(menuId, plylstId, "P")
					},
					playSmartRadio : function(menuId, playOpt) {
						if (MELON.WEBSVC.POC.isTablet()) {
							MELON.WEBSVC.POC.tabletGuidePop();
							return
						}
						var isMac = (navigator.userAgent.indexOf("Mac") > 0);
						if (isMac) {
							MELON.WEBSVC.POC.play.goWeplyerSmartRadio(playOpt)
						} else {
							player
									.melonplayerPlay(menuId, "smart", "",
											playOpt)
						}
					},
					goWeplyerSmartRadio : function(playOpt) {
						if (playOpt != undefined && playOpt != null
								&& playOpt != "") {
							var pW = 352;
							var pH = 525;
							var pL = parseInt((window.screen.width - pW) / 2);
							var pT = parseInt((window.screen.height - pH) / 2);
							var pProp = "width=" + pW + ",height=" + pH
									+ ",left=" + pL + ",top=" + pT
									+ ",directories=no,status=no,menubar=no";
							playOpt = playOpt.replace(//gi, "^");
							var ua = navigator.userAgent;
							if (ua.indexOf("MSIE 6") > 0
									|| ua.indexOf("MSIE 7") > 0
									|| ua.indexOf("MSIE 8") > 0) {
								WEB_PLAYER_POPUP = window.open("",
										"WEB_PLAYER_POPUP", pProp);
								var f = document.createElement("FORM");
								var url = "http://www.melon.com/webplayer/smartRadio.htm?playOpt="
										+ playOpt;
								f.action = url;
								f.method = "get";
								f.target = "WEB_PLAYER_POPUP";
								var indexQM = url.indexOf("?");
								if (indexQM >= 0) {
									var params = url.substring(indexQM + 1)
											.split("&");
									for (var i = 0; i < params.length; i++) {
										var keyValuePair = params[i].split("=");
										var input = document
												.createElement("INPUT");
										input.type = "hidden";
										input.name = keyValuePair[0];
										input.value = keyValuePair[1];
										f.appendChild(input)
									}
								}
								document.body.appendChild(f);
								f.submit()
							} else {
								if (ua.indexOf("Safari") > 0
										&& ua.indexOf("Mac") > 0) {
									WEB_PLAYER_POPUP = window.open(
											"http://www.melon.com/webplayer/smartRadio.htm?playOpt="
													+ playOpt,
											"WEB_PLAYER_POPUP", pProp)
								} else {
									WEB_PLAYER_POPUP = window.open("",
											"WEB_PLAYER_POPUP", pProp);
									WEB_PLAYER_POPUP.location.href = "http://www.melon.com/webplayer/smartRadio.htm?playOpt="
											+ playOpt
								}
							}
							if (!WEB_PLAYER_POPUP) {
								alert("차단된 팝업창을 허용해 주세요.")
							} else {
								if (window.focus) {
									setTimeout(function() {
										try {
											WEB_PLAYER_POPUP.focus()
										} catch (err) {
										}
									}, 1000)
								}
							}
						} else {
							alert("곡을 선택해 주세요.")
						}
					},
					addPlayList : function(songId) {
						if (!MELON.WEBSVC.POC.login.isMelonLogin()) {
							MELON.WEBSVC.POC.login.loginPopupLayerd("");
							return
						}
						if (songId == "" || songId == undefined) {
							alert("곡을 선택해 주세요.");
							return
						}
						var url = "/mymusic/common/popup/mymusiccommon_addPlaylistPopUp.htm";
						var title = "addPlayListFrm";
						MELON.WEBSVC.openPopup("", 560, 730, {
							target : title,
							scrollbars : "no"
						}, "center", title);
						var $form = $("form#addPlayList");
						$form.remove();
						$form = $("<form></form>");
						$form.attr("action", url);
						$form.attr("method", "post");
						$form.attr("target", title);
						$form.attr("id", "addPlayList");
						$form.hide();
						$form.appendTo("body");
						var inputSongId = $('<input type="hidden" name="input_check" value="'
								+ songId + '">');
						$form.append(inputSongId);
						$form.submit()
					},
					addFormPlayList : function(formId) {
						if (!MELON.WEBSVC.POC.login.isMelonLogin()) {
							MELON.WEBSVC.POC.login.loginPopupLayerd("");
							return
						}
						var songList = new Array();
						$("#" + formId).find(".input_check:checked").each(
								function() {
									if (!isNaN($(this).val())) {
										songList.push($(this).val())
									}
								});
						if (songList == "") {
							alert("곡을 선택해 주세요.");
							return
						}
						var songCnt = $("#" + formId).find(
								"input:checkbox[name=input_check]:checked").length;
						if (songCnt == 0) {
							alert("곡을 선택해 주세요.");
							return
						}
						if (songCnt > 500) {
							alert("최대 500곡까지 담을 수 있습니다.\n곡 수를 확인하시고 다시 선택해주세요.");
							return
						}
						var url = "/mymusic/common/popup/mymusiccommon_addPlaylistPopUp.htm";
						var title = "addPlayList";
						MELON.WEBSVC.openPopup("", 560, 730, {
							target : title,
							scrollbars : "no"
						}, "center", title);
						$("#" + formId).attr("target", title);
						$("#" + formId).attr("action", url);
						$("#" + formId).attr("method", "post");
						$("#" + formId).submit()
					},
					ocxPlay : function(menuId, itemFlags, itemIds) {
						player.ocxPlay(menuId, itemFlags, itemIds)
					},
					melonplayerActualPlay : function(params) {
						player.melonplayerActualPlay(params)
					},
					melonplayerActualPlaySocket : function(menuId, itemFlags,
							itemList) {
						player.melonplayerActualPlaySocket(menuId, itemFlags,
								itemList)
					},
					melon_ocx_message : function(PLAYER_RETURN) {
						return player.melon_ocx_message(PLAYER_RETURN)
					},
					getMelonPlayerObject : function() {
						return melonPlayerFunc.getMelonPlayerObject()
					},
					browser : function() {
						return melonPlayerFunc.browser()
					},
					chkMelonPlayerObject : function() {
						return melonPlayerFunc.chkMelonPlayerObject()
					},
					melonplayerPlay : function(menuId, itemFlags, itemIds,
							playList) {
						player.melonplayerPlay(menuId, itemFlags, itemIds,
								playList)
					}
				},
				link : {
					goSongDetail : function(songId) {
						if (typeof songId == "undefined") {
							return
						}
						location.href = "http://www.melon.com/song/detail.htm?songId="
								+ songId
					},
					goAlbumDetail : function(albumId) {
						if (typeof albumId == "undefined") {
							return
						}
						location.href = "http://www.melon.com/album/detail.htm?albumId="
								+ albumId
					},
					goMvDetail : function(menuId, mvId, contentsType,
							mvTypeCode) {
						if (typeof mvId == "undefined") {
							return
						}
						var action = MELON.WEBSVC.POC.httpMelonVod;
						if (typeof mvTypeCode != "undefined"
								&& mvTypeCode == "MV0007") {
							action = MELON.WEBSVC.POC.httpMelonLive
						}
						var $form = $("<form></form>");
						var $menId = $('<input type="hidden" name="menuId" value="'
								+ menuId + '"/>');
						if (contentsType == "song") {
							action += "/video/detail.htm?songId=" + mvId
						} else {
							action += "/video/detail.htm?mvId=" + mvId
						}
						action += "&menuId=" + menuId;
						location.href = action
					},
					goArtistDetail : function(artistId, tabIndex) {
						if (typeof artistId == "undefined") {
							return
						}
						switch (tabIndex != null ? tabIndex.toString() : null) {
						case "1":
							location.href = "http://www.melon.com/artist/timeline.htm?artistId="
									+ artistId;
							break;
						case "2":
							location.href = "http://www.melon.com/artist/detail.htm?artistId="
									+ artistId;
							break;
						case "3":
							location.href = "http://www.melon.com/artist/song.htm?artistId="
									+ artistId;
							break;
						case "4":
							location.href = "http://www.melon.com/artist/album.htm?artistId="
									+ artistId;
							break;
						case "5":
							location.href = "http://www.melon.com/artist/video.htm?artistId="
									+ artistId;
							break;
						case "6":
							location.href = "http://www.melon.com/artist/photo.htm?artistId="
									+ artistId;
							break;
						case "7":
							location.href = "http://www.melon.com/artist/recmlist.htm?artistId="
									+ artistId;
							break;
						case "8":
							location.href = "http://www.melon.com/artist/concert.htm?artistId="
									+ artistId;
							break;
						case "9":
							location.href = "http://www.melon.com/artist/product.htm?artistId="
									+ artistId;
							break;
						case "10":
							location.href = "http://www.melon.com/artist/fan.htm?artistId="
									+ artistId;
							break;
						case "11":
							location.href = "http://www.melon.com/artist/review.htm?artistId="
									+ artistId;
							break;
						case "12":
							location.href = "http://www.melon.com/artist/shop.htm?artistId="
									+ artistId;
							break;
						default:
							location.href = "http://www.melon.com/artist/timeline.htm?artistId="
									+ artistId;
							break
						}
					},
					goProgramDetail : function(menuSeq, progSeq) {
						if (typeof menuSeq == "undefined"
								|| typeof progSeq == "undefined") {
							return
						}
						if (menuSeq == "2") {
							location.href = "http://www.melon.com/tv/mv/index.htm"
						} else {
							location.href = "http://www.melon.com/tv/menu/index.htm?menuSeq="
									+ menuSeq + "&progSeq=" + progSeq
						}
					},
					goThemaDetail : function(themaId) {
						if (typeof themaId == "undefined") {
							return
						}
						location.href = "http://www.melon.com/tv/thema/inform.htm?progSeq="
								+ themaId
					},
					goMyMusic : function(memberKey) {
						if (typeof memberKey == "undefined" || memberKey < 1) {
							alert("정상적인 접근이 아닙니다.");
							location.href = "http://www.melon.com";
							return
						}
						location.href = "http://www.melon.com/mymusic/main/mymusicmainother_list.htm?memberKey="
								+ memberKey
					},
					goPerfDetail : function(artistId, perfId) {
						if (typeof artistId == "undefined"
								|| typeof perfId == "undefined") {
							return
						}
						location.href = "http://www.melon.com/artist/concertDetail.htm?artistId="
								+ artistId + "&perfId=" + perfId
					},
					goMessage : function() {
						location.href = "http://www.melon.com/mymusic/messagepresent/mymusicmessage_list.htm"
					},
					goReturnMessage : function(memberkey, menuId) {
						if (typeof memberkey == "undefined" || memberkey < 1) {
							alert("정상적인 접근이 아닙니다.");
							window.location = "http://www.melon.com";
							return
						}
						if (!MELON.WEBSVC.POC.login.isMelonLogin()) {
							MELON.WEBSVC.POC.login.loginPopupLayerd("");
							return
						}
						var ua = navigator.userAgent.toLocaleLowerCase();
						$
								.get(
										"http://www.melon.com/mymusic/friend/mymusicfriend_listFriendMemberStatus.json",
										{
											memberkey : memberkey
										}, function(data) {
										})
								.done(
										function(data) {
											if (data.MEMBERSTATUS != "0") {
												alert("탈퇴한 회원입니다.");
												return
											} else {
												params = {
													targetMemK : memberkey,
													targetMemN : data.MEMBERNICKNAME,
													reMessage : "Y",
													menuId : menuId
												};
												method = "POST";
												var form = document
														.createElement("form");
												form.setAttribute("method",
														method);
												form
														.setAttribute(
																"action",
																"http://www.melon.com/mymusic/messagepresent/popup/mymusicmessage_insertForm.htm");
												for ( var key in params) {
													var hiddenField = document
															.createElement("input");
													hiddenField.setAttribute(
															"type", "hidden");
													hiddenField.setAttribute(
															"name", key);
													hiddenField.setAttribute(
															"value",
															params[key]);
													form
															.appendChild(hiddenField)
												}
												document.body.appendChild(form);
												if (ua.indexOf("safari") > -1
														|| ua.indexOf("IS40") > -1) {
													MELON.WEBSVC
															.openPopup(
																	"",
																	730,
																	750,
																	{
																		target : "pop",
																		scrollbars : "no"
																	},
																	"center",
																	"pop")
												} else {
													MELON.WEBSVC
															.openPopup(
																	"",
																	730,
																	738,
																	{
																		target : "pop",
																		scrollbars : "no"
																	},
																	"center",
																	"pop")
												}
												form.setAttribute("target",
														"pop");
												form.submit()
											}
										})
					},
					goPresentSong : function() {
						location.href = "http://www.melon.com/mymusic/messagepresent/mymusicpresent_list.htm"
					},
					goTotalSearch : function(query, contType, formId, section,
							ipath) {
						if (typeof query == "undefined") {
							return
						}
						if (typeof contType == "undefined" || contType == "") {
							contType = "total"
						}
						if (typeof section == "undefined") {
							section = ""
						}
						if (typeof ipath == "undefined" || ipath == "") {
							ipath = "srch_form"
						}
						var fromMPS = getCookie("MPS");
						var fromMPSYn = fromMPS == null
								|| fromMPS.indexOf("MELONPLAYER") < 0;
						if (!fromMPSYn) {
							ipath = "srch_app"
						}
						var formObj = $("#" + formId);
						var $ipath = $('<input type="hidden" name="ipath" value="'
								+ ipath + '"/>');
						var rUrl = "";
						rUrl = "http://www.melon.com/search/" + contType
								+ "/index.htm";
						formObj.action = rUrl;
						formObj.attr("action", rUrl);
						formObj.attr("method", "get");
						formObj.find("[name=q]").val(query);
						formObj.find("[name=section]").val(section);
						$ipath.appendTo(formObj);
						formObj.submit()
					},
					goJoin : function() {
						location.href = "https://www.melon.com/muid/web/join/stipulationagreement_inform.htm"
					},
					goIdSearch : function() {
						location.href = "https://www.melon.com/muid/web/search/idsearch_inform.htm"
					},
					goTerms : function(termsType, targetType) {
						var termsUrl = "";
						switch (termsType) {
						case "use":
							termsUrl = "http://info.melon.com/terms/web/terms1_1.html";
							break;
						case "player":
							termsUrl = "http://info.melon.com/terms/web/terms2.html";
							break;
						case "privateinfo":
							termsUrl = "http://info.melon.com/terms/web/terms3.html";
							break;
						case "youth":
							termsUrl = "http://info.melon.com/terms/web/terms5_1.html";
							break;
						default:
							termsUrl = "http://info.melon.com/terms/web/terms1_1.html"
						}
						if (typeof targetType == "undefined") {
							location.href = termsUrl
						} else {
							window.open(termsUrl, termsType)
						}
					},
					goDjPlaylistDetail : function(memberStatus, adminOpenYn,
							delYn, plylstSeq) {
						if (adminOpenYn == "N") {
							alert("비공개된 컨텐츠 입니다.");
							return
						}
						if (delYn == "Y") {
							alert("삭제된 컨텐츠 입니다.");
							return
						}
						location.href = "http://www.melon.com/mymusic/dj/mymusicdjplaylistview_inform.htm?plylstSeq="
								+ plylstSeq
					},
					goDjCollectionWithoutStatus : function(plylstSeq) {
						if (typeof plylstSeq == "undefined") {
							return
						}
						location.href = "http://www.melon.com/mymusic/dj/mymusicdjplaylistview_inform.htm?plylstSeq="
								+ plylstSeq
					},
					goPlaylistWithoutStatus : function(plylstSeq) {
						if (typeof plylstSeq == "undefined") {
							return
						}
						location.href = "http://www.melon.com/mymusic/playlist/mymusicplaylistview_inform.htm?plylstSeq="
								+ plylstSeq
					},
					goArtistPlaylistDetail : function(plylstSeq) {
						if (typeof plylstSeq == "undefined") {
							return
						}
						location.href = "http://www.melon.com/artist/playlistDetail.htm?plylstSeq="
								+ plylstSeq
					},
					goMstoryCategory : function(mstoryCateSeq) {
						if (typeof mstoryCateSeq == "undefined") {
							return
						}
						location.href = "http://www.melon.com/musicstory/index.htm?mstoryCateSeq="
								+ mstoryCateSeq
					},
					goStoreMelonDetail : function(contsType, prodSeq) {
						if (typeof contsType == "undefined"
								|| typeof prodSeq == "undefined") {
							return
						}
						window.open("http://store.melon.com/api/gate.htm?type="
								+ contsType + "&param=" + prodSeq + "&pocId="
								+ MELON.WEBSVC.POC.getPocId(), contsType)
					},
					goPopupWithPageUrl : function(pgeUrl, pgeName) {
						if (typeof pgeUrl == "undefined"
								|| typeof pgeName == "undefined") {
							return
						}
						window.open(pgeUrl, pgeName)
					},
					goContentsDetail : function(contsType, contsId, menuId) {
						switch (contsType) {
						case "N10001":
							MELON.WEBSVC.POC.link.goSongDetail(contsId);
							break;
						case "N10002":
							MELON.WEBSVC.POC.link.goAlbumDetail(contsId);
							break;
						case "N10003":
							MELON.WEBSVC.POC.link.goMvDetail(menuId, contsId);
							break;
						case "N10004":
							MELON.WEBSVC.POC.link.goArtistDetail(contsId);
							break;
						case "N10005":
							MELON.WEBSVC.POC.link
									.goPlaylistWithoutStatus(contsId);
							break;
						case "N10006":
							MELON.WEBSVC.POC.link.goArtistDetail(contsId);
							break;
						case "N10007":
							MELON.WEBSVC.POC.link.goMstoryDetail(contsId);
							break;
						case "N10009":
							MELON.WEBSVC.POC.link
									.goDjCollectionWithoutStatus(contsId);
							break;
						case "N10010":
							MELON.WEBSVC.POC.link
									.goDjCollectionWithoutStatus(contsId);
							break;
						case "N10016":
							MELON.WEBSVC.POC.link
									.goArtistPlaylistDetail(contsId);
							break;
						case "DJMGZ":
							location.href = "http://www.melon.com/dj/magazine/djmagazinedetail_listEpsd.htm?magaznSeq="
									+ contsId;
							break;
						case "MSTRY":
							MELON.WEBSVC.POC.link.goMstoryCategory(contsId);
							break;
						case "STRPD":
							MELON.WEBSVC.POC.link.goStoreMelonDetail("product",
									contsId);
							break;
						case "STRAT":
							MELON.WEBSVC.POC.link.goStoreMelonDetail("artist",
									contsId);
							break;
						default:
							MELON.WEBSVC.POC.link.goAlbumDetail(contsId)
						}
					},
					goClassicPeriodArtist : function(classicMenuId, periodCode) {
						if (typeof classicMenuId == "undefined") {
							return
						}
						if (typeof periodCode == "undefined") {
							location.href = "http://www.melon.com/genre/classicPeriodArtist_list.htm?classicMenuId="
									+ classicMenuId
						} else {
							location.href = "http://www.melon.com/genre/classicPeriodArtist_list.htm?classicMenuId="
									+ classicMenuId
									+ "&periodCode="
									+ periodCode
						}
					},
					goClassicArtist : function(classicMenuId) {
						if (typeof classicMenuId == "undefined") {
							return
						}
						location.href = "http://www.melon.com/genre/classicArtist_list.htm?classicMenuId="
								+ classicMenuId
					},
					goClassicArtistAlbum : function(artistId, periodCode) {
						if (typeof artistId == "undefined") {
							return
						}
						if (typeof periodCode == "undefined") {
							location.href = "http://www.melon.com/genre/classicArtistAlbum_list.htm?artistId="
									+ artistId
						} else {
							location.href = "http://www.melon.com/genre/classicArtistAlbum_list.htm?artistId="
									+ artistId + "&periodCode=" + periodCode
						}
					},
					goClassicAlbumChart : function(classicMenuId) {
						if (typeof classicMenuId == "undefined") {
							return
						}
						location.href = "http://www.melon.com/genre/classicAlbumChart_list.htm?classicMenuId="
								+ classicMenuId
					},
					goClassicMasterpiece : function(classicMenuId) {
						if (typeof classicMenuId == "undefined") {
							return
						}
						location.href = "http://www.melon.com/genre/classicMasterpiece_list.htm?classicMenuId="
								+ classicMenuId
					},
					goGenreAlbum : function(classicMenuId, subMenuId) {
						if (typeof classicMenuId == "undefined") {
							return
						}
						if (typeof subMenuId == "undefined") {
							location.href = "http://www.melon.com/genre/album_list.htm?classicMenuId="
									+ classicMenuId
						} else {
							location.href = "http://www.melon.com/genre/album_list.htm?classicMenuId="
									+ classicMenuId + "&subMenuId=" + subMenuId
						}
					},
					goGenreSong : function(classicMenuId, subMenuId) {
						if (typeof classicMenuId == "undefined") {
							return
						}
						if (typeof subMenuId == "undefined") {
							location.href = "http://www.melon.com/genre/song_list.htm?classicMenuId="
									+ classicMenuId
						} else {
							location.href = "http://www.melon.com/genre/song_list.htm?classicMenuId="
									+ classicMenuId + "&subMenuId=" + subMenuId
						}
					},
					goGenreSongChart : function(classicMenuId) {
						if (typeof classicMenuId == "undefined") {
							return
						}
						location.href = "http://www.melon.com/genre/songChart_list.htm?classicMenuId="
								+ classicMenuId
					},
					goGenreThemaChild : function(classCd, genreCd) {
						if (typeof classCd == "undefined") {
							return
						}
						if (typeof genreCd == "undefined") {
							location.href = "http://www.melon.com/genre/song_list.htm?classCd="
									+ classCd
						} else {
							location.href = "http://www.melon.com/genre/song_list.htm?classCd="
									+ classCd + "&genreCd=" + genreCd
						}
					},
					goMyCupon : function() {
						location.href = "http://www.melon.com/commerce/mypage/coupon/web/couponbox_couponBoxView.htm"
					},
					goMelonCash : function() {
						location.href = "http://www.melon.com/commerce/mypage/cash/web/meloncash_listChargedSpentView.htm"
					},
					goAnswer : function(faqId) {
						if (typeof faqId == "undefined") {
							return
						}
						location.href = "http://faqs2.melon.com/customer/faq/informFaq.htm?faqId="
								+ faqId
					},
					goMultiMessagePop : function(contsType, contsId, menuId) {
						var h = 0;
						if (contsType == "song") {
							h = 456
						} else {
							if (contsType == "album") {
								h = 456
							} else {
								if (contsType == "artist") {
									h = 456
								} else {
									if (contsType == "mv") {
										h = 460
									} else {
										if (contsType == "plylst") {
											h = 466
										} else {
											if (contsType == "djcol") {
												h = 466
											} else {
												if (contsType == "artistplylst") {
													h = 466
												} else {
													if (contsType == "photo") {
														h = 546
													}
												}
											}
										}
									}
								}
							}
						}
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							MELON.WEBSVC
									.openPopup(
											"http://www.melon.com/mymusic/messagepresent/popup/mymusicmessage_insertMultiForm.htm?contsType="
													+ contsType
													+ "&menuId="
													+ menuId
													+ "&contsId="
													+ contsId, 730, h, {
												scrollbars : "no"
											}, "center", "multipop")
						} else {
							MELON.WEBSVC.POC.login.loginPopupLayerd("");
							return
						}
					},
					goAztalk : function() {
						location.href = "http://www.melon.com/artistplus/aztalk/index.htm"
					},
					goMultiMessageNew : function(contsType, contsId, mvTypeCode) {
						if (typeof contsId == "undefined") {
							return
						}
						var action = MELON.WEBSVC.POC.httpMelonVod;
						if (typeof mvTypeCode != "undefined"
								&& mvTypeCode == "MV0007") {
							action = MELON.WEBSVC.POC.httpMelonLive
						}
						switch (contsType) {
						case "song":
							window
									.open("http://www.melon.com/song/detail.htm?songId="
											+ contsId);
							break;
						case "album":
							window
									.open("http://www.melon.com/album/detail.htm?albumId="
											+ contsId);
							break;
						case "artist":
							window
									.open("http://www.melon.com/artist/timeline.htm?artistId="
											+ contsId);
							break;
						case "mv":
							window.open(action + "/video/detail.htm?mvId="
									+ contsId);
							break;
						case "artistplylst":
							window
									.open("http://www.melon.com/artist/playlistDetail.htm?plylstSeq="
											+ contsId);
							break;
						case "photo":
							window
									.open("http://www.melon.com/artist/photo.htm?artistId="
											+ contsId);
							break;
						default:
							window
									.open("http://www.melon.com/song/detail.htm?songId="
											+ contsId);
							break
						}
					},
					goComingsoon : function() {
						location.href = "http://www.melon.com/new/comingsoon/index.htm"
					},
					goSearchLog : function(w, coll, cpath, srch_wd, doc_id,
							formId) {
						var param;
						var docIds = new Array();
						$("#" + formId).find(
								"input[name='input_check']:checked").each(
								function() {
									if (!isNaN(this.value)) {
										docIds.push($(this).val())
									}
								});
						if (doc_id == "") {
							doc_id = docIds
						}
						param = "c_w=" + w;
						param += "&c_coll=" + coll;
						param += "&c_cpath=" + cpath;
						param += "&c_srchwd="
								+ encodeURIComponent(encodeURIComponent(srch_wd));
						param += "&c_docid=" + doc_id;
						var url = "http://www.melon.com/searchlog/writer.json?"
								+ param;
						$.ajax({
							url : url,
							jsonpCallback : "callBackResponse",
							dataType : "jsonp",
							type : "POST",
							contentType : "application/json; charset=UTF-8",
							scriptCharset : "UTF-8",
							cache : false,
							jsonp : "jscallback"
						})
					},
					goDjtoday : function() {
						location.href = "http://www.melon.com/dj/today/djtoday_list.htm"
					},
					goMyMusicManySong : function(yyyyMM) {
						location.href = "http://www.melon.com/mymusic/top/mymusictopmanysong_list.htm?memberKey="
								+ getMemberKey() + "&searchDate=" + yyyyMM
					},
					goPhotoDetail : function(artistId, photoId) {
						location.href = "http://www.melon.com/artist/photo.htm?artistId="
								+ artistId + "&photoId=" + photoId
					},
					goPhotoBtmDetail : function(artistId, photoId, orderBy) {
						if (typeof orderBy == "undefined") {
							orderBy = ""
						}
						location.href = "http://www.melon.com/artist/photo_detail.htm?artistId="
								+ artistId
								+ "&photoId="
								+ photoId
								+ "&orderBy=" + orderBy
					},
					goMstoryDetail : function(mstorySeq, cateObj, startIndex,
							musicToday) {
						if (typeof mstorySeq == "undefined") {
							return
						}
						var redUrl = MELON.WEBSVC.POC.httpMelonWww
								+ "/musicstory/inform.htm?mstorySeq="
								+ mstorySeq;
						if (typeof startIndex != "undefined") {
							redUrl += "&startIndex=" + startIndex
						}
						if (typeof musicToday != "undefined") {
							redUrl += "&musicToday=" + musicToday
						}
						if (typeof cateObj == "undefined") {
							redUrl += "&expose=true"
						} else {
							if (!$(cateObj).hasClass("on")) {
								redUrl += "&expose=false"
							}
						}
						location.href = redUrl
					},
					goMstoryCateDetail : function(mstoryCateSeq, cateObj,
							startIndex) {
						if (typeof mstoryCateSeq == "undefined") {
							return
						}
						var redUrl = MELON.WEBSVC.POC.httpMelonWww
								+ "/musicstory/index.htm?mstoryCateSeq="
								+ mstoryCateSeq;
						if (typeof startIndex != "undefined") {
							redUrl += "&pageIndex=" + startIndex
						}
						if (typeof cateObj == "undefined") {
							redUrl += "&expose=true"
						} else {
							if (!$(cateObj).hasClass("on")) {
								redUrl += "&expose=false"
							}
						}
						location.href = redUrl
					},
					goEntNewsDetail : function(entnewsSeq, cateObj, startIndex,
							searchWord) {
						if (typeof entnewsSeq == "undefined") {
							return
						}
						var redUrl = MELON.WEBSVC.POC.httpMelonWww
								+ "/musicstory/entnews/inform.htm?entnewsSeq="
								+ entnewsSeq;
						if (typeof startIndex != "undefined") {
							redUrl += "&startIndex=" + startIndex
						}
						if (typeof searchWord != "undefined") {
							redUrl += "&searchWord=" + searchWord
						}
						if (typeof cateObj == "undefined") {
							redUrl += "&expose=true"
						} else {
							if (!$(cateObj).hasClass("on")) {
								redUrl += "&expose=false"
							}
						}
						location.href = redUrl
					},
					goEntNewsList : function(cateObj, startIndex, searchWord) {
						var redUrl = MELON.WEBSVC.POC.httpMelonWww
								+ "/musicstory/entnews/index.htm";
						if (typeof startIndex != "undefined") {
							redUrl += "?pageIndex=" + startIndex
						} else {
							redUrl += "?pageIndex=1"
						}
						if (typeof searchWord != "undefined") {
							redUrl += "&searchWord=" + searchWord
						}
						if (typeof cateObj == "undefined") {
							redUrl += "&expose=true"
						} else {
							if (!$(cateObj).hasClass("on")) {
								redUrl += "&expose=false"
							}
						}
						location.href = redUrl
					},
					goArtistShop : function(artistId, menuId) {
						if (typeof artistId == "undefined") {
							return
						}
						var redUrl = "http://store.melon.com/api/gate.htm?type=artist&param="
								+ artistId
								+ "&pocId="
								+ MELON.WEBSVC.POC.getPocId()
								+ "&menuId="
								+ menuId;
						window.open(redUrl, "_blank")
					},
					goMelonShopDetail : function(redUrl, minorBuyPosblYn) {
						if (typeof redUrl == "undefined") {
							return
						}
						if (typeof minorBuyPosblYn == "undefined") {
							minorBuyPosblYn = "Y"
						}
						if (minorBuyPosblYn == "N") {
							if (!isMelonLogin()) {
								alert("이 정보내용은 청소년유해매체물로서 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 및 「청소년 보호법」 에 따라 19세 미만의 청소년이 이용할 수 없습니다.\n확인을 위해 먼저 로그인 하세요.");
								MELON.WEBSVC.POC.login.loginPopupLayerd("")
							} else {
								var memberAuthFlg = getMemberAuthFlg();
								switch (memberAuthFlg) {
								case "1":
									window.open(redUrl, "_blank");
									break;
								case "0":
								case "2":
									if (!confirm("이 정보내용은 청소년 유해매체물로서 「정보통신이용촉진 및 정보보호 등에 관한 법률」 및 「청소년 보호법」에  따라 19세 미만의 청소년이 이용할 수 없습니다.\n성인인증 후 이용해주세요.")) {
										return
									}
									niceAuthPop("nineteen", "Y", "", "", true,
											"01");
									break;
								case "3":
								case "4":
									alert("이 정보내용은 청소년유해매체물로서 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 및 「청소년 보호법」 에 따라 19세 미만의 청소년이 이용할 수 없습니다");
									break;
								default:
									alert("이 정보내용은 청소년유해매체물로서 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 및 「청소년 보호법」 에 따라 19세 미만의 청소년이 이용할 수 없습니다");
									break
								}
							}
						} else {
							window.open(redUrl, "_blank")
						}
					}
				},
				buy : {
					goBuyProduct : function(formName, contsId, contsType,
							paramsName, buyType, menuId, exceptAll) {
						if (MELON.WEBSVC.POC.isTablet()) {
							MELON.WEBSVC.POC.tabletGuidePop();
							return
						}
						if (isMelonLogin()) {
							MELON.WEBSVC.CM.CONT.goBuyProduct(formName,
									contsId, contsType, paramsName, buyType,
									menuId, exceptAll)
						} else {
							MELON.WEBSVC.POC.login.loginCheckFuncCall()
						}
					},
					goBuyProductByPlylst : function(contsId, menuId) {
						if (MELON.WEBSVC.POC.isTablet()) {
							MELON.WEBSVC.POC.tabletGuidePop();
							return
						}
						if (isMelonLogin()) {
							$
									.ajax({
										type : "POST",
										url : "/mymusic/common/mymusiccommon_listPlaylistSongIds.json",
										data : {
											plylstSeq : contsId
										},
										dataType : "json",
										async : false,
										success : function(data) {
											var songList = data.songIds;
											if (document.plylstSongList != undefined) {
												document.body
														.removeChild(document.plylstSongList)
											}
											if (data.songIds != null
													&& songList.length > 0) {
												var form = "";
												if (MELON.WEBSVC.browser.isIE
														&& MELON.WEBSVC.browser.version < 8) {
													form = document
															.createElement("<form name='plylstSongList' style='display:none;'>");
													for ( var key in songList) {
														var hiddenField = document
																.createElement("<input type='checkbox' name='song_id_chk' checked='checked' style='display:none;' value='"
																		+ songList[key]
																		+ "'>");
														form
																.appendChild(hiddenField)
													}
												} else {
													form = document
															.createElement("form");
													form.setAttribute("name",
															"plylstSongList");
													form.setAttribute("style",
															"display:none");
													for ( var key in songList) {
														var hiddenField = document
																.createElement("input");
														hiddenField
																.setAttribute(
																		"type",
																		"checkbox");
														hiddenField
																.setAttribute(
																		"name",
																		"song_id_chk");
														hiddenField
																.setAttribute(
																		"checked",
																		true);
														hiddenField
																.setAttribute(
																		"value",
																		songList[key]);
														hiddenField
																.setAttribute(
																		"style",
																		"display:none");
														form
																.appendChild(hiddenField)
													}
												}
												document.body.appendChild(form);
												MELON.WEBSVC.CM.CONT
														.goBuyProduct(
																"plylstSongList",
																"", "3C0001",
																"song_id_chk",
																"0", menuId, "")
											} else {
												alert("다운로드 가능한 곡이 없습니다.");
												return
											}
										}
									})
						} else {
							MELON.WEBSVC.POC.login.loginCheckFuncCall()
						}
					},
					goPresentOnlyOne : function(type, contsId, menuId) {
						if (!MELON.WEBSVC.POC.login.isMelonLogin()) {
							MELON.WEBSVC.POC.login.loginPopupLayerd("");
							return
						}
						if (!confirm("해당 곡을 선물 하시겠습니까?")) {
							return
						}
						location.href = "/mymusic/messagepresent/mymusicpresent_insert.htm?songIds="
								+ contsId + "&menuId=" + menuId
					},
					goPresentForAlbum : function(albumId, formId, menuId) {
						if (!MELON.WEBSVC.POC.login.isMelonLogin()) {
							MELON.WEBSVC.POC.login.loginPopupLayerd("");
							return
						}
						if (albumId == "") {
							alert("앨범을 선택해 주세요.");
							return
						}
						var contsList = new Array();
						var songIds = "";
						if (formId != null && formId != "") {
							$("#" + formId).find(".input_check").each(
									function() {
										if (!isNaN($(this).val())) {
											contsList.push($(this).val())
										}
									})
						} else {
							$
									.ajax({
										type : "POST",
										url : "/album/listAlbumSong.json",
										data : {
											albumId : albumId
										},
										dataType : "json",
										async : false,
										success : function(data) {
											for ( var key in data.songList) {
												contsList
														.push(data.songList[key].SONGID)
											}
										}
									})
						}
						if (contsList == "") {
							alert("선물 가능한 수록곡이 없습니다.");
							return
						}
						if (menuId == "") {
							alert("메뉴아이디가 존재하지 않습니다.");
							return
						}
						if (!confirm("앨범을 선물 하시겠습니까?")) {
							return
						}
						if (contsList.length > 50) {
							alert("한 번에 최대 50곡까지만 선물 가능합니다.");
							return
						}
						params = {
							songIds : contsList.join(),
							menuId : menuId
						};
						method = "POST";
						var form = document.createElement("form");
						form.setAttribute("method", method);
						form
								.setAttribute("action",
										"/mymusic/messagepresent/mymusicpresent_insert.htm");
						for ( var key in params) {
							var hiddenField = document.createElement("input");
							hiddenField.setAttribute("type", "hidden");
							hiddenField.setAttribute("name", key);
							hiddenField.setAttribute("value", params[key]);
							form.appendChild(hiddenField)
						}
						document.body.appendChild(form);
						form.submit()
					},
					goPresent : function(type, formId, menuId) {
						if (!MELON.WEBSVC.POC.login.isMelonLogin()) {
							MELON.WEBSVC.POC.login.loginPopupLayerd("");
							return
						}
						var str = "";
						var count = 0;
						if (type == "song") {
							str = "곡을"
						} else {
							alert("추후 적용될 예정입니다.");
							return
						}
						var contsList = new Array();
						var songIds = "";
						$("#" + formId).find(".input_check:checked").each(
								function() {
									if (!isNaN($(this).val())) {
										contsList.push($(this).val());
										count++
									}
								});
						if (contsList == "") {
							alert(str + " 선택해 주세요.");
							return
						}
						if (menuId == "") {
							alert("메뉴아이디가 존재하지 않습니다.");
							return
						}
						if (!confirm(count + "개의 " + str + " 선물 하시겠습니까?")) {
							return
						}
						if (contsList.length > 50) {
							alert("한 번에 최대 50곡까지만 선물 가능합니다.");
							return
						}
						params = {
							songIds : contsList.join(),
							menuId : menuId
						};
						method = "POST";
						var form = document.createElement("form");
						form.setAttribute("method", method);
						form
								.setAttribute("action",
										"/mymusic/messagepresent/mymusicpresent_insert.htm");
						for ( var key in params) {
							var hiddenField = document.createElement("input");
							hiddenField.setAttribute("type", "hidden");
							hiddenField.setAttribute("name", key);
							hiddenField.setAttribute("value", params[key]);
							form.appendChild(hiddenField)
						}
						document.body.appendChild(form);
						form.submit()
					},
					popPhoneDecorate : function(tumsFlg, songId) {
						if (!isMelonLogin()) {
							MELON.WEBSVC.POC.login.loginPopupLayerd();
							return
						}
						if (songId == 0 || typeof songId == "undefined"
								|| songId == "") {
							alert("곡아이디가 없습니다.");
							return
						}
						var URL = "http://decop.melon.com/3.0/player/decop_player.jsp?p_tumsFlg="
								+ tumsFlg
								+ "&p_songId="
								+ songId
								+ "&truepage=http://decop.melon.com/3.0/gnb2/popupBox/phone_deco_p.jsp%3Fp_songId="
								+ songId + "%26p_tumsFlg=" + tumsFlg;
						show = window.open(URL, "phone",
								"height=330,width=452,scrollbars=yes");
						show.focus()
					}
				},
				login : {
					loginCheckFuncCall : function(methodName) {
						var iFuncName = 0;
						var iParamStart = 1;
						var isLogin = isMelonLogin();
						if (isLogin) {
							var param = "";
							var cmd = "";
							for (var i = iParamStart; i < arguments.length; i++) {
								param += "arguments[" + i + "]";
								if (i + 1 < arguments.length) {
									param += ","
								}
							}
							cmd = arguments[iFuncName] + "(" + param + ")";
							eval(cmd)
						} else {
							MELON.WEBSVC.POC.login.loginPopupLayerd()
						}
					},
					loginPopup : function(type) {
						var popUrl = "";
						var urlOpt = "";
						if (!type) {
							window.name = "_OPENER_LOGIN_WINDOW";
							popUrl = "http://www.melon.com/muid/web/login/loginpopup_inform.htm";
							urlOpt = "scrollbars=no, resizable=yes,location=no, width=560,height=419, left=20, top=20";
							window.open(popUrl, "_LOGIN_POPUP", urlOpt)
						} else {
							if (type == "1") {
								window.name = "_OPENER_LOGIN_WINDOW";
								popUrl = "http://www.melon.com/muid/web/login/loginpopup_inform.htm";
								urlOpt = "scrollbars=no, resizable=yes,location=no, width=560,height=419, left=20, top=20";
								window.open(popUrl, "_LOGIN_POPUP", urlOpt)
							} else {
								if (type == "2") {
									popUrl = "http://www.melon.com/muid/web/login/loginpopup_inform.htm";
									location.href = popUrl
								}
							}
						}
					},
					loginPopupLayerd : function(returnPage) {
						$
								.ajax(
										{
											url : "/muid/web/login/loginlayer_inform.htm",
											data : {
												returnPage : returnPage
											}
										})
								.done(
										function(html) {
											$(html)
													.appendTo("body")
													.modal(
															{
																modal : true,
																clone : true,
																containerCss : {
																	backgroundColor : "#fffff"
																},
																removeOnClose : true
															})
													.find(
															"input[name=returnPage]")
													.val(
															returnPage
																	|| location.href);
											try {
												if ($("script[src='resource/script/muid/web/memberAlertMsg.js']").length == 0
														&& $("script[src='http://member.melon.com/resource/script/muid/web/memberAlertMsg.js']").length == 0) {
													var memAlertJsStr = '<script type="text/javascript" src="http://member.melon.com/resource/script/muid/web/memberAlertMsg.js"><\/script>';
													$(memAlertJsStr).appendTo(
															"body")
												}
												if ($("script[src='/resource/script/muid/web/memberFunc.js']").length == 0
														&& $("script[src='http://member.melon.com/resource/script/muid/web/memberFunc.js']").length == 0) {
													var memFuncJsStr = "<script type='text/javascript' src='http://member.melon.com/resource/script/muid/web/memberFunc.js'><\/script>";
													$(memFuncJsStr).appendTo(
															"body")
												}
												$("input[placeholder]")
														.placeholder({})
											} catch (e) {
											}
										})
					},
					loginPopupLayerdMMA : function(returnPage) {
						$
								.ajax(
										{
											url : "/muid/web/login/loginlayer_inform.htm",
											data : {
												returnPage : returnPage
											}
										})
								.done(
										function(html) {
											$(html)
													.appendTo("body")
													.modal(
															{
																modal : true,
																clone : true,
																draggable : false,
																containerCss : {
																	backgroundColor : "#fffff"
																},
																removeOnClose : true
															})
													.find(
															"input[name=returnPage]")
													.val(
															returnPage
																	|| location.href);
											try {
												if ($("script[src='/resource/script/muid/web/memberAlertMsg.js']").length == 0
														&& $("script[src='http://member.melon.com/resource/script/muid/web/memberAlertMsg.js']").length == 0) {
													var memAlertJsStr = '<script type="text/javascript" src="http://member.melon.com/resource/script/muid/web/memberAlertMsg.js"><\/script>';
													$(memAlertJsStr).appendTo(
															"body")
												}
												if ($("script[src='/resource/script/muid/web/memberFunc.js']").length == 0
														&& $("script[src='http://member.melon.com/resource/script/muid/web/memberFunc.js']").length == 0) {
													var memFuncJsStr = "<script type='text/javascript' src='http://member.melon.com/resource/script/muid/web/memberFunc.js'><\/script>";
													$(memFuncJsStr).appendTo(
															"body")
												}
												$("input[placeholder]")
														.placeholder({})
											} catch (e) {
											}
										})
					},
					isMelonLogin : function() {
						return isMelonLogin()
					},
					gnbLogin : function() {
						var loginBoxIdx = 0;
						if ($("#gnbLoginDiv").children().eq(1).css("display") == "block") {
							loginBoxIdx = 1
						}
						var id = $("#gnbLoginDiv").children().eq(loginBoxIdx)
								.find("input[name=memberId]").val();
						var pwd = $("#gnbLoginDiv").children().eq(loginBoxIdx)
								.find("input[name=memberPwd]").val();
						var saveId = $("#gnbLoginDiv").children().eq(
								loginBoxIdx).find("input[name=saveId]").prop(
								"checked") ? "Y" : "N";
						if (id == "" || id == "아이디") {
							alert("아이디를 입력해 주세요.");
							return false
						}
						if (pwd == "") {
							alert("비밀번호를 입력해 주세요.");
							return false
						}
						var loginFrm = $('<form method="post" name="gnbLoginFrm"></form>');
						loginFrm.appendTo("body");
						var returnURL = document.location.href;
						returnURL = encodeURIComponent(returnURL);
						var loginRSA;
						try {
							loginRSA = new AuthRSA();
							loginRSA
									.execute(function(p, e) {
										loginFrm
												.append('<input type="hidden" id="memberId" name="memberId" value="'
														+ loginRSA.encrypt(id)
														+ '">');
										loginFrm
												.append('<input type="hidden" id="memberPwd" name="memberPwd" value="'
														+ loginRSA.encrypt(pwd)
														+ '">');
										loginFrm
												.append('<input type="hidden" id="publicKey" name="publicKey" value="'
														+ p + '">');
										loginFrm
												.append('<input type="hidden" id="saveId" name="saveId" value="'
														+ saveId + '">');
										loginFrm.prop("action",
												"https://member.melon.com/muid/web/login/login_informProcs.htm?returnPage="
														+ returnURL);
										loginFrm.submit()
									})
						} catch (e) {
							loginFrm
									.append('<input type="hidden" id="memberId" name="memberId" value="'
											+ id + '">');
							loginFrm
									.append('<input type="hidden" id="memberPwd" name="memberPwd" value="'
											+ pwd + '">');
							loginFrm
									.append('<input type="hidden" id="saveId" name="saveId" value="'
											+ saveId + '">');
							loginFrm.prop("action",
									"https://member.melon.com/muid/web/login/login_informProcs.htm?returnPage="
											+ returnURL);
							loginFrm.submit()
						}
					},
					gnbLogout : function() {
						logout()
					},
					menuLogin : function(returnPage) {
						if (returnPage == null || returnPage == "") {
							location.href = "https://www.melon.com/muid/web/login/login_inform.htm"
						} else {
							var loginFrm = $('<form method="post" name="menuLoginFrm"></form>');
							loginFrm.appendTo("body");
							var inputReturnPage = $("<input />");
							inputReturnPage.attr("name", "returnPage");
							inputReturnPage.attr("value", returnPage);
							inputReturnPage.appendTo(loginFrm);
							loginFrm
									.attr("action",
											"https://www.melon.com/muid/web/login/login_inform.htm");
							loginFrm.submit()
						}
					},
					menuLoginWithReqType : function(returnPage, reqType) {
						if (returnPage == null || returnPage == "") {
							location.href = "https://www.melon.com/muid/web/login/login_inform.htm"
						} else {
							var loginFrm = $('<form method="post" name="menuLoginFrm"></form>');
							loginFrm.appendTo("body");
							var inputReturnPage = $("<input />");
							inputReturnPage.attr("name", "returnPage");
							inputReturnPage.attr("value", returnPage);
							inputReturnPage.appendTo(loginFrm);
							var inputReqType = $("<input />");
							inputReqType.attr("name", "reqType");
							inputReqType.attr("value", reqType);
							inputReqType.appendTo(loginFrm);
							loginFrm
									.attr("action",
											"https://www.melon.com/muid/web/login/login_inform.htm");
							loginFrm.submit()
						}
					}
				},
				menu : {
					goMyMusicMain : function() {
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							location.href = "http://www.melon.com/mymusic/main/mymusicmain_list.htm?memberKey="
									+ getMemberKey()
						} else {
							MELON.WEBSVC.POC.login
									.menuLoginWithReqType(
											"http://www.melon.com/mymusic/main/mymusicmain_list.htm",
											"TYPE01");
							return
						}
					},
					goMyMusicLike : function() {
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							location.href = "http://www.melon.com/mymusic/like/mymusiclikesong_list.htm?memberKey="
									+ getMemberKey()
						} else {
							MELON.WEBSVC.POC.login.menuLogin();
							return
						}
					},
					goMyMusicPlayList : function() {
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							location.href = "http://www.melon.com/mymusic/playlist/mymusicplaylist_list.htm?memberKey="
									+ getMemberKey()
						} else {
							MELON.WEBSVC.POC.login.menuLogin();
							return
						}
					},
					goMyMusicDjCollection : function() {
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							location.href = "http://www.melon.com/mymusic/djcollection/mymusiccollectiondj_list.htm?memberKey="
									+ getMemberKey()
						} else {
							MELON.WEBSVC.POC.login.menuLogin();
							return
						}
					},
					goMyMusicRecentSong : function() {
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							location.href = "http://www.melon.com/mymusic/recent/mymusicplaylistrecentsong_list.htm?memberKey="
									+ getMemberKey()
						} else {
							MELON.WEBSVC.POC.login.menuLogin();
							return
						}
					},
					goMyMusicManySong : function() {
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							location.href = "http://www.melon.com/mymusic/top/mymusicplaylistmanysong_list.htm?memberKey="
									+ getMemberKey()
						} else {
							MELON.WEBSVC.POC.login.menuLogin();
							return
						}
					},
					goMyMusicFanSignArtist : function() {
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							location.href = "http://www.melon.com/mymusic/artistfan/mymusicartistfan_list.htm?memberKey="
									+ getMemberKey()
						} else {
							MELON.WEBSVC.POC.login.menuLogin();
							return
						}
					},
					goMyMusicFriend : function() {
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							location.href = "http://www.melon.com/mymusic/friend/mymusicfriendmusicchart_list.htm?memberKey="
									+ getMemberKey()
						} else {
							MELON.WEBSVC.POC.login.menuLogin();
							return
						}
					},
					goMyMusicMyFriend : function() {
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							location.href = "http://www.melon.com/mymusic/friend/mymusicfriend_list.htm?memberKey="
									+ getMemberKey()
						} else {
							MELON.WEBSVC.POC.login.menuLogin();
							return
						}
					},
					goMyMusicMessage : function() {
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							location.href = "http://www.melon.com/mymusic/messagepresent/mymusicmessage_list.htm"
						} else {
							MELON.WEBSVC.POC.login.menuLogin();
							return
						}
					},
					goDjRegister : function() {
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							location.href = "http://www.melon.com/dj/djregister/djregister_inform.htm"
						} else {
							MELON.WEBSVC.POC.login.menuLogin();
							return
						}
					},
					goMyPage : function() {
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							location.href = "http://www.melon.com/commerce/mypage/product/web/producthistory_listCurUserProdView.htm"
						} else {
							MELON.WEBSVC.POC.login.menuLogin();
							return
						}
					},
					goMyPageAddCash : function() {
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							window
									.open(httpsWww
											+ "/buy/meloncash/charge.htm",
											"melonCash",
											"app_, width=645, height=612, status=no, toolbar=no, scrollbars=yes")
						} else {
							MELON.WEBSVC.POC.login.menuLogin();
							return
						}
					},
					goFeed : function() {
						if (MELON.WEBSVC.POC.login.isMelonLogin()) {
							location.href = "http://www.melon.com/feed/index.htm"
						} else {
							MELON.WEBSVC.POC.login
									.menuLogin("http://www.melon.com/feed/index.htm");
							return
						}
					},
					cm : {
						goPamphlet : function() {
							location.href = this.getPamphletUrl()
						},
						getPamphletUrl : function() {
							return "http://www.melon.com/commerce/pamphlet/web/sale_listMainView.htm"
						}
					}
				},
				sns : {
					postFacebook : function(param) {
						var memberKey = param.memberKey;
						var type = param.type;
						var contsId = param.contsId;
						var message = param.message;
						var menuId = param.menuId;
						if (menuId == undefined || menuId == "undefined") {
							menuId = ""
						}
						if (type == "son") {
							type = "sonDft"
						} else {
							if (type == "alb") {
								type = "albDft"
							} else {
								if (type == "art") {
									type = "artDft"
								}
							}
						}
						var url = "http://www.melon.com/restful/cds/facebook/web/facebook_posting/"
								+ type + "/" + contsId + ".htm";
						if (type == "ply" || type == "oab" || type == "apl"
								|| type == "djm" || type == "djc") {
							$
									.ajax({
										type : "POST",
										url : "/sns/snsposting_informPostingEtcData.json",
										data : {
											type : type,
											contsId : contsId
										},
										async : false,
										success : function(result) {
											url = "http://www.melon.com/restful/cds/facebook/web/facebook_posting/"
													+ type
													+ "/"
													+ contsId
													+ "/"
													+ result.memberKey
													+ "/"
													+ result.updtDate
													+ ".htm"
										}
									})
						}
						$
								.ajax({
									type : "POST",
									url : "/sns/snsposting_postFacebook.json",
									data : {
										memberKey : memberKey,
										url : url,
										message : message
									},
									dataType : "json",
									success : function(result) {
										if (result.result == "SNSOK") {
											var longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type="
													+ type
													+ "&sId="
													+ contsId
													+ "&frm=cmt&menuId="
													+ menuId;
											melon.sns.getShortenUrl({
												longUrl : longUrl,
												type : type,
												ref : "facebook",
												contsId : contsId,
												menuId : menuId
											});
											melon.sns.outPostingLog("facebook",
													type, contsId)
										} else {
											alert("페이스북 계정연결을 하여야 합니다.")
										}
									}
								})
					},
					postTwitter : function(param) {
						var memberKey = param.memberKey;
						var type = param.type;
						var contsId = param.contsId;
						var message = param.message;
						var menuId = param.menuId;
						if (menuId == undefined || menuId == "undefined") {
							menuId = ""
						}
						var longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type="
								+ type
								+ "&sId="
								+ contsId
								+ "&frm=cmt&menuId="
								+ menuId;
						var url = melon.sns.getShortenUrl({
							longUrl : longUrl,
							type : type,
							ref : "twitter",
							contsId : contsId,
							menuId : menuId
						});
						$.ajax({
							type : "POST",
							url : "/sns/snsposting_postTwitter.json",
							data : {
								memberKey : memberKey,
								url : url,
								message : message
							},
							dataType : "json",
							success : function(result) {
								if (result.result == "SNSOK") {
									melon.sns.outPostingLog("twitter", type,
											contsId)
								} else {
									alert("트위터 계정연결을 하여야 합니다.")
								}
							}
						})
					},
					facebook : function(param) {
						var adjTitle = "";
						var adjDescription = "음악이 필요한 순간, 멜론";
						var strStatus = "";
						var cbUrl = "";
						var type = param.type;
						var contsId = param.contsId;
						var menuId = param.menuId;
						if (menuId == undefined || menuId == "undefined") {
							menuId = ""
						}
						var artistId = param.artistId;
						if (artistId == undefined || artistId == "undefined") {
							artistId = ""
						}
						var imgUrl = param.imgUrl;
						if (imgUrl == undefined || imgUrl == null
								|| imgUrl == "undefined") {
							imgUrl = ""
						}
						var subType = param.subType;
						if (subType == undefined || subType == null
								|| subType == "undefined") {
							subType = ""
						}
						var wwwHome = "http://www.melon.com";
						var longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type="
								+ type
								+ "&sId="
								+ contsId
								+ "&menuId="
								+ menuId;
						var fbFeedUrl = wwwHome
								+ "/restful/cds/facebook/web/facebook_posting/"
								+ type + "/" + contsId + ".htm";
						var redirectUrl = "http://www.melon.com/sns/snsposting_close.htm";
						if ("son" == type) {
							adjTitle = param.songName + " - "
									+ param.artistName;
							if (imgUrl.indexOf("noAlbum_") > 0) {
								imgUrl = "/resource/image/web/default/noAlbum_500.jpg"
							} else {
								imgUrl = melon.sns
										.getImgUrlByWidth(imgUrl, 500)
							}
						} else {
							if ("alb" == type) {
								adjTitle = param.albumName + " - "
										+ param.artistName;
								if (imgUrl.indexOf("noAlbum_") > 0) {
									imgUrl = "/resource/image/web/default/noAlbum_500.jpg"
								} else {
									imgUrl = melon.sns.getImgUrlByWidth(imgUrl,
											500)
								}
							} else {
								if ("art" == type) {
									adjTitle = param.artistName
								} else {
									if ("playlist" == type || "ply" == type) {
										adjTitle = param.playlistName + " by "
												+ param.memberNickName;
										var memberKey = param.memberKey;
										var updtDate = param.updtDate;
										var albumImage1Path = param.albumImage1Path;
										if (imgUrl == null || imgUrl == "") {
											if (albumImage1Path == null
													|| albumImage1Path == "") {
												imgUrl = "/resource/image/web/default/noAlbum_500.jpg"
											} else {
												imgUrl = albumImage1Path;
												imgUrl = melon.sns
														.getImgUrlByWidth(
																imgUrl, 500)
											}
										} else {
											imgUrl = imgUrl.replace("_190",
													"_org")
										}
										imgUrl = imgUrl + "?tm=" + updtDate
									} else {
										if ("oalbum" == type || "oab" == type
												|| "djc" == type) {
											adjTitle = param.playlistName
													+ " by "
													+ param.memberNickName;
											var memberKey = param.memberKey;
											var updtDate = param.updtDate;
											var albumImage1Path = param.albumImage1Path;
											if (imgUrl == null || imgUrl == "") {
												if (albumImage1Path == null
														|| albumImage1Path == "") {
													imgUrl = "/resource/image/web/default/noAlbum_500.jpg"
												} else {
													imgUrl = albumImage1Path;
													imgUrl = melon.sns
															.getImgUrlByWidth(
																	imgUrl, 500)
												}
											} else {
												imgUrl = imgUrl.replace("_190",
														"_org")
											}
											imgUrl = imgUrl + "?tm=" + updtDate
										} else {
											if ("pht" == type) {
												adjTitle = param.artistName;
												longUrl = longUrl + "&artId="
														+ artistId;
												if (imgUrl.indexOf("_org") > 0) {
													imgUrl = imgUrl.replace(
															"_org", "_500")
												} else {
													if (imgUrl
															.indexOf("noAlbum_") > 0) {
														imgUrl = "/resource/image/web/default/noAlbum_500.jpg"
													}
												}
											} else {
												if ("mvd" == type) {
													longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type="
															+ type
															+ "&sId="
															+ contsId
															+ "&menuId="
															+ menuId
															+ "&subType="
															+ subType;
													adjTitle = param.mvdName
															+ " - "
															+ param.artistName;
													if (imgUrl
															.indexOf("noMovie_") > 0) {
														imgUrl = "/resource/image/web/default/noMovie_4x3_640.jpg"
													} else {
														imgUrl = melon.sns
																.getImgUrlByWidth(
																		imgUrl,
																		640)
													}
													if ("live" == subType) {
														fbFeedUrl = wwwHome
																+ "/restful/cds/facebook/web/facebook_posting/mvdLLk/"
																+ contsId
																+ ".htm"
													} else {
														fbFeedUrl = wwwHome
																+ "/restful/cds/facebook/web/facebook_posting/mvdVLk/"
																+ contsId
																+ ".htm"
													}
												} else {
													if ("djm" == type) {
														adjTitle = param.magaznName
																+ " by "
																+ param.magaznNickname;
														var memberKey = "1";
														var updtDate = param.updtDate;
														if (imgUrl == null
																|| imgUrl == "") {
															imgUrl = "/resource/image/web/default/noAlbum_500.jpg"
														} else {
															imgUrl = imgUrl
																	.replace(
																			"_220",
																			"_640")
														}
														imgUrl = imgUrl
																+ "?tm="
																+ updtDate
													} else {
														if ("mus" == type) {
															adjTitle = "["
																	+ param.cateName
																	+ "]"
																	+ param.mstoryTitle;
															if (imgUrl
																	.indexOf("noMovie_") > 0) {
																imgUrl = "/resource/image/web/default/noMovie_4x3_640.jpg"
															}
														} else {
															if ("nws" == type) {
																adjTitle = param.message;
																longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type=art&sId="
																		+ artistId
																		+ "&menuId="
																		+ menuId;
																longUrl = longUrl
																		+ "&frm=nws";
																if (imgUrl
																		.indexOf("noAlbum_") > 0) {
																	imgUrl = "/resource/image/web/default/noAlbum_500.jpg"
																} else {
																	if (imgUrl
																			.indexOf("/cm/album/images/") > 0) {
																		imgUrl = melon.sns
																				.getImgUrlByWidth(
																						imgUrl,
																						500)
																	}
																}
															} else {
																if ("ntz" == type) {
																	adjTitle = "멜론 주간 어워드 투표 진행중! 빨리 투표에 참여하세요";
																	imgUrl = "http://image.melon.co.kr/resource/image/web/chart/award_op.jpg"
																} else {
																	if ("apl" == type) {
																		adjTitle = param.playlistName
																				+ " by "
																				+ param.artistNameWebList;
																		var memberKey = param.memberKey;
																		var updtDate = param.updtDate;
																		if (imgUrl
																				.indexOf("noAlbum_") > 0) {
																			imgUrl = "/resource/image/web/default/noAlbum_500.jpg"
																		} else {
																			imgUrl = melon.sns
																					.getImgUrlByWidth(
																							imgUrl,
																							500)
																		}
																		imgUrl = imgUrl
																				+ "?tm="
																				+ updtDate
																	} else {
																		if ("afr" == type) {
																			adjTitle = param.message;
																			longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type="
																					+ type
																					+ "&sId="
																					+ artistId
																					+ "&menuId="
																					+ menuId;
																			var memberKey = param.memberKey;
																			var temperature = param.temperature;
																			var totalUserRank = param.totalUserRank;
																			var userRank = param.userRank;
																			var isMeArtist = param.isMeArtist;
																			if (temperature == undefined
																					|| temperature == "undefined"
																					|| temperature == "") {
																				temperature = "0"
																			}
																			imgUrl = "/resource/image/cds/artist/feel/facebook_"
																					+ temperature
																					+ ".png";
																			if (contsId == null
																					|| contsId == "0") {
																				contsId = artistId
																			}
																		} else {
																			if ("thk" == type) {
																				adjTitle = param.artistName
																						+ "님의 THANK YOU  메시지";
																				longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type="
																						+ type
																						+ "&sId="
																						+ contsId
																						+ "&artId="
																						+ artistId
																						+ "&menuId="
																						+ menuId;
																				if (imgUrl == ""
																						|| imgUrl
																								.indexOf("noAlbum_") > 0) {
																					imgUrl = "/resource/image/web/default/noAlbum_500.jpg"
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
						cbUrl = melon.sns.getShortenUrl({
							longUrl : longUrl,
							type : type,
							ref : "facebook",
							contsId : contsId,
							menuId : menuId
						});
						melon.sns.outPostingLog("facebook", type, contsId);
						strStatus = "u=" + cbUrl + "&t="
								+ encodeURIComponent(adjTitle);
						if (imgUrl != null) {
							if (imgUrl.indexOf("http") < 0) {
								imgUrl = "http://image.melon.co.kr" + imgUrl
							}
						}
						if ("mvd" == type) {
							cbUrl = fbFeedUrl
						}
						var facebookURL = "https://www.facebook.com/dialog/feed?app_id=357952407588971&display=popup&name="
								+ encodeURIComponent(adjTitle)
								+ "&description="
								+ encodeURIComponent(adjDescription)
								+ "&picture="
								+ imgUrl
								+ "&link="
								+ cbUrl
								+ "&redirect_uri="
								+ redirectUrl
								+ "&caption=www.melon.com";
						window
								.open(facebookURL, "fbPosting",
										"width=700, height=540, status=no, toolbar=no,resizable=no")
					},
					twitter : function(param) {
						var adjTitle = "";
						var strStatus = "";
						var cbUrl = "";
						var type = param.type;
						var contsId = param.contsId;
						var menuId = param.menuId;
						if (menuId == undefined || menuId == "undefined") {
							menuId = ""
						}
						var artistId = param.artistId;
						if (artistId == undefined || artistId == "undefined") {
							artistId = ""
						}
						var subType = param.subType;
						if (subType == undefined || subType == null
								|| subType == "undefined") {
							subType = ""
						}
						var longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type="
								+ type
								+ "&sId="
								+ contsId
								+ "&menuId="
								+ menuId;
						if ("son" == type) {
							adjTitle = param.songName + " - "
									+ param.artistName + " - 들어보세요."
						} else {
							if ("alb" == type) {
								adjTitle = param.artistName + "의 "
										+ param.albumName + " - 추천합니다."
							} else {
								if ("art" == type) {
									adjTitle = param.artistName + " - 좋아합니다."
								} else {
									if ("playlist" == type || "ply" == type) {
										adjTitle = param.playlistName + " by "
												+ param.memberNickName
									} else {
										if ("oalbum" == type || "oab" == type
												|| "djc" == type) {
											adjTitle = "DJ 플레이리스트 :: "
													+ param.playlistName
													+ " by "
													+ param.memberNickName
										} else {
											if ("pht" == type) {
												adjTitle = param.artistName
														+ "의 포토를 좋아합니다.";
												longUrl = longUrl + "&artId="
														+ artistId
											} else {
												if ("mvd" == type) {
													longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type="
															+ type
															+ "&sId="
															+ contsId
															+ "&menuId="
															+ menuId
															+ "&subType="
															+ subType;
													adjTitle = param.artistName
															+ "의 "
															+ param.mvdName
															+ " - 감상해보세요."
												} else {
													if ("djm" == type) {
														adjTitle = "DJ 매거진 :: "
																+ param.magaznName
																+ " by "
																+ param.magaznNickname
													} else {
														if ("mus" == type) {
															adjTitle = "["
																	+ param.cateName
																	+ "]"
																	+ param.mstoryTitle
														} else {
															if ("nws" == type) {
																adjTitle = param.message;
																longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type=art&sId="
																		+ artistId
																		+ "&menuId="
																		+ menuId;
																longUrl = longUrl
																		+ "&frm=nws"
															} else {
																if ("ntz" == type) {
																	adjTitle = "멜론 주간 어워드 투표 진행중! 빨리 투표에 참여하세요"
																} else {
																	if ("apl" == type) {
																		adjTitle = "아티스트 플레이리스트 :: "
																				+ param.playlistName
																				+ " by "
																				+ param.artistNameWebList
																	} else {
																		if ("afr" == type) {
																			adjTitle = param.message;
																			longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type="
																					+ type
																					+ "&sId="
																					+ artistId
																					+ "&menuId="
																					+ menuId;
																			if (contsId == null
																					|| contsId == "0") {
																				contsId = artistId
																			}
																		} else {
																			if ("thk" == type) {
																				adjTitle = param.artistName
																						+ "님의 THANK YOU  메시지";
																				longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type="
																						+ type
																						+ "&sId="
																						+ contsId
																						+ "&artId="
																						+ artistId
																						+ "&menuId="
																						+ menuId
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
						cbUrl = melon.sns.getShortenUrl({
							longUrl : longUrl,
							type : type,
							ref : "twitter",
							contsId : contsId,
							menuId : menuId
						});
						melon.sns.outPostingLog("twitter", type, contsId);
						try {
							adjTitle = MELON.WEBSVC.string
									.unescapeHTML(adjTitle)
						} catch (e) {
						}
						strStatus = encodeURIComponent(adjTitle + " " + cbUrl
								+ " #MelOn");
						var twitURL = "http://twitter.com/home?status="
								+ strStatus;
						window.open(twitURL)
					},
					cyworld : function(param) {
						var adjTitle = "";
						var strStatus = "";
						var cbUrl = "";
						var adjSummary = " ";
						var type = param.type;
						var contsId = param.contsId;
						var menuId = param.menuId;
						if (menuId == undefined || menuId == "undefined") {
							menuId = ""
						}
						var artistId = param.artistId;
						if (artistId == undefined || artistId == "undefined") {
							artistId = ""
						}
						var longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type="
								+ type
								+ "&sId="
								+ contsId
								+ "&ref=cyworld&menuId=" + menuId;
						if ("son" == type) {
							adjTitle = param.songName + "-" + param.artistName;
							if (param.albumName != undefined
									&& param.albumName != "") {
								adjSummary += "[앨범]" + param.albumName
							}
							if (param.adjDate != undefined
									&& param.adjDate != "") {
								param.adjDate = melon.sns.formatDate(
										param.adjDate, ".");
								adjSummary += " (발매일 : " + param.adjDate + ")"
							}
						} else {
							if ("alb" == type) {
								adjTitle = param.albumName + "-"
										+ param.artistName;
								if (param.adjDate != undefined
										&& param.adjDate != "") {
									param.adjDate = melon.sns.formatDate(
											param.adjDate, ".");
									adjSummary += " (발매일 : " + param.adjDate
											+ ")"
								}
							} else {
								if ("art" == type) {
									adjTitle = param.artistName;
									if (param.adjNation != "") {
										adjSummary += "(국적 : "
												+ param.adjNation + ")"
									}
								} else {
									if ("playlist" == type || "ply" == type) {
										adjTitle = param.playlistName + "-"
												+ param.memberNickName;
										adjSummary = "  "
									} else {
										if ("oalbum" == type || "oab" == type
												|| "djc" == type) {
											adjTitle = param.playlistName + "-"
													+ param.memberNickName;
											adjSummary = "  "
										} else {
											if ("pht" == type) {
												adjTitle = param.artistName;
												longUrl = longUrl + "&artId="
														+ artistId;
												adjSummary = "  "
											} else {
												if ("mvd" == type) {
													adjTitle = param.mvdName
															+ "-"
															+ param.artistName;
													adjSummary = "  "
												} else {
													if ("djm" == type) {
														adjTitle = param.magaznName
																+ "-"
																+ param.magaznNickname;
														adjSummary = "  "
													} else {
														if ("mus" == type) {
															adjTitle = "["
																	+ param.cateName
																	+ "]"
																	+ param.mstoryTitle;
															adjSummary = "  "
														} else {
															if ("nws" == type) {
																adjTitle = param.message;
																longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type=art&sId="
																		+ contsId
																		+ "&menuId="
																		+ menuId;
																longUrl = longUrl
																		+ "&frm=nws";
																adjSummary = "  "
															} else {
																if ("ntz" == type) {
																	adjTitle = "멜론 주간 어워드 투표 진행중! 빨리 투표에 참여하세요";
																	param.imgUrl = "http://image.melon.co.kr/resource/image/web/chart/award_op.jpg";
																	adjSummary = "  "
																} else {
																	if ("apl" == type) {
																		adjTitle = param.playlistName
																				+ "-"
																				+ param.artistNameWebList;
																		adjSummary = "  "
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
						var imgUrl = param.imgUrl;
						if (imgUrl.indexOf("http") < 0) {
							imgUrl = "http://image.melon.co.kr" + imgUrl
						}
						var writer = "음악이 필요한 순간, 멜론";
						strStatus = "url=" + encodeURIComponent(longUrl)
								+ "&thumbnail=" + encodeURIComponent(imgUrl)
								+ "&title_nobase64="
								+ encodeURIComponent(adjTitle)
								+ "&summary_nobase64="
								+ encodeURIComponent(adjSummary) + "&writer="
								+ encodeURIComponent(writer);
						var cyworldURL = "http://csp.cyworld.com/bi/bi_recommend_pop.php?"
								+ strStatus;
						melon.sns.outPostingLog("cyworld", type, contsId);
						window
								.open(cyworldURL, "recom_icon_pop",
										"width=400,height=364,scrollbars=no,resizable=no")
					},
					nate : function(param) {
						var adjTitle = "";
						var strStatus = "";
						var cbUrl = "";
						var type = param.type;
						var contsId = param.contsId;
						var menuId = param.menuId;
						if (menuId == undefined || menuId == "undefined") {
							menuId = ""
						}
						var artistId = param.artistId;
						if (artistId == undefined || artistId == "undefined") {
							artistId = ""
						}
						var longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type="
								+ type
								+ "&sId="
								+ contsId
								+ "&menuId="
								+ menuId;
						if ("son" == type) {
							adjTitle = param.songName + " - "
									+ param.artistName
						} else {
							if ("alb" == type) {
								adjTitle = param.artistName + "의 "
										+ param.albumName + " 좋아합니다!"
							} else {
								if ("art" == type) {
									adjTitle = param.artistName + " 좋아합니다!"
								} else {
									if ("playlist" == type || "ply" == type) {
										adjTitle = param.memberNickName + "의 "
												+ param.playlistName
												+ " 좋아합니다!"
									} else {
										if ("oalbum" == type || "oab" == type
												|| "djc" == type) {
											adjTitle = param.memberNickName
													+ "의 " + param.playlistName
													+ " 좋아합니다!"
										} else {
											if ("pht" == type) {
												adjTitle = param.artistName
														+ "의 포토를 좋아합니다!";
												longUrl = longUrl + "&artId="
														+ artistId
											} else {
												if ("mvd" == type) {
													adjTitle = param.artistName
															+ "의 "
															+ param.mvdName
															+ " 좋아합니다!"
												} else {
													if ("djm" == type) {
														adjTitle = param.magaznNickname
																+ "의 "
																+ param.magaznName
																+ " 좋아합니다!"
													} else {
														if ("mus" == type) {
															adjTitle = "["
																	+ param.cateName
																	+ "]"
																	+ param.mstoryTitle
														} else {
															if ("nws" == type) {
																adjTitle = param.message;
																longUrl = "http://m.melon.com/pda/msvc/snsGatePage.jsp?type=art&sId="
																		+ contsId
																		+ "&menuId="
																		+ menuId;
																longUrl = longUrl
																		+ "&frm=nws"
															} else {
																if ("ntz" == type) {
																	adjTitle = "멜론 주간 어워드 투표 진행중! 빨리 투표에 참여하세요"
																} else {
																	if ("apl" == type) {
																		adjTitle = param.artistNameWebList
																				+ "의 "
																				+ param.playlistName
																				+ " 좋아합니다!"
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
						cbUrl = melon.sns.getShortenUrl({
							longUrl : longUrl,
							type : type,
							ref : "nate",
							contsId : contsId,
							menuId : menuId
						});
						melon.sns.outPostingLog("nate", type, contsId);
						strStatus = "u=" + cbUrl + "&t="
								+ encodeURIComponent(adjTitle);
						strStatus = encodeURIComponent(adjTitle + " " + cbUrl
								+ " #MelOn");
						var nateURL = "http://api.nateon.nate.com/web/note/SendNote.do?msg="
								+ encodeURIComponent(adjTitle)
								+ "&lurl="
								+ encodeURIComponent(cbUrl);
						window
								.open(nateURL, "note",
										"width=500,height=540,scrollbars=no,resizable=no")
					},
					getShortenUrl : function(param) {
						var url = "/sns/snsposting_informShortenUrl.json";
						if (param != null && param.ref != null
								&& param.ref != undefined) {
							url += "?ref=" + param.ref;
							param.longUrl += "&ref=" + param.ref
						}
						if (param != null && param.type != null
								&& typeof (param.type) != undefined) {
							if (url.indexOf("?") != -1) {
								url += "&page=" + param.type;
								param.longUrl += "&page=" + param.type
							} else {
								url += "?page=" + param.type;
								param.longUrl += "?page=" + param.type
							}
						}
						if (param != null && param.menuId != null
								&& typeof (param.menuId) != undefined) {
							if (url.indexOf("?") != -1) {
								url += "&menuId=" + param.menuId
							} else {
								url += "?menuId=" + param.menuId
							}
						}
						if (param != null && param.contsId != null
								&& typeof (param.contsId) != undefined) {
							if (url.indexOf("?") != -1) {
								url += "&contsId=" + param.contsId;
								param.longUrl += "&contsId=" + param.contsId
							} else {
								url += "?contsId=" + param.contsId;
								param.longUrl += "?contsId=" + param.contsId
							}
						}
						var shortUrl = "";
						param.longUrl = melon.sns.getUrlRemake({
							url : param.longUrl
						});
						$
								.ajax({
									type : "GET",
									url : melon.sns.getUrlRemake({
										url : url
									}),
									data : "longUrl="
											+ encodeURIComponent(param.longUrl),
									dataType : "json",
									async : false,
									success : function(json) {
										var jsonObj = eval("(" + json.resultStr
												+ ")");
										shortUrl = jsonObj.results[param.longUrl].shortUrl
									}
								});
						return shortUrl
					},
					getShortenUrl2 : function(param) {
						var url = "/sns/snsposting_informShortenUrl.json";
						if (param != null && param.ref != null
								&& param.ref != undefined) {
							url += "?ref=" + param.ref
						}
						if (param != null && param.type != null
								&& typeof (param.type) != undefined) {
							if (url.indexOf("?") != -1) {
								url += "&page=" + param.type
							} else {
								url += "?page=" + param.type
							}
						}
						if (param != null && param.menuId != null
								&& typeof (param.menuId) != undefined) {
							if (url.indexOf("?") != -1) {
								url += "&menuId=" + param.menuId
							} else {
								url += "?menuId=" + param.menuId
							}
						}
						if (param != null && param.contsId != null
								&& typeof (param.contsId) != undefined) {
							if (url.indexOf("?") != -1) {
								url += "&contsId=" + param.contsId
							} else {
								url += "?contsId=" + param.contsId
							}
						}
						var shortUrl = "";
						$
								.ajax({
									type : "GET",
									url : melon.sns.getUrlRemake({
										url : url
									}),
									data : "longUrl="
											+ encodeURIComponent(param.longUrl),
									dataType : "json",
									async : false,
									success : function(json) {
										var jsonObj = eval("(" + json.resultStr
												+ ")");
										shortUrl = jsonObj.results[param.longUrl].shortUrl
									}
								});
						return shortUrl
					},
					getUrlRemake : function(param) {
						var da = new Date();
						var millisecond = da.getMilliseconds();
						var url = param.url;
						if (url.indexOf("?") >= 0) {
							url = url + "&ajax_ts=" + millisecond
						} else {
							url = url + "?ajax_ts=" + millisecond
						}
						return url
					},
					formatDate : function(date, gubun) {
						var returnDate = "";
						if (date == null || date == "" || date.length < 8) {
							return returnDate
						} else {
							if (date == "00000000") {
								returnDate = ""
							} else {
								var year = date.substring(0, 4);
								var month = date.substring(4, 6);
								var day = date.substring(6, 8);
								if (year != "0000" && year != "") {
									returnDate = year
								}
								if (month != "00" && month != "") {
									returnDate += gubun + month
								}
								if (day != "0000" && day != "") {
									returnDate += gubun + day
								}
							}
							return returnDate
						}
					},
					outPostingLog : function(ref, page, sId) {
						if (page != undefined && page == "playlist") {
							page = "ply"
						}
						if (page != undefined && page == "oalbum") {
							page = "djc"
						}
						var memberKey = getMemberKey();
						$.ajax({
							type : "POST",
							url : "/sns/snsposting_outPostingLog.json",
							data : {
								ref : ref,
								page : page,
								sId : sId,
								uKey : memberKey
							},
							success : function(result) {
							}
						})
					},
					getImgUrlByWidth : function(imgUrl, width) {
						if (imgUrl == null || imgUrl == undefined) {
							return ""
						}
						var dotIdx = imgUrl.lastIndexOf(".");
						if (dotIdx < 0) {
							return ""
						}
						var preFix = imgUrl.substring(0, dotIdx);
						var postFix = imgUrl.substring(dotIdx, imgUrl.length);
						return preFix + "_" + width + postFix
					}
				},
				show : {
					moreButton : function(id, height, buttonTarget) {
						var realHeight = $("#" + id).height();
						$("#" + id).css("height", height + "px");
						if (height < realHeight) {
							if (buttonTarget != null && buttonTarget != "") {
								$("#" + buttonTarget).show()
							} else {
								$(".arrow_d").show()
							}
						}
					}
				}
			}, commentObj = {
				goArtistDtl : function(artistId) {
					MELON.WEBSVC.POC.link.goArtistDetail(artistId, 0)
				},
				goVideoDtl : function(menuId, mvId) {
					MELON.WEBSVC.POC.link.goMvDetail(menuId, mvId, "")
				},
				goAlbumDtl : function(albumId) {
					MELON.WEBSVC.POC.link.goAlbumDetail(albumId)
				},
				goSongDtl : function(songId) {
					MELON.WEBSVC.POC.link.goSongDetail(songId)
				},
				playSong : function(menuId, contentId, isAdultContent) {
					MELON.WEBSVC.POC.play.playSong(menuId, contentId)
				},
				playAlbum : function(menuId, albumId) {
					MELON.WEBSVC.POC.play.playAlbum(menuId, albumId)
				},
				goLogIn : function() {
					MELON.WEBSVC.POC.login.loginPopupLayerd()
				},
				goBuyProduct : function(formName, contsId, contsType,
						paramsName, buyType, menuId, exceptAll) {
					MELON.WEBSVC.POC.buy.goBuyProduct(formName, contsId,
							contsType, paramsName, buyType, menuId, exceptAll)
				}
			};
	var melonPlayerPakage__ = "MelonWebLinker.MelonLinker.1";
	var melonPlayerVersion__ = "5,14,613,13";
	var melonPlayerFunc = {
		getMelonPlayerObject : function() {
			var melonPlayerObject = "";
			var tmpAgent = navigator.userAgent.toUpperCase();
			if (tmpAgent.indexOf("MSIE") > -1
					|| tmpAgent.indexOf("TRIDENT") > -1) {
				melonPlayerObject += '<OBJECT ID="MelonWebLinker" WIDTH="0" HEIGHT="0" ';
				melonPlayerObject += 'codebase="http://www.melon.com/resource/cab/webplayer/MelonWebLinker.cab#version='
						+ melonPlayerVersion__ + '" ';
				melonPlayerObject += 'classid="clsid:C6710B89-FB87-4CE8-A719-565767E70D27">';
				melonPlayerObject += "</OBJECT>"
			} else {
				if (tmpAgent.indexOf("SAFARI") > -1) {
					melonPlayerObject += '<object id="MelonWebLinker" type="application/x-melonweblinker" width="0" height="0" ></object>'
				} else {
					if (tmpAgent.indexOf("APPLEWEBKIT/5") > -1) {
						melonPlayerObject += '<object id="MelonWebLinker" type="application/x-melonweblinker" width="0" height="0" ></object>'
					} else {
						if (tmpAgent.indexOf("MAC") > -1) {
							melonPlayerObject += '<object id="MelonWebLinker" type="application/x-melonweblinker" width="0" height="0" ></object>'
						} else {
							if (tmpAgent.indexOf("FIREFOX") > -1) {
								melonPlayerObject = '<object id="MelonWebLinker" type="application/x-melonweblinker" width="0" height="0">';
								melonPlayerObject += "</object>"
							} else {
								if (tmpAgent.indexOf("CHROME") > -1) {
									melonPlayerObject += '<object id="MelonWebLinker" type="application/x-melonweblinker" width="0" height="0" ></object>'
								} else {
									melonPlayerObject += '<object id="MelonWebLinker" type="application/x-melonweblinker" width="0" height="0" ></object>'
								}
							}
						}
					}
				}
			}
			return melonPlayerObject
		},
		chkMelonPlayerObject : function() {
			try {
				var packager = new ActiveXObject(melonPlayerPakage__);
				if (packager) {
					return true
				} else {
					return false
				}
			} catch (err) {
				return false
			}
		},
		browser : function() {
			var tmpAgent = navigator.userAgent.toUpperCase();
			var tmpBrowser = "ie";
			if (tmpAgent.indexOf("MSIE") > -1
					|| tmpAgent.indexOf("TRIDENT") > -1) {
				tmpBrowser = "ie"
			} else {
				if (tmpAgent.indexOf("OPR") > -1
						|| tmpAgent.indexOf("OPERA") > -1) {
					tmpBrowser = "opera"
				} else {
					if (tmpAgent.indexOf("CHROME") > -1) {
						tmpBrowser = "chrome"
					} else {
						if (tmpAgent.indexOf("SAFARI") > -1) {
							tmpBrowser = "safari"
						} else {
							if (tmpAgent.indexOf("MAC") > -1) {
								tmpBrowser = "chrome"
							} else {
								if (tmpAgent.indexOf("FIREFOX") > -1) {
									tmpBrowser = "firefox"
								} else {
									if (tmpAgent.indexOf("APPLEWEBKIT/5") > -1) {
										tmpBrowser = "safari"
									} else {
										if (tmpAgent.indexOf("EDGE") > -1) {
											tmpBrowser = "edge"
										} else {
											tmpBrowser = "none"
										}
									}
								}
							}
						}
					}
				}
			}
			return tmpBrowser
		}
	};
	var PARAM_DELIMITER = "";
	var PARAM_DELIMITER_END = ":";
	var itemFlagArray = new Array();
	var itemIdArray = new Array();
	var contentFlagArray = new Array();
	var playItem = "";
	var downloadItem = "";
	var PLAYER_RETURN = "";
	var PLAYER_RETURN_SUCCESS = "RETURN_TOBROWSER_NEED_NOTHING";
	var LOGIN_KEY_CHECK = "";
	var LOGIN_ID_CHECK = "";
	var MELON_PLAYER_OCX_HTTP_HOME = "http://www.melon.com";
	if (typeof httpWww != "undefined" && httpWww != null && httpWww != "") {
		MELON_PLAYER_OCX_HTTP_HOME = httpWww
	}
	var IMAGE_HOME = "http://image.melon.co.kr";
	var player = {
		ocxPlay : function(menuId, itemFlags, itemIds, targetMemberKey) {
			if (typeof targetMemberKey == "undefined") {
				targetMemberKey = getMemberKey() == "" ? 0 : getMemberKey()
			}
			var RETURN_NOT_LOGIN = "0";
			var RETURN_LOGIN = "1";
			var SHOWCASE_ID = "121";
			var itemFlag = "";
			var itemId = "";
			var playList = "";
			if (itemFlags.length > 1) {
				for (var i = 0; i < itemFlags.length; i++) {
					itemFlag = itemFlag + itemFlags[i];
					if (i < (itemFlags.length - 1)) {
						itemFlag = itemFlag + PARAM_DELIMITER
					}
				}
			} else {
				itemFlag = itemFlags[0]
			}
			if (itemIds.length > 0) {
				for (var i = 0; i < itemIds.length; i++) {
					itemId = itemId + itemIds[i];
					itemId = itemId + PARAM_DELIMITER;
					playList += itemFlags[i] + PARAM_DELIMITER + itemIds[i]
							+ PARAM_DELIMITER + targetMemberKey
							+ PARAM_DELIMITER + menuId + PARAM_DELIMITER
							+ PARAM_DELIMITER_END
				}
			}
			player.melonplayerPlay(menuId, itemFlags, itemIds, playList)
		},
		melonplayerActualPlay : function(params) {
			var IS_INPUT_AUTHENTICATION_ADULT_PWD = getCookie("IS_INPUT_AUTHENTICATION_ADULT_PWD");
			var memberAuthFlg = isMemberAdult();
			var p_sessionAuthYN = IS_INPUT_AUTHENTICATION_ADULT_PWD == "Y" ? "1"
					: "0";
			var p_realNameYN = isRealNameFlag();
			var p_adultYN = isMemberAdult() == "0" ? "0" : "1";
			var p_adultOptAutoYN = getMemberAuthFlg() == "3" ? "2"
					: getMemberAuthFlg() == "2" ? "1"
							: getMemberAuthFlg() == "5" ? "1" : "0";
			params += " /a " + p_sessionAuthYN + p_realNameYN + p_adultYN
					+ p_adultOptAutoYN;
			$("body").append(melonPlayerFunc.getMelonPlayerObject());
			var MELON_PLAYER = document.getElementById("MelonWebLinker");
			if (params.indexOf("ie") > -1) {
				if (!melonPlayerFunc.chkMelonPlayerObject()) {
					if (getCookie("melon_player_setup_status") != "1") {
						alert(" 멜론플레이어가 정상적으로 설치되지 않았습니다.\n 멜론플레이어 설치가 필요합니다.");
						setCookie("melon_player_setup_status", "1", 10, "/", "");
						return
					}
					setTimeout("melonplayerActualPlay('" + params + "')", 1000)
				} else {
					if (MELON_PLAYER && MELON_PLAYER != null) {
						try {
							MELON_PLAYER.MelOnInvoke(params)
						} catch (e) {
						}
						setCookie("melon_player_setup_status", "0", -1, "/", "");
						return
					}
				}
			} else {
				if (params.indexOf("chrome") > -1) {
					var isPlugInSetup = false;
					var plugInNameStr = "";
					for (var idx = 0; idx < navigator.plugins.length; idx++) {
						plugInNameStr += navigator.plugins[idx].name + ", ";
						if (navigator.plugins[idx].name
								.indexOf("MelOnWebLinker") > -1) {
							isPlugInSetup = true
						}
					}
					if (isPlugInSetup) {
						MELON_PLAYER.MelOnInvoke(params)
					} else {
						window
								.open(
										"http://www.melon.com/plugin/popup/plugin_install.htm",
										"_blank",
										"width=560, height=330, location=no,menubar=no,toolbar=no,scrollbars=yes,resizable=no,status=no")
					}
				} else {
					var isPlugInSetup = false;
					for (var idx = 0; idx < navigator.plugins.length; idx++) {
						if (navigator.plugins[idx].name
								.indexOf("MelOnWebLinker") > -1) {
							isPlugInSetup = true
						}
					}
					if (isPlugInSetup) {
						MELON_PLAYER.MelOnInvoke(params)
					} else {
						window
								.open(
										"http://www.melon.com/plugin/popup/plugin_install.htm",
										"_blank",
										"width=560, height=330, location=no,menubar=no,toolbar=no,scrollbars=yes,resizable=no,status=no")
					}
				}
			}
		},
		melonplayerActualPlaySocket : function(menuId, itemFlags, itemList) {
			var IS_INPUT_AUTHENTICATION_ADULT_PWD = getCookie("IS_INPUT_AUTHENTICATION_ADULT_PWD");
			var memberAuthFlg = isMemberAdult();
			var p_sessionAuthYN = IS_INPUT_AUTHENTICATION_ADULT_PWD == "Y" ? "1"
					: "0";
			var p_realNameYN = isRealNameFlag();
			var p_adultYN = isMemberAdult() == "0" ? "0" : "1";
			var tmpMemberAuthFlg = getMemberAuthFlg();
			var p_adultOptAutoYN = tmpMemberAuthFlg == "3" ? "2"
					: tmpMemberAuthFlg == "2" ? "1"
							: tmpMemberAuthFlg == "5" ? "1" : "0";
			var p_command = itemFlags == "smart" ? "smartradio" : "play";
			var fromMPS = getCookie("MPS");
			var fromMPSYn = fromMPS == null
					|| fromMPS.indexOf("MELONPLAYER") < 0;
			if (fromMPSYn) {
				var rParam = {
					USERID : getMemberId(),
					USERNO : getMemberKey(),
					COMMAND : p_command,
					BROWSER : navigator.userAgent,
					SESSIONAUTH : p_sessionAuthYN,
					REALNAMETYPE : p_realNameYN,
					ADULTTYPE : p_adultYN,
					PASSWORDAUTOOPTION : p_adultOptAutoYN,
					LOGINTIME : "201506041145",
					LIST : itemList
				};
				$.fn.chkNotifyInstalled();
				var localCnt = 0;
				var retry = setInterval(function() {
					if ($.isNotifyInstalled) {
						$.fn.socketPlay(JSON.stringify(rParam))
					}
					localCnt++;
					if (localCnt == 5 || $.isNotifyInstalled) {
						clearInterval(retry);
						if (!$.isNotifyInstalled) {
						}
					}
				}, 1500)
			} else {
				if (itemList.length > 1) {
					var itemsInfo = new MelOnAPIHelper();
					for (var idx = 0; idx < itemList.length; idx++) {
						itemsInfo
								.append(itemList[idx].itemIDType,
										itemList[idx].itemID,
										itemList[idx].statisticID)
					}
					var itemInfo = unescape(JSON.stringify(itemsInfo).replace(
							/\\u/g, "%u"));
					if (itemFlags == "smart") {
						MelonAPI.action("smartRadioDetailTabOpen", itemInfo)
					} else {
						MelonAPI.action("listenMusic", itemInfo)
					}
				} else {
					for (var idx = 0; idx < itemList.length; idx++) {
						var itemInfo = unescape(JSON.stringify(itemList[idx])
								.replace(/\\u/g, "%u"));
						if (itemFlags == "smart") {
							MelonAPI
									.action("smartRadioDetailTabOpen", itemInfo)
						} else {
							MelonAPI.action("listenMusic", itemInfo)
						}
					}
				}
			}
		},
		melonplayerActualPlayHighVdo : function(params) {
			var IS_INPUT_AUTHENTICATION_ADULT_PWD = getCookie("IS_INPUT_AUTHENTICATION_ADULT_PWD");
			var memberAuthFlg = isMemberAdult();
			var p_sessionAuthYN = IS_INPUT_AUTHENTICATION_ADULT_PWD == "Y" ? "1"
					: "0";
			var p_realNameYN = isRealNameFlag();
			var p_adultYN = isMemberAdult() == "0" ? "0" : "1";
			var p_adultOptAutoYN = "1";
			params += " /a " + p_sessionAuthYN + p_realNameYN + p_adultYN
					+ p_adultOptAutoYN;
			$("body").append(melonPlayerFunc.getMelonPlayerObject());
			var MELON_PLAYER = document.getElementById("MelonWebLinker");
			if (params.indexOf("ie") > -1) {
				if (!melonPlayerFunc.chkMelonPlayerObject()) {
					if (getCookie("melon_player_setup_status") != "1") {
						alert(" 멜론플레이어가 정상적으로 설치되지 않았습니다.\n 멜론플레이어 설치가 필요합니다.");
						setCookie("melon_player_setup_status", "1", 10, "/", "");
						return
					}
					setTimeout("melonplayerActualPlay('" + params + "')", 1000)
				} else {
					if (MELON_PLAYER && MELON_PLAYER != null) {
						try {
							MELON_PLAYER.MelOnInvoke(params)
						} catch (e) {
						}
						setCookie("melon_player_setup_status", "0", -1, "/", "");
						return
					}
				}
			} else {
				if (params.indexOf("chrome") > -1) {
					var isPlugInSetup = false;
					var plugInNameStr = "";
					for (var idx = 0; idx < navigator.plugins.length; idx++) {
						plugInNameStr += navigator.plugins[idx].name + ", ";
						if (navigator.plugins[idx].name
								.indexOf("MelOnWebLinker") > -1) {
							isPlugInSetup = true
						}
					}
					if (isPlugInSetup) {
						MELON_PLAYER.MelOnInvoke(params)
					} else {
						window
								.open(
										"http://www.melon.com/plugin/popup/plugin_install.htm",
										"_blank",
										"width=560, height=330, location=no,menubar=no,toolbar=no,scrollbars=yes,resizable=no,status=no")
					}
				} else {
					var isPlugInSetup = false;
					for (var idx = 0; idx < navigator.plugins.length; idx++) {
						if (navigator.plugins[idx].name
								.indexOf("MelOnWebLinker") > -1) {
							isPlugInSetup = true
						}
					}
					if (isPlugInSetup) {
						MELON_PLAYER.MelOnInvoke(params)
					} else {
						window
								.open(
										"http://www.melon.com/plugin/popup/plugin_install.htm",
										"_blank",
										"width=560, height=330, location=no,menubar=no,toolbar=no,scrollbars=yes,resizable=no,status=no")
					}
				}
			}
		},
		melon_ocx_message : function(PLAYER_RETURN) {
			if (PLAYER_RETURN == 0) {
				return PLAYER_RETURN_SUCCESS
			} else {
				if (PLAYER_RETURN == 1) {
					if (confirm("음악을 듣기 위해서는 멜론 플레이어가 설치되어 있어야 합니다..\n멜론 플레이어를 설치하시겠습니까?")) {
						document.location.href = "http://appsvr.melon.com/cabv40/Melon4Setup.exe"
					}
					return "RETURN_TOBROWSER_NEED_INSTALL"
				} else {
					if (PLAYER_RETURN == -1) {
						alert("쿠키 정보가 없습니다 : ERROR_CODE=[RETURN_TOBROWSER_FAILURE_COOKIE]");
						return "RETURN_TOBROWSER_FAILURE_COOKIE"
					} else {
						if (PLAYER_RETURN == -2) {
							alert("오류가 발생했습니다. 잠시 후에 다시 이용해 주십시오.");
							return "RETURN_TOBROWSER_FAILURE_HTTPCALL"
						} else {
							if (PLAYER_RETURN == -3) {
								alert("오류가 발생했습니다. 잠시 후에 다시 이용해 주십시오.");
								return "RETURN_TOBROWSER_FAILURE_HTTPCALL_STATUS"
							} else {
								if (PLAYER_RETURN == -4) {
									return PLAYER_RETURN_SUCCESS
								} else {
									if (PLAYER_RETURN == -5) {
										alert("사용자 정보가 불충합니다. 잠시 후에 다시 이용해 주십시오.");
										return "RETURN_TOBROWSER_FAILURE"
									} else {
										if (PLAYER_RETURN == -6) {
											alert("서버와의 통신상에 Error가 발생했습니다. \n잠시 후에 다시 이용해 주십시오.");
											return "RETURN_TOBROWSER_FAILURE"
										} else {
											if (PLAYER_RETURN == -10001) {
												alert("오류가 발생했습니다. 잠시 후에 다시 이용해 주십시오.");
												return "RETURN_TOBROWSER_FAILURE"
											} else {
												if (PLAYER_RETURN == -10204) {
													alert("권리사의 요청으로 서비스가 일시 중지된 곡입니다.");
													return "RETURN_TOBROWSER_FAILURE"
												} else {
													if (PLAYER_RETURN == -10201) {
														alert("음악 정보가 존재하지 않습니다.");
														return "RETURN_TOBROWSER_FAILURE"
													} else {
														if (PLAYER_RETURN == -10202) {
															alert("앨범 정보가 존재하지 않습니다.");
															return "RETURN_TOBROWSER_FAILURE"
														} else {
															if (PLAYER_RETURN == -10203) {
																alert("상품 정보가 존재하지 않습니다.");
																return "RETURN_TOBROWSER_FAILURE"
															} else {
																if (PLAYER_RETURN == -10300) {
																	alert("구매하지 않은 음악입니다.");
																	return "RETURN_TOBROWSER_FAILURE"
																} else {
																	if (PLAYER_RETURN == -10301) {
																		alert("선물 받지 않은 음악입니다.");
																		return "RETURN_TOBROWSER_FAILURE"
																	} else {
																		if (PLAYER_RETURN == -10302) {
																			alert("다운로드 기간이 지났습니다.");
																			return "RETURN_TOBROWSER_FAILURE"
																		} else {
																			if (PLAYER_RETURN == -10406) {
																				alert("오류가 발생했습니다. 잠시 후에 다시 이용해 주십시오.");
																				return "RETURN_TOBROWSER_FAILURE"
																			} else {
																				if (PLAYER_RETURN == -10409) {
																					alert("오류가 발생했습니다. 잠시 후에 다시 이용해 주십시오.");
																					return "RETURN_TOBROWSER_FAILURE"
																				} else {
																					if (PLAYER_RETURN == -10207) {
																						location.href = "/cds/common/web/popnotice_list.htm?ptype=NL";
																						return "RETURN_TOBROWSER_FAILURE"
																					} else {
																						if (PLAYER_RETURN < 0) {
																							alert("오류가 발생했습니다. 잠시 후에 다시 이용해 주십시오.");
																							return "RETURN_TOBROWSER_FAILURE"
																						} else {
																							return ""
																						}
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		},
		melonplayerPlay : function(menuId, itemFlags, itemIds, playList) {
			var params = "/c ";
			if (isMelonLogin()) {
				var tmpItemIds = "";
				var arrItemIds = String(itemIds).split(",");
				var itemIdsLen = 1;
				var cmpBrowser = melonPlayerFunc.browser();
				var fromMPS = getCookie("MPS");
				var fromMPSYn = fromMPS == null
						|| fromMPS.indexOf("MELONPLAYER") < 0;
				var tmpObj = new Object();
				var itemList = [];
				if (menuId == "") {
					menuId = "58611"
				}
				if (itemFlags == "smart") {
					var parsedPlaylist = playList.replace(//gi, "^");
					var poArr = parsedPlaylist.split("^");
					if (fromMPSYn) {
						if (cmpBrowser == "chrome" || cmpBrowser == "edge"
								|| cmpBrowser == "safari"
								|| cmpBrowser == "firefox") {
							tmpObj = {
								CHID : poArr[0],
								CHINFO : poArr[1],
								CHYEAR : poArr[2],
								STATISTICID : poArr[3]
							};
							itemList.push(tmpObj);
							player.melonplayerActualPlaySocket(menuId,
									itemFlags, itemList)
						} else {
							playList = playList;
							params += "smartradio /b "
									+ melonPlayerFunc.browser() + " /i "
									+ getMemberId() + " /n " + getMemberKey()
									+ " /s " + playList;
							if (itemFlags == "21") {
								player.melonplayerActualPlayHighVdo(params)
							} else {
								player.melonplayerActualPlay(params)
							}
						}
					} else {
						tmpObj = {
							chinfo : poArr[1],
							chid : poArr[0],
							chname : "smart",
							genreyear : "",
							channelgubun : "A",
							statisticID : poArr[3]
						};
						itemList.push(tmpObj);
						player.melonplayerActualPlaySocket(menuId, itemFlags,
								itemList)
					}
				} else {
					if (itemFlags != "smart") {
						if (fromMPSYn) {
							if (cmpBrowser == "chrome" || cmpBrowser == "edge"
									|| cmpBrowser == "safari"
									|| cmpBrowser == "firefox") {
								for (var idx = 0; idx < itemIds.length; idx++) {
									tmpObj = {
										ITEMFLAG : itemFlags[idx],
										ITEMID : itemIds[idx],
										FRIENDNO : getMemberKey(),
										STATISTICID : menuId
									};
									itemList.push(tmpObj)
								}
								player.melonplayerActualPlaySocket(menuId,
										itemFlags, itemList)
							} else {
								if (itemFlags != "4") {
									itemIdsLen = itemIds.length
								} else {
									itemIdsLen = arrItemIds.length
								}
								playList = itemIdsLen + PARAM_DELIMITER
										+ playList;
								params += "play /b "
										+ melonPlayerFunc.browser() + " /i "
										+ getMemberId() + " /n "
										+ getMemberKey() + " /s " + playList;
								if (itemFlags == "21") {
									player.melonplayerActualPlayHighVdo(params)
								} else {
									player.melonplayerActualPlay(params)
								}
							}
						} else {
							for (var idx = 0; idx < itemIds.length; idx++) {
								tmpObj = {
									userNo : getMemberKey(),
									itemIDType : itemFlags[idx],
									itemID : itemIds[idx],
									statisticID : menuId
								};
								itemList.push(tmpObj)
							}
							player.melonplayerActualPlaySocket(menuId,
									itemFlags, itemList)
						}
					}
				}
			} else {
				return false
			}
		}
	};
	$.isNotifyInstalled = false;
	$.fn.chkNotifyInstalled = function() {
		try {
			console.log("ntfy install checking start.")
		} catch (e) {
		}
		$.isNotifyInstalled = false;
		var maxRetryCnt = 3;
		var nFailed_Count = 0;
		var reconnectionDelayMax = 1000;
		var DestinationIP = "http://127.0.0.1:46286";
		if ($("#notifyFrame").length < 1) {
			var notifyFrame = '<iframe id="notifyFrame" name="notifyFrame" width=0 height=0 src="" style="display:none;"></iframe>';
			$(notifyFrame).appendTo("body")
		}
		try {
			console.log("ntfy install checking... connect try...")
		} catch (e) {
		}
		try {
			var connectData = {
				reconnection : true,
				reconnectionDelay : 1000,
				reconnectionDelayMax : 2500,
				reconnectionAttempts : maxRetryCnt,
				"force new connection" : true
			};
			if (melonPlayerFunc.browser() == "ie"
					&& navigator.userAgent.indexOf("Trident") < 0) {
				connectData = {
					reconnection : true,
					timeout : 3000,
					reconnectionDelay : 1000,
					reconnectionDelayMax : 2500,
					reconnectionAttempts : maxRetryCnt,
					"force new connection" : true
				}
			}
			socketio = io.connect(DestinationIP, connectData)
		} catch (e) {
			console.log(e)
		}
		socketio.on("connect", function() {
			try {
				console.log("ntfy install checking... connect success...")
			} catch (e) {
			}
			try {
				$.isNotifyInstalled = true;
				nFailed_Count = 0;
				var checkParam = {
					USERID : getMemberId(),
					USERNO : getMemberKey(),
					COMMAND : "compversion",
					BROWSER : navigator.userAgent,
					VERSIONNO : "51562415"
				};
				socketio.emit("query", JSON.stringify(checkParam))
			} catch (e) {
			}
		});
		socketio
				.on(
						"result",
						function(result) {
							try {
								console
										.log("ntfy install checking... empty result...")
							} catch (e) {
							}
							var rsltObj = JSON.parse(result);
							try {
								console
										.log("ntfy install checking... result.STATUS"
												+ rsltObj.STATUS)
							} catch (e) {
							}
							socketio.close();
							if (rsltObj.STATUS == "-10001") {
								$.isNotifyInstalled = false;
								maxRetryCnt = 7;
								nFailed_Count = 0;
								if (navigator.userAgent.toUpperCase().indexOf(
										"MSIE 9") > -1 && false) {
									var ie9Win = window
											.open("", "",
													"scrollbars=no,location=no,width=0,height=0,toolbar=no,left=-10,top=-10");
									ie9Win.document
											.write("<iframe src='MelOnNtfy2:melonhandler' width=0, height=0, style='display:none;'></iframe>");
									setTimeout(function() {
										try {
											ie9Win.location.href;
											ie9Win.setTimeout("window.close()",
													500)
										} catch (e) {
											ie9Win.close()
										}
									}, 1000)
								} else {
									try {
										$("#notifyFrame").attr("src",
												"MelOnNtfy2:melonhandler")
									} catch (e) {
									}
								}
							}
						});
		socketio
				.on(
						"connect_error",
						function() {
							try {
								console
										.log("ntfy install checking... connect error..."
												+ nFailed_Count)
							} catch (e) {
							}
							nFailed_Count++;
							if (nFailed_Count == 1) {
								try {
									$("#notifyFrame").attr("src",
											"MelOnNtfy2:melonhandler")
								} catch (e) {
								}
							} else {
								if (nFailed_Count >= maxRetryCnt) {
									nFailed_Count = 0;
									try {
										socketio.close()
									} catch (e) {
									}
									$.isNotifyInstalled = false;
									window
											.open(
													"http://www.melon.com/plugin/popup/melonnotify_install.htm",
													"melonnotify_install",
													"width=560, height=330, location=no,menubar=no,toolbar=no,scrollbars=yes,resizable=no,status=no")
								}
							}
						});
		socketio
				.on(
						"disconnect",
						function() {
							try {
								console
										.log("ntfy install checking... disconnect after connect ...")
							} catch (e) {
							}
						})
	};
	$.fn.optShift = function() {
		var end = 0, start = 0;
		var $chk = this;
		$chk.click(function(event) {
			start = $chk.index(event.target);
			if (event.shiftKey) {
				if (start > end) {
					var temp = start;
					start = end;
					end = temp
				}
				for (var i = start; i < end; i++) {
					if (!$chk.eq(i).is(":disabled")) {
						$chk.eq(i).checked(true)
					}
				}
			}
			end = start
		})
	};
	$.fn.socketPlay = function(queryVal) {
		var maxRetryCnt = 3;
		var nFailed_Count = 0;
		var DestinationIP = "http://127.0.0.1:46286";
		if ($("#notifyFrame").length < 1) {
			var notifyFrame = '<iframe id="notifyFrame" name="notifyFrame" width=0 height=0 src="" style="display:none;"></iframe>';
			$(notifyFrame).appendTo("body")
		}
		if (typeof socketio == "undefined") {
			try {
				console.log("socketio.connect::start")
			} catch (e) {
			}
			try {
				var connectData = {
					reconnection : true,
					reconnectionDelay : 1000,
					reconnectionDelayMax : 1000,
					reconnectionAttempts : maxRetryCnt,
					"force new connection" : true
				};
				if (melonPlayerFunc.browser() == "ie"
						&& navigator.userAgent.indexOf("Trident") < 0) {
					connectData = {
						reconnection : true,
						timeout : 3000,
						reconnectionDelay : 1000,
						reconnectionDelayMax : 1000,
						reconnectionAttempts : maxRetryCnt,
						"force new connection" : true
					}
				}
				socketio = io.connect(DestinationIP, connectData)
			} catch (e) {
			}
		} else {
			if (socketio.disconnected) {
				try {
					console.log("socketio.live::disconnected:true")
				} catch (e) {
				}
				try {
					var connectData = {
						reconnection : true,
						reconnectionDelay : 1000,
						reconnectionDelayMax : 1000,
						reconnectionAttempts : maxRetryCnt,
						"force new connection" : true
					};
					if (melonPlayerFunc.browser() == "ie"
							&& navigator.userAgent.indexOf("Trident") < 0) {
						connectData = {
							reconnection : true,
							timeout : 3000,
							reconnectionDelay : 1000,
							reconnectionDelayMax : 1000,
							reconnectionAttempts : maxRetryCnt,
							"force new connection" : true
						}
					}
					socketio = io.connect(DestinationIP, connectData)
				} catch (e) {
				}
			} else {
				try {
					console
							.log("socketio.live::disconnected:false do Nothing!!!!")
				} catch (e) {
				}
			}
		}
		socketio
				.on(
						"connect_error",
						function() {
							try {
								console
										.log("socketio.connect_error::nFailed_Count::"
												+ nFailed_Count)
							} catch (e) {
							}
							nFailed_Count++;
							if (nFailed_Count == 1) {
								try {
									$("#notifyFrame").attr("src",
											"MelOnNtfy2:melonhandler")
								} catch (e) {
								}
							} else {
								if (nFailed_Count >= maxRetryCnt) {
									window
											.open(
													"http://www.melon.com/plugin/popup/melonnotify_install.htm",
													"melonnotify_install",
													"width=560, height=330, location=no,menubar=no,toolbar=no,scrollbars=yes,resizable=no,status=no");
									nFailed_Count = 0;
									try {
										socketio.close()
									} catch (e) {
									}
								}
							}
						});
		socketio.on("connect", function() {
			try {
				console.log("socketio.connect::success")
			} catch (e) {
			}
			nFailed_Count = 0;
			try {
				socketio.emit("query", queryVal)
			} catch (e) {
			}
		});
		socketio.on("disconnect", function() {
			try {
				console.log("socketio.disconnect::")
			} catch (e) {
			}
			try {
				$("#notifyFrame").attr("src", "")
			} catch (e) {
			}
		});
		socketio.on("result", function(result) {
			try {
				console.log("socketio.result::" + result)
			} catch (e) {
			}
			try {
				console.log("socketio.result::close")
			} catch (e) {
			}
			socketio.close();
			try {
				$("#notifyFrame").attr("src", "")
			} catch (e) {
			}
		})
	}
})();
function MelOnAPIHelper() {
	this.LIST = Array()
}
MelOnAPIHelper.prototype.append = function(d, c, b) {
	var a = this.LIST.length;
	this.LIST[a] = {
		itemIDType : d,
		itemID : c,
		statisticID : b
	}
};
MelOnAPIHelper.prototype.stringify = (function() {
	return JSON.stringify(this)
});
var _FLASH_INSTALLED = false;
try {
	var v = 0;
	if (typeof navigator.plugins != "undefined"
			&& typeof navigator.plugins["Shockwave Flash"] == "object") {
		_FLASH_INSTALLED = true
	}
	try {
		v = parseFloat((new ActiveXObject("ShockwaveFlash.ShockwaveFlash"))
				.GetVariable("$version").match(/(.\d?),/)[1], 10);
		if (_FLASH_INSTALLED || v > 5) {
			_FLASH_INSTALLED = true
		}
	} catch (e) {
	}
} catch (e) {
	_FLASH_INSTALLED = false
}
getBrowserName = function() {
	var b = navigator.userAgent.split(" ")[0];
	var a = b.length > 0 ? navigator.userAgent.replace(b, "")
			: navigator.userAgent;
	if (b.indexOf("Opera") >= 0 || a.indexOf("Opera") >= 0
			|| b.indexOf("OPR") >= 0 || a.indexOf("OPR") >= 0) {
		return "Opera"
	}
	if (a.indexOf("MSIE") >= 0 || a.indexOf("Edge") >= 0) {
		return "Internet Explorer"
	}
	if (a
			.match("(Windows NT 6.3|Windows NT 6.2|Windows NT 6.1|Windows NT 10.0)") !== null
			&& a.indexOf("Trident") >= 0) {
		return "Internet Explorer"
	}
	if (a.indexOf("Firefox") >= 0) {
		return "Firefox"
	}
	if (a.indexOf("Chrome") >= 0) {
		return "Google Chrome"
	}
	if (a.indexOf("Safari") >= 0) {
		return "Safari"
	}
	if (a.indexOf("Gecko") >= 0) {
		return "Gecko"
	}
	if (a.indexOf("Mozilla") >= 0) {
		return "Netscape"
	}
	return ""
};
webPlayerFlashAlert = function() {
	var b = [
			'<div class="layer_popup small" style="width:384px; display:none;" >',
			'<h1 class="layer_title">설치안내</h1>',
			'<div class="layer_cntt">',
			'<div class="box_default">',
			'<p class="txt_emphs">Adobe Flash Player 설치안내</p>',
			"<p>멜론 웹플레이어를 사용하시려면 <br/> Adobe Flash Player가 설치되어 있어야 합니다.</p>",
			"<p>[확인]버튼을 클릭하면, 설치 사이트로 이동합니다.</p>",
			"</div>",
			'<div class="wrap_btn_c">',
			'<button type="button" title="확인" class="btn_emphs_small" data-role="ok"><span class="odd_span"><span class="even_span">확인</span></span></button>',
			'<button type="button" title="취소" class="btn_emphs02_small d_close" data-role="cancel"><span class="odd_span"><span class="even_span">취소</span></span></button>',
			"</div>",
			"</div>",
			'<button type="button" title="닫기" class="btn_close d_close" data-role="ok"><span class="odd_span">닫기</span></button>',
			'<span class="shadow"></span>', "</div>" ].join("");
	var c = $(b).appendTo("body").find("div.d_content").html("").end();
	var a = MELON.PBPGN.Modal;
	var d = new a(c, {
		onOk : function() {
			window.open("http://get.adobe.com/kr/flashplayer/", "flashurl");
			self.close()
		}
	});
	return d.on("modalhidden", function() {
		c.remove()
	})
};/* melonweb_svc.js */