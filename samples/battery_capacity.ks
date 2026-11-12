canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tA = 0
tOn = 1500
runMs = 3600
tEnd = 6000

// ---------- title ----------
title = text("Everything runs on the battery", 8, 0.8) { color: #ffd166, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title : draw() { startTime: tA, duration: 800 }

// ---------- battery icon (left) ----------
batName = text("battery", 2.8, 2.8) { color: #a8dadc, fontSize: 26, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
batBody = rectangle(0.9, 3.4, 3.8, 2.4) { fillColor: #0b1224, color: #ffffff, lineWidth: 4 }
batTip = rectangle(4.7, 4.3, 0.25, 0.6) { fillColor: #ffffff, color: #ffffff, lineWidth: 1 }
batName : draw() { startTime: 300, duration: 600 }
batBody : fadeIn() { startTime: 300, duration: 500 }
batTip : fadeIn() { startTime: 300, duration: 500 }

// 5 cells: the right ones go out first (4 steps: 80, 60, 40, 20 percent)
cellCol = [#ff5c7a, #ff9d2f, #7cff6b, #7cff6b, #7cff6b]
for idx in range(0, 5) {
  cell = rectangle(1.1 + 0.7 * idx, 3.6, 0.58, 2.0) { fillColor: cellCol[idx], color: cellCol[idx], lineWidth: 1 }
  cell : fadeIn() { startTime: 500, duration: 400 }
  if (idx > 0) {
    cell : fadeOut() { startTime: 1800 + 800 * (4 - idx), duration: 400 }
  }
}

// readout: 100%, 80%, 60%, 40%, 20% (each appears as its cell goes out)
for k in range(0, 5) {
  pv = 100 - 20 * k
  pct = text("${pv}%", 2.8, 6.6) { color: #ffd166, fontSize: 40, fontFamily: "Courier New", fontWeight: "bold", textAlign: "center" }
  if (k == 0) {
    pct : fadeIn() { startTime: 800, duration: 300 }
    pct : fadeOut() { startTime: 1800, duration: 200 }
  } else if (k < 4) {
    pct : fadeIn() { startTime: 1800 + 800 * (k - 1) + 200, duration: 200 }
    pct : fadeOut() { startTime: 1800 + 800 * k, duration: 200 }
  } else {
    pct : fadeIn() { startTime: 1800 + 800 * 3 + 200, duration: 300 }
  }
}
lowTxt = text("LOW", 2.8, 7.5) { color: #ff5c7a, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
lowTxt : draw() { startTime: 4700, duration: 600 }

// ---------- bus wire and branches to the four loads ----------
rowY = [2.2, 3.8, 5.4, 7.0]
brEnd = [8.9, 8.9, 7.75, 8.0]
stem = line(4.95, 4.6, 1.25, 0) { color: rgba(255,209,102,0.5), lineWidth: 2 }
bus = line(6.2, 2.2, 0, 4.8) { color: rgba(255,209,102,0.5), lineWidth: 2 }
stem : draw() { startTime: 800, duration: 400 }
bus : draw() { startTime: 1000, duration: 500 }
for r in range(0, 4) {
  br = line(6.2, rowY[r], brEnd[r] - 6.2, 0) { color: rgba(255,209,102,0.5), lineWidth: 2 }
  br : draw() { startTime: 1100 + 100 * r, duration: 400 }
}

// energy dots: along the stem, then along each branch
for i in range(0, 10) {
  sd = circle(5.05, 4.6, 0.08) { fillColor: #ffd166, color: #ffd166, lineWidth: 1, opacity: 0 }
  sd : show() { startTime: tOn + 330 * i }
  sd : move(1.15, 0) { startTime: tOn + 330 * i, duration: 450, easing: "linear" }
  sd : morph[opacity: 0.9 * clamp(6 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tOn + 330 * i, duration: 450, easing: "linear" }
  sd : hide()
  for r in range(0, 4) {
    bd = circle(6.3, rowY[r], 0.08) { fillColor: #ffd166, color: #ffd166, lineWidth: 1, opacity: 0 }
    bd : show() { startTime: tOn + 400 + 330 * i }
    bd : move(brEnd[r] - 6.3, 0) { startTime: tOn + 400 + 330 * i, duration: 600, easing: "linear" }
    bd : morph[opacity: 0.9 * clamp(6 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tOn + 400 + 330 * i, duration: 600, easing: "linear" }
    bd : hide()
  }
}

// ---------- load 1: main motor (spinning wheel) ----------
wheel = group [
  circle(9.5, 2.2, 0.5) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(9.5, 2.2, 0.28) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  line(9.5, 2.2, 0.28, 0) { color: #14213d, lineWidth: 3 },
  line(9.5, 2.2, 0, 0.28) { color: #14213d, lineWidth: 3 },
  line(9.5, 2.2, -0.28, 0) { color: #14213d, lineWidth: 3 },
  line(9.5, 2.2, 0, -0.28) { color: #14213d, lineWidth: 3 },
  line(9.85, 2.2, 0.15, 0) { color: #ffd166, lineWidth: 3 }
]
lblMotor = text("main motor → tires", 13.2, 2.2) { color: #ffd166, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
wheel : fadeIn() { startTime: 900, duration: 400 }
lblMotor : draw() { startTime: 1000, duration: 700 }
wheel : rotate(12 * PI) { pivot: (9.5, 2.2), startTime: tOn, duration: runMs, easing: "ease-in-quad" }

// ---------- load 2: air conditioning (snowflake) ----------
flake = group [
  line(9.5, 3.8, 0.5, 0) { color: #a8dadc, lineWidth: 4 },
  line(9.5, 3.8, -0.5, 0) { color: #a8dadc, lineWidth: 4 },
  line(9.5, 3.8, 0.25, 0.433) { color: #a8dadc, lineWidth: 4 },
  line(9.5, 3.8, -0.25, -0.433) { color: #a8dadc, lineWidth: 4 },
  line(9.5, 3.8, -0.25, 0.433) { color: #a8dadc, lineWidth: 4 },
  line(9.5, 3.8, 0.25, -0.433) { color: #a8dadc, lineWidth: 4 },
  circle(9.5, 3.8, 0.1) { fillColor: #e8fbff, color: #e8fbff, lineWidth: 1 }
]
lblAc = text("air conditioning (AC)", 13.2, 3.8) { color: #a8dadc, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
flake : fadeIn() { startTime: 1100, duration: 400 }
lblAc : draw() { startTime: 1200, duration: 700 }
flake : rotate(4 * PI) { pivot: (9.5, 3.8), startTime: tOn, duration: runMs, easing: "linear" }

// ---------- load 3: 4 fans ----------
for j in range(0, 4) {
  fx = 8.2 + 0.8 * j
  fh = circle(fx, 5.4, 0.34) { fillColor: #0b1224, color: #4cc9f0, lineWidth: 2 }
  fb = group [
    line(fx, 5.4, 0, -0.27) { color: #ffd166, lineWidth: 3 },
    line(fx, 5.4, 0.234, 0.135) { color: #cfd8dc, lineWidth: 3 },
    line(fx, 5.4, -0.234, 0.135) { color: #cfd8dc, lineWidth: 3 },
    circle(fx, 5.4, 0.05) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 }
  ]
  fh : fadeIn() { startTime: 1200 + 80 * j, duration: 400 }
  fb : fadeIn() { startTime: 1200 + 80 * j, duration: 400 }
  fb : rotate(24 * PI) { pivot: (fx, 5.4), startTime: tOn, duration: runMs, easing: "ease-in-quad" }
}
lblFans = text("4 fans", 13.2, 5.4) { color: #4cc9f0, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
lblFans : draw() { startTime: 1300, duration: 600 }

// ---------- load 4: air compressor (crank) + tank for the cold gas thrusters ----------
comp = circle(8.5, 7.0, 0.38) { fillColor: #2b3a55, color: #ffffff, lineWidth: 2 }
crank = group [
  line(8.5, 7.0, 0.3, 0) { color: #7cff6b, lineWidth: 4 },
  circle(8.8, 7.0, 0.06) { fillColor: #7cff6b, color: #7cff6b, lineWidth: 1 }
]
pipe = line(8.88, 7.0, 0.62, 0) { color: #cfd8dc, lineWidth: 3 }
tank = rectangle(9.5, 6.65, 1.5, 0.7) { fillColor: rgba(76,201,240,0.35), color: #4cc9f0, lineWidth: 2 }
lblComp = text("air compressor + tank", 13.2, 7.0) { color: #7cff6b, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
comp : fadeIn() { startTime: 1300, duration: 400 }
crank : fadeIn() { startTime: 1300, duration: 400 }
pipe : fadeIn() { startTime: 1300, duration: 400 }
tank : fadeIn() { startTime: 1300, duration: 400 }
lblComp : draw() { startTime: 1400, duration: 700 }
crank : rotate(16 * PI) { pivot: (8.5, 7.0), startTime: tOn, duration: runMs, easing: "ease-in-quad" }

// ---------- captions ----------
cap1 = text("motor, AC, fans, compressor: all on the same battery", 8, 8.2) { color: #4cc9f0, fontSize: 26, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
cap1 : draw() { startTime: 2000, duration: 1800 }
cap1 : undraw() { startTime: 4500, duration: 300 }

noteEst = text("illustrative, estimated values", 8, 8.85) { color: #a8dadc, fontSize: 14, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
noteEst : fadeIn() { startTime: 300, duration: 500 }

// ---------- conclusion (last effect ends at 6000) ----------
endTxt = text("Every system drains the same battery", 8, 8.2) { color: #ffd166, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
endTxt : draw() { startTime: 4800, duration: 1200 }
