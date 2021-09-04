using CairoMakie, Random, Distributions
Random.seed!(1234)
b = Binomial(10, 0.85)
n = 500
function someSegments(; n = 50)
    Point2f0.(vec([[x, rand(b)] for i in 1:2, x = rand(n)]))
end
with_theme(theme_dark()) do
    fig, = linesegments(someSegments(; n = n); color = rand(n), 
        colormap = :Spectral_11, linewidth = abs.(randn(n)), 
        axis = (; xlabel = "x", ylabel = "y"),
        figure = (; resolution = (600,400)))
    save("linesegments.png", fig, px_per_unit = 2)
    display(fig)
end