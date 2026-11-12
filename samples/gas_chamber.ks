canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tA = 0
tCar = 600
tLbl = 1400
tRel = 2800
thrustMs = 4000
tEnd = tRel + thrustMs
tNew = 5000

// ---------- title ----------
title = text("Gas out, car pushed the other way", 8, 0.8) { color: #ffd166, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title : draw() { startTime: tA, duration: 900 }
title : hide() { startTime: tNew - 200 }

// ---------- ground ----------
ground = line(0.3, 7.0, 15.4, 0) { color: #a8dadc, lineWidth: 2 }
ground : show() { startTime: tA + 200 }

// ---------- car (side view, scale 0.55, rear at x = 1.6, ground y = 7.0) ----------
car = group [
  path(true, 1.798, 6.12, 3.338, 5.84, 5.005, 6.147, 5.505, 6.093, 6.347, 6.406, 6.347, 6.648, 1.875, 6.626, 1.6, 6.472, 1.633, 6.17) { fillColor: #e63946, color: #ffffff, lineWidth: 2 },
  path(true, 2.425, 6.093, 3.305, 5.928, 4.46, 6.136, 4.46, 6.285, 2.425, 6.285) { fillColor: #a8dadc, color: #ffffff, lineWidth: 1 },
  rectangle(2.26, 6.285, 1.43, 0.275) { fillColor: #3a0f18, color: #4cc9f0, lineWidth: 1.5 },
  path(false, 2.26, 6.312, 1.875, 6.389, 1.628, 6.389) { color: #cfd8dc, lineWidth: 2 },
  path(false, 2.26, 6.532, 1.875, 6.489, 1.628, 6.489) { color: #cfd8dc, lineWidth: 2 },
  circle(2.343, 6.351, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(2.54, 6.351, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(2.739, 6.351, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(2.937, 6.351, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(3.135, 6.351, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(3.333, 6.351, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(3.531, 6.351, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(2.386, 6.434, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(2.585, 6.434, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(2.783, 6.434, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(2.981, 6.434, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(3.179, 6.434, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(3.377, 6.434, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(3.575, 6.434, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(2.343, 6.516, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(2.54, 6.516, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(2.739, 6.516, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(2.937, 6.516, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(3.135, 6.516, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(3.333, 6.516, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(3.531, 6.516, 0.035) { fillColor: #4cc9f0, color: #4cc9f0, lineWidth: 1 },
  circle(2.535, 6.588, 0.413) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(2.535, 6.588, 0.2) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 },
  circle(5.34, 6.588, 0.413) { fillColor: #14213d, color: #ffffff, lineWidth: 2 },
  circle(5.34, 6.588, 0.2) { fillColor: #cfd8dc, color: #cfd8dc, lineWidth: 1 }
]
car : show() { startTime: tCar }

// ---------- plug that keeps the nozzle shut until release ----------
plug = rectangle(1.57, 6.385, 0.07, 0.11) { fillColor: #ffd166, color: #ffd166, lineWidth: 1 }
plug : show() { startTime: tCar }
plug : hide() { startTime: tRel }

// ---------- labels before release ----------
lblP = text("high-pressure gas inside", 4.4, 5.0) { color: #4cc9f0, fontSize: 24, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
lblPLine = line(3.4, 5.25, -0.5, 0.95) { color: #4cc9f0, lineWidth: 1.5 }
lblP : draw() { startTime: tLbl, duration: 900 }
lblPLine : draw() { startTime: tLbl + 400, duration: 500 }
lblP : hide() { startTime: tRel }
lblPLine : hide() { startTime: tRel }

lblN = text("nozzle", 0.95, 5.55) { color: #cfd8dc, fontSize: 20, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
lblNLine = line(1.15, 5.8, 0.4, 0.55) { color: #cfd8dc, lineWidth: 1.5 }
lblN : draw() { startTime: tLbl + 900, duration: 500 }
lblNLine : draw() { startTime: tLbl + 900, duration: 400 }
lblN : hide() { startTime: tRel }
lblNLine : hide() { startTime: tRel }

// ---------- arrows (they follow the car) ----------
gasArrow = path(false, 1.4, 6.44, 0.5, 6.44, 0.8, 6.26, 0.5, 6.44, 0.8, 6.62) { color: #4cc9f0, lineWidth: 5 }
forceArrow = path(false, 2.6, 5.45, 4.3, 5.45, 4.0, 5.27, 4.3, 5.45, 4.0, 5.63) { color: #ffd166, lineWidth: 5 }
gasArrow : show() { startTime: tRel }
forceArrow : show() { startTime: tRel }
gasArrow : hide() { startTime: tEnd }
forceArrow : hide() { startTime: tEnd }

// ---------- the push: car accelerates for 4 s ----------
car : move(5, 0) { startTime: tRel, duration: thrustMs, easing: "ease-in-quad" }
gasArrow : move(5, 0) { startTime: tRel, duration: thrustMs, easing: "ease-in-quad" }
forceArrow : move(5, 0) { startTime: tRel, duration: thrustMs, easing: "ease-in-quad" }

// ---------- gas puffs: start at the nozzle (world position), shoot backward, fade ----------
for i in range(0, 40) {
  pp = 100 * i / thrustMs
  pfX = 1.55 + 5 * pp * pp
  pfY = 6.44 + 0.12 * sin(i * 1.7)
  pf = circle(pfX, pfY, 0.09 + 0.03 * (i % 3)) { fillColor: #a8dadc, color: #a8dadc, lineWidth: 1, opacity: 0 }
  pf : show() { startTime: tRel + 100 * i }
  pf : move(-2.2, 0) { startTime: tRel + 100 * i, duration: 600, easing: "ease-out-quad" }
  pf : morph[opacity: 0.85 * (1 - clamp((T - S) / D, 0, 1))] { startTime: tRel + 100 * i, duration: 600, easing: "linear" }
  pf : hide()
}

// ---------- labels during the push ----------
lblGas = text("high-pressure gas → fast gas out", 3.6, 8.2) { color: #4cc9f0, fontSize: 22, fontFamily: "Georgia", textAlign: "center" }
lblGas : draw() { startTime: tRel + 200, duration: 900 }
lblCar = text("car pushed forward", 12.2, 8.2) { color: #ffd166, fontSize: 22, fontFamily: "Georgia", textAlign: "center" }
lblCar : draw() { startTime: tRel + 1200, duration: 800 }

// ---------- Newton's third law ----------
newtonTitle = text("Newton's Third Law", 8, 0.9) { color: #ffd166, fontSize: 40, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
newtonTitle : draw() { startTime: tNew, duration: 800 }
actionTxt = text("Action: the car pushes the gas backward", 8, 1.8) { color: #4cc9f0, fontSize: 28, fontFamily: "Georgia", textAlign: "center" }
reactTxt = text("Reaction: the gas pushes the car forward", 8, 2.5) { color: #ffd166, fontSize: 28, fontFamily: "Georgia", textAlign: "center" }
actionTxt : draw() { startTime: tNew + 700, duration: 900 }
reactTxt : draw() { startTime: tNew + 1700, duration: 900 }
eqTxt = text("equal in size, opposite in direction", 8, 3.3) { color: #a8dadc, fontSize: 26, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
eqTxt : draw() { startTime: 7000, duration: 1000 }
