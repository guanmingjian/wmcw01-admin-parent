package cn.oreo5.mapper;

import cn.oreo5.entity.PO.Auth;
import cn.oreo5.entity.PO.AuthExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AuthMapper {
    int countByExample(AuthExample example);

    int deleteByExample(AuthExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Auth record);

    int insertSelective(Auth record);

    List<Auth> selectByExample(AuthExample example);

    Auth selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Auth record, @Param("example") AuthExample example);

    int updateByExample(@Param("record") Auth record, @Param("example") AuthExample example);

    int updateByPrimaryKeySelective(Auth record);

    int updateByPrimaryKey(Auth record);

    /**
     * 通过角色ID查询出角色与权限的关联关系表
     * @param roleId
     * @return
     */
    List<Integer> selectAssignedAuthIdByRoleId(Integer roleId);

    /**
     * 删除该ID旧的角色与权限关联关系表
     * @param roleId
     * @return
     */
    int deleteOldRelationship(Integer roleId);

    /**
     * 新建该ID新的角色与权限关联关系表
     * @param roleId
     * @param authIdList
     * @return
     */
    int insertNewRelationship(@Param("roleId") Integer roleId, @Param("authIdList") List<Integer> authIdList);

    /**
     * 根据adminId查询已分配的权限
     * @param adminId
     * @return
     */
    List<String> selectAssignedAuthNameByAdminId(Integer adminId);
}