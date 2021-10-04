using Makie, GLMakie, Random
Random.seed!(3)
# patterns
# `'/'`, `'\\'`, `'-'`, `'|'`, `'x'`, and `'+'`
directions = [Vec2f0(1), Vec2f0(1, -1), Vec2f0(1, 0), Vec2f0(0, 1),
    [Vec2f0(1), Vec2f0(1, -1)], [Vec2f0(1, 0), Vec2f0(0, 1)]]
colors = [:white, :red, (:green, 0.5), :white, (:navy, 0.85),:black]
patterns = [Makie.LinePattern(direction= hatch; width = 5, tilesize=(20,20),
    linecolor = colors[indx], background_color = colors[end-indx+1])
    for (indx, hatch) in enumerate(directions)]
fig = Figure(resolution = (1200,800), fontsize = 32)
ax = Axis(fig[1,1])
for (idx, pattern) in enumerate(patterns)
    barplot!(ax, [idx], [idx*(2rand()+1)], color = pattern, strokewidth = 2)
end
ax.xticks = (1:6, ["/", "\\", "-", "|", "x", "+"])
save("strippedPatterns.png", fig)
fig