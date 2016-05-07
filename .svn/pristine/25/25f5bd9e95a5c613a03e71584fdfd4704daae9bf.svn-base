package org.JukeBugs.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.JukeBugs.dao.JbuserDAO;
import org.JukeBugs.dao.MusicDAO;
import org.JukeBugs.util.PageNavigator;
import org.JukeBugs.vo.Artist;
import org.JukeBugs.vo.ArtistAlbum;
import org.JukeBugs.vo.Jbuser;
import org.JukeBugs.vo.Log;
import org.JukeBugs.vo.MakeAlbum;
import org.JukeBugs.vo.MakeAlbumSongs;
import org.JukeBugs.vo.Musicfeed;
import org.JukeBugs.vo.Song;
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
import org.springframework.web.multipart.MultipartFile;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MusicController {
	@Autowired
	SqlSession sqlSession;
	
	
	private static final Logger logger = LoggerFactory.getLogger(MusicController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	/*@RequestMapping(value = "/", method = RequestMethod.GET)
	public String music() {
		logger.info("======> music()" + sqlSession);
		return "index";
	}*/
	
	/*@RequestMapping(value="signin", method=RequestMethod.GET)
	public String signIn() {
	    logger.info("========> signin()" + sqlSession);
	    return "signin";
	}
	   
    @RequestMapping(value="signup", method=RequestMethod.GET)
    public String singUp() {
    	logger.info("========> signup()" + sqlSession);
    	return "signup";
    }*/
    
    @RequestMapping(value="join", method=RequestMethod.POST)
    public String join(
          
    @RequestParam(value="userid", required=true) String userid, 
    @RequestParam(value="userpassword", required=true) String userpassword, 
    @RequestParam(value="username", required=true) String username,
    @RequestParam(value="usernick", required=true) String usernick,
    @RequestParam(value="userquestion", required=true) String userquestion,
    @RequestParam(value="useranswer", required=true) String useranswer,
    @RequestParam(value="chk[]", required=true) String chk [],
    @RequestParam(value="file") MultipartFile file,
    HttpServletRequest request
    
    ) throws Exception{
       logger.info("=====> join ," + userid + userpassword + username + usernick + userquestion + useranswer + chk[0] + chk[1] + chk[2] );
       System.out.println("==> 파일 :: " + file);
       String userlike1 = chk[0];
       String userlike2 = chk[1];
       String userlike3 = chk[2];
       String userillegal = "y";
       
       logger.info("=====> new join ," + userlike1 + userlike2 + userlike3 + userillegal);
       
       String userprofileimgurl = null;
       
	       if(!file.isEmpty()) {
	    	   
			   String originalFile = file.getOriginalFilename();
			   
			   UUID uid = UUID.randomUUID();
			   userprofileimgurl = uid.toString() + "_" + originalFile;
			   
			   //업로드의 실제위치를 알려달라
			   String path = request.getSession().getServletContext().getRealPath("/upload");
			   String fpath = path + "\\" + userprofileimgurl; // 경로+실제파일이 합쳐진 것
			   
			   //클라이언트가 올린 땐 input이고 input에서 우리 서버에 저장하려면 output이다
			   System.out.println("===> 저장경로" + fpath);
			   FileOutputStream fs = new FileOutputStream(fpath);
			   
			   fs.write(file.getBytes());
				
			   fs.close();
	       } 
	       
	       Jbuser jbuser = new Jbuser(userid, userpassword, username, usernick, userlike1, userlike2, userlike3, userquestion, useranswer, userprofileimgurl ,userillegal);
	       
	       JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
	       dao.insert(jbuser);
	       
	       logger.info("=======> insert success " + jbuser);
	       return "main";
	    }
    
   /* @RequestMapping(value="login", method=RequestMethod.POST)
    public String login(
          HttpSession session,
          @RequestParam(value="userid", required=true) String userid,
          @RequestParam(value="userpassword", required=true) String userpassword,
          Model model
          
          ){
       
       JbuserDAO dao = sqlSession.getMapper(JbuserDAO.class);
       Jbuser jbuser = dao.selectOne(userid);
       
       if(jbuser != null){
          
          if(jbuser.getUserpassword().equals(userpassword)){
             System.out.println("login success");
             session.setAttribute("loginId", jbuser.getUserid());
             session.setAttribute("userNick", jbuser.getUsernick());
             session.setAttribute("userprofileimgurl", jbuser.getUserprofileimgurl());
             System.out.println("session put success");
             model.addAttribute("jbuser", jbuser);
          } else {
             System.out.println("login fail");
             //return "redirect:signin";
          }
       }
       return "index";
    }
    
    
    @RequestMapping(value="logout", method=RequestMethod.GET)
    public String logout(HttpSession session, String userid){
    System.out.println("logout=========");
       if (session != null) {
          session.removeAttribute("loginId");
          session.removeAttribute("userNick");
          session.invalidate();
       }
       return "redirect:/";
    }*/

	
	
	@RequestMapping(value="search", method=RequestMethod.GET)
	public String search(String content, HttpServletRequest request, Model model, HttpSession session) {
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		List<Artist> artistList = null;
		List<ArtistAlbum> artistAlbumList = null;
		List<Song> searchBasedOnArtistNameSongList = new ArrayList<>();
		List<Song> searchBasedOnSongNameSongList = new ArrayList<>();
		List<Song> searchBasedOnAlbumNameSongList = new ArrayList<>();
		
		String loggedInId = (String) session.getAttribute("loginId");
		
		
		Artist artist = dao.artistSelectOne(content);
		System.out.println("널인가 :: " + artist);
		System.out.println(content);
		System.out.println(dao.checkGroup(content));
		
		if(artist == null) {
			artistList = dao.artistSelectList(content);
			artistAlbumList =  dao.artistAlbumSelectList(content);
		} else {
			if(dao.checkGroup(content).equals("group") || dao.checkGroup(content).equals("Group")){
				System.out.println("222");
				artistList = dao.groupMemberList(content);
				artistAlbumList = dao.artistAlbumSelectListGroup(content);
			} else {
				System.out.println("111");
				artistList = dao.artistSelectList(content);
				artistAlbumList = dao.artistAlbumSelectListGroup(content);
			}
		}
		
		model.addAttribute("Artist", artist);
		model.addAttribute("ArtistList", artistList);
		model.addAttribute("ArtistAlbumList", artistAlbumList);
		
		
		//ArtistAlbum oneAlbum = dao.artistAlbumSelectOne(content);
		//model.addAttribute("ArtistAlbum", oneAlbum);
		
		searchBasedOnArtistNameSongList = dao.searchBasedOnArtistNameSongList(content);
		int searchBasedOnArtistNameSongListCount = dao.searchBasedOnArtistNameSongListCount(content);
		if (loggedInId != null) {													//로그인 했다면
			Map<String, String> map = new HashMap<String, String>();
			map.put("userId", loggedInId);
			map.put("content", content);
			List<String> checkLike = dao.getSearchArtistNameLikeList(map);			//지금 보고 있는 앨범 안의 곡들중 로그인한 사람이 좋아요를 누른 곡ID를 가져옴
			for (int i = 0; i < searchBasedOnArtistNameSongList.size(); i++) {
				for (String str : checkLike) {
					if (str.contains(searchBasedOnArtistNameSongList.get(i).getSongid())) {
						searchBasedOnArtistNameSongList.get(i).setLike(true);							//앨범곡중 좋아요를 누른게 있다면 적절한 boolean 값 설정.
					}
				}
			}
		}
		//System.out.println("두번째 :: " + searchBasedOnArtistNameSongList);
		
		searchBasedOnSongNameSongList = dao.searchBasedOnSongNameSongList(content);
		System.out.println(searchBasedOnSongNameSongList);
		int searchBasedOnSongNameSongListCount = dao.searchBasedOnSongNameSongListCount(content);
		System.out.println(searchBasedOnSongNameSongListCount);
		if (loggedInId != null) {													//로그인 했다면
			Map<String, String> map = new HashMap<String, String>();
			map.put("userId", loggedInId);
			map.put("content", content);
			List<String> checkLike = dao.getSearchSongNameLikeList(map);			//지금 보고 있는 앨범 안의 곡들중 로그인한 사람이 좋아요를 누른 곡ID를 가져옴
			for (int i = 0; i < searchBasedOnSongNameSongList.size(); i++) {
				for (String str : checkLike) {
					if (str.contains(searchBasedOnSongNameSongList.get(i).getSongid())) {
						searchBasedOnSongNameSongList.get(i).setLike(true);							//앨범곡중 좋아요를 누른게 있다면 적절한 boolean 값 설정.
					}
				}
			}
		}
		
		
		searchBasedOnAlbumNameSongList = dao.searchBasedOnAlbumNameSongList(content);
		int searchBasedOnAlbumNameSongListCount = dao.searchBasedOnAlbumNameSongListCount(content);
		
		if (loggedInId != null) {													//로그인 했다면
			Map<String, String> map = new HashMap<String, String>();
			map.put("userId", loggedInId);
			map.put("content", content);
			List<String> checkLike = dao.getSearchAlbumNameLikeList(map);			//지금 보고 있는 앨범 안의 곡들중 로그인한 사람이 좋아요를 누른 곡ID를 가져옴
			for (int i = 0; i < searchBasedOnAlbumNameSongList.size(); i++) {
				for (String str : checkLike) {
					if (str.contains(searchBasedOnAlbumNameSongList.get(i).getSongid())) {
						searchBasedOnAlbumNameSongList.get(i).setLike(true);							//앨범곡중 좋아요를 누른게 있다면 적절한 boolean 값 설정.
					}
				}
			}
		}
		
		
		model.addAttribute("searchBasedOnArtistNameSongList", searchBasedOnArtistNameSongList);
		model.addAttribute("searchBasedOnArtistNameSongListCount", searchBasedOnArtistNameSongListCount);
		model.addAttribute("searchBasedOnSongNameSongList", searchBasedOnSongNameSongList);
		model.addAttribute("searchBasedOnSongNameSongListCount", searchBasedOnSongNameSongListCount);
		model.addAttribute("searchBasedOnAlbumNameSongList", searchBasedOnAlbumNameSongList);
		model.addAttribute("searchBasedOnAlbumNameSongListCount", searchBasedOnAlbumNameSongListCount);
		
		//List<Song> songList = dao.songList(content);
		/*session.setAttribute("artistAlbumList", artistAlbumList);
		session.setAttribute("songList", songList);*/
		
		return "search";
	}
	
	@RequestMapping(value="goTotalArtistSearch", method=RequestMethod.GET)
	public String goTotalArtistSearch(HttpServletRequest request, String artistname, Model model) {
		List<Artist> artistList = null;
		System.out.println(artistname);
		
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		artistList = dao.groupMemberList(artistname);
		System.out.println(artistList);
		model.addAttribute("ArtistList", artistList);
		
		return "totalArtist";
	}
	
	@RequestMapping(value="goTotalAlbumSearch", method=RequestMethod.GET)
	public String goTotalAlbumSearch(HttpServletRequest request, String artistname, Model model) {
		
		List<ArtistAlbum> artistAlbumList = null;
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		artistAlbumList = dao.artistAlbumSelectList(artistname);
		model.addAttribute("ArtistAlbumList", artistAlbumList);
		model.addAttribute("artistName", artistname);
		
		return "totalAlbum";
	}
	
	@RequestMapping(value="searchAlbumSong", method=RequestMethod.GET)
	public String searchAlbumSong(HttpServletRequest request, String albumid, Model model, HttpSession session) {
		List<Song> songList = null;
		
		System.out.println(albumid+"ddd");
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		songList = dao.songList(albumid);
		System.out.println(songList);
		
		ArtistAlbum artistAlbum = dao.artistAlbumSelectOneId(albumid);
		int count = dao.songListCount(albumid);
		
		String loggedInId = (String) session.getAttribute("loginId");
		if (loggedInId != null) {													//로그인 했다면
			Map<String, String> map = new HashMap<String, String>();
			map.put("userId", loggedInId);
			map.put("albumId", albumid);
			System.out.println(songList);
			List<String> checkLike = dao.getLikeList(map);			//지금 보고 있는 앨범 안의 곡들중 로그인한 사람이 좋아요를 누른 곡ID를 가져옴
			for (int i = 0; i < songList.size(); i++) {
				for (String str : checkLike) {
					if (str.contains(songList.get(i).getSongid())) {
						songList.get(i).setLike(true);							//앨범곡중 좋아요를 누른게 있다면 적절한 boolean 값 설정.
					}
				}
			}
			System.out.println("searchAlbumSong   :  "+ checkLike);
		}
		
		System.out.println("searchAlbumSong   :  "+ songList);
		model.addAttribute("albumid", albumid);
		model.addAttribute("songList", songList);
		model.addAttribute("artistAlbum", artistAlbum);
		model.addAttribute("artistName", songList.get(0).getArtist());		//위에서 날려버린 ArtistName을 가져와서 모델로 뿌림.(화면은 정상적으로 나옴)
		model.addAttribute("count", count);
		
		
		return "searchAlbumSong";
	}
	
	@RequestMapping(value="doAjax" , method=RequestMethod.GET)
	public @ResponseBody Song doAjax(String songId, Model model) {
		System.out.println("여기로 오나");
		logger.info("=====> " + songId);
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		Song song = dao.songUrl(songId);
		System.out.println("노래 객체 : "+song);
		
		return song;
	}
	
	@RequestMapping(value="songList", method=RequestMethod.GET)
	public @ResponseBody List<Song> songids(
			@RequestParam(value="songids") List<String> songids) {
		System.out.println("와야지");
		System.out.println("아작스 : " + songids);
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		List<Song> songIdsList = new ArrayList<>();
		for (String songid : songids) {
			System.out.println("1");
			System.out.println(songid);
			songIdsList.add(dao.songUrl(songid));
			System.out.println("이거 : " + songIdsList);
		}
		return songIdsList;
	}
	
	@RequestMapping(value="searchAlbumList", method=RequestMethod.POST)
	public @ResponseBody List<MakeAlbum> searchAlbumList (HttpSession session) {
		System.out.println("여기로 오나");
		String loginId = (String) session.getAttribute("loginId");
		List<MakeAlbum> makeAlbumList = new ArrayList<>();
		if(loginId == null) {
			//로그인 인터셉터 띄우기
		}else {
			System.out.println("로그인 아이디===>"+loginId);
			MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
			makeAlbumList = dao.selectMakeAlbum(loginId);
			/*MakeAlbum Vo에 곡을 카운트하는 게터,세터 만듦*/
			
		}
		System.out.println(makeAlbumList);
		return makeAlbumList;
	}
	
	@RequestMapping(value="myAlbumAdd", method=RequestMethod.POST)
	public @ResponseBody List<MakeAlbum> myAlbumAdd(@RequestBody Map<String, Object> data, HttpSession session) {
		System.out.println("aaaaaaaa");
		Map<String, Object> map = new HashMap<>();
		
		String loginId = (String) session.getAttribute("loginId");
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		System.out.println("zzz"+data.get("savedFileName"));
		String songTitleName = loginId + data.get("title");
		map.put("songId", data.get("songId"));
		map.put("title", data.get("title"));
		map.put("loginId", loginId);
		map.put("songTitleName", songTitleName);
		map.put("savedFileName", data.get("savedFileName"));
		map.put("originalFileName", data.get("originalFileName"));
		dao.myAlbumAdd(map);		
		dao.makeAlbumSong(map);
		
		return null;
	}
	
	@RequestMapping(value="removeAlbum", method=RequestMethod.GET)
	public @ResponseBody List<MakeAlbum> removeAlbum(String title, HttpSession session) {
		HashMap<String, Object> map = new HashMap<>();
		System.out.println("여기에 타이틀 :: " + title);
		String loginId = (String) session.getAttribute("loginId");
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		String songTitleName = loginId + title;
		System.out.println("메이크앨범아이디 :: " + songTitleName);
		map.put("loginId", loginId);
		map.put("songTitleName", songTitleName);
		dao.makeAlbumSongsDelete(map);
		dao.makeAlbumDelete(map);
		
		return null;
	}
	
	@RequestMapping(value="selectAlbumAdd", method=RequestMethod.GET)
	public @ResponseBody List<MakeAlbum> selectAlbumAdd (
			@RequestParam(value="songIds") List<String> songIds, String title, String savedFileName, String originalFileName, HttpSession session) {
		System.out.println("여기로 들어오긴 하나? " + songIds);
		System.out.println("이건 타이틀 : " + title);
		
		HashMap<String, Object> map = new HashMap<>();
		
		String loginId = (String)session.getAttribute("loginId");
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		String songTitleName = loginId + title;
		map.put("title", title);
		map.put("loginId", loginId);
		map.put("songTitleName", songTitleName);
		map.put("savedFileName", savedFileName);
		map.put("originalFileName", originalFileName);
		dao.myAlbumAdd(map);
		String ids = "";
		for(int i=0; i<songIds.size(); i++) {
			MakeAlbumSongs mas = new MakeAlbumSongs();
			ids = songIds.get(i);
			mas.setMakealbumid(songTitleName);
			mas.setSongid(ids);
			dao.makeAlbumsongList(mas);
		}
		
		return null;
	}
	
	@RequestMapping(value="selectAddList", method=RequestMethod.GET)
	public @ResponseBody List<MakeAlbum> selectAddList (
			@RequestParam(value="songIds") List<String> songIds, String title, HttpSession session) {
		System.out.println("여기로 들어오긴 하나? " + songIds);
		System.out.println("이건 타이틀 : " + title);
		
		HashMap<String, Object> map = new HashMap<>();
		
		String loginId = (String)session.getAttribute("loginId");
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		String songTitleName = loginId + title;
		map.put("title", title);
		map.put("loginId", loginId);
		map.put("songTitleName", songTitleName);
		String ids = "";
		for(int i=0; i<songIds.size(); i++) {
			MakeAlbumSongs mas = new MakeAlbumSongs();
			ids = songIds.get(i);
			mas.setMakealbumid(songTitleName);
			mas.setSongid(ids);
			dao.makeAlbumsongList(mas);
		}
		
		return null;
	}
	
	@RequestMapping(value="selectAddOne", method=RequestMethod.GET)
	public @ResponseBody List<MakeAlbum> selectAddOne (
			String songIds, String title, HttpSession session) {
		System.out.println("여기로 들어오긴 하나? " + songIds);
		System.out.println("이건 타이틀 : " + title);
		
		HashMap<String, Object> map = new HashMap<>();
		
		String loginId = (String)session.getAttribute("loginId");
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		String songTitleName = loginId + title;
		System.out.println("makeAlbumId :: " + songTitleName);
		map.put("title", title);
		map.put("loginId", loginId);
		map.put("songTitleName", songTitleName);
		map.put("songIds", songIds);
		dao.makeAlbumsongOne(map);
		
		return null;
	}
	
	@RequestMapping(value="goTotalArtistNameSongList", method=RequestMethod.GET)
	public String goTotalArtistNameSongList (
			@RequestParam(value="currentPage", defaultValue="1") int currentPage
			,String content, Model model, PageNavigator pagenavi) {
		
		System.out.println("들어와라11");
		System.out.println(content);
		
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		
		List<Song> searchBasedOnArtistNameSongList = new ArrayList<>();
		
		int countPerPage = 10;
		int pagePerGroup = 5;
		
		int offset = ((currentPage-1)*countPerPage);
		
		RowBounds row = new RowBounds(offset, countPerPage);
		
		int searchBasedOnArtistNameSongListCountPage = dao.searchBasedOnArtistNameSongListCountPage(content);
		
		pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, searchBasedOnArtistNameSongListCountPage);

		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println(searchBasedOnArtistNameSongListCountPage);
		System.out.println(pagenavi.getStartRecord());
		System.out.println(pagenavi.getCountPerPage());
		System.out.println(pagenavi.getEndPageGroup());
		map.put("content", content);
		
		searchBasedOnArtistNameSongList = dao.searchBasedOnArtistNameSongListMap(map,row);
		model.addAttribute("pagenavi", pagenavi);
		
		model.addAttribute("searchBasedOnArtistNameSongList", searchBasedOnArtistNameSongList);
		model.addAttribute("searchBasedOnArtistNameSongListCount", searchBasedOnArtistNameSongListCountPage);
		model.addAttribute("artistName", content);
		
		
		return "goTotalArtistNameSongList";
	}
	
	@RequestMapping(value="goTotalSongNameSongList", method=RequestMethod.GET)
	public String goTotalSongNameSongList (
			@RequestParam(value="currentPage", defaultValue="1") int currentPage
			,String content, Model model, PageNavigator pagenavi) {
		System.out.println("들어와라22");
		System.out.println(content);
		
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		
		List<Song> searchBasedOnSongNameSongList = new ArrayList<>();
		
		int countPerPage = 10;
		int pagePerGroup = 5;
		
		int offset = ((currentPage-1)*countPerPage);
		
		RowBounds row = new RowBounds(offset, countPerPage);
		
		int searchBasedOnSongNameSongListCountPage = dao.searchBasedOnSongNameSongListCountPage(content);
		
		pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, searchBasedOnSongNameSongListCountPage);

		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println(searchBasedOnSongNameSongListCountPage);
		System.out.println(pagenavi.getStartRecord());
		System.out.println(pagenavi.getCountPerPage());
		System.out.println(pagenavi.getEndPageGroup());
		map.put("content", content);
		
		searchBasedOnSongNameSongList = dao.searchBasedOnSongNameSongListMap(map,row);
		
		model.addAttribute("searchBasedOnSongNameSongList", searchBasedOnSongNameSongList);
		model.addAttribute("searchBasedOnSongNameSongListCount", searchBasedOnSongNameSongListCountPage);
		model.addAttribute("artistName", content);
		
		return "goTotalSongNameSongList";
	}
	
	@RequestMapping(value="goTotalAlbumNameSongList", method=RequestMethod.GET)
	public String goTotalAlbumNameSongList (
			@RequestParam(value="currentPage", defaultValue="1") int currentPage
			,String content, Model model, PageNavigator pagenavi) {
		
		System.out.println("들어와라33");
		System.out.println(content);
		
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		
		List<Song> searchBasedOnAlbumNameSongList = new ArrayList<>();
		
		int countPerPage = 10;
		int pagePerGroup = 5;
		
		int offset = ((currentPage-1)*countPerPage);
		
		RowBounds row = new RowBounds(offset, countPerPage);
		
		int searchBasedOnAlbumNameSongListCountPage = dao.searchBasedOnAlbumNameSongListCountPage(content);
		
		pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, searchBasedOnAlbumNameSongListCountPage);
		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println(searchBasedOnAlbumNameSongListCountPage);
		System.out.println(pagenavi.getStartRecord());
		System.out.println(pagenavi.getCountPerPage());
		System.out.println(pagenavi.getEndPageGroup());
		System.out.println(pagenavi.getStartPageGroup());
		map.put("content", content);
		
		searchBasedOnAlbumNameSongList = dao.searchBasedOnAlbumNameSongListMap(map,row);
		
		model.addAttribute("searchBasedOnAlbumNameSongList", searchBasedOnAlbumNameSongList);
		model.addAttribute("searchBasedOnAlbumNameSongListCount", searchBasedOnAlbumNameSongListCountPage);
		model.addAttribute("artistName", content);
		
		return "goTotalAlbumNameSongList";
	}
	
	/*@RequestMapping(value="goProfile", method=RequestMethod.GET)
	public String goProfile () {
		
		return "admin";
	}*/
	
	/*@RequestMapping(value="uploadmp", method=RequestMethod.POST)
	public @ResponseBody Song upload (MultipartFile file, HttpServletRequest request) throws IOException, UnsupportedTagException, InvalidDataException{
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		System.out.println(file);
		
		String uidValue = null;
		String fpath = null;
		String savedFile = null;
		Song song = new Song();
		
		//포스터 선택 한 경우
				if(!file.isEmpty()) {
					
					String originalFile = file.getOriginalFilename();
					//UUID - 단일의 값을 발생
					UUID uid = UUID.randomUUID();
					savedFile = uid.toString()+"_"+originalFile;
					uidValue = uid.toString();
					logger.info(originalFile);
					logger.info(savedFile);
					
					//업로드의 실제위치를 알려달라
					String path = request.getSession().getServletContext().getRealPath("/upload");
					fpath = path+"\\"+savedFile; // 경로+실제파일이 합쳐진 것
					//클라이언트가 올린 땐 input이고 input에서 우리 서버에 저장하려면 output이다
					System.out.println("===> 저장경로" + fpath);
					FileOutputStream fs = new FileOutputStream(fpath);
					fs.write(file.getBytes());
					
					fs.close();
					
				}
				
				//DB에 저장함
				
				System.out.println("===> 실제 저장경로와 파일명 :: " + fpath);
				
				//mp3파일 태그 읽어오기
				Mp3File mp3file = new Mp3File(fpath);
				
				if(mp3file.hasId3v2Tag()) {
					ID3v2 id3v2Tag = mp3file.getId3v2Tag();
					song.setArtist(id3v2Tag.getArtist());
					song.setAlbumtitle(id3v2Tag.getAlbum());
					song.setSongtitle(id3v2Tag.getTitle());
					song.setReleasedate(id3v2Tag.getYear());
					song.setWriter(id3v2Tag.getComposer());
					song.setLyricwriter(id3v2Tag.getPublisher());
					
					byte[] imageData = id3v2Tag.getAlbumImage();
					BufferedImage img = ImageIO.read(new ByteArrayInputStream(imageData));
					
					if(imageData != null) {
						String mimeType = id3v2Tag.getAlbumImageMimeType();
						System.out.println("===> 마임타입 :: " + mimeType);
						String fileType = null;
						String location = null;
						String totalName = null;
						
						int lastIndexOf = mimeType.lastIndexOf('/');
						
						if(lastIndexOf == -1) {
							fileType = "";
						} else {
							fileType = mimeType.substring(lastIndexOf + 1);
							System.out.println("그림확장자 :: " + fileType);
						}
						
						int fpathLength = fpath.length()-5;
						
						if(fpathLength == 0) {
							location = "";
						} else {
							location = fpath.substring(0, fpathLength + 1);
							System.out.println("저장위치 :: " + location);
						}
						System.out.println("최종 위치 및 확장자 :: " + location + "." + fileType);
						
						File albumCover = new File(location+"."+fileType);
						//totalName = location+"."+fileType;
						
						ImageIO.write(img, fileType, albumCover);
						
						int savedFileLastIndex = savedFile.length()-5;
						if(savedFileLastIndex == 0) {
							totalName = "";
						} else {
							totalName = savedFile.substring(0, savedFileLastIndex + 1);
						}
						System.out.println(totalName + "." + fileType);
						song.setSavedfile(totalName + "." + fileType);
						song.setOriginalfile(fpath);
					}
				}
				
				//dao.insert(vo);
		
		return song;
	}
	
	@RequestMapping(value="saveInfo", method=RequestMethod.POST)
	public String saveInfo (HttpServletRequest request, Song so) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		System.out.println("===> song 객체 :: " + request.getParameter("songtitle"));
		System.out.println("===> :: " + so);
		System.out.println("송타이틀 :: " + so.getSongtitle());
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		UUID uid = UUID.randomUUID();
		UUID uid2 = UUID.randomUUID();
		UUID uid3 = UUID.randomUUID();
		so.setSongid(uid.toString());
		so.setSource(so.getOriginalfile());
		so.setAlbumid(uid2.toString());
		
		if(so.getArtistid().length() == 0) {
			so.setArtistid(uid3.toString());
			dao.insertSongInfo(so);
			dao.insertNewArtist(so);	
		}else {
			dao.insertSongInfo(so);
		}
		
		return "index";
	}
	
	@RequestMapping(value="artistNameCheck", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> artistNameCheck (String artistName) {
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		System.out.println("아티스트이름 :: " + artistName.length());
		String message = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
			Artist artistNameCheck = null;
			artistNameCheck = dao.artistNameCheck(artistName);
			
			if(artistNameCheck == null) {
				map.put("status", "0");
			} else {
				List<Artist> artistNameCheckList = new ArrayList<>();
				artistNameCheckList = dao.artistNameCheckList(artistName);
				System.out.println("아티스트이름 리스트 :: " + artistNameCheckList);
				map.put("artistNameCheckList", artistNameCheckList);
				map.put("status", "1");
			}
		map.put("aaa", message);
		obj.status
		
		var t = obj.aaa;
		
		return map;
	}*/
	
	@RequestMapping(value="albumCoverUpload", method=RequestMethod.POST)
	public @ResponseBody MakeAlbum albumCoverUpload (MultipartFile file, HttpServletRequest request) throws IOException {
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		
		System.out.println(file);
		
		MakeAlbum mk = new MakeAlbum();
		
		if(!file.isEmpty()) {
			String originalFile = file.getOriginalFilename();
					
			//UUID - 단일의 값을 발생
			UUID uid = UUID.randomUUID();
			String savedFile = uid.toString()+"_"+originalFile;
			logger.info(originalFile);
			logger.info(savedFile);
			
			mk.setOriginalfile(originalFile);
			mk.setSavedfile(savedFile);
			
			
			//업로드의 실제위치를 알려달라
			String path = request.getSession().getServletContext().getRealPath("/upload"); 
			String fpath = path+"\\"+savedFile; // 경로+실제파일이 합쳐진 것
			//클라이언트가 올린 땐 input이고 input에서 우리 서버에 저장하려면 output이다
			
			System.out.println("===> 저장경로" + fpath);
			FileOutputStream fs = new FileOutputStream(fpath);
			fs.write(file.getBytes());
			
			fs.close();
		}
		return mk;
	}
	
	/*@RequestMapping(value="logInfo", method=RequestMethod.GET)
	public String logInfo(HttpSession session, Model model) {
		System.out.println("zzz");
		List<Log> logList = new ArrayList<>();
		
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		String loginId = (String) session.getAttribute("loginId");
		logList = dao.selectLogInfo(loginId);
		int count = dao.selectLogCount(loginId);
		System.out.println(logList);
		model.addAttribute("logList", logList);
		model.addAttribute("count", count);
		return "logView";
	}*/
	
	@RequestMapping(value="logInfo", method=RequestMethod.GET)
	public String genres(
			@RequestParam(value="currentPage", defaultValue="1") int currentPage, 
			HttpSession session, Model model, PageNavigator pagenavi){
		
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		
		String loginId = (String) session.getAttribute("loginId");
		
		System.out.println(loginId);
		
		int countPerPage = 10;
		int pagePerGroup = 5;
		
		int total = dao.selectLogCount(loginId);
		System.out.println("total : " + total);
		System.out.println(currentPage);
		int offset = ((currentPage-1)*countPerPage);
		
		RowBounds row = new RowBounds(offset, countPerPage);
		pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);

		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println(pagenavi.getStartRecord());
		System.out.println(pagenavi.getCountPerPage());
		System.out.println(pagenavi.getEndPageGroup());
		map.put("loginId", loginId);
		
		System.out.println(row);
		List<Log> logList = dao.selectLogList(map,row);
		System.out.println("장르별 list" + logList);
		
		model.addAttribute("logList", logList);
		model.addAttribute("pagenavi", pagenavi);
		model.addAttribute("total", total);
		return "logView";
	}
	
	
	
	
	/////////////////////////////` 부분///////////////////////////////////
	@RequestMapping(value="likeMusic", method=RequestMethod.POST)
	public @ResponseBody int likeMusic(						//좋아요 하트버튼 누를때마다 호출
			@RequestBody Map<String, String> map, HttpSession session){
		System.out.println("여기가 1");
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		JbuserDAO dao1 = sqlSession.getMapper(JbuserDAO.class);
		String loggedInId = (String) session.getAttribute("loginId");
		String songId = map.get("songId");						
		Map<String, String> map1 = new HashMap<String, String>();
		map1.put("userId", loggedInId);
		map1.put("songId", songId);
		dao.insertLikeMusic(map1);					//로그인한 애와 좋아요 누른 곡ID를 가져와서 좋아요 처리함
		
		Song likedSong = dao.selectSong(songId);			//좋아요한 곡을 가져와서
		int LikeCount = dao.selectLikeCount(songId);	  // 라이크한 곡의 like숫자를 센다
		System.out.println("여기가 2");
		Musicfeed musicfeed = new Musicfeed();
		musicfeed.setWriterUser(loggedInId);
		musicfeed.setWritemessage("I liked " + likedSong.getSongtitle());			//뮤직피드에도 동시에 내가 좋아했다더라 하고 적어줌
		musicfeed.setMusicfeedtitle(likedSong.getAlbumid());
		dao1.insertMusicFeed(musicfeed);
		System.out.println("전체 라이크한 수 :: " + LikeCount);
		
		System.out.println("likeMusic");
		return LikeCount;
	}
	
	@RequestMapping(value="deleteLike", method=RequestMethod.POST)
	public @ResponseBody int deleteLike(				//좋아요 취소
			@RequestBody Map<String, String> map, HttpSession session){
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		String loggedInId = (String) session.getAttribute("loginId");
		String songId = map.get("songId");
		Map<String, String> map1 = new HashMap<String, String>();
		map1.put("userId", loggedInId);
		map1.put("songId", songId);
		dao.deleteLikeMusic(map1);			//로그인한 애의 ID와 좋아요 취소한 곡의 ID로 좋아요 취소 처리
		
		int LikeCount = dao.selectLikeCount(songId);
		System.out.println("deleteLike");
		return LikeCount;
	}
	
	@RequestMapping(value="likes", method=RequestMethod.GET)
	public String likes(HttpSession session, Model model, PageNavigator pagenavi,
			@RequestParam(value="currentPage", defaultValue="1") int currentPage){
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		String loggedInId = (String) session.getAttribute("loginId");
		List<Song> userLikes = null;
		int countPerPage = 20;				//한 페이지에 20개 출력
		int pagePerGroup = 5;
		int total = dao.getUserLikesCount(loggedInId);		
		
		pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", loggedInId);
		map.put("startRecord", pagenavi.getStartRecord());
		map.put("countPerPage", pagenavi.getCountPerPage());
		userLikes = dao.getUserLikes(map);					//로그인한 애가 좋아요한 곡들의 목록을 적절히 페이징해서 가져옴
		for (int i = 0; i < userLikes.size(); i++) {
			userLikes.get(i).setLike(true);
		}
		model.addAttribute("pagenavi", pagenavi);
		model.addAttribute("userLikes", userLikes);
		return "likes";
	}
	
	@RequestMapping(value="likesOther", method=RequestMethod.GET)
	public String likesOther(							//내가 프로필을 보고 있는 애가 좋아요 누른 목록 보기
			@RequestParam(value="otherUserId", required=true) String otherUserId
			, @RequestParam(value="currentPage", defaultValue="1") int currentPage
			, Model model, PageNavigator pagenavi){
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		JbuserDAO dao1 = sqlSession.getMapper(JbuserDAO.class);
		Jbuser otherUser = dao1.selectOne(otherUserId);
		List<Song> otherLikes = null;
		
		int countPerPage = 20;
		int pagePerGroup = 5;
		int total = dao.getUserLikesCount(otherUserId);
		
		pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", otherUserId);
		map.put("startRecord", pagenavi.getStartRecord());
		map.put("countPerPage", pagenavi.getCountPerPage());
		otherLikes = dao.getUserLikes(map);									//얘가 좋아요 누른 곡들을 적절히 페이징해서 가져옴
		
		model.addAttribute("otherNick", otherUser.getUsernick());
		model.addAttribute("otherLikes", otherLikes);
		model.addAttribute("pagenavi", pagenavi);
		model.addAttribute("otherUserId", otherUserId);
		return "likesOther";
	}
	
	///////////////////////////////신고기능/////////////////////////////
	@RequestMapping(value="reportMusicFeed", method=RequestMethod.POST)
	public @ResponseBody void reportMusicFeed(				//뮤직피드 신고(profile.jsp)
			@RequestBody Map<String, String> map){
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		String musicfeedid = map.get("musicfeedid");
		dao.insertReportMusicFeed(musicfeedid);				//뮤직피드 신! 고!
		
		System.out.println("reportMusicFeed");
	}
	@RequestMapping(value="reportMessage", method=RequestMethod.POST)
	public @ResponseBody void reportMessage(			//메세지 신고	(Message.jsp)
			@RequestBody Map<String, String> map){
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		String messageid = map.get("messageid");
		dao.insertReportMessage(messageid);				//메세지 신! 고!
		
		System.out.println("reportMessage");
	}
	@RequestMapping(value="reportSong", method=RequestMethod.POST)
	public @ResponseBody void reportSong(			//곡 신고!	(searchAlbumSong.jsp)
			@RequestBody Map<String, String> map){
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		String songid = map.get("songid");
		String reason = map.get("reason");			//이유도 받아 갖고 옴
		Map<String, String> map1 = new HashMap<String, String>();
		
		map1.put("songid", songid);
		map1.put("reason", reason);
		dao.insertReportSong(map1);					//이유와 같이 신!고!
		
		System.out.println("reportSong");
	}
	@RequestMapping(value="reportAlbum", method=RequestMethod.POST)
	public @ResponseBody void reportAlbum(				//앨범 신고 (searchAlbumSong.jsp)
			@RequestBody Map<String, String> map){
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		String albumid = map.get("albumid");
		String reason = map.get("reason");
		Map<String, String> map1 = new HashMap<String, String>();
		
		map1.put("albumid", albumid);
		map1.put("reason", reason);
		dao.insertReportAlbum(map1);			//이하 곡 신고와 같음
		
		System.out.println("reportAlbum");
	}
	@RequestMapping(value="reportArtist", method=RequestMethod.POST)
	public @ResponseBody void reportArtist( 			//아티스트 신고. 이하 곡, 앨범 신고와 같음 (searchAlbumSong.jsp)
			@RequestBody Map<String, String> map){
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		String artistid = map.get("artistid");
		String reason = map.get("reason");
		Map<String, String> map1 = new HashMap<String, String>();
		
		map1.put("artistid", artistid);
		map1.put("reason", reason);
		dao.insertReportArtist(map1);
		
		System.out.println(artistid+":  " + reason);
		System.out.println("reportArtist");
	}
	
	
	
	////////////////////--------장르----------//////////////////////////////
	
	//404 맵핑 경로를 잘못 줬거나 컨트롤러를 잘못 만들었거나 servlet.xml에 bean이 잘 등록되었는지 
	//500 db에 경로가 잘 되었는지
	//400 (value="currentPage", defaultValue="1") int currentPage) { 여기서 currentPage가 일치 하지 않는 경우 
	@RequestMapping(value="All", method=RequestMethod.GET)
	public String All(
			@RequestParam(value="currentPage", defaultValue="1") int currentPage, 
			@RequestParam(value="sn", defaultValue="All") String sn,
			Model model, PageNavigator pagenavi){
		
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		
		List<String> genreList = dao.genreList();
		
		int countPerPage = 10;
		int pagePerGroup = 5;
		
		int total = dao.getTotal();
		
		pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
		
		RowBounds row = new RowBounds(pagenavi.getStartRecord(), pagenavi.getCountPerPage());
		
		
		List<ArtistAlbum> list = dao.showAll(row);
		
		model.addAttribute("aa", list);
		model.addAttribute("pagenavi", pagenavi);
		model.addAttribute("genreList", genreList);
		model.addAttribute("sn", sn);
	
		return "genres";
		
	}
	
@RequestMapping(value="emo", method=RequestMethod.GET)
public String emo(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="emo") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);	
	
	return "genres";
}
	
@RequestMapping(value="rock", method=RequestMethod.GET)
public String rock(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="rock") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	System.out.println("pagenavi : " + pagenavi);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	map.put("currentPage", currentPage);
	System.out.println("start : " + map.get("startRecord")+"\n countPerPage : "+map.get("countPerPage")+" tag Value : "+map.get("tagvalue") +"또탈"+ total);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	System.out.println(list);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="acoustic", method=RequestMethod.GET)
public String acoustic(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="acoustic") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="ambient", method=RequestMethod.GET)
public String ambient(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="ambient") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="blues", method=RequestMethod.GET)
public String blues(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="blues") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);	
	
	return "genres";
}

@RequestMapping(value="classical", method=RequestMethod.GET)
public String classical(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="classical") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="country", method=RequestMethod.GET)
public String country(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="country") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="electronic", method=RequestMethod.GET)
public String electronic(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="electronic") String sn, Model model, PageNavigator pagenavi){
	

	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="folk", method=RequestMethod.GET)
public String folk(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="folk") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="hardcore", method=RequestMethod.GET)
public String hardcore(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="hardcore") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="hip hop", method=RequestMethod.GET)
public String hiphop(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="hip hop") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="jazz", method=RequestMethod.GET)
public String jazz(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="jazz") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="latin", method=RequestMethod.GET)
public String latin(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="latin") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="metal", method=RequestMethod.GET)
public String metal(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="metal") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}


@RequestMapping(value="pop punk", method=RequestMethod.GET)
public String poppunk(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="pop punk") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="punk", method=RequestMethod.GET)
public String punk(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="punk") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="reggae", method=RequestMethod.GET)
public String reggae(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="reggae") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="rnb", method=RequestMethod.GET)
public String rnb(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="rnb") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="soul", method=RequestMethod.GET)
public String soul(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="soul") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}

@RequestMapping(value="world", method=RequestMethod.GET)
public String world(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="world") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}


@RequestMapping(value="indie", method=RequestMethod.GET)
public String indie(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		@RequestParam(value="sn", defaultValue="indie") String sn, Model model, PageNavigator pagenavi){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}


@RequestMapping(value="pop", method=RequestMethod.GET)
public String pop(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
		Model model, PageNavigator pagenavi, 
		@RequestParam(value="sn", defaultValue="pop") String sn
		){
	
	MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
	
	List<String> genreList = dao.genreList();
	
	int countPerPage = 10;
	int pagePerGroup = 5;
	
	int total = dao.getTotalGenre(sn);
	
	pagenavi = new PageNavigator(countPerPage, pagePerGroup, currentPage, total);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("tagvalue", sn);
	map.put("startRecord", pagenavi.getStartRecord());
	map.put("countPerPage", countPerPage);
	
	List<ArtistAlbum> list = dao.showAllGenre(map);
	
	model.addAttribute("aa", list);
	model.addAttribute("pagenavi", pagenavi);
	model.addAttribute("genreList", genreList);
	model.addAttribute("sn", sn);
	
	return "genres";
}
	
	
	
	
}
