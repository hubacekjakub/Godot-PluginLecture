# Tooling in Godot (Editor Plugins + `@tool`)

This lecture shows editor tooling in Godot 4 using a small example plugin called **Randomizer**.

Optionaly download repo: https://github.com/hubacekjakub/Godot-PluginLecture which works as base for this lecture, but its not necessity, tooling can work in any project. 


What it does:
- Adds a **“Randomize”** button to the **2D (Canvas) toolbar**.
- Randomizes the **position** of currently selected nodes (supports `Node2D` and `Control`).
- Provides a small **Randomizer dock** on the **right side** of the 2D editor with **Min Offset / Max Offset**.
- Uses the editor’s **Undo/Redo**, so the operation is undoable.

Official references used throughout:
- `EditorPlugin`: https://docs.godotengine.org/en/stable/classes/class_editorplugin.html
- Making plugins: https://docs.godotengine.org/en/stable/tutorials/plugins/editor/making_plugins.html
- `EditorInterface`: https://docs.godotengine.org/en/stable/classes/class_editorinterface.html
- `EditorSelection`: https://docs.godotengine.org/en/stable/classes/class_editorselection.html
- `EditorUndoRedoManager`: https://docs.godotengine.org/en/stable/classes/class_editorundoredomanager.html

---

## Task 1 — Create the plugin

Godot discovers editor plugins under:

- `res://addons/<plugin_name>/plugin.cfg`

For this demo, the plugin folder is:

- `res://addons/randomizer/`

Task 1 goal (no implementation yet):

- Create a new plugin folder under `res://addons/`.
- Use editor to create plugin and fill basic info

Documentation:

- Plugin structure and setup: https://docs.godotengine.org/en/stable/tutorials/plugins/editor/making_plugins.html
- Plugin lifecycle and capabilities: https://docs.godotengine.org/en/stable/classes/class_editorplugin.html

---

## Task 2 — Add “Randomize” button into the 2D toolbar

In Godot’s editor, plugins can inject controls into built-in editor containers.

Task 2 goal:

- When the plugin is enabled, show a **Randomize** button directly in the **2D editor toolbar**.
- When the plugin is disabled, remove anything the plugin added (to keep the editor clean).

Why this matters:

- This puts the tool where designers already work (2D view), so it feels “native”.

Documentation:

- Editor UI extension points and containers: https://docs.godotengine.org/en/stable/classes/class_editorplugin.html

---

## Task 3 — Write randomization for selected nodes

Task 3 goal:

- Use the editor’s selection system to find which nodes the user currently has selected.
- Apply a randomized position change to those selected nodes.

Key concept:

- Editor plugins can access editor state (like selection) via **EditorInterface**.

Documentation:

- Accessing editor features: https://docs.godotengine.org/en/stable/classes/class_editorinterface.html
- Working with selection: https://docs.godotengine.org/en/stable/classes/class_editorselection.html

---

## Task 4 — Create randomization panel and attach it to 2D editor right side

To keep the tool usable, settings should live in a panel instead of hard-coded values.

Task 4 goal:

- Create a dedicated **scene** that represents your tool’s UI panel.
- Add a **script** to that scene so it can store settings (like min/max) and expose tool behavior.
- Attach that scene as a **dock** on the **right side** of the editor (so it’s always available while working in 2D).

Documentation:

- Docking custom controls in the editor: https://docs.godotengine.org/en/stable/classes/class_editorplugin.html
- Plugin setup and recommended structure: https://docs.godotengine.org/en/stable/tutorials/plugins/editor/making_plugins.html

---

## Bonus 1 — `@tool` without plugins

You don’t always need a full editor plugin to get editor-time functionality.

`@tool` makes a script run in the editor, which is great for:

- Visualizing things for level design (paths, ranges, trajectories).
- Auto-updating helper visuals based on exported properties.

Key practices:

- Use `Engine.is_editor_hint()` to branch editor-only logic.
- Any script you instantiate and call instance methods on should also be `@tool`.
- Be cautious when modifying the editor scene tree.

Official docs:

- Running code in the editor: https://docs.godotengine.org/en/stable/tutorials/plugins/running_code_in_the_editor.html

---

## Bonus 2 — Undo/Redo action (editor-safe tooling)

Tools that modify scenes should integrate with Undo/Redo.

In Godot 4 editor plugins, use `EditorUndoRedoManager`:

1) `undo_redo.create_action("Randomize Positions")`
2) For each node:
   - `undo_redo.add_do_property(node, "position", new_pos)`
   - `undo_redo.add_undo_property(node, "position", old_pos)`
3) `undo_redo.commit_action()`

Why it matters:

- Users expect editor operations to be undoable.
- It reduces risk while experimenting (especially important for tooling demos).

References:

- `EditorUndoRedoManager`: https://docs.godotengine.org/en/stable/classes/class_editorundoredomanager.html
- `UndoRedo`: https://docs.godotengine.org/en/stable/classes/class_undoredo.html
