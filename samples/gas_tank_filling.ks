canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tA = 0
tCar = 300
tFill1 = 1000
tHose = 2900
tRun = 3300
tPump = 3600
tPumpEnd = 9000
tEnd = 10000

// ---------- titles ----------
title1 = text("Filling 1: external gas supply", 8, 0.8) { color: #ffd166, fontSize: 34, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title1 : draw() { startTime: tA, duration: 1000 }
title1 : undraw() { startTime: 2700, duration: 300 }
title2 = text("Filling 2: onboard pump, while driving", 8, 0.8) { color: #7cff6b, fontSize: 34, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title2 : draw() { startTime: 3000, duration: 1000 }

// ---------- road ----------
ground = line(0.3, 7.3, 15.4, 0) { color: #a8dadc, lineWidth: 2 }
ground : fadeIn() { startTime: 300, duration: 500 }
for i in range(0, 22) {
  dash = line(0.3 + 1.2 * i, 7.7, 0.6, 0) { color: #a8dadc, lineWidth: 3 }
  dash : fadeIn() { startTime: 300, duration: 500 }
  dash : move(-8, 0) { startTime: tRun, duration: tEnd - tRun, easing: "ease-in-quad" }
}

// ---------- car (side view, scale 0.75, rear at x = 3.5, ground y = 7.3) ----------
car = group [
  path(true, 3.77, 6.1, 5.87, 5.718, 8.143, 6.138, 8.825, 6.062, 9.973, 6.49, 9.973, 6.82, 3.875, 6.79, 3.5, 6.58, 3.545, 6.168) { fillColor: #e63946, color: #ffffff, lineWidth: 2 },
  path(true, 4.625, 6.062, 5.825, 5.838, 7.4, 6.123, 7.4, 6.325, 4.625, 6.325) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 }
]
car : fadeIn() { startTime: tCar, duration: 600 }

wheelR = group [
  circle(4.775, 6.737, 0.5625) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(4.775, 6.737, 0.3) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  line(4.775, 6.737, 0.3, 0) { color: #14213d, lineWidth: 3 },
  line(4.775, 6.737, 0, 0.3) { color: #14213d, lineWidth: 3 },
  line(4.775, 6.737, -0.3, 0) { color: #14213d, lineWidth: 3 },
  line(4.775, 6.737, 0, -0.3) { color: #14213d, lineWidth: 3 },
  line(5.155, 6.737, 0.18, 0) { color: #ffd166, lineWidth: 3 }
]
wheelF = group [
  circle(8.6, 6.737, 0.5625) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(8.6, 6.737, 0.3) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  line(8.6, 6.737, 0.3, 0) { color: #14213d, lineWidth: 3 },
  line(8.6, 6.737, 0, 0.3) { color: #14213d, lineWidth: 3 },
  line(8.6, 6.737, -0.3, 0) { color: #14213d, lineWidth: 3 },
  line(8.6, 6.737, 0, -0.3) { color: #14213d, lineWidth: 3 },
  line(8.98, 6.737, 0.18, 0) { color: #ffd166, lineWidth: 3 }
]
wheelR : fadeIn() { startTime: tCar + 200, duration: 500 }
wheelF : fadeIn() { startTime: tCar + 200, duration: 500 }
// the car runs from 3.3 s: wheel angle = road distance 8 / radius 0.5625
wheelR : rotate(8 / 0.5625) { pivot: (4.775, 6.737), startTime: tRun, duration: tEnd - tRun, easing: "ease-in-quad" }
wheelF : rotate(8 / 0.5625) { pivot: (8.6, 6.737), startTime: tRun, duration: tEnd - tRun, easing: "ease-in-quad" }

// ---------- tank with a fill level that grows from its left edge ----------
tank = rectangle(5.9, 6.378, 1.725, 0.3375) { fillColor: #0b1224, color: #4cc9f0, lineWidth: 2 }
fill = rectangle(5.95, 6.4, 1.625, 0.29) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 }
tank : fadeIn() { startTime: 600, duration: 400 }
fill : scale((0.2, 1)) { pivot: (5.95, 6.545), startTime: 0, duration: 1 }
fill : fadeIn() { startTime: 600, duration: 400 }
fill : scale((0.6, 1)) { pivot: (5.95, 6.545), startTime: tFill1, duration: 2000, easing: "linear" }
fill : scale((1, 1)) { pivot: (5.95, 6.545), startTime: tPump, duration: tPumpEnd - tPump, easing: "linear" }
tankLbl = text("600 L tank", 6.76, 7.05) { color: #4cc9f0, fontSize: 20, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
tankLbl : draw() { startTime: 700, duration: 600 }

// ---------- pipe from the rear port to the tank ----------
port = rectangle(3.4, 6.5, 0.15, 0.16) { fillColor: #ffd166, color: #ffd166, lineWidth: 1 }
inPipe = path(false, 3.55, 6.58, 5.9, 6.55) { color: #cfd8dc, lineWidth: 3 }
port : fadeIn() { startTime: 800, duration: 300 }
inPipe : draw() { startTime: 800, duration: 400 }

// ---------- PART 1 (0 - 3 s): external gas supply ----------
cyl = rectangle(0.6, 5.3, 1.1, 2.0) { fillColor: #2b3a55, color: #ffffff, lineWidth: 2 }
cylCap = rectangle(0.9, 5.05, 0.5, 0.25) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 }
hose = path(false, 1.7, 5.6, 2.9, 5.6, 3.15, 6.58, 3.4, 6.58) { color: #cfd8dc, lineWidth: 5 }
cylLbl = text("external gas", 1.15, 4.7) { color: #ffd166, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
cyl : fadeIn() { startTime: 400, duration: 500 }
cylCap : fadeIn() { startTime: 400, duration: 500 }
hose : draw() { startTime: 800, duration: 500 }
cylLbl : draw() { startTime: 700, duration: 600 }
cyl : fadeOut() { startTime: tHose, duration: 400 }
cylCap : fadeOut() { startTime: tHose, duration: 400 }
hose : fadeOut() { startTime: tHose, duration: 400 }
cylLbl : undraw() { startTime: tHose, duration: 400 }

// gas dots follow the hose and the pipe into the tank
guide = path(false, 1.7, 5.6, 2.9, 5.6, 3.15, 6.58, 3.55, 6.58, 5.9, 6.55) { color: #ffd166, lineWidth: 1 }
for i in range(0, 8) {
  gd = circle(1.7, 5.6, 0.08) { fillColor: #ffd166, color: #ffd166, lineWidth: 1, opacity: 0 }
  gd : show() { startTime: 1000 + 250 * i }
  gd : morph[opacity: 0.9] { startTime: 1000 + 250 * i, duration: 1 }
  gd : follow(guide) { orient: false, startTime: 1000 + 250 * i, duration: 1100, easing: "linear" }
  gd : hide()
}

cap1 = text("gas from outside fills the tank", 8, 8.2) { color: #ffd166, fontSize: 26, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
cap1 : draw() { startTime: 1200, duration: 1400 }
cap1 : undraw() { startTime: 2900, duration: 300 }

// ---------- PART 2 (3 - 10 s): onboard pump, while the car runs ----------
pump = circle(6.9, 4.0, 0.35) { fillColor: #2b3a55, color: #7cff6b, lineWidth: 3 }
crank = group [
  line(6.9, 4.0, 0.26, 0) { color: #7cff6b, lineWidth: 4 },
  circle(7.16, 4.0, 0.06) { fillColor: #7cff6b, color: #7cff6b, lineWidth: 1 }
]
pPipe = line(6.9, 4.35, 0, 2.03) { color: #4cc9f0, lineWidth: 3 }
pLbl = text("onboard pump", 6.9, 3.3) { color: #7cff6b, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
pSub = text("runs on the battery", 6.9, 2.85) { color: #ffd166, fontSize: 20, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
pump : fadeIn() { startTime: tRun, duration: 400 }
crank : fadeIn() { startTime: tRun, duration: 400 }
pPipe : draw() { startTime: tRun + 200, duration: 500 }
pLbl : draw() { startTime: tRun + 400, duration: 700 }
pSub : draw() { startTime: tRun + 900, duration: 700 }
crank : rotate(26 * PI) { pivot: (6.9, 4.0), startTime: tPump, duration: tPumpEnd - tPump, easing: "ease-in-quad" }

for i in range(0, 18) {
  pd = circle(6.9, 4.4, 0.07) { fillColor: #e8fbff, color: #e8fbff, lineWidth: 1, opacity: 0 }
  pd : show() { startTime: tPump + 300 * i }
  pd : morph[opacity: 0.9] { startTime: tPump + 300 * i, duration: 1 }
  pd : move(0, 1.95) { startTime: tPump + 300 * i, duration: 650, easing: "linear" }
  pd : hide()
}

cap2 = text("the pump keeps filling the tank while the car runs", 8, 8.2) { color: #7cff6b, fontSize: 26, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
cap2 : draw() { startTime: 4200, duration: 1800 }
cap2 : undraw() { startTime: 8500, duration: 300 }

// ---------- pressure gauge (centre 13.0, 2.9): 0 to 300 bar ----------
gGauge = circle(13.0, 2.9, 1.4) { fillColor: #0b1224, color: #4cc9f0, lineWidth: 3 }
gName = text("TANK PRESSURE", 13.0, 1.3) { color: #a8dadc, fontSize: 18, fontFamily: "Georgia", textAlign: "center" }
gGauge : fadeIn() { startTime: 500, duration: 400 }
gName : draw() { startTime: 500, duration: 600 }
tickCol = [#ff5c7a, #ff5c7a, #ff9d2f, #ffd166, #7cff6b, #7cff6b, #7cff6b]
for v in range(0, 7) {
  gAng = PI + PI * v / 6
  gtk = line(13.0 + 1.05 * cos(gAng), 2.9 + 1.05 * sin(gAng), 0.2 * cos(gAng), 0.2 * sin(gAng)) { color: tickCol[v], lineWidth: 3 }
  gtk : fadeIn() { startTime: 700, duration: 300 }
}
gLab0 = text("0", 11.8, 3.3) { color: #a8dadc, fontSize: 16, fontFamily: "Courier New", textAlign: "center" }
gLab6 = text("300", 14.2, 3.3) { color: #a8dadc, fontSize: 16, fontFamily: "Courier New", textAlign: "center" }
gLab0 : fadeIn() { startTime: 800, duration: 300 }
gLab6 : fadeIn() { startTime: 800, duration: 300 }

needle = line(13.0, 2.9, 1.0, 0) { color: #ff5c7a, lineWidth: 4 }
gHub = circle(13.0, 2.9, 0.09) { fillColor: #ff5c7a, color: #ff5c7a, lineWidth: 1 }
needle : rotate(-PI * 0.8) { pivot: (13.0, 2.9), startTime: 0, duration: 1 }
needle : fadeIn() { startTime: 800, duration: 300 }
gHub : fadeIn() { startTime: 800, duration: 300 }
// 60 -> 180 bar (external), then 180 -> 300 bar (pump)
needle : rotate(-PI * 120 / 300) { pivot: (13.0, 2.9), startTime: tFill1, duration: 2000, easing: "linear" }
needle : rotate(0) { pivot: (13.0, 2.9), startTime: tPump, duration: tPumpEnd - tPump, easing: "linear" }

// stepped readout
rdVals = [60, 100, 140, 180, 220, 260, 300]
rdT = [800, 1667, 2333, 3000, 5400, 7200, 9000]
rdCol = [#ff5c7a, #ff9d2f, #ffd166, #ffd166, #a8dadc, #7cff6b, #7cff6b]
for k in range(0, 7) {
  rv = rdVals[k]
  rd = text("${rv} bar", 13.0, 3.65) { color: rdCol[k], fontSize: 26, fontFamily: "Courier New", fontWeight: "bold", textAlign: "center" }
  if (k == 0) {
    rd : fadeIn() { startTime: rdT[0], duration: 200 }
    rd : fadeOut() { startTime: rdT[1], duration: 150 }
  } else if (k < 6) {
    rd : fadeIn() { startTime: rdT[k], duration: 150 }
    rd : fadeOut() { startTime: rdT[k + 1], duration: 150 }
  } else {
    rd : fadeIn() { startTime: rdT[6], duration: 200 }
  }
}

fullTxt = text("FULL", 13.0, 4.9) { color: #7cff6b, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
fullTxt : draw() { startTime: 9000, duration: 600 }

noteEst = text("illustrative, estimated values", 8, 8.85) { color: #a8dadc, fontSize: 14, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
noteEst : fadeIn() { startTime: 300, duration: 500 }

// ---------- conclusion (last effect ends at 10000) ----------
endTxt = text("Fill at the station, top up on the move", 8, 8.2) { color: #ffd166, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
endTxt : draw() { startTime: 8900, duration: 1100 }
