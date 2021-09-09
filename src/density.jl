using CairoMakie, Random
Random.seed!(124)
colors = ["#FF410D", "#6EE2FF", "#F7C530", "#95CC5E", "#D0DFE6", "#F79D1E"]
μσpairs = [[2,0.5], [-1,2], [0.25,1], [1,0.1], [1, 0.05], [1.2,0.1]]

with_theme(theme_dark()) do
    fig = Figure(resolution = (600,400))
    ax = Axis(fig[1,1]; palette = (; patchcolor = tuple.(colors, 0.45)))
    for (idx, μσ) in enumerate(μσpairs)
        density!(rand(Normal(μσ...), 1000), strokewidth = 1.5, 
            strokecolor = :white, direction = idx > 3 ? :x : :y, 
            linestyle = idx > 3 ? :dash : nothing, 
            label = "$(μσ[1]),  $(μσ[2])")
    end
    axislegend(L"\mu,\quad\sigma"; position= :cb, titlesize= 22)
    hidedecorations!(ax; grid = false)
    save("density.png", fig, px_per_unit = 2)
    display(fig)
end