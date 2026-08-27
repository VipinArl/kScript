# 6. Groups

A `group` bundles multiple shapes defined inline into a single animation target. All standard effects (`move`, `scale`, `rotate`, `draw`, `show`, `hide`, `morph`) work on a group just as they do on a single shape.

### 6.1 Syntax

```
name = group [ shape1(params), shape2(params), ... ]
```

Members are defined inside `[ ]` using the same constructor syntax as standalone shapes. They can carry `{ props }` and inline `: effect` notation.

```
logo = group [
  circle(8, 4.5, 3)          { color: #6c5ce7 },
  rectangle(6.5, 3, 3, 3)    { color: #00b894 }
]
logo : draw()
```

### 6.2 Rigid-body transform behaviour

`scale` and `rotate` treat the group as a **rigid body** — all positions are computed relative to the **bounding-box centre** of the group, so the layout is preserved exactly:

- **`move(dx, dy)`** — every member shifts by the same `(dx, dy)`. The relative positions of members do not change.
- **`scale(sx, sy)`** — every member's size is scaled, and its position moves outward/inward from the group bounding-box centre proportionally, so spacing grows or shrinks uniformly.
- **`rotate(angle)`** — every member spins in place _and_ its position orbits the group bounding-box centre by the same angle, so the whole group rotates like a single object.

```
// Three shapes arranged around centre
dial = group [
  circle(8, 4.5, 0.3)   { color: #dfe6e9 },
  rectangle(7.8, 2, 0.4, 2.5) { color: #fdcb6e }
]
dial : show()
dial : rotate(360deg) { duration: 3s, loop: true }
```

### 6.3 Members are anonymous

Shapes inside a `group [ ]` do not get their own named variables — they cannot be individually targeted by later animation definitions. If you need to animate members independently after a group animation, define them as named variables first and animate them individually from that point.

### 6.4 Inline effects on members

Each member can have an inline `: effect` applied at definition time. These fire independently of the group-level effects.

```
burst = group [
  circle(5, 4.5, 1) : draw(),
  circle(11, 4.5, 1) : draw() { startTime: 500ms }
]
burst : move(0, -2) { startTime: 1s, duration: 2s }
```

### 6.5 Combining with serial and parallel

Groups can be used with `serial` and `parallel` blocks just like individual shapes:

```
card = group [
  rectangle(5, 2.5, 6, 4) { fillColor: #2d3436 },
  text("Hello", 8, 4.5)   { color: #ffffff }
]
card : serial [
  show(),
  move(0, -1) { duration: 500ms, easing: "ease-out-cubic" },
  scale(1.05, 1.05) { duration: 300ms }
]
```

---

