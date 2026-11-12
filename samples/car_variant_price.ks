canvas { BGColor: #05070f }

// ---------- timing (ms): three 2 s slots ----------
tSlot = [0, 2000, 4000]
enterMs = 350
crawlMs = 1300
exitMs = 350
tEnd = 6000

// ---------- title, date, disclaimer ----------
title = text("Roadster: expected pricing", 8, 0.55) { color: #ffd166, fontSize: 32, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title : draw() { startTime: 0, duration: 700 }
sub = text("slated for production around 2028", 8, 1.05) { color: #a8dadc, fontSize: 20, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
sub : draw() { startTime: 200, duration: 700 }
ground = line(0.3, 6.4, 15.4, 0) { color: #a8dadc, lineWidth: 2 }
ground : fadeIn() { startTime: 100, duration: 400 }
noPrice = text("Prices are officially not announced", 8, 8.2) { color: #ff5c7a, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
noPrice : fadeIn() { startTime: 500, duration: 500 }
noteEst = text("all figures are estimates", 8, 8.75) { color: #a8dadc, fontSize: 14, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
noteEst : fadeIn() { startTime: 500, duration: 500 }

// =====================================================
// CAR A: Performance (4 fans), slot 0 - 2 s
// =====================================================
carA = group [
  path(true, -5.184, 5.44, -3.504, 5.134, -1.686, 5.47, -1.14, 5.41, -0.222, 5.752, -0.222, 6.016, -5.1, 5.992, -5.4, 5.824, -5.364, 5.494) { fillColor: #e63946, color: #ffffff, lineWidth: 2 },
  path(true, -4.5, 5.41, -3.54, 5.23, -2.28, 5.458, -2.28, 5.62, -4.5, 5.62) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 },
  circle(-5.2, 5.53, 0.045) { fillColor: #0b1224, color: #4cc9f0, lineWidth: 1.5 },
  circle(-5.2, 5.638, 0.045) { fillColor: #0b1224, color: #4cc9f0, lineWidth: 1.5 },
  circle(-5.2, 5.746, 0.045) { fillColor: #0b1224, color: #4cc9f0, lineWidth: 1.5 },
  circle(-5.2, 5.854, 0.045) { fillColor: #0b1224, color: #4cc9f0, lineWidth: 1.5 }
]
wrA = group [
  circle(-4.38, 5.95, 0.45) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(-4.38, 5.95, 0.21) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  line(-4.38, 5.95, 0.21, 0) { color: #14213d, lineWidth: 3 },
  line(-4.38, 5.95, 0, 0.21) { color: #14213d, lineWidth: 3 },
  line(-4.38, 5.95, -0.21, 0) { color: #14213d, lineWidth: 3 },
  line(-4.38, 5.95, 0, -0.21) { color: #14213d, lineWidth: 3 },
  line(-4.04, 5.95, 0.12, 0) { color: #ffd166, lineWidth: 3 }
]
wfA = group [
  circle(-1.32, 5.95, 0.45) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(-1.32, 5.95, 0.21) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  line(-1.32, 5.95, 0.21, 0) { color: #14213d, lineWidth: 3 },
  line(-1.32, 5.95, 0, 0.21) { color: #14213d, lineWidth: 3 },
  line(-1.32, 5.95, -0.21, 0) { color: #14213d, lineWidth: 3 },
  line(-1.32, 5.95, 0, -0.21) { color: #14213d, lineWidth: 3 },
  line(-0.98, 5.95, 0.12, 0) { color: #ffd166, lineWidth: 3 }
]
carA : show() { startTime: 0 }
wrA : show() { startTime: 0 }
wfA : show() { startTime: 0 }
carA : move(10.4, 0) { startTime: tSlot[0], duration: enterMs, easing: "ease-out-quad" }
carA : move(1.0, 0) { startTime: tSlot[0] + enterMs, duration: crawlMs, easing: "linear" }
carA : move(10.2, 0) { startTime: tSlot[0] + enterMs + crawlMs, duration: exitMs, easing: "ease-in-quad" }
// wheels roll: angle = distance / 0.45 (23.111, 25.333, 48.0 rad in total)
wrA : parallel [ move(10.4, 0), rotate(10.4 / 0.45) ] { startTime: tSlot[0], duration: enterMs, easing: "ease-out-quad" }
wrA : parallel [ move(1.0, 0), rotate(11.4 / 0.45) ] { startTime: tSlot[0] + enterMs, duration: crawlMs, easing: "linear" }
wrA : parallel [ move(10.2, 0), rotate(21.6 / 0.45) ] { startTime: tSlot[0] + enterMs + crawlMs, duration: exitMs, easing: "ease-in-quad" }
wfA : parallel [ move(10.4, 0), rotate(10.4 / 0.45) ] { startTime: tSlot[0], duration: enterMs, easing: "ease-out-quad" }
wfA : parallel [ move(1.0, 0), rotate(11.4 / 0.45) ] { startTime: tSlot[0] + enterMs, duration: crawlMs, easing: "linear" }
wfA : parallel [ move(10.2, 0), rotate(21.6 / 0.45) ] { startTime: tSlot[0] + enterMs + crawlMs, duration: exitMs, easing: "ease-in-quad" }

// =====================================================
// CAR B: Thrust (4 rear thrusters), slot 2 - 4 s
// =====================================================
carB = group [
  path(true, -5.184, 5.44, -3.504, 5.134, -1.686, 5.47, -1.14, 5.41, -0.222, 5.752, -0.222, 6.016, -5.1, 5.992, -5.4, 5.824, -5.364, 5.494) { fillColor: #e63946, color: #ffffff, lineWidth: 2 },
  path(true, -4.5, 5.41, -3.54, 5.23, -2.28, 5.458, -2.28, 5.62, -4.5, 5.62) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 },
  rectangle(-5.43, 5.5, 0.07, 0.06) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 },
  rectangle(-5.43, 5.608, 0.07, 0.06) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 },
  rectangle(-5.43, 5.716, 0.07, 0.06) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 },
  rectangle(-5.43, 5.824, 0.07, 0.06) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 }
]
wrB = group [
  circle(-4.38, 5.95, 0.45) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(-4.38, 5.95, 0.21) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  line(-4.38, 5.95, 0.21, 0) { color: #14213d, lineWidth: 3 },
  line(-4.38, 5.95, 0, 0.21) { color: #14213d, lineWidth: 3 },
  line(-4.38, 5.95, -0.21, 0) { color: #14213d, lineWidth: 3 },
  line(-4.38, 5.95, 0, -0.21) { color: #14213d, lineWidth: 3 },
  line(-4.04, 5.95, 0.12, 0) { color: #ffd166, lineWidth: 3 }
]
wfB = group [
  circle(-1.32, 5.95, 0.45) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(-1.32, 5.95, 0.21) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  line(-1.32, 5.95, 0.21, 0) { color: #14213d, lineWidth: 3 },
  line(-1.32, 5.95, 0, 0.21) { color: #14213d, lineWidth: 3 },
  line(-1.32, 5.95, -0.21, 0) { color: #14213d, lineWidth: 3 },
  line(-1.32, 5.95, 0, -0.21) { color: #14213d, lineWidth: 3 },
  line(-0.98, 5.95, 0.12, 0) { color: #ffd166, lineWidth: 3 }
]
carB : show() { startTime: 0 }
wrB : show() { startTime: 0 }
wfB : show() { startTime: 0 }
carB : move(10.4, 0) { startTime: tSlot[1], duration: enterMs, easing: "ease-out-quad" }
carB : move(1.0, 0) { startTime: tSlot[1] + enterMs, duration: crawlMs, easing: "linear" }
carB : move(10.2, 0) { startTime: tSlot[1] + enterMs + crawlMs, duration: exitMs, easing: "ease-in-quad" }
wrB : parallel [ move(10.4, 0), rotate(10.4 / 0.45) ] { startTime: tSlot[1], duration: enterMs, easing: "ease-out-quad" }
wrB : parallel [ move(1.0, 0), rotate(11.4 / 0.45) ] { startTime: tSlot[1] + enterMs, duration: crawlMs, easing: "linear" }
wrB : parallel [ move(10.2, 0), rotate(21.6 / 0.45) ] { startTime: tSlot[1] + enterMs + crawlMs, duration: exitMs, easing: "ease-in-quad" }
wfB : parallel [ move(10.4, 0), rotate(10.4 / 0.45) ] { startTime: tSlot[1], duration: enterMs, easing: "ease-out-quad" }
wfB : parallel [ move(1.0, 0), rotate(11.4 / 0.45) ] { startTime: tSlot[1] + enterMs, duration: crawlMs, easing: "linear" }
wfB : parallel [ move(10.2, 0), rotate(21.6 / 0.45) ] { startTime: tSlot[1] + enterMs + crawlMs, duration: exitMs, easing: "ease-in-quad" }

// 4 rear jets (followers of car B)
rowsB = [5.53, 5.638, 5.746, 5.854]
for i in range(0, 4) {
  jB = path(true, -5.43, rowsB[i] - 0.035, -5.43, rowsB[i] + 0.035, -6.5, rowsB[i]) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1, opacity: 0 }
  jB : show() { startTime: tSlot[1] }
  jB : move(10.4, 0) { startTime: tSlot[1], duration: enterMs, easing: "ease-out-quad" }
  jB : move(1.0, 0) { startTime: tSlot[1] + enterMs, duration: crawlMs, easing: "linear" }
  jB : move(10.2, 0) { startTime: tSlot[1] + enterMs + crawlMs, duration: exitMs, easing: "ease-in-quad" }
  jB : morph[opacity: 0.9 * clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.85 + 0.15 * sin(60 * clamp((T - S) / D, 0, 1) + i)) * clamp(8 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tSlot[1], duration: 2000, easing: "linear" }
  jB : hide()
}

// =====================================================
// CAR C: Rocket (flies in and out), slot 4 - 6 s
// =====================================================
carC = group [
  path(true, -5.184, 5.44, -3.504, 5.134, -1.686, 5.47, -1.14, 5.41, -0.222, 5.752, -0.222, 6.016, -5.1, 5.992, -5.4, 5.824, -5.364, 5.494) { fillColor: #e63946, color: #ffffff, lineWidth: 2 },
  path(true, -4.5, 5.41, -3.54, 5.23, -2.28, 5.458, -2.28, 5.62, -4.5, 5.62) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 },
  circle(-4.38, 5.95, 0.45) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(-4.38, 5.95, 0.21) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  circle(-1.32, 5.95, 0.45) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(-1.32, 5.95, 0.21) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  path(true, -3.9, 6.0, -3.66, 6.0, -3.6, 6.12, -3.96, 6.12) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 },
  path(true, -2.07, 6.0, -1.83, 6.0, -1.77, 6.12, -2.13, 6.12) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 },
  rectangle(-5.43, 5.5, 0.07, 0.06) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 },
  rectangle(-5.43, 5.608, 0.07, 0.06) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 },
  rectangle(-5.43, 5.716, 0.07, 0.06) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 },
  rectangle(-5.43, 5.824, 0.07, 0.06) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 }
]
carC : move(0, -2.4) { startTime: 0, duration: 1 }
carC : show() { startTime: 5 }
carC : move(10.4, 1.7) { startTime: tSlot[2], duration: enterMs, easing: "ease-out-quad" }
carC : move(1.0, 0) { startTime: tSlot[2] + enterMs, duration: crawlMs, easing: "linear" }
carC : move(10.2, -2.3) { startTime: tSlot[2] + enterMs + crawlMs, duration: exitMs, easing: "ease-in-quad" }

// 2 bottom jets + 2 rear jets (followers of car C)
bx = [-3.78, -1.95]
for i in range(0, 2) {
  jD = path(true, bx[i] - 0.1, 6.12, bx[i] + 0.1, 6.12, bx[i], 6.78) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1, opacity: 0 }
  jD : move(0, -2.4) { startTime: 0, duration: 1 }
  jD : show() { startTime: 5 }
  jD : move(10.4, 1.7) { startTime: tSlot[2], duration: enterMs, easing: "ease-out-quad" }
  jD : move(1.0, 0) { startTime: tSlot[2] + enterMs, duration: crawlMs, easing: "linear" }
  jD : move(10.2, -2.3) { startTime: tSlot[2] + enterMs + crawlMs, duration: exitMs, easing: "ease-in-quad" }
  jD : morph[opacity: 0.9 * clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.85 + 0.15 * sin(60 * clamp((T - S) / D, 0, 1) + i)) * clamp(8 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tSlot[2], duration: 2000, easing: "linear" }
  jD : hide()
}
rowsC = [5.585, 5.8]
for i in range(0, 2) {
  jR = path(true, -5.43, rowsC[i] - 0.05, -5.43, rowsC[i] + 0.05, -6.6, rowsC[i]) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1, opacity: 0 }
  jR : move(0, -2.4) { startTime: 0, duration: 1 }
  jR : show() { startTime: 5 }
  jR : move(10.4, 1.7) { startTime: tSlot[2], duration: enterMs, easing: "ease-out-quad" }
  jR : move(1.0, 0) { startTime: tSlot[2] + enterMs, duration: crawlMs, easing: "linear" }
  jR : move(10.2, -2.3) { startTime: tSlot[2] + enterMs + crawlMs, duration: exitMs, easing: "ease-in-quad" }
  jR : morph[opacity: 0.9 * clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.85 + 0.15 * sin(60 * clamp((T - S) / D, 0, 1) + i)) * clamp(8 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tSlot[2], duration: 2000, easing: "linear" }
  jR : hide()
}

// =====================================================
// price tags (one per car, shown while it crawls through the centre)
// =====================================================
tagName = ["Performance", "Thrust", "Rocket"]
tagPrice = ["US$200,000 – US$250,000", "US$300,000 – US$400,000", "US$500,000 – over US$1,000,000"]
tagNote1 = ["4 rear fans · base model", "4 fans + 4 rear thrusters", "4 fans + 4 rear + 6 side thrusters"]
tagNote2 = ["deposit around US$50,000", "special package", "cold-gas thrusters + aerospace hardware"]
tagCol = [#ffd166, #4cc9f0, #ff9d2f]
for m in range(0, 3) {
  tIn = tSlot[m] + 450
  tOut = tSlot[m] + 1700
  tg = path(true, 5.5, 1.5, 10.9, 1.5, 10.9, 4.3, 5.1, 4.3, 5.1, 1.9) { fillColor: tagCol[m], color: #ffffff, lineWidth: 2 }
  hole = circle(5.5, 1.85, 0.09) { fillColor: #05070f, color: #05070f, lineWidth: 1 }
  nm = text(tagName[m], 8.0, 2.15) { color: #05070f, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
  pr = text(tagPrice[m], 8.0, 2.85) { color: #05070f, fontSize: 28, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
  n1 = text(tagNote1[m], 8.0, 3.45) { color: #05070f, fontSize: 20, fontFamily: "Georgia", textAlign: "center" }
  n2 = text(tagNote2[m], 8.0, 3.9) { color: #05070f, fontSize: 20, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
  tg : fadeIn() { startTime: tIn, duration: 200 }
  hole : fadeIn() { startTime: tIn, duration: 200 }
  nm : draw() { startTime: tIn + 100, duration: 350 }
  pr : draw() { startTime: tIn + 250, duration: 450 }
  n1 : draw() { startTime: tIn + 500, duration: 350 }
  n2 : draw() { startTime: tIn + 650, duration: 350 }
  tg : fadeOut() { startTime: tOut, duration: 250 }
  hole : fadeOut() { startTime: tOut, duration: 250 }
  nm : undraw() { startTime: tOut, duration: 250 }
  pr : undraw() { startTime: tOut, duration: 250 }
  n1 : undraw() { startTime: tOut, duration: 250 }
  n2 : undraw() { startTime: tOut, duration: 250 }
}
