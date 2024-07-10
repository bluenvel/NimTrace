import algebra, ray, color
from math import sqrt
type 
  Sphere* = object
    origin*: Point
    radius*: float
  Container* = seq[Sphere]

const white: ColorPixel = ColorPixel(r: Color(255), g: Color(255), b: Color(255))
const blue: ColorPixel = ColorPixel(r: Color(146), g: Color(185), b: Color(247))

proc sphere*(x, y, z, r: float) : Sphere {.inline.} = 
  result.origin = point(x, y, z)
  result.radius = r

proc hit*(s: Sphere, r: Ray) : float {.inline.} =
  let oc: Vec = s.origin - r.origin
  let a = len_sq(r.direction)
  let b = dot(r.direction, oc)
  let c = len_sq(oc) - s.radius * s.radius
  let discriminant = b * b - a * c 
  if discriminant < 0.0:
    return -1.0
  else: 
    return (b - sqrt(discriminant)) / a 

proc ray_color*(s: Sphere, r: Ray) : ColorPixel {.inline.} = 
  let t = hit(s, r)
  if t > 0.0:
    let Normal: UnitVec = to_unit(r.at(t) - s.origin)
    result.r = Color(int(255 * (Normal.x / 2.0 + 0.5)))
    result.g = Color(int(255 * (Normal.y / 2.0 + 0.5))) 
    result.b = Color(int(255 * (Normal.z / 2.0 + 0.5)))
  else: 
    let UD: UnitVec = to_unit(r.direction)
    let alpha = 0.5 + UD.y / 2.0
    # first argument is the floor colour, the second is ceiling
    result = mix_Colors(white, blue, alpha)
