canvas { BGColor: #05070f }

// ---- phase timeline (ms): edit these to retime a phase ----
tLegend = 4000
tFans = 4600
tChamber = 5000
tFlow = 5400
flowGap = 400
tJets = 6000
tDeplete = 6800
tLow = 8000
tTop = 8600
tAtm = 9000
tArrows = 9400
tSum = 9800
tPush = 10700
tDim = 11300
tDown = 11500
tWall = 12000
endT = 15000

// ---- title ----
title = text("Roadster: fan downforce", 4.6, 0.6) { color: #7fd8ff, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
title : show() { startTime: 0 }
title : morph[opacity: 1] { startTime: 0, duration: 700 }

// ---- ground ----
groundFill = rectangle(0, 7.35, 16, 1.65) { fillColor: #0b1018 }
groundFill : show() { startTime: 0 }
groundLine = line((0.3, 7.35), (15.7, 7.35)) { color: #4cc9f0, lineWidth: 0.8 }
groundLine : draw() { startTime: 200, duration: 800 }

// ---- low-pressure chamber under the car (behind the wheels) ----
chamber = rectangle(5.3, 6.52, 4.3, 0.83) { fillColor: rgba(76,201,240,0.14), opacity: 0 }
chamber : show() { startTime: tChamber }
chamber : morph[opacity: 1] { startTime: tChamber, duration: 500 }

// ---- car frame (wireframe only) ----
bodyOutline = path(true, 2.368, 5.270, 6.008, 4.607, 9.947, 5.335, 11.130, 5.205, 13.119, 5.946, 13.119, 6.518, 2.550, 6.466, 1.900, 6.102, 1.978, 5.387) { color: #e0e6ee, lineWidth: 0.8 }
bodyOutline : draw() { startTime: 500, duration: 800 }

cabin = path(true, 3.850, 5.205, 5.930, 4.815, 8.660, 5.309, 8.660, 5.660, 3.850, 5.660) { color: rgba(224,230,238,0.6), lineWidth: 0.5 }
cabin : draw() { startTime: 1200, duration: 800 }

wheelRear = circle(4.11, 6.55, 0.8) { color: rgba(255,255,255,0.4), lineWidth: 0.6 }
wheelFront = circle(10.74, 6.55, 0.8) { color: rgba(255,255,255,0.4), lineWidth: 0.6 }
wheelRearIn = circle(4.11, 6.55, 0.45) { color: rgba(255,255,255,0.3), lineWidth: 0.5 }
wheelFrontIn = circle(10.74, 6.55, 0.45) { color: rgba(255,255,255,0.3), lineWidth: 0.5 }
wheelRear : draw() { startTime: 1400, duration: 300 }
wheelFront : draw() { startTime: 1500, duration: 300 }
wheelRearIn : draw() { startTime: 1800, duration: 300 }
wheelFrontIn : draw() { startTime: 2000, duration: 300 }

// ---- internal mechanism: duct, vent, fan bay, skirts ----
ductTop = path(false, 2.85, 5.7, 7.6, 5.7, 7.6, 6.52) { color: #4cc9f0, lineWidth: 0.8 }
ductBottom = path(false, 2.85, 6.3, 7.1, 6.3, 7.1, 6.52) { color: #4cc9f0, lineWidth: 0.8 }
ductTop : draw() { startTime: 2300, duration: 800 }
ductBottom : draw() { startTime: 2500, duration: 800 }

ventGap = line((7.1, 6.49), (7.6, 6.49)) { color: #05070f, lineWidth: 1.2 }
ventGap : show() { startTime: 3000 }

fanHousing = rectangle(2.2, 5.5, 0.65, 1.0) { color: #ffd166, lineWidth: 0.8 }
fanHousing : draw() { startTime: 3600, duration: 800 }
fanDisc = line((2.52, 5.58), (2.52, 6.42)) { color: #ffd166, lineWidth: 1.0 }
fanDisc : draw() { startTime: 4200, duration: 500 }
fanHub = circle(2.52, 6.0, 0.1) { fillColor: #ffd166 }
fanHub : show() { startTime: 3200 }

rearSkirt = line((5.3, 6.49), (5.3, 7.2)) { color: #ffd166, lineWidth: 0.8 }
frontSkirt = line((9.6, 6.52), (9.6, 7.2)) { color: #ffd166, lineWidth: 0.8 }
rearSkirt : draw() { startTime: 3500, duration: 500 }
frontSkirt : draw() { startTime: 3700, duration: 500 }

// ---- legend under the ground ----
legendX = [2.5, 7.35, 9.9]
legendTxt = ["4 FANS", "VENT", "INTAKE GAP"]
legendCol = [#ffd166, #4cc9f0, #ffd166]
for (lt, i) in legendTxt {
  lx = legendX[i]
  lgTick = line((lx, 7.42), (lx, 7.72)) { color: legendCol[i], lineWidth: 0.5 }
  lgTick : draw() { startTime: tLegend + i * 200, duration: 300 }
  lgLab = text(lt, lx, 7.98) { color: legendCol[i], fontSize: 14, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
  lgLab : show() { startTime: tLegend + 200 + i * 200 }
  lgLab : morph[opacity: 1] { startTime: tLegend + 200 + i * 200, duration: 300 }
}

// ---- air in the chamber: starts dense, the fans pull most of it out ----
for i in range(0, 14) {
  cdx = 5.5 + ((i * 29) % 39) / 10
  cdy = 6.65 + ((i * 17) % 12) / 20
  chDot = circle(cdx, cdy, 0.05) { fillColor: #a8dadc, opacity: 0 }
  chDot : show() { startTime: tChamber + i * 40 }
  chDot : morph[opacity: 0.8] { startTime: tChamber + i * 40, duration: 300 }
  if (i >= 3) {
    chDot : morph[opacity: 0] { startTime: tDeplete + (i - 3) * 150, duration: 400 }
  }
}

// ---- airflow: under the front skirt, up the vent, along the duct, through the fan, out the back ----
for k in range(0, 12) {
  st = tFlow + k * flowGap
  flow = circle(9.9, 7.28, 0.07) { fillColor: #7fd8ff, opacity: 0 }
  flow : show() { startTime: st }
  flow : morph[opacity: clamp(8 * clamp((T - S) / D, 0, 1), 0, 1) * clamp(8 * (1 - clamp((T - S) / D, 0, 1)), 0, 1)] { startTime: st, duration: 3000 }
  flow : serial [
    move(-2.55, 0) { duration: 1000, easing: "linear" },
    move(0, -1.28) { duration: 600, easing: "ease-in-quad" },
    move(-8.5, 0) { duration: 1000, easing: "ease-in-sine" },
    move(-1.95, 0) { duration: 400, easing: "linear" }
  ] { startTime: st }
}


// ---- exhaust jets at the back ----
for (jy, i) in [5.75, 6.0, 6.25] {
  jet = path(false, 1.85, jy, 0.55, jy, 0.8, jy - 0.18, 0.55, jy, 0.8, jy + 0.18) { color: #7fd8ff, lineWidth: 0.6 }
  jet : draw() { startTime: tJets + i * 150, duration: 600 }
}

// ---- rear-view inset: the four fans spinning up ----
insetBox = rectangle(11.7, 0.5, 3.8, 1.6) { color: #4cc9f0, lineWidth: 0.6 }
insetBox : show() { startTime: tFans }
insetCap = text("REAR VIEW", 13.6, 2.4) { color: #a8dadc, fontSize: 12, fontFamily: "Georgia", textAlign: "center", opacity: 0 }
insetCap : show() { startTime: tFans + 100 }
insetCap : morph[opacity: 1] { startTime: tFans + 100, duration: 400 }

for f in range(0, 4) {
  fx = 12.2 + f * 0.9
  fy = 1.3
  fanRing = circle(fx, fy, 0.38) { color: #ffd166, lineWidth: 0.6 }
  fanRing : show() { startTime: tFans }
  fanCore = circle(fx, fy, 0.09) { fillColor: #ffd166 }
  fanCore : show() { startTime: tFans }
  for b in range(0, 6) {
    ba = b * TAU / 6
    blade = line((fx + 0.1 * cos(ba), fy + 0.1 * sin(ba)), (fx + 0.34 * cos(ba), fy + 0.34 * sin(ba))) { color: #7fd8ff, lineWidth: 0.6 }
    blade : show() { startTime: tFans }
    blade : rotate(8 * PI) { pivot: (fx, fy), startTime: tFans + 200, duration: 2000, easing: "ease-in-sine" }
    blade : rotate(53 * PI) { pivot: (fx, fy), startTime: tFans + 2200, duration: endT - tFans - 2200, easing: "linear" }
  }
}

// ---- low pressure label ----
lowTxt = text("LOW PRESSURE UNDER THE CAR", 7.4, 8.5) { color: #4cc9f0, fontSize: 15, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
lowTxt : show() { startTime: tLow }
lowTxt : morph[opacity: 1] { startTime: tLow, duration: 500 }

// ---- atmospheric pressure from above ----
for i in range(0, 40) {
  tdx = 3.6 + ((i * 37) % 89) / 10
  tdy = 2.1 + ((i * 53) % 21) / 10
  topDot = circle(tdx, tdy, 0.05) { fillColor: #ff9d2f, opacity: 0 }
  topDot : show() { startTime: tTop + i * 25 }
  topDot : morph[opacity: 0.7] { startTime: tTop + i * 25, duration: 300 }
  topDot : morph[opacity: 0.25] { startTime: tDim, duration: 400 }
}

atmTxt = text("ATMOSPHERIC PRESSURE", 7.6, 1.55) { color: #ff9d2f, fontSize: 14, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
atmTxt : show() { startTime: tAtm }
atmTxt : morph[opacity: 1] { startTime: tAtm, duration: 500 }

tips = [4.926, 4.734, 4.543, 4.624, 4.818, 5.012, 5.206, 5.105, 5.409]
for (ty, i) in tips {
  ax = 3.6 + i * 1.05
  pushArrow = path(false, ax, 2.7, ax, ty, ax - 0.2, ty - 0.3, ax, ty, ax + 0.2, ty - 0.3) { color: #ff9d2f, lineWidth: 0.8 }
  pushArrow : draw() { startTime: tArrows + i * 90, duration: 500 }
  pushArrow : serial [
    move(0, 0.25) { duration: 300, easing: "ease-in-out-sine" },
    move(0, -0.25) { duration: 300, easing: "ease-in-out-sine" },
    move(0, 0.25) { duration: 300, easing: "ease-in-out-sine" },
    move(0, -0.25) { duration: 300, easing: "ease-in-out-sine" },
    move(0, 0.25) { duration: 300, easing: "ease-in-out-sine" }
  ]
  pushArrow : morph[opacity: 0.25] { startTime: tDim, duration: 400 }
}

// ---- one-line summary ----
sumTxt = text("Fans pump air out, so the air above pushes the car down", 8, 8.85) { color: #e0e6ee, fontSize: 13, fontFamily: "Georgia", textAlign: "center", opacity: 0 }
sumTxt : show() { startTime: tSum }
sumTxt : morph[opacity: 1] { startTime: tSum, duration: 600 }

// ---- the result: downforce ----
dfArrow = path(false, 9.2, 2.6, 9.2, 4.95, 8.9, 4.55, 9.2, 4.95, 9.5, 4.55) { color: #ffd166, lineWidth: 1.8, opacity: 0 }
dfArrow : show() { startTime: tDown }
dfArrow : morph[opacity: 1] { startTime: tDown, duration: 500 }
dfArrow : morph[opacity: 0.7 + 0.3 * sin(clamp((T - S) / D, 0, 1) * TAU * 2)] { startTime: tDown + 500, duration: endT - tDown - 500 }
dfTxt = text("DOWNFORCE", 10.8, 3.4) { color: #ffd166, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
dfTxt : show() { startTime: tDown + 200 }
dfTxt : morph[opacity: 1] { startTime: tDown + 200, duration: 500 }

// ---- wall inset: the same force presses the car onto a vertical wall ----
wallLine = line((0.7, 1.3), (0.7, 3.5)) { color: #ffffff, lineWidth: 1.2 }
wallLine : draw() { startTime: tWall, duration: 600 }
wallCar = path(true, 0.972, 3.070, 1.059, 2.594, 0.964, 2.079, 0.980, 1.924, 0.884, 1.664, 0.809, 1.664, 0.816, 3.046, 0.863, 3.131, 0.957, 3.121) { color: #e0e6ee, lineWidth: 0.6 }
wallCar : draw() { startTime: tWall + 200, duration: 600 }
wallWheelA = circle(0.827, 2.842, 0.128) { color: rgba(255,255,255,0.5), lineWidth: 0.5 }
wallWheelB = circle(0.827, 1.975, 0.128) { color: rgba(255,255,255,0.5), lineWidth: 0.5 }
wallWheelA : draw() { startTime: tWall + 500, duration: 400 }
wallWheelB : draw() { startTime: tWall + 500, duration: 400 }
for (wy, i) in [1.8, 2.2, 2.6, 3.0] {
  wallArrow = path(false, 2.2, wy, 1.35, wy, 1.55, wy - 0.14, 1.35, wy, 1.55, wy + 0.14) { color: #ff9d2f, lineWidth: 0.6 }
  wallArrow : draw() { startTime: tWall + 800 + i * 120, duration: 400 }
}
wallTxt = text("grips vertical walls", 1.9, 3.85) { color: #a8dadc, fontSize: 13, fontFamily: "Georgia", textAlign: "center", opacity: 0 }
wallTxt : show() { startTime: tWall + 1300 }
wallTxt : morph[opacity: 1] { startTime: tWall + 1300, duration: 500 }
