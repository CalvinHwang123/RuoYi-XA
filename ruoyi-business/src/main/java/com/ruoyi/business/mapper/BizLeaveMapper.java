package com.ruoyi.business.mapper;

import java.util.List;
import com.ruoyi.business.domain.BizLeave;

/**
 * 请假Mapper接口
 *
 * @author 一只闲鹿
 */
public interface BizLeaveMapper
{
    /**
     * 查询请假
     *
     * @param id 请假主键
     * @return 请假
     */
    public BizLeave selectBizLeaveById(Long id);

    /**
     * 查询请假列表
     *
     * @param bizLeave 请假
     * @return 请假集合
     */
    public List<BizLeave> selectBizLeaveList(BizLeave bizLeave);

    /**
     * 新增请假
     *
     * @param bizLeave 请假
     * @return 结果
     */
    public int insertBizLeave(BizLeave bizLeave);

    /**
     * 修改请假
     *
     * @param bizLeave 请假
     * @return 结果
     */
    public int updateBizLeave(BizLeave bizLeave);

    /**
     * 删除请假
     *
     * @param id 请假主键
     * @return 结果
     */
    public int deleteBizLeaveById(Long id);

    /**
     * 批量删除请假
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteBizLeaveByIds(String[] ids);
}
