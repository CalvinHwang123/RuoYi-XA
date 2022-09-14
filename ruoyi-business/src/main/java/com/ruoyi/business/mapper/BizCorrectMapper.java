package com.ruoyi.business.mapper;

import java.util.List;
import com.ruoyi.business.domain.BizCorrect;

/**
 * 员工转正Mapper接口
 * 
 * @author 员工转正
 * @date 2021-12-01
 */
public interface BizCorrectMapper 
{
    /**
     * 查询员工转正
     * 
     * @param id 员工转正主键
     * @return 员工转正
     */
    public BizCorrect selectBizCorrectById(Long id);

    /**
     * 查询员工转正列表
     * 
     * @param bizCorrect 员工转正
     * @return 员工转正集合
     */
    public List<BizCorrect> selectBizCorrectList(BizCorrect bizCorrect);

    /**
     * 新增员工转正
     * 
     * @param bizCorrect 员工转正
     * @return 结果
     */
    public int insertBizCorrect(BizCorrect bizCorrect);

    /**
     * 修改员工转正
     * 
     * @param bizCorrect 员工转正
     * @return 结果
     */
    public int updateBizCorrect(BizCorrect bizCorrect);

    /**
     * 删除员工转正
     * 
     * @param id 员工转正主键
     * @return 结果
     */
    public int deleteBizCorrectById(Long id);

    /**
     * 批量删除员工转正
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteBizCorrectByIds(String[] ids);
}
