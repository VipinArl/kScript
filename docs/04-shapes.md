# 4. Shapes

Shapes are the visual building blocks. A shape constructor returns an object that can be animated.

### 4.1 Shape Constructors

| Shape       | Signature                                       | Description                                                                      |
| ----------- | ----------------------------------------------- | -------------------------------------------------------------------------------- |
| `circle`    | `circle(cx, cy, r)`                             | Circle centered at (cx, cy) with radius r                                        |
| `rectangle` | `rectangle(x, y, w, h)`                         | Rectangle at top-left (x, y), size w × h                                         |
| `line`      | `line(x1, y1, dx, dy)`                          | Line from (x1, y1) offset by (dx, dy)                                            |
| `arc`       | `arc(cx, cy, r, startAngle, endAngle)`          | Circular arc — angles in degrees                                                 |
| `earc`      | `earc(cx, cy, rx, ry)`                          | Elliptic arc — radii rx and ry                                                   |
| `earc`      | `earc(cx, cy, rx, ry, startAngle, endAngle)`    | Elliptic arc with angle range — degrees                                          |
| `text`      | `text("content", x, y)`                         | Text label at (x, y)                                                             |
| `image`     | `image("src", x, y, w)`                         | Image at top-left (x, y), width w (height auto)                                  |
| `point`     | `point(x, y)`                                   | Single visible dot                                                               |
| `path`      | `path(closed, x1, y1, x2, y2, ...)`             | Multi-point open or closed path                                                  |
| `curve`     | `curve("expr", [rl, ru], (px, py))`             | Curve y = f(x) sampled from a math expression                                    |
| `curve`     | `curve("xExpr", "yExpr", [rl, ru], (px, py))`   | Parametric curve format.                                                         |
| `polar`     | `polar("expr", [θ1, θ2], (cx, cy))`             | Polar curve r = f(θ) from a math expression                                      |
| `group`     | `group [ shape1(params), shape2(params), ... ]` | Bundle inline shapes into one animation target                                   |
| `axes`      | `axes(xRange, yRange, (ox, oy)) { } [ data ]`   | Graph/number-line with ticks, plus a line/bar chart or plotted shapes (see §4.9) |

> **Coordinate space:** The canvas units match the aspect ratio (default 16 × 9). Origin is top-left.

```
c  = circle(8, 4.5, 2)
r  = rectangle(3, 2, 5, 3)
l  = line(1, 4.5, 14, 0)
a  = arc(8, 4.5, 3, 0, 180)
e  = earc(8, 4.5, 4, 2)
t  = text("Hello", 8, 4.5)
p  = point(8, 4.5)
```

**PointLiteral alternative syntax** — any shape accepting two separate x/y coordinates can receive a `(x, y)` point literal instead. The two forms are equivalent:

```
// 4 individual scalars
l = line(1, 4.5, 14, 0)

// 2 point literals  (each (x, y) counts as one argument)
l = line((1, 4.5), (15, 4.5))
```

For `line` and `rectangle`, the 4-scalar form takes the last two values as a **relative offset / size**, while the 2-PointLiteral form uses **absolute endpoints / corners**:

| Syntax                        | Interpretation                           |
| ----------------------------- | ---------------------------------------- |
| `line(x1, y1, dx, dy)`        | Start (x1, y1) → end (x1+dx, y1+dy)      |
| `line((x1,y1), (x2,y2))`      | Start (x1, y1) → end (x2, y2) — absolute |
| `rectangle(x, y, w, h)`       | Top-left (x, y), size w × h              |
| `rectangle((x1,y1), (x2,y2))` | Corners (x1, y1) and (x2, y2) — absolute |
| `arc(cx, cy, r, s, e)`        | Center (cx, cy)                          |
| `arc((cx,cy), r, s, e)`       | Same — PointLiteral for center           |
| `circle(cx, cy, r)`           | Center (cx, cy)                          |
| `circle((cx,cy), r)`          | Same — PointLiteral for center           |

### 4.2 Arc Shape

`arc` draws a circular arc between two angles (in **degrees**).

```
arc(cx, cy, radius, startAngle, endAngle)
arc((cx, cy), radius, startAngle, endAngle)
```

```
// Semicircle (top half)
a = arc(8, 4.5, 3, 0, 180) { color: #e17055 }
a : show()

// Three-quarter arc
q = arc(8, 4.5, 2, 45, 315) { color: #74b9ff }
q : show()
```

### 4.3 Elliptic Arc (earc)

`earc` draws an elliptic arc using **separate x and y radii**. Angles are in **degrees**.

```
earc(cx, cy, rx, ry)
earc(cx, cy, rx, ry, startAngle, endAngle)
```

| Argument     | Type   | Default | Description                                                         |
| ------------ | ------ | ------- | ------------------------------------------------------------------- |
| `cx`, `cy`   | number | —       | Center of the ellipse                                               |
| `rx`         | number | —       | Horizontal radius                                                   |
| `ry`         | number | rx      | Vertical radius (defaults to rx if omitted when using 4-param form) |
| `startAngle` | number | 0       | Start angle in degrees                                              |
| `endAngle`   | number | 360     | End angle in degrees (full ellipse = 360)                           |

```
// Full ellipse
e = earc(8, 4.5, 5, 2) { color: #6c5ce7 }
e : show()

// Half ellipse
h = earc(8, 4.5, 4, 1.5, 0, 180) { color: #00b894 }
h : show()

// Ellipse with fill
ef = earc(8, 4.5, 3, 2) { fillColor: #ffeaa7, lineWidth: 1 }
ef : show()
```

### 4.4 Group

`group` bundles inline shape definitions into a single animation target. Effects on the group animate all members as a rigid body.

```
name = group [ shape1(params), shape2(params), ... ]
```

Shapes are defined directly inside the `[ ]` block — they are anonymous members and cannot be individually referenced later. Each member can carry its own `{ props }` and inline `: effect` at definition time.

```
pair = group [
  circle(4, 4.5, 1) { color: #e17055 },
  circle(12, 4.5, 1) { color: #74b9ff }
]
pair : show()
pair : move(0, -2) { duration: 1s }
```

**How group effects behave:**

| Effect                             | Behaviour on group members                                                                                           |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| `move`                             | Every member translates by the same `(dx, dy)` delta                                                                 |
| `scale`                            | Every member scales in size; positions also shift proportionally so the group scales around its bounding-box centre  |
| `rotate`                           | Every member spins in place; positions also orbit the group bounding-box centre so the group rotates as a rigid body |
| `draw` / `show` / `hide` / `morph` | Applied identically and independently to each member                                                                 |

```
logo = group [
  rectangle(6, 3, 4, 3) { color: #6c5ce7 },
  circle(8, 4.5, 0.8)   { color: #00b894 }
]
logo : show()
logo : rotate(180deg) { startTime: 1s, duration: 2s }
```

### 4.5 Path Shape

`path` is the only shape that takes a **boolean** as its first argument, followed by any even number of coordinate pairs:

```
path(closed, x1, y1, x2, y2, ...)
```

| Argument | Type    | Description                                                |
| -------- | ------- | ---------------------------------------------------------- |
| `closed` | boolean | `true` — last point connects back to first; `false` — open |
| `x, y`   | numbers | One or more coordinate pairs defining the path vertices    |

**Rules:**

- The total parameter count must be **odd**: one boolean + an even number of coordinates.
- An even total (e.g. `path(false, 10, 20, 30)`) is a compile error: _"coordinates must be paired"_.
- **Single point** `path(closed, x, y)` renders as a filled dot sized by `lineWidth`.
- **Two or more points** render as connected line segments.
- When `closed: true`, the last segment from the final point back to the first is added automatically.

```
// Open zigzag path (5 points)
p = path(false, 1, 7, 4, 2, 7, 7, 10, 2, 13, 7) { color: #6c5ce7 }
p : show()

// Closed triangle
tri = path(true, 8, 1, 14.5, 8, 1.5, 8) { color: #e17055 }
tri : show()

// Single point → dot
dot = path(false, 8, 4.5) { color: #00b894, lineWidth: 1 }
dot : show()
```

**`draw()` on a path** animates the stroke from the first point to the last in proportion to the elapsed time, traversing the path by cumulative length. For a closed path, the closing segment is part of the animated sequence.

### 4.5a Image Shape

`image` draws a raster image at top-left `(x, y)`. Give a width and the **height is auto-calculated from the image's aspect ratio** (so it never distorts); pass an optional height to force exact dimensions:

```
image("src", x, y, w)       // height follows the image's aspect ratio
image("src", x, y, w, h)    // explicit width × height (may distort)
```

| Argument | Type   | Description                                                            |
| -------- | ------ | ---------------------------------------------------------------------- |
| `src`    | string | A **local asset name** (added in the Assets panel) or an **image URL** |
| `x, y`   | number | Top-left position                                                      |
| `w`      | number | Width in canvas units                                                  |
| `h`      | number | _Optional._ Height; omit to auto-fit the aspect ratio                  |

> The auto height is resolved once the image decodes, so a square placeholder may show briefly before the correct height appears.

**Resolving `src`:**

- A **local asset name** (e.g. `"logo"`) is matched against assets added through the player's **Assets panel**. Assets live in the current browser session only — there is no save/reopen yet, so add them again next session (or reference a URL).
- A **URL** (`https://…`) is loaded directly. The renderer first tries a CORS request so the image can be exported; if the host blocks CORS the image still previews, but **video/image export will refuse it** (a cross-origin image taints the export canvas). Importing the URL through the Assets panel sidesteps this by copying the bytes into a local asset.

```
// Local asset named "logo" — width 6, height auto from aspect ratio
img = image("logo", 5, 2, 6)
img : show()

// Direct URL (exports only if the host allows cross-origin access)
pic = image("https://example.com/cat.png", 1, 1, 4)
pic : show()

// Explicit width × height when you want to force the size
banner = image("logo", 1, 1, 14, 2)
banner : show()
```

Like every shape, an image starts hidden — call `show()` to reveal it. All standard transforms (`move`, `scale`, `rotate`, opacity) apply; stroke-based effects (`draw`/`undraw`) are accepted but have no visible effect on a raster.

### 4.6 Curve Shape

`curve` plots a mathematical **expression** `y = f(x)` as an open polyline on the canvas. The expression is sampled across the domain to produce a set of points, rendered as a connected stroke — identical in appearance to an open `path`. Static curves are sampled once when the shape is created; expressions that reference the clock `T` are re-sampled every render frame.

```
curve("expr", [x1, x2], (px, py))
curve("expr", [x1, x2], (px, py)) { scale: 1, pointCount: 100, visualProps... }
```

| Argument   | Type   | Description                                                                        |
| ---------- | ------ | ---------------------------------------------------------------------------------- |
| `"expr"`   | string | A quoted math expression of the domain variable `x` (and optionally the clock `T`) |
| `[x1, x2]` | list   | Domain over which `x` is swept; `x2` must be greater than `x1`                     |
| `(px, py)` | point  | Canvas anchor — the first sample (at `x1`) is translated to land here              |

**The expression language:**

- **Variables:** `x` — the horizontal coordinate, swept over `[x1, x2]`. `T` — the animation clock in seconds (see below).
- **Operators:** `+ - * / %` and `^` (power, right-associative), unary `-`, and parentheses.
- **Constants:** `PI`, `E`, `TAU` (= 2π).
- **Functions:** `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `atan2`, `sinh`, `cosh`, `tanh`, `exp`, `log`/`ln`, `log2`, `log10`, `sqrt`, `cbrt`, `abs`, `sign`, `floor`, `ceil`, `round`, `trunc`, `pow`, `mod`, `hypot`, `min`, `max`, `clamp`.
- **Bare-name shorthand:** a lone function name is applied to `x`, so `"sin"` means `"sin(x)"`.

A malformed expression (unknown symbol, unknown function, bad syntax) is a compile error with a message.

**Optional props (`{}`):**

| Property                              | Type   | Default | Description                                                                                               |
| ------------------------------------- | ------ | ------- | --------------------------------------------------------------------------------------------------------- |
| `scale`                               | number | `1`     | Y-axis multiplier. For `sin(x)` whose output is `[-1, 1]`, `scale: 2` spans 4 canvas units vertically.    |
| `pointCount`                          | number | auto    | Override the sample count. Default is `ceil((x2 − x1) / 0.1)` capped at 100. Specified value always wins. |
| `color`, `lineWidth`, `opacity`, etc. | —      | —       | All standard visual properties apply (see §4.8).                                                          |

**Example expressions:**

| Expression               | Draws                                               |
| ------------------------ | --------------------------------------------------- |
| `"sin(x)"`               | A sine wave over the domain (one cycle per 2π of x) |
| `"sin(3*x)"`             | Three times the spatial frequency                   |
| `"x^2 - 2*x + 1"`        | A parabola                                          |
| `"log2(x)"`              | Base-2 logarithm                                    |
| `"clamp(x, -1, 1)"`      | `x` clamped to `[-1, 1]`                            |
| `"exp(-x*x) * cos(6*x)"` | A Gaussian-windowed wave packet                     |

**Coefficients live in the expression.** There is no separate parameter list any more — frequency, exponent, log base, and clamp bounds are all written directly: `sin(3*x)`, `x^2`, `log(x)/log(2)`, `clamp(x,-1,1)`.

**Singularities:** any sample that evaluates to a non-finite value (e.g. `tan` near ±π/2, `log` at or below 0) is clamped to ±1,000,000 — no gap in the path, just a spike.

**Sampling:**

Default sample count is `ceil((x2 − x1) / 0.1)` capped at 100 points. `pointCount` overrides this completely — lower values give a coarser look, higher values give smoother curves.

```
// default sampling
wave = curve("sin(x)", [1, 7], (1, 4.5))

// 200-point high-fidelity curve
wave = curve("sin(3*x)", [0, 16], (0, 4.5)) { pointCount: 200 }

// intentional coarse look — 6 points only
wave = curve("sin(x)", [0, 8], (0, 4.5)) { pointCount: 6 }
```

**Animated curves — using the clock `T`:**

When the expression references `T` (seconds since playback started), the curve is re-sampled every render frame. Because `x` gives the wave its shape and `T` shifts it, `sin(x - T)` is a wave that travels sideways, `sin(x) * T` grows in amplitude, and so on.

```
w = curve("sin(x - T)", [1, 15], (1, 4.5)) { scale: 2 }
w : show()
```

> The compiler emits a warning when `T` is detected: _"curve contains runtime variable T — this curve will be evaluated per-frame."_

**Chirp (varying wavelength):** an `x²` term inside the sine makes the frequency sweep across the domain — the wavelength shrinks from left to right.

```
// wavelength sweeps 2 → 0.2 across ~10 cycles
c = curve("sin(3.1416*x + 3.888*x^2)", [0, 3.64], (1, 4.5)) { scale: 2 }
```

**Effects:**

All standard effects work on a curve — `show`, `draw`, `undraw`, `move`, `scale`, `rotate`. `draw()` animates the stroke progressively from the first sampled point to the last.

```
// Sine wave that draws itself
w = curve("sin(2*x)", [1, 15], (1, 4.5)) { scale: 1.5, color: #6c5ce7 }
w : draw() { duration: 3s }

// Parabola
p = curve("x^2", [-3, 3], (5, 7)) { scale: 0.3, color: #e17055 }
p : show()

// Natural log
l = curve("log(x)", [1, 8], (1, 6)) { color: #00b894 }
l : show()
```

#### 4.6.1 Parametric Curve Shape

`curve` plots a **parametric curve**, where both the X and Y coordinates are defined by independent mathematical expressions. Instead of drawing `y = f(x)`, the engine evaluates two expressions for every value of the domain variable, producing an open polyline.

Static parametric curves are sampled once when the shape is created. If either expression references the animation clock `T`, the curve is re-sampled every render frame.

```kscript
curve("xExpr", "yExpr", [x1, x2], (px, py))
curve("xExpr", "yExpr", [x1, x2], (px, py)) {
    scale: 1,
    pointCount: 100,
    visualProps...
}
```

| Argument   | Type   | Description                                                                  |
| ---------- | ------ | ---------------------------------------------------------------------------- |
| `"xExpr"`  | string | A quoted math expression defining the X coordinate                           |
| `"yExpr"`  | string | A quoted math expression defining the Y coordinate                           |
| `[x1, x2]` | list   | Domain over which the parameter `x` is swept; `x2` must be greater than `x1` |
| `(px, py)` | point  | Canvas anchor — the first sampled point is translated to land here           |

** Expression language **

Both expressions use the same expression language as the regular curve form.

- **Variables:** `x` — the parameter swept over `[x1, x2]`. `T` — the animation clock in seconds.
- **Operators:** `+ - * / %` and `^` (power, right-associative), unary `-`, and parentheses.
- **Constants:** `PI`, `TAU`, `E`.
- **Functions:** `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `atan2`, `sinh`, `cosh`, `tanh`, `exp`, `log`/`ln`, `log2`, `log10`, `sqrt`, `cbrt`, `abs`, `sign`, `floor`, `ceil`, `round`, `trunc`, `pow`, `mod`, `hypot`, `min`, `max`, `clamp`.
- **Bare-name shorthand:** A lone function name is applied to `x`, so `"sin"` is equivalent to `"sin(x)"`.

A malformed expression (unknown symbol, unknown function, bad syntax) is a compile error with a message.

** Optional props (`{}`) **

| Property                              | Type   | Default | Description                                                                                               |
| ------------------------------------- | ------ | ------- | --------------------------------------------------------------------------------------------------------- |
| `scale`                               | number | `1`     | Uniform multiplier applied to both X and Y coordinates before positioning.                                |
| `pointCount`                          | number | auto    | Override the sample count. Default is `ceil((x2 − x1) / 0.1)` capped at 100. Specified value always wins. |
| `color`, `lineWidth`, `opacity`, etc. | —      | —       | All standard visual properties apply (see §4.8).                                                          |

** Example expressions **

| X Expression                | Y Expression                | Draws                 |
| --------------------------- | --------------------------- | --------------------- |
| `"cos(x)"`                  | `"sin(x)"`                  | Circle                |
| `"2*cos(x)"`                | `"sin(x)"`                  | Ellipse               |
| `"x*cos(x)"`                | `"x*sin(x)"`                | Archimedean spiral    |
| `"sin(3*x)"`                | `"sin(4*x)"`                | Lissajous figure      |
| `"cos(x)^3"`                | `"sin(x)^3"`                | Astroid               |
| `"cos(x)*(1+0.3*cos(8*x))"` | `"sin(x)*(1+0.3*cos(8*x))"` | Flower                |
| `"cos(x)+0.5*cos(3*x)"`     | `"sin(x)-0.5*sin(3*x)"`     | Epicycloid-like curve |

Like the regular curve form, all coefficients and constants are written directly in the expressions. There is no separate parameter list.

** Animation **

Either expression may reference the animation clock `T`.

```kscript
curve(
    "cos(x)*(1+0.3*sin(T))",
    "sin(x)*(1+0.3*sin(T))",
    [0, TAU],
    (8, 4.5)
)
```

```kscript
curve(
    "x*cos(x + T)",
    "x*sin(x + T)",
    [0, 8*PI],
    (8, 4.5)
)
```

Whenever `T` appears in either expression, the curve is re-sampled every frame.

** Coordinate system **

Unlike the regular curve form (`y = f(x)`), the parameter `x` is **not** the final horizontal canvas coordinate. Instead, both coordinates are computed independently:

```
X = xExpr(x)
Y = yExpr(x)
```

The domain variable simply controls progression along the curve.

** Singularities **

If either expression evaluates to a non-finite value (`NaN`, `Infinity`, or `-Infinity`), that coordinate is clamped to ±1,000,000. No gaps are introduced in the path; the result is a spike.

** Sampling **

Default sample count is `ceil((x2 − x1) / 0.1)` capped at 100 points. `pointCount` overrides this completely — lower values give a coarser appearance, while higher values produce smoother curves.

** Archimedean Spiral **

```kscript
curve(
    "0.2*x*cos(x)",
    "0.2*x*sin(x)",
    [0, 8*PI],
    (8, 4.5)
) {
    color: orange
}
```

** Lissajous Figure **

```kscript
curve(
    "sin(3*x)",
    "sin(4*x)",
    [0, TAU],
    (8, 4.5)
) {
    scale: 2,
    color: purple
}
```

** Figure Eight (Lemniscate) **

```kscript
curve(
    "cos(x)/(1+sin(x)^2)",
    "sin(x)*cos(x)/(1+sin(x)^2)",
    [0, TAU],
    (8, 4.5)
) {
    scale: 3,
    color: red
}
```

** Pulsing Circle **

```kscript
curve(
    "(1+0.3*sin(T))*cos(x)",
    "(1+0.3*sin(T))*sin(x)",
    [0, TAU],
    (8, 4.5)
) {
    scale: 2,
    color: cyan
}
```

---

### 4.7 Polar Shape

`polar` plots a polar **expression** **r = f(θ)** as an open polyline, sweeping the angle θ over a range and placing each sample at `(cx + r·cos θ, cy + r·sin θ)`. It is the polar-coordinate counterpart of [`curve`](#46-curve-shape): same expression language, same optional props, same effects — only the domain variable changes from `x` to `theta`. Static polar curves are sampled once when created; expressions referencing the clock `T` are re-sampled every render frame.

```
polar("expr", [θ1, θ2], (cx, cy))
polar("expr", [θ1, θ2], (cx, cy)) { scale: 1, pointCount: 100, visualProps... }
```

| Argument   | Type   | Description                                                                  |
| ---------- | ------ | ---------------------------------------------------------------------------- |
| `"expr"`   | string | A quoted math expression of the angle `theta` (and optionally the clock `T`) |
| `[θ1, θ2]` | list   | Angle range (radians) swept by `theta`; `θ2` must be greater than `θ1`       |
| `(cx, cy)` | point  | Center the curve is drawn around                                             |

The expression language is identical to `curve` (§4.6) except the domain variable is `theta` instead of `x`. A bare name like `"cos"` means `"cos(theta)"`.

**Optional props (`{}`):**

| Prop         | Default | Meaning                                                                                  |
| ------------ | ------- | ---------------------------------------------------------------------------------------- |
| `scale`      | `1`     | Radius multiplier — scales `r` (bounded functions like `sin`/`cos` need this to be seen) |
| `pointCount` | auto    | Fixed number of samples; overrides the automatic density                                 |
| visual props | —       | All standard visual properties apply (see §4.8)                                          |

**Example expressions:**

| Expression         | Draws                                                  |
| ------------------ | ------------------------------------------------------ |
| `"cos(4*theta)"`   | An 8-petal rose (`r = cos(4θ)`)                        |
| `"sin(2*theta)"`   | A 4-petal rose                                         |
| `"sqrt(theta)"`    | An Archimedean-style spiral whose radius grows as `√θ` |
| `"1 + cos(theta)"` | A cardioid                                             |
| `"theta"`          | An Archimedean spiral (`r = θ`)                        |

The radius is multiplied by `scale` and non-finite samples are clamped exactly as in §4.6.

**Sampling:**

Default sample count is `ceil((θ2 − θ1) / 0.05)` capped at 360 points — denser than `curve` so closed loops stay smooth. `pointCount` overrides this completely.

**Animated curves — using the clock `T`:**

When the expression references `T`, the curve is re-sampled every render frame. For example `cos(4*theta - T)` rotates the rose, and `(1 + cos(theta)) * T` pulses it.

```
p = polar("cos(4*theta - T)", [0, 2*PI], (8, 4.5)) { scale: 3 }
p : show()
```

**Effects:**

All standard effects work — `show`, `draw`, `undraw`, `move`, `scale`, `rotate`. `draw()` animates the stroke progressively from the first sampled point to the last.

```
// 8-petal rose
r = polar("cos(4*theta)", [0, 2*PI], (8, 4.5)) { scale: 3, color: #6c5ce7 }
r : draw() { duration: 3s }

// Archimedean spiral
s = polar("sqrt(theta)", [0, 6*PI], (8, 4.5)) { scale: 1.2, color: #00b894 }
s : show()
```

---

### 4.8 Shape Visual Properties

Optional properties set in a `{}` block after the constructor:

```
c = circle(8, 4.5, 2) {
  color: #ff6b6b,
  fillColor: #ffd93d,
  fill: true,
  lineWidth: 1,
  opacity: 0.8,
  visible: false
}
```

| Property    | Type    | Description                                                                             |
| ----------- | ------- | --------------------------------------------------------------------------------------- |
| `color`     | color   | Stroke/outline color                                                                    |
| `fillColor` | color   | Fill color (also sets `fill: true`)                                                     |
| `fill`      | boolean | Whether to fill. Defaults to `true` when `fillColor` is set; explicit `false` overrides |
| `lineWidth` | number  | Stroke line width                                                                       |
| `opacity`   | number  | Opacity 0.0–1.0                                                                         |
| `visible`   | boolean | Initial visibility (default: `true`)                                                    |

**Text-specific properties** — `text` has no stroke/fill; its `color` property sets the glyph color directly:

```
t = text("Hello", 8, 4.5) {
  color: #333333,
  fontSize: 24,
  fontFamily: "Georgia",
  fontWeight: "bold",
  fontStyle: "italic",
  textAlign: "center"
}
```

| Property     | Type   | Description                                              | Default   |
| ------------ | ------ | -------------------------------------------------------- | --------- |
| `color`      | color  | Text (glyph) color                                       | `#000000` |
| `fontSize`   | number | Font size in px                                          | `16`      |
| `fontFamily` | string | Any font available to the page (e.g. `Arial`, `Georgia`) | `Arial`   |
| `fontWeight` | string | `normal`, `bold`, or a numeric weight `100`–`900`        | `normal`  |
| `fontStyle`  | string | `normal`, `italic`, or `oblique`                         | `normal`  |
| `textAlign`  | string | `left`, `center`, or `right`                             | `left`    |

---

### 4.9 Axes (Graphs)

`axes` is a coordinate system to plot _against_ — a pair of axis lines with ticks (optionally arrows, gridlines, and numeric labels). Its trailing `[ ]` block turns it into a **chart**: a list of numbers becomes a line or bar graph, and everything inside is positioned in **graph coordinates** rather than canvas coordinates.

```
axes(xRange, yRange, (ox, oy))
axes(xRange, yRange, (ox, oy)) { color, arrows, grid, labels, scale, graphType, barWidth, startTick } [ data-or-shapes ]
```

**Positional arguments**

| Argument   | Type  | Description                                                                                |
| ---------- | ----- | ------------------------------------------------------------------------------------------ |
| `xRange`   | list  | `[start, end, step?]` for the x-axis (step defaults to `1`). Pass `[]` to omit the x-axis. |
| `yRange`   | list  | `[start, end, step?]` for the y-axis. Pass `[]` to omit the y-axis.                        |
| `(ox, oy)` | point | **Required.** Where graph `(0, 0)` sits, in canvas units. No default.                      |

The x/y range args are distinguished from the origin by type (lists vs. a point), so the forms below are all unambiguous:

| Form                  | Meaning                              |
| --------------------- | ------------------------------------ |
| `axes([x], (o))`      | x-axis only                          |
| `axes([], [y], (o))`  | y-axis only (a vertical number line) |
| `axes([x], [y], (o))` | both axes                            |

Omitting an axis only hides that axis line — the coordinate frame still maps both dimensions, so a chart or shape still positions correctly.

**Coordinate mapping.** Graph point `(gx, gy)` lands at canvas `(ox + gx·scaleX, oy − gy·scaleY)`. The y is **flipped** so graph-y points up (math convention), local to the axes — shapes outside the axes are unaffected.

**Optional props (`{}`)**

| Property    | Type            | Default           | Description                                                                                           |
| ----------- | --------------- | ----------------- | ----------------------------------------------------------------------------------------------------- |
| `scale`     | number or point | `1`               | Graph-units → canvas-units. A single number is uniform; a point `(sx, sy)` scales axes independently. |
| `color`     | color           | `#000000`         | Axis (and data) color.                                                                                |
| `arrows`    | boolean         | `false`           | Draw arrowheads at the ends of each axis.                                                             |
| `grid`      | boolean         | `false`           | Draw gridlines at each tick (needs both axes).                                                        |
| `labels`    | boolean         | `false`           | Draw numeric tick labels. Label font size is fixed (does not scale).                                  |
| `graphType` | string          | `"line"`          | For a data chart: `"line"` or `"bar"`. Must be quoted.                                                |
| `barWidth`  | number          | `step · 0.6`      | Bar width in graph units (bar charts only).                                                           |
| `startTick` | number          | line `0`, bar `1` | Index of the first x-tick the data starts on. Bars default to `1` to keep the y-axis clear.           |

**The `[ ]` block — data or shapes**

The block's content decides the mode:

- **Numbers → a chart.** `[ 3, 7, 2, 5 ]` plots one value per x-axis tick (value _i_ → tick _i + startTick_). `graphType: "line"` (default) draws a connected polyline; `"bar"` draws a filled rectangle from the y=0 baseline to each value. If the value count doesn't match the available ticks, the compiler emits a **warning** and plots as many as fit.
- **Shapes → plotted in graph space.** `[ circle(0, 0, 1), rectangle((1,1),(4,3)) ]` places shapes using graph coordinates. Position arguments map through the graph transform; sizes are in graph units (a circle radius uses the x-scale). Supported: `circle`, `point`, `rectangle`, `line`, `text`, `path`. A `text`'s `fontSize` stays literal (unscaled). Other shapes are a compile error inside `axes`.
- Mixing numbers and shapes in one block is an error. A data chart requires an x-axis.

An open `path` inside the block is the general way to draw a **line graph** with explicit x/y points; a data-number list is the shorthand.

**Effects.** `show`, `move`, `scale` apply to the whole graph (frame + plotted content) as a rigid body. `draw()` is **staged and sequenced**: the axis lines draw first (then gridlines, then labels), after which each plotted shape / bar draws one by one.

**Examples**

```
// Both axes with grid, arrows, and labels
g = axes([-10, 10, 1], [-10, 10, 1], (8, 4.5)) {
  color: #636e72, arrows: true, grid: true, labels: true, scale: (0.35, 0.35)
}
g : draw() { duration: 2s }

// Bar chart (bars start one tick in, clear of the y-axis)
b = axes([0, 5], [0, 10], (2, 7)) { graphType: "bar", color: #0984e3, scale: (0.9, 0.5) } [ 3, 7, 2, 5, 8 ]
b : draw() { duration: 3s }

// Line chart
l = axes([0, 5], [0, 10], (2, 7)) { color: #6c5ce7, scale: (1, 0.5) } [ 2, 5, 3, 8, 6, 4 ]
l : draw() { duration: 2s }

// Plotting shapes in graph coordinates
p = axes([-5, 5, 1], [-5, 5, 1], (8, 4.5)) { grid: true, scale: (0.6, 0.6) } [
  circle(0, 0, 1) { color: #e17055 },
  rectangle((1, 1), (3, 3)) { color: #00b894 }
]
p : show()
```

---
