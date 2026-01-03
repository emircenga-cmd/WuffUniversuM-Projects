# Connecting Claude Code & Gemini CLI via MCP

This document details how to implement the **Model Context Protocol (MCP)** to allow Claude Code (acting as the main agent) to utilize Gemini CLI (acting as a specialized sub-agent).

## 🚀 The Architecture

**Claude Code (Client)** ➡️ **MCP Server (Python)** ➡️ **Gemini CLI (Tool)**

*   **Claude Code:** Orchestrates the workflow and talks to the user.
*   **MCP Server:** A bridge script that exposes Gemini's capabilities as function calls.
*   **Gemini CLI:** Executes the specific sub-agent personas defined in your `.gemini/commands/` folder.

---

## 1. Prerequisites

You need Python installed and the `fastmcp` library (the standard for building MCP servers quickly).

```bash
pip install fastmcp
```

Ensure `gemini` is installed and available in your system PATH (`npm install -g @google/gemini-cli`).

---

## 2. The Bridge Script (`gemini_mcp_bridge.py`)

Create this file in your project or a central tools directory.

```python
from fastmcp import FastMCP
import subprocess
import os

# Initialize the MCP Server
mcp = FastMCP("Gemini Sub-Agent Bridge")

@mcp.tool()
def ask_gemini_subagent(task: str, role: str = "general", context_files: str = "") -> str:
    """
    Delegates a task to the Gemini CLI agent with a specific role.

    Args:
        task: The specific instruction or question for Gemini.
        role: The persona to adopt. Options: 'architect', 'coder', 'review', 'general'.
              (Must correspond to your .gemini/commands/*.toml files)
        context_files: Optional list of files to read, formatted as '@file1 @file2'.
    """
    
    # Map roles to Gemini Custom Commands
    # If role is 'general', we don't use a slash command
    command_flag = f"/{role}" if role != "general" else ""
    
    # Construct the full shell command
    # Structure: gemini /role -p "Task context" --no-stream
    # We use --no-stream to ensure we capture the full output at once
    full_command = f'gemini {command_flag} -p "{task} {context_files}"'
    
    print(f"🤖 Claude is calling Gemini as: {role}...")
    
    try:
        # Execute the command
        result = subprocess.run(
            full_command, 
            shell=True, 
            capture_output=True, 
            text=True,
            encoding='utf-8' # Ensure UTF-8 for special characters
        )
        
        if result.returncode != 0:
            return f"❌ Gemini Error:\n{result.stderr}"
            
        return f"✅ Gemini ({role}) Response:\n\n{result.stdout}"

    except Exception as e:
        return f"❌ System Error executing Gemini: {str(e)}"

# Entry point for the MCP server
if __name__ == "__main__":
    mcp.run()
```

---

## 3. Configuring Claude Code

You need to tell Claude Code about this new server. Locate your Claude configuration file (typically `claude_config.json` or passed via flags depending on your environment setup).

If you are running Claude via a wrapper or environment that supports `mcpServers` config:

```json
{
  "mcpServers": {
    "gemini-bridge": {
      "command": "python",
      "args": ["/absolute/path/to/gemini_mcp_bridge.py"]
    }
  }
}
```

*Note: Replace `/absolute/path/to/` with the actual path.*

---

## 4. How to Use It (Workflow)

Once configured, you can talk to Claude normally, but now you can explicitly ask it to delegate tasks.

**Scenario 1: Architecture Review**
> **User:** "Claude, I want to build a new microservice. Please ask the **architect** sub-agent to outline the folder structure first."
>
> **Claude (Internal Thought):** *I have a tool `ask_gemini_subagent`. I will call it with `task="outline folder structure"` and `role="architect"`.*
>
> **Gemini (via Bridge):** Loads `architect.toml`, generates the structure, returns text.
>
> **Claude:** "Here is the structure proposed by the Gemini Architect..."

**Scenario 2: Double Check Code**
> **User:** "I wrote this function. Ask the **reviewer** to check it for security holes."
>
> **Claude:** Calls `ask_gemini_subagent(task="Check for security holes", role="review", context_files="@src/auth.ts")`.

---

## 5. Best Practices

1.  **Keep Prompts Atomic:** When Claude calls Gemini, the task should be specific (e.g., "Write a regex for email", not "Build the whole app").
2.  **Shared Context:** Use the `context_files` argument to pass file references (`@filename`) so Gemini can read the actual files.
3.  **Error Handling:** If Gemini fails, the bridge script returns the error as text so Claude can decide what to do (retry or inform user).
4.  **Cost Management:** Remember that you are now running TWO models. Use Gemini Flash for the sub-agent roles (via `gemini -m gemini-2.0-flash` in the script) to keep costs near zero.
