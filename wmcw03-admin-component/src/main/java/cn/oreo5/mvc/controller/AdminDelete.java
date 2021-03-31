package cn.oreo5.mvc.controller;

import cn.oreo5.service.AdminService;
import cn.oreo5.util.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class AdminDelete {

    @Autowired
    private AdminService adminService;

    //删除功能
    @RequestMapping("admin/{type}/delete.json")
    @ResponseBody
    public ResultEntity<String> deleteByIdArray(
            @RequestBody List<Integer> idList,
            @PathVariable String type
    ) {
        if("user".equals(type)){
            return adminService.deleteUser(idList);
        }else if("admin".equals(type)){
            return adminService.deleteAdmin(idList);
        }else if("role".equals(type)){
            return adminService.deleteRole(idList);
        }else if("article".equals(type)){
            return adminService.deleteArticle(idList);
        }else if("hotel".equals(type)){
            return adminService.deleteHotel(idList);
        }else if("photo".equals(type)){
            return adminService.deletePhoto(idList);
        }else if("map".equals(type)){
            return adminService.deleteMap(idList);
        }

        return ResultEntity.failed("操作失误！请返回原页面刷新重试！");
    }
}
