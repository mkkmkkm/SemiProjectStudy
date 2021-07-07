package notice.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import notice.dto.NoticeDto;
import test.util.DbcpBean;

public class NoticeDao {
   private static NoticeDao dao;
   //외부에서 객체 생성하지 못하도록
   private NoticeDao() {}
   //자신의 참조값을 리턴해주는 공개 메소드
   public static NoticeDao getInstance() {
      if(dao==null) {
         dao=new NoticeDao();
      }
      return dao;
   }
   //조회수 증가 시키는 메소드
   public boolean addViewCount(int num) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      int flag = 0;
      try {
         conn = new DbcpBean().getConn();
         //실행할 sql 문 작성
         String sql = "UPDATE board_notice"
               + " SET viewCount=viewCount+1"
               + " WHERE num=?";
         pstmt = conn.prepareStatement(sql);
         //? 에 바인딩할 내용이 있으면 여기서 바인딩
         pstmt.setInt(1, num);
         //insert or update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
         flag = pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
         }
      }
      if (flag > 0) {
         return true;
      } else {
         return false;
      }
   }
      //글 하나의 정보를 수정하는 메소드
   public boolean update(NoticeDto dto) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      int flag = 0;
      try {
         conn = new DbcpBean().getConn();
         //실행할 sql 문 작성
         String sql = "UPDATE board_notice"
               + " SET title=?,content=?"
               + " WHERE num=?";
         pstmt = conn.prepareStatement(sql);
         //? 에 바인딩할 내용이 있으면 여기서 바인딩
         pstmt.setString(1, dto.getTitle());
         pstmt.setString(2, dto.getContent());
         pstmt.setInt(3, dto.getNum());
         //insert or update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
         flag = pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
         }
      }
      if (flag > 0) {
         return true;
      } else {
         return false;
      }
   }
   
   //글 하나의 정보를 삭제하는 메소드
   public boolean delete(int num) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      int flag = 0;
      try {
         conn = new DbcpBean().getConn();
         //실행할 sql 문 작성
         String sql = "DELETE FROM board_notice"
               + " WHERE num=?";
         pstmt = conn.prepareStatement(sql);
         //? 에 바인딩할 내용이 있으면 여기서 바인딩
         pstmt.setInt(1, num);
         //insert or update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
         flag = pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
         }
      }
      if (flag > 0) {
         return true;
      } else {
         return false;
      }
   }
   //글하나의 정보를 리턴하는 메소드
   public NoticeDto getData(int num) {
	   NoticeDto dto=null;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         //Connection 객체의 참조값 얻어오기 
         conn = new DbcpBean().getConn();
         //실행할 sql 문 작성
         String sql = "SELECT num,title,writer,content,viewCount,regdate"
               + " FROM board_notice"
               + " WHERE num=?";
         //PreparedStatement 객체의 참조값 얻어오기
         pstmt = conn.prepareStatement(sql);
         //? 에 바인딩할 내용이 있으면 여기서 바인딩
         pstmt.setInt(1, num);
         //select 문 수행하고 결과를 ResultSet 으로 받아오기
         rs = pstmt.executeQuery();
         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
         if(rs.next()) {
            dto=new NoticeDto();
            dto.setNum(rs.getInt("num"));
            dto.setWriter(rs.getString("writer"));
            dto.setTitle(rs.getString("title"));
            dto.setContent(rs.getString("content"));
            dto.setViewCount(rs.getInt("viewCount"));
            dto.setRegdate(rs.getString("regdate"));
            dto.setPrevNum(rs.getInt("prevNum"));
            dto.setNextNum(rs.getInt("nextNum"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
         }
      }
      return dto;
   }
   
   //새글 저장하는 메소드 
   public boolean insert(NoticeDto dto) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      int flag = 0;
      try {
         conn = new DbcpBean().getConn();
         //실행할 insert, update, delete 문 구성
         String sql = "INSERT INTO board_notice"
               + " (num,writer,title,content,viewCount,regdate)"
               + " VALUES(board_notice_seq.NEXTVAL,?,?,?,0,SYSDATE)";
         pstmt = conn.prepareStatement(sql);
         //? 에 바인딩할 내용이 있으면 바인딩한다.
         pstmt.setString(1, dto.getWriter());
         pstmt.setString(2, dto.getTitle());
         pstmt.setString(3, dto.getContent());
         flag = pstmt.executeUpdate(); //sql 문 실행하고 변화된 row 갯수 리턴 받기
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
         }
      }
      if (flag > 0) {
         return true;
      } else {
         return false;
      }
   }
   //글 목록을 리턴하는 메소드 
   public List<NoticeDto> getList(NoticeDto dto){
      //글목록을 담을 ArrayList 객체 생성
      List<NoticeDto> list=new ArrayList<NoticeDto>();
      
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         conn = new DbcpBean().getConn();
         //select 문 작성
         String sql = "SELECT *" + 
               "      FROM" + 
               "          (SELECT result1.*, ROWNUM AS rnum" + 
               "          FROM" + 
               "              (SELECT num,writer,title,viewCount,regdate" + 
               "              FROM board_notice" + 
               "              ORDER BY num DESC) result1)" + 
               "      WHERE rnum BETWEEN ? AND ?";
         pstmt = conn.prepareStatement(sql);
         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
         pstmt.setInt(1, dto.getStartRowNum());
         pstmt.setInt(2, dto.getEndRowNum());
         //select 문 수행하고 ResultSet 받아오기
         rs = pstmt.executeQuery();
         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
         while (rs.next()) {
        	NoticeDto dto2=new NoticeDto();
            dto2.setNum(rs.getInt("num"));
            dto2.setWriter(rs.getString("writer"));
            dto2.setTitle(rs.getString("title"));
            dto2.setViewCount(rs.getInt("viewCount"));
            dto2.setRegdate(rs.getString("regdate"));
            list.add(dto2);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
         }
      }
      return list;
   }
   //전체 글의 갯수를 리턴하는 메소드
   public int getCount() {
      //글의 갯수를 담을 지역변수 
      int count=0;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         conn = new DbcpBean().getConn();
         //select 문 작성
         String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
               + " FROM board_notice";
         pstmt = conn.prepareStatement(sql);
         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.

         //select 문 수행하고 ResultSet 받아오기
         rs = pstmt.executeQuery();
         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
         if (rs.next()) {
            count=rs.getInt("num");
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
         }
      }
      return count;
   }
   /*
    *  Title, Content 검색일때 실행할 메소드
    *  NoticeDto 의 title, content 이라는 필드에 검색 키워드가 들어 있다.
    */
   public List<NoticeDto> getListTC(NoticeDto dto){
      //글목록을 담을 ArrayList 객체 생성
      List<NoticeDto> list=new ArrayList<NoticeDto>();
      
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         conn = new DbcpBean().getConn();
         //select 문 작성
         String sql = "SELECT *" + 
               "      FROM" + 
               "          (SELECT result1.*, ROWNUM AS rnum" + 
               "          FROM" + 
               "              (SELECT num,writer,title,viewCount,regdate" + 
               "              FROM board_Notice"+ 
               "             WHERE title LIKE '%'||?||'%' OR content LIKE '%'||?||'%' "+               
               "              ORDER BY num DESC) result1)" + 
               "      WHERE rnum BETWEEN ? AND ?";
         pstmt = conn.prepareStatement(sql);
         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
         pstmt.setString(1, dto.getTitle());
         pstmt.setString(2, dto.getContent());
         pstmt.setInt(3, dto.getStartRowNum());
         pstmt.setInt(4, dto.getEndRowNum());
         //select 문 수행하고 ResultSet 받아오기
         rs = pstmt.executeQuery();
         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
         while (rs.next()) {
            NoticeDto dto2=new NoticeDto();
            dto2.setNum(rs.getInt("num"));
            dto2.setWriter(rs.getString("writer"));
            dto2.setTitle(rs.getString("title"));
            dto2.setViewCount(rs.getInt("viewCount"));
            dto2.setRegdate(rs.getString("regdate"));
            list.add(dto2);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
         }
      }
      return list;
   }
   //제목, 내용 검색했을때 전체 row 의 갯수 리턴
   public int getCountTC(NoticeDto dto) {
      //글의 갯수를 담을 지역변수 
      int count=0;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         conn = new DbcpBean().getConn();
         //select 문 작성
         String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
               + " FROM board_Notice"
               + " WHERE title LIKE '%'||?||'%' OR content LIKE '%'||?||'%'";
         pstmt = conn.prepareStatement(sql);
         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
         pstmt.setString(1, dto.getTitle());
         pstmt.setString(2, dto.getContent());
         //select 문 수행하고 ResultSet 받아오기
         rs = pstmt.executeQuery();
         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
         if (rs.next()) {
            count=rs.getInt("num");
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
         }
      }
      return count;
   }
   /*
    *  Title 검색일때 실행할 메소드
    *  NoticeDto 의 title 이라는 필드에 검색 키워드가 들어 있다.
    */
   public List<NoticeDto> getListT(NoticeDto dto){
      //글목록을 담을 ArrayList 객체 생성
      List<NoticeDto> list=new ArrayList<NoticeDto>();
      
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         conn = new DbcpBean().getConn();
         //select 문 작성
         String sql = "SELECT *" + 
               "      FROM" + 
               "          (SELECT result1.*, ROWNUM AS rnum" + 
               "          FROM" + 
               "              (SELECT num,writer,title,viewCount,regdate" + 
               "              FROM board_Notice"+ 
               "             WHERE title LIKE '%' || ? || '%' "+               
               "              ORDER BY num DESC) result1)" + 
               "      WHERE rnum BETWEEN ? AND ?";
         pstmt = conn.prepareStatement(sql);
         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
         pstmt.setString(1, dto.getTitle());
         pstmt.setInt(2, dto.getStartRowNum());
         pstmt.setInt(3, dto.getEndRowNum());
         //select 문 수행하고 ResultSet 받아오기
         rs = pstmt.executeQuery();
         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
         while (rs.next()) {
            NoticeDto dto2=new NoticeDto();
            dto2.setNum(rs.getInt("num"));
            dto2.setWriter(rs.getString("writer"));
            dto2.setTitle(rs.getString("title"));
            dto2.setViewCount(rs.getInt("viewCount"));
            dto2.setRegdate(rs.getString("regdate"));
            list.add(dto2);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
         }
      }
      return list;
   }
   //제목 검색했을때 전체 row 의 갯수 리턴
   public int getCountT(NoticeDto dto) {
      //글의 갯수를 담을 지역변수 
      int count=0;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         conn = new DbcpBean().getConn();
         //select 문 작성
         String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
               + " FROM board_Notice"
               + " WHERE title LIKE '%'||?||'%' ";
         pstmt = conn.prepareStatement(sql);
         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
         pstmt.setString(1, dto.getTitle());
         //select 문 수행하고 ResultSet 받아오기
         rs = pstmt.executeQuery();
         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
         if (rs.next()) {
            count=rs.getInt("num");
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
         }
      }
      return count;
   }
   /*
    *  Writer 검색일때 실행할 메소드
    *  NoticeDto 의 writer 이라는 필드에 검색 키워드가 들어 있다.
    */
   public List<NoticeDto> getListW(NoticeDto dto){
      //글목록을 담을 ArrayList 객체 생성
      List<NoticeDto> list=new ArrayList<NoticeDto>();
      
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         conn = new DbcpBean().getConn();
         //select 문 작성
         String sql = "SELECT *" + 
               "      FROM" + 
               "          (SELECT result1.*, ROWNUM AS rnum" + 
               "          FROM" + 
               "              (SELECT num,writer,title,viewCount,regdate" + 
               "              FROM board_Notice"+ 
               "             WHERE writer LIKE '%' || ? || '%' "+               
               "              ORDER BY num DESC) result1)" + 
               "      WHERE rnum BETWEEN ? AND ?";
         pstmt = conn.prepareStatement(sql);
         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
         pstmt.setString(1, dto.getWriter());
         pstmt.setInt(2, dto.getStartRowNum());
         pstmt.setInt(3, dto.getEndRowNum());
         //select 문 수행하고 ResultSet 받아오기
         rs = pstmt.executeQuery();
         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
         while (rs.next()) {
            NoticeDto dto2=new NoticeDto();
            dto2.setNum(rs.getInt("num"));
            dto2.setWriter(rs.getString("writer"));
            dto2.setTitle(rs.getString("title"));
            dto2.setViewCount(rs.getInt("viewCount"));
            dto2.setRegdate(rs.getString("regdate"));
            list.add(dto2);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
         }
      }
      return list;
   }
   //작성자 검색했을때 전체 row 의 갯수 리턴
   public int getCountW(NoticeDto dto) {
      //글의 갯수를 담을 지역변수 
      int count=0;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         conn = new DbcpBean().getConn();
         //select 문 작성
         String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
               + " FROM board_Notice"
               + " WHERE writer LIKE '%'||?||'%' ";
         pstmt = conn.prepareStatement(sql);
         // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
         pstmt.setString(1, dto.getWriter());
         //select 문 수행하고 ResultSet 받아오기
         rs = pstmt.executeQuery();
         //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
         if (rs.next()) {
            count=rs.getInt("num");
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
         }
      }
      return count;
   }
   
  //마지막 공지글 하나의 정보를 리턴하는 메소드
   public NoticeDto getData1() {
	   NoticeDto dto=null;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         //Connection 객체의 참조값 얻어오기 
         conn = new DbcpBean().getConn();
         //실행할 sql 문 작성
         String sql = "SELECT num,writer,title,viewCount,regdate"
        		 	+" FROM board_notice"
        		 	+" WHERE num IN(SELECT MAX(NUM) FROM board_notice)";
         //PreparedStatement 객체의 참조값 얻어오기
         pstmt = conn.prepareStatement(sql);
         //? 에 바인딩할 내용이 있으면 여기서 바인딩
         //select 문 수행하고 결과를 ResultSet 으로 받아오기
         rs = pstmt.executeQuery();
         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
         if(rs.next()) {
            dto=new NoticeDto();
            dto.setNum(rs.getInt("num"));
            dto.setWriter(rs.getString("writer"));
            dto.setTitle(rs.getString("title"));
            dto.setViewCount(rs.getInt("viewCount"));
            dto.setRegdate(rs.getString("regdate"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e) {
         }
      }
      return dto;
   }
   
	
}






 