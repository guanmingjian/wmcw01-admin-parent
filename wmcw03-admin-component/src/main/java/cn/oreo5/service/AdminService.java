package cn.oreo5.service;

import cn.oreo5.entity.*;
import cn.oreo5.entity.PO.*;
import cn.oreo5.util.ResultEntity;
import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

public interface AdminService {

    /**
     * 获取分页的Role列表
     * @param pageNum
     * @param pageSize
     * @param keyword
     * @return
     */
    PageInfo<Role> getRolePage(Integer pageNum, Integer pageSize, String keyword);

    /**
     * 通过ID获取Role
     * @param id
     * @return
     */
    Role selectRoleById(String id);

    /**
     * 新增Role
     * @param role
     * @return
     */
    ResultEntity<String> addRole(Role role);

    /**
     * 删除Role
     * @param idList
     * @return
     */
    ResultEntity<String> deleteRole(List<Integer> idList);

    /**
     * 更新Role
     * @param role
     * @return
     */
    ResultEntity<String> updateRole(Role role);

    /**
     * 获取分页的Admin列表
     * @param pageNum
     * @param pageSize
     * @param keyword
     * @return
     */
    PageInfo<Admin> getAdminPage(Integer pageNum, Integer pageSize, String keyword);

    /**
     * 新增Admin
     * @param adminArray
     * @return
     */
    ResultEntity<String> addAdmin(List<Map> adminArray);

    /**
     * 删除Admin
     * @param adminIdList
     * @return
     */
    ResultEntity<String> deleteAdmin(List<Integer> adminIdList);

    /**
     * 更新Admin
     * @param adminArray
     * @return
     */
    ResultEntity<String> updateAdmin(List<Map> adminArray, Integer id);

    /**
     * 通过ID获取Admin
     * @param id
     * @return
     */
    Admin selectAdminById(String id);

    /**
     * 更新管理员状态
     * @param admin
     * @return
     */
    ResultEntity<String> updateAdminStatus(Admin admin);

    /**
     * 更新角色状态
     * @param role
     * @return
     */
    ResultEntity<String> updateRoleStatus(Role role);


    /**
     * 获取Auth数据
     * @return
     */
    List<Auth> getAuth();

    /**
     * 获取已授权的角色与权限关联关系表
     * @param roleId
     * @return
     */
    List<Integer> getAssignRelationship(Integer roleId);

    /**
     * 保存角色-权限关联表
     * @param map
     * @return
     */
    ResultEntity<String> saveRoleAuthRelationship(Map<String, List<Integer>> map);

    /**
     * 根据adminId查询已分配的权限
     * @param adminId
     * @return
     */
    List<String> getAssignedAuthNameByAdminId(Integer adminId);

    /**
     * 根据adminId查询已分配的角色
     * @param adminId
     * @return
     */
    List<Role> getAssignedRoleByAdminId(Integer adminId);

    /**
     * 根据name查询出Admin
     * @param username
     * @return
     */
    Admin getAdminByName(String username);

    /**
     * 获取分页的Article列表
     * @param pageNum
     * @param pageSize
     * @param keyword
     * @param type
     * @return
     */
    PageInfo<Article> getArticlePage(Integer pageNum, Integer pageSize, String keyword, String type);

    /**
     * 获取分页的Hotel列表
     * @param pageNum
     * @param pageSize
     * @param keyword
     * @return
     */
    PageInfo<Hotel> getHotelPage(Integer pageNum, Integer pageSize, String keyword);

    /**
     * 获取分页的Photo列表
     * @param pageNum
     * @param pageSize
     * @param keyword
     * @param type
     * @return
     */
    PageInfo<Photo> getPhotoPage(Integer pageNum, Integer pageSize, String keyword, String type);

    /**
     * 获取分页的Map列表
     * @param pageNum
     * @param pageSize
     * @param keyword
     * @param type
     * @return
     */
    PageInfo<cn.oreo5.entity.PO.Map> getMapPage(Integer pageNum, Integer pageSize, String keyword, String type);

    /**
     * 获取分页的User列表
     * @param pageNum
     * @param pageSize
     * @param keyword
     * @return
     */
    PageInfo<User> getUserPage(Integer pageNum, Integer pageSize, String keyword);

    /**
     * 新增Hotel
     * @param hotel
     * @return
     */
    ResultEntity<String> addHotel(Hotel hotel);

    /**
     * 新增Photo
     * @param photo
     * @return
     */
    ResultEntity<String> addPhoto(Photo photo);

    /**
     * 删除User
     * @param idList
     * @return
     */
    ResultEntity<String> deleteUser(List<Integer> idList);

    /**
     * 删除Article
     * @param idList
     * @return
     */
    ResultEntity<String> deleteArticle(List<Integer> idList);

    /**
     * 删除Hotel
     * @param idList
     * @return
     */
    ResultEntity<String> deleteHotel(List<Integer> idList);

    /**
     * 删除Photo
     * @param idList
     * @return
     */
    ResultEntity<String> deletePhoto(List<Integer> idList);

    /**
     * 删除Map
     * @param idList
     * @return
     */
    ResultEntity<String> deleteMap(List<Integer> idList);

    /**
     * 新增User
     * @param user
     * @return
     */
    ResultEntity<String> addUser(User user);

    /**
     * 更新用户状态
     * @param user
     * @return
     */
    ResultEntity<String> updateUserStatus(User user);

    /**
     * 通过ID获取User
     * @param id
     * @return
     */
    User selectUserById(String id);

    /**
     * 通过ID获取Article
     * @param id
     * @return
     */
    Article selectArticleById(String id);

    /**
     * 通过ID获取Hotel
     * @param id
     * @return
     */
    Hotel selectHotelById(String id);

    /**
     * 通过ID获取Photo
     * @param id
     * @return
     */
    Photo selectPhotoById(String id);

    /**
     * 更新User
     * @param user
     * @return
     */
    ResultEntity<String> updateUser(User user);

    /**
     * 更新Article
     * @param article
     * @return
     */
    ResultEntity<String> updateArticle(Article article);

    /**
     * 更新Hotel
     * @param hotel
     * @return
     */
    ResultEntity<String> updateHotel(Hotel hotel);

    /**
     * 更新Photo
     * @param photo
     * @return
     */
    ResultEntity<String> updatePhoto(Photo photo);

    /**
     * 通过ID获取Map
     * @param id
     * @return
     */
    cn.oreo5.entity.PO.Map selectMapById(int id);

    /**
     * 新增坐标
     * @param type
     * @param map
     * @return
     */
    ResultEntity<String> addMap(int type, Map map);

    /**
     * 新增文章
     * @param article
     * @return
     */
    int addArticle(Article article);

    /**
     * 查询全部用户的年龄，并返回一个数组：不同年龄段的总人数
     * @return
     */
    int[] selectUserAge();

    /**
     * 查询用户的男、女性别的总数量
     * @return
     */
    int[] selectUserSex();
}

