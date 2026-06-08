-- 中文说明：Flyway 基线脚本。
-- 当前仓库仍处于工程骨架阶段，先用最小占位表验证：
-- 1. migration 目录已经正式建立；
-- 2. test/staging/prod 环境可通过同一条 Flyway 链路执行迁移；
-- 3. 后续真实业务表结构可以在此基础上持续演进。

CREATE TABLE IF NOT EXISTS system_bootstrap_marker (
    id BIGINT NOT NULL AUTO_INCREMENT,
    marker_code VARCHAR(64) NOT NULL,
    marker_value VARCHAR(128) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_system_bootstrap_marker_code (marker_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='工程基线迁移标记表';

INSERT INTO system_bootstrap_marker (marker_code, marker_value)
VALUES ('flyway_baseline', 'V1')
ON DUPLICATE KEY UPDATE marker_value = VALUES(marker_value);
