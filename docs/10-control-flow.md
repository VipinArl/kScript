# 14. Conditional Statements

Execute a block based on a condition. The `else` branch is optional. A single statement doesn't need braces.

```
if (condition) {
  ...
} else {
  ...
}
```

```
n = 7
c = circle(8, 4.5, 2)
r = rectangle(5, 3, 6, 3)

if (n > 5) {
  c : draw()
} else {
  r : draw()
}
```

```
// Without braces for single statements
h = 3
if (h > 2) c = circle(8, 4.5, h)
```

---


## 15. For Loops


Iterate over a list or range.

**Single variable:**

```
for item in collection {
  ...
}
```

**With index:**

```
for (item, index) in collection {
  ...
}
```

**Examples:**

```
// Draw circles at evenly-spaced x positions
for x in range(1, 15, 2) {
  c = circle(x, 4.5, 0.5)
  c : draw()
}
```

```
// Staggered entrance using index
shapes = [circle(2, 4.5, 1), circle(6, 4.5, 1), circle(10, 4.5, 1)]
for (s, i) in shapes {
  s : show() { startTime: i * 300ms }
}
```

```
// Comprehension + loop
circles = [circle(x, 4.5, 0.75) for x in range(1, 15, 2)]
for c in circles
  c : draw()
```

```
// Loop with condition
nums = [1, 2, 3, 4, 5, 6, 7, 8]
for (n, i) in nums {
  if (n % 2 == 0) {
    c = circle(n, 4.5, 0.5)
    c : show()
  }
}
```

---


## 16. Event Flow


Define actions that fire in response to user interactions or playback events.

```
on (eventType) { statement }
on (eventType, targetObject) { statement }
```

`targetObject` is optional — when provided, the event is scoped to that object.

### Event Types

| Event          | Trigger                                           |
| -------------- | ------------------------------------------------- |
| `click`        | Mouse click (on targetObject if given)            |
| `hover`        | Mouse hover over targetObject                     |
| `drag`         | Mouse drag on targetObject                        |
| `keypress`     | Any key is pressed                                |
| `time`         | Fires at a specified time                         |
| `animationEnd` | An animation completes (on targetObject if given) |

### Examples

```
r = rectangle(5, 3, 6, 3)
c = circle(8, 4.5, 2)
r : show()

// Click the rectangle to draw the circle
on (click, r) {
  c : draw()
}
```

```
// Chain animations: after r finishes drawing, show c
r : draw()
on (animationEnd, r) {
  c : show()
}
```

```
// Any keypress triggers a pulse
r = rectangle(5, 3, 6, 3) : show()
on (keypress) {
  r : pulse()
}
```

```
// Hover interaction
btn = rectangle(6, 3.5, 4, 2) : show()
on (hover, btn) {
  btn : scale(1.05, 1.05) { duration: 200ms }
}
```

---

