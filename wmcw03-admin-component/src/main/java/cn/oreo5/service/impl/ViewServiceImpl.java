package cn.oreo5.service.impl;


import cn.oreo5.entity.PO.View;
import cn.oreo5.entity.PO.ViewExample;
import cn.oreo5.mapper.ViewMapper;
import cn.oreo5.service.ViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class ViewServiceImpl implements ViewService {

    @Autowired
    private ViewMapper viewMapper;

    @Override
    public Map getIndexPageView() {
        Map map = new HashMap<>();

        ViewExample viewExample = new ViewExample();
        ViewExample.Criteria criteria = viewExample.createCriteria();

        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String format = sdf.format(date);

        criteria.andTimeEqualTo(format);
        criteria.andIndexVisitsIsNotNull();

        List<View> view = viewMapper.selectByExample(viewExample);
        if (view.size() == 0) {
            map.put("count", 0);
            map.put("time", format);
        } else {
            map.put("count", view.get(0).getIndexVisits());
            map.put("time", format);
        }

        return map;
    }

    @Override
    public Map getHotelPageView() {
        Map map = new HashMap<>();

        ViewExample viewExample = new ViewExample();
        ViewExample.Criteria criteria = viewExample.createCriteria();

        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String format = sdf.format(date);

        criteria.andTimeEqualTo(format);
        criteria.andHotelVisitsIsNotNull();

        List<View> view = viewMapper.selectByExample(viewExample);

        if (view.size() == 0) {
            map.put("time", format);
            map.put("count", 0);
        } else {
            map.put("count", view.get(0).getHotelVisits());
            map.put("time", format);
        }

        return map;
    }

    @Override
    public Map getCatePageView() {
        Map map = new HashMap<>();

        ViewExample viewExample = new ViewExample();
        ViewExample.Criteria criteria = viewExample.createCriteria();

        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String format = sdf.format(date);

        criteria.andTimeEqualTo(format);
        criteria.andCateVisitsIsNotNull();

        List<View> view = viewMapper.selectByExample(viewExample);

        if (view.size() == 0) {
            map.put("time", format);
            map.put("count", 0);
        } else {
            map.put("count", view.get(0).getCateVisits());
            map.put("time", format);
        }

        return map;
    }

    @Override
    public Map getMapPageView() {
        Map map = new HashMap<>();

        ViewExample viewExample = new ViewExample();
        ViewExample.Criteria criteria = viewExample.createCriteria();

        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String format = sdf.format(date);

        criteria.andTimeEqualTo(format);
        criteria.andMapVisitsIsNotNull();

        List<View> view = viewMapper.selectByExample(viewExample);

        if (view.size() == 0) {
            map.put("time", format);
            map.put("count", 0);
        } else {
            map.put("count", view.get(0).getMapVisits());
            map.put("time", format);
        }

        return map;
    }

    @Override
    public List<Map> getIndexSevenPageView() {
        List<Map> mapList = new LinkedList<>();

        // 获取7天的日期，同时查询访问量
        for (int i = 6; i >= 0; i--) {
            Map map = new HashMap<>();

            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - i);
            Date today = calendar.getTime();
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            String result = format.format(today);

            ViewExample viewExample = new ViewExample();
            ViewExample.Criteria criteria = viewExample.createCriteria();

            criteria.andTimeEqualTo(result);
            criteria.andIndexVisitsIsNotNull();

            List<View> view = viewMapper.selectByExample(viewExample);
            if (view.size() == 0) {
                map.put("count", 0);
                map.put("time", result);
            } else {
                map.put("count", view.get(0).getIndexVisits());
                map.put("time", result);
            }
            mapList.add(map);
        }

        return mapList;
    }

    @Override
    public List<Map> getHotelSevenPageView() {
        List<Map> mapList = new LinkedList<>();

        // 获取7天的日期，同时查询访问量
        for (int i = 6; i >= 0; i--) {
            Map map = new HashMap<>();

            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - i);
            Date today = calendar.getTime();
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            String result = format.format(today);

            ViewExample viewExample = new ViewExample();
            ViewExample.Criteria criteria = viewExample.createCriteria();

            criteria.andTimeEqualTo(result);
            criteria.andHotelVisitsIsNotNull();

            List<View> view = viewMapper.selectByExample(viewExample);
            if (view.size() == 0) {
                map.put("count", 0);
                map.put("time", result);
            } else {
                map.put("count", view.get(0).getHotelVisits());
                map.put("time", result);
            }
            mapList.add(map);
        }

        return mapList;
    }

    @Override
    public List<Map> getCateSevenPageView() {
        List<Map> mapList = new LinkedList<>();

        // 获取7天的日期，同时查询访问量
        for (int i = 6; i >= 0; i--) {
            Map map = new HashMap<>();

            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - i);
            Date today = calendar.getTime();
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            String result = format.format(today);

            ViewExample viewExample = new ViewExample();
            ViewExample.Criteria criteria = viewExample.createCriteria();

            criteria.andTimeEqualTo(result);
            criteria.andCateVisitsIsNotNull();

            List<View> view = viewMapper.selectByExample(viewExample);
            if (view.size() == 0) {
                map.put("count", 0);
                map.put("time", result);
            } else {
                map.put("count", view.get(0).getCateVisits());
                map.put("time", result);
            }
            mapList.add(map);
        }

        return mapList;
    }

    @Override
    public List<Map> getMapSevenPageView() {
        List<Map> mapList = new LinkedList<>();

        // 获取7天的日期，同时查询访问量
        for (int i = 6; i >= 0; i--) {
            Map map = new HashMap<>();

            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - i);
            Date today = calendar.getTime();
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            String result = format.format(today);

            ViewExample viewExample = new ViewExample();
            ViewExample.Criteria criteria = viewExample.createCriteria();

            criteria.andTimeEqualTo(result);
            criteria.andMapVisitsIsNotNull();

            List<View> view = viewMapper.selectByExample(viewExample);
            if (view.size() == 0) {
                map.put("count", 0);
                map.put("time", result);
            } else {
                map.put("count", view.get(0).getMapVisits());
                map.put("time", result);
            }
            mapList.add(map);
        }

        return mapList;
    }
}