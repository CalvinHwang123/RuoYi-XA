package com.ruoyi.business.clazz;

import lombok.extern.slf4j.Slf4j;
import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.JavaDelegate;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class ServiceClassTask implements JavaDelegate {
    @Override
    public void execute(DelegateExecution execution) {
        log.info("执行了服务任务");
    }
}
