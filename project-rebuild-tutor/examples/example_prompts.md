# Example Prompts

## 1. 从零学习整个项目，先询问基础

使用 project-rebuild-tutor skill，分析当前项目。
在给出计划前，请先询问我的基础和学习目标。
我想通过从零复刻的方式完全学会这个项目。
章节内容请先讲理论、实现思路和原项目设计解读，最后再安排编码步骤。

## 2. 直接零基础开始并创建学习目录

使用 project-rebuild-tutor skill，分析当前项目。
不用询问，直接按零基础路线开始。
请先输出先导性说明，然后在项目目录中创建 .learning-roadmap 教学目录和章节式教程。
章节默认先讲理论和实现思路，最后才给编码步骤。
不要修改业务代码。

## 3. 只学习某个模块

使用 project-rebuild-tutor skill，只学习 AI 回复模块。
请先询问我的基础和目标，然后生成局部复刻路线，并创建 .learning-roadmap 教学文件。
每章先解释模块为什么存在、解决什么问题、原项目为什么这样设计，再安排实践任务。

## 4. 重构式学习

使用 project-rebuild-tutor skill，分析当前项目的核心模块。
我想通过重构这个模块来学习它。
请先生成安全重构路线，创建学习目录，不要直接修改业务代码。
章节请先讲设计问题、理论依据和原项目结构，再给最小安全重构步骤。

## 5. 面试/答辩路线

使用 project-rebuild-tutor skill，分析当前项目。
我的目标是能在面试或答辩中讲清楚这个项目。
请生成偏架构、流程和设计取舍的学习路线，并创建 .learning-roadmap。
章节重点放在理论、架构位置和源码设计解读，实践任务放在最后。

## 6. 继续下一章

使用 project-rebuild-tutor skill，根据 .learning-roadmap/progress.md 继续下一章。
请先输出本章导读、核心问题、理论背景和实现思路，再给本次任务和验证方式。

## 7. 更新学习重点

使用 project-rebuild-tutor skill，更新学习路线。
React 基础我已经懂了，后续重点讲 Tauri、系统托盘、本地存储和自动更新。

## Help

查看辅助脚本帮助：

```bash
skills/project-rebuild-tutor/scripts/project_snapshot.sh --help
skills/project-rebuild-tutor/scripts/detect_learning_units.sh --help
skills/project-rebuild-tutor/scripts/generate_roadmap.sh --help
```
