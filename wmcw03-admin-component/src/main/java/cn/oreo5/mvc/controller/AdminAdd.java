package cn.oreo5.mvc.controller;

import cn.oreo5.entity.VO.FormVO;
import cn.oreo5.entity.PO.Hotel;
import cn.oreo5.entity.PO.Photo;
import cn.oreo5.entity.PO.Role;
import cn.oreo5.entity.PO.User;
import cn.oreo5.service.AdminService;
import cn.oreo5.util.ResultEntity;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AdminAdd {
    @Autowired
    private AdminService adminService;

    //转到新增页面
    @RequestMapping("admin/get/{type}/add.html")
    public String adminToAdd(
            @PathVariable String type,
            @RequestParam(value="photoType", defaultValue="0") String photoType,
            ModelMap modelMap
    ){
        FormVO form = new FormVO();
        String[] title = null;
        String[] name = null;

        form.setUrl("admin/do/"+type+"/add.json");

        if("user".equals(type)){
            title = new String[]{"用户名", "用户密码","性别", "年龄","手机号","邮箱", "生日"};
            name = new String[]{"name", "password","sex", "age","phoneNumber","email", "birth"};
        }else if("role".equals(type)){
            title = new String[]{"角色名","角色描述"};
            name = new String[]{"name","description"};
        }else if("hotel".equals(type)){
            title = new String[]{"酒店名称", "酒店价格","酒店区域", "酒店位置","酒店星级", "酒店简介","酒店类型", "图片路径"};
            name = new String[]{"name", "price","region", "location","starLevel", "briefIntro", "type","imgPath"};
        }else if("photo".equals(type)){
            form.setUrl("admin/do/"+type+"/add.json?photoType="+photoType);
            title = new String[]{"图片标题","图片简介","图片路径"};
            name = new String[]{"title","briefIntro","imgPath"};
        }

        Map<String,String> map = new LinkedHashMap<>();
        for (int i = 0 ; i < title.length; i++){
            map.put(title[i],name[i]);
        }

        form.setData(map);

        modelMap.addAttribute("Form",form);

        return "addForm";
    }

    //新增功能
    @RequestMapping("admin/do/{type}/add.json")
    @ResponseBody
    public ResultEntity<String> adminAdd(
            @PathVariable String type,
            @RequestBody String object,
            @RequestParam(value="photoType", defaultValue="0") String photoType
    ) throws IOException {

        ObjectMapper mapper = new ObjectMapper();

        if("user".equals(type)){
            User user = mapper.readValue(object,User.class);
            return adminService.addUser(user);
        }else if("role".equals(type)) {
            Role role = mapper.readValue(object,Role.class);
            return adminService.addRole(role);
        }else if("hotel".equals(type)) {
            Hotel hotel = mapper.readValue(object,Hotel.class);
            return adminService.addHotel(hotel);
        }else if("photo".equals(type)) {
            Photo photo = mapper.readValue(object,Photo.class);
            photo.setClas(Integer.parseInt(photoType));
            return adminService.addPhoto(photo);
        }
        return ResultEntity.failed("操作失误！请返回原页面刷新重试！");
    }

    //新增管理员功能
    @RequestMapping("admin/do/admin/add.json")
    @ResponseBody
    public ResultEntity<String> addAdmin(
            @RequestBody List<Map> adminArray
    ) {
        return adminService.addAdmin(adminArray);
    }
}
