# 1. Canvas Definition

Defines the canvas for rendering. Optional — omitting it uses defaults.

```
canvas {
  width: 16,
  height: 9,
  FPS: 60,
  BGColor: #1a1a2e
  loop: true
}
```

| Property  | Type    | Default   | Description                      |
| --------- | ------- | --------- | -------------------------------- |
| `width`   | number  | 16        | Aspect ratio width (not pixels)  |
| `height`  | number  | 9         | Aspect ratio height (not pixels) |
| `FPS`     | number  | 60        | Suggested frames per second      |
| `BGColor` | color   | `#ffffff` | Background color                 |
| `loop`    | boolean | false     | Set the animation runs for ever  |

> `width` and `height` describe the **aspect ratio**, not pixel dimensions. The rendering destination scales actual pixels to fit.

---

