package cn.oreo5.mapper;

import cn.oreo5.entity.PO.Admin;
import cn.oreo5.entity.PO.AdminExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminMapper {
    int countByExample(AdminExample example);

    int deleteByExample(AdminExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Admin record);

    int insertSelective(Admin record);

    List<Admin> selectByExample(AdminExample example);

    Admin selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Admin record, @Param("example") AdminExample example);

    int updateByExample(@Param("record") Admin record, @Param("example") AdminExample example);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKey(Admin record);

    /**
     * 查询管理员表，关联查询出角色表
     * @param keyword
     * @return
     */
    List<Admin> selectAdminWithRoleByKeyword(String keyword);

    /**
     * 新增关联表
     * @param adminId
     * @param roleIdList
     * @return
     */
    int insertAdminRoleRelationship(@Param("adminId") Integer adminId, @Param("roleIdList") List<Integer> roleIdList);

    /**
     * 删除关联表
     * @param adminIdList
     * @return
     */
    int deleteAdminRoleRelationship(@Param("adminIdList") List<Integer> adminIdList);

    /**
     * 通过关联表查出带角色表的管理员表
     * @return
     */
    Admin selectAdminWithRoleById(@Param("adminId") String adminId);
}