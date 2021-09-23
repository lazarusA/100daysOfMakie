using GLMakie
xtmp = 10 .^(range(-1.5, stop=0.3,length=10))
x = vcat(-reverse(xtmp), xtmp)
y = vcat(-reverse(xtmp), xtmp)
f(z) = log(z)
fvals = [f(u+1im*v) for u in x, v in y]
fvalues = real.(fvals)
fargs = angle.(fvals)

set_theme!(theme_dark())
fig = Figure(resolution = (1200,600))
ax1 = Axis3(fig[1,1]; aspect = :data, perspectiveness = 0.5, 
    elevation = 0.08, azimuth = -1.02)
ax2 = Axis3(fig[1,2]; aspect = :data, perspectiveness = 0.5, 
    elevation = 0.11, azimuth = -0.45)
wireframe!(ax1, x, y, fvalues; color = :white, transparency = true) 
surface!(ax2, x, y, fvalues; color = fargs,
    colormap = :diverging_rainbow_bgymr_45_85_c67_n256,
    colorrange = (-π,π), backlight = 1f0, highclip = :black)
save("wireframeSurface.png", fig)
display(fig)