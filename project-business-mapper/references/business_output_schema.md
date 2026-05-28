# Business Output Schema

## Directory

Default output directory for local projects:

```text
.business-understanding/
```

Default output directory for remote repository analysis:

```text
current-working-directory/.business-understanding/
```

Use `--output-dir <path>` to override.

Expected full document set:

```text
.business-understanding/
  README.md
  business_overview.md
  business_map.md
  roles_and_actors.md
  domain_model.md
  core_flows.md
  state_machines.md
  business_rules.md
  edge_cases.md
  key_insights.md
  technical_mapping.md
  change_impact_notes.md
  interview_summary.md
  glossary.md
  open_questions.md
```

## Required File Content

`README.md`:
- Purpose of the directory.
- Recommended reading order.
- Role of each file.
- How to continue analysis for a module or remote subdirectory.
- How to ask Codex to change code safely using business rules.
- How to refresh documents.

`business_overview.md`:
- One-sentence positioning.
- Served users/systems.
- Problem solved.
- Core business value.
- Core business closed loop.
- Scope boundary.
- Non-goals.
- For remote repositories: repository URL, branch/tag, analyzed scope, remote mode, whether clone was used, and analysis depth.

`business_map.md`:
- Business mainline.
- Mermaid business flow chart.
- Core object relationship diagram.
- Business module distribution.
- Key business dependencies.

`roles_and_actors.md`:
- User roles.
- System roles.
- External systems.
- Each role's goal.
- Participating flows.
- Operations each role can trigger.

`domain_model.md`:
- Core objects.
- Meaning.
- Key fields.
- Lifecycle.
- Relationships.
- Business importance.
- Source locations.

`core_flows.md`:
- Flow name.
- Business purpose.
- Trigger.
- Actors.
- Inputs.
- Preconditions.
- Normal steps.
- State changes.
- Outputs.
- Exception branches.
- Source mapping.
- Test suggestions.

`state_machines.md`:
- State machine name.
- State list and meanings.
- Mermaid transition diagram.
- Allowed transitions.
- Forbidden transitions.
- Trigger conditions.
- Risks.
- Source locations.

`business_rules.md`:
- Rule ID.
- Rule content.
- Reason.
- Consequence if violated.
- Source location.
- Test method.
- Change notes.

`edge_cases.md`:
- Edge case.
- Trigger.
- Current handling.
- Why it is handled that way.
- Consequence if ignored.
- Suggested test.

`key_insights.md`:
- 3-10 key business/product/design ideas.
- Explanation.
- Problem solved.
- Trade-off.
- Transferable lesson.
- Source or flow mapping.

`technical_mapping.md`:
- Business concept to source file mapping.
- Business flow to function/class/module mapping.
- Business-core files.
- Technical glue files.
- Reading priority.
- For remote repositories: mark whether mapping came from remote tree, README, selected source file, or clone.

`change_impact_notes.md`:
- Requirement change notes.
- High-risk objects.
- State machines not to break.
- Rules needing tests.
- Common change risks.

`interview_summary.md`:
- One-line project intro.
- Business background.
- Core flow.
- Key design ideas.
- Difficulties.
- Highlights.
- Improvements.
- Speakable version.

`glossary.md`:
- Business terms.
- Technical terms that affect business understanding.
- Abbreviations.
- Source locations.

`open_questions.md`:
- Currently unconfirmed questions.
- Questions needing runtime verification.
- Questions needing product/business confirmation.
- Low-confidence structural inferences.
- For remote repositories: access limits, files not read, clone not performed, or scope limits.

## Chat Summary Format

Only output a concise Chinese summary:

```markdown
# 业务拆解完成：{项目名}

## 分析来源

- 仓库：
- 分支 / tag：
- 分析范围：
- 远程分析模式：
- 是否 clone：
- 输出目录：
- 分析深度说明：

## 1. 项目业务一句话定位

## 2. 核心业务主线

## 3. 最重要的业务对象

## 4. 最重要的业务思想

## 5. 已生成的业务理解文档

## 6. 建议下一步

## 7. 使用量报告
```

For local analysis, omit `分析来源` unless useful. For remote analysis, always include it.

For lightweight remote analysis, include:

`本次为轻量远程分析，主要基于 README、目录结构和少量关键文件。部分业务结论可能需要进一步阅读源码或运行项目确认。`

## Truth Marking

Use:

- `已由源码确认`
- `根据 README 确认`
- `根据远程目录结构推断`
- `根据目录结构推断`
- `需要进一步阅读源码确认`
- `需要运行项目确认`
- `需要业务方确认`
- `远程仓库无法访问`

Add source path references wherever possible. For remote repositories, source references should include repository path and, when known, branch/tag.
