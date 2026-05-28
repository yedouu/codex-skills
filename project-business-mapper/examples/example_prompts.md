# Example Prompts

## 示例 1：全项目业务拆解

使用 project-business-mapper skill，以 overview 模式分析当前项目。
请从业务视角拆解项目，生成 .business-understanding 文档。
不要修改业务代码。

## 示例 2：只分析某个模块

使用 project-business-mapper skill，以 module 模式分析 src/ai 模块。
请提取该模块的业务目标、核心对象、流程、规则和异常场景。

## 示例 3：分析某条业务流程

使用 project-business-mapper skill，以 flow 模式分析：
用户发送消息后 AI 回复的业务流程。
请输出角色、输入、状态变化、异常分支和业务规则。

## 示例 4：提取状态机

使用 project-business-mapper skill，以 state-machine 模式分析订单状态流转。
请输出状态列表、允许转移、禁止转移、风险点和源码映射。

## 示例 5：面试/答辩表达

使用 project-business-mapper skill，以 interview 模式分析当前项目。
请生成我可以在面试或答辩中讲的业务介绍、核心流程、难点和亮点。

## 示例 6：需求变更影响

使用 project-business-mapper skill，以 change-impact 模式分析：
我要修改取消订单逻辑，会影响哪些业务规则和状态机？
请不要修改代码，只做业务影响分析。

## 示例 7：显示帮助

使用 project-business-mapper skill，显示帮助。

或：

project-business-mapper --help

## 示例 8：轻量分析在线仓库

使用 project-business-mapper skill，以 lightweight-remote 模式分析这个在线仓库：
https://github.com/owner/repo

请从业务视角拆解项目，先不要 clone 全仓库。
只读取 README、目录结构和关键业务文件。
输出业务摘要，并生成 .business-understanding 文档。

## 示例 9：完整分析在线仓库

使用 project-business-mapper skill，以 full-remote 模式分析：
https://github.com/owner/repo

如果需要，请浅克隆到临时目录。
请生成完整 .business-understanding 文档。
不要修改远程仓库，不要提交代码。

## 示例 10：只分析在线仓库的某个子目录

使用 project-business-mapper skill，以 scoped-remote 模式分析：
https://github.com/owner/repo/tree/main/packages/server

只分析该子目录的业务目标、核心流程、业务对象、规则和异常场景。

## 示例 11：在线仓库面试版总结

使用 project-business-mapper skill，以 remote-interview 模式分析：
https://github.com/owner/repo

请输出适合面试/答辩表达的业务介绍、核心流程、关键思想、难点和亮点。

## 示例 12：在线仓库需求变更影响分析

使用 project-business-mapper skill，以 remote-change-impact 模式分析：
https://github.com/owner/repo

需求变更：
我要修改用户取消订单逻辑。

请分析这会影响哪些业务对象、状态机、业务规则和测试点。
不要修改代码。
