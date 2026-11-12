canvas { BGColor: #05070f }

// ---- timeline data ----
xs = [2.6, 6.4, 10.2, 14.0]
years = ["2017", "2020", "2026", "2028"]
captions = ["car introduced", "first release date", "demo day", "release pushed"]
palette = [#4cc9f0, #ffd166, #ff9d2f, #ff5c7a]

carSpeed = 2.8
carStart = 1400
drive1DX = xs[2] + 1.2
drive1Dur = drive1DX / carSpeed * 1000
drive2Start = carStart + drive1Dur
drive2DX = 1.5
drive2Dur = 2 * drive2DX / carSpeed * 1000
endTime = drive2Start + drive2Dur

// each new milestone is introduced as the car passes the previous one
introT = [800, carStart + (xs[0] + 1.2) / carSpeed * 1000, carStart + (xs[1] + 1.2) / carSpeed * 1000, carStart + (xs[2] + 1.2) / carSpeed * 1000]
riseOffset = 2.2

// ---- night sky ----
for s in range(0, 14) {
  stx = 0.5 + (s * 1.9) % 15
  sty = 0.4 + (s * 1.3) % 3.6
  star = point(stx, sty) { fillColor: #ffffff, opacity: 0 }
  star : show() { startTime: 0 }
  star : morph[opacity: 0.3 + 0.25 * sin(clamp((T - S) / D, 0, 1) * TAU * 3 + s)] { startTime: 0, duration: 9000 }
}

title = text("Roadster timeline", 8, 1.0) { color: #7fd8ff, fontSize: 26, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
title : show() { startTime: 0 }
title : morph[opacity: 1] { startTime: 0, duration: 600 }

// ---- milestones (drawn before the road so they rise out of the ground) ----
for (yr, i) in years {
  mx = xs[i]
  t0 = introT[i]
  stone = path(true, mx - 1.05, 8.0 + riseOffset, mx - 1.05, 6.05 + riseOffset, mx - 0.85, 5.75 + riseOffset, mx + 0.85, 5.75 + riseOffset, mx + 1.05, 6.05 + riseOffset, mx + 1.05, 8.0 + riseOffset) { fillColor: #1a2233, color: palette[i], lineWidth: 0.6 }
  stone : show() { startTime: t0 }
  stone : move(0, -riseOffset) { startTime: t0, duration: 700, easing: "ease-out-back" }

  ring = circle(mx, 7.5, 0.2) { color: palette[i], lineWidth: 0.6, opacity: 0 }
  ring : show() { startTime: t0 }
  ring : morph[radius: lerp(0.2, 1.6, clamp((T - S) / D, 0, 1)), opacity: 0.9 * (1 - clamp((T - S) / D, 0, 1))] { startTime: t0, duration: 900 }
  ring : hide() { startTime: t0 + 900 }

  for sp in range(0, 8) {
    a = -PI + (sp + 0.5) * PI / 8
    spark = circle(mx, 7.5, 0.07) { fillColor: palette[i], opacity: 0 }
    spark : show() { startTime: t0 + 150 }
    spark : parallel [
      move(cos(a) * 1.4, sin(a) * 1.4) { easing: "ease-out-cubic" },
      morph[opacity: 1 - clamp((T - S) / D, 0, 1)]
    ] { startTime: t0 + 150, duration: 800 }
    spark : hide() { startTime: t0 + 950 }
  }

  yearTxt = text(yr, mx, 6.3) { color: palette[i], fontSize: 26, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
  yearTxt : show() { startTime: t0 + 500 }
  yearTxt : morph[opacity: 1] { startTime: t0 + 500, duration: 400 }

  capTxt = text(captions[i], mx, 6.8) { color: #a8dadc, fontSize: 12, fontFamily: "Georgia", textAlign: "center", opacity: 0 }
  capTxt : show() { startTime: t0 + 700 }
  capTxt : morph[opacity: 1] { startTime: t0 + 700, duration: 400 }

  if (i == 3) {
    yearTxt : morph[opacity: 0.75 + 0.25 * sin(clamp((T - S) / D, 0, 1) * TAU * 2)] { startTime: endTime, duration: 2200 }
  }
}

// ---- road ----
ground = rectangle(0, 7.5, 16, 1.5) { fillColor: #0b1018 }
ground : show() { startTime: 0 }
roadEdge = line((0, 7.5), (16, 7.5)) { color: #4cc9f0, lineWidth: 0.6 }
roadEdge : draw() { startTime: 100, duration: 900 }
for i in range(0, 10) {
  dash = line((i * 1.7 + 0.3, 8.3), (i * 1.7 + 1.1, 8.3)) { color: rgba(255,255,255,0.3), lineWidth: 0.5 }
  dash : draw() { startTime: 200 + i * 60, duration: 300 }
}

car = group [
  path(true, -2.067, 7.148, -1.451, 7.036, -0.784, 7.159, -0.584, 7.137, -0.247, 7.262, -0.247, 7.359, -2.036, 7.350, -2.146, 7.289, -2.133, 7.168) { fillColor: #e63946, color: #ffffff, lineWidth: 0.5 },
  path(true, -1.816, 7.137, -1.464, 7.071, -1.002, 7.155, -1.002, 7.214, -1.816, 7.214) { fillColor: #a8dadc, color: #1d3557, lineWidth: 0.5 },
  circle(-1.772, 7.335, 0.165) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(-0.650, 7.335, 0.165) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(-1.772, 7.335, 0.06) { fillColor: #cfd8dc },
  circle(-0.650, 7.335, 0.06) { fillColor: #cfd8dc },
  circle(-0.298, 7.280, 0.04) { fillColor: #ffd166 }
]

car : show() { startTime: 0 }
car : move(drive1DX, 0) { startTime: carStart, duration: drive1Dur, easing: "linear" }
car : move(drive2DX, 0) { startTime: drive2Start, duration: drive2Dur, easing: "ease-out-quad" }
