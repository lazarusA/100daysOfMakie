using CairoMakie, Random, Distributions
Random.seed!(13)
n = 3000
colors = to_colormap(:spring, 8)[3:end]

set_theme!(theme_dark())
fig = Figure(resolution = (600, 400))
ax = Axis(fig[1,1]; palette = (; patchcolor = colors), 
    xticks = (1:7, ["cat 1", "A", "B", "C", "D", "E", "F"]), 
    yticks = ([-5], ["cat 2"]), yticklabelrotation = π/2)
boxplot!(ax, fill(-5,n), rand(Normal(0, 0.5), n); orientation=:horizontal, 
    whiskerwidth = 1, width = 2, color = (:orange, 0.95), 
    whiskercolor = :red, mediancolor = :yellow, markersize = 8, 
    strokecolor = :black, strokewidth = 1, label = "horizontal")
boxplot!(ax, fill(1,n), rand(Normal(1,  3), n); whiskerwidth = 1, 
    width = 0.5, color = :dodgerblue, whiskercolor = :dodgerblue, 
    mediancolor = :white, markersize = 5, strokecolor = :white, 
    strokewidth = 1, label = "vertical")
for i in 2:7
    boxplot!(ax, fill(i,n), rand(Normal(rand(-2:5), 2*rand() + 0.3), n); 
        whiskerwidth = 1, width = 0.35)
end
axislegend(ax, position = :lt)
save("boxplot.png", fig, px_per_unit = 2)
display(fig)
