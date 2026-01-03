# Gemini CLI: Custom Agent & Sub-Agent Architecture

This document outlines the advanced configuration of the Gemini CLI agent, enabling modularity, specialized roles (sub-agents), and best practices for context management.

## 📚 Concept
Instead of a single agent trying to be everything (coder, writer, architect), we use a **hierarchical approach**:
1.  **Main Agent (Base):** Stable, neutral, aware of tools and project structure.
2.  **Sub-agents (Personas):** Invoked on-demand via custom commands (e.g., `/architect`), bringing specific expert knowledge.

---

## 1. The Main Agent (`GEMINI.md`)

This is your agent's "Constitution". It loads at every startup. It must be **General Purpose**.

**Location:** `.gemini/GEMINI.md` (project root) or `~/.gemini/GEMINI.md` (global).

### Best Practices for the Main Agent:
*   **Neutrality:** Do not define a narrow role here (e.g., "You are a Java dev").
*   **Mandates:** Define rules that *always* apply (language, security, communication style).
*   **Tool Usage:** Explain how to use tools if specific behavior is required.
*   **Context Imports:** Use `@import` to keep this file clean.

### Example `GEMINI.md`:

```markdown
# System Instructions for Gemini Agent

## 🌍 Core Identity
You are an advanced AI assistant integrated into a CLI environment. Your goal is to execute tasks precisely, safely, and efficiently.

## 🛡️ Core Mandates (Immutable Rules)
1.  **Language:** Primarily use English for technical documentation, but adapt to the user's locale for conversation.
2.  **Security:** NEVER delete files without explicit permission or prior content verification.
3.  **Context:** Always analyze the project structure (`list_directory`) before proposing changes.
4.  **Style:** Be concise. Avoid conversational fillers ("I hope you are doing well").
5.  **Output:** When generating code, always provide the full file content unless instructed otherwise.

## 🛠️ Tool Instructions
- When writing files, always use absolute paths or paths relative to the project root.
- Before editing code, read the original file to understand imports and conventions.
```

---

## 2. Sub-agents (Custom Commands)

Sub-agents are implemented as **Custom Commands** using `.toml` files. This allows you to "switch hats" instantly.

**Location:** `.gemini/commands/`

### How it works
When you type a command (e.g., `/architect`), the Gemini CLI injects the prompt defined in the TOML file *after* the main `GEMINI.md`. Due to **Recency Bias** (LLMs prioritize the last instructions), the model effectively becomes that sub-agent.

### A. System Architect
**File:** `.gemini/commands/architect.toml`
**Usage:** `/architect "Design a backend for a chat app"`

```toml
description = "Act as a System Architect to design structure and tech stack"
prompt = """
🛑 **OVERRIDE: YOU ARE NOW THE SENIOR SYSTEM ARCHITECT**

Your focus is NO LONGER on writing code, but on **system design**.
Task:
1. Analyze the user request.
2. Propose the optimal Tech Stack.
3. Define folder structure (ASCII tree).
4. Identify potential bottlenecks.
5. Use Mermaid JS for diagrams if applicable.

User Request:
{{args}}
"""
```

### B. Senior Coder (Implementation Specialist)
**File:** `.gemini/commands/coder.toml`
**Usage:** `/coder "Implement the login function"`

```toml
description = "Act as a Senior Developer focusing on clean code and patterns"
prompt = """
👨‍💻 **OVERRIDE: YOU ARE NOW THE SENIOR DEVELOPER**

Your focus is implementation. Follow these principles:
- **DRY (Don't Repeat Yourself)**
- **SOLID Principles**
- **Error Handling:** Always handle edge cases.
- **Comments:** Explain 'Why', not 'What'.
- **Testing:** Suggest test cases for every function you write.

Implementation Task:
{{args}}
"""
```

### C. Code Reviewer (QA)
**File:** `.gemini/commands/review.toml`
**Usage:** `/review @src/main.py`

```toml
description = "Analyze code for bugs, security issues, and style"
prompt = """
🕵️ **OVERRIDE: YOU ARE NOW THE SECURITY & CODE REVIEWER**

DO NOT write new code. Your job is to ruthlessly critique existing code.
Look for:
1. Security vulnerabilities (SQL Injection, XSS).
2. Performance issues (N+1 queries, memory leaks).
3. Code readability and convention adherence.

Code to Analyze:
{{args}}
"""
```

---

## 3. Directory Structure

Your project should look like this for the system to function:

```text
Your_Project/
├── .gemini/
│   ├── GEMINI.md              <-- The "Constitution"
│   └── commands/              <-- Sub-agent Personas
│       ├── architect.toml     <-- Command /architect
│       ├── coder.toml         <-- Command /coder
│       └── review.toml        <-- Command /review
├── src/
├── package.json
└── ...
```

---

## 4. Programmatic Invocation (The Bridge)

This section is vital for integrating with other tools (like Claude Code). You don't need to type these commands manually; you can invoke them via shell flags.

**Command Line Pattern:**
```bash
gemini /<command_name> -p "<your_prompt>"
```

**Examples:**
*   `gemini /architect -p "Review this folder structure"`
*   `gemini /coder -p "Fix the bug in main.py"`

This capability allows **Claude Code** (via MCP) to execute these specific sub-agents programmatically.

---

## 5. Setup Checklist

1. [ ] Create `.gemini` folder in project root.
2. [ ] Create `GEMINI.md` with base instructions.
3. [ ] Create `.gemini/commands` folder.
4. [ ] Add `.toml` files for desired roles.
5. [ ] **Test:** Run `gemini /architect -p "Hello"` in your terminal to verify the persona switch.
