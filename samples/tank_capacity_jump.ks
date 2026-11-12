canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tA = 0
tCar = 300
tGauge = 1000
tLbl = 1400
tJ = 3000
drainMs = 2400
tUp = 1800
tDownStart = tJ + tUp
tLand = tJ + 3600
tNote = 9000
tEnd = 12000

// ---------- titles ----------
title = text("Cold gas tank: 600 L", 8, 0.8) { color: #4cc9f0, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title : draw() { startTime: tA, duration: 900 }
title : hide() { startTime: tNote }
title2 = text("A jump, not a flight", 8, 0.8) { color: #ffd166, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title2 : draw() { startTime: tNote, duration: 900 }

ground = line(0.3, 7.4, 15.4, 0) { color: #a8dadc, lineWidth: 2 }
ground : show() { startTime: 100 }

// ---------- car (side view, scale 0.55, rear at x = 1.5, ground y = 7.4) ----------
car = group [
  path(true, 1.698, 6.52, 3.238, 6.24, 4.905, 6.548, 5.405, 6.493, 6.247, 6.806, 6.247, 7.048, 1.775, 7.026, 1.5, 6.872, 1.533, 6.57) { fillColor: #e63946, color: #ffffff, lineWidth: 2 },
  path(true, 2.325, 6.493, 3.205, 6.328, 4.36, 6.537, 4.36, 6.685, 2.325, 6.685) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 },
  rectangle(3.26, 6.724, 1.265, 0.248) { fillColor: rgba(76,201,240,0.45), color: #4cc9f0, lineWidth: 2 },
  circle(2.435, 6.988, 0.413) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(2.435, 6.988, 0.193) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  circle(5.24, 6.988, 0.413) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(5.24, 6.988, 0.193) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 }
]
car : show() { startTime: tCar }

// tank label before the jump
tankLn = line(3.7, 5.3, 0.19, 1.3) { color: #4cc9f0, lineWidth: 1.5 }
tankTxt = text("600 L cold gas tank", 3.7, 5.05) { color: #4cc9f0, fontSize: 26, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
tankLn : draw() { startTime: tLbl, duration: 400 }
tankTxt : draw() { startTime: tLbl, duration: 800 }
tankLn : hide() { startTime: tJ }
tankTxt : hide() { startTime: tJ }

// ---------- gauge (centre 13.2, 2.9): left = empty (0), right = full (600) ----------
gauge = circle(13.2, 2.9, 1.3) { fillColor: #0b1224, color: #4cc9f0, lineWidth: 3 }
gauge : show() { startTime: tGauge }
gName = text("COLD GAS TANK", 13.2, 1.3) { color: #a8dadc, fontSize: 18, fontFamily: "Georgia", textAlign: "center" }
gName : draw() { startTime: tGauge, duration: 700 }

tickCol = [#ff5c7a, #ff9d2f, #ffd166, #ffd166, #7cff6b, #7cff6b, #7cff6b]
for v in range(0, 7) {
  gAng = PI + PI * v / 6
  gtk = line(13.2 + 1.0 * cos(gAng), 2.9 + 1.0 * sin(gAng), 0.2 * cos(gAng), 0.2 * sin(gAng)) { color: tickCol[v], lineWidth: 3 }
  gtk : show() { startTime: tGauge + 300 }
}
gLab0 = text("0", 12.1, 3.3) { color: #a8dadc, fontSize: 16, fontFamily: "Courier New", textAlign: "center" }
gLab6 = text("600", 14.3, 3.3) { color: #a8dadc, fontSize: 16, fontFamily: "Courier New", textAlign: "center" }
gLab0 : show() { startTime: tGauge + 400 }
gLab6 : show() { startTime: tGauge + 400 }

needle = line(13.2, 2.9, 0.95, 0) { color: #ff5c7a, lineWidth: 4 }
gHub = circle(13.2, 2.9, 0.09) { fillColor: #ff5c7a, color: #ff5c7a, lineWidth: 1 }
needle : show() { startTime: tGauge + 500 }
gHub : show() { startTime: tGauge + 500 }
needle : rotate(-PI) { pivot: (13.2, 2.9), startTime: tJ, duration: drainMs, easing: "linear" }

// digital readout: 600 L, 540 L, ... 0 L (one step per 240 ms)
for k in range(0, 11) {
  rdVal = 600 - 60 * k
  rd = text("${rdVal} L", 13.2, 3.65) { color: #ffd166, fontSize: 26, fontFamily: "Courier New", fontWeight: "bold", textAlign: "center" }
  if (k == 0) {
    rd : show() { startTime: tGauge + 500 }
    rd : hide() { startTime: tJ + 240 }
  } else if (k < 10) {
    rd : show() { startTime: tJ + 240 * k }
    rd : hide() { startTime: tJ + 240 * (k + 1) }
  } else {
    rd : show() { startTime: tJ + 240 * k }
  }
}

emptyTxt = text("TANK EMPTY", 13.2, 4.8) { color: #ff5c7a, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
emptyTxt : draw() { startTime: tJ + drainMs, duration: 700 }

// ---------- the jump: parabola = linear x + ease-out up + ease-in down ----------
car : move(5.2, 0) { startTime: tJ, duration: 3600, easing: "linear" }
car : move(0, -2.6) { startTime: tJ, duration: tUp, easing: "ease-out-quad" }
car : move(0, 2.6) { startTime: tDownStart, duration: tUp, easing: "ease-in-quad" }

// ---------- 4 downward cold jets (outer plume + core), followers of the car ----------
jx = [2.985, 3.106, 4.662, 4.784]
for i in range(0, 4) {
  jo = path(true, jx[i] - 0.08, 7.03, jx[i] + 0.08, 7.03, jx[i], 7.58) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1, opacity: 0 }
  jc = path(true, jx[i] - 0.04, 7.03, jx[i] + 0.04, 7.03, jx[i], 7.4) { fillColor: #e8fbff, color: #e8fbff, lineWidth: 1, opacity: 0 }
  jo : show() { startTime: tJ }
  jc : show() { startTime: tJ }
  jo : move(5.2, 0) { startTime: tJ, duration: 3600, easing: "linear" }
  jc : move(5.2, 0) { startTime: tJ, duration: 3600, easing: "linear" }
  jo : move(0, -2.6) { startTime: tJ, duration: tUp, easing: "ease-out-quad" }
  jc : move(0, -2.6) { startTime: tJ, duration: tUp, easing: "ease-out-quad" }
  jo : move(0, 2.6) { startTime: tDownStart, duration: tUp, easing: "ease-in-quad" }
  jc : move(0, 2.6) { startTime: tDownStart, duration: tUp, easing: "ease-in-quad" }
  jo : morph[opacity: 0.9 * clamp(6 * clamp((T - S) / D, 0, 1), 0, 1) * (0.85 + 0.15 * sin(60 * clamp((T - S) / D, 0, 1) + i)) * clamp(6 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tJ, duration: drainMs, easing: "linear" }
  jc : morph[opacity: clamp(6 * clamp((T - S) / D, 0, 1), 0, 1) * (0.9 + 0.1 * sin(70 * clamp((T - S) / D, 0, 1) + i)) * clamp(6 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tJ, duration: drainMs, easing: "linear" }
  jo : hide()
  jc : hide()
}

// ---------- captions during the jump ----------
capGo = text("jump! the gas pours out through the thrusters", 8, 8.3) { color: #a8dadc, fontSize: 26, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
capGo : draw() { startTime: tJ, duration: 1400 }
capGo : hide() { startTime: tJ + drainMs + 800 }
capUsed = text("all 600 L used up in one jump", 8, 8.3) { color: #ff9d2f, fontSize: 28, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
capUsed : draw() { startTime: 6000, duration: 1400 }
capUsed : hide() { startTime: tNote }

noteEst = text("illustrative, estimated values", 8, 8.85) { color: #a8dadc, fontSize: 14, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
noteEst : show() { startTime: tGauge }

// ---------- final 3 s: the jump path, FLYING struck out, JUMPING ----------
trace = path(false, 3.97, 6.66, 4.23, 6.16, 4.49, 5.72, 4.75, 5.33, 5.01, 4.99, 5.27, 4.71, 5.53, 4.47, 5.79, 4.29, 6.05, 4.16, 6.31, 4.08, 6.57, 4.06, 6.83, 4.08, 7.09, 4.16, 7.35, 4.29, 7.61, 4.47, 7.87, 4.71, 8.13, 4.99, 8.39, 5.33, 8.65, 5.72, 8.91, 6.16, 9.17, 6.66) { color: #ffd166, lineWidth: 3 }
trace : draw() { startTime: tNote, duration: 1200, easing: "ease-in-out-sine" }

flyTxt = text("FLYING", 5.2, 2.3) { color: #a8dadc, fontSize: 44, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
flyTxt : show() { startTime: tNote + 500 }
strike = line(3.8, 2.1, 2.8, 0) { color: #ff5c7a, lineWidth: 3 }
strike : draw() { startTime: tNote + 900, duration: 500 }

jumpTxt = text("JUMPING", 8.8, 2.3) { color: #7cff6b, fontSize: 44, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
jumpTxt : draw() { startTime: tNote + 1400, duration: 800 }

endTxt = text("The gas runs out in seconds: a short hop, not a flight", 8, 8.3) { color: #ffd166, fontSize: 28, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
endTxt : draw() { startTime: 10800, duration: 1200 }
