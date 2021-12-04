# AS2018517

library(hexSticker)
library(ggplot2)

# Inserting Image
imgurl <- system.file("figures/image.png", package="hexSticker")
imgurl

# Google Fonts
library(showtext)
## Loading Google fonts (http://www.google.com/fonts)
font_add_google("Otomanopee One", "Open Sans")
## Automatically use showtext to render text for future devices
showtext_auto()

# hexSticker
s4 <- sticker(imgurl, package="sta3262", p_size=15, p_y= 0.63, p_color = "#2874A6",
              h_color ="#2874A6", h_fill =  "black", h_size = 2.5,
              s_x=0.95, s_y=1.2, s_width=1.3, s_height=0.0,
              p_family = "Open Sans", filename="inst/figures/image23.png")
s4
