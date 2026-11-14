canvas { BGColor: #05070f }

// ---------- phase times (ms) ----------
tWords = 0
tMark = 2000
tMark1 = 2000
tMark2 = 2700
tMark3 = 3400
strokeMs = 650
tMarkEnd = 4000
tEnd = 5000

// ---------- 12 FAKE words: same sizes, tilts and positions as before ----------
fx = [2.3, 7.9, 12.6, 4.9, 10.6, 14.2, 2.3, 3.4, 8.0, 13.0, 13.9, 1.6]
fy = [1.1, 0.9, 1.3, 2.4, 2.5, 3.6, 3.9, 5.9, 6.9, 6.0, 7.9, 7.7]
fs = [110, 70, 120, 90, 100, 80, 120, 90, 120, 110, 70, 80]
fa = [-0.08, 0.06, 0.1, -0.12, 0.05, -0.15, 0.12, -0.06, 0.0, 0.09, -0.1, 0.07]
ft = ["FAKE", "fake", "FAKE", "Fake", "FAKE", "fake", "FAKE", "FAKE", "Fake", "FAKE", "fake", "FAKE"]
fw = ["bold", "normal", "bold", "normal", "bold", "bold", "bold", "normal", "bold", "bold", "normal", "bold"]
fc = [#ff5c7a, #5b6b8c, #ff5c7a, #3a4660, #5b6b8c, #ff5c7a, #5b6b8c, #ff5c7a, #3a4660, #ff5c7a, #5b6b8c, #3a4660]

// ---------- the three marker strokes (defined first, so the letters sit on top of them) ----------
// line 1: top third, left to right
mark1 = path(true, 5.22, 3.8, 8.0, 3.74, 10.82, 3.78, 10.88, 4.3, 8.0, 4.36, 5.18, 4.34) 
{ fillColor: #ffe14d, color: #ffe14d, lineWidth: 1, opacity: 0 }
// line 2: middle third, right to left
//mark2 = path(true, 10.86, 4.28, 8.0, 4.34, 5.14, 4.3, 5.1, 4.86, 8.0, 4.9, 10.9, 4.84) 
//{ fillColor: #ffe14d, color: #ffe14d, lineWidth: 1, opacity: 1 }
mark2 = line(10.88, 4.6, -5.76, -0.05) { color: #ffe14d, lineWidth: 50 }
// line 3: bottom third, left to right
mark3 = path(true, 5.18, 4.82, 8.0, 4.86, 10.84, 4.82, 10.8, 5.38, 8.0, 5.42, 5.2, 5.36) 
{ fillColor: #ffe14d, color: #ffe14d, lineWidth: 1, opacity: 0 }

mark1 : show() { startTime: 1 }
//mark2 : show() { startTime: 1 }
mark3 : show() { startTime: 1 }
mark1 : scale((0.01, 1)) { pivot: (5.18, 4.07), startTime: 3, duration: 1 }
//mark2 : scale((0.01, 1)) { pivot: (10.88, 4.57), startTime: 3, duration: 1 }
mark3 : scale((0.01, 1)) { pivot: (5.18, 5.1), startTime: 3, duration: 1 }

// ---------- first second: every word comes in (FAKE words 60 ms apart, FACT last) ----------
for i in range(0, 12) {
  fk = text(ft[i], fx[i], fy[i]) { color: fc[i], fontSize: fs[i], fontFamily: "Georgia", fontWeight: fw[i], textAlign: "center" }
  fk : rotate(fa[i]) { pivot: (fx[i], fy[i]), startTime: 0, duration: 1 }
  fk : draw() { startTime: tWords + 60 * i, duration: 300 }
  // while the marking happens, the fakes dim (2 s to 4 s)
  fk : morph[opacity: lerp(1, 0.3, clamp((T - S) / D, 0, 1))] { startTime: tMark, duration: tMarkEnd - tMark, easing: "linear" }
}

factWhite = text("FACT", 8.0, 5) { color: #ffffff, fontSize: 140, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
factWhite : draw() { startTime: 700, duration: 300 }

// dark copy on top: fades in over the two marking seconds, so the letters never disappear
factBlack = text("FACT", 8.0, 5) { color: #05070f, fontSize: 140, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center" }
factBlack : fadeIn() { startTime: tMark, duration: tMarkEnd - tMark }

// ---------- 2nd second: nothing ----------

// ---------- 3rd and 4th seconds: marking in 3 lines ----------
mark1 : morph[opacity: 1] { startTime: tMark1, duration: 1 }
mark1 : scale((1, 1)) { pivot: (5.18, 4.07), startTime: tMark1, duration: strokeMs, easing: "ease-in-out-sine" }
mark2 : draw() { startTime: tMark2, duration: strokeMs, easing: "ease-in-out-sine" }
//mark2 : morph[opacity: 1] { startTime: tMark2, duration: 1 }
//mark2 : scale((1, 1)) { pivot: (5, 4.57), startTime: tMark2, duration: strokeMs, easing: "ease-in-out-sine" }
//mark2 : draw() { startTime: tMark2, duration: strokeMs, easing: "ease-in-out-sine" }
mark3 : morph[opacity: 1] { startTime: tMark3, duration: 1 }
mark3 : scale((1, 1)) { pivot: (5.18, 5.1), startTime: tMark3, duration: tMarkEnd - tMark3, easing: "ease-in-out-sine" }

// ---------- 5th second: nothing changes (invisible dummy move keeps the clip at 5 s) ----------
hold = circle(0.1, 0.1, 0.02) { color: #05070f, lineWidth: 1, opacity: 0 }
hold : move(0, 0.03) { startTime: tMarkEnd, duration: tEnd - tMarkEnd }
