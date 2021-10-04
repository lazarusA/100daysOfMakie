using CairoMakie, Random
Random.seed!(113)
n = 100
x = randn(n)
y = cumsum(x) .- minimum(cumsum(x))
leftPoints =  Point2f.(tuple.(1, LinRange(minimum(y), maximum(y),n)))
rightPoints = Point2f.(tuple.(n, LinRange(minimum(y), maximum(y),n)))
fig = Figure(resolution = (600, 400)) 
ax = Axis(fig[1,1])
band!(ax, leftPoints, rightPoints, color = 1:length(leftPoints), 
    colormap = :devon)
band!(ax, 1:n, y, fill(maximum(y), n); color = :white)
lines!(ax, y; color = :grey20)
foreach(ele -> translate!(ax.elements[ele], 0, 0, 9), 
    [:ygridlines, :xgridlines])
save("bandHorizontal.png", fig, px_per_unit = 2)
fig