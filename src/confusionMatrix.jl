using CairoMakie, MLBase, Random
Random.seed!(123)
# fake data
gt = rand(1:10,1000)
pred = rand(1:10,1000)
data = confusmat(10, gt, pred)
ticks = string.(sort(unique(gt)))
# plot
fig = Figure(resolution = (600, 400))
ax = Axis(fig[1,1]; aspect = 1, ylabel = "Ground truth",
    xlabel = "Prediction")
hmap = heatmap!(ax, data, colormap = :magma)
for i in 1:10, j in 1:10
    txtcolor = data[i,j] < 10 ? :white : :black
    text!(ax, "$(round(data[i,j], digits = 2))", position = (i,j),
        color = txtcolor, align = (:center, :center), textsize = 12)
end
cbar = Colorbar(fig[1,2], hmap, label = "Counts", width = 25,
    halign = :left, ticksize = 25, tickalign = 1,
    height = Relative(3.55/4))
ax.xticks = (1:10, ticks)
ax.yticks = (1:10, ticks)
save("confusionMatrix.png", fig, px_per_unit = 2)
fig