package com.ruoyi.business.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.business.mapper.BizCorrectMapper;
import com.ruoyi.business.domain.BizCorrect;
import com.ruoyi.business.service.IBizCorrectService;
import com.ruoyi.common.core.text.Convert;

/**
 * 员工转正Service业务层处理
 * 
 * @author 员工转正
 * @date 2021-12-01
 */
@Service
public class BizCorrectServiceImpl implements IBizCorrectService 
{
    @Autowired
    private BizCorrectMapper bizCorrectMapper;

    /**
     * 查询员工转正
     * 
     * @param id 员工转正主键
     * @return 员工转正
     */
    @Override
    public BizCorrect selectBizCorrectById(Long id)
    {
        return bizCorrectMapper.selectBizCorrectById(id);
    }

    /**
     * 查询员工转正列表
     * 
     * @param bizCorrect 员工转正
     * @return 员工转正
     */
    @Override
    public List<BizCorrect> selectBizCorrectList(BizCorrect bizCorrect)
    {
        return bizCorrectMapper.selectBizCorrectList(bizCorrect);
    }

    /**
     * 新增员工转正
     * 
     * @param bizCorrect 员工转正
     * @return 结果
     */
    @Override
    public int insertBizCorrect(BizCorrect bizCorrect)
    {
        bizCorrect.setCreateTime(DateUtils.getNowDate());
        return bizCorrectMapper.insertBizCorrect(bizCorrect);
    }

    /**
     * 修改员工转正
     * 
     * @param bizCorrect 员工转正
     * @return 结果
     */
    @Override
    public int updateBizCorrect(BizCorrect bizCorrect)
    {
        bizCorrect.setUpdateTime(DateUtils.getNowDate());
        return bizCorrectMapper.updateBizCorrect(bizCorrect);
    }

    /**
     * 批量删除员工转正
     * 
     * @param ids 需要删除的员工转正主键
     * @return 结果
     */
    @Override
    public int deleteBizCorrectByIds(String ids)
    {
        return bizCorrectMapper.deleteBizCorrectByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除员工转正信息
     * 
     * @param id 员工转正主键
     * @return 结果
     */
    @Override
    public int deleteBizCorrectById(Long id)
    {
        return bizCorrectMapper.deleteBizCorrectById(id);
    }
}
