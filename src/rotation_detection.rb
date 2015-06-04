def rotation_detection(u, v)
  u1 = v[1] - u[1]
  u2 = 0
  v1 = u1
  v2 = v[0] - u[0]
  cosalpha = (u1*v1 + u2*v2).abs/(Math.sqrt(u1**2 + u2**2) * Math.sqrt(v1**2 + v2**2))
  degrees = Math.acos(cosalpha)*180/Math::PI
  if v2 < 0
    degrees = -degrees
  end
  radians = degrees*Math::PI/180
end

