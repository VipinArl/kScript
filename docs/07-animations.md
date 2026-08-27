# 7. Animation Definitions

An animation definition connects an object to an effect:

```
objectName : effectCall(params) { animationProps }
```

```
c = circle(8, 4.5, 2)
c : show()
c : move(4, 0) { startTime: 1s, duration: 2s }
```

### 7.1 Inline Effects

Apply an effect on the same line as the shape definition:

```
c = circle(8, 4.5, 2) : show()
r = rectangle(3, 2, 4, 3) : draw() { duration: 2s }
```

---


## 8. Built-in Effects


### `show()`

Makes the object instantly visible. Default duration: 1ms.

```
c : show()
c : show() { startTime: 500ms }
```

### `hide()`

Makes the object instantly invisible. Default duration: 1ms.

```
c : hide() { startTime: 3s }
```

### `draw(clockwise?)`

Animates drawing the shape stroke-by-stroke. Default duration: 3000ms.

| Argument    | Type    | Default | Description                                                         |
| ----------- | ------- | ------- | ------------------------------------------------------------------- |
| `clockwise` | boolean | `true`  | Direction to draw — `true` for clockwise, `false` for anticlockwise |

```
c : draw()                              // clockwise (default)
c : draw(false)                         // anticlockwise
c : draw(true) { duration: 5s, easing: "ease-in-out" }
```

### `undraw(clockwise?)`

Reverse of `draw` — animates erasing the shape. Default duration: 3000ms.

| Argument    | Type    | Default | Description                                                          |
| ----------- | ------- | ------- | -------------------------------------------------------------------- |
| `clockwise` | boolean | `true`  | Direction to erase — `true` for clockwise, `false` for anticlockwise |

```
c : undraw() { startTime: 4s }          // clockwise (default)
c : undraw(false) { startTime: 4s }     // anticlockwise
```

### `move(dx, dy)`

Moves the object by `(dx, dy)` **relative to its current position**. Each chained move starts from where the previous one ended, so serial moves accumulate correctly. Default duration: 3000ms.

```
c : move(4, 0)
c : move(-4, 0) { startTime: 1s, easing: "ease-out-cubic" }
```

A `0` delta on an axis leaves that axis untouched, so two moves on independent axes compose in `parallel` — e.g. `parallel [ move(11, 0) { easing: "linear" }, move(0, 5) { easing: "ease-out-bounce" } ]` travels horizontally at a constant rate while bouncing vertically.

### `move((x, y))` — absolute form

Moves the object to the **fixed canvas position** `(x, y)`, regardless of where it currently is. Pass a parenthesised coordinate pair as a single argument to use this form.

```
c : move((8, 4.5))                               // move to center
c : move((2, 4.5)) { startTime: 1s, duration: 2s }
```

Serial chains using the absolute form always land on the same coordinate even across multiple moves:

```
c = circle(2, 4.5, 1) : show()
c : serial [
  move((8, 4.5)),    // → center
  move((14, 4.5)),   // → right
  move((8, 4.5))     // → center again
]
```

### `scale(sx, sy)`

Scales the object by factors `sx` and `sy` relative to its **current size**. In a serial chain, each scale multiplies from the size reached by the previous animation. Default duration: 3000ms.

```
c : scale(2, 2)
c : scale(0.5, 0.5) { easing: "ease-in-back" }
```

Like `rotate`, `scale` accepts an optional `pivot` point to scale about a fixed canvas point instead of the shape's centre:

```
// Grow outward from the top-left corner at (5, 3)
r : scale(2, 2) { pivot: (5, 3), duration: 1s }
```

A `scale` factor of `1` on an axis is a no-op on that axis, so two scales on independent axes (e.g. `scale(2,1)` and `scale(1,0.3)`) compose in `parallel` instead of overriding each other.

### `scale((sx, sy))` — absolute form

Scales the object to `sx` and `sy` times its **original model size**, ignoring any intermediate animation state. Pass a parenthesised factor pair as a single argument to use this form.

```
c : scale((2, 2))   // always 2× the original, even inside a serial chain
```

Use the absolute form when you need a deterministic final size regardless of what came before in a chain.

```
c = circle(8, 4.5, 1) : show()
c : scale(0.1, 0.1) {duration: 1}

c : serial[
  scale((1.25, 1.25)),
  scale((0.8, 0.8)),
  scale((1, 1))
] {duration: 500}
```

### `rotate(angle)`

Rotates the object by `angle` (in degrees, or use `deg` unit). Default duration: 3000ms.

By default a shape rotates about its own centre. Pass the optional `pivot` property to rotate about a **fixed canvas point** instead — useful for a clock hand, a needle, or a radar sweep whose base should stay put:

```
c : rotate(180deg)
c : rotate(360deg) { duration: 2s, loop: true }

// A hand that pivots about its lower end at (8, 4.5)
hand : rotate(360deg) { pivot: (8, 4.5), duration: 6s, loop: true }
```

### `fadeIn()`

Fades the object from fully transparent to fully visible. Default duration: 3000ms.

The object's opacity increases from 0 to 1 over the animation duration.

```
c = circle(8, 4, 2) : fadeIn()

c : fadeIn() { duration: 2s }
```

### `fadeOut()`

Fades the object from fully visible to fully transparent. Default duration: 3000ms.

The object's opacity decreases from 1 to 0 over the animation duration. Once the animation completes, the object is fully transparent.

```
c = circle(8, 4, 2)
c : fadeOut() { duration: 2s }
c = circle(8, 4, 2)

// fadeIn() and fadeOut() can be combined with serial to create sequential visibility transitions
c = circle(8, 4, 2)
c : serial[
  fadeIn(),
  fadeOut()
]
```

### `morph(props)`

Directly animates any shape property with a formula. See [Section 12](#12-morph) for details.

---


## 9. Animation Properties


These go inside `{}` after an effect call:

| Property    | Type          | Description                                                              |
| ----------- | ------------- | ------------------------------------------------------------------------ |
| `startTime` | unit / number | When the effect starts (e.g., `1s`, `500ms`)                             |
| `endTime`   | unit / number | When the effect ends (alternative to `duration`)                         |
| `duration`  | unit / number | How long the effect runs                                                 |
| `delay`     | unit / number | Extra gap after the previous effect (used in `serial` groups)            |
| `easing`    | string        | Easing curve name — must be a **quoted string**                          |
| `loop`      | boolean       | Whether to repeat the effect                                             |
| `pivot`     | point         | Fixed canvas point a `rotate`/`scale` transforms about (e.g. `(8, 4.5)`) |

```
c : move(6, 0) {
  startTime: 2s,
  duration: 1500ms,
  easing: "ease-out-bounce",
  loop: false
}
```

> `easing` values are quoted strings such as `"ease-out-cubic"`. See the full list in [Section 10](#10-easing-functions).

---


## 10. Easing Functions


Pass as a **quoted string** to the `easing` property.

| Category | Values                                                             |
| -------- | ------------------------------------------------------------------ |
| Linear   | `"linear"`                                                         |
| Basic    | `"ease-in"`, `"ease-out"`, `"ease-in-out"`                         |
| Sine     | `"ease-in-sine"`, `"ease-out-sine"`, `"ease-in-out-sine"`          |
| Quad     | `"ease-in-quad"`, `"ease-out-quad"`, `"ease-in-out-quad"`          |
| Cubic    | `"ease-in-cubic"`, `"ease-out-cubic"`, `"ease-in-out-cubic"`       |
| Quart    | `"ease-in-quart"`, `"ease-out-quart"`, `"ease-in-out-quart"`       |
| Quint    | `"ease-in-quint"`, `"ease-out-quint"`, `"ease-in-out-quint"`       |
| Expo     | `"ease-in-expo"`, `"ease-out-expo"`, `"ease-in-out-expo"`          |
| Circ     | `"ease-in-circ"`, `"ease-out-circ"`, `"ease-in-out-circ"`          |
| Back     | `"ease-in-back"`, `"ease-out-back"`, `"ease-in-out-back"`          |
| Elastic  | `"ease-in-elastic"`, `"ease-out-elastic"`, `"ease-in-out-elastic"` |
| Bounce   | `"ease-in-bounce"`, `"ease-out-bounce"`, `"ease-in-out-bounce"`    |

```
c : move(4, 0) { easing: "ease-out-bounce" }
```

---


## 11. Group Effects


Chain multiple effects on one object using `serial` or `parallel`.

### `serial [ ... ]`

Effects run one after another (each starts when the previous ends).

```
c = circle(8, 4.5, 2)
c : serial [
  show(),
  move(4, 0),
  scale(2, 2)
]
```

### `parallel [ ... ]`

All effects start at the same time.

```
c = circle(8, 4.5, 2)
c : parallel [
  move(4, 0),
  scale(2, 2),
  color(#ff6b6b)
]
```

### Group-level properties

A `{}` block after the group applies to all effects:

```
c : serial [
  show(),
  move(4, 0),
  hide()
] { delay: 200ms }   // 200ms gap inserted between each effect
```

### Overriding individual timings

Override specific effects with explicit `startTime` to mix serial and parallel behaviour:

```
c : serial [
  show(),
  move(4, 0) { startTime: 0 },        // runs at same time as show
  scale(1.5, 1.5) { startTime: 0 }    // also at time 0
]
```

### Nested groups

`serial` and `parallel` can be nested freely:

```
c : serial [
  show(),
  parallel [
    move(4, 0),
    color(#ff6b6b)
  ],
  hide()
]
```

---

