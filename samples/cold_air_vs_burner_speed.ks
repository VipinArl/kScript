canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tA = 0
tStart = 1500
gap = 150
hotMs = 700
coldMs = 2300
tBars = 6800
tEnd = 10000

// ---------- title ----------
title = text("Exhaust speed: flame vs cold air", 8, 0.8) { color: #ffd166, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title : draw() { startTime: tA, duration: 900 }

// ---------- lanes, finish line, nozzles ----------
laneHot = line(2.5, 2.4, 10.9, 0) { color: rgba(255,157,47,0.25), lineWidth: 1.5 }
laneCold = line(2.5, 4.8, 10.9, 0) { color: rgba(76,201,240,0.25), lineWidth: 1.5 }
finish = line(13.4, 1.6, 0, 4.0) { color: #ffd166, lineWidth: 3 }
finTxt = text("finish", 13.4, 1.35) { color: #ffd166, fontSize: 20, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
laneHot : show() { startTime: 300 }
laneCold : show() { startTime: 300 }
finish : show() { startTime: 300 }
finTxt : show() { startTime: 300 }

casingH = rectangle(1.0, 2.0, 1.0, 0.8) { fillColor: #2b3a55, color: #ffffff, lineWidth: 2 }
bellH = path(true, 2.0, 2.05, 2.5, 2.2, 2.5, 2.6, 2.0, 2.75) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1.5 }
casingC = rectangle(1.0, 4.4, 1.0, 0.8) { fillColor: #2b3a55, color: #ffffff, lineWidth: 2 }
bellC = path(true, 2.0, 4.45, 2.5, 4.6, 2.5, 5.0, 2.0, 5.15) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1.5 }
casingH : show() { startTime: 400 }
bellH : show() { startTime: 400 }
casingC : show() { startTime: 400 }
bellC : show() { startTime: 400 }

lblH = text("FLAME THRUSTER", 3.6, 1.45) { color: #ff9d2f, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
lblC = text("COLD AIR THRUSTER", 3.8, 3.85) { color: #4cc9f0, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
lblH : draw() { startTime: 500, duration: 800 }
lblC : draw() { startTime: 700, duration: 800 }

// ---------- flames at the nozzles ----------
flameH = path(true, 2.5, 2.2, 4.6, 2.4, 2.5, 2.6) { fillColor: #ff9d2f, color: #ffd166, lineWidth: 1, opacity: 0 }
flameHI = path(true, 2.5, 2.3, 3.7, 2.4, 2.5, 2.5) { fillColor: #ffd166, color: #ffd166, lineWidth: 1, opacity: 0 }
plumeC = path(true, 2.5, 4.6, 3.8, 4.8, 2.5, 5.0) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1, opacity: 0 }
plumeCI = path(true, 2.5, 4.7, 3.2, 4.8, 2.5, 4.9) { fillColor: #e8fbff, color: #e8fbff, lineWidth: 1, opacity: 0 }
flameH : show() { startTime: tStart }
flameHI : show() { startTime: tStart }
plumeC : show() { startTime: tStart }
plumeCI : show() { startTime: tStart }
flameH : morph[opacity: clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.9 + 0.1 * sin(90 * clamp((T - S) / D, 0, 1))) * clamp(8 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tStart, duration: 5200, easing: "linear" }
flameHI : morph[opacity: clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.95 + 0.05 * sin(70 * clamp((T - S) / D, 0, 1))) * clamp(8 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tStart, duration: 5200, easing: "linear" }
plumeC : morph[opacity: 0.85 * clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * (0.92 + 0.08 * sin(50 * clamp((T - S) / D, 0, 1))) * clamp(8 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tStart, duration: 5200, easing: "linear" }
plumeCI : morph[opacity: clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * clamp(8 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tStart, duration: 5200, easing: "linear" }
flameH : hide()
flameHI : hide()
plumeC : hide()
plumeCI : hide()

// ---------- the race: same distance (10.5 units), different speed ----------
hotCols = [#ff9d2f, #ffd166, #ff5c7a]
for i in range(0, 34) {
  hp = circle(2.7, 2.4 + 0.15 * sin(i * 2.1), 0.1) { fillColor: hotCols[i % 3], color: hotCols[i % 3], lineWidth: 1, opacity: 0 }
  hp : show() { startTime: tStart + gap * i }
  hp : move(10.5, 0) { startTime: tStart + gap * i, duration: hotMs, easing: "linear" }
  hp : morph[opacity: 0.95 * clamp(6 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tStart + gap * i, duration: hotMs, easing: "linear" }
  hp : hide()

  cp = circle(2.7, 4.8 + 0.15 * sin(i * 2.1), 0.1) { fillColor: #a8dadc, color: #e8fbff, lineWidth: 1, opacity: 0 }
  cp : show() { startTime: tStart + gap * i }
  cp : move(10.5, 0) { startTime: tStart + gap * i, duration: coldMs, easing: "linear" }
  cp : morph[opacity: 0.95 * clamp(6 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: tStart + gap * i, duration: coldMs, easing: "linear" }
  cp : hide()
}

// ---------- arrival tags ----------
arrH = text("arrives first!", 11.9, 3.0) { color: #ff9d2f, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
arrC = text("arrives much later", 11.7, 5.4) { color: #4cc9f0, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
arrH : draw() { startTime: tStart + hotMs, duration: 600 }
arrC : draw() { startTime: tStart + coldMs, duration: 800 }

capRace = text("same distance, very different speed", 8, 8.3) { color: #a8dadc, fontSize: 26, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
capRace : draw() { startTime: 4000, duration: 1400 }
capRace : hide() { startTime: tBars }

// ---------- exhaust speed bars (illustrative) ----------
barTitle = text("exhaust speed", 8, 6.05) { color: #a8dadc, fontSize: 22, fontFamily: "Georgia", textAlign: "center" }
barH = line(3.2, 6.7, 6.0, 0) { color: #ff9d2f, lineWidth: 14 }
barC = line(3.2, 7.5, 1.4, 0) { color: #4cc9f0, lineWidth: 14 }
valH = text("about 3 km/s", 10.9, 6.7) { color: #ff9d2f, fontSize: 24, fontFamily: "Courier New", textAlign: "center" }
valC = text("about 0.7 km/s", 6.3, 7.5) { color: #4cc9f0, fontSize: 24, fontFamily: "Courier New", textAlign: "center" }
tagH = text("flame", 2.0, 6.7) { color: #ff9d2f, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
tagC = text("cold", 2.0, 7.5) { color: #4cc9f0, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
barTitle : draw() { startTime: tBars, duration: 600 }
tagH : draw() { startTime: tBars, duration: 400 }
tagC : draw() { startTime: tBars, duration: 400 }
barH : draw() { startTime: tBars + 200, duration: 1000, easing: "ease-out-quad" }
barC : draw() { startTime: tBars + 200, duration: 1000, easing: "ease-out-quad" }
valH : draw() { startTime: tBars + 1100, duration: 500 }
valC : draw() { startTime: tBars + 1100, duration: 500 }

noteEst = text("illustrative, estimated values", 8, 8.85) { color: #a8dadc, fontSize: 14, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
noteEst : show() { startTime: tBars }

// ---------- conclusion (last effect ends at 10000) ----------
endTxt = text("Faster exhaust = more thrust: the flame is more powerful", 8, 8.3) { color: #ffd166, fontSize: 28, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
endTxt : draw() { startTime: 8200, duration: 1800 }
