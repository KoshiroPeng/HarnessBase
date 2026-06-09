package org.dromara.demo.service;

import org.dromara.demo.domain.TestDemoEncrypt;

/**
 * 测试加解密功能 Service 接口
 *
 * @author Lion Li
 */
public interface ITestDemoEncryptService {

    /**
     * 新增测试数据
     */
    boolean insert(TestDemoEncrypt demo);

    /**
     * 按主键查询测试数据
     */
    TestDemoEncrypt selectById(Long id);
}
