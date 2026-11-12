canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tDescStart = 1000
descMs = 8500
tLand = tDescStart + descMs
tBurn = 2400
tLegs = 7000
tLblPods = 10000
tXfer = 13000
tFly = 13500
flyMs = 2600
flyGap = 250
tLift = 17000
tEnd = 18000
dropY = 7.25

// ---------- sway: puff time, then the booster drifts by sdx ----------
pulseT = [4000, 4700, 5400, 6100, 6800, 7500, 8200, 8900]
sdx = [0.30, -0.28, 0.22, -0.20, 0.14, -0.12, 0.06, -0.12]
prior = [0, 0.30, 0.02, 0.24, 0.04, 0.18, 0.06, 0.12]
pdir = [-1, 1, -1, 1, -1, 1, -1, 1]
pux = [3.58, 4.42, 3.58, 4.42, 3.58, 4.42, 3.58, 4.42]
puy = [-3.35, -3.35, -3.0, -3.0, -3.35, -3.35, -3.0, -3.0]

// ---------- titles and ground ----------
title = text("Falcon 9 landing", 11.5, 0.9) { color: #ffd166, fontSize: 34, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title : draw() { startTime: 0, duration: 900 }
title : hide() { startTime: tXfer }
title2 = text("From the rocket to the car", 8, 0.9) { color: #ffd166, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title2 : draw() { startTime: tXfer, duration: 1000 }

ground = line(0.3, 7.6, 15.4, 0) { color: #a8dadc, lineWidth: 2 }
ground : show() { startTime: 200 }
pad = rectangle(2.6, 7.6, 2.8, 0.16) { fillColor: #3a4660, color: #ffffff, lineWidth: 1.5 }
padMark = circle(4.0, 7.68, 0.06) { fillColor: #ffd166, color: #ffd166, lineWidth: 1 }
pad : show() { startTime: 200 }
padMark : show() { startTime: 200 }

// ---------- booster (starts above the screen, centre x = 4) ----------
rocket = group [
  rectangle(3.7, -3.8, 0.6, 3.6) { fillColor: #e8eef2, color: #ffffff, lineWidth: 1.5 },
  rectangle(3.7, -3.8, 0.6, 0.5) { fillColor: #14213d, color: #ffffff, lineWidth: 1 },
  rectangle(3.72, -0.2, 0.56, 0.3) { fillColor: #14213d, color: #ffffff, lineWidth: 1 },
  path(true, 3.8, 0.1, 3.9, 0.1, 3.95, 0.3, 3.75, 0.3) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  path(true, 3.95, 0.1, 4.05, 0.1, 4.1, 0.3, 3.9, 0.3) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  path(true, 4.1, 0.1, 4.2, 0.1, 4.25, 0.3, 4.05, 0.3) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  rectangle(3.3, -3.2, 0.4, 0.1) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 },
  rectangle(4.3, -3.2, 0.4, 0.1) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 }
]
rocket : show() { startTime: 0 }

// ---------- followers: engine flame, legs, four cold-gas pods ----------
flame = path(true, 3.8, 0.1, 4.2, 0.1, 4.0, 1.1) { fillColor: #ff9d2f, color: #ffd166, lineWidth: 1, opacity: 0 }
legL = path(false, 3.72, -0.2, 3.3, 0.0, 3.05, 0.35) { color: #cfd8dc, lineWidth: 3, opacity: 0 }
legR = path(false, 4.28, -0.2, 4.7, 0.0, 4.95, 0.35) { color: #cfd8dc, lineWidth: 3, opacity: 0 }
p0 = circle(3.58, -3.35, 0.13) { fillColor: #4cc9f0, color: #ffffff, lineWidth: 1.5 }
p1 = circle(4.42, -3.35, 0.13) { fillColor: #4cc9f0, color: #ffffff, lineWidth: 1.5 }
p2 = circle(3.58, -3.0, 0.13) { fillColor: #4cc9f0, color: #ffffff, lineWidth: 1.5 }
p3 = circle(4.42, -3.0, 0.13) { fillColor: #4cc9f0, color: #ffffff, lineWidth: 1.5 }
// ---------- cold-gas jets: outer plume + inner core, index = pod (0 left-top, 1 right-top, 2 left-low, 3 right-low) ----------
jetO0 = path(true, 3.46, -3.42, 2.46, -3.55, 1.96, -3.35, 2.46, -3.15, 3.46, -3.28) { fillColor: #4cc9f0, opacity: 0 }
jetO1 = path(true, 4.54, -3.42, 5.54, -3.55, 6.04, -3.35, 5.54, -3.15, 4.54, -3.28) { fillColor: #4cc9f0, opacity: 0 }
jetO2 = path(true, 3.46, -3.07, 2.46, -3.2, 1.96, -3.0, 2.46, -2.8, 3.46, -2.93) { fillColor: #4cc9f0, opacity: 0 }
jetO3 = path(true, 4.54, -3.07, 5.54, -3.2, 6.04, -3.0, 5.54, -2.8, 4.54, -2.93) { fillColor: #4cc9f0, opacity: 0 }
jetI0 = path(true, 3.46, -3.39, 2.76, -3.44, 2.41, -3.35, 2.76, -3.26, 3.46, -3.31) { fillColor: #e8fbff, opacity: 0 }
jetI1 = path(true, 4.54, -3.39, 5.24, -3.44, 5.59, -3.35, 5.24, -3.26, 4.54, -3.31) { fillColor: #e8fbff, opacity: 0 }
jetI2 = path(true, 3.46, -3.04, 2.76, -3.09, 2.41, -3.0, 2.76, -2.91, 3.46, -2.96) { fillColor: #e8fbff, opacity: 0 }
jetI3 = path(true, 4.54, -3.04, 5.24, -3.09, 5.59, -3.0, 5.24, -2.91, 4.54, -2.96) { fillColor: #e8fbff, opacity: 0 }
jetFlames = [jetO0, jetO1, jetO2, jetO3, jetI0, jetI1, jetI2, jetI3]
pods = [p0, p1, p2, p3]
followers = [flame, legL, legR, p0, p1, p2, p3, jetO0, jetO1, jetO2, jetO3, jetI0, jetI1, jetI2, jetI3]

for (p, i) in pods {
  p : show() { startTime: 300 }
}

// descent and sway apply to the booster and to every follower
rocket : move(0, dropY) { startTime: tDescStart, duration: descMs, easing: "ease-out-quad" }
for (f, i) in followers {
  f : move(0, dropY) { startTime: tDescStart, duration: descMs, easing: "ease-out-quad" }
}
for k in range(0, 8) {
  rocket : move(sdx[k], 0) { startTime: pulseT[k] + 150, duration: 500, easing: "ease-out-quad" }
  for (f, i) in followers {
    f : move(sdx[k], 0) { startTime: pulseT[k] + 150, duration: 500, easing: "ease-out-quad" }
  }
}

// engine burn: flame flickers, then fades just before touchdown
flame : show() { startTime: tBurn }
flame : morph[opacity: clamp(5 * clamp((T - S) / D, 0, 1), 0, 1) * (0.85 + 0.12 * sin(40 * PI * clamp((T - S) / D, 0, 1))) * clamp(6 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tBurn, duration: tLand - tBurn, easing: "linear" }
flame : hide()

// legs fade in
legL : show() { startTime: tLegs }
legR : show() { startTime: tLegs }
legL : morph[opacity: clamp((T - S) / D, 0, 1)] { startTime: tLegs, duration: 500, easing: "linear" }
legR : morph[opacity: clamp((T - S) / D, 0, 1)] { startTime: tLegs, duration: 500, easing: "linear" }

// ---------- jet bursts: even bursts fire the left pair, odd bursts the right pair ----------
for (f, n) in jetFlames {
  f : show() { startTime: 300 }
  for k in range(n % 2, 8, 2) {
    f : morph[opacity: clamp(5 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.85 + 0.15 * sin(clamp((T - S) / D, 0, 1) * 70 + n))] { startTime: pulseT[k], duration: 600, easing: "linear" }
  }
}

// ---------- jet bursts: even bursts fire the left pair, odd bursts the right pair ----------
for (f, n) in jetFlames {
  f : show() { startTime: 300 }
  for k in range(n % 2, 8, 2) {
    f : morph[opacity: clamp(5 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.85 + 0.15 * sin(clamp((T - S) / D, 0, 1) * 70 + n))] { startTime: pulseT[k], duration: 600, easing: "linear" }
  }
}


// ---------- captions during the landing ----------
cap1 = text("Engine burn slows the fall", 11.5, 1.9) { color: #ff9d2f, fontSize: 24, fontFamily: "Georgia", textAlign: "center" }
cap2 = text("Cold gas thrusters: tiny bursts keep it steady", 11.5, 2.5) { color: #4cc9f0, fontSize: 24, fontFamily: "Georgia", textAlign: "center" }
cap3 = text("Legs deploy", 11.5, 3.1) { color: #ffd166, fontSize: 24, fontFamily: "Georgia", textAlign: "center" }
cap4 = text("Touchdown!", 11.5, 3.7) { color: #7cff6b, fontSize: 28, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
cap1 : draw() { startTime: 2600, duration: 900 }
cap2 : draw() { startTime: 4200, duration: 1200 }
cap3 : draw() { startTime: 7000, duration: 600 }
cap4 : draw() { startTime: tLand, duration: 700 }
cap1 : hide() { startTime: tXfer }
cap2 : hide() { startTime: tXfer }
cap3 : hide() { startTime: tXfer }
cap4 : hide() { startTime: tXfer }

// label pointing at the pods after landing
podLn = line(2.0, 3.1, 1.5, 0.8) { color: #4cc9f0, lineWidth: 1.5 }
podTxt = text("cold gas thrusters", 1.5, 2.85) { color: #4cc9f0, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
podLn : draw() { startTime: tLblPods, duration: 400 }
podTxt : draw() { startTime: tLblPods, duration: 800 }
podLn : hide() { startTime: tXfer }
podTxt : hide() { startTime: tXfer }

// ---------- the car (side view, scale 0.55, rear at x = 9.8, ground y = 7.6) ----------
car = group [
  path(true, 9.998, 6.72, 11.538, 6.439, 13.205, 6.747, 13.705, 6.692, 14.547, 7.006, 14.547, 7.248, 10.075, 7.226, 9.8, 7.072, 9.833, 6.769) { fillColor: #e63946, color: #ffffff, lineWidth: 2 },
  path(true, 10.625, 6.692, 11.505, 6.527, 12.66, 6.736, 12.66, 6.885, 10.625, 6.885) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 },
  circle(10.735, 7.188, 0.413) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(10.735, 7.188, 0.193) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  circle(13.54, 7.188, 0.413) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(13.54, 7.188, 0.193) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 }
]
car : show() { startTime: tXfer }
car : move(0, -0.5) { startTime: tLift, duration: 700, easing: "ease-out-quad" }

// ---------- flight guides for the pods (never shown), each starts at the pod's landed position ----------
gd0 = path(false, 3.58, 3.9, 4.22, 3.62, 4.86, 3.44, 5.51, 3.36, 6.15, 3.39, 6.79, 3.52, 7.43, 3.76, 8.07, 4.09, 8.72, 4.54, 9.36, 5.08, 10.0, 5.73, 10.64, 6.48, 11.29, 7.33) { color: #ffd166, lineWidth: 1 }
gd1 = path(false, 4.42, 3.9, 5.13, 3.62, 5.84, 3.44, 6.56, 3.36, 7.27, 3.39, 7.98, 3.52, 8.69, 3.76, 9.4, 4.09, 10.12, 4.54, 10.83, 5.08, 11.54, 5.73, 12.25, 6.48, 12.96, 7.33) { color: #ffd166, lineWidth: 1 }
gd2 = path(false, 3.58, 4.25, 4.23, 3.97, 4.88, 3.78, 5.54, 3.69, 6.19, 3.7, 6.84, 3.81, 7.49, 4.02, 8.15, 4.33, 8.8, 4.73, 9.45, 5.23, 10.1, 5.83, 10.75, 6.53, 11.41, 7.33) { color: #ffd166, lineWidth: 1 }
gd3 = path(false, 4.42, 4.25, 5.14, 3.97, 5.86, 3.78, 6.59, 3.69, 7.31, 3.7, 8.03, 3.81, 8.75, 4.02, 9.47, 4.33, 10.2, 4.73, 10.92, 5.23, 11.64, 5.83, 12.36, 6.53, 13.08, 7.33) { color: #ffd166, lineWidth: 1 }
guides = [gd0, gd1, gd2, gd3]

for (p, i) in pods {
  p : follow(guides[i]) { orient: false, startTime: tFly + flyGap * i, duration: flyMs, easing: "ease-in-out-sine" }
  p : move(0, -0.5) { startTime: tLift, duration: 700, easing: "ease-out-quad" }
}

// ---------- cold jets under the car (they lift with it) ----------
tgx = [11.285, 12.963, 11.406, 13.084]
for i in range(0, 4) {
  jcO = path(true, tgx[i] - 0.06, 7.42, tgx[i] - 0.16, 7.72, tgx[i], 7.95, tgx[i] + 0.16, 7.72, tgx[i] + 0.06, 7.42) { fillColor: #4cc9f0, opacity: 0 }
  jcI = path(true, tgx[i] - 0.04, 7.42, tgx[i] - 0.09, 7.64, tgx[i], 7.8, tgx[i] + 0.09, 7.64, tgx[i] + 0.04, 7.42) { fillColor: #e8fbff, opacity: 0 }
  jcO : show() { startTime: 16900 }
  jcI : show() { startTime: 16900 }
  jcO : move(0, -0.5) { startTime: tLift, duration: 700, easing: "ease-out-quad" }
  jcI : move(0, -0.5) { startTime: tLift, duration: 700, easing: "ease-out-quad" }
  jcO : morph[opacity: clamp(4 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.85 + 0.15 * sin(clamp((T - S) / D, 0, 1) * 70 + i))] { startTime: 16900, duration: 1000, easing: "linear" }
  jcI : morph[opacity: clamp(4 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.85 + 0.15 * sin(clamp((T - S) / D, 0, 1) * 70 + i))] { startTime: 16900, duration: 1000, easing: "linear" }
}

// ---------- captions for the hand-over ----------
mvTxt = text("the same cold gas thrusters fly to the car", 8, 8.4) { color: #4cc9f0, fontSize: 26, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
mvTxt : draw() { startTime: 13400, duration: 1400 }
mvTxt : hide() { startTime: 16600 }
endTxt = text("Steady in the air, now on the car", 8, 8.4) { color: #ffd166, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
endTxt : draw() { startTime: 16700, duration: 1300 }
