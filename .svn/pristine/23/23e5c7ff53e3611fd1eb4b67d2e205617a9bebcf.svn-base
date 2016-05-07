package org.JukeBugs.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.JukeBugs.vo.ArtistAlbum;
import org.JukeBugs.vo.FindFriendsVO;
import org.JukeBugs.vo.Friend;
import org.JukeBugs.vo.Jbuser;
import org.JukeBugs.vo.Message;
import org.JukeBugs.vo.Musicfeed;
import org.JukeBugs.vo.Song;
import org.apache.ibatis.session.RowBounds;

public interface JbuserDAO {
	
	public void insert(Jbuser jbuser);
	public Jbuser selectOne(String userid);
	public List<ArtistAlbum> showAll(HashMap<String, Object> map);
	public int getTotal();
	
	public void insertMessage(Message message);
	public List<Message> getInboxList(Map<String, Object> map);
	public List<Message> getSentList(Map<String, Object> map);
	public void deleteMessage(String string);
	public ArrayList<FindFriendsVO> recommendFriends(String logedInID, RowBounds rb);
	public void friendRequest(Friend friend);
	public List<Friend> getFollowers(String logedinUserId);
	public List<Friend> getFollowing(String logedinUserId);
	public void deleteFollower(Map<String, String> map);
	public List<String> checkFollowBack(String logedinUserId);
	public String checkFollowBackOther(Map<String, String> map);
	public Friend compatibilityOther(Map<String, String> map);
	public void insertMusicFeed(Musicfeed musicfeed);
	public List<Musicfeed> getMusicFeed(String logedInId);
	public void deleteMusicFeed(String musicfeedid);
	public String checkFollowYou(Map<String, String> map);
	public Musicfeed getMusicFeedById(String musicfeedid);
	public Message getMessageById(String messageid);
	public List<Song> getRankingSong();
	public String getAlbumImgUrl(String albumid);
	public List<Song> getRecommendationSong(String loggedInId);
	public int getInboxTotal(String loggedinUserId);
	public int getSentTotal(String loggedinUserId);
	public List<ArtistAlbum> getRecommendationAlbum(String loggedInId);
	public List<ArtistAlbum> getRankingAlbum();
}
