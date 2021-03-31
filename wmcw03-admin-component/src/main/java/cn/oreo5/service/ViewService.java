package cn.oreo5.service;

import java.util.List;
import java.util.Map;

public interface ViewService {

    /**
     * 查询当日主页访问量
     * @return
     */
    Map getIndexPageView();

    /**
     * 查询当日酒店访问量
     * @return
     */
    Map getHotelPageView();

    /**
     * 查询当日美食访问量
     * @return
     */
    Map getCatePageView();

    /**
     * 查询当日地图访问量
     * @return
     */
    Map getMapPageView();

    /**
     * 查询近7日主页的访问量
     * @return
     */
    List<Map> getIndexSevenPageView();

    /**
     * 查询近7日酒店的访问量
     * @return
     */
    List<Map> getHotelSevenPageView();

    /**
     * 查询近7日美食的访问量
     * @return
     */

    List<Map> getCateSevenPageView();

    /**
     * 查询近7日地图的访问量
     * @return
     */
    List<Map> getMapSevenPageView();
}
