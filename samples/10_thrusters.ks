canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tA = 0
tCar = 300
tLift = 1500
riseMs = 1200
tFz = 4200
tUn = 5700
tDown = 6700
downMs = 1400
tLand = 8100
tEnd = 10000

// ---------- title ----------
title = text("10 thrusters hold the car up", 8, 0.8) { color: #ffd166, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title : draw() { startTime: tA, duration: 1000 }

ground = line(0.3, 7.0, 15.4, 0) { color: #a8dadc, lineWidth: 2 }
ground : show() { startTime: tA + 200 }

// ---------- car (side view, scale 0.65, rear at x = 2.9, ground y = 7.0) ----------
car = group [
  path(true, 3.134, 5.96, 4.954, 5.629, 6.924, 5.992, 7.515, 5.928, 8.509, 6.298, 8.509, 6.584, 3.225, 6.558, 2.9, 6.376, 2.939, 6.019) { fillColor: #e63946, color: #ffffff, lineWidth: 2 },
  path(true, 3.875, 5.928, 4.915, 5.732, 6.28, 5.979, 6.28, 6.155, 3.875, 6.155) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 },
  rectangle(4.98, 6.2, 1.495, 0.293) { fillColor: rgba(76,201,240,0.3), color: #4cc9f0, lineWidth: 2 },
  rectangle(4.575, 6.53, 0.16, 0.07) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  rectangle(4.718, 6.53, 0.16, 0.07) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  rectangle(6.558, 6.53, 0.16, 0.07) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  rectangle(6.7, 6.53, 0.16, 0.07) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  rectangle(2.89, 6.0, 0.06, 0.12) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  rectangle(2.87, 6.15, 0.06, 0.12) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  rectangle(2.86, 6.3, 0.06, 0.12) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  rectangle(3.06, 6.45, 0.06, 0.12) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(7.807, 6.331, 0.17) { fillColor: #0b1224, color: #4cc9f0, lineWidth: 2 },
  circle(7.807, 6.331, 0.05) { fillColor: #a8dadc, color: #a8dadc, lineWidth: 1 },
  circle(8.133, 6.35, 0.17) { fillColor: #0b1224, color: #4cc9f0, lineWidth: 2 },
  circle(8.133, 6.35, 0.05) { fillColor: #a8dadc, color: #a8dadc, lineWidth: 1 },
  circle(4.005, 6.513, 0.488) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(4.005, 6.513, 0.227) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  circle(7.32, 6.513, 0.488) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(7.32, 6.513, 0.227) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 }
]
car : show() { startTime: tCar }
car : move(0, -1.6) { startTime: tLift, duration: riseMs, easing: "ease-out-quad" }
car : move(0, 1.6) { startTime: tDown, duration: downMs, easing: "ease-in-out-quad" }

// ---------- 4 downward jets (2 front, 2 rear; far side offset) ----------
downX = [4.655, 4.798, 6.638, 6.78]
for i in range(0, 4) {
  jd = path(true, downX[i] - 0.08, 6.56, downX[i] + 0.08, 6.56, downX[i], 7.06) { fillColor: #a8dadc, color: #a8dadc, lineWidth: 1, opacity: 0 }
  jd : show() { startTime: tLift }
  jd : move(0, -1.6) { startTime: tLift, duration: riseMs, easing: "ease-out-quad" }
  jd : move(0, 1.6) { startTime: tDown, duration: downMs, easing: "ease-in-out-quad" }
  jd : morph[opacity: clamp(6 * clamp((T - S) / D, 0, 1), 0, 1) * (0.8 + 0.15 * sin(28 * PI * clamp((T - S) / D, 0, 1)))] { startTime: tLift, duration: tFz - tLift, easing: "linear" }
  jd : morph[opacity: (0.8 + 0.15 * sin(24 * PI * clamp((T - S) / D, 0, 1))) * clamp(5 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tUn, duration: tLand - tUn, easing: "linear" }
  jd : hide()
}

// ---------- 4 rear jets (pointing back, to the left) ----------
rearX = [2.93, 2.91, 2.9, 3.1]
rearY = [6.058, 6.207, 6.357, 6.506]
for i in range(0, 4) {
  jr = path(true, rearX[i], rearY[i] - 0.055, rearX[i], rearY[i] + 0.055, rearX[i] - 1.0, rearY[i]) { fillColor: #a8dadc, color: #a8dadc, lineWidth: 1, opacity: 0 }
  jr : show() { startTime: tLift }
  jr : move(0, -1.6) { startTime: tLift, duration: riseMs, easing: "ease-out-quad" }
  jr : move(0, 1.6) { startTime: tDown, duration: downMs, easing: "ease-in-out-quad" }
  jr : morph[opacity: clamp(6 * clamp((T - S) / D, 0, 1), 0, 1) * (0.8 + 0.15 * sin(28 * PI * clamp((T - S) / D, 0, 1)))] { startTime: tLift, duration: tFz - tLift, easing: "linear" }
  jr : morph[opacity: (0.8 + 0.15 * sin(24 * PI * clamp((T - S) / D, 0, 1))) * clamp(5 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tUn, duration: tLand - tUn, easing: "linear" }
  jr : hide()
}

// ---------- 2 sideways thrusters (pulsing rings: jets toward and away from the viewer) ----------
latX = [7.807, 8.133]
latY = [6.331, 6.35]
for i in range(0, 2) {
  jl = circle(latX[i], latY[i], 0.12) { fillColor: rgba(168,222,220,0.15), color: #a8dadc, lineWidth: 2, opacity: 0 }
  jl : show() { startTime: tLift }
  jl : move(0, -1.6) { startTime: tLift, duration: riseMs, easing: "ease-out-quad" }
  jl : move(0, 1.6) { startTime: tDown, duration: downMs, easing: "ease-in-out-quad" }
  jl : morph[opacity: clamp(6 * clamp((T - S) / D, 0, 1), 0, 1) * 0.9] { startTime: tLift, duration: tFz - tLift, easing: "linear" }
  jl : morph[radius: 0.12 + 0.1 * abs(sin(14 * PI * clamp((T - S) / D, 0, 1)))] { startTime: tLift, duration: tFz - tLift, easing: "linear" }
  jl : morph[opacity: 0.9 * clamp(5 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tUn, duration: tLand - tUn, easing: "linear" }
  jl : morph[radius: 0.12 + 0.1 * abs(sin(12 * PI * clamp((T - S) / D, 0, 1)))] { startTime: tUn, duration: tLand - tUn, easing: "linear" }
  jl : hide()
}

// ---------- caption while hovering ----------
syncTxt = text("all 10 fire in sync", 8, 8.2) { color: #a8dadc, fontSize: 26, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
syncTxt : draw() { startTime: 2800, duration: 900 }
syncTxt : hide() { startTime: tFz }

// ---------- freeze frame: number the 10 thrusters (hover height = 1.6 above start) ----------
frzTag = text("FREEZE FRAME", 13.4, 0.8) { color: #ffd166, fontSize: 22, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
frzTag : show() { startTime: tFz }
frzTag : hide() { startTime: tUn }

// badges: 1-4 down, 5-6 sideways, 7-10 rear
bx = [4.4, 5.0, 6.4, 7.0, 7.6, 8.5, 0.8, 0.8, 0.8, 0.8]
by = [6.2, 6.2, 6.2, 6.2, 3.5, 3.5, 3.9, 4.5, 5.1, 5.7]
// leader lines: start (lx, ly), then (dx, dy) to the thruster
lx = [4.4, 5.0, 6.4, 7.0, 7.6, 8.5, 1.0, 1.0, 1.0, 1.0]
ly = [5.98, 5.98, 5.98, 5.98, 3.7, 3.7, 3.9, 4.5, 5.1, 5.7]
ldx = [0.255, -0.202, 0.238, -0.22, 0.207, -0.367, 0.93, 0.91, 0.9, 1.1]
ldy = [-0.5, -0.5, -0.5, -0.5, 1.03, 1.05, 0.558, 0.107, -0.343, -0.794]
bcol = [#4cc9f0, #4cc9f0, #4cc9f0, #4cc9f0, #ffd166, #ffd166, #7cff6b, #7cff6b, #7cff6b, #7cff6b]
for i in range(0, 10) {
  tShow = tFz + 100 + 90 * i
  ld = line(lx[i], ly[i], ldx[i], ldy[i]) { color: bcol[i], lineWidth: 1.5 }
  bd = circle(bx[i], by[i], 0.2) { fillColor: #05070f, color: bcol[i], lineWidth: 2.5 }
  bn = text("${i + 1}", bx[i], by[i]) { color: bcol[i], fontSize: 20, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
  ld : show() { startTime: tShow }
  bd : show() { startTime: tShow }
  bn : show() { startTime: tShow }
  ld : hide() { startTime: tUn }
  bd : hide() { startTime: tUn }
  bn : hide() { startTime: tUn }
}

// ---------- freeze frame: tank label and legend ----------
tankLn = line(4.9, 3.3, 0.5, 1.3) { color: #4cc9f0, lineWidth: 1.5 }
tankTxt = text("600 L cold air tank", 4.4, 3.05) { color: #4cc9f0, fontSize: 26, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
tankLn : draw() { startTime: tFz + 900, duration: 400 }
tankTxt : draw() { startTime: tFz + 900, duration: 700 }
tankLn : hide() { startTime: tUn }
tankTxt : hide() { startTime: tUn }

cnt = text("10 thrusters", 12.8, 2.6) { color: #ffd166, fontSize: 46, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
lgD = text("1 - 4   downward", 12.8, 3.5) { color: #4cc9f0, fontSize: 26, fontFamily: "Georgia", textAlign: "center" }
lgS = text("5 - 6   sideways", 12.8, 4.1) { color: #ffd166, fontSize: 26, fontFamily: "Georgia", textAlign: "center" }
lgR = text("7 - 10   rear", 12.8, 4.7) { color: #7cff6b, fontSize: 26, fontFamily: "Georgia", textAlign: "center" }
cnt : draw() { startTime: tFz + 400, duration: 700 }
lgD : draw() { startTime: tFz + 800, duration: 500 }
lgS : draw() { startTime: tFz + 1100, duration: 500 }
lgR : draw() { startTime: tFz + 1400, duration: 500 }
cnt : hide() { startTime: tUn }
lgD : hide() { startTime: tUn }
lgS : hide() { startTime: tUn }
lgR : hide() { startTime: tUn }

// ---------- closing caption (last effect ends at 10000) ----------
endTxt = text("Cold air + 10 synchronized thrusters = a controlled hover", 8, 8.3) { color: #ffd166, fontSize: 28, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
endTxt : draw() { startTime: 8400, duration: 1600 }
