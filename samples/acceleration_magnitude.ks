canvas { BGColor: #05070f }

// ---------- clip boundaries (ms) ----------
tA = 0
tB = 5000
tC = 10000
tD = 15000
tEnd = 24000

// erase windows (undraw): clips 1-3 finish 100 ms before the cut, clip 4 ends at 24000
uA = tB - 700
uB = tC - 700
uC = tD - 700
uD = tEnd - 800

// ---------- note shown on every clip ----------
noteEst = text("illustrative, estimated values", 8, 8.85) { color: #a8dadc, fontSize: 14, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
noteEst : draw() { startTime: 300, duration: 700 }
noteEst : undraw() { startTime: uD, duration: 800 }

// =====================================================
// CLIP 1 (0 - 5 s): 0 to 97 km/h in 0.81 s
// =====================================================
dcx = 4.0
dcy = 4.4
ring = circle(dcx, dcy, 1.7) { color: #4cc9f0, lineWidth: 3 }
ring : draw() { startTime: tA + 100, duration: 700 }
ring : undraw() { startTime: uA, duration: 600 }

for sv in range(0, 201, 50) {
  dAng = 3 * PI / 4 + 1.5 * PI * sv / 200
  dtk = line(dcx + 1.3 * cos(dAng), dcy + 1.3 * sin(dAng), 0.25 * cos(dAng), 0.25 * sin(dAng)) { color: #a8dadc, lineWidth: 2 }
  dlb = text("${sv}", dcx + 0.95 * cos(dAng), dcy + 0.95 * sin(dAng)) { color: #a8dadc, fontSize: 14, fontFamily: "Courier New", textAlign: "center" }
  dtk : draw() { startTime: tA + 500, duration: 400 }
  dlb : draw() { startTime: tA + 600, duration: 400 }
  dtk : undraw() { startTime: uA, duration: 600 }
  dlb : undraw() { startTime: uA, duration: 600 }
}

dNeedle = line(dcx, dcy, 1.1 * cos(3 * PI / 4), 1.1 * sin(3 * PI / 4)) { color: #ff5c7a, lineWidth: 4 }
dHub = circle(dcx, dcy, 0.09) { fillColor: #ff5c7a, color: #ff5c7a, lineWidth: 1 }
dNeedle : draw() { startTime: tA + 900, duration: 400 }
dHub : draw() { startTime: tA + 900, duration: 300 }
dNeedle : rotate(1.5 * PI * 97 / 200) { pivot: (dcx, dcy), startTime: 1500, duration: 810, easing: "linear" }
dNeedle : undraw() { startTime: uA, duration: 600 }
dHub : undraw() { startTime: uA, duration: 600 }

// stepped digital readout: 0, 24, 49, 73, 97 km/h across the 0.81 s run
rdVals = [0, 24, 49, 73, 97]
for k in range(0, 5) {
  rdv = rdVals[k]
  rdT = text("${rdv} km/h", dcx, 5.5) { color: #ffd166, fontSize: 24, fontFamily: "Courier New", textAlign: "center" }
  if (k == 0) {
    rdT : show() { startTime: tA + 1300 }
    rdT : hide() { startTime: 1702 }
  } else if (k < 4) {
    rdT : show() { startTime: 1500 + 202 * k }
    rdT : hide() { startTime: 1500 + 202 * (k + 1) }
  } else {
    rdT : show() { startTime: 1500 + 202 * k }
    rdT : hide() { startTime: uA }
  }
}

c1a = text("0 → 97 km/h", 11.6, 3.7) { color: #ffd166, fontSize: 56, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
c1b = text("in just 0.81 seconds", 11.6, 4.9) { color: #4cc9f0, fontSize: 40, fontFamily: "Georgia", textAlign: "center" }
c1c = text("(0 - 60 mph)", 11.6, 5.8) { color: #a8dadc, fontSize: 26, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
c1a : draw() { startTime: 1000, duration: 1000 }
c1b : draw() { startTime: 2400, duration: 1000 }
c1c : draw() { startTime: 3500, duration: 700 }
c1a : undraw() { startTime: uA, duration: 600 }
c1b : undraw() { startTime: uA, duration: 600 }
c1c : undraw() { startTime: uA, duration: 600 }

// =====================================================
// CLIP 2 (5 - 10 s): acceleration is 33 m/s2
// =====================================================
c2ground = line(0.8, 5.6, 6.6, 0) { color: #a8dadc, lineWidth: 2 }
c2body = path(true, 1.416, 4.64, 3.096, 4.334, 4.914, 4.67, 5.46, 4.61, 6.378, 4.952, 6.378, 5.216, 1.5, 5.192, 1.2, 5.024, 1.236, 4.694) { fillColor: #e63946, color: #ffffff, lineWidth: 2 }
c2win = path(true, 2.1, 4.61, 3.06, 4.43, 4.32, 4.658, 4.32, 4.82, 2.1, 4.82) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 }
c2wh1 = circle(2.22, 5.15, 0.45) { fillColor: #14213d, color: #ffffff, lineWidth: 2 }
c2wh2 = circle(5.28, 5.15, 0.45) { fillColor: #14213d, color: #ffffff, lineWidth: 2 }
c2arrow = path(false, 2.0, 3.4, 6.0, 3.4, 5.7, 3.2, 6.0, 3.4, 5.7, 3.6) { color: #7cff6b, lineWidth: 5 }
c2lab = text("acceleration", 4.0, 2.85) { color: #7cff6b, fontSize: 26, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
c2ground : draw() { startTime: tB + 100, duration: 500 }
c2body : draw() { startTime: tB + 300, duration: 800 }
c2win : draw() { startTime: tB + 600, duration: 500 }
c2wh1 : draw() { startTime: tB + 800, duration: 400 }
c2wh2 : draw() { startTime: tB + 800, duration: 400 }
c2arrow : draw() { startTime: tB + 1200, duration: 700 }
c2lab : draw() { startTime: tB + 1500, duration: 700 }
c2ground : undraw() { startTime: uB, duration: 600 }
c2body : undraw() { startTime: uB, duration: 600 }
c2win : undraw() { startTime: uB, duration: 600 }
c2wh1 : undraw() { startTime: uB, duration: 600 }
c2wh2 : undraw() { startTime: uB, duration: 600 }
c2arrow : undraw() { startTime: uB, duration: 600 }
c2lab : undraw() { startTime: uB, duration: 600 }

c2a = text("33 m/s²", 11.6, 3.8) { color: #ffd166, fontSize: 72, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
c2b = text("every second, the speed", 11.6, 5.0) { color: #4cc9f0, fontSize: 30, fontFamily: "Georgia", textAlign: "center" }
c2c = text("rises by 33 m/s", 11.6, 5.6) { color: #4cc9f0, fontSize: 30, fontFamily: "Georgia", textAlign: "center" }
c2a : draw() { startTime: tB + 700, duration: 1200 }
c2b : draw() { startTime: tB + 2200, duration: 1000 }
c2c : draw() { startTime: tB + 3000, duration: 800 }
c2a : undraw() { startTime: uB, duration: 600 }
c2b : undraw() { startTime: uB, duration: 600 }
c2c : undraw() { startTime: uB, duration: 600 }

// =====================================================
// CLIP 3 (10 - 15 s): 3.4 times gravity (1 g = 1.5 units)
// =====================================================
c3l1 = text("gravity: 9.8 m/s²  (1 g)", 4.0, 3.0) { color: #a8dadc, fontSize: 24, fontFamily: "Georgia", textAlign: "center" }
c3b1 = line(1.2, 3.5, 1.5, 0) { color: #a8dadc, lineWidth: 18 }
c3l2 = text("car: 33 m/s²  (3.4 g)", 4.0, 4.4) { color: #ff9d2f, fontSize: 24, fontFamily: "Georgia", textAlign: "center" }
c3b2 = line(1.2, 4.9, 5.1, 0) { color: #ff9d2f, lineWidth: 18 }
c3t1 = line(2.7, 4.65, 0, 0.5) { color: #05070f, lineWidth: 3 }
c3t2 = line(4.2, 4.65, 0, 0.5) { color: #05070f, lineWidth: 3 }
c3t3 = line(5.7, 4.65, 0, 0.5) { color: #05070f, lineWidth: 3 }
c3l1 : draw() { startTime: tC + 200, duration: 700 }
c3b1 : draw() { startTime: tC + 700, duration: 500 }
c3l2 : draw() { startTime: tC + 1300, duration: 700 }
c3b2 : draw() { startTime: tC + 1800, duration: 1400, easing: "ease-out-quad" }
c3t1 : draw() { startTime: tC + 2300, duration: 200 }
c3t2 : draw() { startTime: tC + 2500, duration: 200 }
c3t3 : draw() { startTime: tC + 2700, duration: 200 }
c3l1 : undraw() { startTime: uC, duration: 600 }
c3b1 : undraw() { startTime: uC, duration: 600 }
c3l2 : undraw() { startTime: uC, duration: 600 }
c3b2 : undraw() { startTime: uC, duration: 600 }
c3t1 : undraw() { startTime: uC, duration: 600 }
c3t2 : undraw() { startTime: uC, duration: 600 }
c3t3 : undraw() { startTime: uC, duration: 600 }

c3a = text("3.4 × gravity", 11.6, 3.8) { color: #ffd166, fontSize: 60, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
c3b = text("33 ÷ 9.8 ≈ 3.4", 11.6, 5.0) { color: #4cc9f0, fontSize: 40, fontFamily: "Courier New", textAlign: "center" }
c3a : draw() { startTime: tC + 900, duration: 1200 }
c3b : draw() { startTime: tC + 2400, duration: 1000 }
c3a : undraw() { startTime: uC, duration: 600 }
c3b : undraw() { startTime: uC, duration: 600 }

// =====================================================
// CLIP 4 (15 - 24 s): the passenger feels about 3.5 times their weight
// =====================================================
seatBack = rectangle(1.2, 3.2, 0.35, 2.6) { fillColor: #2b3a55, color: #ffffff, lineWidth: 2 }
seatBase = rectangle(1.2, 5.5, 2.4, 0.3) { fillColor: #2b3a55, color: #ffffff, lineWidth: 2 }
pHead = circle(2.0, 3.55, 0.3) { color: #ffffff, lineWidth: 3 }
pTorso = line(2.0, 3.85, 0, 1.55) { color: #ffffff, lineWidth: 6 }
pThigh = line(2.0, 5.4, 1.7, 0) { color: #ffffff, lineWidth: 6 }
pShin = line(3.7, 5.4, 0, 1.3) { color: #ffffff, lineWidth: 6 }
pArm = line(2.0, 4.2, 0.9, 0.55) { color: #ffffff, lineWidth: 5 }
c4ground = line(0.8, 6.7, 6.4, 0) { color: #a8dadc, lineWidth: 2 }
c4acc = path(false, 2.0, 2.4, 5.4, 2.4, 5.1, 2.2, 5.4, 2.4, 5.1, 2.6) { color: #7cff6b, lineWidth: 5 }
c4accL = text("acceleration", 3.7, 1.95) { color: #7cff6b, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
c4push = path(false, 3.9, 4.5, 2.4, 4.5, 2.7, 4.3, 2.4, 4.5, 2.7, 4.7) { color: #ff5c7a, lineWidth: 6 }
c4pushL = text("pressed back into the seat", 3.9, 7.4) { color: #ff5c7a, fontSize: 22, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }

seatBack : draw() { startTime: tD + 100, duration: 600 }
seatBase : draw() { startTime: tD + 100, duration: 600 }
c4ground : draw() { startTime: tD + 100, duration: 500 }
pHead : draw() { startTime: tD + 600, duration: 400 }
pTorso : draw() { startTime: tD + 800, duration: 400 }
pThigh : draw() { startTime: tD + 1000, duration: 400 }
pShin : draw() { startTime: tD + 1200, duration: 300 }
pArm : draw() { startTime: tD + 1300, duration: 300 }
c4acc : draw() { startTime: tD + 1800, duration: 800 }
c4accL : draw() { startTime: tD + 2000, duration: 800 }
c4push : draw() { startTime: tD + 3300, duration: 700 }
c4pushL : draw() { startTime: tD + 3600, duration: 1000 }
seatBack : undraw() { startTime: uD, duration: 800 }
seatBase : undraw() { startTime: uD, duration: 800 }
c4ground : undraw() { startTime: uD, duration: 800 }
pHead : undraw() { startTime: uD, duration: 800 }
pTorso : undraw() { startTime: uD, duration: 800 }
pThigh : undraw() { startTime: uD, duration: 800 }
pShin : undraw() { startTime: uD, duration: 800 }
pArm : undraw() { startTime: uD, duration: 800 }
c4acc : undraw() { startTime: uD, duration: 800 }
c4accL : undraw() { startTime: uD, duration: 800 }
c4push : undraw() { startTime: uD, duration: 800 }
c4pushL : undraw() { startTime: uD, duration: 800 }
// the push arrow pulses once the number appears
c4push : scale((1.2, 1)) { pivot: (3.9, 4.5), startTime: tD + 5500, duration: 400, easing: "ease-in-out-sine" }
c4push : scale((1, 1)) { pivot: (3.9, 4.5), startTime: tD + 5900, duration: 400, easing: "ease-in-out-sine" }
c4push : scale((1.2, 1)) { pivot: (3.9, 4.5), startTime: tD + 6300, duration: 400, easing: "ease-in-out-sine" }
c4push : scale((1, 1)) { pivot: (3.9, 4.5), startTime: tD + 6700, duration: 400, easing: "ease-in-out-sine" }

c4a = text("The passenger feels", 11.6, 2.6) { color: #4cc9f0, fontSize: 34, fontFamily: "Georgia", textAlign: "center" }
c4b = text("≈ 3.5 × their weight", 11.6, 3.8) { color: #ffd166, fontSize: 48, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
c4c = text("approximately, during the launch", 11.6, 4.7) { color: #a8dadc, fontSize: 26, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
c4a : draw() { startTime: tD + 1800, duration: 1000 }
c4b : draw() { startTime: tD + 3000, duration: 1500 }
c4c : draw() { startTime: tD + 4600, duration: 1000 }
c4a : undraw() { startTime: uD, duration: 800 }
c4b : undraw() { startTime: uD, duration: 800 }
c4c : undraw() { startTime: uD, duration: 800 }

// weight bars: normal vs launch (1 unit = 1.2)
bn = text("normal", 9.3, 6.1) { color: #a8dadc, fontSize: 22, fontFamily: "Georgia", textAlign: "center" }
bnb = line(8.2, 6.5, 1.2, 0) { color: #a8dadc, lineWidth: 16 }
bl = text("at launch", 9.3, 7.2) { color: #ff9d2f, fontSize: 22, fontFamily: "Georgia", textAlign: "center" }
blb = line(8.2, 7.6, 4.2, 0) { color: #ff9d2f, lineWidth: 16 }
bn : draw() { startTime: tD + 6000, duration: 500 }
bnb : draw() { startTime: tD + 6200, duration: 500 }
bl : draw() { startTime: tD + 6700, duration: 500 }
blb : draw() { startTime: tD + 6900, duration: 1200, easing: "ease-out-quad" }
bn : undraw() { startTime: uD, duration: 800 }
bnb : undraw() { startTime: uD, duration: 800 }
bl : undraw() { startTime: uD, duration: 800 }
blb : undraw() { startTime: uD, duration: 800 }
