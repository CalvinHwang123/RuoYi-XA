package com.ruoyi.business.listener;

import com.ruoyi.business.service.IBizLeaveService;
import com.ruoyi.business.service.impl.BizLeaveServiceImpl;
import com.ruoyi.common.utils.spring.SpringUtils;
import lombok.extern.slf4j.Slf4j;
import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.ExecutionListener;
import org.springframework.stereotype.Component;

/**
 * @author 一只闲鹿
 */
@Component
@Slf4j
public class RobotActivityListener implements ExecutionListener {

    @Override
    public void notify(DelegateExecution execution) {
        IBizLeaveService bizLeaveService = SpringUtils.getBean(BizLeaveServiceImpl.class);
        log.info("bizLeaveService: {}", bizLeaveService);
        log.info("执行了【机器活动】");
    }

}
