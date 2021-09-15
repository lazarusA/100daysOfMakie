using CairoMakie, Random
Random.seed!(145)
n = 50
x = 1:n
y = sin.(x) .+ randn(n)/10
yerr = 0.2*abs.(randn(n))
xerr = abs.(randn(n))
set_theme!(theme_dark())

fig, ax, =  errorbars(x, y, yerr; color = 1:n, colormap = (:white, :red),
    whiskerwidth = 10, linewidth = 1.5, 
    figure = (;resolution = (600,400)))
errorbars!(x, y, xerr; color = 1:n, colormap = (:dodgerblue, :white), 
    direction = :x, linewidth = 1.5, whiskerwidth = 10)
scatter!(x, y; markersize = 10, color = (:white, 0.25), 
    strokewidth = 1, strokecolor = :white)
lines!(x, y; linewidth = 0.5, linestyle = :dashdot)
hidedecorations!(ax; grid = false) 
save("errorbars.png", fig, px_per_unit = 2)
display(fig)