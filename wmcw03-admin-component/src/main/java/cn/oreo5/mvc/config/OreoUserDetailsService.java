package cn.oreo5.mvc.config;

import cn.oreo5.entity.PO.Admin;
import cn.oreo5.entity.PO.Role;
import cn.oreo5.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class OreoUserDetailsService implements UserDetailsService {

    @Autowired
    private AdminService adminService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        // 1.根据账号名称查询Admin对象
        Admin admin = adminService.getAdminByName(username);

        // 2.获取adminId
        Integer adminId = admin.getId();

        // 3.根据adminId查询角色信息
        List<Role> assignedRoleList = adminService.getAssignedRoleByAdminId(adminId);

        // 4.根据adminId查询权限信息
        List<String> authNameList = adminService.getAssignedAuthNameByAdminId(adminId);

        // 5.创建集合对象用来存储GrantedAuthority
        List<GrantedAuthority> authorities = new ArrayList<>();

        // 6.遍历assignedRoleList存入角色信息
        for (Role role : assignedRoleList) {

            // 注意：不要忘了加前缀！
            String roleName = "ROLE_" + role.getName();

            SimpleGrantedAuthority simpleGrantedAuthority = new SimpleGrantedAuthority(roleName);

            authorities.add(simpleGrantedAuthority);
        }

        // 7.遍历authNameList存入权限信息
        for (String authName : authNameList) {

            SimpleGrantedAuthority simpleGrantedAuthority = new SimpleGrantedAuthority(authName);

            authorities.add(simpleGrantedAuthority);
        }

        // 8.封装SecurityAdmin对象
        SecurityAdmin securityAdmin = new SecurityAdmin(admin, authorities);

        return securityAdmin;
    }
}
