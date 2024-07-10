from math import sqrt 

type 
  Vec* = object 
    x*, y*, z*: float 
  UnitVec* {.borrow: `.`} = distinct Vec 
  Point* {.borrow: `.`} = distinct Vec 

proc vec*(x, y, z: float) : Vec {.inline.} = 
  result.x = x 
  result.y = y
  result.z = z
proc `-`*(v: Vec) : Vec {.inline.} = 
  result.x = -v.x 
  result.y = -v.y 
  result.z = -v.z 
proc `+`*(v: Vec, t: Vec) : Vec {.inline.} = 
  result.x = v.x + t.x 
  result.y = v.y + t.y 
  result.z = v.z + t.z 
proc `-`*(v: Vec, t: Vec) : Vec {.inline.} = 
  v + -t
proc `*=`*(v: var Vec, t: float) {.inline.} =
  v.x *= t
  v.y *= t 
  v.z *= t 
proc `/=`*(v: var Vec, t: float) {.inline.} =
  v *= 1.0 / t
proc `+=`*(v: var Vec, t: Vec) {.inline.} = 
  v = v + t 
proc `-=`*(v: var Vec, t: Vec) {.inline.} = 
  v += -t
proc `*`*(v: Vec, t: float) : Vec {.inline.} = 
  result.x = v.x * t 
  result.y = v.y * t 
  result.z = v.z * t 
proc `*`*(t: float, v: Vec) : Vec {.inline.} =
  v * t 
proc `/`*(v: Vec, t: float) : Vec {.inline.} = 
  v * (1.0 / t)

proc dot*(v, t: Vec) : float {.inline.} = 
  v.x * t.x + v.y * t.y + v.z * t.z 
proc len_sq*(v: Vec) : float {.inline.} = 
  dot(v, v)
proc len*(v: Vec) : float {.inline.} = 
  sqrt(len_sq v)
proc `.x.`*(v: Vec, t: Vec) : Vec {.inline.} = 
  result.x = v.y * t.z - v.z * t.y 
  result.y = v.z * t.x - v.x * t.z 
  result.z = v.x * t.y - v.y * t.x 
proc `$`*(v: Vec) : string {.inline.} = 
  result &= $v.x & ' ' & $v.y & ' ' & $v.z

# POINTS

proc `-`*(p1, p2: Point) : Vec {.inline.} = 
  result.x = p1.x - p2.x 
  result.y = p1.y - p2.y 
  result.z = p1.z - p2.z 
proc `+`*(p1: Point, v: Vec) : Point {.inline.} =
  result.x = p1.x + v.x 
  result.y = p1.y + v.y 
  result.z = p1.z + v.z 
proc `-`*(p: Point, v: Vec) : Point {.inline.} = 
  result.x = p.x - v.x 
  result.y = p.y - v.y 
  result.z = p.z - v.z
proc `$`*(p: Point) : string {.borrow.}

proc point*(x, y, z: float) : Point {.inline.} = 
  result.x = x
  result.y = y
  result.z = z

# UNITS

proc to_unit*(v: Vec) : UnitVec {.inline.} = 
  UnitVec(v / v.len) 
proc `$`*(u: UnitVec) : string {.borrow.}
