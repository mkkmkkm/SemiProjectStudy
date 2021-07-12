-- 사용자(회원)정보를 저장할 테이블
CREATE TABLE users(
  id VARCHAR2(100) PRIMARY KEY, 
  pwd VARCHAR2(100) NOT NULL,
  profile VARCHAR2(100), --프로필 이미지 경로를 저장할 칼럼
  regdate DATE --가입일
); 

--공지사항을 저장할 테이블
CREATE TABLE board_notice(
	num NUMBER PRIMARY KEY, --글번호
	writer VARCHAR2(100) NOT NULL, --작성자(로그인된 아이디)
	title VARCHAR2(100) NOT NULL, --제목
	content CLOB, --글 내용
	viewCount NUMBER, --조회수
	regdate DATE --글 작성일
);

--공지사항의 번호를 얻어낼 시퀀스
create sequence board_notice_seq;

--게시글을 저장할 테이블
CREATE TABLE board_cafe(
	num NUMBER PRIMARY KEY, --글번호
	writer VARCHAR2(100) NOT NULL, --작성자(로그인된 아이디)
	title VARCHAR2(100) NOT NULL, --제목
	category VARCHAR2(100) NOT NULL, --카테고리
	content CLOB, --글 내용
	viewCount NUMBER, --조회수
	likeCount NUMBER, --좋아요수
	regdate DATE --글 작성일
);

--공지사항의 번호를 얻어낼 시퀀스
create sequence board_cafe_seq;

--게시글의 댓글을 저장할 테이블
CREATE TABLE board_cafe_comment(
   num NUMBER PRIMARY KEY, --댓글의 글번호
   writer VARCHAR2(100), --댓글 작성자의 아이디
   content VARCHAR2(500), --댓글 내용
   target_id VARCHAR2(100), --댓글의 대상자 아이디
   ref_group NUMBER,
   -- 게시글 내의 댓글은 모두 같은 ref_group 번호를 가지고 있음.
   comment_group NUMBER,
   -- 원 댓글 각각이 하나의 comment_group. 대댓글은 이 그룹 하나의 자식 요소. 
   -- 들여쓰기 여부: ref_group = comment_group 확인
   deleted CHAR(3) DEFAULT 'no',
   -- 삭제 시 yes로 변경, "삭제된 댓글입니다" 출력 
   -- (부모 댓글이 삭제될 시 계층관계 어긋남)
   regdate DATE
);

--게시글의 댓글 번호에 사용할 시퀀스
CREATE SEQUENCE board_cafe_comment_seq;

-- 이미지 갤러리를 만들기 위한 테이블
CREATE TABLE board_gallery(
	num NUMBER PRIMARY KEY,
	writer VARCHAR2(100),
	caption VARCHAR2(100), --이미지에 대한 설명
	imagePath VARCHAR2(100), --업로드된 이미지의 경로 ex)/upload/xxx.jpg
	regdate DATE --이미지 업로드 날짜
);

CREATE SEQUENCE board_gallery_seq;


