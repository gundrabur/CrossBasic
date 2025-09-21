# 3D Raytracer Demo

This directory contains a simple 3D raytracing demonstration for the CrossBasic interpreter.

## Files

- `raytrace.bas` - Simple 3D raytracer that renders spheres
- `raytrace_simple.bas` - Alternative implementation
- This README with mathematical background

## Overview

The raytracer implements basic 3D rendering by casting rays from a camera through each pixel and testing for intersections with 3D objects (spheres).

## Algorithm

### Ray Generation
For each pixel (x, y) on the screen:
1. Convert screen coordinates to normalized device coordinates (-1 to 1)
2. Create a ray from the camera position through the pixel
3. Normalize the ray direction vector

### Sphere Intersection
For each sphere in the scene:
1. Calculate the ray-sphere intersection using the quadratic formula
2. Solve: ||P(t)||² = r² where P(t) = ray_origin + t * ray_direction
3. If discriminant ≥ 0, the ray intersects the sphere

### Mathematical Details

Ray equation: P(t) = O + t*D
- O = ray origin (camera position)
- D = ray direction (normalized)
- t = distance parameter

Sphere equation: ||P - C||² = r²
- C = sphere center
- r = sphere radius

Substituting ray into sphere equation gives quadratic:
At² + Bt + C = 0

Where:
- A = D·D = 1 (since D is normalized)
- B = 2D·(O-C)
- C = (O-C)·(O-C) - r²

## Scene Description

The demo renders three spheres:

1. **Red Sphere** (Color 2)
   - Center: (0, 0, 2)
   - Radius: 1.0

2. **Blue Sphere** (Color 4)
   - Center: (-1.5, -0.5, 1.5)
   - Radius: 0.7

3. **Green Sphere** (Color 3)
   - Center: (1, 0.5, 3)
   - Radius: 0.8

## Camera Setup

- Position: (0, 0, -3)
- Field of view: ~60 degrees
- Aspect ratio: 4:3

## Performance Notes

- Uses reduced resolution (step size) for faster rendering
- Simple intersection test without depth sorting
- Later spheres in the test order override earlier ones
- No lighting model - just solid colors

## Usage

To run the raytracer:
```
RUN
```

Or load the file:
```
LOAD "raytrace.bas"
RUN
```

The program will:
1. Initialize graphics mode
2. Set up the scene parameters
3. Cast rays for each pixel
4. Display progress as it renders
5. Show the final result

## Educational Value

This demo illustrates:
- 3D coordinate systems and transformations
- Ray-object intersection mathematics
- Basic computer graphics concepts
- Structured programming in BASIC
- Mathematical computation with square roots and discriminants

## Extensions

Possible enhancements could include:
- Depth sorting for proper occlusion
- Simple lighting calculations
- Additional primitive types
- Anti-aliasing
- Reflections or shadows

The current implementation provides a solid foundation for understanding raytracing principles while remaining simple enough to run efficiently in the BASIC interpreter.