import algebra 

type Ray* = object 
  origin*: Point 
  direction*: Vec 

proc at*(r: Ray, t: float) : Point {.inline.} = 
  result = r.origin + t * r.direction 


