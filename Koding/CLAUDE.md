# Koding - WuffUniversuM OS Development Project

## Project Overview
This is the **development and technical support** repository for **WuffUniversuM OS**.

**Important:** This is NOT the final orchestrator - this is where we BUILD it and provide technical support.

## Project Purpose
- 🔬 Research and design WUFF Orchestrator architecture
- 🛠️ Develop and test custom sub-agent systems
- 📚 Create comprehensive technical documentation
- 🧪 Experiment with MCP (Model Context Protocol) integration
- 💡 Build knowledge base for future orchestrator implementation
- 🔧 Provide ongoing technical support infrastructure

## Key Components

### 1. Sub-Agent System
Located in `.claude/agents/`:
- Business Analyst Agent
- Research Specialist Agent
- Documentation Writer Agent
- Code Implementation Agent
- (More agents as needed)

### 2. MCP Servers
Located in `MCPs/`:
- **basic-memory**: File-based memory server for persistent context across sessions

### 3. Documentation
Located in `docs/`:
- WUFF Master Blueprint
- Implementation Checklist
- ClickUp Structure Analysis
- Project Memory

## Architecture
This project implements a custom orchestrator pattern where:
1. Main orchestrator analyzes tasks and delegates to specialized sub-agents
2. Each sub-agent has domain expertise and dedicated system prompts
3. MCP servers provide persistent memory and tool capabilities
4. Hooks enable custom workflows and automation

## Development Approach
- Iterative development with Claude Code
- Documentation-first design
- Git version control
- Integration with Obsidian vault for knowledge management

## Related Resources
- Obsidian Vault: `C:\WuffUniversuM\Basic Memory i Obsidian\WuffUniversuM Vault\`
- Documentation: See `docs/` folder

## Current Focus
**Phase 1: Development Infrastructure**
- Setting up development environment and tools
- Creating architectural blueprints and documentation
- Researching orchestrator patterns and sub-agent systems
- Building proof-of-concept implementations

**Phase 2: Future - Orchestrator Implementation**
- The actual WuffUniversuM Orchestrator will be a separate project
- This repository will provide technical support and ongoing development
