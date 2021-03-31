<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base href="http://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/" />
    <!-- CSRF -->
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="百度地图,百度地图API，百度地图自定义工具，百度地图所见即所得工具" />
    <meta name="description" content="百度地图API自定义地图，帮助用户在可视化操作下生成百度地图" />
    <style type="text/css">
        body, html ,#map{width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
    </style>
    <title>百度地图API自定义地图</title>
    <!--引用百度地图API-->
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=edWz0TEY0SfquXMWHCewibkPiWyaIVmM"></script>
</head>

<body>
<!--百度地图容器-->
<div style="border:#ccc solid 1px;font-size:12px" id="map"></div>
</body>
<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="lib/layer/layer.js"></script>
<script type="text/javascript">
    //创建和初始化地图函数：
    function initMap(){
        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
        addMapOverlay();//向地图添加覆盖物
    }
    function createMap(){
        map = new BMap.Map("map");
        map.centerAndZoom(new BMap.Point(113.58796,23.056822),15);
        geoc = new BMap.Geocoder();
    }
    function setMapEvent(){
        map.enableScrollWheelZoom();
        map.enableKeyboard();
        map.enableDragging();
        map.enableDoubleClickZoom()
    }
    function addClickHandler(target,window){
        target.addEventListener("click",function(){
            target.openInfoWindow(window);
        });
    }
    function addMapOverlay(){
    }
    //向地图添加控件
    function addMapControl(){
        var scaleControl = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
        scaleControl.setUnit(BMAP_UNIT_IMPERIAL);
        map.addControl(scaleControl);
        var navControl = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
        map.addControl(navControl);
        var overviewControl = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:true});
        map.addControl(overviewControl);
    }
    var map;
    var geoc;
    initMap();
    map.addEventListener("click",getInfo);
    //点击地图获取起点或终点坐标
    function getInfo(e){
        map.clearOverlays();
        // 经纬度e.point.lng和e.point.lat;
        maker = new BMap.Marker(e.point);  // 创建标注
        map.addOverlay(maker);              // 将标注添加到地图中
        geoc.getLocation(e.point, function(rs){
            var addComp = rs.addressComponents;
            var location =  addComp.province+addComp.city+addComp.district+addComp.street+addComp.streetNumber;
            var longitude = e.point.lng;
            var latitude = e.point.lat;
            f(longitude,latitude,location);
        });
    }
    function f(lng,lat,location) {

        // 获取 CSRF Token
        window.csrfToken = $("meta[name='_csrf']").attr("content");
        window.csrfHeader = $("meta[name='_csrf_header']").attr("content");

        layer.confirm('确认要删除吗？'+'<br>'+'地址：'+location,function(){

            var map = [];
            map = {
                longitude:lng,
                latitude:lat,
                location:location
            };

            $.ajax({
                "url":"admin/do/map/${requestScope.type}.add.json",
                "type":"post",
                "beforeSend":function (request) {
                    request.setRequestHeader(csrfHeader,csrfToken);     // 添加 CSRF Token
                },
                "data":JSON.stringify(map),
                "contentType":"application/json;charset=UTF-8",
                "dataType":"json",
                "success":function(response){

                    var result = response.result;

                    if(result == "SUCCESS") {
                        layer.alert('新增成功');
                    }

                    if(result == "FAILED") {
                        layer.alert('新增失败');
                    }
                },
                "error":function(response){
                    layer.alert('新增失败');
                }
            });
        });
    }
</script>
</html>
