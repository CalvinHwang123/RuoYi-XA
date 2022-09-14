package com.ruoyi.business.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 请假对象 biz_leave
 *
 * @author 一只闲鹿
 */
public class BizLeave extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 请假类型 */
    @Excel(name = "请假类型")
    private String type;

    /** 标题 */
    @Excel(name = "标题")
    private String title;

    /** 原因 */
    @Excel(name = "原因")
    private String reason;

    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date startTime;

    /** 结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "结束时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endTime;

    /** 请假时长，单位秒 */
    @Excel(name = "请假时长，单位秒")
    private Long totalTime;

    /** 实际开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "实际开始时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date realityStartTime;

    /** 实际结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "实际结束时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date realityEndTime;

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId()
    {
        return id;
    }
    public void setType(String type)
    {
        this.type = type;
    }

    public String getType()
    {
        return type;
    }
    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getTitle()
    {
        return title;
    }
    public void setReason(String reason)
    {
        this.reason = reason;
    }

    public String getReason()
    {
        return reason;
    }
    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }

    public Date getStartTime()
    {
        return startTime;
    }
    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }

    public Date getEndTime()
    {
        return endTime;
    }
    public void setTotalTime(Long totalTime)
    {
        this.totalTime = totalTime;
    }

    public Long getTotalTime()
    {
        return totalTime;
    }
    public void setRealityStartTime(Date realityStartTime)
    {
        this.realityStartTime = realityStartTime;
    }

    public Date getRealityStartTime()
    {
        return realityStartTime;
    }
    public void setRealityEndTime(Date realityEndTime)
    {
        this.realityEndTime = realityEndTime;
    }

    public Date getRealityEndTime()
    {
        return realityEndTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("type", getType())
            .append("title", getTitle())
            .append("reason", getReason())
            .append("startTime", getStartTime())
            .append("endTime", getEndTime())
            .append("totalTime", getTotalTime())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("realityStartTime", getRealityStartTime())
            .append("realityEndTime", getRealityEndTime())
            .toString();
    }
}
