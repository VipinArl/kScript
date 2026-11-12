canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tA = 0
tCar = 1000
tLaunch = 2200
spinMs = 4300
tNeed = 4200
tEnd = 10000

// ---------- title ----------
title = text("Why wheels alone are not enough", 8, 0.8) { color: #ffd166, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title : draw() { startTime: tA, duration: 1000 }

// ---------- road (treadmill): ground line + dashes that scroll left ----------
ground = line(0.3, 6.2, 15.4, 0) { color: #a8dadc, lineWidth: 2 }
ground : fadeIn() { startTime: 300, duration: 500 }
for i in range(0, 14) {
  dash = line(0.3 + 1.2 * i, 6.6, 0.6, 0) { color: #a8dadc, lineWidth: 3 }
  dash : fadeIn() { startTime: 300, duration: 500 }
  dash : move(-0.6, 0) { startTime: tLaunch, duration: spinMs, easing: "ease-in-quad" }
}

// ---------- car (side view, scale 0.75, rear at x = 1.5, ground y = 6.2) ----------
carBody = group [
  path(true, 1.77, 5.0, 3.87, 4.618, 6.143, 5.038, 6.825, 4.963, 7.972, 5.39, 7.972, 5.72, 1.875, 5.69, 1.5, 5.48, 1.545, 5.068) { fillColor: #e63946, color: #ffffff, lineWidth: 2 },
  path(true, 2.625, 4.963, 3.825, 4.738, 5.4, 5.023, 5.4, 5.225, 2.625, 5.225) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 }
]
carBody : fadeIn() { startTime: tCar, duration: 700 }

// rear wheel (driven)
wheelR = group [
  circle(2.775, 5.638, 0.5625) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(2.775, 5.638, 0.3) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  line(2.775, 5.638, 0.3, 0) { color: #14213d, lineWidth: 3 },
  line(2.775, 5.638, 0, 0.3) { color: #14213d, lineWidth: 3 },
  line(2.775, 5.638, -0.3, 0) { color: #14213d, lineWidth: 3 },
  line(2.775, 5.638, 0, -0.3) { color: #14213d, lineWidth: 3 },
  line(3.155, 5.638, 0.18, 0) { color: #ffd166, lineWidth: 3 },
  line(2.395, 5.638, -0.18, 0) { color: #ffd166, lineWidth: 3 }
]
// front wheel (just rolls with the road)
wheelF = group [
  circle(6.6, 5.638, 0.5625) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(6.6, 5.638, 0.3) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  line(6.6, 5.638, 0.3, 0) { color: #14213d, lineWidth: 3 },
  line(6.6, 5.638, 0, 0.3) { color: #14213d, lineWidth: 3 },
  line(6.6, 5.638, -0.3, 0) { color: #14213d, lineWidth: 3 },
  line(6.6, 5.638, 0, -0.3) { color: #14213d, lineWidth: 3 },
  line(6.98, 5.638, 0.18, 0) { color: #ffd166, lineWidth: 3 },
  line(6.22, 5.638, -0.18, 0) { color: #ffd166, lineWidth: 3 }
]
wheelR : fadeIn() { startTime: tCar + 200, duration: 600 }
wheelF : fadeIn() { startTime: tCar + 200, duration: 600 }

// rear wheel: 6 revolutions. front wheel: only road distance / radius = 0.6 / 0.5625 rad
wheelR : rotate(12 * PI) { pivot: (2.775, 5.638), startTime: tLaunch, duration: spinMs, easing: "ease-in-quad" }
wheelF : rotate(0.6 / 0.5625) { pivot: (6.6, 5.638), startTime: tLaunch, duration: spinMs, easing: "ease-in-quad" }

// ---------- caption: power on ----------
capPow = text("full power to the wheels", 4.6, 2.3) { color: #ffd166, fontSize: 26, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
capPow : draw() { startTime: 1600, duration: 900 }
capPow : undraw() { startTime: 6300, duration: 500 }

// ---------- tire smoke from the slipping rear tire ----------
for i in range(0, 16) {
  sm = circle(2.55, 6.1, 0.12) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1, opacity: 0 }
  sm : show() { startTime: 2800 + 230 * i }
  sm : move(-1.2, -0.5) { startTime: 2800 + 230 * i, duration: 700, easing: "ease-out-quad" }
  sm : morph[opacity: 0.6 * (1 - clamp((T - S) / D, 0, 1))] { startTime: 2800 + 230 * i, duration: 700, easing: "linear" }
  sm : morph[radius: lerp(0.12, 0.3, clamp((T - S) / D, 0, 1))] { startTime: 2800 + 230 * i, duration: 700, easing: "linear" }
  sm : hide()
}

// ---------- tags with leader lines ----------
tagSpin = text("wheel spins fast", 2.8, 3.7) { color: #ff9d2f, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
spinLn = line(2.8, 3.9, 0, 1.15) { color: #ff9d2f, lineWidth: 1.5 }
tagSlow = text("car barely moves", 6.3, 3.7) { color: #ff5c7a, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
slowLn = line(6.3, 3.9, 0, 0.75) { color: #ff5c7a, lineWidth: 1.5 }
tagSpin : draw() { startTime: 3000, duration: 800 }
spinLn : draw() { startTime: 3300, duration: 400 }
tagSlow : draw() { startTime: 3800, duration: 800 }
slowLn : draw() { startTime: 4100, duration: 400 }

// ---------- bars: what the car needs vs what the tires can give (1 g = 1.5 units) ----------
l1 = text("car needs 33 m/s²  (3.4 g)", 11.8, 2.6) { color: #ff9d2f, fontSize: 24, fontFamily: "Georgia", textAlign: "center" }
b1 = line(9.2, 3.1, 5.1, 0) { color: #ff9d2f, lineWidth: 16 }
l2 = text("tire grip gives at most about 10 m/s²  (1 g)", 11.8, 4.0) { color: #4cc9f0, fontSize: 22, fontFamily: "Georgia", textAlign: "center" }
b2 = line(9.2, 4.5, 1.5, 0) { color: #4cc9f0, lineWidth: 16 }
l1 : draw() { startTime: tNeed, duration: 700 }
b1 : draw() { startTime: tNeed + 700, duration: 1000, easing: "ease-out-quad" }
l2 : draw() { startTime: 5900, duration: 800 }
b2 : draw() { startTime: 6600, duration: 600, easing: "ease-out-quad" }

gap = text("the missing grip turns into wheel spin", 11.8, 5.6) { color: #ff5c7a, fontSize: 26, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
gap : draw() { startTime: 7300, duration: 1000 }

noteEst = text("illustrative, estimated values", 8, 8.85) { color: #a8dadc, fontSize: 14, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
noteEst : fadeIn() { startTime: 300, duration: 500 }

// ---------- conclusion (last effect ends at 10000) ----------
endTxt = text("Wheels alone can't push harder than the tires can grip", 8, 8.0) { color: #ffd166, fontSize: 28, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
endTxt : draw() { startTime: 8400, duration: 1600 }
