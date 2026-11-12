canvas { BGColor: #05070f }

// ---- timeline (ms) ----
tA = 2400
dA = 2800
tB = tA + dA
dB = 4300
tFinal = 10000

// ---- title ----
title = text("Upside down: why 2x suction?", 8, 0.45) { color: #7fd8ff, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title : draw() { startTime: 0, duration: 1000 }

// ---- ceiling with scrolling dashes (the ceiling moves, the car stays) ----
ceiling = rectangle(0.3, 1.0, 8.9, 0.6) { fillColor: #1a2233, color: #4cc9f0, lineWidth: 0.8 }
ceiling : show() { startTime: 0 }
for hi in range(0, 12) {
  hx = 0.6 + hi * 0.75
  hatch = line((hx, 1.0), (hx - 0.3, 0.75)) { color: rgba(255,255,255,0.25), lineWidth: 0.5 }
  hatch : draw() { startTime: 100 + hi * 40, duration: 200 }
}
for i in range(0, 24) {
  dx = 0.3 + i * 1.6
  dash = line((dx, 1.3), (dx + 0.8, 1.3)) { color: rgba(255,255,255,0.4), lineWidth: 0.6 }
  dash : draw() { startTime: 500, duration: 300 }
  dash : move(-1.2, 0) { startTime: tA, duration: dA, easing: "linear" }
  dash : move(-20, 0) { startTime: tB, duration: dB, easing: "linear" }
}

// ---- suction chamber between the car floor and the ceiling ----
chamber = rectangle(2.8, 1.6, 2.0, 0.43) { fillColor: rgba(76,201,240,0.25) }
chamber : show() { startTime: 1600 }
chamberHi = rectangle(2.8, 1.6, 2.0, 0.43) { fillColor: rgba(76,201,240,0.85), opacity: 0 }
chamberHi : show() { startTime: tB }
chamberHi : morph[opacity: 1] { duration: 600 }

// ---- the car, upside down under the ceiling ----
carBody = group [
  path(true, 1.234, 2.640, 3.054, 2.971, 5.024, 2.607, 5.615, 2.672, 6.609, 2.302, 6.609, 2.016, 1.325, 2.042, 1.000, 2.224, 1.039, 2.582) { fillColor: #e63946, color: #ffffff, lineWidth: 0.5 },
  path(true, 1.975, 2.672, 3.015, 2.867, 4.380, 2.620, 4.380, 2.445, 1.975, 2.445) { fillColor: #a8dadc, color: #1d3557, lineWidth: 0.5 }
]
carBody : show() { startTime: 800 }

wheelRear = group [
  circle(2.105, 2.088, 0.488) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(2.105, 2.088, 0.26) { fillColor: #cfd8dc },
  line((2.505, 2.088), (2.585, 2.088)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((2.388, 2.371), (2.444, 2.427)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((2.105, 2.488), (2.105, 2.568)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((1.822, 2.371), (1.766, 2.427)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((1.705, 2.088), (1.625, 2.088)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((1.822, 1.805), (1.766, 1.749)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((2.105, 1.688), (2.105, 1.608)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((2.388, 1.805), (2.444, 1.749)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((2.105, 2.208), (2.105, 2.558)) { color: #ffd166, lineWidth: 1.2 }
]
wheelRear : show() { startTime: 1000 }

wheelFront = group [
  circle(5.42, 2.088, 0.488) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(5.42, 2.088, 0.26) { fillColor: #cfd8dc },
  line((5.820, 2.088), (5.900, 2.088)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((5.703, 2.371), (5.759, 2.427)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((5.420, 2.488), (5.420, 2.568)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((5.137, 2.371), (5.081, 2.427)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((5.020, 2.088), (4.940, 2.088)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((5.137, 1.805), (5.081, 1.749)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((5.420, 1.688), (5.420, 1.608)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((5.703, 1.805), (5.759, 1.749)) { color: rgba(255,255,255,0.7), lineWidth: 0.5 },
  line((5.42, 2.208), (5.42, 2.558)) { color: #ffd166, lineWidth: 1.2 }
]
wheelFront : show() { startTime: 1100 }

// wheels: phase A spins fast in place (slip), phase B turns at the speed of the ceiling (grip)
wheelRear : rotate(60) { pivot: (2.105, 2.088), startTime: tA, duration: dA, easing: "linear" }
wheelRear : rotate(101) { pivot: (2.105, 2.088), startTime: tB, duration: dB, easing: "linear" }
wheelFront : rotate(60) { pivot: (5.42, 2.088), startTime: tA, duration: dA, easing: "linear" }
wheelFront : rotate(101) { pivot: (5.42, 2.088), startTime: tB, duration: dB, easing: "linear" }

// ---- the body droops with no pressing force, then snaps up when the suction doubles ----
carBody : move(0, 0.18) { startTime: tA, duration: 400, easing: "ease-out-quad" }
carBody : serial [ move(0, -0.03), move(0, 0.03) ] { duration: 70, loop: 16 }
carBody : move(0, -0.18) { startTime: tB, duration: 500, easing: "ease-out-back" }

// ---- sparks at the rear wheel while it slips ----
for k in range(0, 11) {
  spark = circle(2.105, 1.65, 0.05) { fillColor: #ff9d2f, opacity: 0 }
  spark : show() { startTime: tA + 300 + k * 190 }
  spark : parallel [
    move(-1.1, 0.5) { easing: "ease-out-cubic" },
    morph[opacity: 1 - clamp((T - S) / D, 0, 1)]
  ] { duration: 600 }
  spark : hide()
}

// ---- speed streaks in phase B ----
for k in range(0, 14) {
  sy = 3.6 + ((k * 7) % 11) * 0.19
  streak = line((9.0, sy), (10.2, sy)) { color: rgba(255,255,255,0.35), lineWidth: 0.5 }
  streak : show() { startTime: tB + 400 + k * 260 }
  streak : move(-10, 0) { duration: 700, easing: "ease-in-quad" }
  streak : hide()
}

// ---- tags on the left ----
slipTag = text("wheels spin, no traction", 4.6, 4.2) { color: #ff9d2f, fontSize: 16, fontFamily: "Georgia", textAlign: "center" }
slipTag : draw() { startTime: tA + 200, duration: 900 }
slipTag : hide() { startTime: tB }
tractionTag = text("traction!", 4.6, 4.2) { color: #7cff6b, fontSize: 20, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
tractionTag : draw() { startTime: tB + 600, duration: 600 }

// ---- pressing-force bar: 0 in phase A, 1W in phase B (full bar = 2W) ----
barFill = rectangle(0.8, 7.0, 3.8, 0.45) { fillColor: rgba(124,255,107,0.7) }
barTrack = rectangle(0.8, 7.0, 7.6, 0.45) { color: #4cc9f0, lineWidth: 0.6 }
barHead = text("pressing force of the wheels on the ceiling", 4.6, 6.65) { color: #4cc9f0, fontSize: 14, fontFamily: "Georgia", textAlign: "center" }
barHead : draw() { startTime: 1500, duration: 900 }
barTrack : draw() { startTime: 1700, duration: 600 }
tick0 = text("0", 0.8, 7.8) { color: #a8dadc, fontSize: 13, fontFamily: "Georgia", textAlign: "center" }
tick1 = text("1W", 4.6, 7.8) { color: #a8dadc, fontSize: 13, fontFamily: "Georgia", textAlign: "center" }
tick2 = text("2W", 8.4, 7.8) { color: #a8dadc, fontSize: 13, fontFamily: "Georgia", textAlign: "center" }
tick0 : draw() { startTime: 1900, duration: 300 }
tick1 : draw() { startTime: 2000, duration: 300 }
tick2 : draw() { startTime: 2100, duration: 300 }
zeroTxt = text("0 = nothing to grip with", 4.6, 7.22) { color: #ff5c7a, fontSize: 14, fontFamily: "Georgia", textAlign: "center" }
zeroTxt : draw() { startTime: tA, duration: 700 }
zeroTxt : hide() { startTime: tB }
barFill : scale((0.01, 1)) { pivot: (0.8, 7.225), startTime: 0, duration: 1 }
barFill : show() { startTime: tB + 500 }
barFill : scale((1, 1)) { pivot: (0.8, 7.225), duration: 700, easing: "ease-out-cubic" }

// ---- force panel on the right (hides the dashes behind it) ----
panel = rectangle(9.2, 0.9, 6.6, 7.3) { fillColor: #05070f, color: #4cc9f0, lineWidth: 0.6 }
panel : show() { startTime: 1000 }
hdr = text("FORCES ON THE CAR", 12.5, 1.4) { color: #a8dadc, fontSize: 16, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
hdr : draw() { startTime: 1200, duration: 900 }

carDot = circle(12.5, 4.6, 0.14) { fillColor: #ffffff }
carDot : show() { startTime: 1300 }
weightArrow = path(false, 12.5, 4.6, 12.5, 5.8, 12.3, 5.5, 12.5, 5.8, 12.7, 5.5) { color: #ff5c7a, lineWidth: 1.4 }
weightArrow : draw() { startTime: 1400, duration: 500 }
weightLbl = text("weight = 1W", 12.9, 5.5) { color: #ff5c7a, fontSize: 15, fontFamily: "Georgia", fontWeight: "bold", textAlign: "left" }
weightLbl : draw() { startTime: 1700, duration: 600 }

suctionArrow = path(false, 12.5, 4.6, 12.5, 3.4, 12.3, 3.7, 12.5, 3.4, 12.7, 3.7) { color: #ffd166, lineWidth: 1.6 }
suctionArrow : draw() { startTime: 1600, duration: 500 }
suctionArrow : scale((1, 2)) { pivot: (12.5, 4.6), startTime: tB, duration: 600, easing: "ease-out-cubic" }
sucA = text("suction = 1W", 12.9, 3.5) { color: #ffd166, fontSize: 15, fontFamily: "Georgia", fontWeight: "bold", textAlign: "left" }
sucA : draw() { startTime: 1900, duration: 600 }
sucA : hide() { startTime: tB }
sucB = text("suction = 2W", 12.9, 3.0) { color: #ffd166, fontSize: 15, fontFamily: "Georgia", fontWeight: "bold", textAlign: "left" }
sucB : draw() { startTime: tB + 300, duration: 600 }

eqA = text("net = 1W - 1W = 0", 12.5, 6.5) { color: #ff5c7a, fontSize: 18, fontFamily: "Georgia", textAlign: "center" }
eqA : draw() { startTime: 2100, duration: 900 }
eqA : hide() { startTime: tB }
eqB = text("net = 2W - 1W = 1W", 12.5, 6.5) { color: #7cff6b, fontSize: 18, fontFamily: "Georgia", textAlign: "center" }
eqB : draw() { startTime: tB + 300, duration: 900 }

noGrip = text("NO GRIP", 12.5, 7.5) { color: #ff5c7a, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
noGrip : draw() { startTime: tA + 300, duration: 800 }
noGrip : hide() { startTime: tB }
gripTxt = text("GRIP!", 12.5, 7.5) { color: #7cff6b, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
gripTxt : draw() { startTime: tB + 400, duration: 700 }

// ---- takeaway (the last effect ends at exactly 11 s) ----
final = text("2W suction - W weight = W grip: it drives upside down", 8, 8.6) { color: #ffd166, fontSize: 18, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
final : draw() { startTime: tFinal, duration: 1000 }
