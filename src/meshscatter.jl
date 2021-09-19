using GLMakie, Random
Random.seed!(13)
x = -6:0.5:6
y = -6:0.5:6
z = 6exp.( -(x.^2 .+ y' .^ 2)./4)

box = Rect3(Point3f(-0.5), Vec3f(1))
colors = to_colormap(:linear_worb_100_25_c53_n256)
n = length(colors)
g(x) = x^(1/10)
alphas = [g(x) for x in LinRange(0,1,n)]
cmap_alpha = RGBAf0.(colors, alphas)

set_theme!(theme_dark())
fig, ax, = meshscatter(x, y, z; marker=box, markersize = 0.5, 
    color = vec(z), colormap = cmap_alpha, colorrange = (0,6),
    axis = (; type = Axis3, aspect = :data, azimuth = 7.3, 
    elevation = 0.189, perspectiveness = 0.5), 
    figure = (;resolution =(1200,800)))
meshscatter!(ax, x .+ 7, y, z./2; markersize = 0.25, color = vec(z./2), 
    colormap = cmap_alpha, colorrange = (0, 6), 
    ambient = Vec3f0(0.85, 0.85, 0.85), backlight = 1.5f0)
xlims!(-5.5,10)
ylims!(-5.5,5.5)
hidedecorations!(ax; grid = false)
hidespines!(ax)
save("meshscatter.png", fig) 
display(fig)