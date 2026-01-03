# WUFF Orchestrator - Technical Implementation Project

## Project Overview
This is the main technical implementation project for **WuffUniversuM OS** - a comprehensive AI-powered orchestration system.

## Project Purpose
- Design and implement WUFF Orchestrator architecture
- Build custom sub-agent system with specialized agents
- Integrate MCP (Model Context Protocol) servers for memory and tools
- Create technical infrastructure for AI-driven task orchestration

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
Building the foundational orchestrator system with basic sub-agent delegation capabilities.
