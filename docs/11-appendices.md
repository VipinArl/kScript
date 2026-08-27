# Appendices

## Appendix A: Complete Shape Property Reference


### A.1 Visual properties (all shapes)

| Property    | Shapes                             | Type    | Default                       |
| ----------- | ---------------------------------- | ------- | ----------------------------- |
| `color`     | all                                | color   | depends on shape              |
| `fillColor` | circle, rectangle, arc, earc, path | color   | —                             |
| `fill`      | circle, rectangle, arc, earc, path | boolean | false (true if fillColor set) |
| `lineWidth` | all                                | number  | 1                             |
| `opacity`   | all                                | number  | 1.0                           |
| `visible`   | all                                | boolean | true                          |

### A.2 Shape-specific animatable properties (for use with `morph`)

| Shape    | Property     | Description                              |
| -------- | ------------ | ---------------------------------------- |
| `circle` | `radius`     | Circle radius                            |
| `arc`    | `radius`     | Arc radius                               |
| `arc`    | `startAngle` | Start angle (radians, stored internally) |
| `arc`    | `endAngle`   | End angle (radians, stored internally)   |
| `earc`   | `radiusX`    | Horizontal radius                        |
| `earc`   | `radiusY`    | Vertical radius                          |
| `earc`   | `startAngle` | Start angle (degrees)                    |
| `earc`   | `endAngle`   | End angle (degrees)                      |
| `text`   | `text`       | Text content                             |

## Appendix B: All Arithmetic Constants

| Constant | Meaning                                |
| -------- | -------------------------------------- |
| `PI`     | 3.14159265…                            |
| `TAU`    | 6.28318530… (2π)                       |
| `E`      | 2.71828182…                            |
| `@`      | Infinity                               |
| `#`      | NaN                                    |
| `T`      | Current animation time (morph runtime) |
| `D`      | Effect duration (morph runtime)        |
| `S`      | Effect start time (morph runtime)      |

## Appendix C: Grammar Summary

```
program            ← statement*
statement          ← CanvasDefinition | AssignmentStatement | animationDefinition
                   | effectDefinition | conditionalStatement | iterativeStatement
                   | eventFlow

CanvasDefinition   ← 'canvas' '{' optionalProps '}'
AssignmentStatement ← Identifier '=' (expression | groupDefinition)
groupDefinition    ← 'group' '[' invocationExpression (',' invocationExpression)* ']'
animationDefinition ← Identifier ':' animationBody
animationBody      ← morphDef | effect | groupEffect
morphDef           ← 'morph' '[' objectProp ':' expression (',' objectProp ':' expression)* ']' ('{' optionalProps '}')?
effect             ← Identifier '(' argList ')' ('{' optionalProps '}')?
groupEffect        ← ('serial' | 'parallel') '[' (animationBody (',' animationBody)*)? ']' ('{' optionalProps '}')?
effectDefinition   ← Identifier '(' paramList ')' '{' animationBody (',' animationBody)* '}'
conditionalStatement ← 'if' '(' expression ')' statementBlock ('else' statementBlock)?
iterativeStatement ← 'for' (Identifier | '(' Identifier ',' Identifier ')') 'in' expression statementBlock
eventFlow          ← 'on' '(' eventType (',' Identifier)? ')' statementBlock
eventType          ← 'click' | 'hover' | 'drag' | 'keypress' | 'time' | 'animationEnd'
```

---

## Appendix D: Language Improvement Suggestions

These are features not yet in the language that would increase expressiveness or ergonomics:

**String interpolation:** Currently `text("Score: 0", 8, 5)` cannot embed a variable. Something like `"Score: ${score}"` would make dynamic text labels possible without a workaround.

**Property reading:** There is no way to read a shape's current property (e.g., `c.x`, `c.radius`). This would enable reactive animations and conditional logic based on object state.

**List length:** `items.length` or `len(items)` would make loops and comprehensions more self-contained.

**Ternary expression:** `condition ? a : b` would reduce verbose if/else blocks in expressions, particularly useful inside morph formulas.

**Repeat count for effects:** `{ repeat: 3 }` to run an effect N times instead of boolean `loop`. Could be `{ loop: 3 }` as an integer form.

**Import / include:** `import "helpers.ks"` to split large scripts into reusable files and share custom effect libraries.

---

## Appendix E: Proposed Math-Animation Capabilities (Roadmap)

> ⚠️ **None of the features in this appendix are implemented yet.** They are a design sketch of where kScript is headed as a _math-based_ animation language. Syntax shown here is provisional and may change. Items are ordered roughly by impact-to-effort, best first.

### E.4 Vectors / arrows

An arrow primitive with a head — for vectors, gradients, forces, and "this maps to that" diagrams.

```
// Proposed: arrow from tail to head
v = arrow((8, 4.5), (12, 6)) { color: #e17055, headSize: 0.3 }
v : draw() { duration: 800ms }
```

All standard transforms apply; `draw()` grows the shaft then pops the head.

### E.5 Trace-along-path effect

Animate a point (or any shape) traveling **along** a curve as it is drawn — the signature "watch the graph being generated" move.

```
// Proposed: a dot rides the sine wave while it draws
w   = curve("sin(2*x)", [1, 15], (1, 4.5)) { scale: 2 }
dot = circle(0, 0, 0.2) { fillColor: #fdcb6e }

w   : draw()              { duration: 3s }
dot : trace(w)            { duration: 3s }   // dot follows w's sampled points
```

Reuses the curve's already-sampled point list; the tracer just looks up position by progress.

### E.6 Dynamic text — string interpolation and animated counters

`text()` is currently static. Two related additions make on-screen values possible (counts, accumulating integrals, live readouts):

```
// Proposed: string interpolation
score = 0
t = text("Score: ${score}", 8, 1)

// Proposed: an animated numeric value that updates a label
n = counter(0, 100) { duration: 2s, easing: "ease-out-cubic" }
label = text("Count: ${n}", 8, 4.5)
```

### E.7 Smaller expression-level ergonomics

These are not math-specific but are felt constantly once scripts grow:

| Feature            | Proposed syntax               | Benefit                                     |
| ------------------ | ----------------------------- | ------------------------------------------- |
| Ternary            | `cond ? a : b`                | Cleaner `morph` formulas and inline choices |
| List length        | `len(items)` / `items.length` | Self-contained loops and comprehensions     |
| Property reading   | `c.radius`, `c.x`             | Reactive logic based on current shape state |
| Integer loop count | `{ loop: 3 }`                 | Run an effect N times, not just on/off      |

### E.8 Heavier items (deliberately post-alpha)

- **LaTeX / equation rendering** — `equation("\\int_0^1 x^2 dx", x, y)` via KaTeX/MathJax. Core to math explainers eventually, but a heavy dependency and a sub-project on its own.
- **Calculus helpers** — `tangent(curve, x)`, `riemann(curve, n)`, area-under-curve shading.
- **Import / include** — `import "helpers.ks"` for shared effect libraries (also listed in Appendix D).
