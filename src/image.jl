using GLMakie, TestImages
coffee = testimage("coffee.png")
img = coffee[:, 80:480]
set_theme!(theme_dark())
fig = Figure(resolution = (1200,1200))
ax1 = Axis(fig[1,1])
ax2 = Axis3(fig[1,2]; aspect = (1,1,1), elevation = pi/6,
        perspectiveness = 0.5)
ax3 = Axis3(fig[2,1]; aspect = (1,1,1),
    azimuth = 4.726, elevation = 0.05, perspectiveness = 0.5)
ax4 = Axis3(fig[2,2]; aspect = (1,1,1), elevation = pi/6,
    perspectiveness = 0.5)
image!(ax1, rotr90(img))
image!(ax2, rotr90(img))
mesh!(ax3, Sphere(Point3f(0), 1), color = img)
image!(ax4, rotr90(img); transformation = (:xy, -1))
image!(ax4, rotr90(img); transformation = (:xz, 420))
image!(ax4, rotr90(img); transformation = (:yz, 420))
zlims!(ax4, -1,420)
axs = [ax1, ax2, ax3, ax4]
[hidedecorations!(ax; grid = false) for ax in axs]
colgap!(fig.layout, 0)
rowgap!(fig.layout, 0)
save("image.png", fig)
fig