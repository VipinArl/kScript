# kScript Language Documentation

kScript is a domain-specific language for creating animations and interactive visual compositions. It provides a concise syntax for defining canvas properties, drawing shapes, applying effects, and reacting to user events.

## Documentation Structure

This documentation is organized into the following sections:

| Section | Description |
|---------|-------------|
| [01 - Canvas Definition](docs/01-canvas.md) | Defining the rendering canvas |
| [02 - Comments](docs/02-comments.md) | Single-line and multi-line comments |
| [03 - Variables and Assignment](docs/03-variables.md) | Declaring and assigning values |
| [04 - Shapes](docs/04-shapes.md) | All shape constructors and properties |
| [05 - Expressions](docs/05-expressions.md) | Numbers, units, colors, lists, functions |
| [06 - Groups](docs/06-groups.md) | Bundling shapes into rigid bodies |
| [07 - Animation Definitions](docs/07-animations.md) | Applying effects and animation properties |
| [08 - Morph](docs/08-morph.md) | Property and shape morphing |
| [09 - Custom Effects](docs/09-custom-effects.md) | Defining reusable effects |
| [10 - Control Flow](docs/10-control-flow.md) | Conditionals, loops, and event handling |
| [11 - Appendices](docs/11-appendices.md) | Property reference, grammar, and roadmap |

## Quick Start

```kscript
canvas {
  width: 16,
  height: 9,
  FPS: 60,
  BGColor: #1a1a2e
}

c = circle(8, 4.5, 2) { color: #6c5ce7 }
c : show()
c : move(4, 0) { duration: 2s, easing: "ease-out-cubic" }
```

## License

This documentation is provided for the kScript language.
