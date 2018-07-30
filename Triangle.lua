local function fromAxes(p,x,y,z)
	return CFrame.new(
		p.x, p.y, p.z,
		x.x, y.x, z.x,
		x.y, y.y, z.y,
		x.z, y.z, z.z
	)
end
local function triangle(a,b,c)
	local ab, ac, bc = b - a, c - a, c - b
	local abl, acl, bcl = ab.magnitude, ac.magnitude, bc.magnitude
	if abl > bcl and abl > acl then
		c, a = a, c
	elseif acl > bcl and acl > abl then
		a, b = b, a
	end
	ab, ac, bc = b - a, c - a, c - b
	local out = ac:Cross(ab).unit
	local biDir = bc:Cross(out).unit
	local biLen = math.abs(ab:Dot(biDir))
	local norm = bc.magnitude
	local s1 = Vector3.new(0, math.abs(ab:Dot(bc))/norm, biLen)
	local s2 = Vector3.new(0, biLen, math.abs(ac:Dot(bc))/norm)
	bc = -bc.unit
	local c1 = fromAxes((a + b)/2, -out, bc, -biDir)
	local c2 = fromAxes((a + c)/2, -out, biDir, bc)
	return c1,s1,c2,s2
end
