# 12. Morph

`morph` has two distinct forms: **property morph** animates scalar properties of a shape using a time-based formula; **shape morph** smoothly transforms one shape into another.

---

### 12.1 Property Morph

Animates any shape property using a time-based formula. The expression can reference `T` (current time), `S` (start time), and `D` (duration).

```
objectName : morph[ propName: expression ] { animationProps }
```

```
c = circle(8, 4.5, 2)

// Fade in: opacity goes from 0 to 1
c : morph[opacity: (T - S) / D]

// Fade out over 2 s starting at 3 s
c : morph[opacity: 1 - (T - S) / D] { startTime: 3s, duration: 2s }

// Shrink radius from 2 → 0
c : morph[radius: 2 * (1 - (T - S) / D)] { duration: 1500ms }

// Animate multiple props simultaneously
c : morph[
  opacity: (T - S) / D,
  radius: lerp(0.5, 2, (T - S) / D)
]
```

Property morph can be used inside a custom effect definition (see Section 13):

```
fadeIn(dur = 1s) {
  morph[opacity: (T - S) / D] { duration: dur }
}
c = circle(8, 4.5, 2)
c : fadeIn()
c : fadeIn(2s)
```

---

### 12.2 Shape Morph

Smoothly transforms the geometry of one shape into another. The source shape's outline is interpolated point-by-point into the destination shape's outline over the animation duration.

```
sourceShape : morph[shape: destShape] { animationProps }
```

| Behaviour            | Detail                                                                                  |
| -------------------- | --------------------------------------------------------------------------------------- |
| During morph         | Source is replaced by an animated path that flows from source geometry to dest geometry |
| On completion        | Source is hidden; destination is revealed in its final state                            |
| Destination `show()` | Not needed — shape morph reveals the destination automatically                          |
| Easing               | All standard easing curves apply                                                        |

Works with any combination of `rectangle`, `circle`, and `path` as source or destination.

```
a = rectangle(3, 2, 6, 5) { color: #6c5ce7, lineWidth: 1 }
b = circle(8, 4.5, 2.5) { color: #00b894, lineWidth: 1 }

a : show()
a : morph[shape: b] { startTime: 1s, duration: 2s }
```

```
// With easing
a = rectangle(2, 3, 4, 3) { color: #e17055 }
b = circle(12, 4.5, 2) { color: #74b9ff }

a : show()
a : morph[shape: b] { startTime: 500ms, duration: 2s, easing: "ease-in-out-cubic" }
```

```
// Morph between paths
tri = path(true, 8, 1, 14.5, 8, 1.5, 8) { color: #fdcb6e }
star = path(true, 8,1, 9.5,4, 13,4, 10.5,6.5, 11.5,9.5, 8,7.5, 4.5,9.5, 5.5,6.5, 3,4, 6.5,4) { color: #e84393 }

tri : show()
tri : morph[shape: star] { startTime: 1s, duration: 2.5s, easing: "ease-in-out-back" }
```

> **Tip:** The destination shape's visual properties (color, fill, line width) are independent of the morph. Style the destination shape to what you want it to look like after the morph completes.

---

