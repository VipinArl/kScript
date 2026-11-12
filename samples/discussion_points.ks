canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tList = 400
tP1 = 2000
tP2 = 4800
tP3 = 8000
tEndCap = 10000
tEnd = 12000

// ---------- title and the list of terms ----------
title = text("What we will discuss", 8, 0.6) { color: #ffd166, fontSize: 34, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title : draw() { startTime: 0, duration: 800 }

hd1 = text("1  Suction using fans", 3.0, 1.5) { color: #4cc9f0, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
hd2 = text("2  Cold gas thrusters", 8.0, 1.5) { color: #7cff6b, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
hd3 = text("3  Computer coordination", 13.0, 1.5) { color: #ffd166, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
hd1 : draw() { startTime: tList, duration: 700 }
hd2 : draw() { startTime: tList + 400, duration: 700 }
hd3 : draw() { startTime: tList + 800, duration: 700 }

// underline that lights up with each phase
ul1 = line(1.4, 1.8, 3.2, 0) { color: #4cc9f0, lineWidth: 4 }
ul2 = line(6.4, 1.8, 3.2, 0) { color: #7cff6b, lineWidth: 4 }
ul3 = line(11.4, 1.8, 3.2, 0) { color: #ffd166, lineWidth: 4 }
ul1 : draw() { startTime: tP1, duration: 400 }
ul2 : draw() { startTime: tP2, duration: 400 }
ul3 : draw() { startTime: tP3, duration: 400 }

// side hints (not a car outline)
hintR = text("← rear", 1.1, 7.95) { color: #a8dadc, fontSize: 16, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
hintF = text("front →", 14.9, 7.95) { color: #a8dadc, fontSize: 16, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
hintR : fadeIn() { startTime: tP1, duration: 400 }
hintF : fadeIn() { startTime: tP1, duration: 400 }

// =====================================================
// TERM 1: suction using fans (rear cluster + vent under the car + duct)
// =====================================================
fanX = [2.3, 3.1, 2.3, 3.1]
fanY = [3.7, 3.7, 4.5, 4.5]
for j in range(0, 4) {
  fh = circle(fanX[j], fanY[j], 0.32) { fillColor: #0b1224, color: #4cc9f0, lineWidth: 2.5 }
  fb = group [
    line(fanX[j], fanY[j], 0, -0.26) { color: #ffd166, lineWidth: 3 },
    line(fanX[j], fanY[j], 0.225, 0.13) { color: #cfd8dc, lineWidth: 3 },
    line(fanX[j], fanY[j], -0.225, 0.13) { color: #cfd8dc, lineWidth: 3 },
    circle(fanX[j], fanY[j], 0.05) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 }
  ]
  fh : fadeIn() { startTime: tP1 + 300 + 150 * j, duration: 400 }
  fb : fadeIn() { startTime: tP1 + 400 + 150 * j, duration: 400 }
  fb : rotate(24 * PI) { pivot: (fanX[j], fanY[j]), startTime: tP1 + 1200, duration: tEnd - tP1 - 1200, easing: "ease-in-quad" }
}
fanTag = text("4 fans", 2.7, 3.0) { color: #4cc9f0, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
fanSub = text("rear of the car", 3.1, 5.25) { color: #a8dadc, fontSize: 18, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
fanTag : draw() { startTime: tP1 + 300, duration: 600 }
fanSub : draw() { startTime: tP1 + 900, duration: 700 }

vent = rectangle(4.6, 6.6, 1.2, 0.15) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 }
ventTag = text("vent (underbody)", 5.2, 7.1) { color: #4cc9f0, fontSize: 18, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
duct = path(false, 4.6, 6.65, 3.9, 6.45, 3.5, 5.6, 3.2, 4.9) { color: #4cc9f0, lineWidth: 3 }
vent : fadeIn() { startTime: tP1 + 900, duration: 400 }
ventTag : draw() { startTime: tP1 + 1000, duration: 700 }
duct : draw() { startTime: tP1 + 1200, duration: 700 }

guide = path(false, 4.6, 6.65, 3.9, 6.45, 3.5, 5.6, 3.2, 4.9) { color: #4cc9f0, lineWidth: 1 }
for i in range(0, 7) {
  ad = circle(4.6, 6.65, 0.07) { fillColor: #e8fbff, color: #e8fbff, lineWidth: 1, opacity: 0 }
  ad : show() { startTime: tP1 + 1800 + 420 * i }
  ad : morph[opacity: 0.9] { startTime: tP1 + 1800 + 420 * i, duration: 1 }
  ad : follow(guide) { orient: false, startTime: tP1 + 1800 + 420 * i, duration: 800, easing: "linear" }
  ad : hide()
}

cap1 = text("the fans pull air out from under the car", 8, 8.4) { color: #4cc9f0, fontSize: 26, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
cap1 : draw() { startTime: tP1 + 600, duration: 1500 }
cap1 : undraw() { startTime: tP2 - 300, duration: 300 }

// =====================================================
// TERM 2: cold gas thrusters (4 rear, 4 down, 2 side) + 600 L tank + compressor
// =====================================================
rearY = [3.6, 4.0, 4.4, 4.8]
for r in range(0, 4) {
  rn = path(true, 1.85, rearY[r] - 0.09, 1.85, rearY[r] + 0.09, 1.4, rearY[r]) { fillColor: #cfd8dc, color: #7cff6b, lineWidth: 1.5 }
  rn : fadeIn() { startTime: tP2 + 200 + 120 * r, duration: 300 }
}
rearTag = text("4 rear", 1.25, 5.3) { color: #7cff6b, fontSize: 20, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
rearTag : draw() { startTime: tP2 + 500, duration: 600 }

downX = [6.3, 6.85, 10.4, 10.95]
for d in range(0, 4) {
  db = path(true, downX[d] - 0.12, 6.8, downX[d] + 0.12, 6.8, downX[d] + 0.17, 7.1, downX[d] - 0.17, 7.1) { fillColor: #cfd8dc, color: #7cff6b, lineWidth: 1.5 }
  db : fadeIn() { startTime: tP2 + 700 + 120 * d, duration: 300 }
}
downTag1 = text("2 down", 6.6, 7.5) { color: #7cff6b, fontSize: 18, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
downTag2 = text("2 down", 10.7, 7.5) { color: #7cff6b, fontSize: 18, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
downTag1 : draw() { startTime: tP2 + 1000, duration: 500 }
downTag2 : draw() { startTime: tP2 + 1000, duration: 500 }

sideX = [6.0, 10.0]
for sx in range(0, 2) {
  sr = circle(sideX[sx], 4.4, 0.22) { fillColor: #0b1224, color: #7cff6b, lineWidth: 2.5 }
  sd = circle(sideX[sx], 4.4, 0.06) { fillColor: #7cff6b, color: #7cff6b, lineWidth: 1 }
  stg = text("side", sideX[sx], 4.85) { color: #7cff6b, fontSize: 18, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
  sr : fadeIn() { startTime: tP2 + 1100 + 200 * sx, duration: 300 }
  sd : fadeIn() { startTime: tP2 + 1100 + 200 * sx, duration: 300 }
  stg : draw() { startTime: tP2 + 1300 + 200 * sx, duration: 500 }
}

tank = rectangle(7.2, 5.4, 2.2, 0.7) { fillColor: rgba(76,201,240,0.3), color: #4cc9f0, lineWidth: 2.5 }
tankTxt = text("600 L tank", 8.3, 5.75) { color: #4cc9f0, fontSize: 20, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
tankSub = text("belly (underbody)", 8.3, 6.4) { color: #a8dadc, fontSize: 18, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
tank : fadeIn() { startTime: tP2 + 1600, duration: 400 }
tankTxt : draw() { startTime: tP2 + 1800, duration: 600 }
tankSub : draw() { startTime: tP2 + 2200, duration: 600 }

comp = circle(10.9, 5.75, 0.38) { fillColor: #2b3a55, color: #7cff6b, lineWidth: 2.5 }
crank = group [
  line(10.9, 5.75, 0.28, 0) { color: #7cff6b, lineWidth: 4 },
  circle(11.18, 5.75, 0.06) { fillColor: #7cff6b, color: #7cff6b, lineWidth: 1 }
]
cpipe = line(9.4, 5.75, 1.12, 0) { color: #4cc9f0, lineWidth: 3 }
compTag = text("compressor", 10.9, 6.3) { color: #7cff6b, fontSize: 18, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
comp : fadeIn() { startTime: tP2 + 2000, duration: 400 }
crank : fadeIn() { startTime: tP2 + 2000, duration: 400 }
cpipe : draw() { startTime: tP2 + 2200, duration: 400 }
compTag : draw() { startTime: tP2 + 2400, duration: 600 }
crank : rotate(16 * PI) { pivot: (10.9, 5.75), startTime: tP2 + 2400, duration: tEnd - tP2 - 2400, easing: "ease-in-quad" }

cap2 = text("cold gas thrusters: 4 rear, 4 down, 2 sideways, fed by the tank and compressor", 8, 8.4) { color: #7cff6b, fontSize: 24, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
cap2 : draw() { startTime: tP2 + 800, duration: 1000 }
cap2 : undraw() { startTime: tP2 + 2500, duration: 600 }

// =====================================================
// TERM 3: computer coordination
// =====================================================
cpu = rectangle(7.0, 2.6, 2.0, 0.9) { fillColor: #0b1224, color: #ffd166, lineWidth: 3 }
cpuTxt = text("Controller", 8.0, 3.05) { color: #ffd166, fontSize: 20, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
cpuSub = text("cabin (center)", 8.0, 2.3) { color: #a8dadc, fontSize: 18, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
cpu : fadeIn() { startTime: tP3 + 200, duration: 400 }
cpuTxt : draw() { startTime: tP3 + 400, duration: 700 }
cpuSub : draw() { startTime: tP3 + 800, duration: 600 }

imu = circle(8.0, 4.4, 0.26) { fillColor: #0b1224, color: #ffd166, lineWidth: 2.5 }
imuX = line(7.82, 4.4, 0.36, 0) { color: #ffd166, lineWidth: 2 }
imuY = line(8.0, 4.22, 0, 0.36) { color: #ffd166, lineWidth: 2 }
imuTag = text("IMU", 8.0, 4.8) { color: #ffd166, fontSize: 16, fontFamily: "Courier New", fontWeight: "bold", textAlign: "center" }
imu : fadeIn() { startTime: tP3 + 700, duration: 400 }
imuX : fadeIn() { startTime: tP3 + 700, duration: 400 }
imuY : fadeIn() { startTime: tP3 + 700, duration: 400 }
imuTag : draw() { startTime: tP3 + 900, duration: 500 }

ps1 = circle(5.1, 6.25, 0.12) { fillColor: #ffd166, color: #ffd166, lineWidth: 1 }
ps2 = circle(9.6, 5.1, 0.12) { fillColor: #ffd166, color: #ffd166, lineWidth: 1 }
psTag = text("pressure sensors", 5.1, 5.85) { color: #ffd166, fontSize: 16, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
ps1 : fadeIn() { startTime: tP3 + 1000, duration: 300 }
ps2 : fadeIn() { startTime: tP3 + 1000, duration: 300 }
psTag : draw() { startTime: tP3 + 1100, duration: 600 }

// control lines from the computer to everything it coordinates
ctlX = [7.0, 7.0, 7.2, 8.8, 8.4, 7.2, 9.0, 5.1, 8.0]
ctlY = [3.0, 2.8, 3.5, 3.5, 3.5, 3.5, 3.2, 6.15, 3.5]
ctlDx = [-3.55, -5.5, -1.0, 1.0, 0.0, -0.65, 1.65, 1.9, 0.0]
ctlDy = [0.95, 0.6, 0.8, 0.8, 1.9, 3.25, 3.55, -2.7, 0.62]
for q in range(0, 9) {
  cl = line(ctlX[q], ctlY[q], ctlDx[q], ctlDy[q]) { color: rgba(255,209,102,0.6), lineWidth: 1.5 }
  cl : draw() { startTime: tP3 + 1000 + 120 * q, duration: 400 }
}

cap3 = text("the computer reads the sensors and coordinates the fans and thrusters", 8, 8.4) { color: #ffd166, fontSize: 24, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
cap3 : draw() { startTime: tP3 + 500, duration: 500 }
cap3 : undraw() { startTime: tP3 + 1300, duration: 800 }

// ---------- closing caption (last effect ends at 12000) ----------
capEnd = text("Fans, thrusters and the computer work as one system", 8, 8.4) { color: #ffd166, fontSize: 28, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
capEnd : draw() { startTime: tEndCap, duration: 800 }

pt = point(0.1,0.1): show() {duration: 500}
