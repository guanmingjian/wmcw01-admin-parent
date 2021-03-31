package cn.oreo5.mvc.controller;

import cn.oreo5.entity.PO.*;
import cn.oreo5.service.AdminService;
import cn.oreo5.util.ResultEntity;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class AdminUpdate {

    @Autowired
    private AdminService adminService;

    //转到编辑页面
    @RequestMapping("admin/get/{type}/{id}/update.html")
    public String adminToUpdate(
            @PathVariable String type,
            @PathVariable String id,
            ModelMap modelMap
    ){

        List<String[]> list = new ArrayList<>();

        String url = "admin/do/"+type+"/"+id+"/update.json";


        if("user".equals(type)){
            //获取回显的数据
            User user = adminService.selectUserById(id);

            String sex;

            if(user.getSex().equals("1")){
                sex = "男";
            }else {
                sex = "女";
            }

            //存入集合
            list.add(new String[]{"用户名", "name", user.getName()});
            list.add(new String[]{"用户密码", "password", ""});
            list.add(new String[]{"性别", "sex", sex});
            list.add(new String[]{"年龄", "age", user.getAge().toString()});
            list.add(new String[]{"手机号", "phoneNumber", user.getPhoneNumber()});
            list.add(new String[]{"邮箱", "email", user.getEmail()});
            list.add(new String[]{"生日", "birth", user.getBirth()});
        }else if("admin".equals(type)){
            //获取回显的数据
            Admin admin = adminService.selectAdminById(id);

            List<Role> roleList = admin.getRoleList();

            int role1 = 0,role2 = 0,role3 = 0;

            for (Role role : roleList) {
                switch (role.getId()){
                    case 1:
                        role1 = 1;
                        break;
                    case 2:
                        role2 = 1;
                        break;
                    case 3:
                        role3 = 1;
                        break;
                }
            }

            modelMap.addAttribute("admin",admin);
            modelMap.addAttribute("role1",role1);
            modelMap.addAttribute("role2",role2);
            modelMap.addAttribute("role3",role3);

            return "updateAdmin";
        }else if("role".equals(type)){
            //获取回显的数据
            Role role = adminService.selectRoleById(id);

            //存入集合
            list.add(new String[]{"角色名称", "name", role.getName()});
            list.add(new String[]{"角色描述", "description", role.getDescription()});
        }else if("article".equals(type)){
            //获取回显的数据
            Article article = adminService.selectArticleById(id);

            //存入集合
            list.add(new String[]{"文章标题", "title", article.getTitle()});
            list.add(new String[]{"文章作者", "authorName", article.getAuthorName()});
            list.add(new String[]{"图片地址", "imgPath", article.getImgPath()});
        }else if("hotel".equals(type)){
            //获取回显的数据
            Hotel hotel = adminService.selectHotelById(id);

            //存入集合
            list.add(new String[]{"酒店名称", "name", hotel.getName()});
            list.add(new String[]{"酒店价格", "price", hotel.getPrice().toString()});
            list.add(new String[]{"酒店区域", "region", hotel.getRegion()});
            list.add(new String[]{"酒店位置", "location", hotel.getLocation()});
            list.add(new String[]{"酒店星级", "starLevel", hotel.getStarLevel()});
            list.add(new String[]{"酒店简介", "briefIntro", hotel.getBriefIntro()});
            list.add(new String[]{"酒店类型", "type", hotel.getType()});
            list.add(new String[]{"图片路径", "imgPath", hotel.getImgPath()});
        }else if("photo".equals(type)){
            //获取回显的数据
            Photo photo = adminService.selectPhotoById(id);

            //存入集合
            list.add(new String[]{"图片标题", "title", photo.getTitle()});
            list.add(new String[]{"图片简介", "briefIntro", photo.getBriefIntro()});
            list.add(new String[]{"图片路径", "imgPath", photo.getImgPath()});
        }

        modelMap.addAttribute("list",list);
        modelMap.addAttribute("url",url);

        return "updateForm";
    }

    //编辑功能
    @RequestMapping("admin/do/{type}/{id}/update.json")
    @ResponseBody
    public ResultEntity<String> adminUpdate(
            @PathVariable String type,
            @PathVariable String id,
            @RequestBody String object
    ) throws IOException {

        ObjectMapper mapper = new ObjectMapper();

        if("user".equals(type)) {
            User user = mapper.readValue(object,User.class);
            user.setId(Integer.parseInt(id));
            return adminService.updateUser(user);
        }else if("role".equals(type)) {
            Role role = mapper.readValue(object,Role.class);
            role.setId(Integer.parseInt(id));
            return adminService.updateRole(role);
        }else if("article".equals(type)) {
            Article article = mapper.readValue(object,Article.class);
            article.setId(Integer.parseInt(id));
            return adminService.updateArticle(article);
        }else if("hotel".equals(type)) {
            Hotel hotel = mapper.readValue(object,Hotel.class);
            hotel.setId(Integer.parseInt(id));
            return adminService.updateHotel(hotel);
        }else if("photo".equals(type)) {
            Photo photo = mapper.readValue(object,Photo.class);
            photo.setId(Integer.parseInt(id));
            return adminService.updatePhoto(photo);
        }

        return ResultEntity.failed("操作失误！请返回原页面刷新重试！");
    }


    //编辑管理员功能
    @RequestMapping("admin/do/admin/{id}/update.json")
    @ResponseBody
    public ResultEntity<String> updateAdmin(
            @RequestBody List<Map> adminArray,
            @PathVariable String id
    ) {
        return adminService.updateAdmin(adminArray,Integer.parseInt(id));
    }

}