canvas { BGColor: #05070f }

// ---- timeline (ms), matched to the narration ----
tMass = 3000
tForce = 6500
tPress = 9500
tAtm = 12500
tRow5 = 15500
tDrop5 = 16300
tRow6 = 20500
tDrop10 = 21400
tDouble = 22200

// ---- title and disclaimer ----
title = text("How much suction does the car need?", 8, 0.5) { color: #7fd8ff, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
title : show() { startTime: 0 }
title : morph[opacity: 1] { duration: 600 }

note = text("Estimated values - Tesla has not published official numbers", 8, 8.7) { color: #a8dadc, fontSize: 13, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center", opacity: 0 }
note : show() { startTime: 600 }
note : morph[opacity: 1] { duration: 500 }

// ---- ceiling ----
ceiling = rectangle(0.3, 1.1, 8.4, 0.6) { fillColor: #1a2233, color: #4cc9f0, lineWidth: 0.8 }
ceiling : show() { startTime: 0 }
for hi in range(0, 12) {
  hx = 0.6 + hi * 0.7
  hatch = line((hx, 1.1), (hx - 0.3, 0.8)) { color: rgba(255,255,255,0.25), lineWidth: 0.5 }
  hatch : draw() { startTime: 100 + hi * 40, duration: 200 }
}

// ---- underbody chamber (between the car floor and the ceiling) ----
chamber = rectangle(3.0, 1.7, 2.9, 0.57) { fillColor: rgba(255,157,47,0.3) }
chamber : show() { startTime: 2400 }
chamberLow = rectangle(3.0, 1.7, 2.9, 0.57) { fillColor: rgba(76,201,240,0.85), opacity: 0 }
chamberLow : show() { startTime: 2400 }
chamberHl = rectangle(2.95, 1.65, 3.0, 0.67) { color: #ffd166, lineWidth: 0.8, opacity: 0 }
chamberHl : show() { startTime: tMass }
chamberHl : serial [ morph[opacity: 1], morph[opacity: 0.15] ] { duration: 300, loop: 3 }
chamberHl : hide()

areaTxt = text("A = 4 m²", 4.45, 1.42) { color: #4cc9f0, fontSize: 16, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
areaTxt : show() { startTime: tMass + 300 }
areaTxt : morph[opacity: 1] { duration: 400 }

// ---- the car, upside down: it slides in along the ceiling ----
car = group [
  path(true, 1.017, 3.108, 3.481, 3.557, 6.147, 3.064, 6.948, 3.152, 8.294, 2.650, 8.294, 2.263, 1.140, 2.298, 0.700, 2.545, 0.753, 3.029) { fillColor: #e63946, color: #ffffff, lineWidth: 0.5 },
  path(true, 2.020, 3.152, 3.428, 3.416, 5.276, 3.082, 5.276, 2.844, 2.020, 2.844) { fillColor: #a8dadc, color: #1d3557, lineWidth: 0.5 },
  circle(2.196, 2.36, 0.66) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(6.684, 2.36, 0.66) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(2.196, 2.36, 0.24) { fillColor: #cfd8dc },
  circle(6.684, 2.36, 0.24) { fillColor: #cfd8dc }
]
car : move(-9, 0) { startTime: 0, duration: 1 }
car : show() { startTime: 700 }
car : move(9, 0) { duration: 1600, easing: "ease-out-cubic" }

massTag = text("2,000 kg", 4.45, 2.58) { color: #ffffff, fontSize: 16, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
massTag : show() { startTime: tMass + 200 }
massTag : morph[opacity: 1] { duration: 400 }

// ---- weight arrows (gravity pulls the car down) ----
weightArrow = path(false, 7.7, 2.95, 7.7, 4.55, 7.5, 4.25, 7.7, 4.55, 7.9, 4.25) { color: #ff5c7a, lineWidth: 1.2 }
weightArrow : draw() { startTime: tForce + 600, duration: 700 }
weightArrow2 = path(false, 8.3, 2.95, 8.3, 4.55, 8.1, 4.25, 8.3, 4.55, 8.5, 4.25) { color: #ff5c7a, lineWidth: 1.2 }
weightArrow2 : draw() { startTime: tDouble, duration: 600 }

weightTxt = text("W = 20,000 N", 8.0, 4.95) { color: #ff5c7a, fontSize: 13, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
weightTxt : show() { startTime: tForce + 900 }
weightTxt : morph[opacity: 1] { duration: 400 }
weightTxt : hide() { startTime: tDouble }
weightTxt2 = text("2W = 40,000 N", 8.0, 4.95) { color: #ff5c7a, fontSize: 13, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
weightTxt2 : show() { startTime: tDouble + 300 }
weightTxt2 : morph[opacity: 1] { duration: 400 }

// ---- the air pushes up from below ----
airX = [1.4, 2.6, 3.8, 5.0, 6.2]
airTip = [3.298, 3.516, 3.618, 3.396, 3.19]
for (ax, i) in airX {
  ty = airTip[i]
  airArrow = path(false, ax, 5.0, ax, ty, ax - 0.2, ty + 0.3, ax, ty, ax + 0.2, ty + 0.3) { color: #ff9d2f, lineWidth: 0.8 }
  airArrow : draw() { startTime: tAtm + 200 + i * 120, duration: 500 }
}
airTxt = text("air pushes up", 4.4, 5.45) { color: #ff9d2f, fontSize: 15, fontFamily: "Georgia", textAlign: "center", opacity: 0 }
airTxt : show() { startTime: tAtm + 800 }
airTxt : morph[opacity: 1] { duration: 400 }
airTxt : hide() { startTime: tDrop5 + 800 }

// ---- net force after the pressure drop ----
goldArrow = path(false, 4.4, 5.1, 4.4, 3.55, 4.15, 3.9, 4.4, 3.55, 4.65, 3.9) { color: #ffd166, lineWidth: 2.0 }
goldArrow : draw() { startTime: tDrop5 + 800, duration: 600 }
goldArrow : scale((1, 2)) { pivot: (4.4, 5.1), startTime: tDouble + 200, duration: 600, easing: "ease-out-cubic" }
eqTxt1 = text("F = W", 4.4, 5.45) { color: #ffd166, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
eqTxt1 : show() { startTime: tDrop5 + 900 }
eqTxt1 : morph[opacity: 1] { duration: 400 }
eqTxt1 : hide() { startTime: tDouble + 200 }
eqTxt2 = text("F = 2W", 4.4, 5.45) { color: #ffd166, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
eqTxt2 : show() { startTime: tDouble + 500 }
eqTxt2 : morph[opacity: 1] { duration: 400 }

// ---- pressure bar: 101 kPa, then -5 %, then -10 % ----
barA = rectangle(1.0, 6.45, 6.3, 0.6) { fillColor: rgba(76,201,240,0.6) }
barB = rectangle(7.3, 6.45, 0.35, 0.6) { fillColor: rgba(76,201,240,0.6) }
barC = rectangle(7.65, 6.45, 0.35, 0.6) { fillColor: rgba(76,201,240,0.6) }
redB = rectangle(7.3, 6.45, 0.35, 0.6) { fillColor: #ff9d2f, opacity: 0 }
redC = rectangle(7.65, 6.45, 0.35, 0.6) { fillColor: #ff5c7a, opacity: 0 }
barTrack = rectangle(1.0, 6.45, 7.0, 0.6) { color: #4cc9f0, lineWidth: 0.8 }

barHead = text("pressure under the car", 4.5, 6.15) { color: #4cc9f0, fontSize: 15, fontFamily: "Georgia", textAlign: "center", opacity: 0 }
barHead : show() { startTime: tAtm + 400 }
barHead : morph[opacity: 1] { duration: 400 }
barTrack : draw() { startTime: tAtm + 400, duration: 600 }
barA : show() { startTime: tAtm + 900 }
barB : show() { startTime: tAtm + 900 }
barC : show() { startTime: tAtm + 900 }

read101 = text("101 kPa", 4.5, 6.75) { color: #ffffff, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
read101 : show() { startTime: tAtm + 1000 }
read101 : morph[opacity: 1] { duration: 400 }
read101 : hide() { startTime: tDrop5 + 300 }
read96 = text("96 kPa", 4.5, 6.75) { color: #ffffff, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
read96 : show() { startTime: tDrop5 + 300 }
read96 : hide() { startTime: tDrop10 + 300 }
read91 = text("91 kPa", 4.5, 6.75) { color: #ffffff, fontSize: 22, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
read91 : show() { startTime: tDrop10 + 300 }

// first drop: 5 %
redC : show() { startTime: tDrop5 }
redC : morph[opacity: 1] { duration: 300 }
redC : hide()
barC : hide() { startTime: tDrop5 + 300 }
cut5 = text("-5 %", 7.85, 6.15) { color: #ff5c7a, fontSize: 15, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
cut5 : show() { startTime: tDrop5 + 300 }
cut5 : morph[opacity: 1] { duration: 300 }
chamberLow : morph[opacity: 0.6] { startTime: tDrop5, duration: 700 }

// second drop: 10 %
redB : show() { startTime: tDrop10 }
redB : morph[opacity: 1] { duration: 300 }
redB : hide()
barB : hide() { startTime: tDrop10 + 300 }
cut10 = text("-10 %", 6.95, 6.15) { color: #ff9d2f, fontSize: 15, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
cut10 : show() { startTime: tDrop10 + 300 }
cut10 : morph[opacity: 1] { duration: 300 }
chamberLow : morph[opacity: 0.95] { startTime: tDrop10, duration: 700 }

// ---- the step-by-step equations, line by line ----
rowTxt = ["m = 2,000 kg     A = 4 m²", "F = m × g = 2,000 × 10 = 20,000 N", "ΔP = F ÷ A = 20,000 ÷ 4 = 5,000 Pa", "P(air) ≈ 101,000 Pa", "5,000 ÷ 101,000 ≈ 5 %", "2W: 10,000 ÷ 101,000 ≈ 10 %"]
rowTime = [tMass, tForce, tPress, tAtm, tRow5, tRow6]
rowCol = [#a8dadc, #ffffff, #ffffff, #ff9d2f, #ffd166, #ffd166]
for (rt, i) in rowTxt {
  ry = 1.8 + i * 0.95
  bullet = circle(8.9, ry, 0.22) { color: rowCol[i], lineWidth: 0.6 }
  bullet : show() { startTime: rowTime[i] }
  num = text("${i + 1}", 8.9, ry) { color: rowCol[i], fontSize: 14, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
  num : show() { startTime: rowTime[i] }
  row = text(rt, 9.75, ry) { color: rowCol[i], fontSize: 18, fontFamily: "Georgia", textAlign: "left", opacity: 0 }
  row : show() { startTime: rowTime[i] }
  row : parallel [ morph[opacity: clamp((T - S) / D, 0, 1)], move(-0.4, 0) { easing: "ease-out-cubic" } ] { duration: 500 }
}

// ---- the takeaway, fading in over the last 1.5 s ----
final = text("Only 5-10 % lower pressure is enough", 12.3, 7.7) { color: #ffd166, fontSize: 20, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
final : show() { startTime: 23500 }
final : morph[opacity: 1] { duration: 1500 }
