import algebra, ray, color, hittable
import std/with

proc main = 
  const camera_origin: Point = point(0.0, 0.0, 0.0)
  const focal_length = 1.0 
  const pixelplaneWidth = 500
  const aspect_ratio = 3.0 / 2.0
  const pixelplaneHeight = int(pixelplaneWidth.float / aspect_ratio)
  const viewplaneHeight = 2.0 
  const viewplaneWidth = viewplaneHeight * (pixelplaneWidth.float / pixelplaneHeight.float)
  const Uvec = Vec(x: viewplaneWidth, y: 0.0, z: 0.0)
  const Vvec = Vec(x: 0.0, y: viewplaneHeight, z: 0.0)
  const viewplaneUpperCorner = camera_origin + vec(0.0, 0.0, focal_length) - Uvec / 2.0 - Vvec / 2.0
  const DU = Uvec / pixelplaneWidth.float 
  const DV = Vvec / pixelplaneHeight.float
  const pixelZero: Point = viewplaneUpperCorner + DU / 2.0 + DV / 2.0
  # y +1 
  # y  0
  # y -1

  var world: Container
  world.add(sphere(0, 0, 3.0, 1.5))

  block renderProcedure:
    let output: File = open("output/render.ppm", fmWrite)
    output.write("P3\n", pixelplaneWidth, " ", pixelplaneHeight, "\n")
    output.write("255\n")
    defer: 
      close output
    for row in 0..<pixelplaneHeight: 
      for col in 0..<pixelplaneWidth:
        for mesh in world:
          let pixel_position: Point = pixelZero + row.float * DV + col.float * DU
          let castray: Ray = Ray(origin: camera_origin, direction: pixel_position - camera_origin)
          write_Color(output, ray_color(mesh, castray))

when isMainModule: 
  main()
