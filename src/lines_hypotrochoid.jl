using CairoMakie
x(t; a = 5, b = 7, c = 1.5) = (a - b)*cos(t) + c*cos(t*(a/b - 1))
y(t; a = 5, b = 7, c = 1.5) = (a - b)*sin(t) - c*sin(t*(a/b - 1))
t = 0:0.001:20π
with_theme(theme_dark()) do
    fig, = lines(x.(t), y.(t); color = ("#08F7FE",0.8), linewidth = 0.8, 
        axis = (; aspect = DataAspect(), xlabel = "x", ylabel = "y"), 
        figure = (; resolution = (600,600)))
    [lines!(x.(t), y.(t); color = ("#08F7FE", 0.08), linewidth = 1 + 0.8*i) 
        for i in 1:13]
    save("lines_hypotrochoid.png", fig, px_per_unit = 2)
end
