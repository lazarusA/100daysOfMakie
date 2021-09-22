using GLMakie, LaTeXStrings
x = -1.7:0.05:1.7
y = -1.7:0.05:1.7
z = -1.7:0.05:1.7
set_theme!(theme_dark())
r(i,j,k) = sqrt(i^2 +j^2 + k^2)
fig = Figure(resolution = (1200,600))
for α in 1:3
    axs = Axis3(fig[1,α]; aspect = :data, perspectiveness = 0.5)
    vol = [rand()/r(i,j,k)^(α) for i in x, j in y, k in z]
    volume!(axs, vol, colormap = :thermal, colorrange = (0,1.5), 
        transparency = :true)
    Label(fig[2, α], latexstring("\\sim \\frac{1}{r^{$(α)}}"), 
        tellheight= true, tellwidth = false, textsize = 40)
    hidedecorations!(axs; grid = false)
end
save("volume.png", fig)
fig