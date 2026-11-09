"""Play Market uchun 1024x500 feature graphic yaratadi (Pillow kerak).

    python store/make_feature_graphic.py
"""
from PIL import Image, ImageDraw, ImageFont

W, H = 1024, 500
top, bottom = (139, 124, 246), (67, 52, 190)

img = Image.new("RGB", (W, H))
px = img.load()
for y in range(H):
    for x in range(W):
        t = (x / W * 0.6 + y / H * 0.4)
        px[x, y] = tuple(int(top[i] + (bottom[i] - top[i]) * t) for i in range(3))

# Yumshoq dekorativ doiralar
over = Image.new("RGBA", (W, H), (0, 0, 0, 0))
d = ImageDraw.Draw(over)
d.ellipse((620, -140, 1160, 400), fill=(255, 255, 255, 28))
d.ellipse((760, 220, 1120, 580), fill=(255, 200, 87, 46))
img = Image.alpha_composite(img.convert("RGBA"), over)

icon = Image.open("assets/icon/store_512.png").convert("RGBA").resize((220, 220), Image.LANCZOS)
mask = Image.new("L", (220, 220), 0)
ImageDraw.Draw(mask).rounded_rectangle((0, 0, 220, 220), radius=56, fill=255)
img.paste(icon, (90, 140), mask)

draw = ImageDraw.Draw(img)
title = ImageFont.truetype("C:/Windows/Fonts/segoeuib.ttf", 112)
sub = ImageFont.truetype("C:/Windows/Fonts/segoeui.ttf", 38)
draw.text((350, 128), "Utilix", font=title, fill="white")
draw.text((354, 272), "27 tools. 7 languages. Offline.", font=sub, fill=(255, 255, 255, 235))
draw.text((354, 322), "PDF · QR · Calculators · Text · Images", font=sub, fill=(255, 224, 150, 255))

img.convert("RGB").save("store/feature_graphic_1024x500.png")
print("ok")
