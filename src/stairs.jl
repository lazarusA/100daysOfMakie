using CairoMakie, SpecialFunctions
p(s, β) = (β + 1)*a(β) * s^β * exp(-a(β)*s^(β+1))
a(β) = gamma(((β + 2)/(β + 1))^(β + 1))
s = LinRange(0,3,30)
colors = ["#FF410D", "#6EE2FF", "#F7C530", "#95CC5E", "#D0DFE6", "#F79D1E"]

with_theme(theme_dark()) do
    fig = Figure(resolution = (600,400))
    ax = Axis(fig[1,1]; palette = (; color = colors))
    for β in [0,1], step in [:pre, :center, :post]
        stairs!(s, p.(s, β), step = step, label = "$(β), :$(step)")
    end
    lines!(s, p.(s, 1), color = :grey90)
    lines!(s, p.(s, 0), color = :grey70)
    text!(L"p(s)=(\beta+1)a_{\beta}\,s^{\beta}\exp(-a_{\beta}s^{\beta+1})", 
        position = (0.7, 0.95), color = :white)
    text!(L"a_{\beta} = \Gamma[(\beta+2)/(\beta+1)]^{\beta + 1}", 
        position = (1.7, 0.25), color = :white)
    axislegend("β, step", position = :rt)
    save("stairs.png", fig, px_per_unit = 2)
    display(fig)
end