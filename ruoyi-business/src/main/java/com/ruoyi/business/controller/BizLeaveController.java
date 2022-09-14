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
import com.ruoyi.business.domain.BizLeave;
import com.ruoyi.business.service.IBizLeaveService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 请假Controller
 *
 * @author 一只闲鹿
 */
@Controller
@RequestMapping("/business/leave")
public class BizLeaveController extends BaseController
{
    private String prefix = "business/leave";

    @Autowired
    private IBizLeaveService bizLeaveService;

    @RequiresPermissions("business:leave:view")
    @GetMapping()
    public String leave()
    {
        return prefix + "/leave";
    }

    /**
     * 查询请假列表
     */
    @RequiresPermissions("business:leave:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(BizLeave bizLeave)
    {
        startPage();
        List<BizLeave> list = bizLeaveService.selectBizLeaveList(bizLeave);
        return getDataTable(list);
    }

    /**
     * 导出请假列表
     */
    @RequiresPermissions("business:leave:export")
    @Log(title = "请假", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(BizLeave bizLeave)
    {
        List<BizLeave> list = bizLeaveService.selectBizLeaveList(bizLeave);
        ExcelUtil<BizLeave> util = new ExcelUtil<BizLeave>(BizLeave.class);
        return util.exportExcel(list, "请假数据");
    }

    /**
     * 新增请假
     */
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存请假
     */
    @RequiresPermissions("business:leave:add")
    @Log(title = "请假", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(BizLeave bizLeave)
    {
        return toAjax(bizLeaveService.insertBizLeave(bizLeave));
    }

    /**
     * 修改请假
     */
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap mmap)
    {
        BizLeave bizLeave = bizLeaveService.selectBizLeaveById(id);
        mmap.put("bizLeave", bizLeave);
        return prefix + "/edit";
    }

    /**
     * 修改保存请假
     */
    @RequiresPermissions("business:leave:edit")
    @Log(title = "请假", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(BizLeave bizLeave)
    {
        return toAjax(bizLeaveService.updateBizLeave(bizLeave));
    }

    /**
     * 删除请假
     */
    @RequiresPermissions("business:leave:remove")
    @Log(title = "请假", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        return toAjax(bizLeaveService.deleteBizLeaveByIds(ids));
    }
}
