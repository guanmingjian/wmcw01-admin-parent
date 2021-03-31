package cn.oreo5.mvc.controller;


import cn.oreo5.entity.PO.Admin;
import cn.oreo5.entity.PO.Auth;
import cn.oreo5.entity.PO.Role;
import cn.oreo5.entity.PO.User;
import cn.oreo5.service.AdminService;
import cn.oreo5.util.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
public class AuthController {

    @Autowired
    private AdminService adminService;


    @Bean
    public ReloadableResourceBundleMessageSource messageSource(){
        ReloadableResourceBundleMessageSource reloadableResourceBundleMessageSource = new ReloadableResourceBundleMessageSource();
        reloadableResourceBundleMessageSource.setBasename("classpath:messages");
        return reloadableResourceBundleMessageSource;
    }


    //启用停用功能
    @RequestMapping(value = "admin/do/{type}/{id}/{status}/status.json",method = {RequestMethod.POST})
    @ResponseBody
    public ResultEntity<String> adminUpdateStatus(
            @PathVariable String type,
            @PathVariable String id,
            @PathVariable String status
    ){
        if("user".equals(type)) {
            User user = new User();
            user.setId(Integer.parseInt(id));
            user.setStatus(status);
            return adminService.updateUserStatus(user);
        }else if("admin".equals(type)) {
            Admin admin = new Admin();
            admin.setId(Integer.parseInt(id));
            admin.setStatus(status);
            return adminService.updateAdminStatus(admin);
        }else if("role".equals(type)) {
            Role role = new Role();
            role.setId(Integer.parseInt(id));
            role.setStatus(status);
            return adminService.updateRoleStatus(role);
        }

        return ResultEntity.failed("操作失误！请返回原页面刷新重试！");
    }

    //转到授权页面
    @RequestMapping("admin/get/auth/{roleId}/assign.html")
    public String main(
            @PathVariable Integer roleId,
            ModelMap modelMap
    ){
        modelMap.addAttribute("roleId",roleId);
        return "assign";
    }

    //权限列表页面中获取所有Auth数据
    @RequestMapping("admin/get/auth.json")
    @ResponseBody
    public ResultEntity<List<Auth>> getAuth(){
        List<Auth> authList = adminService.getAuth();

        return ResultEntity.successWithData(authList);
    }

    //获取该角色已有的权限
    @RequestMapping("admin/get/relationship/assign.json")
    @ResponseBody
    public ResultEntity<List<Integer>> getAssignRelationship(
            @RequestParam("roleId") Integer roleId)
    {
        List<Integer> authIdList =adminService.getAssignRelationship(roleId);

        return ResultEntity.successWithData(authIdList);
    }

    //保存角色-权限关联表
    @RequestMapping("/assign/do/role/assign/auth.json")
    @ResponseBody
    public ResultEntity<String> saveRoleAuthRelationship(
            @RequestBody Map<String,List<Integer>> map
    ){
        return adminService.saveRoleAuthRelationship(map);
    }
}
