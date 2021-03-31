package cn.oreo5.mvc.config;

import java.util.List;

import cn.oreo5.entity.PO.Admin;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class SecurityAdmin extends User{

    private static final long serialVersionUID = 1L;

    // 原始的Admin对象，包含Admin对象的全部属性
    private Admin originalAdmin;

    public SecurityAdmin(
            // 传入原始的Admin对象
            Admin originalAdmin,

            // 创建角色、权限信息的集合
            List<GrantedAuthority> authorities) {

        // 调用父类构造器
        super(originalAdmin.getName(), originalAdmin.getPassword(), authorities);

        // 给本类的this.originalAdmin赋值
        this.originalAdmin = originalAdmin;

        // 将原始 Admin 对象中的密码擦除
        this.originalAdmin.setPassword(null);

    }

    // 对外提供的获取原始Admin对象的getXxx()方法
    public Admin getOriginalAdmin() {
        return originalAdmin;
    }
}
