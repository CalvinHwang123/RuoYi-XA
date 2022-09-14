package com.ruoyi.business.listener;

import com.ruoyi.business.domain.BizLeave;
import com.ruoyi.business.service.IBizLeaveService;
import com.ruoyi.business.service.impl.BizLeaveServiceImpl;
import com.xianlu.activiti.util.SpringUtils2;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;

/**
 * @author 一只闲鹿
 */
@Component("bizLeaveUpdateListener")
@Slf4j
public class BizLeaveUpdateListener implements TaskListener {

    @SneakyThrows
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void notify(DelegateTask delegateTask) {
        log.info("BizLeaveUpdateListener executes start");
        IBizLeaveService bizLeaveService = SpringUtils2.getBean(BizLeaveServiceImpl.class);
        BizLeave bizLeave = bizLeaveService.selectBizLeaveById(new Long(delegateTask.getExecution().getProcessInstanceBusinessKey()));
        log.info("bizLeave: {}", bizLeave);
        // 业务表单字段
        Object title = delegateTask.getVariable("title");
        Object endTime = delegateTask.getVariable("endTime");
        log.info("title: {}, endTime: {}", title, endTime);
        bizLeave.setTitle((String) title);
        bizLeave.setEndTime(new SimpleDateFormat("yyyy-MM-dd").parse((String) endTime));
        bizLeaveService.updateBizLeave(bizLeave);
        log.info("BizLeaveUpdateListener executes end");
    }
}
