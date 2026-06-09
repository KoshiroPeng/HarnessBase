package org.dromara.demo.controller;

import org.dromara.common.core.domain.R;
import org.dromara.common.redis.utils.RedisUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Redis 发布订阅 演示案例
 *
 * @author Lion Li
 */
@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/demo/redis/pubsub")
public class RedisPubSubController {

    /**
     * 发布消息
     *
     * @param key   通道Key
     * @param value 发送内容
     */
    @GetMapping("/pub")
    public R<Void> pub(String key, String value) {
        RedisUtils.publish(key, value, consumer -> {
            log.info("发布通道 => {}, 发送值 => {}", key, value);
        });
        return R.ok("操作成功");
    }

    /**
     * 订阅消息
     *
     * @param key 通道Key
     */
    @GetMapping("/sub")
    public R<Void> sub(String key) {
        RedisUtils.subscribe(key, String.class, msg -> {
            log.info("订阅通道 => {}, 接收值 => {}", key, msg);
        });
        return R.ok("操作成功");
    }

}
