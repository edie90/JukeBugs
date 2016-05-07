package org.JukeBugs.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.JukeBugs.vo.Artist;
import org.JukeBugs.vo.ArtistAlbum;
import org.JukeBugs.vo.Like;
import org.JukeBugs.vo.Log;
import org.JukeBugs.vo.MakeAlbum;
import org.JukeBugs.vo.MakeAlbumSongs;
import org.JukeBugs.vo.Song;
import org.apache.ibatis.session.RowBounds;


public interface MusicDAO {
	public List<ArtistAlbum> artistAlbumSelectList(String albumTitle);
	public List<Song> songList(String albumid);
	public ArtistAlbum artistAlbumSelectOne(String content);
	public Artist artistSelectOne(String content);
	public List<Artist> artistSelectList(String content);
	public String checkGroup(String content);
	public List<Artist> groupMemberList(String content);
	public List<ArtistAlbum> artistAlbumSelectListGroup(String content);
	public ArtistAlbum artistAlbumSelectOneId(String albumid);
	public int songListCount(String albumid);
	public Song songUrl(String songId);
	public List<Song> songIdsList(String songid);
	public List<MakeAlbum> selectMakeAlbum(String loginId);
	public void myAlbumAdd(Map<String, Object> map);
	public void makeAlbumSong(Map<String, Object> map);
	public void makeAlbumDelete(HashMap<String, Object> map);
	public void makeAlbumSongsDelete(HashMap<String, Object> map);
	public void makeAlbumsongList(MakeAlbumSongs mas);
	public void makeAlbumsongOne(HashMap<String, Object> map);
	public List<Song> searchBasedOnArtistNameSongList(String content);
	public List<Song> searchBasedOnSongNameSongList(String content);
	public List<Song> searchBasedOnAlbumNameSongList(String content);
	public int searchBasedOnArtistNameSongListCount(String content);
	public int searchBasedOnSongNameSongListCount(String content);
	public int searchBasedOnAlbumNameSongListCount(String content);
	public void insertSongInfo(Song so);
	public List<Artist> artistNameCheckList(String artistName);
	public Artist artistNameCheck(String artistName);
	public void insertNewArtist(Song so);
	public void insertExistArtist(Song so);
	public int selectLogCount(String loginId);
	public List<Log> selectLogList(HashMap<String, Object> map, RowBounds row);
	public List<Song> searchBasedOnArtistNameSongListMap(HashMap<String, Object> map, RowBounds row);
	public int searchBasedOnArtistNameSongListCountPage(String content);
	public int searchBasedOnSongNameSongListCountPage(String content);
	public List<Song> searchBasedOnSongNameSongListMap(HashMap<String, Object> map, RowBounds row);
	public int searchBasedOnAlbumNameSongListCountPage(String content);
	public List<Song> searchBasedOnAlbumNameSongListMap(HashMap<String, Object> map, RowBounds row);
	
	/////////////////////////////Like 기능///////////////////////////////
	public void insertLikeMusic(Map<String, String> map1);
	public void deleteLikeMusic(Map<String, String> map1);
	public List<String> getLikeList(Map<String, String> map);
	public List<Song> getUserLikes(Map<String, Object> map);
	public Song selectSong(String songId);
	public List<Like> countLikeSong(String songid);
	public int selectLikeCount(String songId); // 20160504 개별노래 LikeCount 추가
	public List<String> getSearchArtistNameLikeList(Map<String, String> map);
	public List<String> getSearchSongNameLikeList(Map<String, String> map);
	public List<String> getSearchAlbumNameLikeList(Map<String, String> map);
	/////////////////////////////신고 기능//////////////////////////////////
	public void insertReportMusicFeed(String musicfeedid);
	public void insertReportMessage(String messageid);
	public void insertReportSong(Map<String, String> map1);
	public void insertReportAlbum(Map<String, String> map1);
	public void insertReportArtist(Map<String, String> map1);
	public int getUserLikesCount(String otherUserId);
	
	////////////////////////장르기능////////////////////
	public int getTotalGenre(String sn);
	public List<String> genreList();
	public int getTotal();
	public List<ArtistAlbum> showAllGenre(HashMap<String, Object>map);
	public List<ArtistAlbum> showAll(RowBounds row);
	
	//////////// 신곡 등록 기능 보조 ///////////////
	public void insertHaveSongs (Map<String, String> map);
	public void insertHaveAlbum (Map<String, String> map);

}
