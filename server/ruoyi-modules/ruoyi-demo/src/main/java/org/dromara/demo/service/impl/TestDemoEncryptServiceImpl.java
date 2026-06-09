package org.dromara.demo.service.impl;

import lombok.RequiredArgsConstructor;
import org.dromara.demo.domain.TestDemoEncrypt;
import org.dromara.demo.mapper.TestDemoEncryptMapper;
import org.dromara.demo.service.ITestDemoEncryptService;
import org.springframework.stereotype.Service;

/**
 * 测试加解密功能 Service 业务层处理
 *
 * @author Lion Li
 */
@RequiredArgsConstructor
@Service
public class TestDemoEncryptServiceImpl implements ITestDemoEncryptService {

    private final TestDemoEncryptMapper baseMapper;

    @Override
    public boolean insert(TestDemoEncrypt demo) {
        return baseMapper.insert(demo) > 0;
    }

    @Override
    public TestDemoEncrypt selectById(Long id) {
        return baseMapper.selectById(id);
    }
}
