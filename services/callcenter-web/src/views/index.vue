<template>
  <div class="app-container home">
    <section class="page-header">
      <div>
        <h1>CallCenter 初始化控制台</h1>
        <p>当前底座已按呼叫中心项目裁剪为模块化单体，优先支撑私有化部署、系统管理、权限、文件存储、缓存与后续业务模块扩展。</p>
      </div>
      <el-tag size="large" type="success">可部署底座</el-tag>
    </section>

    <el-row :gutter="16">
      <el-col v-for="item in overview" :key="item.label" :xs="24" :sm="12" :lg="6">
        <div class="metric-card">
          <div class="metric-label">{{ item.label }}</div>
          <div class="metric-value">{{ item.value }}</div>
          <div class="metric-desc">{{ item.desc }}</div>
        </div>
      </el-col>
    </el-row>

    <el-row :gutter="16" class="content-row">
      <el-col :xs="24" :lg="14">
        <div class="panel">
          <div class="panel-title">初始化范围</div>
          <el-table :data="modules" border>
            <el-table-column prop="name" label="能力" min-width="130" />
            <el-table-column prop="scope" label="当前处理" min-width="180" />
            <el-table-column prop="status" label="状态" width="110">
              <template #default="{ row }">
                <el-tag :type="row.type">{{ row.status }}</el-tag>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </el-col>
      <el-col :xs="24" :lg="10">
        <div class="panel">
          <div class="panel-title">工程约束</div>
          <ul class="rule-list">
            <li v-for="rule in rules" :key="rule">{{ rule }}</li>
          </ul>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="Index" lang="ts">
const overview = [
  { label: '架构模式', value: '模块化单体', desc: '保留清晰模块边界，后续按真实边界拆分' },
  { label: '部署方式', value: 'Compose', desc: 'MySQL、Redis、MinIO 与应用可一键编排' },
  { label: '开发范式', value: 'SDD', desc: '规范、计划、任务、实现、验证闭环' },
  { label: '业务阶段', value: '零到一', desc: '先稳定底座，再逐步补齐呼叫中心能力' }
];

const modules = [
  { name: '系统管理', scope: '用户、角色、菜单、部门、岗位、字典、参数', status: '保留', type: 'success' },
  { name: '系统监控', scope: '在线用户、操作日志、登录日志、缓存监控', status: '保留', type: 'success' },
  { name: '文件存储', scope: 'MinIO 私有化对象存储配置', status: '保留', type: 'success' },
  { name: '低频工具', scope: '代码生成、示例、工作流、任务调度、外部监控', status: '裁剪', type: 'info' }
];

const rules = [
  '第一阶段不默认引入微服务、Nacos、Kubernetes、ELK 或 SkyWalking。',
  '业务需求必须先进入 specs，再生成 plan、tasks 和实现代码。',
  'Docker Compose 是默认交付入口，生产部署先保证一个命令可启动。',
  'CTI、录音、质检、外呼、聊天等业务模块后续按 spec 单独落地。'
];
</script>

<style lang="scss" scoped>
.home {
  color: var(--el-text-color-primary);

  .page-header {
    display: flex;
    gap: 16px;
    align-items: flex-start;
    justify-content: space-between;
    margin-bottom: 18px;

    h1 {
      margin: 0 0 8px;
      font-size: 24px;
      font-weight: 600;
    }

    p {
      max-width: 760px;
      margin: 0;
      color: var(--el-text-color-secondary);
      line-height: 1.7;
    }
  }

  .metric-card,
  .panel {
    border: 1px solid var(--el-border-color-light);
    border-radius: 6px;
    background: var(--el-bg-color);
  }

  .metric-card {
    min-height: 128px;
    padding: 18px;
    margin-bottom: 16px;
  }

  .metric-label,
  .metric-desc {
    color: var(--el-text-color-secondary);
  }

  .metric-label {
    font-size: 13px;
  }

  .metric-value {
    margin: 10px 0;
    font-size: 26px;
    font-weight: 600;
  }

  .metric-desc {
    line-height: 1.6;
  }

  .content-row {
    margin-top: 4px;
  }

  .panel {
    padding: 16px;
    margin-bottom: 16px;
  }

  .panel-title {
    margin-bottom: 12px;
    font-size: 16px;
    font-weight: 600;
  }

  .rule-list {
    padding-left: 18px;
    margin: 0;
    color: var(--el-text-color-regular);
    line-height: 1.9;
  }
}
</style>
