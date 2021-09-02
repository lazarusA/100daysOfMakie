using CairoMakie, Random, Distributions
Random.seed!(1234)
d = Normal()
b = Binomial(15, 0.7)
n = 350
with_theme(theme_dark()) do
    fig, = scatter(rand(d,n), rand(b, n);  markersize = 12*abs.(rand(d, n)),
        color = tuple.(:dodgerblue, rand(n)), strokewidth = 0.5, 
        strokecolor = :white, axis = (; xlabel = "x", ylabel = "y"), 
        figure = (; resolution = (600,400)))
    save("scatter_bubbles.png", fig, px_per_unit = 2)
end