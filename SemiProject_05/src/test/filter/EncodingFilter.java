
package test.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

//@WebFilter("/*") : 이 프로젝트의 모든 요청에 대해서 필터가 동작하도록 한다. 
//@WebFilter("/*")
public class EncodingFilter implements Filter{
	private String encoding;
	
	@Override
	public void destroy() {
		
	}	
	//필터가 동작할때마다 호출된다. 
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		//System.out.println("EncodingFilter doFilter()");
		
		//1. 만일 인코딩 설정되지 않았다면
		if(request.getCharacterEncoding()==null) {
			//post 방식 전송했을 때 한글 깨지지 않도록 설정
			request.setCharacterEncoding(encoding);
		}
		//2. 요청의 흐름 계속 이어가기
		chain.doFilter(request, response);
	}
	
	//필터가 최초 사용될 때 1번만 호출된다. 
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		/*
		 *<init-param>
	        <param-name>encoding</param-name>
	        <param-value>utf-8</param-value>
	     </init-param>
	     	web.xml에 위와 같이 설정된 초기화 파라미터 값 읽어오기
		 */
		//doFilter()메소드에서 사용할 수 있도록 필드에 저장한다. //this. 생략 가능
	//	System.out.println(" init");
		encoding=filterConfig.getInitParameter("encoding"); //"utf-8"
	}
	
}
