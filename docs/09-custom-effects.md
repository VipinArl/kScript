# 13. Custom Effect Definitions

Define reusable effects with parameters. Parameters can have default values.

```
effectName(param1 = default, param2 = default, ...) {
  animationBody,
  animationBody,
  ...
}
```

- Parameters without a default are required.
- The body contains one or more animation bodies (effects, group effects, morph).
- Unit literals work as default values: `dur = 1s`.

```
// Simple reusable fade-in
fadeIn(dur = 1s) {
  morph[opacity: (T - S) / D] { duration: dur }
}

// Bounce entrance
bounceIn(height = 1, depth = 0.3, dur = 2s) {
  parallel [
    serial [
      move(0, height)          { easing: "ease-out-cubic",   duration: dur * 0.6 },
      move(0, -height * 0.3)   { easing: "ease-in-out-quad", duration: dur * 0.25 },
      move(0, height * 0.05)   { easing: "ease-out",         duration: dur * 0.15 }
    ],
    scale(1 / (1 + depth), 1 / (1 + depth)) { easing: "ease-out-cubic" }
  ]
}

c = circle(8, 4.5, 2)
c : bounceIn()
c : bounceIn(2, 0.5, 3s)
```

```
// Pulse (scale up and back)
pulse(amount = 1.2, dur = 500ms) {
  serial [
    scale(amount, amount) { duration: dur / 2 },
    scale(1, 1)           { duration: dur / 2 }
  ]
}

r = rectangle(5, 3, 6, 3) : show()
r : pulse()
r : pulse(1.5, 1s)
```

---

