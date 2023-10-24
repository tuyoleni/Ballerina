import math

def sin(x):
  return math.sin(x)

def arcsin(x):
  """Returns the arcsine of x in radians."""
  if x > 1:
    return math.pi / 2
  elif x < -1:
    return -math.pi / 2
  else:
    return math.asin(x)

def solve_equation(x):
  """Returns the solution to the equation sin(15) - 0.295x = 27.081."""
  return arcsin(27.081 + 0.295 * x) * 180 / math.pi

print(solve_equation(15))
