canvas { BGColor: #05070f }

extX = 0.8
extY = 0.2
cx = 10.2
cy = 4.6
rx = 2.9
ry = 2.9
boxR = 13.7
boxT = cy - ry - extY
floorY = cy + ry
spin = 1

meshColor = rgba(76,201,240,0.35)

// ---- timeline (ms) ----
driveStart = 1400
driveDur = 1800
climbStart = driveStart + driveDur + 100
climbDur = 3200
loopAngle = PI
jumpStart = climbStart + climbDur + 1000
flightDur = 2800
flipAngle = PI * 160 / 180
topAngle = -90
landTime = jumpStart + flightDur

spinStart = jumpStart + 60
spinDur = 420
sideStart = jumpStart + 650
sideDur = 700
brakeStart = jumpStart + 1000
brakeDur = 380
bottomStart = jumpStart + 1540
bottomDur = 1400
smokeStart = jumpStart + 1700
landX = 4.4

// ---- night sky ----
for s in range(0, 16) {
  stx = 0.5 + (s * 1.9) % 15
  sty = 0.4 + (s * 1.3) % 3.2
  star = point(stx, sty) { fillColor: #ffffff, opacity: 0 }
  star : show() { startTime: 0 }
  star : morph[opacity: 0.3 + 0.25 * sin(clamp((T - S) / D, 0, 1) * TAU * 3 + s)] { startTime: 0, duration: 13000 }
}

// ---- support mesh ----
for k in range(1, 10) {
  y = boxT + k * 0.6
  u = (y - cy) / ry
  xs = cx + rx * sqrt(1 - u * u)
  mh = line((xs, y), (boxR, y)) { color: meshColor, lineWidth: 0.5 } : draw() { startTime: 200 + k * 70, duration: 500 }
}

for m in range(1, 6) {
  x = cx + m * 0.6
  u = (x - cx) / rx
  if (u < 1) {
    hh = ry * sqrt(1 - u * u)
    if (cy - hh - boxT > 0.15) {
      mvu = line((x, boxT), (x, cy - hh)) { color: meshColor, lineWidth: 0.5 } : draw() { startTime: 300 + m * 70, duration: 500 }
    }
    if (floorY - (cy + hh) > 0.15) {
      mvd = line((x, cy + hh), (x, floorY)) { color: meshColor, lineWidth: 0.5 } : draw() { startTime: 300 + m * 70, duration: 500 }
    }
  } else {
    mvf = line((x, boxT), (x, floorY)) { color: meshColor, lineWidth: 0.5 } : draw() { startTime: 300 + m * 70, duration: 500 }
    tl = line(cx,boxT, (cx, cy-ry)) { color: meshColor, lineWidth: 0.5 } : draw() { startTime: 300 + m * 70, duration: 500 }
  }
}

// ---- ramp ----
ramp = group [
  path(false, cx, cy-ry ,cx-extX,cy-ry ,cx-extX, boxT, cx, boxT, boxR, boxT, boxR, floorY, 0.6, floorY) { color: #4cc9f0, lineWidth: 1.2 },
  earc(cx, cy, rx, ry, topAngle, 90) { color: #4cc9f0, lineWidth: 1.6 }
]
ramp : show() { startTime: 100 }

// ---- landing smoke (behind the car) ----
for k in range(0, 18) {
  smokeX = landX + (k - 8.5) * 0.2 + 0.25 * sin(k * 1.7)
  r0 = 0.15 + 0.04 * (k % 3)
  r1 = 0.6 + 0.12 * (k % 4)
  smoke = circle(smokeX, 7.25, r0) { fillColor: #c9d6e8, opacity: 0 }
  smoke : show() { startTime: smokeStart + k * 60 }
  smoke : parallel [
    morph[radius: lerp(r0, r1, clamp((T - S) / D, 0, 1)), opacity: 0.5 * sin(PI * clamp((T - S) / D, 0, 1))],
    move((k - 8.5) * 0.3, -0.25 - 0.08 * (k % 4)) { easing: "ease-out-cubic" }
  ] { startTime: smokeStart + k * 60, duration: 2000 }
  smoke : hide() { startTime: smokeStart + k * 60 + 2000 }
}

// ---- car used for the drive and the climb ----
car = group [
  path(true, 0.933, 7.148, 1.549, 7.036, 2.216, 7.159, 2.416, 7.137, 2.753, 7.262, 2.753, 7.359, 0.964, 7.35, 0.854, 7.289, 0.867, 7.168) { fillColor: #e63946, color: #ffffff, lineWidth: 0.5 },
  path(true, 1.184, 7.137, 1.536, 7.071, 1.998, 7.155, 1.998, 7.214, 1.184, 7.214) { fillColor: #a8dadc, color: #1d3557, lineWidth: 0.5 },
  circle(1.228, 7.335, 0.165) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(2.35, 7.335, 0.165) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(1.228, 7.335, 0.06) { fillColor: #cfd8dc },
  circle(2.35, 7.335, 0.06) { fillColor: #cfd8dc },
  circle(2.702, 7.28, 0.04) { fillColor: #ffd166 }
]
car : show() { startTime: 1000 }

// ---- thruster flames, defined in the upside-down launch pose (no effects here) ----
// attitude jets, burst 1: tail roof jet + nose underside jet
jetTailRoofO = path(true, 10.144, 1.917, 10.022, 1.962, 10.187, 2.311, 10.271, 2.456, 10.242, 2.291) { fillColor: #9fdcff, opacity: 0 }
jetTailRoofI = path(true, 10.107, 1.931, 10.059, 1.948, 10.158, 2.180, 10.206, 2.278, 10.180, 2.172) { fillColor: #ffffff, opacity: 0 }
jetNoseUnderO = path(true, 8.477, 2.306, 8.354, 2.351, 8.256, 1.977, 8.227, 1.812, 8.311, 1.957) { fillColor: #9fdcff, opacity: 0 }
jetNoseUnderI = path(true, 8.440, 2.319, 8.391, 2.337, 8.318, 2.096, 8.292, 1.990, 8.340, 2.088) { fillColor: #ffffff, opacity: 0 }

// attitude jets, burst 2: nose roof jet + tail underside jet
jetNoseRoofO = path(true, 8.717, 2.383, 8.595, 2.428, 8.761, 2.777, 8.844, 2.922, 8.816, 2.757) { fillColor: #9fdcff, opacity: 0 }
jetNoseRoofI = path(true, 8.681, 2.397, 8.632, 2.415, 8.732, 2.646, 8.780, 2.744, 8.754, 2.638) { fillColor: #ffffff, opacity: 0 }
jetTailUnderO = path(true, 10.180, 1.723, 10.058, 1.768, 9.960, 1.394, 9.931, 1.229, 10.015, 1.374) { fillColor: #9fdcff, opacity: 0 }
jetTailUnderI = path(true, 10.143, 1.737, 10.094, 1.755, 10.022, 1.513, 9.996, 1.407, 10.044, 1.505) { fillColor: #ffffff, opacity: 0 }

// side thrusters at the nose and the tail
sideNoseO = path(true, 8.412, 2.473, 8.378, 2.379, 7.894, 2.585, 7.690, 2.683, 7.909, 2.627) { fillColor: #4cc9f0, opacity: 0 }
sideTailO = path(true, 10.196, 1.824, 10.162, 1.730, 10.665, 1.576, 10.884, 1.520, 10.680, 1.618) { fillColor: #4cc9f0, opacity: 0 }
sideNoseI = path(true, 8.402, 2.445, 8.388, 2.408, 8.063, 2.538, 7.925, 2.597, 8.069, 2.555) { fillColor: #e8fbff, opacity: 0 }
sideTailI = path(true, 10.186, 1.796, 10.172, 1.758, 10.505, 1.649, 10.649, 1.606, 10.511, 1.666) { fillColor: #e8fbff, opacity: 0 }

// bottom thrusters (landing burn)
botRearO = path(true, 10.078, 1.707, 9.975, 1.745, 9.776, 1.110, 9.702, 0.833, 9.822, 1.093) { fillColor: #4cc9f0, opacity: 0 }
botRearMidO = path(true, 9.496, 1.919, 9.392, 1.957, 9.157, 1.223, 9.068, 0.904, 9.204, 1.206) { fillColor: #4cc9f0, opacity: 0 }
botFrontMidO = path(true, 9.167, 2.039, 9.063, 2.077, 8.828, 1.343, 8.739, 1.024, 8.875, 1.326) { fillColor: #4cc9f0, opacity: 0 }
botFrontO = path(true, 8.556, 2.261, 8.453, 2.299, 8.254, 1.664, 8.179, 1.387, 8.300, 1.647) { fillColor: #4cc9f0, opacity: 0 }
botRearI = path(true, 10.047, 1.718, 10.006, 1.734, 9.858, 1.292, 9.799, 1.101, 9.877, 1.285) { fillColor: #e8fbff, opacity: 0 }
botRearMidI = path(true, 9.465, 1.931, 9.423, 1.946, 9.250, 1.435, 9.181, 1.214, 9.269, 1.428) { fillColor: #e8fbff, opacity: 0 }
botFrontMidI = path(true, 9.136, 2.050, 9.094, 2.065, 8.921, 1.555, 8.852, 1.334, 8.940, 1.548) { fillColor: #e8fbff, opacity: 0 }
botFrontI = path(true, 8.525, 2.273, 8.484, 2.288, 8.336, 1.846, 8.277, 1.655, 8.354, 1.839) { fillColor: #e8fbff, opacity: 0 }

spinFlames = [jetTailRoofO, jetTailRoofI, jetNoseUnderO, jetNoseUnderI]
brakeFlames = [jetNoseRoofO, jetNoseRoofI, jetTailUnderO, jetTailUnderI]
sideFlames = [sideNoseO, sideTailO, sideNoseI, sideTailI]
bottomFlames = [botRearO, botRearMidO, botFrontMidO, botFrontO, botRearI, botRearMidI, botFrontMidI, botFrontI]

// ---- identical car, pre-placed in the upside-down launch pose (body only) ----
carFlight = group [
  path(true, 10.143, 1.909, 9.603, 2.225, 8.934, 2.338, 8.753, 2.427, 8.394, 2.424, 8.361, 2.333, 10.045, 1.730, 10.169, 1.750, 10.198, 1.868) { fillColor: #e63946, color: #ffffff, lineWidth: 0.5 },
  path(true, 9.911, 2.005, 9.603, 2.188, 9.140, 2.267, 9.120, 2.211, 9.885, 1.933) { fillColor: #a8dadc, color: #1d3557, lineWidth: 0.5 },
  circle(9.802, 1.834, 0.165) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(8.748, 2.218, 0.165) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(9.802, 1.834, 0.06) { fillColor: #cfd8dc },
  circle(8.748, 2.218, 0.06) { fillColor: #cfd8dc },
  circle(8.436, 2.390, 0.04) { fillColor: #ffd166 }
]

// ---- 1) accelerate along the floor ----
car : move(cx - 1.8, 0) { startTime: driveStart, duration: driveDur, easing: "ease-in-sine" }

// ---- 2) climb the loop, ending upside down ----
car : rotate(-spin * loopAngle) { pivot: (cx, cy), startTime: climbStart, duration: climbDur, easing: "ease-out-sine" }

tag = text("upside down!", 6.4, 1.0) { color: #ffd166, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
tag : show() { startTime: climbStart + climbDur }
tag : morph[opacity: 1] { startTime: climbStart + climbDur, duration: 300 }
tag : morph[opacity: 0] { startTime: jumpStart - 300, duration: 300 }

// ---- 3) flip off the ramp: the flames rotate exactly like the car, and burn in short bursts ----
for (f, i) in spinFlames {
  f : show() { startTime: jumpStart }
  f : rotate(-spin * flipAngle) { pivot: (7.3, 5.111), startTime: jumpStart, duration: flightDur, easing: "ease-out-quad" }
  f : morph[opacity: clamp(4 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.8 + 0.2 * sin(clamp((T - S) / D, 0, 1) * 60 + i))] { startTime: spinStart, duration: spinDur }
}
for (f, i) in sideFlames {
  f : show() { startTime: jumpStart }
  f : rotate(-spin * flipAngle) { pivot: (7.3, 5.111), startTime: jumpStart, duration: flightDur, easing: "ease-out-quad" }
  f : morph[opacity: clamp(4 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.8 + 0.2 * sin(clamp((T - S) / D, 0, 1) * 60 + i))] { startTime: sideStart, duration: sideDur }
}
for (f, i) in brakeFlames {
  f : show() { startTime: jumpStart }
  f : rotate(-spin * flipAngle) { pivot: (7.3, 5.111), startTime: jumpStart, duration: flightDur, easing: "ease-out-quad" }
  f : morph[opacity: clamp(4 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.8 + 0.2 * sin(clamp((T - S) / D, 0, 1) * 60 + i))] { startTime: brakeStart, duration: brakeDur }
}
for (f, i) in bottomFlames {
  f : show() { startTime: jumpStart }
  f : rotate(-spin * flipAngle) { pivot: (7.3, 5.111), startTime: jumpStart, duration: flightDur, easing: "ease-out-quad" }
  f : morph[opacity: clamp(4 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.8 + 0.2 * sin(clamp((T - S) / D, 0, 1) * 70 + i))] { startTime: bottomStart, duration: bottomDur }
}

car : hide() { startTime: jumpStart }
carFlight : show() { startTime: jumpStart }
carFlight : rotate(-spin * flipAngle) { pivot: (7.3, 5.111), startTime: jumpStart, duration: flightDur, easing: "ease-out-quad" }

// ---- 4) touchdown ----
landTag = text("perfect landing", 4.4, 1.6) { color: #7fd8ff, fontSize: 26, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
landTag : show() { startTime: landTime + 300 }
landTag : morph[opacity: 1] { startTime: landTime + 300, duration: 500 }
