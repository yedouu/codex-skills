# project-business-mapper 帮助

## Purpose

`project-business-mapper` 用于从业务视角拆解本地或在线代码项目，尤其适合快速理解 GitHub 仓库的业务目标、核心问题、业务角色、领域对象、核心流程、状态机、业务规则、异常场景和关键业务思想。

它默认生成 `.business-understanding/` 业务理解文档，并且在聊天窗口只输出先导性摘要。

## Supported Modes

本地项目模式：

- `overview`：全项目业务拆解，适合刚接手项目。
- `module`：单模块业务拆解，例如订单、支付、AI 回复、定位、任务调度、权限模块。
- `flow`：单业务流程拆解，例如下单、支付回调、消息回复、文件审核、任务创建到完成。
- `state-machine`：状态机提取，例如订单状态、任务状态、会话状态、机器人状态、AI 回复状态。
- `rules`：业务规则提取，找出最不能改错的约束。
- `interview`：面试 / 答辩表达，生成能讲清项目的业务介绍。
- `change-impact`：需求变更影响分析，可结合当前 git diff。
- `pm-view`：产品经理视角，强调用户价值、业务路径、体验和风险。
- `engineer-handoff`：工程师接手视角，强调高风险模块、规则、测试重点和踩坑点。

在线仓库模式：

- `lightweight-remote`：轻量远程分析，只读取 README、docs、manifest、目录结构、关键文件列表和少量核心源码文件。
- `full-remote`：完整远程分析，在用户允许或明确要求时浅克隆仓库，再按本地项目分析。
- `scoped-remote`：远程子目录分析，只分析仓库中的某个目录。
- `remote-interview`：在线仓库面试 / 答辩表达。
- `remote-change-impact`：在线仓库需求变更影响分析。

## Options

- `--repo <url>`：指定在线仓库 URL。
- `--branch <name>`：指定分支或 tag。
- `--scope <path>`：限定本地目录、模块，或只分析仓库中的某个目录。
- `--mode <mode>`：选择本地分析模式，默认 `overview`。
- `--remote-mode lightweight|full|scoped|interview|change-impact`：选择远程分析模式。
- `--no-clone`：只通过远程读取进行轻量分析，不 clone。
- `--clone-depth <n>`：设置浅克隆深度，默认 `1`。
- `--output-dir <path>`：指定业务理解文档输出目录，默认 `.business-understanding/`。
- `--no-files`：只在聊天中输出摘要，不创建文件。
- `--refresh`：重新生成业务理解文档。
- `--diff`：结合当前 git diff 分析业务影响。
- `-h` / `--help`：显示帮助。帮助模式不会扫描项目、读取远程仓库、clone、创建文件或修改任何内容。

## Output Formats

默认输出目录：

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

聊天窗口默认只输出：

1. 项目业务一句话定位；
2. 核心业务主线；
3. 最重要的业务对象；
4. 最重要的业务思想；
5. 已生成的文档列表；
6. 建议下一步；
7. 使用量报告。

分析在线仓库时，摘要还必须包含：

```markdown
## 分析来源

- 仓库：
- 分支 / tag：
- 分析范围：
- 远程分析模式：
- 是否 clone：
- 输出目录：
- 分析深度说明：
```

如果是轻量远程分析，必须说明：

`本次为轻量远程分析，主要基于 README、目录结构和少量关键文件。部分业务结论可能需要进一步阅读源码或运行项目确认。`

## Common Examples

```text
使用 project-business-mapper skill，以 overview 模式分析当前项目。
请从业务视角拆解项目，生成 .business-understanding 文档。
不要修改业务代码。
```

```text
使用 project-business-mapper skill，以 module 模式分析 src/ai 模块。
请提取该模块的业务目标、核心对象、流程、规则和异常场景。
```

```text
使用 project-business-mapper skill，以 flow 模式分析：
用户发送消息后 AI 回复的业务流程。
请输出角色、输入、状态变化、异常分支和业务规则。
```

```text
使用 project-business-mapper skill，以 state-machine 模式分析订单状态流转。
请输出状态列表、允许转移、禁止转移、风险点和源码映射。
```

```text
使用 project-business-mapper skill，以 interview 模式分析当前项目。
请生成我可以在面试或答辩中讲的业务介绍、核心流程、难点和亮点。
```

```text
使用 project-business-mapper skill，以 change-impact 模式分析：
我要修改取消订单逻辑，会影响哪些业务规则和状态机？
请不要修改代码，只做业务影响分析。
```

```text
project-business-mapper --help
```

```text
project-business-mapper --repo https://github.com/owner/repo --remote-mode lightweight
```

```text
project-business-mapper --repo https://github.com/owner/repo --remote-mode full --clone-depth 1
```

```text
project-business-mapper --repo https://github.com/owner/repo --scope packages/server --remote-mode scoped
```

```text
project-business-mapper --repo https://github.com/owner/repo --remote-mode interview --no-files
```

## Safety Rules

本地项目安全规则：

- 不修改业务代码。
- 不安装依赖。
- 不运行危险命令。
- 不扫描大型目录。
- 不把所有代码一次性读完。
- 不读取第三方库内部代码作为项目业务。
- 不编造业务角色、流程、规则或结论。

在线仓库安全规则：

- 不修改远程仓库。
- 不创建 commit。
- 不 push。
- 不创建 pull request。
- 不修改远程文件。
- 不泄露私有仓库内容。
- 不下载大型二进制文件。
- 不分析 `node_modules`、`dist`、`build`、`target`、`vendor` 等大型目录。
- 不扫描或输出密钥、token、证书、私钥、凭据等敏感文件内容。
- 如果发现 `.env`、`secret`、`key`、`pem`、`credentials` 等敏感文件，只记录“存在敏感配置文件”，不要输出具体内容。
- 如果远程仓库无法访问，必须明确说明原因，而不是编造结果。
- 如果仓库过大，必须建议用户指定 `--scope`。
- 如果只读取了 README 和目录结构，必须明确说明分析深度有限。

无法确认时必须标注：`根据目录结构推断`、`需要进一步阅读源码确认`、`需要运行项目确认` 或 `需要业务方确认`。

Help 模式只输出帮助，不扫描项目、不读取远程仓库、不 clone、不创建文件、不修改任何内容。
