canvas { BGColor: #0d1321}

extX = 0.8
extY = 0.2
cx = 10.2
cy = 4.6
rx = 2.8
ry = 2.9
boxR = 13.7
boxT = cy - ry - extY
floorY = cy + ry
carH = 0.275
spin = 1
topAngle = -90

meshColor = rgba(76,201,240,0.35)

for k in range(1, 10) {
  y = boxT + k * 0.6
  u = (y - cy) / ry
  xs = cx + rx * sqrt(1 - u * u)
  mh = line((xs, y), (boxR, y)) { color: meshColor, lineWidth: 0.5 } : draw() { startTime: 200 + k * 70, duration: 500 }
}
for m in range(1, 6) {
  x = cx + m * 0.6
  u = (x - cx) / rx
  if (u < 1) {
    hh = ry * sqrt(1 - u * u)
    if (cy - hh - boxT > 0.15) {
      mvu = line((x, boxT), (x, cy - hh)) { color: meshColor, lineWidth: 0.5 } : draw() { startTime: 300 + m * 70, duration: 500 }
    }
    if (floorY - (cy + hh) > 0.15) {
      mvd = line((x, cy + hh), (x, floorY)) { color: meshColor, lineWidth: 0.5 } : draw() { startTime: 300 + m * 70, duration: 500 }
    }
  } else {
    mvf = line((x, boxT), (x, floorY)) { color: meshColor, lineWidth: 0.5 } : draw() { startTime: 300 + m * 70, duration: 500 }
    tl = line(cx,boxT, (cx, cy-ry)) { color: meshColor, lineWidth: 0.5 } : draw() { startTime: 300 + m * 70, duration: 500 }
  }
}

ramp = group [
  path(false, cx, cy-ry ,cx-extX,cy-ry ,cx-extX, boxT, cx, boxT, boxR, boxT, boxR, floorY, 0.6, floorY) { color: #4cc9f0, lineWidth: 1.2 },
  earc(cx, cy, rx, ry, topAngle, 90) { color: #4cc9f0, lineWidth: 1.6 }
]
ramp : show() { startTime: 100 }

car = group [
  path(true, 0.933, 7.148, 1.549, 7.036, 2.216, 7.159, 2.416, 7.137, 2.753, 7.262, 2.753, 7.359, 0.964, 7.35, 0.854, 7.289, 0.867, 7.168) { fillColor: #e63946, color: #ffffff, lineWidth: 0.5 },
  path(true, 1.184, 7.137, 1.536, 7.071, 1.998, 7.155, 1.998, 7.214, 1.184, 7.214) { fillColor: #a8dadc, color: #1d3557, lineWidth: 0.5 },
  circle(1.228, 7.335, 0.165) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(2.35, 7.335, 0.165) { fillColor: #14213d, color: #ffffff, lineWidth: 0.5 },
  circle(1.228, 7.335, 0.06) { fillColor: #cfd8dc },
  circle(2.35, 7.335, 0.06) { fillColor: #cfd8dc },
  circle(2.702, 7.28, 0.04) { fillColor: #ffd166 }
]
car : show() { startTime: 1000 }

loopAngle = PI 
driveStart = 1400
driveDur = 1800
climbStart = driveStart + driveDur + 100
climbDur = 3200
holdDur = 1200
descentStart = climbStart + climbDur + holdDur
descentDur = 3200
descentEnd = descentStart + descentDur

car : move(cx - 1.8, 0) { startTime: driveStart, duration: driveDur, easing: "ease-in-sine" }

car : rotate(-spin * loopAngle) { pivot: (cx, cy), startTime: climbStart, duration: climbDur, easing: "ease-out-sine" }

tag = text("upside down!", 7.0, 1.2) { color: #ffd166, fontSize: 24, fontFamily: "Georgia", fontWeight: "bold", textAlign: "center", opacity: 0 }
tag : show() { startTime: climbStart + climbDur }
tag : morph[opacity: 1] { startTime: climbStart + climbDur, duration: 300 }
tag : morph[opacity: 0] { startTime: descentStart - 300, duration: 300 }

car : rotate(0) { pivot: (cx, cy), startTime: descentStart, duration: descentDur, easing: "ease-in-sine" }

car : move(-(cx - 1.8), 0) { startTime: descentEnd + 200, duration: 1600, easing: "ease-out-sine" }
