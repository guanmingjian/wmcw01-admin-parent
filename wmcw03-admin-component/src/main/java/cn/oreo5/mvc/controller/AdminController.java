package cn.oreo5.mvc.controller;

import cn.oreo5.entity.DO.WangEditor;
import cn.oreo5.entity.PO.*;
import cn.oreo5.service.AdminService;
import cn.oreo5.util.NowUtil;
import cn.oreo5.util.ResultEntity;
import com.github.pagehelper.PageInfo;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.UUID;

@Controller
public class AdminController {

    @Autowired
    private AdminService adminService;

    private Logger logger = LoggerFactory.getLogger(AdminController.class);

    //自动转发受保护的页面
    @RequestMapping("{page}")
    public String main(
            @PathVariable String page,
            @RequestParam(value="type", defaultValue="0") Integer type,
            ModelMap modelMap
    ){

        // 实例化对象，并指向以 . 对 page 进行分割
        StringTokenizer s = new StringTokenizer(page, ".");
        String toPage = s.nextToken();

        modelMap.addAttribute("type",type);

        logger.info("自动转发了"+page+"页面");

        return toPage;
    }

    // 回到登录页面
    @RequestMapping("login.html")
    public String toIndex(){
        return "forward:/login.jsp";
    }

    //----------------------------------------------成员管理-------------------------------------------------------

    //获取成员列表
    @ResponseBody
    @RequestMapping("admin/get/admin-userList.json")
    public ResultEntity<PageInfo<User>> getUserPageInfo(
            @RequestParam(value="pageNum", defaultValue="1") Integer pageNum,
            @RequestParam(value="pageSize", defaultValue="10") Integer pageSize,
            @RequestParam(value="keyword", defaultValue="") String keyword
    ) {

        // 调用Service方法获取分页数据
        PageInfo<User> pageInfo = adminService.getUserPage(pageNum, pageSize, keyword);

        // 封装到ResultEntity对象中返回（如果上面的操作抛出异常，交给异常映射机制处理）
        return ResultEntity.successWithData(pageInfo);
    }

    //----------------------------------------------管理员管理-------------------------------------------------------

    //获取管理员列表
    @ResponseBody
    @RequestMapping("admin/get/admin-adminList.json")
    public ResultEntity<PageInfo<Admin>> getAdminListPageInfo(
            @RequestParam(value="pageNum", defaultValue="1") Integer pageNum,
            @RequestParam(value="pageSize", defaultValue="10") Integer pageSize,
            @RequestParam(value="keyword", defaultValue="") String keyword
    ) {
        // 调用Service方法获取分页数据
        PageInfo<Admin> pageInfo = adminService.getAdminPage(pageNum, pageSize, keyword);

        // 封装到ResultEntity对象中返回（如果上面的操作抛出异常，交给异常映射机制处理）
        return ResultEntity.successWithData(pageInfo);
    }

    //获取角色列表
    @ResponseBody
    @RequestMapping("admin/get/admin-role.json")
    public ResultEntity<PageInfo<Role>> getRoleListPageInfo(
            @RequestParam(value="pageNum", defaultValue="1") Integer pageNum,
            @RequestParam(value="pageSize", defaultValue="10") Integer pageSize,
            @RequestParam(value="keyword", defaultValue="") String keyword
    ) {
        // 调用Service方法获取分页数据
        PageInfo<Role> pageInfo = adminService.getRolePage(pageNum, pageSize, keyword);

        // 封装到ResultEntity对象中返回（如果上面的操作抛出异常，交给异常映射机制处理）
        return ResultEntity.successWithData(pageInfo);
    }

    //----------------------------------------------文章管理-------------------------------------------------------

    //获取文章列表
    @ResponseBody
    @RequestMapping("admin/get/admin-article.json")
    public ResultEntity<PageInfo<Article>> getArticlePageInfo(
            @RequestParam(value="pageNum", defaultValue="1") Integer pageNum,
            @RequestParam(value="pageSize", defaultValue="10") Integer pageSize,
            @RequestParam(value="keyword", defaultValue="") String keyword,
            @RequestParam(value="type", defaultValue="0") String type
    ) {

        // 调用Service方法获取分页数据
        PageInfo<Article> pageInfo = adminService.getArticlePage(pageNum, pageSize, keyword,type);

        // 封装到ResultEntity对象中返回（如果上面的操作抛出异常，交给异常映射机制处理）
        return ResultEntity.successWithData(pageInfo);
    }

    //发布文章
    @RequestMapping("admin/do/article/add.html")
    public String addArticle(
            @RequestParam(value="title", defaultValue="") String title,
            @RequestParam(value="authorName", defaultValue="") String authorName,
            @RequestParam(value="clas", defaultValue="0") int clas,
            @RequestParam(value="keyword", defaultValue="") String keyword,
            @RequestParam(value="timPublish", defaultValue="") String timPublish,
            @RequestParam(value="textContent", defaultValue="") String textContent
    ){

        if(clas!=0){
            Article article = new Article();
            article.setTitle(title);
            article.setKeyword(keyword);
            article.setAuthorName(authorName);
            article.setTextContent(textContent);
            article.setPublishTime(NowUtil.getDateAndTime());
            article.setClas(clas);
            article.setComNum((int)((Math.random()*9+1)*1000));
            article.setLikeNum((int)((Math.random()*9+1)*1000));
            article.setReadNum((int)((Math.random()*9+1)*1000));

            adminService.addArticle(article);
        }
        return "redirect:/admin-article.html?type="+clas+"&msg=1";
    }

    //富文本编辑器图片上传
    @RequestMapping(value = "/admin/do/article/upload.json", method = RequestMethod.POST)
    @ResponseBody
    public WangEditor uploadFile(
            @RequestParam("myFile") MultipartFile multipartFile){
        try {
            //获取输入流
            InputStream inputStream = multipartFile.getInputStream();
            //生成图片名称
            String imgName = getFileName();
            //生成文件和文件夹
            String path="F:/imgs";
            //String path="/data/imgs";
            File file = new File(path, imgName);
            FileUtils.copyInputStreamToFile(inputStream, file);

            //返回图片访问路径
            String url = "/imgs/"+imgName;

            String[] str = {url};

            WangEditor we = new WangEditor(str);
            return we;

        } catch (IOException e) {
            logger.info("上传文件失败"+e);
        }
        return null;
    }

    //生成图片名字
    public String getFileName() {
        String str = UUID.randomUUID().toString();
        String name = str + ".jpg";
        return name;
    }

    //----------------------------------------------酒店管理-------------------------------------------------------

    //获取酒店列表
    @ResponseBody
    @RequestMapping("admin/get/admin-hotel.json")
    public ResultEntity<PageInfo<Hotel>> getHotelPageInfo(
            @RequestParam(value="pageNum", defaultValue="1") Integer pageNum,
            @RequestParam(value="pageSize", defaultValue="10") Integer pageSize,
            @RequestParam(value="keyword", defaultValue="") String keyword
    ) {

        // 调用Service方法获取分页数据
        PageInfo<Hotel> pageInfo = adminService.getHotelPage(pageNum, pageSize, keyword);

        // 封装到ResultEntity对象中返回（如果上面的操作抛出异常，交给异常映射机制处理）
        return ResultEntity.successWithData(pageInfo);
    }

    //----------------------------------------------图片管理-------------------------------------------------------

    //获取图片列表
    @ResponseBody
    @RequestMapping("admin/get/admin-photo.json")
    public ResultEntity<PageInfo<Photo>> getPhotoPageInfo(
            @RequestParam(value="pageNum", defaultValue="1") Integer pageNum,
            @RequestParam(value="pageSize", defaultValue="10") Integer pageSize,
            @RequestParam(value="keyword", defaultValue="") String keyword,
            @RequestParam(value="type", defaultValue="0") String type
    ) {

        // 调用Service方法获取分页数据
        PageInfo<Photo> pageInfo = adminService.getPhotoPage(pageNum, pageSize, keyword,type);

        // 封装到ResultEntity对象中返回（如果上面的操作抛出异常，交给异常映射机制处理）
        return ResultEntity.successWithData(pageInfo);
    }

    //----------------------------------------------地图管理-------------------------------------------------------

    //获取地图列表
    @ResponseBody
    @RequestMapping("admin/get/admin-map.json")
    public ResultEntity<PageInfo<Map>> getMapPageInfo(
            @RequestParam(value="pageNum", defaultValue="1") Integer pageNum,
            @RequestParam(value="pageSize", defaultValue="10") Integer pageSize,
            @RequestParam(value="keyword", defaultValue="") String keyword,
            @RequestParam(value="type", defaultValue="0") String type
    ) {

        // 调用Service方法获取分页数据
        PageInfo<Map> pageInfo = adminService.getMapPage(pageNum, pageSize, keyword,type);

        // 封装到ResultEntity对象中返回（如果上面的操作抛出异常，交给异常映射机制处理）
        return ResultEntity.successWithData(pageInfo);
    }

    //查看该点的地图
    @RequestMapping("admin/seekMap/{id}.html")
    public String seekMap(
            @PathVariable int id,
            ModelMap modelMap
    ){
        Map map = adminService.selectMapById(id);
        modelMap.addAttribute("longitude",map.getLongitude());
        modelMap.addAttribute("latitude",map.getLatitude());

        return "mapShow";
    }

    // 进入新增地图坐标页面
    @RequestMapping("admin/get/map/{type}/add.html")
    public String adminToAddMap(
            @PathVariable int type,
            ModelMap modelMap
    ){
        modelMap.addAttribute("type",type);

        return "mapAdd";
    }

    // 新增地图坐标
    @RequestMapping("admin/do/map/{type}.add.json")
    @ResponseBody
    public ResultEntity<String> addMap(
            @PathVariable int type,
            @RequestBody java.util.Map map
    ){
        return adminService.addMap(type,map);
    }

    @ResponseBody
    @RequestMapping("admin/get/user_age.json")
    public ResultEntity<java.util.Map<String,Object>> getUserAge() {

        // 调用Service方法获取分页数据
        int[] ints = adminService.selectUserAge();
        String[] usernum = new String[4];
        for (int i = 0; i < ints.length; i++){
            usernum[i] = ints[i]+"";
            System.out.println(usernum[i]);
        }
        String[] age = {"1~16","17~30","31~60","61~100"};
        java.util.Map <String,Object> map = new HashMap<>();
        map.put("usernum",usernum);
        map.put("age",age);
        // 封装到ResultEntity对象中返回（如果上面的操作抛出异常，交给异常映射机制处理）
        return ResultEntity.successWithData(map);
    }
}
