type Color* = int16
type ColorPixel* = object
  r*, g*, b*: Color

proc write_Color*(output: File, cpix: ColorPixel) {.inline.} = 
  output.write($cpix.r & ' ' & $cpix.g & ' ' & $cpix.b & '\n')
proc adjust_Color*(cpix: var ColorPixel, rf, gf, bf: float) {.inline.} = 
  cpix.r = Color(int(rf * 255))
  cpix.g = Color(int(gf * 255))
  cpix.b = Color(int(bf * 255))
proc mix_Colors*(a, b: ColorPixel, alpha: float) : ColorPixel {.inline.} =
  let ra = float(a.r) * alpha + float(b.r) * (1.0 - alpha)
  let ga = float(a.g) * alpha + float(b.g) * (1.0 - alpha)
  let ba = float(a.b) * alpha + float(b.b) * (1.0 - alpha)
  result.r = Color(ra)
  result.b = Color(ba)
  result.g = Color(ga) 
