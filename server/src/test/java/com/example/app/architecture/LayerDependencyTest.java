package com.example.app.architecture;

import com.tngtech.archunit.core.domain.JavaModifier;
import com.tngtech.archunit.core.importer.ImportOption;
import com.tngtech.archunit.junit.AnalyzeClasses;
import com.tngtech.archunit.junit.ArchTest;
import com.tngtech.archunit.lang.ArchRule;
import org.springframework.beans.factory.annotation.Autowired;

import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.fields;
import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.noClasses;
import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.noFields;
import static com.tngtech.archunit.library.Architectures.layeredArchitecture;

@AnalyzeClasses(
    packages = "com.example.app",
    importOptions = ImportOption.DoNotIncludeTests.class
)
public class LayerDependencyTest {

    @ArchTest
    public static final ArchRule layered = layeredArchitecture()
        .consideringAllDependencies()
        .optionalLayer("Domain").definedBy("..domain..")
        .optionalLayer("Config").definedBy("..config..")
        .optionalLayer("Mapper").definedBy("..mapper..")
        .optionalLayer("Infrastructure").definedBy("..infrastructure..")
        .optionalLayer("Service").definedBy("..service..")
        .optionalLayer("Controller").definedBy("..controller..")
        .whereLayer("Domain").mayOnlyBeAccessedByLayers(
            "Config",
            "Mapper",
            "Infrastructure",
            "Service",
            "Controller"
        )
        .whereLayer("Config").mayOnlyBeAccessedByLayers(
            "Mapper",
            "Infrastructure",
            "Service",
            "Controller"
        )
        .whereLayer("Mapper").mayOnlyBeAccessedByLayers("Service")
        .whereLayer("Infrastructure").mayOnlyBeAccessedByLayers("Config", "Service")
        .whereLayer("Service").mayOnlyBeAccessedByLayers("Controller")
        .whereLayer("Controller").mayNotBeAccessedByAnyLayer()
        .as(
            "分层依赖必须保持单向。\n"
                + "允许方向：domain/config/mapper/infrastructure -> service -> controller。\n"
                + "Controller 只能调用 Service，Service 负责业务编排和基础设施适配。\n"
                + "See: docs/architecture/boundaries.md"
        )
        .allowEmptyShould(true);

    @ArchTest
    public static final ArchRule controllerMustNotUseMapper = noClasses()
        .that().resideInAPackage("..controller..")
        .should().dependOnClassesThat().resideInAPackage("..mapper..")
        .as(
            "Controller 不得直接依赖 Mapper。\n"
                + "FIX: 在 Service 中编排数据访问，Controller 仅持有 Service 引用。\n"
                + "See: docs/architecture/boundaries.md"
        )
        .allowEmptyShould(true);

    @ArchTest
    public static final ArchRule controllerMustNotUseInfrastructureDirectly = noClasses()
        .that().resideInAPackage("..controller..")
        .should().dependOnClassesThat().resideInAPackage("..infrastructure..")
        .as(
            "Controller 不得直接依赖 infrastructure。\n"
                + "FIX: 外部调用、指标、安全等横切能力由 Service 通过 Spring 注入使用。\n"
                + "See: docs/architecture/boundaries.md"
        )
        .allowEmptyShould(true);

    @ArchTest
    public static final ArchRule mapperMustNotUseService = noClasses()
        .that().resideInAPackage("..mapper..")
        .should().dependOnClassesThat().resideInAPackage("..service..")
        .as(
            "Mapper 不得依赖 Service。\n"
                + "FIX: Mapper 只负责数据访问，业务编排放在 Service。\n"
                + "See: docs/architecture/boundaries.md"
        )
        .allowEmptyShould(true);

    @ArchTest
    public static final ArchRule domainMustStayIndependent = noClasses()
        .that().resideInAPackage("..domain..")
        .should().dependOnClassesThat().resideInAnyPackage(
            "..controller..",
            "..service..",
            "..mapper..",
            "..infrastructure..",
            "org.springframework.web.."
        )
        .as(
            "Domain 必须保持独立。\n"
                + "FIX: 领域模型只能表达领域概念，不依赖 Controller、Service、Mapper 或 Web 协议。\n"
                + "See: docs/architecture/boundaries.md"
        )
        .allowEmptyShould(true);

    @ArchTest
    public static final ArchRule useApiClientForHttpCalls = noClasses()
        .that().resideOutsideOfPackage("..infrastructure..")
        .should().dependOnClassesThat().haveFullyQualifiedName("org.springframework.web.client.RestTemplate")
        .orShould().dependOnClassesThat().haveFullyQualifiedName("java.net.HttpURLConnection")
        .as(
            "禁止裸 RestTemplate / HttpURLConnection。\n"
                + "FIX: 统一通过 infrastructure.ApiClient 抽象发起外部 HTTP 调用。\n"
                + "See: docs/architecture/boundaries.md"
        )
        .allowEmptyShould(true);

    @ArchTest
    public static final ArchRule noFieldInjection = noFields()
        .should().beAnnotatedWith(Autowired.class)
        .as(
            "禁止字段级 @Autowired。\n"
                + "FIX: 使用构造器注入，推荐 Lombok @RequiredArgsConstructor。\n"
                + "See: docs/conventions/README.md"
        )
        .allowEmptyShould(true);

    @ArchTest
    public static final ArchRule injectedFieldsShouldBeFinal = fields()
        .that().areDeclaredInClassesThat().resideInAnyPackage(
            "..controller..",
            "..service..",
            "..infrastructure.."
        )
        .and().areNotStatic()
        .should().haveModifier(JavaModifier.FINAL)
        .as(
            "需要注入的协作者字段应声明为 final，并通过构造器注入。\n"
                + "FIX: 将依赖字段改为 private final，并使用显式构造器或 @RequiredArgsConstructor。\n"
                + "See: docs/conventions/README.md"
        )
        .allowEmptyShould(true);

    @ArchTest
    public static final ArchRule publicStaticFieldsMustBeFinal = fields()
        .that().haveModifier(JavaModifier.PUBLIC)
        .and().haveModifier(JavaModifier.STATIC)
        .should().haveModifier(JavaModifier.FINAL)
        .as(
            "禁止 public static 非 final 字段污染全局状态。\n"
                + "FIX: 常量声明为 public static final；可变状态放入实例字段并由 Spring 管理生命周期。\n"
                + "See: docs/architecture/boundaries.md"
        )
        .allowEmptyShould(true);

    @ArchTest
    public static final ArchRule utilityFieldsMayBeStaticFinalOnly = fields()
        .that().areDeclaredInClassesThat().resideInAPackage("..domain..")
        .and().haveModifier(JavaModifier.STATIC)
        .should().haveModifier(JavaModifier.FINAL)
        .as(
            "Domain 中的静态字段必须是常量。\n"
                + "FIX: 可变状态应放在实例字段或业务服务中，不要放在静态字段。\n"
                + "See: docs/architecture/boundaries.md"
        )
        .allowEmptyShould(true);
}
