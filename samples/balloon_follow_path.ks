canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tA = 0
tHold = 800
tR = 1000
tMid = 1800
tF = 1000
flightMs = 2900
tD = 3900
deflMs = 500
tZ = 4300

// ---------- title ----------
title = text("Let go of a balloon full of air", 8, 0.8) { color: #ffd166, fontSize: 36, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
title : draw() { startTime: tA, duration: 800 }

// ---------- floor ----------
floorLine = line(0.5, 7.65, 15, 0) { color: #a8dadc, lineWidth: 2 }
floorLine : show() { startTime: tA + 200 }

// ---------- flight guide (never shown) ----------
// x = 3 + 7.5u + 0.8 sin(7 pi u); y = 3.6 + 1.4 cos(4.5 pi u) - 1.6u + 5.3 u^6; u = 0..1
// starts at (3, 5), loops and swoops, drops to (10.5, 7.3)
guide = path(false, 3.0, 5.0, 3.41, 4.93, 3.79, 4.79, 4.09, 4.58, 4.3, 4.32, 4.4, 4.0, 4.4, 3.66, 4.31, 3.3, 4.17, 2.95, 4.0, 2.63, 3.85, 2.34, 3.75, 2.11, 3.74, 1.95, 3.83, 1.86, 4.02, 1.84, 4.31, 1.91, 4.67, 2.04, 5.08, 2.24, 5.5, 2.49, 5.88, 2.77, 6.19, 3.07, 6.42, 3.38, 6.53, 3.66, 6.55, 3.91, 6.47, 4.11, 6.33, 4.25, 6.17, 4.32, 6.01, 4.32, 5.91, 4.24, 5.88, 4.09, 5.95, 3.87, 6.13, 3.61, 6.41, 3.3, 6.76, 2.98, 7.17, 2.65, 7.58, 2.34, 7.97, 2.06, 8.3, 1.84, 8.53, 1.68, 8.67, 1.6, 8.69, 1.6, 8.63, 1.68, 8.5, 1.86, 8.33, 2.11, 8.17, 2.43, 8.06, 2.81, 8.02, 3.23, 8.08, 3.68, 8.24, 4.14, 8.5, 4.6, 8.85, 5.03, 9.25, 5.43, 9.67, 5.79, 10.06, 6.1, 10.4, 6.36, 10.65, 6.57, 10.8, 6.74, 10.84, 6.89, 10.79, 7.01, 10.66, 7.15, 10.5, 7.3) { color: #ffd166, lineWidth: 1 }

// ---------- deflated target shape (never shown) ----------
deflated = path(true, 9.2, 7.38, 9.7, 7.2, 10.1, 7.3, 10.5, 7.12, 10.9, 7.3, 11.4, 7.2, 11.7, 7.45, 11.2, 7.55, 10.5, 7.58, 9.8, 7.58) { fillColor: #e63946, color: #ffffff, lineWidth: 2 }

// ---------- balloon: wider than tall, nozzle at the back (left) ----------
body = earc(3, 5, 1.15, 0.95) { fillColor: #e63946, color: #ffffff, lineWidth: 2 }
knot = path(true, 1.9, 4.85, 1.9, 5.15, 1.45, 5.0) { fillColor: #e63946, color: #ffffff, lineWidth: 1.5 }
body : show() { startTime: tA + 200 }
knot : show() { startTime: tA + 200 }
knot : hide() { startTime: tR }

// ---------- labels before release ----------
holdTag = text("full of air: high pressure inside", 3, 7.0) { color: #a8dadc, fontSize: 22, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
holdTag : draw() { startTime: tHold, duration: 600 }
holdTag : hide() { startTime: tR }

goTag = text("Let go!", 3, 2.6) { color: #ff9d2f, fontSize: 40, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
goTag : show() { startTime: tR - 200 }
goTag : hide() { startTime: tR + 700 }

// ---------- flight along the guide, shrinking and wobbling ----------
body : follow(guide) { startTime: tF, duration: flightMs, easing: "linear" }
body : morph[radiusX: lerp(1.15, 0.8, clamp((T - S) / D, 0, 1)) * (1 - 0.06 * sin(clamp((T - S) / D, 0, 1) * 50))] { startTime: tF, duration: flightMs, easing: "linear" }
body : morph[radiusY: lerp(0.95, 0.6, clamp((T - S) / D, 0, 1)) * (1 + 0.08 * sin(clamp((T - S) / D, 0, 1) * 50))] { startTime: tF, duration: flightMs, easing: "linear" }

// ---------- deflate into a limp balloon on the floor ----------
body : morph[shape: deflated] { startTime: tD, duration: deflMs, easing: "ease-out-quad" }

// ---------- air puffs trailing the nozzle (same formula as the guide) ----------
for i in range(0, 27) {
  pu = 0.02 + 0.03 * i
  pfX = 3 + 7.5 * pu + 0.8 * sin(7 * PI * pu)
  pfY = 3.6 + 1.4 * cos(4.5 * PI * pu) - 1.6 * pu + 5.3 * pow(pu, 6)
  pf = circle(pfX, pfY, 0.14 + 0.1 * (i % 3) * 0.5) { fillColor: #a8dadc, color: #a8dadc, lineWidth: 1, opacity: 0 }
  pf : show() { startTime: tF + (pu + 0.06) * flightMs }
  pf : morph[opacity: 0.6 * (1 - clamp((T - S) / D, 0, 1))] { duration: 450, easing: "linear" }
  pf : hide()
}

// ---------- explanation ----------
midTxt = text("Air rushes out one way, so the balloon goes the other way", 8, 8.3) { color: #a8dadc, fontSize: 24, fontFamily: "Georgia", fontStyle: "italic", textAlign: "center" }
midTxt : draw() { startTime: tMid, duration: 1000 }
midTxt : hide() { startTime: tZ }

endTxt = text("Action = reaction (Newton's 3rd law)", 8, 8.3) { color: #ffd166, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
endTxt : draw() { startTime: tZ, duration: 700 }
