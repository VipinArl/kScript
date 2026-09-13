# 5. Expressions

### 5.1 Numeric Expressions

Arithmetic operators: `+`, `-`, `*`, `/`, `%` (modulo). Parentheses control precedence.

```
a = 3 + 4 * 2      // 11
b = (3 + 4) * 2    // 14
c = 10 % 3         // 1
```

Unary operators: `+` (positive), `-` (negate), `!` (logical NOT).

```
neg  = -5
flag = !true
```

### 5.2 Arithmetic Constants

| Constant | Value    | Description                                       |
| -------- | -------- | ------------------------------------------------- |
| `PI`     | 3.14159… | Pi                                                |
| `TAU`    | 6.28318… | Tau (2 × PI)                                      |
| `E`      | 2.71828… | Euler's number                                    |
| `@`      | Infinity | Positive infinity                                 |
| `#`      | NaN      | Not-a-number                                      |
| `T`      | runtime  | Current animation time (available inside `morph`) |
| `D`      | runtime  | Effect duration (available inside `morph`)        |
| `S`      | runtime  | Effect start time (available inside `morph`)      |

`T`, `D`, and `S` are only meaningful inside `morph` expressions evaluated at runtime.

```
progress = (T - S) / D    // 0 → 1 over the effect
```

### 5.3 Unit Literals

Attach a unit suffix to a number to express time or angle.

| Suffix | Unit         | Example   |
| ------ | ------------ | --------- |
| `ms`   | milliseconds | `500ms`   |
| `s`    | seconds      | `2.5s`    |
| `f`    | frames       | `30f`     |
| `deg`  | degrees      | `90deg`   |
| `rad`  | radians      | `1.57rad` |

```
c : move(4, 0) { duration: 2s, startTime: 500ms }
c : rotate(180deg) { duration: 1s }
```

### 5.4 Boolean Literals

```
visible = true
hidden  = false
```

### 5.5 String Literals

#### 5.5.1 Plain String

Enclosed in double quotes.

```
label = "Hello, World!"
t = text("Score: 100", 8, 4.5)
```

#### 5.5.2 Templated Strings

Templated strings allow expressions to be embedded inside a string using ${...}. The expression is evaluated and its result is inserted into the string.

```
score = 42
total = 50

label = "Score: ${score}"

t = text("Score perc: ${score*(total/100)}", 8, 4.5)
```

### 5.6 Color Literals

| Format      | Syntax                                | Example                    |
| ----------- | ------------------------------------- | -------------------------- |
| Hex         | `#rrggbb`                             | `#ff6b6b`                  |
| Hex + alpha | `#rrggbbaa`                           | `#ff6b6b80`                |
| RGB         | `rgb(r, g, b)` — 0–255                | `rgb(255, 107, 107)`       |
| RGBA        | `rgba(r, g, b, a)` — a: 0.0–1.0       | `rgba(255, 107, 107, 0.5)` |
| HSL         | `hsl(h, s, l)` — h: 0–360, s/l: 0–100 | `hsl(0, 100, 71)`          |
| HSLA        | `hsla(h, s, l, a)` — a: 0.0–1.0       | `hsla(0, 100, 71, 0.5)`    |

> For `hsl`/`hsla`, hue is in degrees (0–360) and saturation/lightness are percentages (0–100) — write them as plain numbers without the `%` sign.

```
c = circle(8, 4.5, 2) {
  color: #ff6b6b,
  fillColor: rgba(255, 107, 107, 0.3)
}

// HSL stroke with an HSLA fill
d = circle(4, 4.5, 1.5) {
  color: hsl(200, 90, 55),
  fillColor: hsla(200, 90, 55, 0.3)
}
```

### 5.7 Lists

**Explicit list:**

```
nums   = [1, 2, 3, 4, 5]
shapes = [circle(2, 4.5, 1), circle(6, 4.5, 1), circle(10, 4.5, 1)]
```

**List comprehension:**

```
squares = [x * x for x in range(1, 6)]
// → [1, 4, 9, 16, 25]
```

**Comprehension with filter:**

```
evens = [x for x in range(1, 11) if x % 2 == 0]
// → [2, 4, 6, 8, 10]
```

**Indexed access:**

```
nums  = [10, 20, 30]
first = nums[0]   // 10
third = nums[2]   // 30
```

### 5.8 Range

Generates a numeric sequence.

```
range(start, end)
range(start, end, step)
```

`end` is exclusive.

```
r1 = range(0, 5)           // [0, 1, 2, 3, 4]
r2 = range(0, 1, 0.25)     // [0, 0.25, 0.5, 0.75]
r3 = range(10, 0, -2)      // [10, 8, 6, 4, 2]
```

### 5.9 Logical and Comparison Operators

```
a && b   // logical AND
a || b   // logical OR
!a       // logical NOT

a == b   // equal
a != b   // not equal
a < b    // less than
a > b    // greater than
a <= b   // less than or equal
a >= b   // greater than or equal
```

```
n = 7
if (n > 0 && n < 10) {
  c = circle(8, 4.5, n * 0.3)
  c : show()
}
```

### 5.10 Clone objects

Create a clone of an object

```
a = axes([-5, 5, 1], (8,4))
b = a // both a and b point to the same object
c = clone(a) // create a new object

a: show()
b: move(0, 1) {duration: 1s} // a will be moved

c: serial[
  show(),
  move(0, 3) {duration: 1s}
] // new object will be shown and moved
```

### 5.11 Built-in Functions

| Function                                   | Signature    | Description                            | Example                       |
| ------------------------------------------ | ------------ | -------------------------------------- | ----------------------------- |
| `sin(x)`                                   | x in radians | Sine                                   | `sin(1.57) → 1`               |
| `cos(x)`                                   | x in radians | Cosine                                 | `cos(0) → 1`                  |
| `tan(x)`                                   | x in radians | Tangent                                | `tan(0) → 0`                  |
| `asin(x)`                                  | -1 ≤ x ≤ 1   | Inverse sine (returns radians)         | `asin(1) → 1.57`              |
| `acos(x)`                                  | -1 ≤ x ≤ 1   | Inverse cosine (returns radians)       | `acos(1) → 0`                 |
| `atan(x)`                                  | any number   | Inverse tangent (returns radians)      | `atan(1) → 0.79`              |
| `atan2(y, x)`                              | any numbers  | Angle from X-axis to point (x, y)      | `atan2(1,1) → 0.79`           |
| `sqrt(x)`                                  | x ≥ 0        | Square root                            | `sqrt(25) → 5`                |
| `pow(x, y)`                                | any numbers  | x raised to the power of y             | `pow(2,3) → 8`                |
| `exp(x)`                                   | any number   | Exponential function (eˣ)              | `exp(1) → 2.72`               |
| `log(x)`                                   | x > 0        | Natural logarithm (base e)             | `log(2.72) → 1`               |
| `log10(x)`                                 | x > 0        | Base-10 logarithm                      | `log10(100) → 2`              |
| `log2(x)`                                  | x > 0        | Base-2 logarithm                       | `log2(8) → 3`                 |
| `lerp(a, b, t)`                            | t in 0–1     | Linear interpolation                   | `lerp(0,10,0.5) → 5`          |
| `min(a, b, ...)`                           | any count    | Minimum value                          | `min(3,7,2) → 2`              |
| `max(a, b, ...)`                           | any count    | Maximum value                          | `max(3,7,2) → 7`              |
| `random()`                                 | —            | Random float in [0, 1]                 | `random() → 0.42`             |
| `random(min, max)`                         | any numbers  | Random float in [min, max]             | `random(1,5) → 3.4`           |
| `clamp(value,min,max)`                     | any numbers  | Limit value to a range                 | `clamp(6,2,5) → 5`            |
| `abs(value)`                               | any number   | Absolute value                         | `abs(-5) → 5`                 |
| `sign(value)`                              | any number   | Sign of the number                     | `sign(-25) → -1`              |
| `floor(value)`                             | any number   | Round down to nearest integer          | `floor(3.9) → 3`              |
| `ceil(value)`                              | any number   | Round up to nearest integer            | `ceil(3.1) → 4`               |
| `round(value)`                             | any number   | Round to nearest integer               | `round(3.6) → 4`              |
| `map(value, inMin, inMax, outMin, outMax)` | any number   | Maps a value from one range to another | `map(50, 0, 100, 0, 1) → 0.5` |
| `smoothstep(edge0, edge1, x)`              | any number   | smooth transition between 0 and 1      | `smoothstep(0, 10, 5) → 0.5`  |

```
r     = sqrt(16)            // 4
mid   = lerp(0, 100, 0.3)  // 30
angle = random(0, TAU)
```

---
