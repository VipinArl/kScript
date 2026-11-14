canvas { BGColor: #05070f }

// ---------- timing (ms): second N spans (N-1)*1000 to N*1000 ----------
ty = 1.9
tClap = 2000
t2 = 3000
tCarA = 5000
t3 = 6000
tCarB = 8000
tTake = 8600
tLand = 9500
t4 = 10000
tFly = 12000
tEnd = 13000

// ---------- ground ----------
ground = line(0.3, 7.4, 15.4, 0) { color: #a8dadc, lineWidth: 2 }
ground : fadeIn() { startTime: 0, duration: 300 }

// ---------- texts: write in 1 s, hold, delete in 1 s ----------
tx1 = text("What do you think about the video?", 8.0, ty) { color: #ffd166, fontSize: 56, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
tx1 : draw() { startTime: 0, duration: 1000 }
tx1 : undraw() { startTime: 2000, duration: 1000 }

tx2 = text("What do you think about the car?", 8.0, ty) { color: #4cc9f0, fontSize: 56, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
tx2 : draw() { startTime: t2, duration: 1000 }
tx2 : undraw() { startTime: 5000, duration: 1000 }

tx3 = text("Thank you for watching!", 8.0, ty) { color: #7cff6b, fontSize: 64, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
tx3 : draw() { startTime: t3, duration: 1000 }
tx3 : undraw() { startTime: 8000, duration: 2000 }

tx4 = text("Take care!", 8.0, ty) { color: #ff9d2f, fontSize: 90, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
tx4 : draw() { startTime: t4, duration: 1000 }

// =====================================================
// 3rd second: the clap board
// =====================================================
boardBody = rectangle(6.7, 4.7, 2.6, 1.7) { fillColor: #14213d, color: #ffffff, lineWidth: 3 }
boardLines = group [
  line(6.9, 5.1, 2.2, 0) { color: #a8dadc, lineWidth: 2 },
  line(6.9, 5.5, 2.2, 0) { color: #a8dadc, lineWidth: 2 },
  line(6.9, 5.9, 1.4, 0) { color: #a8dadc, lineWidth: 2 }
]
clapper = group [
  rectangle(6.7, 4.2, 2.6, 0.45) { fillColor: #ffffff, color: #ffffff, lineWidth: 2 },
  path(true, 6.7, 4.65, 6.96, 4.65, 7.22, 4.2, 6.96, 4.2) { fillColor: #05070f, color: #05070f, lineWidth: 1 },
  path(true, 7.74, 4.65, 8.0, 4.65, 8.26, 4.2, 8.0, 4.2) { fillColor: #05070f, color: #05070f, lineWidth: 1 },
  path(true, 8.78, 4.65, 9.04, 4.65, 9.3, 4.2, 9.04, 4.2) { fillColor: #05070f, color: #05070f, lineWidth: 1 }
]
clapper : rotate(-0.5) { pivot: (6.7, 4.65), startTime: 0, duration: 1 }
boardBody : fadeIn() { startTime: tClap, duration: 300 }
boardLines : fadeIn() { startTime: tClap, duration: 300 }
clapper : fadeIn() { startTime: tClap, duration: 300 }
// clap, with a small bounce
clapper : rotate(0) { pivot: (6.7, 4.65), startTime: 2300, duration: 160, easing: "ease-in-quad" }
clapper : rotate(-0.1) { pivot: (6.7, 4.65), startTime: 2460, duration: 70, easing: "ease-out-quad" }
clapper : rotate(0) { pivot: (6.7, 4.65), startTime: 2530, duration: 70, easing: "ease-in-quad" }
boardBody : fadeOut() { startTime: 2800, duration: 200 }
boardLines : fadeOut() { startTime: 2800, duration: 200 }
clapper : fadeOut() { startTime: 2800, duration: 200 }

// =====================================================
// 6th second: car with rear thrusters drives left to right (accelerating)
// =====================================================
carA = group [
  path(true, -4.32, 6.6, -2.92, 6.345, -1.405, 6.625, -0.95, 6.575, -0.185, 6.86, -0.185, 7.08, -4.25, 7.06, -4.5, 6.92, -4.47, 6.645) { fillColor: #e63946, color: #ffffff, lineWidth: 2 },
  path(true, -3.75, 6.575, -2.95, 6.425, -1.9, 6.615, -1.9, 6.75, -3.75, 6.75) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 },
  circle(-3.65, 7.025, 0.375) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(-3.65, 7.025, 0.175) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  circle(-1.1, 7.025, 0.375) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(-1.1, 7.025, 0.175) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 }
]
carA : show() { startTime: 0 }
carA : move(20.7, 0) { startTime: tCarA, duration: 1000, easing: "ease-in-quad" }

rowsT = [6.7, 6.825]
for i in range(0, 2) {
  jAo = path(true, -4.5, rowsT[i] - 0.04, -4.5, rowsT[i] + 0.04, -5.7, rowsT[i]) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1, opacity: 0 }
  jAc = path(true, -4.5, rowsT[i] - 0.02, -4.5, rowsT[i] + 0.02, -5.1, rowsT[i]) { fillColor: #e8fbff, color: #e8fbff, lineWidth: 1, opacity: 0 }
  jAo : show() { startTime: tCarA }
  jAc : show() { startTime: tCarA }
  jAo : move(20.7, 0) { startTime: tCarA, duration: 1000, easing: "ease-in-quad" }
  jAc : move(20.7, 0) { startTime: tCarA, duration: 1000, easing: "ease-in-quad" }
  jAo : morph[opacity: 0.9 * clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.85 + 0.15 * sin(60 * clamp((T - S) / D, 0, 1) + i))] { startTime: tCarA, duration: 1000, easing: "linear" }
  jAc : morph[opacity: clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.9 + 0.1 * sin(70 * clamp((T - S) / D, 0, 1) + i))] { startTime: tCarA, duration: 1000, easing: "linear" }
  jAo : hide() { startTime: 6000 }
  jAc : hide() { startTime: 6000 }
}

// =====================================================
// 9th - 10th seconds: drive in, jump, flip, land, drive out (constant speed 10.35 units/s)
//   rear x: -4.5 (start), 1.71 at take-off (8.6 s), 11.0 at landing (9.5 s), 16.2 at the end
// =====================================================
carIn = group [
  path(true, -4.32, 6.6, -2.92, 6.345, -1.405, 6.625, -0.95, 6.575, -0.185, 6.86, -0.185, 7.08, -4.25, 7.06, -4.5, 6.92, -4.47, 6.645) { fillColor: #e63946, color: #ffffff, lineWidth: 2 },
  path(true, -3.75, 6.575, -2.95, 6.425, -1.9, 6.615, -1.9, 6.75, -3.75, 6.75) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 },
  circle(-3.65, 7.025, 0.375) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(-3.65, 7.025, 0.175) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  circle(-1.1, 7.025, 0.375) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(-1.1, 7.025, 0.175) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 }
]
carIn : show() { startTime: 0 }
carIn : move(6.21, 0) { startTime: tCarB, duration: 600, easing: "linear" }
carIn : hide() { startTime: tTake }

carJ = group [
  path(true, -4.32, 6.6, -2.92, 6.345, -1.405, 6.625, -0.95, 6.575, -0.185, 6.86, -0.185, 7.08, -4.25, 7.06, -4.5, 6.92, -4.47, 6.645) { fillColor: #e63946, color: #ffffff, lineWidth: 2 },
  path(true, -3.75, 6.575, -2.95, 6.425, -1.9, 6.615, -1.9, 6.75, -3.75, 6.75) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 },
  circle(-3.65, 7.025, 0.375) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(-3.65, 7.025, 0.175) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  circle(-1.1, 7.025, 0.375) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(-1.1, 7.025, 0.175) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 }
]
carJ : move(6.21, 0) { startTime: 0, duration: 1 }
carJ : show() { startTime: tTake }
carJ : move(14.49, 0) { startTime: tTake, duration: 1400, easing: "linear" }
carJ : move(0, -2.0) { startTime: tTake, duration: 450, easing: "ease-out-quad" }
carJ : move(0, 2.0) { startTime: tTake + 450, duration: 450, easing: "ease-in-quad" }
carJ : rotate(2 * PI) { startTime: tTake + 200, duration: 650, easing: "ease-in-out-sine" }

// rear jets while driving in
for i in range(0, 2) {
  jBo = path(true, -4.5, rowsT[i] - 0.04, -4.5, rowsT[i] + 0.04, -5.7, rowsT[i]) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1, opacity: 0 }
  jBc = path(true, -4.5, rowsT[i] - 0.02, -4.5, rowsT[i] + 0.02, -5.1, rowsT[i]) { fillColor: #e8fbff, color: #e8fbff, lineWidth: 1, opacity: 0 }
  jBo : show() { startTime: tCarB }
  jBc : show() { startTime: tCarB }
  jBo : move(6.21, 0) { startTime: tCarB, duration: 600, easing: "linear" }
  jBc : move(6.21, 0) { startTime: tCarB, duration: 600, easing: "linear" }
  jBo : morph[opacity: 0.9 * clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.85 + 0.15 * sin(60 * clamp((T - S) / D, 0, 1) + i))] { startTime: tCarB, duration: 600, easing: "linear" }
  jBc : morph[opacity: clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.9 + 0.1 * sin(70 * clamp((T - S) / D, 0, 1) + i))] { startTime: tCarB, duration: 600, easing: "linear" }
  jBo : hide() { startTime: tTake }
  jBc : hide() { startTime: tTake }
}

// two bottom jets kick the car up at take-off (they follow the rise, then switch off)
bjx = [-3.15, -1.625]
for i in range(0, 2) {
  jDo = path(true, bjx[i] - 0.09, 7.06, bjx[i] + 0.09, 7.06, bjx[i], 7.6) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1, opacity: 0 }
  jDc = path(true, bjx[i] - 0.045, 7.06, bjx[i] + 0.045, 7.06, bjx[i], 7.4) { fillColor: #e8fbff, color: #e8fbff, lineWidth: 1, opacity: 0 }
  jDo : move(6.21, 0) { startTime: 0, duration: 1 }
  jDc : move(6.21, 0) { startTime: 0, duration: 1 }
  jDo : show() { startTime: tTake }
  jDc : show() { startTime: tTake }
  jDo : move(14.49, 0) { startTime: tTake, duration: 1400, easing: "linear" }
  jDc : move(14.49, 0) { startTime: tTake, duration: 1400, easing: "linear" }
  jDo : move(0, -2.0) { startTime: tTake, duration: 450, easing: "ease-out-quad" }
  jDc : move(0, -2.0) { startTime: tTake, duration: 450, easing: "ease-out-quad" }
  jDo : morph[opacity: 0.9 * clamp(5 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.85 + 0.15 * sin(70 * clamp((T - S) / D, 0, 1) + i))] { startTime: tTake, duration: 300, easing: "linear" }
  jDc : morph[opacity: clamp(5 * sin(PI * clamp((T - S) / D, 0, 1)), 0, 1) * (0.9 + 0.1 * sin(80 * clamp((T - S) / D, 0, 1) + i))] { startTime: tTake, duration: 300, easing: "linear" }
  jDo : hide() { startTime: tTake + 320 }
  jDc : hide() { startTime: tTake + 320 }
}

// rear jets again after landing (rear x = 11.0 -> 16.2)
for i in range(0, 2) {
  jLo = path(true, -4.5, rowsT[i] - 0.04, -4.5, rowsT[i] + 0.04, -5.7, rowsT[i]) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1, opacity: 0 }
  jLc = path(true, -4.5, rowsT[i] - 0.02, -4.5, rowsT[i] + 0.02, -5.1, rowsT[i]) { fillColor: #e8fbff, color: #e8fbff, lineWidth: 1, opacity: 0 }
  jLo : move(15.5, 0) { startTime: 0, duration: 1 }
  jLc : move(15.5, 0) { startTime: 0, duration: 1 }
  jLo : show() { startTime: tLand }
  jLc : show() { startTime: tLand }
  jLo : move(5.175, 0) { startTime: tLand, duration: 500, easing: "linear" }
  jLc : move(5.175, 0) { startTime: tLand, duration: 500, easing: "linear" }
  jLo : morph[opacity: 0.9 * clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.85 + 0.15 * sin(60 * clamp((T - S) / D, 0, 1) + i))] { startTime: tLand, duration: 500, easing: "linear" }
  jLc : morph[opacity: clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.9 + 0.1 * sin(70 * clamp((T - S) / D, 0, 1) + i))] { startTime: tLand, duration: 500, easing: "linear" }
  jLo : hide() { startTime: t4 }
  jLc : hide() { startTime: t4 }
}

// =====================================================
// 13th second: thrusters under the text, and it flies away
// =====================================================
fjx = [6.2, 8.0, 9.8]
for i in range(0, 3) {
  jTo = path(true, fjx[i] - 0.16, 2.6, fjx[i] + 0.16, 2.6, fjx[i], 3.5) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1, opacity: 0 }
  jTc = path(true, fjx[i] - 0.08, 2.6, fjx[i] + 0.08, 2.6, fjx[i], 3.15) { fillColor: #e8fbff, color: #e8fbff, lineWidth: 1, opacity: 0 }
  jTo : show() { startTime: tFly }
  jTc : show() { startTime: tFly }
  jTo : morph[opacity: 0.9 * clamp(5 * clamp((T - S) / D, 0, 1), 0, 1) * (0.85 + 0.15 * sin(60 * clamp((T - S) / D, 0, 1) + i))] { startTime: tFly, duration: 1000, easing: "linear" }
  jTc : morph[opacity: clamp(5 * clamp((T - S) / D, 0, 1), 0, 1) * (0.9 + 0.1 * sin(70 * clamp((T - S) / D, 0, 1) + i))] { startTime: tFly, duration: 1000, easing: "linear" }
  jTo : move(3, -8) { startTime: tFly + 300, duration: 700, easing: "ease-in-quad" }
  jTc : move(3, -8) { startTime: tFly + 300, duration: 700, easing: "ease-in-quad" }
}
tx4 : move(3, -8) { startTime: tFly + 300, duration: 700, easing: "ease-in-quad" }
