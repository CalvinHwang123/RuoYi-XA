package com.ruoyi.business.component;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * 允许跨域
 */
@Component
public class CORSFilter implements Filter {

    @Value("#{'${xianlu.form-designer-origin}'.split(',')}")
    private List<String> formDesignerOrigin;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletResponse res = (HttpServletResponse) response;
        res.addHeader("Access-Control-Allow-Credentials", "true");
//        res.addHeader("Access-Control-Allow-Origin", "*");
        // 得指定具体的 Origin，否则报错
        // Access to fetch at 'http://localhost:81/wfForm/list' from origin 'http://localhost:8082' has been blocked by CORS policy:
        // Response to preflight request doesn't pass access control check: The value of the 'Access-Control-Allow-Origin' header
        // in the response must not be the wildcard '*' when the request's credentials mode is 'include'.
        String originHeader = ((HttpServletRequest) request).getHeader("Origin");
        if (formDesignerOrigin.contains(originHeader)) {
            res.addHeader("Access-Control-Allow-Origin", originHeader);
        } else {
            res.addHeader("Access-Control-Allow-Origin", "https://***.***.com");
        }
        res.addHeader("Access-Control-Allow-Methods", "GET, POST, DELETE, PUT");
//        res.addHeader("Access-Control-Allow-Headers", "Content-Type,X-CAF-Authorization-Token,sessionToken,X-TOKEN");
        // token 是客户端 app 请求头携带的
        res.addHeader("Access-Control-Allow-Headers", "Content-Type,X-CAF-Authorization-Token,sessionToken,X-TOKEN,token,Authorization");
        if (((HttpServletRequest) request).getMethod().equals("OPTIONS")) {
            response.getWriter().println("ok");
            return;
        }
        chain.doFilter(request, response);
    }
    @Override
    public void destroy() {
    }
    @Override
    public void init(FilterConfig filterConfig) {
    }

}
