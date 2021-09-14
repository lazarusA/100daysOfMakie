using CairoMakie, Random
Random.seed!(145)
n = 10
x = LinRange(1,20,n) 
y = 5*rand(n)
yerr = 0.4*abs.(randn(n))
set_theme!(theme_dark())
fig, ax,  = barplot(x, y; color = 1:n, width = 1, 
    colormap = Reverse(:inferno), strokewidth = 1, strokecolor = :white, 
    figure = (;resolution = (600,400)))
errorbars!(x, y, yerr, color = 1:n, whiskerwidth = 10, linewidth = 2,
    colormap = Reverse(:linear_wcmr_100_45_c42_n256))
alphabet = 'A':'J'
xticks = string.(collect(alphabet))
ax.xticks = (x, xticks)
hideydecorations!(ax; grid = false) 
save("barplot_and_errorbars.png", fig, px_per_unit = 2)
display(fig)