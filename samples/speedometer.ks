canvas { BGColor: #05070f }

// ---- layout and timeline (ms) ----
gx = 5.0
gy = 4.6
tx = 12.2
runStart = 1900
stepMs = 40
stepCount = 81
runDur = stepCount * stepMs
runEnd = runStart + runDur
achieveStart = runEnd + 200
needleFull = 3.5343


numLabels = ["0", "10", "20", "30", "40", "50", "60", "70", "80"]
revAngles = [0.10, 0.02, 0.14, 0.03, 0.18, 0.05]

// ---- title ----
title = text("Roadster  0 - 60 mph", 8, 0.75) { color: #7fd8ff, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
title : show() { startTime: 0 }
title : morph[opacity: 1] { startTime: 0, duration: 500 }

// ---- gauge ----
glow = circle(gx, gy, 3.8) { fillColor: rgba(76,201,240,0.35), opacity: 0 }
glow : show() { startTime: runStart }
glow : morph[opacity: 0.4 * (1 - pow(1 - clamp((T - S) / D, 0, 1), 2))] { startTime: runStart, duration: runDur }
glow : morph[opacity: 0.4 * (1 - clamp((T - S) / D, 0, 1))] { startTime: runEnd + 200, duration: 800 }

bezel = circle(gx, gy, 3.3) { fillColor: #0b1220, color: #4cc9f0, lineWidth: 0.8 }
bezel : show() { startTime: 100 }

track = arc(gx, gy, 3.0, 135, 405) { color: rgba(255,255,255,0.18), lineWidth: 1.2 }
track : draw() { startTime: 200, duration: 800 }

for tk in range(0, 17) {
  v = tk * 5
  ang = (135 + 270 * v / 80) * PI / 180
  if (v % 10 == 0) {
    tick = line((gx + 2.75 * cos(ang), gy + 2.75 * sin(ang)), (gx + 2.3 * cos(ang), gy + 2.3 * sin(ang))) { color: #ffffff, lineWidth: 0.8 }
    tick : draw() { startTime: 300 + tk * 35, duration: 200 }
  } else {
    tick = line((gx + 2.75 * cos(ang), gy + 2.75 * sin(ang)), (gx + 2.5 * cos(ang), gy + 2.5 * sin(ang))) { color: rgba(255,255,255,0.5), lineWidth: 0.5 }
    tick : draw() { startTime: 300 + tk * 35, duration: 200 }
  }
}

for (nl, i) in numLabels {
  v = i * 10
  ang = (135 + 270 * v / 80) * PI / 180
  numTxt = text(nl, gx + 1.95 * cos(ang), gy + 1.95 * sin(ang)) { color: #a8dadc, fontSize: 16, fontFamily: "Georgia", textAlign: "center", opacity: 0 }
  numTxt : show() { startTime: 600 + i * 50 }
  numTxt : morph[opacity: 1] { startTime: 600 + i * 50, duration: 300 }
}

prog = arc(gx, gy, 3.0, 135, 136) { color: #4cc9f0, lineWidth: 1.4 }
prog : show() { startTime: runStart }
prog : morph[endAngle: lerp(2.3736, 5.8905, 1 - pow(1 - clamp((T - S) / D, 0, 1), 2))] { startTime: runStart, duration: runDur }

needle = line((gx, gy), (gx - 1.768, gy + 1.768)) { color: #ff3b3b, lineWidth: 1.0 }
needle : show() { startTime: 600 }
hub = circle(gx, gy, 0.25) { fillColor: #ff3b3b, color: #ffffff, lineWidth: 0.5 }
hub : show() { startTime: 700 }

mphUnit = text("mph", gx, gy + 1.85) { color: #a8dadc, fontSize: 16, fontFamily: "Georgia", textAlign: "center", opacity: 0 }
mphUnit : show() { startTime: 900 }
mphUnit : morph[opacity: 1] { startTime: 900, duration: 300 }

// ---- digital timer ----
panel = rectangle(9.4, 2.2, 5.6, 2.6) { fillColor: #0b1220, color: #4cc9f0, lineWidth: 0.8 }
panel : show() { startTime: 300 }
timeLbl = text("TIME (s)", tx, 2.7) { color: #a8dadc, fontSize: 16, fontFamily: "Georgia", textAlign: "center", opacity: 0 }
timeLbl : show() { startTime: 700 }
timeLbl : morph[opacity: 1] { startTime: 700, duration: 300 }


// ---- digital mph readout: one text per step, swapped in sequence ----
for i in range(0, stepCount) {
  tens = floor(i / 10)
  ones = i % 10
  mphVal = round(60 * (1 - pow(1 - i / stepCount, 2)))

  timerTxt = text("0.${tens}${ones}", tx, 3.95) { color: #7cff6b, fontSize: 64, fontFamily: "Courier New", fontWeight: "bold", textAlign: "center" }
  mphTxt = text("${mphVal}", gx, gy + 1.15) { color: #ffffff, fontSize: 44, fontFamily: "Courier New", fontWeight: "bold", textAlign: "center" }

  if (i == 0) {
    timerTxt : show() { startTime: 900 }
    mphTxt : show() { startTime: 900 }
  } else {
    timerTxt : show() { startTime: runStart + i * stepMs }
    mphTxt : show() { startTime: runStart + i * stepMs }
  }
  timerTxt : hide() { startTime: runStart + (i + 1) * stepMs }
  mphTxt : hide() { startTime: runStart + (i + 1) * stepMs }
}
mphFinal = text("60", gx, gy + 1.15) { color: #ffd166, fontSize: 44, fontFamily: "Courier New", fontWeight: "bold", textAlign: "center" }
mphFinal : show() { startTime: runEnd }

timerFinal = text("0.81", tx, 3.95) { color: #ffd166, fontSize: 64, fontFamily: "Courier New", fontWeight: "bold", textAlign: "center" }
timerFinal : show() { startTime: runEnd }
timerFinal : serial [
  scale(1.25, 1.25) { duration: 200, easing: "ease-out-cubic" },
  scale(0.8, 0.8) { duration: 300, easing: "ease-in-out-sine" }
] { startTime: runEnd + 50 }

// ---- status text under the timer ----
readyTxt = text("READY", tx, 5.45) { color: #ff9d2f, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
readyTxt : show() { startTime: 1000 }
readyTxt : morph[opacity: 0.55 + 0.45 * sin(clamp((T - S) / D, 0, 1) * TAU * 3)] { startTime: 1000, duration: 900 }
readyTxt : hide() { startTime: runStart }

goTxt = text("GO!", tx, 5.45) { color: #7cff6b, fontSize: 30, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
goTxt : show() { startTime: runStart }
goTxt : parallel [
  morph[opacity: 1 - clamp((T - S) / D, 0, 1)],
  scale(1.5, 1.5) { easing: "ease-out-cubic" }
] { startTime: runStart, duration: 600 }
goTxt : hide() { startTime: runStart + 600 }

slowTxt = text("4x slow motion", tx, 5.45) { color: #a8dadc, fontSize: 16, fontFamily: "Georgia", textAlign: "center", opacity: 0 }
slowTxt : show() { startTime: runStart + 700 }
slowTxt : morph[opacity: 1] { startTime: runStart + 700, duration: 300 }
slowTxt : morph[opacity: 0] { startTime: runEnd - 300, duration: 300 }

// ---- revving: the needle shakes at the line, then sweeps to 60 mph ----
for (ra, i) in revAngles {
  needle : rotate(ra) { pivot: (gx, gy), startTime: 1000 + i * 140, duration: 140, easing: "ease-in-out-sine" }
}
needle : rotate(needleFull) { pivot: (gx, gy), startTime: runStart, duration: runDur, easing: "ease-out-quad" }
needle : rotate(needleFull + 0.1) { pivot: (gx, gy), startTime: runEnd, duration: 150, easing: "ease-out-quad" }
needle : rotate(needleFull) { pivot: (gx, gy), startTime: runEnd + 150, duration: 250, easing: "ease-in-out-sine" }

// ---- achievement ----
burstRing = circle(tx, 3.95, 0.5) { color: #ffd166, lineWidth: 0.8, opacity: 0 }
burstRing : show() { startTime: achieveStart }
burstRing : morph[radius: lerp(0.5, 3.4, clamp((T - S) / D, 0, 1)), opacity: 0.9 * (1 - clamp((T - S) / D, 0, 1))] { startTime: achieveStart, duration: 1000 }
burstRing : hide() { startTime: achieveStart + 1000 }

for sp in range(0, 18) {
  a = sp * TAU / 18
  spark = circle(tx, 3.95, 0.07) { fillColor: #ffd166, opacity: 0 }
  spark : show() { startTime: achieveStart + 100 }
  spark : parallel [
    move(cos(a) * 2.6, sin(a) * 2.6) { easing: "ease-out-cubic" },
    morph[opacity: 1 - clamp((T - S) / D, 0, 1)]
  ] { startTime: achieveStart + 100, duration: 900 }
  spark : hide() { startTime: achieveStart + 1000 }
}

starBadge = path(true, 10.700, 5.900, 10.900, 6.425, 11.461, 6.453, 11.023, 6.805, 11.170, 7.347, 10.700, 7.040, 10.230, 7.347, 10.377, 6.805, 9.939, 6.453, 10.500, 6.425) { fillColor: #ffd166, color: #ffffff, lineWidth: 0.5 }
badgeRing = circle(10.7, 6.7, 1.0) { color: #ffd166, lineWidth: 0.8 }
starBadge : scale((0.2, 0.2)) { startTime: 0, duration: 1 }
badgeRing : scale((0.2, 0.2)) { startTime: 0, duration: 1 }
starBadge : show() { startTime: achieveStart + 200 }
badgeRing : show() { startTime: achieveStart + 200 }
starBadge : scale((1, 1)) { startTime: achieveStart + 200, duration: 500, easing: "ease-out-back" }
badgeRing : scale((1, 1)) { startTime: achieveStart + 200, duration: 500, easing: "ease-out-back" }
badgeRing : morph[opacity: 0.7 + 0.3 * sin(clamp((T - S) / D, 0, 1) * TAU * 3)] { startTime: achieveStart + 800, duration: 8000 - achieveStart - 800 }

achTitle = text("ACHIEVEMENT UNLOCKED", 13.0, 6.2) { color: #ffd166, fontSize: 14, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
achTitle : show() { startTime: achieveStart + 500 }
achTitle : morph[opacity: 1] { startTime: achieveStart + 500, duration: 400 }

achBig = text("0-60 mph in 0.81 s", 13.0, 6.85) { color: #ffffff, fontSize: 20, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
achBig : show() { startTime: achieveStart + 800 }
achBig : morph[opacity: 1] { startTime: achieveStart + 800, duration: 400 }
