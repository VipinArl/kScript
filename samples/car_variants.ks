canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tA = 0
tP2 = 4000
tP3 = 8000
tHold = 12000
tEnd = 13000

// ---------- floor (parallelogram on the ground) ----------
floor = path(true, 0.43, 7.525, 5.19, 7.525, 10.188, 6.25, 5.428, 6.25) { fillColor: rgba(168,222,220,0.07), color: rgba(168,222,220,0.35), lineWidth: 1.5 }
floor : draw() { startTime: tA, duration: 500 }

// ---------- PHASE 1 (0 - 4 s): the car is drawn quickly (rear face + right side), with 4 fans ----------
side = path(true, 4.83, 7.06, 8.946, 6.01, 8.946, 5.415, 8.162, 5.36, 6.3, 5.665, 4.83, 6.04) { fillColor: #c92f3b, color: #ffffff, lineWidth: 2 }
tireR = path(true, 6.054, 6.544, 6.041, 6.389, 6.003, 6.254, 5.943, 6.148, 5.865, 6.082, 5.777, 6.059, 5.685, 6.083, 5.597, 6.15, 5.519, 6.257, 5.459, 6.393, 5.421, 6.548, 5.408, 6.709, 5.421, 6.864, 5.459, 6.999, 5.519, 7.105, 5.597, 7.171, 5.685, 7.194, 5.777, 7.17, 5.865, 7.103, 5.943, 6.996, 6.003, 6.86, 6.041, 6.705) { fillColor: #14213d, color: #ffffff, lineWidth: 1.5 }
rimR = path(true, 5.927, 6.577, 5.919, 6.483, 5.896, 6.401, 5.859, 6.337, 5.812, 6.296, 5.759, 6.283, 5.703, 6.297, 5.65, 6.338, 5.603, 6.402, 5.566, 6.485, 5.543, 6.579, 5.535, 6.677, 5.543, 6.77, 5.566, 6.852, 5.603, 6.916, 5.65, 6.957, 5.703, 6.97, 5.759, 6.956, 5.812, 6.915, 5.859, 6.851, 5.896, 6.768, 5.919, 6.674) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 }
tireF = path(true, 8.504, 5.919, 8.491, 5.764, 8.453, 5.629, 8.393, 5.523, 8.315, 5.457, 8.227, 5.434, 8.135, 5.458, 8.047, 5.525, 7.969, 5.632, 7.909, 5.768, 7.871, 5.923, 7.858, 6.084, 7.871, 6.239, 7.909, 6.374, 7.969, 6.48, 8.047, 6.546, 8.135, 6.569, 8.227, 6.545, 8.315, 6.478, 8.393, 6.371, 8.453, 6.235, 8.491, 6.08) { fillColor: #14213d, color: #ffffff, lineWidth: 1.5 }
rimF = path(true, 8.377, 5.952, 8.369, 5.858, 8.346, 5.776, 8.309, 5.712, 8.262, 5.671, 8.209, 5.658, 8.153, 5.672, 8.1, 5.713, 8.053, 5.777, 8.016, 5.86, 7.993, 5.954, 7.985, 6.052, 7.993, 6.145, 8.016, 6.227, 8.053, 6.291, 8.1, 6.332, 8.153, 6.345, 8.209, 6.331, 8.262, 6.29, 8.309, 6.226, 8.346, 6.143, 8.369, 6.049) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 }
top0 = path(true, 1.6, 6.04, 4.83, 6.04, 6.3, 5.665, 3.07, 5.665) { fillColor: #f05a66, color: #ffffff, lineWidth: 2 }
top1 = path(true, 3.07, 5.665, 6.3, 5.665, 8.162, 5.36, 4.932, 5.36) { fillColor: #f05a66, color: #ffffff, lineWidth: 2 }
top2 = path(true, 4.932, 5.36, 8.162, 5.36, 8.946, 5.415, 5.716, 5.415) { fillColor: #f05a66, color: #ffffff, lineWidth: 2 }
cabinSide = path(true, 4.98, 5.915, 5.47, 5.025, 6.45, 4.775, 7.038, 5.39) { fillColor: #6fa8b0, color: #ffffff, lineWidth: 1.5 }
cabinRear = path(true, 2.43, 5.915, 4.98, 5.915, 5.47, 5.025, 2.92, 5.025) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1.5 }
cabinTop = path(true, 2.92, 5.025, 5.47, 5.025, 6.45, 4.775, 3.9, 4.775) { fillColor: #f05a66, color: #ffffff, lineWidth: 1.5 }
rear = path(true, 1.6, 7.06, 4.83, 7.06, 4.83, 6.04, 1.6, 6.04) { fillColor: #e63946, color: #ffffff, lineWidth: 2 }
tail = path(true, 1.804, 6.21, 4.626, 6.21, 4.626, 6.108, 1.804, 6.108) { fillColor: #ff5c7a, color: #ff5c7a, lineWidth: 1 }

side : draw() { startTime: 100, duration: 600 }
tireR : draw() { startTime: 500, duration: 400 }
rimR : draw() { startTime: 700, duration: 300 }
tireF : draw() { startTime: 600, duration: 400 }
rimF : draw() { startTime: 800, duration: 300 }
top0 : draw() { startTime: 700, duration: 400 }
top1 : draw() { startTime: 850, duration: 400 }
top2 : draw() { startTime: 1000, duration: 400 }
cabinSide : draw() { startTime: 1200, duration: 400 }
cabinRear : draw() { startTime: 1350, duration: 400 }
cabinTop : draw() { startTime: 1500, duration: 400 }
rear : draw() { startTime: 1700, duration: 500 }
tail : draw() { startTime: 2100, duration: 300 }

// 4 fans in a row on the rear face (blades spin up and keep going to the end)
fanX = [2.178, 2.892, 3.606, 4.32]
for j in range(0, 4) {
  fh = circle(fanX[j], 6.312, 0.26) { fillColor: #0b1224, color: #4cc9f0, lineWidth: 2 }
  fb = group [
    line(fanX[j], 6.312, 0, -0.21) { color: #ffd166, lineWidth: 3 },
    line(fanX[j], 6.312, 0.182, 0.105) { color: #cfd8dc, lineWidth: 3 },
    line(fanX[j], 6.312, -0.182, 0.105) { color: #cfd8dc, lineWidth: 3 },
    circle(fanX[j], 6.312, 0.04) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 }
  ]
  fh : draw() { startTime: 2400 + 120 * j, duration: 400 }
  fb : fadeIn() { startTime: 2500 + 120 * j, duration: 400 }
  fb : rotate(40 * PI) { pivot: (fanX[j], 6.312), startTime: 2700, duration: tEnd - 2700, easing: "ease-in-quad" }
}

tagFan = text("4 fans", 1.0, 5.3) { color: #4cc9f0, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
tagFanLn = line(1.4, 5.5, 0.62, 0.65) { color: #4cc9f0, lineWidth: 1.5 }
tagFan : draw() { startTime: 3200, duration: 500 }
tagFanLn : draw() { startTime: 3400, duration: 300 }

// ---------- model name, seats, component list (right panel) ----------
nameP = text("Performance", 12.4, 1.9) { color: #ffd166, fontSize: 56, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
nameT = text("Thrust", 12.4, 1.9) { color: #4cc9f0, fontSize: 56, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
nameR = text("Rocket", 12.4, 1.9) { color: #ff9d2f, fontSize: 56, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
nameP : draw() { startTime: 2000, duration: 1200 }
nameP : undraw() { startTime: tP2 - 100, duration: 300 }
nameT : draw() { startTime: tP2 + 200, duration: 800 }
nameT : undraw() { startTime: tP3 - 100, duration: 300 }
nameR : draw() { startTime: tP3 + 200, duration: 800 }

// 4 seat icons; two drop out for Thrust, one more for Rocket
for s in range(0, 4) {
  sx = 10.2 + 1.0 * s
  head = circle(sx, 3.8, 0.15) { fillColor: #a8dadc, color: #a8dadc, lineWidth: 1 }
  torso = path(true, sx - 0.22, 4.35, sx - 0.14, 4.0, sx + 0.14, 4.0, sx + 0.22, 4.35) { fillColor: #a8dadc, color: #a8dadc, lineWidth: 1 }
  head : fadeIn() { startTime: 3000 + 100 * s, duration: 300 }
  torso : fadeIn() { startTime: 3000 + 100 * s, duration: 300 }
  if (s >= 2) {
    head : fadeOut() { startTime: tP2 + 200, duration: 400 }
    torso : fadeOut() { startTime: tP2 + 200, duration: 400 }
  } else if (s == 1) {
    head : fadeOut() { startTime: tP3 + 200, duration: 400 }
    torso : fadeOut() { startTime: tP3 + 200, duration: 400 }
  }
}
seat4 = text("4 seats", 12.4, 4.9) { color: #a8dadc, fontSize: 28, fontFamily: "Georgia", textAlign: "center" }
seat2 = text("2 seats", 12.4, 4.9) { color: #a8dadc, fontSize: 28, fontFamily: "Georgia", textAlign: "center" }
seat1 = text("1 seat", 12.4, 4.9) { color: #a8dadc, fontSize: 28, fontFamily: "Georgia", textAlign: "center" }
seat4 : draw() { startTime: 3300, duration: 500 }
seat4 : undraw() { startTime: tP2 + 300, duration: 300 }
seat2 : draw() { startTime: tP2 + 600, duration: 400 }
seat2 : undraw() { startTime: tP3 + 300, duration: 300 }
seat1 : draw() { startTime: tP3 + 600, duration: 400 }

l1 = text("4 rear fans", 12.4, 5.8) { color: #4cc9f0, fontSize: 24, fontFamily: "Georgia", textAlign: "center" }
l2 = text("+ 4 rear thrusters", 12.4, 6.4) { color: #7cff6b, fontSize: 24, fontFamily: "Georgia", textAlign: "center" }
l3 = text("+ 6 side thrusters", 12.4, 7.0) { color: #ff9d2f, fontSize: 24, fontFamily: "Georgia", textAlign: "center" }
l3b = text("3 each side: 2 down, 1 sideways", 12.4, 7.5) { color: #a8dadc, fontSize: 20, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
l1 : draw() { startTime: 3000, duration: 700 }
l2 : draw() { startTime: 6000, duration: 700 }
l3 : draw() { startTime: 10000, duration: 700 }
l3b : draw() { startTime: 10500, duration: 800 }

// ---------- PHASE 2 (4 - 8 s): 4 rear thrusters fall into place under the fans ----------
for i in range(0, 4) {
  ho = circle(fanX[i], 6.822, 0.13) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1.5 }
  hi = circle(fanX[i], 6.822, 0.07) { fillColor: #05070f, color: #05070f, lineWidth: 1 }
  ho : move(0, -8) { startTime: 0, duration: 1 }
  hi : move(0, -8) { startTime: 0, duration: 1 }
  ho : show() { startTime: 5 }
  hi : show() { startTime: 5 }
  ho : move(0, 8) { startTime: tP2 + 400 + 300 * i, duration: 900, easing: "ease-out-bounce" }
  hi : move(0, 8) { startTime: tP2 + 400 + 300 * i, duration: 900, easing: "ease-out-bounce" }
}
tagRear = text("4 thrusters", 3.3, 8.1) { color: #7cff6b, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
tagRearLn = line(3.3, 7.8, 0, -0.8) { color: #7cff6b, lineWidth: 1.5 }
tagRear : draw() { startTime: 6200, duration: 600 }
tagRearLn : draw() { startTime: 6400, duration: 300 }

// ---------- PHASE 3 (8 - 12 s): 3 side thrusters fall on this side (3 more on the hidden side) ----------
bell0 = path(true, 6.178, 6.56, 6.552, 6.56, 6.62, 6.9, 6.11, 6.9) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1.5 }
bell1 = path(true, 7.06, 6.335, 7.434, 6.335, 7.502, 6.675, 6.992, 6.675) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1.5 }
cone = path(true, 6.888, 5.889, 6.888, 6.161, 7.432, 6.025) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1.5 }
ring = circle(6.888, 6.025, 0.1) { fillColor: #05070f, color: #4cc9f0, lineWidth: 2 }
sideParts = [bell0, bell1, cone, ring]
for (sp, i) in sideParts {
  sp : move(0, -8) { startTime: 0, duration: 1 }
  sp : show() { startTime: 5 }
  sp : move(0, 8) { startTime: tP3 + 400 + 280 * i, duration: 900, easing: "ease-out-bounce" }
}
tagDown = text("2 down", 6.8, 8.1) { color: #ff9d2f, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
tagDownA = line(6.37, 7.8, 0, -0.85) { color: #ff9d2f, lineWidth: 1.5 }
tagDownB = line(7.25, 7.8, 0, -1.1) { color: #ff9d2f, lineWidth: 1.5 }
tagSide = text("1 sideways", 8.5, 4.4) { color: #ff9d2f, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
tagSideLn = line(8.2, 4.6, -0.75, 1.35) { color: #ff9d2f, lineWidth: 1.5 }
tagDown : draw() { startTime: 10600, duration: 600 }
tagDownA : draw() { startTime: 10800, duration: 300 }
tagDownB : draw() { startTime: 10800, duration: 300 }
tagSide : draw() { startTime: 11100, duration: 600 }
tagSideLn : draw() { startTime: 11300, duration: 400 }
// 12 - 13 s: nothing new; the final image holds while the fans keep spinning (last effect ends at 13000)
