using CairoMakie
n = 50
t = LinRange(0, 5*π, n)
x(t; a = 0.0, b = -2.4) = (a + b*t) * cos(t)
y(t; a = 0.0, b = -2.4) = (a + b*t) * sin(t)
with_theme(theme_dark()) do
    fig = Figure(resolution = (600,400))
    ax = Axis(fig[1,1]; aspect = DataAspect(), xlabel = "x", ylabel = "y")
    for (k,i) in enumerate(-4:-2)
        scatterlines!(x.(t; b = i), y.(t; b = i), color = 1:n, 
      	colormap = (:Spectral_11, 0.5), markercolor = 1:n,
      	markersize = LinRange(3,30/k,n), markercolormap = :Spectral)
    end
    save("scatterlines_archimedes_spiral.png", fig, px_per_unit = 2)
    display(fig)
end