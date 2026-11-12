canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tA = 0
tCar = 600
tHi = 1000
tGauge = 2400
tHop = [3200, 4700, 6200]
hopMs = 1200
tEnd = 9000

// ---------- titles ----------
title = text("Inside the car: the cold gas tank", 8, 0.8) { color: #4cc9f0, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title : draw() { startTime: tA, duration: 1000 }
title : undraw() { startTime: 2700, duration: 300 }
title2 = text("Pressure drops with every jump", 8, 0.8) { color: #ffd166, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title2 : draw() { startTime: 3000, duration: 1000 }

ground = line(0.3, 7.4, 15.4, 0) { color: #a8dadc, lineWidth: 2 }
ground : fadeIn() { startTime: 300, duration: 500 }

// ---------- car (side view, scale 0.6, rear at x = 1.5, ground y = 7.4) ----------
car = group [
  path(true, 1.716, 6.44, 3.396, 6.134, 5.214, 6.47, 5.76, 6.41, 6.678, 6.752, 6.678, 7.016, 1.8, 6.992, 1.5, 6.824, 1.536, 6.494) { fillColor: #e63946, color: #ffffff, lineWidth: 2 },
  path(true, 2.4, 6.41, 3.36, 6.23, 4.62, 6.458, 4.62, 6.62, 2.4, 6.62) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 },
  circle(2.52, 6.95, 0.45) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(2.52, 6.95, 0.21) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  circle(5.58, 6.95, 0.45) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(5.58, 6.95, 0.21) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 }
]
car : fadeIn() { startTime: tCar, duration: 600 }

// the tank sits inside the body (separate shape so it can resize and hop with the car)
tank = rectangle(3.42, 6.662, 1.38, 0.27) { fillColor: rgba(76,201,240,0.55), color: #4cc9f0, lineWidth: 2 }
tank : fadeIn() { startTime: 900, duration: 400 }

// ---------- first 3 s: resize the tank to highlight it ----------
tank : scale((2.2, 2.2)) { pivot: (4.11, 6.797), startTime: tHi + 300, duration: 700, easing: "ease-out-quad" }
tank : scale((1, 1)) { pivot: (4.11, 6.797), startTime: 2400, duration: 500, easing: "ease-in-quad" }

tankLbl = text("600 L cold gas tank", 4.1, 5.3) { color: #4cc9f0, fontSize: 28, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
tankLn = line(4.1, 5.5, 0, 0.95) { color: #4cc9f0, lineWidth: 1.5 }
tankLbl : draw() { startTime: 1500, duration: 800 }
tankLn : draw() { startTime: 1700, duration: 400 }
tankLbl : undraw() { startTime: 2500, duration: 400 }
tankLn : undraw() { startTime: 2500, duration: 400 }

// ---------- pressure gauge (centre 12.6, 2.9): left = 0 bar, right = 300 bar ----------
gGauge = circle(12.6, 2.9, 1.4) { fillColor: #0b1224, color: #4cc9f0, lineWidth: 3 }
gName = text("TANK PRESSURE", 12.6, 1.2) { color: #a8dadc, fontSize: 18, fontFamily: "Georgia", textAlign: "center" }
gGauge : fadeIn() { startTime: tGauge, duration: 500 }
gName : draw() { startTime: tGauge, duration: 600 }

tickCol = [#ff5c7a, #ff5c7a, #ff9d2f, #ffd166, #7cff6b, #7cff6b, #7cff6b]
for v in range(0, 7) {
  gAng = PI + PI * v / 6
  gtk = line(12.6 + 1.05 * cos(gAng), 2.9 + 1.05 * sin(gAng), 0.2 * cos(gAng), 0.2 * sin(gAng)) { color: tickCol[v], lineWidth: 3 }
  gtk : fadeIn() { startTime: tGauge + 200, duration: 300 }
}
gLab0 = text("0", 11.4, 3.3) { color: #a8dadc, fontSize: 16, fontFamily: "Courier New", textAlign: "center" }
gLab6 = text("300", 13.8, 3.3) { color: #a8dadc, fontSize: 16, fontFamily: "Courier New", textAlign: "center" }
gLab0 : fadeIn() { startTime: tGauge + 300, duration: 300 }
gLab6 : fadeIn() { startTime: tGauge + 300, duration: 300 }

needle = line(12.6, 2.9, 1.0, 0) { color: #ff5c7a, lineWidth: 4 }
gHub = circle(12.6, 2.9, 0.09) { fillColor: #ff5c7a, color: #ff5c7a, lineWidth: 1 }
needle : fadeIn() { startTime: tGauge + 400, duration: 300 }
gHub : fadeIn() { startTime: tGauge + 400, duration: 300 }

// needle drops after the start of each jump: 300 -> 220 -> 140 -> 60 bar
needleAng = [-PI * 80 / 300, -PI * 160 / 300, -PI * 240 / 300]
for h in range(0, 3) {
  needle : rotate(needleAng[h]) { pivot: (12.6, 2.9), startTime: tHop[h] + 100, duration: 700, easing: "ease-out-quad" }
}

// digital readout steps down as each jump ends
rdVals = [300, 220, 140, 60]
rdCol = [#7cff6b, #ffd166, #ff9d2f, #ff5c7a]
for k in range(0, 4) {
  rv = rdVals[k]
  rd = text("${rv} bar", 12.6, 3.65) { color: rdCol[k], fontSize: 26, fontFamily: "Courier New", fontWeight: "bold", textAlign: "center" }
  if (k == 0) {
    rd : fadeIn() { startTime: tGauge + 400, duration: 300 }
    rd : fadeOut() { startTime: tHop[0] + 700, duration: 200 }
  } else if (k < 3) {
    rd : fadeIn() { startTime: tHop[k - 1] + 800, duration: 200 }
    rd : fadeOut() { startTime: tHop[k] + 700, duration: 200 }
  } else {
    rd : fadeIn() { startTime: tHop[2] + 800, duration: 300 }
  }
}

// "jump n: -80 bar" tags
dlTxt = ["jump 1: −80 bar", "jump 2: −80 bar", "jump 3: −80 bar"]
for h in range(0, 3) {
  dl = text(dlTxt[h], 12.6, 4.9) { color: #ff9d2f, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
  dl : draw() { startTime: tHop[h] + 800, duration: 500 }
  if (h < 2) {
    dl : undraw() { startTime: tHop[h + 1] + 100, duration: 300 }
  }
}

// ---------- three hops: linear x + ease-out up + ease-in down (same effects on car, tank, jets) ----------
for h in range(0, 3) {
  car : move(1.3, 0) { startTime: tHop[h], duration: hopMs, easing: "linear" }
  car : move(0, -1.5) { startTime: tHop[h], duration: 600, easing: "ease-out-quad" }
  car : move(0, 1.5) { startTime: tHop[h] + 600, duration: 600, easing: "ease-in-quad" }
  tank : move(1.3, 0) { startTime: tHop[h], duration: hopMs, easing: "linear" }
  tank : move(0, -1.5) { startTime: tHop[h], duration: 600, easing: "ease-out-quad" }
  tank : move(0, 1.5) { startTime: tHop[h] + 600, duration: 600, easing: "ease-in-quad" }
}

// ---------- two cold jets under the car fire at the start of each hop ----------
jx = [3.12, 4.95]
for i in range(0, 2) {
  jo = path(true, jx[i] - 0.08, 6.99, jx[i] + 0.08, 6.99, jx[i], 7.45) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1, opacity: 0 }
  jc = path(true, jx[i] - 0.04, 6.99, jx[i] + 0.04, 6.99, jx[i], 7.3) { fillColor: #e8fbff, color: #e8fbff, lineWidth: 1, opacity: 0 }
  jo : show() { startTime: tHop[0] }
  jc : show() { startTime: tHop[0] }
  for h in range(0, 3) {
    jo : move(1.3, 0) { startTime: tHop[h], duration: hopMs, easing: "linear" }
    jc : move(1.3, 0) { startTime: tHop[h], duration: hopMs, easing: "linear" }
    jo : move(0, -1.5) { startTime: tHop[h], duration: 600, easing: "ease-out-quad" }
    jc : move(0, -1.5) { startTime: tHop[h], duration: 600, easing: "ease-out-quad" }
    jo : move(0, 1.5) { startTime: tHop[h] + 600, duration: 600, easing: "ease-in-quad" }
    jc : move(0, 1.5) { startTime: tHop[h] + 600, duration: 600, easing: "ease-in-quad" }
    jo : morph[opacity: 0.9 * clamp(5 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.85 + 0.15 * sin(60 * clamp((T - S) / D, 0, 1) + i))] { startTime: tHop[h], duration: 700, easing: "linear" }
    jc : morph[opacity: clamp(5 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.9 + 0.1 * sin(70 * clamp((T - S) / D, 0, 1) + i))] { startTime: tHop[h], duration: 700, easing: "linear" }
  }
  jo : hide() { startTime: 7800 }
  jc : hide() { startTime: 7800 }
}

// ---------- captions ----------
cap1 = text("each jump = a burst of cold gas from the tank", 8, 8.2) { color: #4cc9f0, fontSize: 26, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
cap1 : draw() { startTime: 3000, duration: 1400 }
cap1 : undraw() { startTime: 7300, duration: 300 }

lowTxt = text("LOW PRESSURE", 12.6, 6.0) { color: #ff5c7a, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
lowTxt : draw() { startTime: 7400, duration: 700 }

noteEst = text("illustrative, estimated values", 8, 8.85) { color: #a8dadc, fontSize: 14, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
noteEst : fadeIn() { startTime: 300, duration: 500 }

// ---------- conclusion (last effect ends at 9000) ----------
endTxt = text("Every jump spends gas, so the tank pressure keeps dropping", 8, 8.2) { color: #ffd166, fontSize: 28, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
endTxt : draw() { startTime: 7600, duration: 1400 }
