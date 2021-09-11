using CairoMakie, Distributions, Random
Random.seed!(124)
n = 4
colors = to_colormap(:seaborn_colorblind, 8)
sides = [:left, :right, :right]

set_theme!(theme_dark())
fig = Figure(resolution = (600,400))
ax = Axis(fig[1,1]; palette = (; patchcolor = colors))
for i in [-5,5], j in 1:n
    violin!(fill(j, 1000), rand(Normal(i,rand()+0.5), 1000); 
    side = i >-3 ? sides[rand(1:3)] : :both)
end
violin!(fill(2.5, 1000), rand(Normal(0,2.5), 1000); color = :transparent,
    strokewidth = 0.85, strokecolor = :grey90, show_median = true, 
    mediancolor = :white)
violin!(fill(4.5, 1000), rand(Normal(2,2), 1000); color = (:dodgerblue,0.1),
    strokewidth = 0.85, strokecolor = :dodgerblue, show_median = true,
    medianlinewidth = 3)
alphabet = 'A':'D' 
xticks = string.(collect(alphabet))
ax.xticks = (1:n, xticks)
hideydecorations!(ax; grid = false) 
save("violin.png", fig, px_per_unit = 2)
display(fig)