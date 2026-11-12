canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tA = 0
tHot = 800
tHotEnd = 4800
tSwitch = 5000
tCold = 5200
tColdEnd = 9400
tEnd = 10000

// ---------- set: ground, post, nozzle, person, bush ----------
ground = line(0.3, 6.3, 15.4, 0) { color: #a8dadc, lineWidth: 2 }
ground : show() { startTime: 100 }

post = rectangle(1.9, 5.0, 0.5, 1.3) { fillColor: #2b3a55, color: #ffffff, lineWidth: 1.5 }
casing = rectangle(1.5, 4.0, 1.5, 1.0) { fillColor: #2b3a55, color: #ffffff, lineWidth: 2 }
bell = path(true, 3.0, 4.1, 3.4, 4.3, 3.4, 4.7, 3.0, 4.9) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1.5 }
post : show() { startTime: 200 }
casing : show() { startTime: 200 }
bell : show() { startTime: 200 }
bellHot = path(true, 3.0, 4.1, 3.4, 4.3, 3.4, 4.7, 3.0, 4.9) { fillColor: #ff5c7a, color: #ff5c7a, lineWidth: 1, opacity: 0 }
bellHot : show() { startTime: tHot }
bellHot : morph[opacity: 0.75 * clamp(4 * clamp((T - S) / D, 0, 1), 0, 1) * clamp(8 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tHot, duration: tHotEnd - tHot, easing: "linear" }
bellHot : hide()

person = group [
  circle(10.8, 4.0, 0.28) { fillColor: #05070f, color: #ffffff, lineWidth: 2.5 },
  line(10.8, 4.28, 0, 1.1) { color: #ffffff, lineWidth: 2.5 },
  line(10.8, 4.55, -0.5, 0.5) { color: #ffffff, lineWidth: 2.5 },
  line(10.8, 4.55, 0.5, 0.5) { color: #ffffff, lineWidth: 2.5 },
  line(10.8, 5.38, -0.35, 0.9) { color: #ffffff, lineWidth: 2.5 },
  line(10.8, 5.38, 0.35, 0.9) { color: #ffffff, lineWidth: 2.5 }
]
person : show() { startTime: 300 }

bush = group [
  circle(9.4, 5.9, 0.38) { fillColor: #2e6b34, color: #3b7a3b, lineWidth: 1.5 },
  circle(9.8, 5.75, 0.3) { fillColor: #2e6b34, color: #3b7a3b, lineWidth: 1.5 },
  circle(9.1, 5.8, 0.28) { fillColor: #2e6b34, color: #3b7a3b, lineWidth: 1.5 }
]
bush : show() { startTime: 300 }

// ---------- PART 1 (0 - 5 s): hot flame, risky ----------
title1 = text("A thruster with a flame", 8, 0.8) { color: #ff9d2f, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title1 : draw() { startTime: tA, duration: 800 }
title1 : hide() { startTime: tSwitch - 100 }

flameO = path(true, 3.4, 4.25, 5.0, 3.85, 6.6, 4.0, 8.8, 4.5, 6.6, 5.0, 5.0, 5.15, 3.4, 4.75) { fillColor: #ff9d2f, color: #ff5c7a, lineWidth: 1, opacity: 0 }
flameI = path(true, 3.4, 4.35, 5.0, 4.1, 6.8, 4.5, 5.0, 4.9, 3.4, 4.65) { fillColor: #ffd166, color: #ffd166, lineWidth: 1, opacity: 0 }
flameO : show() { startTime: tHot }
flameI : show() { startTime: tHot }
flameO : morph[opacity: clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.9 + 0.1 * sin(90 * clamp((T - S) / D, 0, 1))) * clamp(8 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tHot, duration: tHotEnd - tHot, easing: "linear" }
flameI : morph[opacity: clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.95 + 0.05 * sin(70 * clamp((T - S) / D, 0, 1))) * clamp(8 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tHot, duration: tHotEnd - tHot, easing: "linear" }
for k in range(0, 14) {
  flameO : scale((0.86 + 0.14 * (k % 3), 1)) { pivot: (3.4, 4.5), startTime: tHot + 260 * k, duration: 260, easing: "ease-in-out-sine" }
  flameI : scale((0.8 + 0.18 * ((k + 1) % 3), 1)) { pivot: (3.4, 4.5), startTime: tHot + 260 * k, duration: 260, easing: "ease-in-out-sine" }
}
flameO : hide()
flameI : hide()

// sparks flying toward the bush and the person
for i in range(0, 14) {
  sp = circle(3.7, 4.5 + 0.3 * sin(i * 2.3), 0.06) { fillColor: #ffd166, color: #ff9d2f, lineWidth: 1, opacity: 0 }
  sp : show() { startTime: 1000 + 250 * i }
  sp : move(5.2 + 0.25 * (i % 3), 0.35 * sin(i * 1.9)) { startTime: 1000 + 250 * i, duration: 650, easing: "ease-out-quad" }
  sp : morph[opacity: 0.9 * (1 - clamp((T - S) / D, 0, 1))] { startTime: 1000 + 250 * i, duration: 650, easing: "linear" }
  sp : hide()
}

// danger ring around the person (pulses)
ringHot = circle(10.8, 4.9, 1.1) { fillColor: rgba(255,92,122,0.12), color: #ff5c7a, lineWidth: 2, opacity: 0 }
ringHot : show() { startTime: 1500 }
ringHot : morph[opacity: 0.4 + 0.5 * abs(sin(8 * PI * clamp((T - S) / D, 0, 1)))] { startTime: 1500, duration: tHotEnd - 1500, easing: "linear" }
ringHot : hide()

bang = text("!", 10.8, 2.9) { color: #ff5c7a, fontSize: 44, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
bang : show() { startTime: 1700 }
bang : hide() { startTime: tSwitch - 100 }

// the bush catches fire
bushFireL = path(true, 8.95, 5.55, 9.2, 4.75, 9.45, 5.55) { fillColor: #ff9d2f, color: #ffd166, lineWidth: 1, opacity: 0 }
bushFireC = path(true, 9.3, 5.4, 9.6, 4.5, 9.9, 5.4) { fillColor: #ff5c7a, color: #ffd166, lineWidth: 1, opacity: 0 }
bushFireR = path(true, 9.65, 5.5, 9.9, 4.85, 10.15, 5.5) { fillColor: #ff9d2f, color: #ffd166, lineWidth: 1, opacity: 0 }
bushFires = [bushFireL, bushFireC, bushFireR]
for (b, i) in bushFires {
  b : show() { startTime: 3000 + 150 * i }
  b : morph[opacity: clamp(6 * clamp((T - S) / D, 0, 1), 0, 1) * (0.85 + 0.15 * sin(60 * clamp((T - S) / D, 0, 1) + 2 * i)) * clamp(8 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: 3000 + 150 * i, duration: tHotEnd - 3000 - 150 * i, easing: "linear" }
  b : hide()
}
char = circle(9.45, 5.85, 0.62) { fillColor: rgba(0,0,0,0.55), color: rgba(0,0,0,0.55), lineWidth: 1, opacity: 0 }
char : show() { startTime: 3400 }
char : morph[opacity: clamp((T - S) / D, 0, 1)] { startTime: 3400, duration: 1000, easing: "linear" }
char : hide() { startTime: tSwitch - 100 }

// risk labels
warnTri = path(true, 13.5, 1.3, 14.25, 2.7, 12.75, 2.7) { fillColor: #ff5c7a, color: #ffffff, lineWidth: 2 }
warnBang = text("!", 13.5, 2.4) { color: #ffffff, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
risky = text("RISKY", 13.5, 3.4) { color: #ff5c7a, fontSize: 40, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
warnTri : show() { startTime: 1500 }
warnBang : show() { startTime: 1500 }
risky : draw() { startTime: 1500, duration: 800 }
warnTri : hide() { startTime: tSwitch - 100 }
warnBang : hide() { startTime: tSwitch - 100 }
risky : hide() { startTime: tSwitch - 100 }

capHot = text("Fire hazard: burns, ignites, melts things nearby", 8, 8.2) { color: #ff5c7a, fontSize: 26, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
capHot : draw() { startTime: 1800, duration: 1600 }
capHot : hide() { startTime: tSwitch - 100 }

// ---------- PART 2 (5 - 10 s): cold air, safe ----------
title2 = text("A cold air thruster", 8, 0.8) { color: #4cc9f0, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title2 : draw() { startTime: tSwitch, duration: 800 }

plumeO = path(true, 3.4, 4.3, 8.6, 4.05, 9.6, 4.5, 8.6, 4.95, 3.4, 4.7) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1, opacity: 0 }
plumeI = path(true, 3.4, 4.4, 7.0, 4.28, 8.0, 4.5, 7.0, 4.72, 3.4, 4.6) { fillColor: #e8fbff, color: #e8fbff, lineWidth: 1, opacity: 0 }
plumeO : show() { startTime: tCold }
plumeI : show() { startTime: tCold }
plumeO : morph[opacity: 0.85 * clamp(6 * clamp((T - S) / D, 0, 1), 0, 1) * (0.92 + 0.08 * sin(50 * clamp((T - S) / D, 0, 1))) * clamp(6 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tCold, duration: tColdEnd - tCold, easing: "linear" }
plumeI : morph[opacity: clamp(6 * clamp((T - S) / D, 0, 1), 0, 1) * (0.95 + 0.05 * sin(40 * clamp((T - S) / D, 0, 1))) * clamp(6 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tCold, duration: tColdEnd - tCold, easing: "linear" }
plumeO : hide()
plumeI : hide()

// cold air particles streaming along the plume
for i in range(0, 12) {
  ap = circle(3.7, 4.5 + 0.22 * sin(i * 2.1), 0.07) { fillColor: #e8fbff, color: #a8dadc, lineWidth: 1, opacity: 0 }
  ap : show() { startTime: 5400 + 300 * i }
  ap : move(6.2, 0.2 * sin(i * 1.3)) { startTime: 5400 + 300 * i, duration: 550, easing: "ease-out-quad" }
  ap : morph[opacity: 0.9 * (1 - clamp((T - S) / D, 0, 1))] { startTime: 5400 + 300 * i, duration: 550, easing: "linear" }
  ap : hide()
}

// calm ring and smile on the person
ringSafe = circle(10.8, 4.9, 1.1) { fillColor: rgba(124,255,107,0.1), color: #7cff6b, lineWidth: 2 }
ringSafe : show() { startTime: 5800 }
smile = arc(10.8, 4.02, 0.14, 20, 160) { color: #7cff6b, lineWidth: 2 }
smile : show() { startTime: 5800 }

safeTxt = text("SAFE", 13.5, 3.4) { color: #7cff6b, fontSize: 40, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
check = path(false, 13.0, 1.9, 13.4, 2.3, 14.1, 1.5) { color: #7cff6b, lineWidth: 6 }
safeTxt : draw() { startTime: 6000, duration: 800 }
check : draw() { startTime: 6400, duration: 700 }

capCold = text("No fire, no heat: safe to use right next to people", 8, 8.2) { color: #7cff6b, fontSize: 26, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
capCold : draw() { startTime: 7000, duration: 1500 }
capCold : hide() { startTime: 8600 }

endTxt = text("Cold air thrust = safe thrust", 8, 8.2) { color: #ffd166, fontSize: 32, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
endTxt : draw() { startTime: 8600, duration: 1400 }
