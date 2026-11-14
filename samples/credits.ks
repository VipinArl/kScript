canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tX = 200
tText = 1000
tUnder = 2000
tThr = 2300
tFire = 2700
tFly = 2900
flyMs = 2100
tEnd = 5000

// ---------- twinkling stars ----------
sx = [1.0, 2.6, 7.2, 13.8, 15.0, 9.6, 3.2, 12.2]
sy = [1.4, 7.6, 1.2, 1.7, 6.6, 7.7, 2.2, 7.0]
for i in range(0, 8) {
  st = circle(sx[i], sy[i], 0.04 + 0.02 * (i % 3)) { fillColor: #a8dadc, color: #a8dadc, lineWidth: 1 }
  st : fadeIn() { startTime: 100 + 110 * i, duration: 500 }
}

// ---------- the X: two lines drawn ----------
x1 = line(3.5, 3.4, 2.2, 2.2) { color: #4cc9f0, lineWidth: 16 }
x2 = line(5.7, 3.4, -2.2, 2.2) { color: #4cc9f0, lineWidth: 16 }
x1 : draw() { startTime: tX, duration: 500, easing: "ease-out-quad" }
x2 : draw() { startTime: tX + 250, duration: 500, easing: "ease-out-quad" }

// spark burst where the lines cross (center 4.6, 4.5)
for i in range(0, 10) {
  spA = i * PI / 5
  sp = circle(4.6, 4.5, 0.05 + 0.03 * (i % 2)) { fillColor: #ffffff, color: #ffd166, lineWidth: 1, opacity: 0 }
  sp : show() { startTime: 750 }
  sp : move(1.3 * cos(spA), 1.3 * sin(spA)) { startTime: 750, duration: 450, easing: "ease-out-quad" }
  sp : morph[opacity: 0.95 * (1 - clamp((T - S) / D, 0, 1))] { startTime: 750, duration: 450, easing: "linear" }
  sp : hide()
}

// ---------- "facted!": gold shadow copy first, white text on top ----------
shadow = text("facted!", 8.44, 4.88) { color: #ffd166, fontSize: 140, fontFamily: "Georgia", fontWeight: "bold", fontStyle: "italic", textAlign: "center" }
main = text("facted!", 8.4, 4.82) { color: #ffffff, fontSize: 140, fontFamily: "Georgia", fontWeight: "bold", fontStyle: "italic", textAlign: "center" }
shadow : draw() { startTime: tText + 100, duration: 1000 }
main : draw() { startTime: tText, duration: 1000 }

// gold underline with a dot, and a four-point sparkle after the exclamation mark
under = line(6, 5.35, 5, 0) { color: #ffd166, lineWidth: 4 }
underDot = circle(11.3, 5.35, 0.07) { fillColor: #ffd166, color: #ffd166, lineWidth: 1 }
under : draw() { startTime: tUnder, duration: 400, easing: "ease-out-quad" }
underDot : fadeIn() { startTime: tUnder + 350, duration: 200 }
star = path(true, 12.95, 2.85, 13.03, 3.12, 13.3, 3.2, 13.03, 3.28, 12.95, 3.55, 12.87, 3.28, 12.6, 3.2, 12.87, 3.12) { fillColor: #ffffff, color: #ffd166, lineWidth: 1.5 }
star : fadeIn() { startTime: tUnder, duration: 300 }
star : scale((1.5, 1.5)) { pivot: (12.95, 3.2), startTime: tUnder + 300, duration: 250, easing: "ease-out-quad" }
star : scale((1, 1)) { pivot: (12.95, 3.2), startTime: tUnder + 550, duration: 250, easing: "ease-in-quad" }

// ---------- the thruster: starts at the left, nozzle faces left, flies the full width to the right ----------
thr = group [
  rectangle(1.5, 6.75, 0.9, 0.5) { fillColor: #2b3a55, color: #ffffff, lineWidth: 2 },
  path(true, 1.5, 6.8, 1.1, 6.65, 1.1, 7.35, 1.5, 7.2) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1.5 },
  path(true, 2.4, 6.75, 2.6, 6.5, 2.2, 6.75) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 },
  path(true, 2.4, 7.25, 2.6, 7.5, 2.2, 7.25) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 },
  circle(1.95, 7.0, 0.09) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 }
]
thr : fadeIn() { startTime: tThr, duration: 300 }
thr : move(17.5, 0) { startTime: tFly, duration: flyMs, easing: "ease-in-quad" }

// the jet trails behind the thruster (to the left of the nozzle)
jetO = path(true, 1.1, 6.72, 1.1, 7.28, -0.05, 7.0) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1, opacity: 0 }
jetC = path(true, 1.1, 6.86, 1.1, 7.14, 0.5, 7.0) { fillColor: #e8fbff, color: #e8fbff, lineWidth: 1, opacity: 0 }
jetO : show() { startTime: tFire }
jetC : show() { startTime: tFire }
jetO : move(17.5, 0) { startTime: tFly, duration: flyMs, easing: "ease-in-quad" }
jetC : move(17.5, 0) { startTime: tFly, duration: flyMs, easing: "ease-in-quad" }
jetO : morph[opacity: 0.9 * clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.85 + 0.15 * sin(110 * clamp((T - S) / D, 0, 1)))] { startTime: tFire, duration: tEnd - tFire, easing: "linear" }
jetC : morph[opacity: clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.9 + 0.1 * sin(130 * clamp((T - S) / D, 0, 1)))] { startTime: tFire, duration: tEnd - tFire, easing: "linear" }
