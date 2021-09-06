using CairoMakie, Random
Random.seed!(14)
n = 25
m = 50
xPos = LinRange(-π/3,2π,n)
startPos = sin.(xPos)/3
widths = 0.1 .+ 0.2rand(n)
colors = rand(n)
cmap = to_colormap(:starrynight)[5:end]

with_theme(theme_dark()) do
    fig = Figure(resolution = (600,400))
    ax = Axis(fig[1,1])
    for i in 0:3.5:m
        indxs = shuffle(1:n)
        barplot!(xPos[indxs], rand(1:3,n) .+ i; fillto = startPos .+ i,
        color = colors, colormap = cmap, width = widths, strokewidth = 0.5,
        strokecolor = colors[indxs])
    end
    hidedecorations!(ax)
    save("barplot.png", fig, px_per_unit = 2)
    display(fig)
end