canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tA = 0
tB = 1000
tC = 2400
tD = 4000
stepMs = 1000
tE = tD + 5 * stepMs
tF = 9700
tG = 11200
tH = 13000
tI = 14200

// ---------- intro title ----------
title = text("Spoiler vs Fans: Downforce at 0 km/h", 8, 0.7) { color: #ffd166, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title : draw() { startTime: tA, duration: 1200 }

// ---------- split screen ----------
divider = line(8, 1.2, 0, 6.7) { color: rgba(76,201,240,0.35), lineWidth: 1.5 }
divider : show() { startTime: tB }

hdrL = text("SPOILER", 3.2, 1.45) { color: #ff5c7a, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
hdrR = text("REAR FANS", 12.8, 1.45) { color: #7cff6b, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
subL = text("needs moving air", 3.2, 1.95) { color: #a8dadc, fontSize: 20, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
subR = text("makes its own airflow", 12.8, 1.95) { color: #a8dadc, fontSize: 20, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
hdrL : draw() { startTime: tB, duration: 800 }
hdrR : draw() { startTime: tB, duration: 800 }
subL : draw() { startTime: tB + 300, duration: 800 }
subR : draw() { startTime: tB + 300, duration: 800 }

// ---------- two rear views (shared body) ----------
for k in range(0, 2) {
  carX = 3.2 + 9.6 * k

  gr = line(carX - 2.4, 7.6, 4.8, 0) { color: #a8dadc, lineWidth: 2 }
  gr : show() { startTime: tB }

  cBody = path(true, carX - 1.6, 6.9, carX - 1.6, 6.0, carX - 1.35, 5.65, carX + 1.35, 5.65, carX + 1.6, 6.0, carX + 1.6, 6.9) { fillColor: #e63946, color: #ffffff, lineWidth: 2 }
  cBody : show() { startTime: tB + 100 }

  cCabin = path(true, carX - 1.15, 5.65, carX - 0.95, 4.85, carX + 0.95, 4.85, carX + 1.15, 5.65) { fillColor: #e63946, color: #ffffff, lineWidth: 2 }
  cCabin : show() { startTime: tB + 200 }

  cWin = path(true, carX - 0.95, 5.55, carX - 0.8, 5.0, carX + 0.8, 5.0, carX + 0.95, 5.55) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 }
  cWin : show() { startTime: tB + 300 }

  cTail = rectangle(carX - 1.45, 5.82, 2.9, 0.12) { fillColor: #ff5c7a, color: #ff5c7a, lineWidth: 1 }
  cTail : show() { startTime: tB + 400 }

  cStrip = rectangle(carX - 1.25, 6.7, 2.5, 0.2) { fillColor: #14213d, color: #ffffff, lineWidth: 1 }
  cStrip : show() { startTime: tB + 500 }

  cTireL = rectangle(carX - 1.75, 6.5, 0.45, 1.1) { fillColor: #14213d, color: #ffffff, lineWidth: 1.5 }
  cTireR = rectangle(carX + 1.3, 6.5, 0.45, 1.1) { fillColor: #14213d, color: #ffffff, lineWidth: 1.5 }
  cTireL : show() { startTime: tB + 600 }
  cTireR : show() { startTime: tB + 600 }
}

// ---------- left: spoiler ----------
spPostL = rectangle(1.84, 4.65, 0.12, 1.05) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 }
spPostR = rectangle(4.44, 4.65, 0.12, 1.05) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 }
spWing = rectangle(1.6, 4.45, 3.2, 0.2) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1.5 }
spEndL = rectangle(1.55, 4.3, 0.08, 0.5) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 }
spEndR = rectangle(4.77, 4.3, 0.08, 0.5) { fillColor: #cfd8dc, color: #ffffff, lineWidth: 1 }
spPostL : show() { startTime: tB + 700 }
spPostR : show() { startTime: tB + 700 }
spWing : show() { startTime: tB + 750 }
spEndL : show() { startTime: tB + 800 }
spEndR : show() { startTime: tB + 800 }

// ---------- right: 4 fans ----------
for j in range(0, 4) {
  fanX = 11.9 + 0.6 * j
  fanY = 6.4
  fanHouse = circle(fanX, fanY, 0.25) { fillColor: #0b1224, color: #4cc9f0, lineWidth: 1.5 }
  fanHouse : show() { startTime: tB + 700 }
  fanBlades = group [
    line(fanX, fanY, 0, -0.19) { color: #ffd166, lineWidth: 2 },
    line(fanX, fanY, 0.165, 0.095) { color: #cfd8dc, lineWidth: 2 },
    line(fanX, fanY, -0.165, 0.095) { color: #cfd8dc, lineWidth: 2 },
    circle(fanX, fanY, 0.04) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 }
  ]
  fanBlades : show() { startTime: tB + 800 }
  fanBlades : rotate(36 * PI) { startTime: tD, duration: 5000, easing: "ease-in-quad", pivot: (fanX, fanY) }
}

// ---------- speedometer (centre) ----------
spdX = 8
spdY = 4.7
spdRing = circle(spdX, spdY, 1.3) { fillColor: #05070f, color: #4cc9f0, lineWidth: 3 }
spdRing : show() { startTime: tC }

for sv in range(0, 401, 50) {
  tkAng = 3 * PI / 4 + 1.5 * PI * sv / 400
  tk = line(spdX + 1.05 * cos(tkAng), spdY + 1.05 * sin(tkAng), 0.15 * cos(tkAng), 0.15 * sin(tkAng)) { color: #a8dadc, lineWidth: 2 }
  tk : show() { startTime: tC + 200 }
}
for lv in range(0, 401, 100) {
  lbAng = 3 * PI / 4 + 1.5 * PI * lv / 400
  lb = text("${lv}", spdX + 0.82 * cos(lbAng), spdY + 0.82 * sin(lbAng)) { color: #a8dadc, fontSize: 14, fontFamily: "Courier New", textAlign: "center" }
  lb : show() { startTime: tC + 300 }
}

spdName = text("SPEED", spdX, 3.95) { color: #a8dadc, fontSize: 14, fontFamily: "Georgia", textAlign: "center" }
needle = line(spdX, spdY, 0.7 * cos(3 * PI / 4), 0.7 * sin(3 * PI / 4)) { color: #ff5c7a, lineWidth: 3 }
hub = circle(spdX, spdY, 0.08) { fillColor: #ff5c7a, color: #ff5c7a, lineWidth: 1 }
spdTxt = text("0 km/h", spdX, 5.58) { color: #ffd166, fontSize: 24, fontFamily: "Courier New", textAlign: "center" }
spdName : show() { startTime: tC + 300 }
needle : show() { startTime: tC + 400 }
hub : show() { startTime: tC + 400 }
spdTxt : show() { startTime: tC + 500 }

// ---------- readouts under each car ----------
lblL = text("no airflow  ↓ 0 N", 3.2, 8.2) { color: #ff5c7a, fontSize: 20, fontFamily: "Courier New", textAlign: "center" }
lblL : show() { startTime: tC }

rpmVals = [0, 1000, 2500, 4000, 5500, 7000]
dfLabels = ["0 kN", "0.4 kN", "2.6 kN", "6.5 kN", "12.3 kN", "20 kN = W"]
rpmStart = [tC, tD, tD + stepMs, tD + 2 * stepMs, tD + 3 * stepMs, tD + 4 * stepMs]
rpmEnd = [tD, tD + stepMs, tD + 2 * stepMs, tD + 3 * stepMs, tD + 4 * stepMs, tE]
for i in range(0, 6) {
  rt = text("RPM ${rpmVals[i]}  ↓ ${dfLabels[i]}", 12.8, 8.2) { color: #7cff6b, fontSize: 20, fontFamily: "Courier New", textAlign: "center" }
  rt : show() { startTime: rpmStart[i] }
  rt : hide() { startTime: rpmEnd[i] }
}

// ---------- left: no downforce marks ----------
noX = text("×", 3.2, 3.3) { color: #ff5c7a, fontSize: 64, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
noTag = text("no downforce", 3.2, 3.9) { color: #ff5c7a, fontSize: 20, fontFamily: "Georgia", textAlign: "center" }
noX : show() { startTime: tD }
noTag : show() { startTime: tD }

// ---------- right: downforce arrow grows with RPM ----------
dfArrow = path(false, 12.8, 2.7, 12.8, 4.5, 12.6, 4.2, 12.8, 4.5, 13.0, 4.2) { color: #7cff6b, lineWidth: 5 }
dfArrow : scale((1, 0.01)) { pivot: (12.8, 2.7), startTime: 0, duration: 1 }
dfArrow : show() { startTime: tD }
dfArrow : scale((1, 1)) { pivot: (12.8, 2.7), duration: 5000, easing: "ease-in-quad" }
dfTag = text("downforce", 13.85, 3.4) { color: #7cff6b, fontSize: 20, fontFamily: "Georgia", textAlign: "center" }
dfTag : show() { startTime: tD }

noteScene = text("illustrative, estimated values", 8, 8.85) { color: #a8dadc, fontSize: 14, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
noteScene : show() { startTime: tB }

// ---------- cover: fades the scene out ----------
cover = rectangle(0, 0, 16, 9) { fillColor: #05070f, color: #05070f, lineWidth: 1, opacity: 0 }
cover : show() { startTime: tE }
cover : morph[opacity: clamp((T - S) / D, 0, 1)] { duration: 600, easing: "linear" }

// ---------- graph: speed vs downforce ----------
gTitle = text("Downforce vs speed", 8, 0.8) { color: #ffd166, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
gTitle : draw() { startTime: tF, duration: 900 }

// plot mapping: X = 2.2 + 0.04 * v (v in km/h, 0..300); Y = 7.2 - 4 * d (d in W, 0..1.2)
yAxis = line(2.2, 7.2, 0, -4.9) { color: #a8dadc, lineWidth: 2.5 }
xAxis = line(2.2, 7.2, 12.4, 0) { color: #a8dadc, lineWidth: 2.5 }
yAxis : draw() { startTime: tF, duration: 800 }
xAxis : draw() { startTime: tF, duration: 800 }

for gv in range(0, 301, 100) {
  gxp = 2.2 + 0.04 * gv
  gtk = line(gxp, 7.2, 0, 0.12) { color: #a8dadc, lineWidth: 2 }
  glb = text("${gv}", gxp, 7.55) { color: #a8dadc, fontSize: 18, fontFamily: "Courier New", textAlign: "center" }
  gtk : show() { startTime: tF + 800 }
  glb : show() { startTime: tF + 800 }
}
yTickVals = [0, 0.5, 1.0]
yTickLabs = ["0", "0.5 W", "1 W"]
for ii in range(0, 3) {
  gyp = 7.2 - 4 * yTickVals[ii]
  gytk = line(2.08, gyp, 0.12, 0) { color: #a8dadc, lineWidth: 2 }
  gylb = text(yTickLabs[ii], 1.45, gyp) { color: #a8dadc, fontSize: 18, fontFamily: "Courier New", textAlign: "center" }
  gytk : show() { startTime: tF + 800 }
  gylb : show() { startTime: tF + 800 }
}

xTitle = text("Speed (km/h)", 8.2, 7.95) { color: #a8dadc, fontSize: 20, fontFamily: "Georgia", textAlign: "center" }
yTitle = text("Downforce (× W)", 3.8, 2.0) { color: #a8dadc, fontSize: 20, fontFamily: "Georgia", textAlign: "center" }
wDef = text("W = car weight (about 20 kN)", 11.4, 2.05) { color: #a8dadc, fontSize: 16, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
xTitle : draw() { startTime: tF + 800, duration: 600 }
yTitle : draw() { startTime: tF + 800, duration: 600 }
wDef : draw() { startTime: tF + 800, duration: 600 }
noteGraph = text("illustrative, estimated curves", 8, 8.85) { color: #a8dadc, fontSize: 14, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
noteGraph : show() { startTime: tF }

// start-of-race markers at 0 km/h
dotF = circle(2.2, 3.2, 0.12) { fillColor: #7cff6b, color: #ffffff, lineWidth: 1.5 }
dotS = circle(2.2, 7.2, 0.12) { fillColor: #ff5c7a, color: #ffffff, lineWidth: 1.5 }
zeroTag = text("0 km/h", 3.2, 6.75) { color: #ffd166, fontSize: 20, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
dotF : show() { startTime: tG }
dotS : show() { startTime: tG }
zeroTag : show() { startTime: tG }

// fan line: flat from the very first pixel (1 W)
fanLine = line(2.2, 3.2, 12, 0) { color: #7cff6b, lineWidth: 4 }
fanLine : draw() { startTime: tG, duration: 2500, easing: "linear" }

// spoiler curve: d = 0.35 * (v / 300)^2, drawn as 28 segments
nSeg = 28
segMs = 60
for s in range(0, nSeg) {
  va = 300 * s / nSeg
  vb = 300 * (s + 1) / nSeg
  sg = line((2.2 + 0.04 * va, 7.2 - 4 * 0.35 * pow(va / 300, 2)), (2.2 + 0.04 * vb, 7.2 - 4 * 0.35 * pow(vb / 300, 2))) { color: #ff5c7a, lineWidth: 4 }
  sg : draw() { startTime: tG + s * segMs, duration: segMs, easing: "linear" }
}

// curve labels
lblFan = text("Fans (set RPM)", 12.9, 2.85) { color: #7cff6b, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
lblSpoil = text("Spoiler", 13.3, 5.4) { color: #ff5c7a, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
lblFan : draw() { startTime: tH, duration: 500 }
lblSpoil : draw() { startTime: tH, duration: 500 }

// punchline (last effect ends at 16500)
punch = text("Spoilers need speed. Fans don't.", 8, 8.45) { color: #ffd166, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
punch : draw() { startTime: tI, duration: 1300 }
