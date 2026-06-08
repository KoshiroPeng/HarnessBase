/**
 * DTO 包。
 *
 * <p>放 Request、Response、Command、Query 等跨层数据对象。当前基线已支持
 * record，但为保持与现有 Lombok 模式一致，如需不可变对象，优先评估是否继续使用
 * Lombok {@code @Value}，避免在过渡期混入过多风格。</p>
 */
package com.example.app.domain.dto;

