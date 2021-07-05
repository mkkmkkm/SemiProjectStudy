package test.cafe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import test.cafe.dto.CafeDto;
import test.util.DbcpBean;

public class CafeDao {
	private static CafeDao dao;
	private CafeDao() {}
	public static CafeDao getInstance() {
		if(dao==null) {
			dao=new CafeDao();
		}
		return dao;
	}
	//글 하나의 정보를 수정하는 메소드
		public boolean update(CafeDto dto) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int flag = 0;
			try {
				conn = new DbcpBean().getConn();
				//실행할 sql 문 작성
				String sql = "UPDATE board_cafe"
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
				String sql = "DELETE FROM board_cafe"
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
		public CafeDto getData(int num) {
			CafeDto dto2=null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				//Connection 객체의 참조값 얻어오기 
				conn = new DbcpBean().getConn();
				//실행할 sql 문 작성
				String sql = "SELECT num,title,writer,category,content,viewCount,likeCount,regdate"
						+ " FROM board_cafe"
						+ " WHERE num=?";
				//PreparedStatement 객체의 참조값 얻어오기
				pstmt = conn.prepareStatement(sql);
				//? 에 바인딩할 내용이 있으면 여기서 바인딩
				pstmt.setInt(1, num);
				//select 문 수행하고 결과를 ResultSet 으로 받아오기
				rs = pstmt.executeQuery();
				//ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
				if(rs.next()) {
					dto2=new CafeDto();
					dto2.setNum(rs.getInt("num"));
					dto2.setWriter(rs.getString("writer"));
					dto2.setTitle(rs.getString("title"));
					dto2.setCategory(rs.getString("category"));
					dto2.setContent(rs.getString("content"));
					dto2.setViewCount(rs.getInt("viewCount"));
					dto2.setLikeCount(rs.getInt("likeCount"));
					dto2.setRegdate(rs.getString("regdate"));
					dto2.setPrevNum(rs.getInt("prevNum"));
					dto2.setNextNum(rs.getInt("nextNum"));
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
			return dto2;
		}
	//새글 저장하는 메소드 
		public boolean insert(CafeDto dto) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int flag = 0;
			try {
				conn = new DbcpBean().getConn();
				//실행할 insert, update, delete 문 구성
				String sql = "INSERT INTO board_cafe"
						+ " (num,writer,title,category,content,viewCount,likeCount,regdate)"
						+ " VALUES(board_cafe_seq.NEXTVAL,?,?,?,?,0,0,SYSDATE)";
				pstmt = conn.prepareStatement(sql);
				//? 에 바인딩할 내용이 있으면 바인딩한다.
				pstmt.setString(1, dto.getWriter());
				pstmt.setString(2, dto.getTitle());
				pstmt.setString(3, dto.getCategory());
				pstmt.setString(4, dto.getContent());
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
}
