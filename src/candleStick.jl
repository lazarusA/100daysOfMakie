using CairoMakie, Random, Dates, TimeSeries, MarketData, StatsBase
tempo = string.(timestamp(ohlc))
lentime = length(tempo)
slice_dates = range(1, lentime, step = 3)
colors = values(ohlc.Close) .> values(ohlc.Open)
lowV = values(ohlc.Low)
highV = values(ohlc.High)
linesegs = []
for i in 1:lentime
    push!(linesegs, Point2f0(i, lowV[i]))
    push!(linesegs, Point2f0(i, highV[i]))
end
linesegs = Point2f0.(linesegs)
cmap = ((:orangered, 0.85), (:dodgerblue, 0.85))

set_theme!(theme_dark())
fig = Figure(figure_padding = (25,15,60,15), resolution = (600, 400))
ax = Axis(fig[1,1]; xgridstyle=:dash, ygridstyle=:dash)
barplot!(ax, 1:lentime, values(ohlc.Open), fillto = values(ohlc.Close), 
    width = 0.65, color = colors, strokewidth = 0.5, strokecolor = colors, 
    colormap = cmap)
linesegments!(ax, linesegs; linewidth = 3, color = colors, colormap = cmap)
lines!(5:500, values(moving(mean, ohlc.Close, 5)); color = :yellow)
xlims!(ax, 194.5, 225.5)
ylims!(ax, 17,24)
ax.xticks = (slice_dates, tempo[slice_dates])
ax.xticklabelrotation = π/4
save("condleStick.png", fig)
fig