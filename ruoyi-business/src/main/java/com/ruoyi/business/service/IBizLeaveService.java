package com.ruoyi.business.service;

import java.util.List;
import com.ruoyi.business.domain.BizLeave;

/**
 * 请假Service接口
 *
 * @author 一只闲鹿
 */
public interface IBizLeaveService
{
    /**
     * 查询请假
     *
     * @param id 请假主键
     * @return 请假
     */
    BizLeave selectBizLeaveById(Long id);

    /**
     * 查询请假列表
     *
     * @param bizLeave 请假
     * @return 请假集合
     */
    List<BizLeave> selectBizLeaveList(BizLeave bizLeave);

    /**
     * 新增请假
     *
     * @param bizLeave 请假
     * @return 结果
     */
    int insertBizLeave(BizLeave bizLeave);

    /**
     * 修改请假
     *
     * @param bizLeave 请假
     * @return 结果
     */
    int updateBizLeave(BizLeave bizLeave);

    /**
     * 批量删除请假
     *
     * @param ids 需要删除的请假主键集合
     * @return 结果
     */
    int deleteBizLeaveByIds(String ids);

    /**
     * 删除请假信息
     *
     * @param id 请假主键
     * @return 结果
     */
    int deleteBizLeaveById(Long id);
}
