# Koding - Development & Technical Support Project

**Development and technical support infrastructure for WuffUniversuM OS**

## Project Overview

This is the **development and technical support** repository for building the WuffUniversuM Orchestrator system.

**What is this project:**
- 🛠️ Development environment for creating WuffUniversuM OS components
- 📚 Technical documentation and architecture blueprints
- 🔧 Testing ground for orchestrator patterns and sub-agent systems
- 💡 Knowledge base and support infrastructure

**What this is NOT:**
- ❌ This is NOT the final WuffUniversuM Orchestrator (that will be a separate project)
- ❌ This is NOT production code - it's for development and experimentation

**Goal:** Use this project to BUILD the orchestrator system, then provide ongoing technical support.

## Project Structure

```
Koding/
├── .claude/
│   ├── agents/          # Sub-agent definitions (Business Analyst, Research, etc.)
│   ├── hooks/           # Custom workflow automation
│   ├── skills/          # Domain-specific skills
│   └── settings.local.json
├── docs/
│   ├── WUFF-MASTER-BLUEPRINT-v1.0.md         # System architecture
│   ├── WUFF-IMPLEMENTATION-CHECKLIST.md      # Implementation guide
│   ├── PROJECT_MEMORY.md                     # Project context
│   └── CLICKUP-STRUCTURE-ANALYSIS.md         # ClickUp integration
├── .gitignore
├── CLAUDE.md            # Claude Code project context
└── README.md            # This file
```

## Key Features

### 1. **Custom Sub-Agent System**
- Specialized agents for different domains (business analysis, research, documentation, coding)
- Each agent has its own system prompt and expertise area
- Orchestrator delegates tasks to appropriate sub-agents

### 2. **MCP Integration**
- **basic-memory** server for persistent context across chat sessions
- Located globally at: `C:\Claude Code Projects\MCPs\basic-memory\`

### 3. **Documentation-First Approach**
- Comprehensive blueprints and checklists in `docs/` folder
- Integrated with Obsidian vault for knowledge management

## External Resources

- **Obsidian Vault**: `C:\WuffUniversuM\Basic Memory i Obsidian\WuffUniversuM Vault\`
- **MCP Servers**: `C:\Claude Code Projects\MCPs\`

## Getting Started

1. Open this project folder in Claude Code
2. Ensure basic-memory MCP server is running
3. Review documentation in `docs/` folder
4. Start implementing sub-agents in `.claude/agents/`

## Development Workflow

- **Claude Code**: Primary development tool
- **Git**: Version control (this repo)
- **Obsidian**: Documentation and knowledge management
- **MCP**: Persistent memory across sessions

## Current Status

🚧 **In Development** - Setting up foundational orchestrator architecture

## Notes

This project consolidates all previous scattered WUFF development work into a single, organized repository for easier maintenance and collaboration.
