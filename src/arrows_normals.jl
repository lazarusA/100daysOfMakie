using GLMakie, LinearAlgebra, ForwardDiff
x = -2:0.25:2
y = -1:0.25:1

zz(x,y) = x*exp(-x^2 - y^2)
g(x,y, z) = [-x*exp(-x^2 - y^2) + z]
J(xx, yy, zz) = ForwardDiff.jacobian(x -> g(x[1], x[2], x[3]), [xx,yy,zz])

ps = [Point3f(x, y, zz(x,y)) for x in x for y in y]
normals = [Point3f(J(x, y, zz(x,y))...) for x in x for y in y]
lengths = norm.(normals)

set_theme!(theme_dark())
fig, ax, = surface(x, y, zz.(x, y'); colormap = :viridis, transparency = true,
    axis = (;type = Axis3, aspect = :data, perspectiveness = 0.5, 
    elevation = 0.34, azimuth = 2.11), 
    figure = (;resolution = (1200,600)))
wireframe!(ax, x, y,  zz.(x, y'); color = :white, transparency = true, 
    linewidth = 0.25)
arrows!(ax, ps, normals./7; color=lengths, colormap = Reverse(:thermal), 
    linewidth = 0.02, arrowsize = Vec3f(0.08, 0.08, 0.08))
hidedecorations!(ax; grid = false)
save("arrows_normals.png", fig)
fig