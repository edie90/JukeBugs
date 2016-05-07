package org.JukeBugs.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.JukeBugs.dao.JbuserDAO;
import org.JukeBugs.dao.MusicDAO;
import org.JukeBugs.util.PageNavigator;
import org.JukeBugs.vo.*;
import org.apache.commons.codec.binary.Base64;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.acrcloud.demo.Test;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MainController {
	@Autowired
	SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	////////////////////////////   main 화면 (events.jsp)   //////////////////////////
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String main() {							//메인화면 띄움
		return "main";
	}
	
	@RequestMapping(value="main", method=RequestMethod.GET)
	public String goTomain() {							//메인화면 띄움
		return "main";
	}
	
	
	@RequestMapping(value="getRankingSong", method=RequestMethod.GET)
	public @ResponseBody List<Song> getRankingSong(){			//비로그인시 곡 랭킹을 띄움 (main.jsp에서 ajax로 호출됨)
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		List<Song> songRanking = dao.getRankingSong();		//곡 랭킹을 가져옴 (희태오빠가 쿼리 짜심)
		System.out.println("Song Rankings(17songs) : " + songRanking);
		System.out.println("getRankingSong");
		return songRanking;
	}
	
	@RequestMapping(value="getRankingAlbum", method=RequestMethod.GET)
	public @ResponseBody List<ArtistAlbum> getRankingAlbum(){	//비로그인시 앨범 랭킹을 띄움 (main.jsp에서 ajax로 호출됨)
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		List<ArtistAlbum> albumRanking = dao.getRankingAlbum();//앨범 랭킹을 가져옴 (희태오빠가 쿼리 짜심)
		System.out.println("Album Rankings : " + albumRanking);
		System.out.println("getRankingAlbum");
		return albumRanking;
	}
	
	@RequestMapping(value="home", method=RequestMethod.GET)
	public String home() {					//로그인 시의 메인화면 띄움
		
		System.out.println("home");
		return "home";
	}
	
	
	@RequestMapping(value="getRecommendationSong", method=RequestMethod.GET)
	public @ResponseBody List<Song> getRecommendationSong(HttpSession session){//로그인 시 개인에 맞는 추천 곡을 띄움(home.jsp에서 ajax로 호출됨)
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		String loggedInId = (String) session.getAttribute("loginId");
		List<Song> songRecommendation = dao.getRecommendationSong(loggedInId);//추천 곡을 가져옴(희태오빠 쿼리 짜심)
		System.out.println("getRecommendationSong : " + songRecommendation);
		return songRecommendation;
	}
	
	@RequestMapping(value="getRecommendationAlbum", method=RequestMethod.GET)
	public @ResponseBody List<ArtistAlbum> getRecommendationAlbum(HttpSession session){///로그인 시 개인에 맞는 추천 앨범을 띄움(home.jsp에서 ajax로 호출됨)
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		String loggedInId = (String) session.getAttribute("loginId");
		List<ArtistAlbum> albumRecommendation = dao.getRecommendationAlbum(loggedInId);//추천 앨범을 가져옴(희태오빠 쿼리 짜심)
		System.out.println("getRecommendationAlbum : " + albumRecommendation);
		return albumRecommendation;
	}
	
	@RequestMapping(value="trackdetail", method=RequestMethod.GET)
	public String trackdetail(){
		
		return "track-detail";
	}
	
	@RequestMapping(value="logout", method=RequestMethod.GET)
		public String logout(HttpSession session){		//호출되면 로그아웃함
		System.out.println("logout=========");
			if (session != null) {
				session.removeAttribute("loginId");
				session.removeAttribute("userNick");
				session.invalidate();
			}
			return "redirect:/";
		}
	
	///////////////////////// 음악인식 ////////////////////////////////////////
	
	
	@RequestMapping(value="musicRecognition", method=RequestMethod.GET)
	public String musicRecognition(){
		System.out.println("음악인식");	
		return "simple2";
	}
	
	
	@RequestMapping(value="getResult", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> getResult(HttpSession session){
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("releaseDate", session.getAttribute("releaseDate"));
		map.put("albumName", session.getAttribute("albumName"));
		map.put("title", session.getAttribute("title"));
		map.put("artistName", session.getAttribute("artistName"));
		
		return map;
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="sendServer", method=RequestMethod.POST)
	public void sendServer(HttpServletRequest req, Model model, HttpSession session) throws ServletException, IOException{
		
		String fname = "C://Users//user//Desktop//" + "test" + ".mp3";
		String name = req.getParameter("fname");
		String data = req.getParameter("data");
		//System.out.println("name : " + name + ", data : " + data);
		
		data = data.replace("data:audio/mp3;base64,", "");
		data = data.replace(" ", "+");
		byte[] bytes = data.getBytes();
		//System.out.println("bytes : " + bytes);
		byte[] valueDecode = Base64.decodeBase64(bytes);
		//System.out.println("valueDecode : " + valueDecode);
		FileOutputStream os = new FileOutputStream(new File(fname));
		os.write(valueDecode);
		os.close();
		
		ObjectMapper mapper = new ObjectMapper();
		Test test = new Test();
		
		String result = test.test(fname);
		//System.out.println(result);
		
	    Map<String, Object> m = mapper.readValue(result, new TypeReference<Map<String, Object>>(){});
	    
	    Map<String, Object> getMetaData = (Map<String, Object>) m.get("metadata");
	    
	    ArrayList<String> getMusic = (ArrayList<String>) getMetaData.get("music");

	    for(Object r : getMusic){

	    	HashMap<String, Object> mp = (HashMap<String, Object>) r;
	    	
	    	String releaseDate = (String) mp.get("release_date");
	    	System.out.println("발매일 : " + releaseDate);
	    	
	    	session.setAttribute("releaseDate", releaseDate);
	    	
	    	Map<String, Object> getAlbum = (Map<String, Object>) mp.get("album");
	    	String album_name = (String) getAlbum.get("name");
	    	System.out.println("앨범이름 : " + album_name);
	    	
	    	session.setAttribute("albumName", album_name);
	    	
	    	String title = (String) mp.get("title");
	    	System.out.println("타이틀 : " + title);

	    	session.setAttribute("title", title);
	    	
	    	ArrayList<String> getArtists = (ArrayList<String>) mp.get("artists");
	    	
	    	for(Object o : getArtists){
	    		
	    		HashMap<String, Object> getArtist = (HashMap<String, Object>) o; 
	    		String artist_name = (String) getArtist.get("name");
	    		System.out.println("아티스트명 : " + artist_name);
	    		
	    		session.setAttribute("artistName", artist_name);
	    		
	    	}
	    	
	    }
	     
	}
	
	//404 맵핑 경로를 잘못 줬거나 컨트롤러를 잘못 만들었거나 servlet.xml에 bean이 잘 등록되었는지 
	//500 db에 경로가 잘 되었는지
	//400 (value="currentPage", defaultValue="1") int currentPage) { 여기서 currentPage가 일치 하지 않는 경우 
	@RequestMapping(value="genres", method=RequestMethod.GET)
	public String genres(@RequestParam(value="currentPage", defaultValue="1") int currentPage, Model model, PageNavigator pagenavi){
		///이건 제가 한게 아니라서.... 언하가 한거니까 언하에게 문의하세염
		currentPage = 1;				
		
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		
		int countPerPage = 10;
		int pagePerGroup = 5;
		
		int total = dao.getTotal();
		
		pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startPageGroup", pagenavi.getStartPageGroup());
		map.put("endPageGroup", pagenavi.getEndPageGroup());
		
		List<ArtistAlbum> list = dao.showAll(map);
		
		System.out.println(total);
		System.out.println("리스트 " + list);
		System.out.println(pagenavi.toString());
		System.out.println(currentPage);
		
		model.addAttribute("aa", list);
		model.addAttribute("pagenavi", pagenavi);
		
		System.out.println(pagenavi.getCurrentPage());
		System.out.println(pagenavi.getStartPageGroup());
		System.out.println(pagenavi.getEndPageGroup());
		
		//model.addAttribute("currentPage", currentPage);
		
		return "genres";
		
	}
	
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String login(					//로그인. 언하가 한것. (제가 좀 고치긴 했심)
			HttpSession session,
			@RequestParam(value="userid", required=true) String userid,
			@RequestParam(value="userpassword", required=true) String userpassword
			
			){
		
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		Jbuser jbuser = dao.selectOne(userid);		//userId로 검색해서 유저vo에 담아 전체 정보를 가져옴
		
		if(jbuser != null){
			
			if(jbuser.getUserpassword().equals(userpassword)){
				if(jbuser.getUserpassword().equals("admin")) {
					session.setAttribute("loginId", jbuser.getUserid());
					session.setAttribute("userNick", jbuser.getUsernick());
					System.out.println("admin");
					return "adminMain";
				}
				System.out.println("commonlogin");
				System.out.println("login success");
				session.setAttribute("loginId", jbuser.getUserid());
				session.setAttribute("userNick", jbuser.getUsernick());
				System.out.println("session put success");
				
			} else {
				System.out.println("login fail");
				return "redirect:signin";
			}
		}else{
			System.out.println("login fail");
			return "redirect:signin";
		}
		
		return "home";
		
	}
	
	@RequestMapping(value="signin", method=RequestMethod.GET)
	public String signIn() {					//로그인 페이지
		logger.info("========> signin()" + sqlSession);
		return "signin";
	}
	
	@RequestMapping(value="signup", method=RequestMethod.GET)
	public String singUp() {					//회원가입 페이지
		logger.info("========> signup()" + sqlSession);
		return "signup";
	}
	
	/*@RequestMapping(value="join", method=RequestMethod.POST)
	public String join(				//회원가입. 언하가 한 것.
			
	@RequestParam(value="userid", required=true) String userid, 
	@RequestParam(value="userpassword", required=true) String userpassword, 
	@RequestParam(value="username", required=true) String username,
	@RequestParam(value="usernick", required=true) String usernick,
	@RequestParam(value="userquestion", required=true) String userquestion,
	@RequestParam(value="useranswer", required=true) String useranswer,
	@RequestParam(value="chk[]", required=true) String chk []
	
	){
		logger.info("=====> join ," + userid + userpassword + username + usernick + userquestion + useranswer + chk[0] + chk[1] + chk[2] );
		
		String userlike1 = chk[0];
		String userlike2 = chk[1];
		String userlike3 = chk[2];
		String userprofileimgurl = "img"; 
		String userillegal = "y";
		
		logger.info("=====> new join ," + userlike1 + userlike2 + userlike3 + userillegal);
		Jbuser jbuser = new Jbuser(userid, userpassword, username, usernick, userlike1, userlike2, userlike3, userquestion, useranswer, userprofileimgurl, userillegal);
		
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		dao.insert(jbuser);
		
		logger.info("=======> insert success " + jbuser);
		return "index";
	}*/
	////////////////////////내 컨트롤러//////////////////////////
	@RequestMapping(value="profile", method=RequestMethod.GET)
	public String profile(HttpSession session, Model model){		//profile을 띄움과 동시에 나와야할 것들을 model로 보내줌.
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);	
		MusicDAO dao1 = sqlSession.getMapper(MusicDAO.class);
		ArrayList<FindFriendsVO> foundFriends = new ArrayList<FindFriendsVO>();
		String loggedInID = (String) session.getAttribute("loginId");
		foundFriends = dao.recommendFriends(loggedInID, new RowBounds(0, 20));	//follow할만한 사람들을 추천해줌. 일단 전체의 20명만.
		Collections.sort(foundFriends, Collections.reverseOrder());
		
		model.addAttribute("userId", loggedInID);			//로그인한 유저의 id 띄움(세션으로 해도 되긴 하지만....)
		model.addAttribute("findFriends", foundFriends);	//follow할만한 사람들 추천한 목록 내보냄
		model.addAttribute("userLikesCount", dao1.getUserLikesCount(loggedInID));	 	//유저가 like한 곡의 수 내보내서 갯수 나타내줌
		model.addAttribute("messageCount", dao.getInboxTotal(loggedInID));		//유저가 받은 메세지의 수 내보내서 갯수 나타내줌
		model.addAttribute("followerCount", dao.getFollowers(loggedInID).size());		//팔로워 수도 내보내서 갯수 나타내줌
		model.addAttribute("followingCount", dao.getFollowing(loggedInID).size());		//유저가 팔로잉 한 사람의 수도 내보내서 갯수 나타내줌
		System.out.println("profile");
		return "profile";
	}
	
	@RequestMapping(value="message", method=RequestMethod.GET)
	public String message(){					//메세지 화면. 모든건 ajax로 호출해서 여기가 빈칸임...
		System.out.println("Message");
		return "message";
	}
	
	@RequestMapping(value="composeMessage", method=RequestMethod.POST)
	public String composeMessage(HttpSession session,			//메세지 작성 컨트롤러
		@RequestParam(value="requestId", required=true) String requestId,	//메세지 보낼 사람
		@RequestParam(value="message", required=true) String message		//보낼 메세지
		){
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		String sendId = (String) session.getAttribute("loginId");		//글쓰는 본인
		Message messageVO = new Message();
		messageVO.setMessage(message);		//보낼 메세지랑
		messageVO.setSendidjbuser(sendId);		//글 쓰는 본인 아이디랑
		messageVO.setRequestIdjbuser(requestId);		//메세지 받는 애 아이디랑 vo에 넣어서
		dao.insertMessage(messageVO);				//메세지를 보냄.
		System.out.println("composeMessage");
		return "message";
	}
	
	@RequestMapping(value="checkRequestNick", method=RequestMethod.POST)
	public @ResponseBody boolean checkRequestNick(				//위에 composeMessage 이전에 실행되는 컨트롤러
			@RequestBody Map<String, Object> map){						//보내는 메세지를 받는 아이디가 존재하는 놈인지 아닌지 체크.
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		boolean result = false;
		Jbuser requestIdjbuser = dao.selectOne((String) map.get("requestId"));	//보낼 아이디로 유저를 검색해서
		if (requestIdjbuser != null) {			//있으면 통과
			result = true;	
		}else result = false;					//없으면 alert창으로 없는 이용자라고 띄움. (Message.jsp 참조)
		System.out.println("checkRequestNick");
		return result;
	}
	
	@RequestMapping(value="getMessages", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> getMessages(				//로그인 한 유저가 받은 메세지를 갖고옴
			@RequestParam(value="currentPage", defaultValue="1") int currentPage		//페이징함
			, HttpSession session, PageNavigator pagenavi){ 
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		List<Message> inboxList = null;
		String loggedinUserId = (String) session.getAttribute("loginId");
		
		int countPerPage = 5;
		int pagePerGroup = 10;
		int total = dao.getInboxTotal(loggedinUserId);
		System.out.println("total : " + total +" , currentPage :  " + currentPage);
		
		pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("loginId", loggedinUserId);
		map.put("startRecord", pagenavi.getStartRecord());
		map.put("countPerPage", pagenavi.getCountPerPage());
		
		System.out.println("startRecord : "+pagenavi.getStartRecord() + ", countPerPage : " + pagenavi.getCountPerPage() + ", endPageGroup : " + pagenavi.getEndPageGroup());
		
		inboxList = dao.getInboxList(map);				//startRecord등으로 적절히 페이징 되서 로그인한 유저의 메세지를 가져옴
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("inboxList", inboxList);					
		map1.put("pagenavi", pagenavi);				//innerHTML로 하는 바람에 이렇게 map1에 넣어서 리턴하는 수밖엔 없었음.
		System.out.println("getMessages");			//자세한건 message.jsp jquery 부분 참조
		return map1;
	}
	
	@RequestMapping(value="getSentMessages", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> getSentMessages(			//로그인한 유저가 보낸 메시지. (받은거 아님. 받은 메세지는 위에꺼)
			@RequestParam(value="currentPage", defaultValue="1") int currentPage, 
			HttpSession session, PageNavigator pagenavi){
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		List<Message> sentList = null;
		String loggedinUserId = (String) session.getAttribute("loginId");
		
		int countPerPage = 5;
		int pagePerGroup = 10;
		int total = dao.getSentTotal(loggedinUserId);
		
		pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
		
		System.out.println("startRecord : "+pagenavi.getStartRecord() + ", countPerPage : " + pagenavi.getCountPerPage() + ", endPageGroup : " + pagenavi.getEndPageGroup());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("loginId", loggedinUserId);
		map.put("startRecord", pagenavi.getStartRecord());
		map.put("countPerPage", pagenavi.getCountPerPage());
		
		sentList = dao.getSentList(map);					//유저가 보낸 메시지 기록을 가져옴 (페이징함)
		
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("sentList", sentList);
		map1.put("pagenavi", pagenavi);
		
		System.out.println("getSentMessages");
		return map1;
	}
	
	@RequestMapping(value="deleteMessages", method=RequestMethod.POST)
	public void deleteMessages(				//메세지 삭제.
			@RequestParam(value="messageids") List<String> messageIds){
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		for (int i = 0; i < messageIds.size(); i++) {
			dao.deleteMessage(messageIds.get(i));			//checkbox로 1개 이상 삭제할 메세지를 받아오기 때문에 for문 돌려서 삭제.
		}
		System.out.println("deleteMessage");				//자세한건 Message.jsp Jquery 부분 참조
	}
	
	///////////////////////////Friend///////////////////////////////////
	/*@RequestMapping(value="FriendRequest", method=RequestMethod.POST)
	public String FriendRequest(@RequestBody Map<String, Object> map, HttpSession session){
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		String loggedinUserId = (String) session.getAttribute("loginId");
		String requestToId = (String) map.get("requestToId");
		
		friend.setRequestId(requestToId);	//요청 받은 유저
		friend.setUserId(loggedinUserId);		//친구신청한 유저
		dao.friendRequest(friend);
		System.out.println("FriendRequest");																				//이 부분 addFollow로 대체
		return "profile";
	}*/
	@RequestMapping(value="followers", method=RequestMethod.GET)
	public String followers(){						//follower 화면 띄움
		System.out.println("followers");
		return "followers";
	}
	
	@RequestMapping(value="getFollowers", method=RequestMethod.GET)
	public @ResponseBody List<Friend> getFollowers(HttpSession session){			//나를 팔로우 하는 사람들을 가져옴
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		List<Friend> followerInbox = null;
		String loggedinUserId = (String) session.getAttribute("loginId");
		followerInbox = dao.getFollowers(loggedinUserId);			//나를 팔로우 하는 사람들을 가져옴
		List<String> checkFollowBack = null;							
		checkFollowBack = dao.checkFollowBack(loggedinUserId);//나를 맞팔 하는 사람들의 ID를 가져옴
		for (int i = 0; i < followerInbox.size(); i++) {					//나를 팔로우 하는 사람들 중에
			Friend friend = new Friend();
			friend.setRequestId(loggedinUserId);
			friend.setUserId(followerInbox.get(i).getUserId());
			friend.setUserNick(followerInbox.get(i).getUserNick());
				
			for (String str : checkFollowBack) {							//맞팔 하는 사람들이 있다면
				if (str.contains(followerInbox.get(i).getUserId())) {
					friend.setFollowback(true);									//맞팔 중이다 라고 boolean 값 넣어줌
				}
			}
//			friend.setUserNick(dao.selectOne(followerInbox.get(i).getUserId()).getUsernick());
			friend.setCompatibility(followerInbox.get(i).getCompatibility());
			followerInbox.set(i, friend);
		}
		System.out.println("getFollower");
		return followerInbox;
	}
	
	@RequestMapping(value="getFollowing", method=RequestMethod.GET)
	public @ResponseBody List<Friend> getFollowing(HttpSession session){			//내가 팔로잉 하는 사람들을 가져옴
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		List<Friend> followingInbox = null;
		String loggedinUserId = (String) session.getAttribute("loginId");
		followingInbox = dao.getFollowing(loggedinUserId);				//내가 팔로잉 하는 사람들을 가져옴
		List<String> checkFollowBack = null;
		checkFollowBack = dao.checkFollowBack(loggedinUserId);		//나를 맞팔 하는 사람들의 ID를 가져옴
		for (int i = 0; i < followingInbox.size(); i++) {				//내가 팔로잉 하는 사람들 중에
			Friend friend = new Friend();		
			friend.setUserId(loggedinUserId);
			friend.setRequestId(followingInbox.get(i).getRequestId());
			friend.setUserNick(followingInbox.get(i).getUserNick());
			
			for (String str : checkFollowBack) {							//나를 맞팔 하는 사람들이 있다면
				if (str.contains(followingInbox.get(i).getRequestId())) {
					friend.setFollowback(true);							//boolean값 알맞게 줌
				}		
			}
//			friend.setUserNick(dao.selectOne(followingInbox.get(i).getRequestId()).getUsernick());
			friend.setCompatibility(followingInbox.get(i).getCompatibility());
			followingInbox.set(i, friend);
		}
		System.out.println("getFollowing");
		return followingInbox;
	}
	
	@RequestMapping(value="deleteFollowers", method=RequestMethod.POST)
	public void deleteFollowers(											//언팔 하는 컨트롤러(날 팔로우 하는 사람들을 짤라냄)
			@RequestParam(value="followerids") List<String> followerids, HttpSession session){
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		Map<String, String> map = new HashMap<String, String>();
		String loggedinUserId = (String) session.getAttribute("loginId");
		for (int i = 0; i < followerids.size(); i++) {				//checkbox로 1명이상 동시에 언팔 가능하므로 for문 돌림
			map.put("requestId", loggedinUserId);
			map.put("userId", followerids.get(i));
			dao.deleteFollower(map);					//언팔하는 메소드
		}
		System.out.println("deleteFollowers");
	}
	@RequestMapping(value="deleteFollowing", method=RequestMethod.POST)
	public void deleteFollowing(							//위와 같음. 팔로잉을 취소함.
			@RequestParam(value="followerids") List<String> followerids, HttpSession session){
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		Map<String, String> map = new HashMap<String, String>();
		String loggedinUserId = (String) session.getAttribute("loginId");
		for (int i = 0; i < followerids.size(); i++) {
			map.put("userId", loggedinUserId);
			map.put("requestId", followerids.get(i));
			dao.deleteFollower(map);
		}
		System.out.println("deleteFollowing");
	}
	
	/////////////////////////profileOthers///////////////////////////
	@RequestMapping(value="profileOthers", method=RequestMethod.GET)
	public String profileOthers(						//남의 프로필 보기
			@RequestParam(value="otherUserId", required=true) String otherUserId, Model model, HttpSession session){
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		Jbuser otherUser = dao.selectOne(otherUserId);					//내가 클릭한 유저의 전체 정보를 ID로 다 가져옴
		String otherUserNick = otherUser.getUsernick();					//그 중 닉넴을 가져옴
	 	List<Musicfeed> otherMusicFeed = dao.getMusicFeed(otherUserId);		//그 사람의 musicfeed를 가져옴
	 	String loggedinUserId = (String) session.getAttribute("loginId");
	 	boolean followBack = false;
	 	List<Friend> otherFollowers = dao.getFollowers(otherUserId);				//그 사람의 팔로워 들을 가져옴
	 	
	 	for (int i = 0; i < otherFollowers.size(); i++) {										//그 사람들의 팔로워 중에
			Friend friend = new Friend();
			friend.setRequestId(otherUserId);
			friend.setUserId(otherFollowers.get(i).getUserId());
			friend.setUserNick(otherFollowers.get(i).getUserNick());
			
			otherFollowers.set(i, friend);
			if (otherFollowers.get(i).getUserId().equals(loggedinUserId)) {				//본인은 제외하고
				followBack = true;
			}
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("loggedInId", loggedinUserId);
		map.put("otherUserId", otherUserId);
		String chk = dao.checkFollowBackOther(map);									//날 맞팔 하는 사람이 있다면 맞팔이라고 표시함.
		if (chk != null) {
			followBack = true;
		}
		Friend fc = dao.compatibilityOther(map);										//그리고 지금 내가 프로필을 보고 있는 애와
		int compatibility = 0;
		System.out.println("fc if문 확인 전");
		if (fc != null) {
			compatibility = fc.getCompatibility();	
			
		}													
		System.out.println("fc if문 확인 후");//나와의 취향의 비슷함의 정도를 가져와서 뿌려줌.(막대기로 나옴)
		MusicDAO dao1 = sqlSession.getMapper(MusicDAO.class);
		model.addAttribute("musicFeed", otherMusicFeed);
		model.addAttribute("compatibility", compatibility);
		model.addAttribute("followBack", followBack);
		model.addAttribute("loggedInUserId", loggedinUserId);
		model.addAttribute("otherUserId", otherUserId);
		model.addAttribute("otherUserNick", otherUserNick);
		model.addAttribute("otherFollowers", otherFollowers);
		model.addAttribute("likeCount", dao1.getUserLikesCount(otherUserId));
		model.addAttribute("followerCount", dao.getFollowers(otherUserId).size());
		model.addAttribute("followingCount", dao.getFollowing(otherUserId).size());
		System.out.println("profileOThers");
		return "profileOthers";
	}
	
	@RequestMapping(value="getOtherFollowers", method=RequestMethod.POST)
	public @ResponseBody List<Friend> getOtherFollowers(								//내가 프로필을 보고 있는 애의 팔로워들을 가져옴
			@RequestBody Map<String, String> map, HttpSession session){	//profileOthers.jsp상에서 Followers / Following 이라고 되어있는 부분.
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		String otherUserId = map.get("otherUserId");
		String loggedinUserId = (String) session.getAttribute("loginId");
		List<Friend> otherFollowers = dao.getFollowers(otherUserId);					//내가 프로필을 보고 있는 애를 팔로우 하는 사람들을 가져옴
	 	for (int i = 0; i < otherFollowers.size(); i++) {
			Friend friend = new Friend();
			friend.setRequestId(otherUserId);
			friend.setUserId(otherFollowers.get(i).getUserId());
			friend.setUserNick(otherFollowers.get(i).getUserNick());
			
			Map<String, String> map1 = new HashMap<String, String>();
			map1.put("loggedInId", loggedinUserId);
			map1.put("otherUserId", otherFollowers.get(i).getUserId());
			String chkList = dao.checkFollowYou(map1);									//얘를 팔로우 하는 사람들 중 나를 팔로우 하는 사람이 있는지 체크
			if (chkList != null) {															
				friend.setFollowback(true);
			} else friend.setFollowback(false);										//적절하게 boolean값 설정.
		//	friend.setUserNick(dao.selectOne(otherFollowers.get(i).getUserId()).getUsernick());
			otherFollowers.set(i, friend);
		}
	 	System.out.println(otherFollowers);
		System.out.println("getOtherFollowers");
		return otherFollowers;
	}
	@RequestMapping(value="getOtherFollowing", method=RequestMethod.POST)
	public @ResponseBody List<Friend> getOtherFollowing(	//내가 프로필을 보고 있는 애가 팔로잉 하는 사람들을 가져옴
			@RequestBody Map<String, String> map, HttpSession session){//profileOthers.jsp상에서 Followers / Following 이라고 되어있는 부분.
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		String otherUserId = map.get("otherUserId");
		String loggedinUserId = (String) session.getAttribute("loginId");
		List<Friend> otherFollowing = dao.getFollowing(otherUserId);		//얘가 팔로잉 하는 사람들을 가져옴
	 	for (int j = 0; j < otherFollowing.size(); j++) {
	 		Friend friend = new Friend();
	 		friend.setUserId(otherUserId);
	 		friend.setRequestId(otherFollowing.get(j).getRequestId());
	 		friend.setUserNick(otherFollowing.get(j).getUserNick());

	 		Map<String, String> map1 = new HashMap<String, String>();
	 		map1.put("loggedInId", loggedinUserId);
	 		map1.put("otherUserId", otherFollowing.get(j).getRequestId());
	 		String chkList = dao.checkFollowYou(map1);								//얘가 팔로잉 하는 사람들이 나도 팔로우 하는지 체크
			if (chkList != null) {
				friend.setFollowback(true);
			} else friend.setFollowback(false);								//적절한 boolean값 설정
	//		friend.setUserNick(dao.selectOne(otherFollowing.get(j).getRequestId()).getUsernick());
			otherFollowing.set(j, friend);
		}
	 	System.out.println(otherFollowing);
	 	System.out.println("getOtherFollowing");
		return otherFollowing;
	}
	
	
	@RequestMapping(value="addFollow", method=RequestMethod.GET)
	public String addFollow(														//profileOthers.jsp에서 막대기 밑 follow 버튼으로 호출됨
			@RequestParam(value="otherUserId", required=true) String otherUserId, HttpSession session, RedirectAttributes ra){
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		String loggedinUserId = (String) session.getAttribute("loginId");
		Friend friend = new Friend();
		
		friend.setUserId(loggedinUserId);
		friend.setRequestId(otherUserId);								//버튼을 누르면 내가 프로필을 보던 애의 ID를 가져와서 
		dao.friendRequest(friend);											//follow를 해버림. (메소드 이름 자체만 친구로 되어있음. )
		
		ra.addAttribute("otherUserId", otherUserId);				
		System.out.println("addFollow");
		return "redirect:/profileOthers";
	}
	/////////////////////////Music Feed//////////////////////////
	@RequestMapping(value="postMFMessage", method=RequestMethod.POST)
	public @ResponseBody List<Musicfeed> postMFMessage(HttpSession session,		//MusicFeed에 메세지를 쓰는 부분
			@RequestBody Map<String, String> map
		){
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		List<Musicfeed> musicfeedMessage = new ArrayList<>();
		String sendId = (String) session.getAttribute("loginId");
		String message = (String) map.get("message");							//메세지를 ajax로 가져와서
		Musicfeed musicfeed = new Musicfeed();
		musicfeed.setWriterUser(sendId);
		musicfeed.setWritemessage(message);										//vo에 담아서
		System.out.println(musicfeed.getMusicfeedtitle());
		dao.insertMusicFeed(musicfeed);												//뮤직피드에 넣어버림
		
		System.out.println("postMFMessage");
		return musicfeedMessage;
	}
	
	@RequestMapping(value="getMusicFeed", method=RequestMethod.GET)
	public @ResponseBody List<Musicfeed> getMusicFeed(HttpSession session){			//나의 뮤직피드를 가져옴
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		List<Musicfeed> musicfeed = null;
		String loggedInId = (String) session.getAttribute("loginId");
		musicfeed = dao.getMusicFeed(loggedInId);						//내 ID 기준으로 뮤직피드 가져오기
		System.out.println("getMusicFeed");
		return musicfeed;
	}
	
	@RequestMapping(value="deleteMusicFeed", method=RequestMethod.POST)
	public @ResponseBody void deleteMusicFeed(					//뮤직피드 삭제
			@RequestBody Map<String, String> map){
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		String musicfeedid = (String) map.get("musicfeedid");
		dao.deleteMusicFeed(musicfeedid);								//삭!제!
		System.out.println("deleteMusicFeed");
	}
	
	@RequestMapping(value="getOtherMusicFeed", method=RequestMethod.POST)
	public @ResponseBody List<Musicfeed> getOtherMusicFeed(				//다른 놈의 뮤직피드를 가져옴. (profileOthers.jsp에서 호출)
			@RequestBody Map<String, String> map){							//그러니까 내가 프로필을 보고 있는 애의 뮤직피드를 가져오는 것
		JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
		List<Musicfeed> musicfeed = null;
		String otherUserId = map.get("otherUserId");
		musicfeed = dao.getMusicFeed(otherUserId);			//그녀석 ID기준으로 뮤직피드를 가져옴
		System.out.println("getMusicFeed");
		return musicfeed;
	}
	
}
