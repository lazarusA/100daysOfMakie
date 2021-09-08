using CairoMakie, Random, LaTeXStrings
Random.seed!(123)
m = 200
function spiral(; a = 1, n = 100, h = 0, k = 0)
    φ = LinRange(rand() + 1, 6π, n)
    h .+  rand(-1:2:1)*a*cos.(φ)./φ, k .+  rand(-1:2:1)*a*sin.(φ)./φ
end
curves = [spiral(; a = rand(), h = rand(-1:1)) for i in 1:m]

with_theme(theme_dark()) do
    fig = Figure(resolution = (600,400))
    ax = Axis(fig[1,1])
    series!(curves; color = to_colormap(:bone_1, m), linewidth = 1.5)
    text!(latexstring("x=a\\,\\cos(\\varphi)/\\varphi,\\quad 
        y=a\\,\\sin(\\varphi)/\\varphi,\\quad \\varphi>0"), 
        position = (-1,-1))
    hidedecorations!(ax; grid = false)
    save("series.png", fig, px_per_unit = 2)
    display(fig)
end