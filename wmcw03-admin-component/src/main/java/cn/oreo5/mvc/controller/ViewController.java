package cn.oreo5.mvc.controller;

import cn.oreo5.service.ViewService;
import cn.oreo5.util.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ViewController {

    @Autowired
    private ViewService viewService;

    @ResponseBody
    @RequestMapping("view/get/OneVisits.json")//获取一天访问量
    public ResultEntity<Map> getOneVisits() {
        Map<String,Integer> map1 = viewService.getIndexPageView();
        Map<String,Integer> map2 = viewService.getMapPageView();
        Map<String,Integer> map3 = viewService.getCatePageView();
        Map<String,Integer> map4 = viewService.getHotelPageView();
        int[] value = new int[4];
        String[] name = {"首页", "地图", "美食", "酒店"};
        value[0] = map1.get("count");
        value[1] = map2.get("count");
        value[2] = map3.get("count");
        value[3] = map4.get("count");
        Map map = new HashMap<>();
        map.put("name",name);
        map.put("value",value);
        // 封装到ResultEntity对象中返回（如果上面的操作抛出异常，交给异常映射机制处理）
        return ResultEntity.successWithData(map);
    }

    @ResponseBody
    @RequestMapping("view/get/SevenHotel.json")//获取7天访问量
    public ResultEntity<Map> getSevenHotel() {
        List<Map> mapList = viewService.getHotelSevenPageView();
        String[] name = new String[mapList.size()];
        int[] value = new int[mapList.size()];
        for (int i = 0; i < mapList.size(); i++){
            Map map = mapList.get(i);
            name[i] = (String)map.get("time");
            value[i] = (Integer)map.get("count");
        }

        Map map = new HashMap<>();
        map.put("name",name);
        map.put("value",value);
        // 封装到ResultEntity对象中返回（如果上面的操作抛出异常，交给异常映射机制处理）
        return ResultEntity.successWithData(map);
    }

    @ResponseBody
    @RequestMapping("view/get/SevenIndex.json")//获取7天访问量
    public ResultEntity<Map<String,Object>> getSevenIndex() {
        List<Map> mapList = viewService.getIndexSevenPageView();
        String[] name = new String[mapList.size()];
        int[] value = new int[mapList.size()];
        for (int i = 0; i < mapList.size(); i++){
            Map map = mapList.get(i);
            name[i] = (String)map.get("time");
            value[i] = (Integer)map.get("count");
        }

        Map<String,Object> map = new HashMap<>();
        map.put("name",name);
        map.put("value",value);
        // 封装到ResultEntity对象中返回（如果上面的操作抛出异常，交给异常映射机制处理）
        return ResultEntity.successWithData(map);
    }

    @ResponseBody
    @RequestMapping("view/get/SevenMap.json")//获取7天访问量
    public ResultEntity<Map<String,Object>> getSevenMap() {
        List<Map> mapList = viewService.getMapSevenPageView();
        String[] name = new String[mapList.size()];
        int[] value = new int[mapList.size()];
        for (int i = 0; i < mapList.size(); i++){
            Map map = mapList.get(i);
            name[i] = (String)map.get("time");
            value[i] = (Integer)map.get("count");
        }

        Map<String,Object> map = new HashMap<>();
        map.put("name",name);
        map.put("value",value);
        // 封装到ResultEntity对象中返回（如果上面的操作抛出异常，交给异常映射机制处理）
        return ResultEntity.successWithData(map);
    }

    @ResponseBody
    @RequestMapping("view/get/SevenCate.json")//获取7天访问量
    public ResultEntity<Map<String,Object>> getSevenCate() {
        List<Map> mapList = viewService.getCateSevenPageView();
        String[] name = new String[mapList.size()];
        int[] value = new int[mapList.size()];
        for (int i = 0; i < mapList.size(); i++){
            Map map = mapList.get(i);
            name[i] = (String)map.get("time");
            value[i] = (Integer)map.get("count");
        }

        Map<String,Object> map = new HashMap<>();
        map.put("name",name);
        map.put("value",value);
        // 封装到ResultEntity对象中返回（如果上面的操作抛出异常，交给异常映射机制处理）
        return ResultEntity.successWithData(map);
    }


}
