package cn.oreo5.service.impl;

import cn.oreo5.constant.OreoConstant;
import cn.oreo5.entity.PO.*;
import cn.oreo5.mapper.*;
import cn.oreo5.service.AdminService;
import cn.oreo5.util.NowUtil;
import cn.oreo5.util.ResultEntity;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminMapper adminMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private AuthMapper authMapper;
    @Autowired
    private ArticleMapper articleMapper;
    @Autowired
    private HotelMapper hotelMapper;
    @Autowired
    private MapMapper mapMapper;
    @Autowired
    private PhotoMapper photoMapper;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Override
    public PageInfo<Role> getRolePage(Integer pageNum, Integer pageSize, String keyword) {
        // 1.开启分页功能
        PageHelper.startPage(pageNum, pageSize);

        // 2.执行查询
        List<Role> roleList = roleMapper.selectRoleByKeyword(keyword);

        // 3.封装为PageInfo对象返回
        return new PageInfo<>(roleList);
    }

    @Override
    public Role selectRoleById(String id) {
        return roleMapper.selectByPrimaryKey(Integer.parseInt(id));
    }

    @Override
    public ResultEntity<String> addRole(Role role) {

        role.setStatus("1");
        role.setCreateTime(NowUtil.getDateAndTime());

        try {
            roleMapper.insert(role);
        } catch (Exception e) {
            e.printStackTrace();

            /**
             * 判断是否违反唯一约束
             */
            if(e instanceof DuplicateKeyException) {
                return ResultEntity.failed(OreoConstant.MESSAGE_NAME_ALREADY_EXIST);
            }
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        return ResultEntity.successWithoutData();
    }

    @Override
    public ResultEntity<String> deleteRole(List<Integer> idList) {
        int flag = 0;

        RoleExample example = new RoleExample();

        RoleExample.Criteria criteria = example.createCriteria();

        criteria.andIdIn(idList);

        try {
            flag = roleMapper.deleteByExample(example);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        if(flag>0){
            return ResultEntity.successWithoutData();
        }else {
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
    }

    @Override
    public ResultEntity<String> updateRole(Role role) {

        try {
            roleMapper.updateByPrimaryKeySelective(role);
        } catch (Exception e) {
            e.printStackTrace();
            /**
             * 判断是否违反唯一约束
             */
            if(e instanceof DuplicateKeyException) {
                return ResultEntity.failed(OreoConstant.MESSAGE_NAME_ALREADY_EXIST);
            }
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        return ResultEntity.successWithoutData();
    }

    @Override
    public PageInfo<Admin> getAdminPage(Integer pageNum, Integer pageSize, String keyword) {
        // 1.开启分页功能
        PageHelper.startPage(pageNum, pageSize);

        // 2.执行查询
        List<Admin> roleList = adminMapper.selectAdminWithRoleByKeyword(keyword);

        // 3.封装为PageInfo对象返回
        return new PageInfo<>(roleList);
    }

    @Override
    public ResultEntity<String> addAdmin(List<Map> adminArray) {

        Admin admin = new Admin();
        //存放角色的ID列表
        List<Integer> roleIdList = new LinkedList<>();

        //遍历传入的数据并存入对象和集合中
        for (Map map : adminArray) {

            Set<String> set = map.keySet();

            for (String key : set) {

                String value = (String) map.get(key);

                if ("name".equals(key)) {
                    admin.setName(value);
                }
                if ("email".equals(key)) {
                    admin.setEmail(value);
                }
                if ("password".equals(key)) {
                    //String password = OreoUtil.md5(value);
                    //密码带盐值MD5加密
                    String password = passwordEncoder.encode(value);
                    admin.setPassword(password);
                }
                if ("role1".equals(key)) {
                    roleIdList.add(Integer.parseInt(value));
                }
                if ("role2".equals(key)) {
                    roleIdList.add(Integer.parseInt(value));
                }
                if ("role3".equals(key)) {
                    roleIdList.add(Integer.parseInt(value));
                }
            }
        }

        admin.setStatus("1");
        admin.setRegisterTime(NowUtil.getDate());

        try {
            //存入管理员
            adminMapper.insert(admin);
        } catch (Exception e) {
            e.printStackTrace();

            //判断是否违反唯一约束
            if (e instanceof DuplicateKeyException) {
                return ResultEntity.failed(OreoConstant.MESSAGE_NAME_ALREADY_EXIST);
            }
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }

        //存入管理员成功后

        //判断角色ID集合是否为空
        if (roleIdList != null && roleIdList.size() > 0) {

            //封装用管理员名称查询的条件
            AdminExample adminExample = new AdminExample();
            AdminExample.Criteria criteria = adminExample.createCriteria();

            //判断管理员名称是否为空
            if (admin.getName() != null || admin.getName() != "") {
                criteria.andNameEqualTo(admin.getName());
            } else {
                return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
            }

            //通过新存入的管理员名称获取该管理员的ID
            List<Admin> admins = adminMapper.selectByExample(adminExample);

            //判断通过ID是否查询到管理员
            if (admin != null && admins.size() > 0) {

                Admin returnAdmin = admins.get(0);

                //获取回传的管理员ID
                Integer returnId = returnAdmin.getId();

                if(
                    //存入管理员与角色的关联表
                    adminMapper.insertAdminRoleRelationship(returnId, roleIdList)>0
                ){
                    return ResultEntity.successWithoutData();
                }
            }
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        //角色ID集合为空时，就不存入管理员与角色关联表，返回成功
        return ResultEntity.successWithoutData();
    }

    @Override
    public ResultEntity<String> deleteAdmin(List<Integer> adminIdList) {

        //判断idArray是否为空
        if(adminIdList!=null&&adminIdList.size()>0){
            //封装通过ID的批量条件
            AdminExample example = new AdminExample();

            AdminExample.Criteria criteria = example.createCriteria();

            criteria.andIdIn(adminIdList);

            //捕获异常
            try {
                //批量删除Admin
                adminMapper.deleteByExample(example);
            } catch (Exception e) {
                e.printStackTrace();
                return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
            }

            try {
                //批量删除管理员与角色关联表
                adminMapper.deleteAdminRoleRelationship(adminIdList);
            } catch (Exception e) {
                e.printStackTrace();
                return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
            }
            return ResultEntity.successWithoutData();
        }
        return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
    }

    @Override
    public ResultEntity<String> updateAdmin(List<Map> adminArray,Integer id) {

        Admin admin = new Admin();
        admin.setId(id);

        List<Integer> adminIdList = new LinkedList<>();
        adminIdList.add(id);

        List<Integer> roleIdList = new LinkedList<>();

        for (Map map : adminArray) {

            Set<String> set = map.keySet();

            for (String key : set) {

                String value = (String)map.get(key);

                if("name".equals(key)){
                    admin.setName(value);
                }
                if("email".equals(key)){
                    admin.setEmail(value);
                }
                if("role1".equals(key)){
                    roleIdList.add(1);
                }
                if("role2".equals(key)){
                    roleIdList.add(2);
                }
                if("role3".equals(key)){
                    roleIdList.add(3);
                }
            }
        }

        try {
            //修改管理员信息
            adminMapper.updateByPrimaryKeySelective(admin);
        } catch (Exception e) {
            e.printStackTrace();

            //判断是否违反唯一约束
            if (e instanceof DuplicateKeyException) {
                return ResultEntity.failed(OreoConstant.MESSAGE_NAME_ALREADY_EXIST);
            }
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }

        try {
            //删除该ID的关联表
            adminMapper.deleteAdminRoleRelationship(adminIdList);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }

        //判断新的角色ID集合是否为空
        if(roleIdList!=null&&roleIdList.size()>0){
            if(
                //新增该ID的关联表
                adminMapper.insertAdminRoleRelationship(admin.getId(),roleIdList)>0
            ){
                return ResultEntity.successWithoutData();
            }
        }
        //角色ID集合为空时就不存入，返回成功
        return ResultEntity.successWithoutData();
    }

    @Override
    public Admin selectAdminById(String id) {
        return adminMapper.selectAdminWithRoleById(id);
    }

    @Override
    public ResultEntity<String> updateAdminStatus(Admin admin) {
        if(
            adminMapper.updateByPrimaryKeySelective(admin)>0
        ){
            return ResultEntity.successWithoutData();
        }
        return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
    }

    @Override
    public ResultEntity<String> updateRoleStatus(Role role) {
        if(
                roleMapper.updateByPrimaryKeySelective(role)>0
        ){
            return ResultEntity.successWithoutData();
        }
        return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
    }

    @Override
    public List<Auth> getAuth() {
        return authMapper.selectByExample(new AuthExample());
    }

    @Override
    public List<Integer> getAssignRelationship(Integer roleId) {
        return authMapper.selectAssignedAuthIdByRoleId(roleId);
    }

    @Override
    public ResultEntity<String> saveRoleAuthRelationship(Map<String, List<Integer>> map) {
        //1.获取 roleId 的值
        List<Integer> roleIdList = map.get("roleId");

        Integer roleId=roleIdList.get(0);

        try {
            //2.删除旧关联关系数据
            authMapper.deleteOldRelationship(roleId);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }

        //3.获取 authIdList
        List<Integer> authIdList = map.get("authIdArray");

        //4.判断 authIdList 是否有效
        if(authIdList!=null&&authIdList.size()>0){
            if(
                    authMapper.insertNewRelationship(roleId,authIdList)>0
            ){
                return ResultEntity.successWithoutData();
            }else{
                return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
            }
        }
        return ResultEntity.successWithoutData();
    }

    @Override
    public List<String> getAssignedAuthNameByAdminId(Integer adminId) {
        return authMapper.selectAssignedAuthNameByAdminId(adminId);
    }

    @Override
    public List<Role> getAssignedRoleByAdminId(Integer adminId) {
        return roleMapper.selectAssignedRoleByAdminId(adminId);
    }

    @Override
    public Admin getAdminByName(String username) {

        AdminExample adminExample = new AdminExample();

        AdminExample.Criteria criteria = adminExample.createCriteria();

        criteria.andNameEqualTo(username);

        List<Admin> admins = adminMapper.selectByExample(adminExample);

        Admin admin = admins.get(0);

        return admin;
    }

    @Override
    public PageInfo<Article> getArticlePage(Integer pageNum, Integer pageSize, String keyword, String type) {
        // 1.开启分页功能
        PageHelper.startPage(pageNum, pageSize);

        // 2.执行查询
        List<Article> articleList = articleMapper.selectArticleListByKeywordAndType(keyword,type);

        // 3.封装为PageInfo对象返回
        return new PageInfo<>(articleList);
    }

    @Override
    public PageInfo<Hotel> getHotelPage(Integer pageNum, Integer pageSize, String keyword) {
        // 1.开启分页功能
        PageHelper.startPage(pageNum, pageSize);

        // 2.执行查询
        List<Hotel> hotelList = hotelMapper.selectHotelListByKeyword(keyword);

        // 3.封装为PageInfo对象返回
        return new PageInfo<>(hotelList);
    }

    @Override
    public PageInfo<Photo> getPhotoPage(Integer pageNum, Integer pageSize, String keyword, String type) {
        // 1.开启分页功能
        PageHelper.startPage(pageNum, pageSize);

        // 2.执行查询
        List<Photo> photoList = photoMapper.selectPhotoListByKeywordAndType(keyword,type);

        // 3.封装为PageInfo对象返回
        return new PageInfo<>(photoList);
    }

    @Override
    public PageInfo<cn.oreo5.entity.PO.Map> getMapPage(Integer pageNum, Integer pageSize, String keyword, String type) {
        // 1.开启分页功能
        PageHelper.startPage(pageNum, pageSize);

        // 2.执行查询
        List<cn.oreo5.entity.PO.Map> mapList = mapMapper.selectMapListByKeywordAndType(keyword,type);

        // 3.封装为PageInfo对象返回
        return new PageInfo<>(mapList);
    }

    @Override
    public PageInfo<User> getUserPage(Integer pageNum, Integer pageSize, String keyword) {
        // 1.开启分页功能
        PageHelper.startPage(pageNum, pageSize);

        // 2.执行查询
        List<User> userList = userMapper.selectUserListByKeyword(keyword);

        // 3.封装为PageInfo对象返回
        return new PageInfo<>(userList);
    }

    @Override
    public ResultEntity<String> addHotel(Hotel hotel) {

        try{
            hotelMapper.insert(hotel);
        } catch (Exception e) {
            e.printStackTrace();

            /**
             * 判断是否违反唯一约束
             */
            if(e instanceof DuplicateKeyException) {
                return ResultEntity.failed(OreoConstant.MESSAGE_NAME_ALREADY_EXIST);
            }
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        return ResultEntity.successWithoutData();
    }

    @Override
    public ResultEntity<String> addPhoto(Photo photo) {

        try {
            photoMapper.insert(photo);
        } catch (Exception e) {
            e.printStackTrace();

            /**
             * 判断是否违反唯一约束
             */
            if(e instanceof DuplicateKeyException) {
                return ResultEntity.failed(OreoConstant.MESSAGE_NAME_ALREADY_EXIST);
            }
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        return ResultEntity.successWithoutData();
    }

    @Override
    public ResultEntity<String> deleteUser(List<Integer> idList) {
        int flag = 0;

        UserExample example = new UserExample();

        UserExample.Criteria criteria = example.createCriteria();

        criteria.andIdIn(idList);

        try {
            flag = userMapper.deleteByExample(example);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        if(flag>0){
            return ResultEntity.successWithoutData();
        }else {
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
    }

    @Override
    public ResultEntity<String> deleteArticle(List<Integer> idList) {
        int flag = 0;

        ArticleExample example = new ArticleExample();

        ArticleExample.Criteria criteria = example.createCriteria();

        criteria.andIdIn(idList);

        try {
            flag = articleMapper.deleteByExample(example);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        if(flag>0){
            return ResultEntity.successWithoutData();
        }else {
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
    }

    @Override
    public ResultEntity<String> deleteHotel(List<Integer> idList) {
        int flag = 0;

        HotelExample example = new HotelExample();

        HotelExample.Criteria criteria = example.createCriteria();

        criteria.andIdIn(idList);

        try {
            flag = hotelMapper.deleteByExample(example);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        if(flag>0){
            return ResultEntity.successWithoutData();
        }else {
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
    }

    @Override
    public ResultEntity<String> deletePhoto(List<Integer> idList) {
        int flag = 0;

        PhotoExample example = new PhotoExample();

        PhotoExample.Criteria criteria = example.createCriteria();

        criteria.andIdIn(idList);

        try {
            flag = photoMapper.deleteByExample(example);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        if(flag>0){
            return ResultEntity.successWithoutData();
        }else {
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
    }

    @Override
    public ResultEntity<String> deleteMap(List<Integer> idList) {
        int flag = 0;

        MapExample example = new MapExample();

        MapExample.Criteria criteria = example.createCriteria();

        criteria.andIdIn(idList);

        try {
            flag = mapMapper.deleteByExample(example);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        if(flag>0){
            return ResultEntity.successWithoutData();
        }else {
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
    }

    @Override
    public ResultEntity<String> addUser(User user) {

        if(user.getSex().equals("男")){
            user.setSex("1");
        }else {
            user.setSex("2");
        }

        if(user.getPassword()!=null||user.getPassword().equals("")){
            //密码带盐值MD5加密
            String encodePwd = passwordEncoder.encode(user.getPassword());
            user.setPassword(encodePwd);
        }
        user.setStatus("1");
        user.setType("3");
        user.setRegisterTime(NowUtil.getDateAndTime());

        try {
            userMapper.insert(user);
        } catch (Exception e) {
            e.printStackTrace();

            /**
             * 判断是否违反唯一约束
             */
            if(e instanceof DuplicateKeyException) {
                return ResultEntity.failed(OreoConstant.MESSAGE_NAME_ALREADY_EXIST);
            }
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        return ResultEntity.successWithoutData();

    }

    @Override
    public ResultEntity<String> updateUserStatus(User user) {
        if(
                userMapper.updateByPrimaryKeySelective(user)>0
        ){
            return ResultEntity.successWithoutData();
        }
        return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
    }

    @Override
    public User selectUserById(String id) {
        return userMapper.selectByPrimaryKey(Integer.parseInt(id));
    }

    @Override
    public Article selectArticleById(String id) {
        return articleMapper.selectByPrimaryKey(Integer.parseInt(id));
    }

    @Override
    public Hotel selectHotelById(String id) {
        return hotelMapper.selectByPrimaryKey(Integer.parseInt(id));
    }

    @Override
    public Photo selectPhotoById(String id) {
        return photoMapper.selectByPrimaryKey(Integer.parseInt(id));
    }

    @Override
    public ResultEntity<String> updateUser(User user) {

        if(user.getSex().equals("男")){
            user.setSex("1");
        }else {
            user.setSex("2");
        }

        if(user.getPassword()!=null||user.getPassword().equals("")){
            //密码带盐值MD5加密
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }

        try {
            userMapper.updateByPrimaryKeySelective(user);
        } catch (Exception e) {
            e.printStackTrace();
            /**
             * 判断是否违反唯一约束
             */
            if(e instanceof DuplicateKeyException) {
                return ResultEntity.failed(OreoConstant.MESSAGE_NAME_ALREADY_EXIST);
            }
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        return ResultEntity.successWithoutData();
    }

    @Override
    public ResultEntity<String> updateArticle(Article article) {

        article.setChangeTime(NowUtil.getDateAndTime());

        try {
            articleMapper.updateByPrimaryKeySelective(article);
        } catch (Exception e) {
            e.printStackTrace();
            /**
             * 判断是否违反唯一约束
             */
            if(e instanceof DuplicateKeyException) {
                return ResultEntity.failed(OreoConstant.MESSAGE_NAME_ALREADY_EXIST);
            }
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        return ResultEntity.successWithoutData();
    }

    @Override
    public ResultEntity<String> updateHotel(Hotel hotel) {
        try {
            hotelMapper.updateByPrimaryKeySelective(hotel);
        } catch (Exception e) {
            e.printStackTrace();
            /**
             * 判断是否违反唯一约束
             */
            if(e instanceof DuplicateKeyException) {
                return ResultEntity.failed(OreoConstant.MESSAGE_NAME_ALREADY_EXIST);
            }
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        return ResultEntity.successWithoutData();
    }

    @Override
    public ResultEntity<String> updatePhoto(Photo photo) {
        try {
            photoMapper.updateByPrimaryKeySelective(photo);
        } catch (Exception e) {
            e.printStackTrace();
            /**
             * 判断是否违反唯一约束
             */
            if(e instanceof DuplicateKeyException) {
                return ResultEntity.failed(OreoConstant.MESSAGE_NAME_ALREADY_EXIST);
            }
            return ResultEntity.failed(OreoConstant.MESSAGE_AJAX_OPER_FAILED);
        }
        return ResultEntity.successWithoutData();
    }

    @Override
    public cn.oreo5.entity.PO.Map selectMapById(int id) {
        return mapMapper.selectByPrimaryKey(id);
    }

    @Override
    public ResultEntity<String> addMap(int type, Map map) {

        Double longitude = null;
        Double latitude = null;
        String location = null;

        for (Object object : map.keySet()) {
            String key = (String)object;
            if(key.equals("longitude")){
                longitude = (Double)map.get(key);
            }
            if(key.equals("latitude")){
                latitude = (Double)map.get(key);
            }
            if(key.equals("location")){
                location = (String)map.get(key);
            }
        }

        cn.oreo5.entity.PO.Map map1 = new cn.oreo5.entity.PO.Map();
        map1.setClas(type);
        map1.setLongitude(longitude);
        map1.setLatitude(latitude);
        map1.setLocation(location);

        if(
                mapMapper.insert(map1)>0
        ){
            return ResultEntity.successWithoutData();
        }
        return ResultEntity.failed("新增失败");
    }

    @Override
    public int addArticle(Article article) {
        return articleMapper.insert(article);
    }

    @Override
    public int[] selectUserAge() {
        int[] ints = new int[4];
        UserExample userExample1 = new UserExample();
        UserExample userExample2 = new UserExample();
        UserExample userExample3 = new UserExample();
        UserExample userExample4 = new UserExample();
        UserExample.Criteria criteria1 = userExample1.createCriteria();
        UserExample.Criteria criteria2 = userExample2.createCriteria();
        UserExample.Criteria criteria3 = userExample3.createCriteria();
        UserExample.Criteria criteria4 = userExample4.createCriteria();

        criteria1.andLabelEqualTo("1");
        criteria2.andLabelEqualTo("2");
        criteria3.andLabelEqualTo("3");
        criteria4.andLabelEqualTo("4");

        ints[0] = userMapper.countByExample(userExample1);
        ints[1] = userMapper.countByExample(userExample2);
        ints[2] = userMapper.countByExample(userExample3);
        ints[3] = userMapper.countByExample(userExample4);


        return ints;
    }

    @Override
    public int[] selectUserSex() {
        int[] ints = new int[2];

        UserExample userExample1 = new UserExample();
        UserExample userExample2 = new UserExample();

        UserExample.Criteria criteria1 = userExample1.createCriteria();
        UserExample.Criteria criteria2 = userExample2.createCriteria();

        criteria1.andAgeEqualTo(1);
        criteria2.andAgeEqualTo(2);

        ints[0] = userMapper.countByExample(userExample1);
        ints[1] = userMapper.countByExample(userExample2);


        return ints;
    }
}