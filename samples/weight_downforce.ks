canvas { BGColor: #05070f }

// ---- timeline (ms) ----
tGo = 4500
raceDur = 11000
tCut = 6000
tCutEnd = 8000
tRes = 15800

// ---- title and lane labels ----
title = text("More pressure on the tire = more grip", 8, 0.5) { color: #7fd8ff, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title : draw() { startTime: 0, duration: 1500 }

laneLblA = text("WEIGHT ONLY", 0.4, 1.1) { color: #ff9d2f, fontSize: 18, fontFamily: "Georgia", fontWeight: "bold", textAlign: "left" }
laneLblA : draw() { startTime: 800, duration: 900 }
laneLblB = text("WEIGHT + DOWNFORCE", 0.4, 4.75) { color: #7cff6b, fontSize: 18, fontFamily: "Georgia", fontWeight: "bold", textAlign: "left" }
laneLblB : draw() { startTime: 1000, duration: 1100 }

// ---- roads: ground lines and scrolling dashes (the road moves, the car stays) ----
groundA = line((0.3, 3.5), (11.5, 3.5)) { color: #4cc9f0, lineWidth: 0.8 }
groundA : draw() { startTime: 300, duration: 800 }
groundB = line((0.3, 7.45), (11.5, 7.45)) { color: #4cc9f0, lineWidth: 0.8 }
groundB : draw() { startTime: 400, duration: 800 }
divider = line((0.3, 4.2), (11.5, 4.2)) { color: rgba(255,255,255,0.15), lineWidth: 0.5 }
divider : draw() { startTime: 500, duration: 800 }

for i in range(0, 14) {
  dx = 0.3 + i * 1.6
  dashA = line((dx, 3.95), (dx + 0.8, 3.95)) { color: rgba(255,255,255,0.4), lineWidth: 0.6 }
  dashA : draw() { startTime: 600, duration: 300 }
  dashA : move(-6, 0) { startTime: tGo, duration: raceDur, easing: "ease-out-sine" }
}
for i in range(0, 38) {
  dx = 0.3 + i * 1.6
  dashB = line((dx, 7.9), (dx + 0.8, 7.9)) { color: rgba(255,255,255,0.4), lineWidth: 0.6 }
  dashB : draw() { startTime: 700, duration: 300 }
  dashB : move(-44, 0) { startTime: tGo, duration: raceDur, easing: "ease-in-quad" }
}

// ---- the two cars (bodies) ----
carA = group [
  path(true, 1.380, 2.700, 2.780, 2.445, 4.295, 2.725, 4.750, 2.675, 5.515, 2.960, 5.515, 3.180, 1.450, 3.160, 1.200, 3.020, 1.230, 2.745) { fillColor: #e63946, color: #ffffff, lineWidth: 0.5 },
  path(true, 1.950, 2.675, 2.750, 2.525, 3.800, 2.715, 3.800, 2.850, 1.950, 2.850) { fillColor: #a8dadc, color: #1d3557, lineWidth: 0.5 }
]
carA : show() { startTime: 1300 }
carB = group [
  path(true, 1.380, 6.650, 2.780, 6.395, 4.295, 6.675, 4.750, 6.625, 5.515, 6.910, 5.515, 7.130, 1.450, 7.110, 1.200, 6.970, 1.230, 6.695) { fillColor: #e63946, color: #ffffff, lineWidth: 0.5 },
  path(true, 1.950, 6.625, 2.750, 6.475, 3.800, 6.665, 3.800, 6.800, 1.950, 6.800) { fillColor: #a8dadc, color: #1d3557, lineWidth: 0.5 }
]
carB : show() { startTime: 1400 }

// ---- wheels: tire, rim, tread ticks and a marking, all spinning about the hub ----
wheelX = [2.05, 4.6, 2.05, 4.6]
wheelY = [3.125, 3.125, 7.075, 7.075]
wheelSpin = [160, 160, 117.3, 117.3]
wheelEase = ["ease-out-sine", "ease-out-sine", "ease-in-quad", "ease-in-quad"]
for (wx, wi) in wheelX {
  wy = wheelY[wi]
  tire = circle(wx, wy, 0.375) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 }
  tire : show() { startTime: 1500 }
  rim = circle(wx, wy, 0.2) { fillColor: #cfd8dc }
  rim : show() { startTime: 1500 }
  for j in range(0, 10) {
    ja = j * TAU / 10
    tick = line((wx + 0.3 * cos(ja), wy + 0.3 * sin(ja)), (wx + 0.37 * cos(ja), wy + 0.37 * sin(ja))) { color: rgba(255,255,255,0.7), lineWidth: 0.5 }
    tick : show() { startTime: 1600 }
    tick : rotate(wheelSpin[wi]) { pivot: (wx, wy), startTime: tGo, duration: raceDur, easing: wheelEase[wi] }
  }
  mark = line((wx, wy - 0.1), (wx, wy - 0.37)) { color: #ffd166, lineWidth: 1.2 }
  mark : show() { startTime: 1600 }
  mark : rotate(wheelSpin[wi]) { pivot: (wx, wy), startTime: tGo, duration: raceDur, easing: wheelEase[wi] }
}

markLbl = text("tire marking", 1.6, 2.15) { color: #ffd166, fontSize: 13, fontFamily: "Georgia", textAlign: "center" }
markLbl : draw() { startTime: 3000, duration: 700 }
markLbl : hide() { startTime: 4400 }
markLead = line((1.7, 2.3), (2.03, 2.8)) { color: #ffd166, lineWidth: 0.5 }
markLead : draw() { startTime: 3200, duration: 400 }
markLead : hide() { startTime: 4400 }

// ---- the forces on each car ----
weightA = path(false, 3.3, 1.6, 3.3, 2.44, 3.1, 2.14, 3.3, 2.44, 3.5, 2.14) { color: #ff5c7a, lineWidth: 1.2 }
weightA : draw() { startTime: 2600, duration: 500 }
wLblA = text("weight", 3.6, 1.95) { color: #ff5c7a, fontSize: 13, fontFamily: "Georgia", textAlign: "left" }
wLblA : draw() { startTime: 2800, duration: 500 }

weightB = path(false, 2.7, 5.3, 2.7, 6.31, 2.5, 6.01, 2.7, 6.31, 2.9, 6.01) { color: #ff5c7a, lineWidth: 1.2 }
weightB : draw() { startTime: 2700, duration: 500 }
wLblB = text("weight", 1.9, 5.65) { color: #ff5c7a, fontSize: 13, fontFamily: "Georgia", textAlign: "center" }
wLblB : draw() { startTime: 2900, duration: 500 }
dfB = path(false, 3.9, 5.3, 3.9, 6.5, 3.7, 6.2, 3.9, 6.5, 4.1, 6.2) { color: #ffd166, lineWidth: 1.6 }
dfB : draw() { startTime: 3400, duration: 600 }
dfLbl = text("downforce", 4.25, 5.65) { color: #ffd166, fontSize: 13, fontFamily: "Georgia", textAlign: "left" }
dfLbl : draw() { startTime: 3700, duration: 600 }

// ---- tire smoke on the weight-only car: the wheel spins but the road barely moves ----
for k in range(0, 32) {
  puff = circle(2.05, 3.45, 0.1) { fillColor: #c9d6e8, opacity: 0 }
  puff : show() { startTime: tGo + 200 + k * 420 }
  puff : parallel [
    morph[radius: lerp(0.1, 0.5, clamp((T - S) / D, 0, 1)), opacity: 0.5 * sin(PI * clamp((T - S) / D, 0, 1))],
    move(-1.4, -0.45) { easing: "ease-out-cubic" }
  ] { duration: 1400 }
  puff : hide()
}

// ---- the weight-only car shudders (loop count) ----
carA : move(0, 0.03) { startTime: tGo, duration: 90 }
carA : serial [ move(0, -0.06), move(0, 0.06) ] { duration: 90, loop: 50 }
carA : move(0, -0.03)

// ---- GO! ----
goTxt = text("GO!", 5.8, 4.3) { color: #7cff6b, fontSize: 44, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
goTxt : show() { startTime: tGo }
goTxt : parallel [ morph[opacity: 1 - clamp((T - S) / D, 0, 1)], scale(1.4, 1.4) { easing: "ease-out-cubic" } ] { duration: 700 }
goTxt : hide()

// ---- grip limit panel on the right (hides the scrolling dashes behind it) ----
panelR = rectangle(11.6, 1.2, 4.2, 6.7) { fillColor: #05070f, color: #4cc9f0, lineWidth: 0.6 }
panelR : show() { startTime: 1000 }
hdr = text("GRIP LIMIT", 13.7, 1.5) { color: #a8dadc, fontSize: 16, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
hdr : draw() { startTime: 1200, duration: 700 }

fillA = rectangle(11.9, 2.0, 1.8, 0.5) { fillColor: rgba(255,157,47,0.75) }
fillB = rectangle(11.9, 6.0, 3.6, 0.5) { fillColor: rgba(124,255,107,0.7) }
trackA = rectangle(11.9, 2.0, 3.6, 0.5) { color: #4cc9f0, lineWidth: 0.6 }
trackB = rectangle(11.9, 6.0, 3.6, 0.5) { color: #4cc9f0, lineWidth: 0.6 }
trackA : draw() { startTime: 3600, duration: 500 }
trackB : draw() { startTime: 3700, duration: 500 }
fillA : scale((0.01, 1)) { pivot: (11.9, 2.25), startTime: 0, duration: 1 }
fillB : scale((0.01, 1)) { pivot: (11.9, 6.25), startTime: 0, duration: 1 }
fillA : show() { startTime: 4000 }
fillA : scale((1, 1)) { pivot: (11.9, 2.25), duration: 700, easing: "ease-out-cubic" }
fillB : show() { startTime: 4000 }
fillB : scale((1, 1)) { pivot: (11.9, 6.25), duration: 1000, easing: "ease-out-cubic" }
gripLblA = text("grip 1x", 12.8, 2.25) { color: #ffffff, fontSize: 13, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
gripLblA : draw() { startTime: 4400, duration: 400 }
gripLblB = text("grip 2x", 13.7, 6.25) { color: #ffffff, fontSize: 13, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
gripLblB : draw() { startTime: 4500, duration: 400 }

engLine = line((14.3, 1.8), (14.3, 6.7)) { color: #ffd166, lineWidth: 0.8 }
engLine : draw() { startTime: 4300, duration: 700 }
engMask = rectangle(13.55, 4.3, 1.5, 0.35) { fillColor: #05070f }
engMask : show() { startTime: 5000 }
engLbl = text("engine force", 14.3, 4.5) { color: #ffd166, fontSize: 12, fontFamily: "Georgia", textAlign: "center" }
engLbl : draw() { startTime: 5000, duration: 500 }

// ---- cutaway at 6 s: the contact patch, for 2 s ----
dim = rectangle(0, 0, 16, 9) { fillColor: rgba(5,7,15,0.82), opacity: 0 }
dim : show() { startTime: tCut - 200 }
dim : morph[opacity: 1] { duration: 400 }
dim : morph[opacity: 0] { startTime: tCutEnd - 300, duration: 400 }
dim : hide()

cutPanel = rectangle(3.0, 1.5, 10.6, 6.3) { fillColor: #0b1220, color: #4cc9f0, lineWidth: 0.8 }
cutTitle = text("inside the contact patch", 8.3, 1.9) { color: #7fd8ff, fontSize: 18, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }

// low pressure (weight only)
roadL = path(true, 3.400, 6.204, 3.600, 6.275, 3.800, 6.346, 4.000, 6.241, 4.200, 6.238, 4.400, 6.223, 4.600, 6.140, 4.800, 6.223, 5.000, 6.286, 5.200, 6.280, 5.400, 6.109, 5.600, 6.112, 5.800, 6.120, 6.000, 6.305, 6.200, 6.252, 6.400, 6.150, 6.600, 6.382, 6.800, 6.396, 7.000, 6.311, 7.200, 6.243, 7.400, 6.092, 7.600, 6.070, 7.800, 6.162, 8.000, 6.027, 8.000, 6.95, 3.400, 6.95) { fillColor: #3a3030, color: #8a8f98, lineWidth: 0.6 }
rubberL = path(true, 3.400, 4.3, 8.000, 4.3, 8.000, 6.027, 7.800, 6.115, 7.600, 6.070, 7.400, 6.092, 7.200, 6.115, 7.000, 6.115, 6.800, 6.115, 6.600, 6.115, 6.400, 6.115, 6.200, 6.115, 6.000, 6.115, 5.800, 6.115, 5.600, 6.112, 5.400, 6.109, 5.200, 6.115, 5.000, 6.115, 4.800, 6.115, 4.600, 6.115, 4.400, 6.115, 4.200, 6.115, 4.000, 6.115, 3.800, 6.115, 3.600, 6.115, 3.400, 6.115) { fillColor: #2a2f3d, color: #ffffff, lineWidth: 0.6 }
stripeL = line((4.0, 4.6), (4.8, 5.4)) { color: #ffd166, lineWidth: 1.5 }
treadL = text("tire tread + marking", 6.3, 5.0) { color: #ffffff, fontSize: 14, fontFamily: "Georgia", textAlign: "center" }
contactL1 = path(false, 5.4, 6.109, 5.6, 6.112) { color: #ffd166, lineWidth: 1.6 }
contactL2 = path(false, 7.4, 6.092, 7.6, 6.07) { color: #ffd166, lineWidth: 1.6 }
contactL3 = circle(8.0, 6.027, 0.08) { fillColor: #ffd166 }
arrowL = path(false, 5.7, 3.0, 5.7, 4.15, 5.5, 3.85, 5.7, 4.15, 5.9, 3.85) { color: #ff5c7a, lineWidth: 1.2 }
titleL = text("WEIGHT ONLY", 5.7, 2.55) { color: #ff9d2f, fontSize: 15, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
capL = text("few contact points = less grip", 5.7, 7.3) { color: #ff9d2f, fontSize: 14, fontFamily: "Georgia", textAlign: "center" }

// high pressure (weight + downforce)
roadR = path(true, 8.600, 6.204, 8.800, 6.275, 9.000, 6.346, 9.200, 6.241, 9.400, 6.238, 9.600, 6.223, 9.800, 6.140, 10.000, 6.223, 10.200, 6.286, 10.400, 6.280, 10.600, 6.109, 10.800, 6.112, 11.000, 6.120, 11.200, 6.305, 11.400, 6.252, 11.600, 6.150, 11.800, 6.382, 12.000, 6.396, 12.200, 6.311, 12.400, 6.243, 12.600, 6.092, 12.800, 6.070, 13.000, 6.162, 13.200, 6.027, 13.200, 6.95, 8.600, 6.95) { fillColor: #3a3030, color: #8a8f98, lineWidth: 0.6 }
rubberR = path(true, 8.600, 4.3, 13.200, 4.3, 13.200, 6.027, 13.000, 6.162, 12.800, 6.070, 12.600, 6.092, 12.400, 6.243, 12.200, 6.250, 12.000, 6.250, 11.800, 6.250, 11.600, 6.150, 11.400, 6.250, 11.200, 6.250, 11.000, 6.120, 10.800, 6.112, 10.600, 6.109, 10.400, 6.250, 10.200, 6.250, 10.000, 6.223, 9.800, 6.140, 9.600, 6.223, 9.400, 6.238, 9.200, 6.241, 9.000, 6.250, 8.800, 6.250, 8.600, 6.204) { fillColor: #2a2f3d, color: #ffffff, lineWidth: 0.6 }
stripeR = line((9.2, 4.6), (10.0, 5.4)) { color: #ffd166, lineWidth: 1.5 }
treadR = text("tire tread + marking", 11.5, 5.0) { color: #ffffff, fontSize: 14, fontFamily: "Georgia", textAlign: "center" }
contactR1 = circle(8.6, 6.204, 0.08) { fillColor: #ffd166 }
contactR2 = path(false, 9.2, 6.241, 9.4, 6.238, 9.6, 6.223, 9.8, 6.14, 10.0, 6.223) { color: #ffd166, lineWidth: 1.6 }
contactR3 = path(false, 10.6, 6.109, 10.8, 6.112, 11.0, 6.12) { color: #ffd166, lineWidth: 1.6 }
contactR4 = circle(11.6, 6.15, 0.08) { fillColor: #ffd166 }
contactR5 = path(false, 12.4, 6.243, 12.6, 6.092, 12.8, 6.07, 13.0, 6.162, 13.2, 6.027) { color: #ffd166, lineWidth: 1.6 }
arrowR1 = path(false, 10.4, 3.0, 10.4, 4.15, 10.2, 3.85, 10.4, 4.15, 10.6, 3.85) { color: #ff5c7a, lineWidth: 1.2 }
arrowR2 = path(false, 11.4, 3.0, 11.4, 4.15, 11.2, 3.85, 11.4, 4.15, 11.6, 3.85) { color: #ffd166, lineWidth: 1.6 }
titleR = text("WEIGHT + DOWNFORCE", 10.9, 2.55) { color: #7cff6b, fontSize: 15, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
capR = text("rubber fills the surface = more grip", 10.9, 7.3) { color: #7cff6b, fontSize: 14, fontFamily: "Georgia", textAlign: "center" }

commonCut = [cutPanel, cutTitle]
leftCut = [roadL, rubberL, stripeL, treadL, contactL1, contactL2, contactL3, arrowL, titleL, capL]
rightCut = [roadR, rubberR, stripeR, treadR, contactR1, contactR2, contactR3, contactR4, contactR5, arrowR1, arrowR2, titleR, capR]

for (cs, i) in commonCut {
  cs : draw() { startTime: tCut, duration: 500 }
  cs : hide() { startTime: tCutEnd }
}
for (cs, i) in leftCut {
  cs : draw() { startTime: tCut + 300 + i * 50, duration: 500 }
  cs : hide() { startTime: tCutEnd }
}
for (cs, i) in rightCut {
  cs : draw() { startTime: tCut + 800 + i * 40, duration: 500 }
  cs : hide() { startTime: tCutEnd }
}

// ---- result ----
slipsTxt = text("SLIPS", 13.7, 3.2) { color: #ff5c7a, fontSize: 28, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
slipsTxt : draw() { startTime: tRes, duration: 900 }
gripsTxt = text("GRIPS", 13.7, 7.1) { color: #7cff6b, fontSize: 28, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
gripsTxt : draw() { startTime: tRes + 300, duration: 900 }

final = text("Grip = μ × N : more pressure, more grip, more speed", 8, 8.55) { color: #ffd166, fontSize: 18, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
final : draw() { startTime: 18200, duration: 2800 }
