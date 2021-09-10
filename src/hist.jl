using CairoMakie, Distributions, Random
Random.seed!(124)
cmap = to_colormap(:linear_wcmr_100_45_c42_n256)
alpha = rand(length(cmap))
cmap_alpha = RGBAf.(cmap, alpha)

set_theme!(theme_dark())
fig = Figure(resolution = (600,400))
ax = Axis(fig[1,1]; )
hist!(rand(Normal(2.6,0.4), 1000), normalization = :pdf, offset = -1, 
    color = :values, colormap = :plasma, direction = :x, fillto = -0.5)
hist!(rand(Normal(2.6,0.4), 1000), normalization = :pdf, offset = 1, 
    color = :grey90, direction = :x, scale_to = -0.5)
hist!(rand(Normal(0.2,0.2), 1000), normalization = :pdf, offset = 4, 
    strokewidth = 1, color = :transparent, strokecolor = :white, 
    direction = :y, scale_to = -1)
hist!(rand(Normal(0.2,0.2), 1000), normalization = :pdf, color = :values, 
    colormap = cmap_alpha, strokewidth = 1, strokecolor = :black, 
    bar_labels = :values, label_color = :white, label_size = 12,
    label_formatter=x-> round(x, digits=1))
hidedecorations!(ax; grid = false)
save("hist.png", fig, px_per_unit = 2)
display(fig)
