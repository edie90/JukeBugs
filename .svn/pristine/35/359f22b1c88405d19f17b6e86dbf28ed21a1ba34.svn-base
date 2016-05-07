
/* Drop Tables */

DROP TABLE HaveSong CASCADE CONSTRAINTS;
DROP TABLE JB_HaveAlbum CASCADE CONSTRAINTS;
DROP TABLE JB_TAG_ARTIST CASCADE CONSTRAINTS;
DROP TABLE Relation CASCADE CONSTRAINTS;
DROP TABLE ReportArtist CASCADE CONSTRAINTS;
DROP TABLE Artist CASCADE CONSTRAINTS;
DROP TABLE JB_TAG_ALBUM CASCADE CONSTRAINTS;
DROP TABLE ReportArtistAlbum CASCADE CONSTRAINTS;
DROP TABLE JBLog CASCADE CONSTRAINTS;
DROP TABLE JB_TAG_SONG CASCADE CONSTRAINTS;
DROP TABLE LikeMusic CASCADE CONSTRAINTS;
DROP TABLE Make_Album CASCADE CONSTRAINTS;
DROP TABLE ReportSong CASCADE CONSTRAINTS;
DROP TABLE SONG CASCADE CONSTRAINTS;
DROP TABLE Artist_Album CASCADE CONSTRAINTS;
DROP TABLE Friend CASCADE CONSTRAINTS;
DROP TABLE JBActivate CASCADE CONSTRAINTS;
DROP TABLE ReportMessage CASCADE CONSTRAINTS;
DROP TABLE Message CASCADE CONSTRAINTS;
DROP TABLE ReportMusicFeed CASCADE CONSTRAINTS;
DROP TABLE MusicFeed CASCADE CONSTRAINTS;
DROP TABLE JBUser CASCADE CONSTRAINTS;
DROP TABLE JB_TAG CASCADE CONSTRAINTS;
DROP TABLE Report CASCADE CONSTRAINTS;
drop table Make_Album CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE Artist
(
   ArtistID varchar2(100) NOT NULL,
   ArtistName varchar2(200) NOT NULL,
   ArtistDebut date,
   ArtistBirthDay date,
   ArtistActive varchar2(5) NOT NULL,
   ArtistImgUrl varchar2(800),
   -- 악기 담당 - 맡은 악기
   -- 보컬 - 보컬
   -- 솔로 - 솔로
   ArtistPosition varchar2(30),
   PRIMARY KEY (ArtistID)
);


CREATE TABLE Artist_Album
(
   -- Album_Name+Album_Release 의 키 값을 합쳐서 Primary Key 로 함.
   AlbumID varchar2(100) NOT NULL,
   AlbumRelease date,
   AlbumTitle varchar2(200) NOT NULL,
   -- 만약 널일 경우 해당 값이 존재하지 않음. 이라고 웹 상에 출력되어야 함. (사용자 정의서에 추가해야 될 부분.)
   AlbumDiscription varchar2(200),
   AlbumImgUrl varchar2(800),
   PRIMARY KEY (AlbumID)
);


CREATE TABLE Friend
(
   -- 사용자ID, email형식(즐겨찾기 FK)
   UserID varchar2(50) NOT NULL,
   -- 사용자ID, email형식(즐겨찾기 FK)
   RequestID varchar2(50) NOT NULL
);


CREATE TABLE HaveSong
(
   ArtistID varchar2(100) NOT NULL,
   -- 가수명+제목+출시년도
   SongId varchar2(100) NOT NULL UNIQUE
);


CREATE TABLE JBActivate
(
   -- 사용자ID, email형식(즐겨찾기 FK)
   UserId varchar2(50) NOT NULL,
   -- 프리미엄 활성화 시작 날짜
   ActiveDate date NOT NULL,
   EndDate date
);


CREATE TABLE JBLog
(
   -- 사용자ID, email형식(즐겨찾기 FK)
   -- 접근한 사용자 ID
   UserID varchar2(50) NOT NULL,
   -- 가수명+제목+출시년도
   SongID varchar2(100),
   -- User_ID+Album_Name으로 PK를 만듬.
   MakeAlbumID varchar2(100),
   -- 청취일자
   AccessLog date DEFAULT SYSDATE NOT NULL,
   -- 타입
   AccessType varchar2(10)
);


CREATE TABLE JBUser
(
   -- 사용자ID, email형식(즐겨찾기 FK)
   UserId varchar2(50) NOT NULL,
   -- 비밀번호
   UserPassword varchar2(30) NOT NULL,
   UserName varchar2(20) NOT NULL,
   -- Nickname
   UserNick varchar2(20) NOT NULL,
   UserLike1 varchar2(20) NOT NULL,
   UserLike2 varchar2(20),
   UserLike3 varchar2(20),
   -- PW찾기용 질문
   UserQuestion varchar2(50) NOT NULL,
   -- PW찾기용 질문에 대한 답
   UserAnswer varchar2(50) NOT NULL,
   -- 프로필 사진 URL
   UserProfileImgUrl varchar2(800),
   -- 신고 당한 유저의 True False 값을 확인
   UserIllegal varchar2(5) NOT NULL,
   PRIMARY KEY (UserId)
);


CREATE TABLE JB_HaveAlbum
(
   -- Album_Name+Album_Release 의 키 값을 합쳐서 Primary Key 로 함.
   AlbumID varchar2(100) NOT NULL,
   ArtistID varchar2(100) NOT NULL
);


CREATE TABLE JB_TAG
(
   -- 장르 명을 기본 아이디로 사용
   TagValue varchar2(400) NOT NULL,
   Type varchar2(100),
   PRIMARY KEY (TagValue)
);


CREATE TABLE JB_TAG_ALBUM
(
   -- 장르 명을 기본 아이디로 사용
   TagValue varchar2(400) NOT NULL,
   -- Album_Name+Album_Release 의 키 값을 합쳐서 Primary Key 로 함.
   AlbumID varchar2(100) NOT NULL
);


CREATE TABLE JB_TAG_ARTIST
(
   ArtistID varchar2(100) NOT NULL,
   -- 장르 명을 기본 아이디로 사용
   TagValue varchar2(400) NOT NULL
);


CREATE TABLE JB_TAG_SONG
(
   -- 장르 명을 기본 아이디로 사용
   TagValue varchar2(400) NOT NULL,
   -- 가수명+제목+출시년도
   SongId varchar2(100) NOT NULL
);


CREATE TABLE LikeMusic
(
   -- 사용자ID, email형식(즐겨찾기 FK)
   UserID varchar2(50) NOT NULL,
   -- 가수명+제목+출시년도
   SongID varchar2(100) NOT NULL
);


-- m:n  관계인듯
-- 하나의 앨범안에는 여러개의 노래
CREATE TABLE Make_Album
(
   -- User_ID+Album_Name으로 PK를 만듬.
   MakeAlbumID varchar2(100) NOT NULL,
   MakeAlbumName varchar2(50) NOT NULL,
   MakeAlbumAccess number NOT NULL,
   -- 사용자ID, email형식(즐겨찾기 FK)
   UserID varchar2(50) NOT NULL,
   -- 가수명+제목+출시년도
   SongID varchar2(100) NOT NULL,
   PRIMARY KEY (MakeAlbumID)
);




CREATE TABLE Message
(
   -- Send_ID + TimeStamp (초까지)만 으로 해서 저장.
   MessageID varchar2(80) NOT NULL,
   Message varchar2(500),
   SendDate date NOT NULL,
   -- 사용자ID, email형식(즐겨찾기 FK)
   SendID varchar2(50) NOT NULL,
   -- 사용자ID, email형식(즐겨찾기 FK)
   Request_ID varchar2(50) NOT NULL,
   PRIMARY KEY (MessageID)
);


CREATE TABLE MusicFeed
(
   -- 유저아이디 + 등록날짜(나노초까지)
   MusicFeedId varchar2(50) NOT NULL,
   WriteDate date NOT NULL,
   -- 등록 글
   WriteMessage varchar2(500) NOT NULL,
   -- 제목
   MusicFeedTitle varchar2(50) NOT NULL,
   -- 사용자ID, email형식(즐겨찾기 FK)
   UserId varchar2(50) NOT NULL,
   PRIMARY KEY (MusicFeedId)
);


CREATE TABLE Relation
(
   -- 검색값에 대한 내용이 저장되는 컬럼
   Search_Item varchar2(50) NOT NULL,
   -- 언제 검색을 하였는지에 대한 정보를 저장하는 컬럼
   Search_Date date NOT NULL,
   -- 가수명+제목+출시년도
   SongID varchar2(100),
   -- 장르 명을 기본 아이디로 사용
   TagValue varchar2(400),
   -- Album_Name+Album_Release 의 키 값을 합쳐서 Primary Key 로 함.
   AlbumID varchar2(100),
   ArtistID varchar2(100),
   -- 사용자ID, email형식(즐겨찾기 FK)
   UserId varchar2(50)
);


CREATE TABLE Report
(
   -- 시퀀스 - 신고에 대한 순서를 저장하여 PK로 함.
   ReportId number NOT NULL,
   ReportSubstance varchar2(500) NOT NULL,
   PRIMARY KEY (ReportId)
);


CREATE TABLE ReportArtist
(
   -- 시퀀스 - 신고에 대한 순서를 저장하여 PK로 함.
   ReportId number NOT NULL,
   ArtistID varchar2(100) NOT NULL
);


CREATE TABLE ReportArtistAlbum
(
   -- 시퀀스 - 신고에 대한 순서를 저장하여 PK로 함.
   ReportId number NOT NULL,
   -- Album_Name+Album_Release 의 키 값을 합쳐서 Primary Key 로 함.
   AlbumID varchar2(100) NOT NULL
);


CREATE TABLE ReportMessage
(
   -- 시퀀스 - 신고에 대한 순서를 저장하여 PK로 함.
   ReportId number NOT NULL,
   -- Send_ID + TimeStamp (초까지)만 으로 해서 저장.
   MessageID varchar2(80) NOT NULL
);


CREATE TABLE ReportMusicFeed
(
   -- 시퀀스 - 신고에 대한 순서를 저장하여 PK로 함.
   ReportId number NOT NULL,
   -- 유저아이디 + 등록날짜(나노초까지)
   MusicFeedId varchar2(50) NOT NULL
);


CREATE TABLE ReportSong
(
   -- 시퀀스 - 신고에 대한 순서를 저장하여 PK로 함.
   ReportId number NOT NULL,
   -- 가수명+제목+출시년도
   SongId varchar2(100) NOT NULL
);


CREATE TABLE SONG
(
   -- 가수명+제목+출시년도
   SongId varchar2(100) NOT NULL,
   SongTitle varchar2(200) NOT NULL,
   -- Album_Name+Album_Release 의 키 값을 합쳐서 Primary Key 로 함.
   AlbumID varchar2(100) NOT NULL,
   -- 출시년도
   ReleaseDate date,
   -- 트랙 넘버
   TrackNumber number(3,0),
   Writer varchar2(40),
   LyricWriter varchar2(40),
   -- 음원 URL 또는 음원의 위치
   Source varchar2(800),
   PRIMARY KEY (SongId)
);

CREATE TABLE Make_Album
(
   -- User_ID+Album_Name으로 PK를 만듬.
   MakeAlbumID varchar2(100) NOT NULL,
   MakeAlbumName varchar2(50) NOT NULL,
   MakeAlbumAccess number NOT NULL,
   -- 사용자ID, email형식(즐겨찾기 FK)
   UserID varchar2(50) NOT NULL,
   PRIMARY KEY (MakeAlbumID)
);

CREATE TABLE Make_Album_Songs
(
   -- User_ID+Album_Name으로 PK를 만듬.
   MakeAlbumID varchar2(100) NOT NULL,
   -- 가수명+제목+출시년도
   SongId varchar2(100) NOT NULL
);


drop table make_album;

create table make_album_songs
(
	makealbumid varchar2(100) not null,
	songid varchar2(100) not null
);

drop table make_album_songs


/* Create Foreign Keys */

ALTER TABLE HaveSong
   ADD FOREIGN KEY (ArtistID)
   REFERENCES Artist (ArtistID)
;


ALTER TABLE JB_HaveAlbum
   ADD FOREIGN KEY (ArtistID)
   REFERENCES Artist (ArtistID)
;


ALTER TABLE JB_TAG_ARTIST
   ADD FOREIGN KEY (ArtistID)
   REFERENCES Artist (ArtistID)
;


ALTER TABLE Relation
   ADD FOREIGN KEY (ArtistID)
   REFERENCES Artist (ArtistID)
;


ALTER TABLE ReportArtist
   ADD FOREIGN KEY (ArtistID)
   REFERENCES Artist (ArtistID)
;


ALTER TABLE JB_HaveAlbum
   ADD FOREIGN KEY (AlbumID)
   REFERENCES Artist_Album (AlbumID)
;


ALTER TABLE JB_TAG_ALBUM
   ADD FOREIGN KEY (AlbumID)
   REFERENCES Artist_Album (AlbumID)
;


ALTER TABLE Relation
   ADD FOREIGN KEY (AlbumID)
   REFERENCES Artist_Album (AlbumID)
;


ALTER TABLE ReportArtistAlbum
   ADD FOREIGN KEY (AlbumID)
   REFERENCES Artist_Album (AlbumID)
;


ALTER TABLE SONG
   ADD FOREIGN KEY (AlbumID)
   REFERENCES Artist_Album (AlbumID)
;


ALTER TABLE Friend
   ADD FOREIGN KEY (UserID)
   REFERENCES JBUser (UserId)
;


ALTER TABLE Friend
   ADD FOREIGN KEY (RequestID)
   REFERENCES JBUser (UserId)
;


ALTER TABLE JBActivate
   ADD FOREIGN KEY (UserId)
   REFERENCES JBUser (UserId)
;


ALTER TABLE JBLog
   ADD FOREIGN KEY (UserID)
   REFERENCES JBUser (UserId)
;


ALTER TABLE LikeMusic
   ADD FOREIGN KEY (UserID)
   REFERENCES JBUser (UserId)
;


ALTER TABLE Make_Album
   ADD FOREIGN KEY (UserID)
   REFERENCES JBUser (UserId)
   ON DELETE CASCADE
;


ALTER TABLE Message
   ADD FOREIGN KEY (Request_ID)
   REFERENCES JBUser (UserId)
;


ALTER TABLE Message
   ADD FOREIGN KEY (SendID)
   REFERENCES JBUser (UserId)
;


ALTER TABLE MusicFeed
   ADD FOREIGN KEY (UserId)
   REFERENCES JBUser (UserId)
;


ALTER TABLE Relation
   ADD FOREIGN KEY (UserId)
   REFERENCES JBUser (UserId)
;


ALTER TABLE JB_TAG_ALBUM
   ADD FOREIGN KEY (TagValue)
   REFERENCES JB_TAG (TagValue)
;


ALTER TABLE JB_TAG_ARTIST
   ADD FOREIGN KEY (TagValue)
   REFERENCES JB_TAG (TagValue)
;


ALTER TABLE JB_TAG_SONG
   ADD FOREIGN KEY (TagValue)
   REFERENCES JB_TAG (TagValue)
;


ALTER TABLE Relation
   ADD FOREIGN KEY (TagValue)
   REFERENCES JB_TAG (TagValue)
;


ALTER TABLE JBLog
   ADD FOREIGN KEY (MakeAlbumID)
   REFERENCES Make_Album (MakeAlbumID)
;


ALTER TABLE ReportMessage
   ADD FOREIGN KEY (MessageID)
   REFERENCES Message (MessageID)
;


ALTER TABLE ReportMusicFeed
   ADD FOREIGN KEY (MusicFeedId)
   REFERENCES MusicFeed (MusicFeedId)
;


ALTER TABLE ReportArtist
   ADD FOREIGN KEY (ReportId)
   REFERENCES Report (ReportId)
;


ALTER TABLE ReportArtistAlbum
   ADD FOREIGN KEY (ReportId)
   REFERENCES Report (ReportId)
;


ALTER TABLE ReportMessage
   ADD FOREIGN KEY (ReportId)
   REFERENCES Report (ReportId)
;


ALTER TABLE ReportMusicFeed
   ADD FOREIGN KEY (ReportId)
   REFERENCES Report (ReportId)
;


ALTER TABLE ReportSong
   ADD FOREIGN KEY (ReportId)
   REFERENCES Report (ReportId)
;


ALTER TABLE HaveSong
   ADD FOREIGN KEY (SongId)
   REFERENCES SONG (SongId)
;


ALTER TABLE JBLog
   ADD FOREIGN KEY (SongID)
   REFERENCES SONG (SongId)
;


ALTER TABLE JB_TAG_SONG
   ADD FOREIGN KEY (SongId)
   REFERENCES SONG (SongId)
;


ALTER TABLE LikeMusic
   ADD FOREIGN KEY (SongID)
   REFERENCES SONG (SongId)
;


ALTER TABLE Make_Album
   ADD FOREIGN KEY (SongID)
   REFERENCES SONG (SongId)
;


ALTER TABLE Relation
   ADD FOREIGN KEY (SongID)
   REFERENCES SONG (SongId)
;


ALTER TABLE ReportSong
   ADD FOREIGN KEY (SongId)
   REFERENCES SONG (SongId)
;


ALTER TABLE Make_Album
   ADD FOREIGN KEY (UserID)
   REFERENCES JBUser (UserId)
   ON DELETE CASCADE
;

ALTER TABLE Make_Album_Songs
   ADD FOREIGN KEY (MakeAlbumID)
   REFERENCES Make_Album (MakeAlbumID)
;

ALTER TABLE Make_Album_Songs
   ADD FOREIGN KEY (SongId)
   REFERENCES SONG (SongId)
;

alter table make_album 
	add(savedfile varchar2(500))
	
alter table make_album 
	add(originalfile varchar2(500))




insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis1','2016/04/07','aaa');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis2','2016/04/07','bbb');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis3','2016/04/07','ccc');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis4','2016/04/07','ddd');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis5','2016/04/07','eee');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis6','2016/04/07','fff');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis7','2016/04/07','ggg');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis8','2016/04/07','hhh');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis9','2016/04/07','iii');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis10','2016/04/07','jjj');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis11','2016/04/07','kkk');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis12','2016/04/07','lll');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis13','2016/04/07','mmm');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis14','2016/04/07','nnn');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('oasis15','2016/04/07','ooo');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('samsmith1','2016/04/07','ooo');
insert into ARTIST_ALBUM (albumid, albumrelease, albumtitle) values ('samsmith2','2016/04/07','ooo');

insert into song (songid, songtitle, albumid, releasedate) 
values ('20','banana','oasis1 ','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('21','banana','oasis1','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('22','banana','oasis1','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('23','banana','oasis1','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('24','banana','oasis1','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('25','banana','oasis1','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('26','banana','oasis1','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('27','banana','oasis1','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('28','banana','oasis1','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('29','banana','oasis1','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('30','banana','oasis1','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('31','banana','oasis1','2016/04/07');  --oasis1 12곡

insert into song (songid, songtitle, albumid, releasedate) 
values ('32','banana','oasis2','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('33','banana','oasis2','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('34','banana','oasis2','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('35','banana','oasis2','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('36','banana','oasis2','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('37','banana','oasis2','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('38','banana','oasis2','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('39','banana','oasis2','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('40','banana','oasis2','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('41','banana','oasis2','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('42','banana','oasis2','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('43','banana','oasis2','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('44','banana','oasis2','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('45','banana','oasis2','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('46','banana','oasis2','2016/04/07');  --oasis2 15곡

insert into song (songid, songtitle, albumid, releasedate) 
values ('47','lay me down','samsmith1','2016/04/07');
insert into song (songid, songtitle, albumid, releasedate) 
values ('48','writing''s on the wall','samsmith2','2016/04/07');



insert into havesong (artistid, songid) values ('oasis','20');
insert into havesong (artistid, songid) values ('oasis','21');
insert into havesong (artistid, songid) values ('oasis','22');
insert into havesong (artistid, songid) values ('oasis','23');
insert into havesong (artistid, songid) values ('oasis','24');
insert into havesong (artistid, songid) values ('oasis','25');
insert into havesong (artistid, songid) values ('oasis','26');
insert into havesong (artistid, songid) values ('oasis','27');
insert into havesong (artistid, songid) values ('oasis','28');
insert into havesong (artistid, songid) values ('oasis','29');
insert into havesong (artistid, songid) values ('oasis','30');
insert into havesong (artistid, songid) values ('oasis','31');
insert into havesong (artistid, songid) values ('oasis','32');
insert into havesong (artistid, songid) values ('oasis','33');
insert into havesong (artistid, songid) values ('oasis','34');
insert into havesong (artistid, songid) values ('oasis','35');
insert into havesong (artistid, songid) values ('oasis','36');
insert into havesong (artistid, songid) values ('oasis','37');
insert into havesong (artistid, songid) values ('oasis','38');
insert into havesong (artistid, songid) values ('oasis','39');
insert into havesong (artistid, songid) values ('oasis','40');
insert into havesong (artistid, songid) values ('oasis','41');
insert into havesong (artistid, songid) values ('oasis','42');
insert into havesong (artistid, songid) values ('oasis','43');
insert into havesong (artistid, songid) values ('oasis','44');
insert into havesong (artistid, songid) values ('oasis','45');
insert into havesong (artistid, songid) values ('oasis','46');

insert into havesong (artistid, songid) values ('samsmith','47');
insert into havesong (artistid, songid) values ('samsmith','48');


insert into jb_havealbum (albumid, artistid) values ('oasis1','oasis');
insert into jb_havealbum (albumid, artistid) values ('oasis2','oasis');
insert into jb_havealbum (albumid, artistid) values ('samsmith1','samsmith');
insert into jb_havealbum (albumid, artistid) values ('samsmith2','samsmith');


insert into artist values ('oasis','oasis','1991/04/11','2016/04/11','go','oasis.jpg','rock');
insert into artist values ('samsmith','samsmith','2010/04/11','2016/04/11','go','samsmith.jpg','Pop');
insert into artist values ('oasis','samsmith','2010/04/11','2016/04/11','go','samsmith.jpg','Pop');
   -- 가수명+제목+출시년도
   SongId varchar2(100) NOT NULL,
   SongTitle varchar2(50) NOT NULL,
   ArtistID varchar2(50),
   -- 그룹명+데뷔년도 (데뷔 일자의 여부는 차후 논의)
   GroupID varchar2(60),
   -- Album_Name+Album_Release 의 키 값을 합쳐서 Primary Key 로 함.
   AlbumID varchar2(60) NOT NULL,
   -- 출시년도
   ReleaseDate date NOT NULL,

   
   select s.*, ar.artistname artist 
  	from song s, havesong hs, artist ar  
	where ar.artistid = hs.artistid and hs.songid = s.songid and 
	lower(ar.artistname) = lower('oasis');
	
	select s.*, ar.artistname artist, ar.artistid artistid, 
		   ar_al.albumtitle albumtitle, ar_al.albumid albumid 
  	from song s, havesong hs, artist ar, jb_havealbum jb_hal, artist_album ar_al   
	where ar.artistid = hs.artistid and hs.songid = s.songid and 
		  ar.artistid = jb_hal.artistid and jb_hal.albumid = ar_al.albumid and  
	      lower(ar.artistname) = lower('oasis');
	      
	select ar_al.albumtitle, s.songtitle from artist ar, havesong hs, song s, jb_havealbum jb_hal, artist_album ar_al 
where ar.artistid = hs.artistid and hs.songid = s.songid and 
ar.artistid = jb_hal.artistid and jb_hal.albumid = ar_al.albumid and 
lower(ar.artistname) = lower('oasis');      

select ar_al.albumtitle , s.songtitle from artist ar, havesong hs, song s,  artist_album ar_al 
where ar.artistid = hs.artistid and hs.songid = s.songid and 
s.albumid = ar_al.albumid and 
lower(ar.artistname) = lower('oasis');

select count(s.songid) count from artist ar, havesong hs, song s, artist_album ar_al
	where ar.artistid = hs.artistid and hs.songid = s.songid and 
		  s.albumid = ar_al.albumid and 
	      lower(ar.artistname) = lower('oasis');
	      
	      select ar_al.albumtitle, ar_al.albumimgurl, ar.artistname artist, ar.artistid artistid, 
  	ar_al.albumid albumid, s.*    
  	from artist ar, havesong hs, song s, artist_album ar_al 
	where ar.artistid = hs.artistid and hs.songid = s.songid and 
		  s.albumid = ar_al.albumid and 
	      lower(ar.artistname) = lower('oasis')
	      
	      select ar_al.albumtitle, ar_al.albumimgurl, ar_al.albumid albumid, 
       ar.artistname artist, ar.artistid artistid, s.*    
from artist ar, havesong hs, song s, artist_album ar_al 
where s.songid = hs.songid and hs.artistid = ar.artistid and 
s.albumid = ar_al.albumid and (lower(s.songtitle) like '%' || lower('oasis') || '%')

select s.songtitle, s.releasedate, s.albumid, s.source, jbl.*, ar.artistname,
ar.artistid, ar.artistimgurl, ar_al.albumtitle, ar_al.albumimgurl 
from jblog jbl, song s, havesong hs, artist ar, artist_album ar_al 
where jbl.songid = s.songid and s.songid = hs.songid and hs.artistid = ar.artistid 
and s.albumid = ar_al.albumid and jbl.userid = 'a@a.a';

select row_number() over (order by accesslog desc) rnum
	 		, s.songtitle
			, s.releasedate
			, s.albumid
			, s.source
			, jbl.userid
			, jbl.songid
			, jbl.makealbumid
			, to_char(jbl.accesslog, 'YYYY/MM/DD') accesslog
			, jbl.accesstype
			, ar.artistname
			, ar.artistid
			, ar.artistimgurl
			, ar_al.albumtitle
			, ar_al.albumimgurl 
		from jblog jbl, song s, havesong hs, artist ar, artist_album ar_al 
		where jbl.songid = s.songid and s.songid = hs.songid and hs.artistid = ar.artistid 
		      and s.albumid = ar_al.albumid and jbl.userid = 'a@a.a'
		      
		      select row_number() over (order by accesslog desc) rnum
			, jbl.userid
			, jbl.songid
			, jbl.makealbumid
		from jblog jbl
		where jbl.userid = 'a@a.a'
		
		select * from 
	 	(select row_number() over (order by accesslog desc) rnum
			, userid
			, songid
			, makealbumid
			, accesslog
		from jblog 
		where userid = 'a@a.a') 
		where rnum between 0 and 10
		
		
		select * from (
		select row_number() over (order by  desc) rnum
		   , ar_al.albumtitle
  		   , ar_al.albumimgurl
  		   , ar_al.albumid albumid
  		   , ar.artistname artist
  		   , ar.artistid artistid
  		   , s.*    
  	from artist ar, havesong hs, song s, artist_album ar_al  
	where ar.artistid = hs.artistid and hs.songid = s.songid and 
		  s.albumid = ar_al.albumid and  
	      lower(ar.artistname) = lower('oasis')) 
	      where rnum between 0 and 10
	      
	      
	      
	      select * from 
		(select row_number() over (order by accesslog desc) rnum
			, s.songtitle
			, s.releasedate
			, s.albumid
			, s.source
			, jbl.userid
			, jbl.songid
			, jbl.makealbumid
			, to_char(jbl.accesslog, 'YYYY/MM/DD') accesslog
			, jbl.accesstype
			, ar.artistname
			, ar.artistid 
			, ar.artistimgurl
			, ar_al.albumtitle
			, ar_al.albumimgurl 
	from jblog jbl, song s, havesong hs, artist ar, artist_album ar_al 
	where jbl.songid = s.songid and s.songid = hs.songid and hs.artistid = ar.artistid 
		  and s.albumid = ar_al.albumid and jbl.userid = 'a@a.a')
		  where rnum between 0 and 10
		  
		  
		  select songId ,count(songId) as cnt from song where songId in(
select songId from LIKEMUSIC)
group by songId
order by cnt desc



select * from 
(select row_number() over (order by cnt.likedCnt desc) rnum
		   , ar_al.albumtitle as albumtitle
           , ar_al.albumimgurl as albumimgurl
           , ar.artistname as artist
           , ar.artistid as artistid
           , s.*
           , cnt.likedCnt as ccc
   from artist ar, havesong hs, song s, artist_album ar_al,
   (select songId ,count(songId) as likedCnt from LIKEMUSIC
   group by songId) cnt
   where ar.artistid = hs.artistid 
      and hs.songid = s.songid 
      and s.albumid = ar_al.albumid 
      and lower(ar.artistname) = lower('oasis') 
      and cnt.songId = s.songId
   order by cnt.likedCnt desc) 
   where rnum between 0 and 10
   
   
   select * from 
  (select row_number() over (order by cnt.likedCnt desc) rnum
   		   , ar_al.albumtitle as albumtitle
  		   , ar_al.albumimgurl as albumimgurl 
  		   , ar.artistname as artist
  		   , ar.artistid as artistid
  		   , s.*
  		   , cnt.likedCnt as count 
  	from artist ar, havesong hs, song s, artist_album ar_al,
  	(select songid, count(songid) as likedCnt from likemusic 
  	group by songid) cnt 
	where ar.artistid = hs.artistid 
		and hs.songid = s.songid 
		and s.albumid = ar_al.albumid 
		and lower(ar.artistname) = lower('oasis') 
		and cnt.songid = s.songid 
		order by cnt.likedCnt desc)
		where rnum between 0 and 10
		
   
select count(s.songid) count 
  	from artist ar, havesong hs, song s, artist_album ar_al
	where ar.artistid = hs.artistid and hs.songid = s.songid and 
		  s.albumid = ar_al.albumid and 
	      lower(ar.artistname) = lower('oasis')
	      
	      select count(*) 
	  	from artist ar, havesong hs, song s, artist_album ar_al,
	  	(select songid, count(songid) as likedcnt from likemusic 
	  	group by songid) cnt 
		where ar.artistid = hs.artistid 
			and hs.songid = s.songid 
			and s.albumid = ar_al.albumid 
			and lower(ar.artistname) = lower('oasis') 
			and cnt.songid = s.songid 
			order by cnt.likedcnt desc
			
		select * from 
	  	(select row_number() over (order by cnt.likedcnt desc) rnum
	  		  , ar_al.albumtitle as albumtitle
	  		  , ar_al.albumimgurl as albumimgurl 
	  		  , ar.artistname as artist
	  		  , ar.artistid as artistid
	  		  , s.*
	  		  , cnt.likedcnt as count    
		from artist ar, havesong hs, song s, artist_album ar_al,
		(select songid, count(songid) as likedcnt from likemusic 
		group by songid) cnt 
		where s.songid = hs.songid 
			  and hs.artistid = ar.artistid 
			  and s.albumid = ar_al.albumid 
			  and (lower(s.songtitle) like '%' || lower('oasis') || '%')
			  and cnt.songid = s.songid
			  order by cnt.likedcnt desc)
			  where rnum between 0 and 10
			  