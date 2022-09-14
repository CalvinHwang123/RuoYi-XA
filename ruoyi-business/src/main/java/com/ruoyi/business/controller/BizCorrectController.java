package com.ruoyi.business.controller;

import java.util.List;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.business.domain.BizCorrect;
import com.ruoyi.business.service.IBizCorrectService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 员工转正Controller
 * 
 * @author 员工转正
 * @date 2021-12-01
 */
@Controller
@RequestMapping("/business/correct")
public class BizCorrectController extends BaseController
{
    private String prefix = "business/correct";

    @Autowired
    private IBizCorrectService bizCorrectService;

    @RequiresPermissions("business:correct:view")
    @GetMapping()
    public String correct()
    {
        return prefix + "/correct";
    }

    /**
     * 查询员工转正列表
     */
    @RequiresPermissions("business:correct:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(BizCorrect bizCorrect)
    {
        startPage();
        List<BizCorrect> list = bizCorrectService.selectBizCorrectList(bizCorrect);
        return getDataTable(list);
    }

    /**
     * 导出员工转正列表
     */
    @RequiresPermissions("business:correct:export")
    @Log(title = "员工转正", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(BizCorrect bizCorrect)
    {
        List<BizCorrect> list = bizCorrectService.selectBizCorrectList(bizCorrect);
        ExcelUtil<BizCorrect> util = new ExcelUtil<BizCorrect>(BizCorrect.class);
        return util.exportExcel(list, "员工转正数据");
    }

    /**
     * 新增员工转正
     */
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存员工转正
     */
    @RequiresPermissions("business:correct:add")
    @Log(title = "员工转正", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(BizCorrect bizCorrect)
    {
        return toAjax(bizCorrectService.insertBizCorrect(bizCorrect));
    }

    /**
     * 修改员工转正
     */
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap mmap)
    {
        BizCorrect bizCorrect = bizCorrectService.selectBizCorrectById(id);
        mmap.put("bizCorrect", bizCorrect);
        return prefix + "/edit";
    }

    /**
     * 修改保存员工转正
     */
    @RequiresPermissions("business:correct:edit")
    @Log(title = "员工转正", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(BizCorrect bizCorrect)
    {
        return toAjax(bizCorrectService.updateBizCorrect(bizCorrect));
    }

    /**
     * 删除员工转正
     */
    @RequiresPermissions("business:correct:remove")
    @Log(title = "员工转正", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        return toAjax(bizCorrectService.deleteBizCorrectByIds(ids));
    }
}
