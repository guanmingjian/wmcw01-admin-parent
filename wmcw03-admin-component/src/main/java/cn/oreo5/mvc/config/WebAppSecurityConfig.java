package cn.oreo5.mvc.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
public class WebAppSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Override
    protected void configure(AuthenticationManagerBuilder builder) throws Exception {
        builder
                // 开启信息查询和保存功能
                .userDetailsService(userDetailsService)
                // 开启带盐值密码验证功能
                .passwordEncoder(passwordEncoder)
        ;
    }

    @Override
    protected void configure(HttpSecurity security) throws Exception {

        JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
        tokenRepository.setDataSource(dataSource);

        security
                .authorizeRequests()	// 对请求进行授权
                .antMatchers("/login.jsp").permitAll()          // 放行登录页面
                .antMatchers("/login.html").permitAll()          // 放行回到登录请求

                // 放行静态资源
                .antMatchers("/css/**").permitAll()
                .antMatchers("/data/**").permitAll()
                .antMatchers("/fonts/**").permitAll()
                .antMatchers("/images/**").permitAll()
                .antMatchers("/js/**").permitAll()
                .antMatchers("/lib/**").permitAll()

                // 权限控制
                .antMatchers("/userList.html")
                .hasRole("普通管理员")
                .antMatchers("/adminList.html")
                .hasRole("超级管理员")
                .antMatchers("/role.html")
                .hasRole("超级管理员")

                // 其他任意请求认证后访问
                .anyRequest().authenticated()
                .and()

                // 异常设置
                .exceptionHandling()
                .accessDeniedPage("/WEB-INF/noAuth.jsp")          // 设置403异常前往的页面
                .and()

                // 登录设置
                .formLogin()
                .loginPage("/login.html")      // 自定义进入登录页面的请求
                .loginProcessingUrl("/security/do/login.html")          // 设置登录的请求
                .defaultSuccessUrl("/to/main.html")         // 设置登录成功后前往的页面
                .usernameParameter("name")          // 设置从表单获得账号的参数
                .passwordParameter("password")          // 设置从表单获得密码的参数
                .and()

                // 记住功能
                .rememberMe()
                .tokenRepository(tokenRepository)           // 开启数据库记住功能
                .and()

                // 配置X-Frame-Options
                .headers()
                .frameOptions().sameOrigin()            // 设置为sameOrigin：表示该页面可以在相同域名页面的 frame 中展示。
                .httpStrictTransportSecurity().disable()
                .and()

                // 退出登录设置
                .logout()
                .logoutUrl("/security/do/logout.html")            // 设置退出登录的请求
                .logoutSuccessUrl("/login.html")            // 设置退出登录后前往的页面
                .and()
        ;
    }
}
