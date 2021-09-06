using CairoMakie, Random
Random.seed!(14)
n, m = 25, 50
xPos = LinRange(-π/3,2π,n)
startPos = sin.(xPos)/3
widths = 0.1 .+ 0.2rand(n)
colors = rand(n)
cmap1 = to_colormap(:starrynight)[5:end-5]
cmap2 = to_colormap(:vangogh)[5:end-5]
with_theme(theme_dark()) do
    fig = Figure(resolution = (600,800))
    ax1 = Axis(fig[1,1])
    ax2 = Axis(fig[2,1])
    for i in 0:3.5:m
        indxs = shuffle(1:n)
        barplot!(ax1, xPos[indxs], rand(1:3,n) .+ i; fillto = startPos .+ i,
        color = colors, colormap = cmap1, width = widths, strokewidth = 0.5,
        strokecolor = colors[indxs], direction = :y)
        barplot!(ax2, xPos[indxs], rand(1:3,n) .+ i; fillto = startPos .+ i,
        color = colors, colormap = cmap2, width = widths, strokewidth = 0.5,
        strokecolor = colors[indxs], direction = :x)
    end
    hidedecorations!(ax1)
    hidedecorations!(ax2)
    save("barplot2.svg", fig)
    display(fig)
end