package cn.oreo5.mapper;

import cn.oreo5.entity.PO.Role;
import cn.oreo5.entity.PO.RoleExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoleMapper {
    int countByExample(RoleExample example);

    int deleteByExample(RoleExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Role record);

    int insertSelective(Role record);

    List<Role> selectByExample(RoleExample example);

    Role selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Role record, @Param("example") RoleExample example);

    int updateByExample(@Param("record") Role record, @Param("example") RoleExample example);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);

    /**
     * 通过关键字模糊查询角色列表
     * @param keyword
     * @return
     */
    List<Role> selectRoleByKeyword(String keyword);

    /**
     * 根据adminId查询已分配的角色
     * @param adminId
     * @return
     */
    List<Role> selectAssignedRoleByAdminId(Integer adminId);
}