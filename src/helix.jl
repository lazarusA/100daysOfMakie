using GLMakie
npairs, θinit = 40, 10*π/180
z = 1:npairs
θ = z .* θinit
x(θ; r = 5) = r * cos(θ) 
y(θ; r = 5) = r * sin(θ) 
x1, y1 = x.(θ), y.(θ)
x2, y2 = x.(θ .+ π), y.(θ .+ π)
colors1 = rand(1:4, npairs) # 1, 2, 3, 4 =>  'A', 'T', 'C', 'G'
colors2 = [i == 1 ? 2 : i==2 ? 1 : i == 3 ? 4 : 3 for i in colors1]
cmap = cgrad(:Set1_4, 4, categorical = true) 
lseg, colors = Point3f[], Int64[]
for i in 1:npairs
    push!(lseg, [x1[i], z[i], y1[i]])
    push!(lseg, [x2[i], z[i], y2[i]])
    push!(colors, colors1[i])
    push!(colors, colors2[i])
end

with_theme(theme_dark()) do  
    fig, ax, = meshscatter(x1, z, y1, color = colors1, colormap = cmap, 
        colorrange = (0.5, 4.5), markersize = 0.35,
        axis=(type=Axis3, aspect = :data, perspectiveness = 0.5, 
        azimuth = -0.49, elevation = 0.63), 
        figure = (;resolution = (1200,800)))
    meshscatter!(ax, x2, z, y2, color = colors2, colormap = cmap, 
        colorrange = (0.85, 4.5), markersize = 0.35)
    linesegments!(lseg; color = colors, colormap = cmap)
    meshscatter!(ax, tuple.(8, 1:10:40,-2); color = 1:4, colormap = cmap, 
        markersize = 0.5)
    text!(ax, ["A", "T", "C", "G"], position = tuple.(8, 1:10:40,-4), 
        align = (:center, :bottom), color = :white)
    hidedecorations!(ax; grid=false)
    save("helix.png", fig)
    display(fig)
end