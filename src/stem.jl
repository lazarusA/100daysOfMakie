using CairoMakie, Random
Random.seed!(2)
t = 0.3:0.3:3π
my_markers = [:circle, :rect, :utriangle, :dtriangle, :diamond, :pentagon, 
    :cross, :xcross]
with_theme(theme_dark()) do
    fig, ax, = stem(t, 1.5exp.(-t/5).*cos.(t); color = 1:length(t), 
        colormap = :linear_wyor_100_45_c55_n256, stemcolor = 1:length(t), 
        stemcolormap = :linear_wcmr_100_45_c42_n256, 
        figure = (; resolution = (600,400)))
    stem!(t .+ 0.15, -cos.(t) ./ t .+ 0.25; color = :transparent, 
        stemwidth = 0.5, marker = :rect, markersize = 10, strokewidth = 1, 
        strokecolor = :white)
    stem!(1:8, 1.5randn(8); marker = my_markers, 
        color = tuple.(to_colormap(:mk_12, 8), 0.65), stemlinestyle = :dash,
        stemcolor = to_colormap(:mk_12, 8), markersize = 15*rand(8) .+ 10, 
        strokewidth = 1.5, strokecolor = to_colormap(:mk_12, 8))
    hidedecorations!(ax; grid = false)
    save("stem.png", fig, px_per_unit = 2)
    display(fig)
end