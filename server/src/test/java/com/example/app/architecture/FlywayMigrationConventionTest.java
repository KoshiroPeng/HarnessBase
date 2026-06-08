package com.example.app.architecture;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.FilenameFilter;
import java.util.Arrays;
import java.util.regex.Pattern;

public class FlywayMigrationConventionTest {

    private static final Pattern MIGRATION_NAME_PATTERN =
        Pattern.compile("^V[0-9]+__[-a-z0-9_]+\\.sql$");

    @Test
    public void shouldProvideMigrationDirectoryWithAtLeastOneSqlFile() {
        File migrationDirectory = new File("src/main/resources/db/migration");

        Assertions.assertTrue(
            migrationDirectory.isDirectory(),
            "必须存在 Flyway migration 目录：src/main/resources/db/migration"
        );

        File[] migrationFiles = migrationDirectory.listFiles(sqlMigrationFilter());
        Assertions.assertNotNull(migrationFiles, "Flyway migration 目录读取失败。");
        Assertions.assertTrue(
            migrationFiles.length > 0,
            "Flyway migration 目录不能为空，至少需要一个 SQL 迁移脚本。"
        );
    }

    @Test
    public void shouldUseFlywaySqlNamingConvention() {
        File migrationDirectory = new File("src/main/resources/db/migration");
        File[] migrationFiles = migrationDirectory.listFiles(sqlMigrationFilter());

        Assertions.assertNotNull(migrationFiles, "Flyway migration 目录读取失败。");

        Arrays.stream(migrationFiles)
            .forEach(file -> Assertions.assertTrue(
                MIGRATION_NAME_PATTERN.matcher(file.getName()).matches(),
                "Flyway migration 文件命名必须符合 V{版本}__{描述}.sql，例如 V1__create_user_table.sql。非法文件："
                    + file.getName()
            ));
    }

    private FilenameFilter sqlMigrationFilter() {
        return (dir, name) -> name.endsWith(".sql");
    }
}
