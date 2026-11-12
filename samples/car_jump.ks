canvas { BGColor: #05070f }

// ---- timeline (ms) ----
driveStart = 1500
driveDur = 1500
jumpStart = driveStart + driveDur
flightDur = 2700
landTime = jumpStart + flightDur
exitDur = 2050

driveDX = 4.2
flightDX = 11.6
liftH = 3.4
exitDX = 4.4

liftStart = jumpStart
liftDur = 900
spinStart = jumpStart + 500
spinDur = 380
brakeStart = jumpStart + 1100
brakeDur = 380
sideStart = jumpStart + 1700
sideDur = 700
landBurnStart = jumpStart + 1650
landBurnDur = 1300

takeoffX = 3.0
landX = 14.6

// ---- night sky ----
for s in range(0, 14) {
  stx = 0.5 + (s * 1.9) % 15
  sty = 0.4 + (s * 1.3) % 3.4
  star = point(stx, sty) { fillColor: #ffffff, opacity: 0 }
  star : show() { startTime: 0 }
  star : morph[opacity: 0.3 + 0.25 * sin(clamp((T - S) / D, 0, 1) * TAU * 3 + s)] { startTime: 0, duration: 9000 }
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

// ---- vehicles in the way ----
sedan = group [
  path(true, 5.0, 7.5, 5.0, 7.2, 5.12, 7.08, 5.55, 7.0, 5.8, 6.72, 6.3, 6.7, 6.62, 6.98, 6.85, 7.08, 6.9, 7.22, 6.9, 7.5) { fillColor: #d4a85a, color: #f5e6b8, lineWidth: 0.5 },
  path(true, 5.82, 7.0, 5.95, 6.79, 6.28, 6.78, 6.5, 7.0) { fillColor: #1d3557 },
  circle(5.45, 7.33, 0.17) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(6.45, 7.33, 0.17) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(5.45, 7.33, 0.06) { fillColor: #cfd8dc },
  circle(6.45, 7.33, 0.06) { fillColor: #cfd8dc }
]
sedan : show() { startTime: 300 }

semiCab = group [
  path(true, 7.2, 7.2, 7.2, 6.4, 7.5, 6.05, 8.0, 5.65, 8.9, 5.65, 8.9, 7.2) { fillColor: #eef2f7, color: #ffffff, lineWidth: 0.5 },
  path(true, 7.62, 6.05, 8.0, 5.78, 8.3, 5.78, 8.3, 6.2, 7.62, 6.2) { fillColor: #1d3557 },
  circle(7.22, 6.75, 0.07) { fillColor: #ffe9a8 },
  circle(7.7, 7.25, 0.25) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(8.55, 7.25, 0.25) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(7.7, 7.25, 0.08) { fillColor: #cfd8dc },
  circle(8.55, 7.25, 0.08) { fillColor: #cfd8dc }
]
semiCab : show() { startTime: 500 }

trailer = group [
  path(true, 8.9, 7.0, 12.6, 7.0, 12.6, 7.14, 8.9, 7.14) { fillColor: #3b4252, color: #8a94a6, lineWidth: 0.5 },
  circle(11.35, 7.27, 0.23) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(11.85, 7.27, 0.23) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(12.35, 7.27, 0.23) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(12.58, 7.07, 0.07) { fillColor: #ff3b3b }
]
trailer : show() { startTime: 700 }

wedgeTruck = group [
  path(true, 9.3, 6.85, 9.35, 6.55, 10.7, 6.1, 11.4, 6.2, 11.4, 6.85) { fillColor: #9aa5b1, color: #e5e9ef, lineWidth: 0.5 },
  path(false, 9.55, 6.55, 10.6, 6.2) { color: #1d3557, lineWidth: 0.5 },
  circle(9.75, 6.8, 0.2) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(10.95, 6.8, 0.2) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 }
]
wedgeTruck : show() { startTime: 900 }

hatch = group [
  path(true, 11.5, 6.85, 11.5, 6.7, 11.8, 6.6, 12.0, 6.42, 12.35, 6.42, 12.5, 6.65, 12.55, 6.85) { fillColor: #c0392b, color: #f5b7b1, lineWidth: 0.5 },
  circle(11.8, 6.85, 0.15) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(12.3, 6.85, 0.15) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 }
]
hatch : show() { startTime: 1000 }

redGlow = circle(12.7, 7.45, 0.55) { fillColor: rgba(255,40,40,0.25) }
redGlow : show() { startTime: 1100 }

// ---- thruster smoke at takeoff and at landing ----
for k in range(0, 14) {
  smokeX = takeoffX + (k - 6.5) * 0.28 + 0.2 * sin(k * 1.7)
  r0 = 0.15 + 0.04 * (k % 3)
  r1 = 0.6 + 0.12 * (k % 4)
  smokeA = circle(smokeX, 7.3, r0) { fillColor: #c9d6e8, opacity: 0 }
  smokeA : show() { startTime: jumpStart + k * 45 }
  smokeA : parallel [
    morph[radius: lerp(r0, r1, clamp((T - S) / D, 0, 1)), opacity: 0.5 * sin(PI * clamp((T - S) / D, 0, 1))],
    move((k - 6.5) * 0.35, -0.25 - 0.08 * (k % 4)) { easing: "ease-out-cubic" }
  ] { startTime: jumpStart + k * 45, duration: 1800 }
  smokeA : hide() { startTime: jumpStart + k * 45 + 1800 }
}
for k in range(0, 14) {
  smokeX = landX + (k - 6.5) * 0.28 + 0.2 * sin(k * 1.9)
  r0 = 0.15 + 0.04 * (k % 3)
  r1 = 0.6 + 0.12 * (k % 4)
  smokeB = circle(smokeX, 7.3, r0) { fillColor: #c9d6e8, opacity: 0 }
  smokeB : show() { startTime: jumpStart + 2050 + k * 45 }
  smokeB : parallel [
    morph[radius: lerp(r0, r1, clamp((T - S) / D, 0, 1)), opacity: 0.5 * sin(PI * clamp((T - S) / D, 0, 1))],
    move((k - 6.5) * 0.35, -0.25 - 0.08 * (k % 4)) { easing: "ease-out-cubic" }
  ] { startTime: jumpStart + 2050 + k * 45, duration: 1800 }
  smokeB : hide() { startTime: jumpStart + 2050 + k * 45 + 1800 }
}

// ---- headlight beam and thruster flames (separate shapes that travel with the car) ----
beam = path(true, -0.25, 7.25, 3.0, 6.75, 3.0, 7.5, -0.25, 7.32) { fillColor: rgba(255,244,200,0.12) }

// attitude jets, burst 1
jetTailRoofO = path(true, -2.065, 7.140, -1.935, 7.140, -1.971, 6.755, -2.000, 6.590, -2.029, 6.755) { fillColor: #9fdcff, opacity: 0 }
jetTailRoofI = path(true, -2.026, 7.140, -1.974, 7.140, -1.988, 6.888, -2.000, 6.780, -2.012, 6.888) { fillColor: #ffffff, opacity: 0 }
jetNoseUnderO = path(true, -0.365, 7.345, -0.235, 7.345, -0.271, 7.730, -0.300, 7.895, -0.329, 7.730) { fillColor: #9fdcff, opacity: 0 }
jetNoseUnderI = path(true, -0.326, 7.345, -0.274, 7.345, -0.288, 7.597, -0.300, 7.705, -0.312, 7.597) { fillColor: #ffffff, opacity: 0 }

// attitude jets, burst 2
jetNoseRoofO = path(true, -0.565, 7.190, -0.435, 7.190, -0.471, 6.805, -0.500, 6.640, -0.529, 6.805) { fillColor: #9fdcff, opacity: 0 }
jetNoseRoofI = path(true, -0.526, 7.190, -0.474, 7.190, -0.488, 6.938, -0.500, 6.830, -0.512, 6.938) { fillColor: #ffffff, opacity: 0 }
jetTailUnderO = path(true, -2.165, 7.310, -2.035, 7.310, -2.071, 7.695, -2.100, 7.860, -2.129, 7.695) { fillColor: #9fdcff, opacity: 0 }
jetTailUnderI = path(true, -2.126, 7.310, -2.074, 7.310, -2.088, 7.562, -2.100, 7.670, -2.112, 7.562) { fillColor: #ffffff, opacity: 0 }

// side thrusters
sideNoseO = path(true, -0.247, 7.210, -0.247, 7.310, 0.278, 7.282, 0.503, 7.260, 0.278, 7.237) { fillColor: #4cc9f0, opacity: 0 }
sideTailO = path(true, -2.146, 7.210, -2.146, 7.310, -2.671, 7.282, -2.896, 7.260, -2.671, 7.237) { fillColor: #4cc9f0, opacity: 0 }
sideNoseI = path(true, -0.247, 7.240, -0.247, 7.280, 0.103, 7.269, 0.253, 7.260, 0.103, 7.251) { fillColor: #e8fbff, opacity: 0 }
sideTailI = path(true, -2.146, 7.240, -2.146, 7.280, -2.496, 7.269, -2.646, 7.260, -2.496, 7.251) { fillColor: #e8fbff, opacity: 0 }

// bottom thrusters (lift-off and landing burn)
botRearO = path(true, -2.075, 7.360, -1.965, 7.360, -1.995, 8.025, -2.020, 8.310, -2.045, 8.025) { fillColor: #4cc9f0, opacity: 0 }
botRearMidO = path(true, -1.455, 7.360, -1.345, 7.360, -1.375, 8.130, -1.400, 8.460, -1.425, 8.130) { fillColor: #4cc9f0, opacity: 0 }
botFrontMidO = path(true, -1.105, 7.360, -0.995, 7.360, -1.025, 8.130, -1.050, 8.460, -1.075, 8.130) { fillColor: #4cc9f0, opacity: 0 }
botFrontO = path(true, -0.455, 7.360, -0.345, 7.360, -0.375, 8.025, -0.400, 8.310, -0.425, 8.025) { fillColor: #4cc9f0, opacity: 0 }
botRearI = path(true, -2.042, 7.360, -1.998, 7.360, -2.010, 7.825, -2.020, 8.025, -2.030, 7.825) { fillColor: #e8fbff, opacity: 0 }
botRearMidI = path(true, -1.422, 7.360, -1.378, 7.360, -1.390, 7.899, -1.400, 8.130, -1.410, 7.899) { fillColor: #e8fbff, opacity: 0 }
botFrontMidI = path(true, -1.072, 7.360, -1.028, 7.360, -1.040, 7.899, -1.050, 8.130, -1.060, 7.899) { fillColor: #e8fbff, opacity: 0 }
botFrontI = path(true, -0.422, 7.360, -0.378, 7.360, -0.390, 7.825, -0.400, 8.025, -0.410, 7.825) { fillColor: #e8fbff, opacity: 0 }

spinFlames = [jetTailRoofO, jetTailRoofI, jetNoseUnderO, jetNoseUnderI]
brakeFlames = [jetNoseRoofO, jetNoseRoofI, jetTailUnderO, jetTailUnderI]
sideFlames = [sideNoseO, sideTailO, sideNoseI, sideTailI]
bottomFlames = [botRearO, botRearMidO, botFrontMidO, botFrontO, botRearI, botRearMidI, botFrontMidI, botFrontI]

// ---- the car (body only), starting off-screen on the left ----
car = group [
  path(true, -2.067, 7.148, -1.451, 7.036, -0.784, 7.159, -0.584, 7.137, -0.247, 7.262, -0.247, 7.359, -2.036, 7.350, -2.146, 7.289, -2.133, 7.168) { fillColor: #e63946, color: #ffffff, lineWidth: 0.5 },
  path(true, -1.816, 7.137, -1.464, 7.071, -1.002, 7.155, -1.002, 7.214, -1.816, 7.214) { fillColor: #a8dadc, color: #1d3557, lineWidth: 0.5 },
  circle(-1.772, 7.335, 0.165) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(-0.650, 7.335, 0.165) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(-1.772, 7.335, 0.06) { fillColor: #cfd8dc },
  circle(-0.650, 7.335, 0.06) { fillColor: #cfd8dc },
  circle(-0.298, 7.280, 0.04) { fillColor: #ffd166 }
]

// ---- motion: every shape of the car gets the same four moves ----
beam : show() { startTime: 0 }
beam : move(driveDX, 0) { startTime: driveStart, duration: driveDur, easing: "ease-in-sine" }
beam : move(flightDX, 0) { startTime: jumpStart, duration: flightDur, easing: "linear" }
beam : move(0, -liftH) { startTime: jumpStart, duration: flightDur / 2, easing: "ease-out-quad" }
beam : move(0, liftH) { startTime: jumpStart + flightDur / 2, duration: flightDur / 2, easing: "ease-in-quad" }
beam : move(exitDX, 0) { startTime: landTime, duration: exitDur, easing: "ease-out-quad" }

for (f, i) in spinFlames {
  f : show() { startTime: 0 }
  f : move(driveDX, 0) { startTime: driveStart, duration: driveDur, easing: "ease-in-sine" }
  f : move(flightDX, 0) { startTime: jumpStart, duration: flightDur, easing: "linear" }
  f : move(0, -liftH) { startTime: jumpStart, duration: flightDur / 2, easing: "ease-out-quad" }
  f : move(0, liftH) { startTime: jumpStart + flightDur / 2, duration: flightDur / 2, easing: "ease-in-quad" }
  f : move(exitDX, 0) { startTime: landTime, duration: exitDur, easing: "ease-out-quad" }
  f : morph[opacity: clamp(4 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.8 + 0.2 * sin(clamp((T - S) / D, 0, 1) * 60 + i))] { startTime: spinStart, duration: spinDur }
}
for (f, i) in brakeFlames {
  f : show() { startTime: 0 }
  f : move(driveDX, 0) { startTime: driveStart, duration: driveDur, easing: "ease-in-sine" }
  f : move(flightDX, 0) { startTime: jumpStart, duration: flightDur, easing: "linear" }
  f : move(0, -liftH) { startTime: jumpStart, duration: flightDur / 2, easing: "ease-out-quad" }
  f : move(0, liftH) { startTime: jumpStart + flightDur / 2, duration: flightDur / 2, easing: "ease-in-quad" }
  f : move(exitDX, 0) { startTime: landTime, duration: exitDur, easing: "ease-out-quad" }
  f : morph[opacity: clamp(4 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.8 + 0.2 * sin(clamp((T - S) / D, 0, 1) * 60 + i))] { startTime: brakeStart, duration: brakeDur }
}
for (f, i) in sideFlames {
  f : show() { startTime: 0 }
  f : move(driveDX, 0) { startTime: driveStart, duration: driveDur, easing: "ease-in-sine" }
  f : move(flightDX, 0) { startTime: jumpStart, duration: flightDur, easing: "linear" }
  f : move(0, -liftH) { startTime: jumpStart, duration: flightDur / 2, easing: "ease-out-quad" }
  f : move(0, liftH) { startTime: jumpStart + flightDur / 2, duration: flightDur / 2, easing: "ease-in-quad" }
  f : move(exitDX, 0) { startTime: landTime, duration: exitDur, easing: "ease-out-quad" }
  f : morph[opacity: clamp(4 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.8 + 0.2 * sin(clamp((T - S) / D, 0, 1) * 60 + i))] { startTime: sideStart, duration: sideDur }
}
for (f, i) in bottomFlames {
  f : show() { startTime: 0 }
  f : move(driveDX, 0) { startTime: driveStart, duration: driveDur, easing: "ease-in-sine" }
  f : move(flightDX, 0) { startTime: jumpStart, duration: flightDur, easing: "linear" }
  f : move(0, -liftH) { startTime: jumpStart, duration: flightDur / 2, easing: "ease-out-quad" }
  f : move(0, liftH) { startTime: jumpStart + flightDur / 2, duration: flightDur / 2, easing: "ease-in-quad" }
  f : move(exitDX, 0) { startTime: landTime, duration: exitDur, easing: "ease-out-quad" }
  f : morph[opacity: clamp(4 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.8 + 0.2 * sin(clamp((T - S) / D, 0, 1) * 70 + i))] { startTime: liftStart, duration: liftDur }
  f : morph[opacity: clamp(4 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.8 + 0.2 * sin(clamp((T - S) / D, 0, 1) * 70 + i))] { startTime: landBurnStart, duration: landBurnDur }
}

car : show() { startTime: 0 }
car : move(driveDX, 0) { startTime: driveStart, duration: driveDur, easing: "ease-in-sine" }
car : move(flightDX, 0) { startTime: jumpStart, duration: flightDur, easing: "linear" }
car : move(0, -liftH) { startTime: jumpStart, duration: flightDur / 2, easing: "ease-out-quad" }
car : move(0, liftH) { startTime: jumpStart + flightDur / 2, duration: flightDur / 2, easing: "ease-in-quad" }
car : move(exitDX, 0) { startTime: landTime, duration: exitDur, easing: "ease-out-quad" }

// ---- captions ----
tagA = text("clear the traffic", 8, 1.1) { color: #7fd8ff, fontSize: 26, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
tagA : show() { startTime: 1300 }
tagA : morph[opacity: 1] { startTime: 1300, duration: 400 }
tagA : morph[opacity: 0] { startTime: jumpStart - 200, duration: 300 }

tagB = text("thrusters: go!", 8, 1.1) { color: #ffd166, fontSize: 26, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
tagB : show() { startTime: jumpStart + 300 }
tagB : morph[opacity: 1] { startTime: jumpStart + 300, duration: 300 }
tagB : morph[opacity: 0] { startTime: landTime - 300, duration: 300 }

tagC = text("clean landing", 8, 1.1) { color: #7fd8ff, fontSize: 26, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
tagC : show() { startTime: landTime + 200 }
tagC : morph[opacity: 1] { startTime: landTime + 200, duration: 500 }
