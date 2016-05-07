DROP TABLE MOVIE_TBL;

CREATE TABLE MOVIE_TBL
(
	SEQ NUMBER PRIMARY KEY,
	TITLE VARCHAR2(50),
	DIRECTOR VARCHAR2(50),
	ACTOR VARCHAR2(50),
	GENRE VARCHAR2(50),
	ORIGINALFILE VARCHAR2(200),
	SAVEDFILE VARCHAR2(500)
)

CREATE SEQUENCE MOVIE_SEQ