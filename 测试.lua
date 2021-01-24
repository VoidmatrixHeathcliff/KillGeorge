UsingMoudle("All")

WINDOW_WIDTH, WINDOW_HEIGHT = 640, 360

CreateWindow(
    "Kill George",
    {
        x = WINDOW_POSITION_DEFAULT,
        y = WINDOW_POSITION_DEFAULT,
        w = WINDOW_WIDTH,
        h = WINDOW_HEIGHT
    },
    {}
)

font = LoadFont("Resource/Font/Silver.ttf", 30)

color_text = {r = 195, g = 195, b = 95, a = 255}

image_text = CreateUTF8TextImageBlended(font, "测试用文字", color_text)

width_image_text, height_image_text = GetImageSize(image_text)

texture_text = CreateTexture(image_text)

while true do

    SetDrawColor({r = 0, g = 0, b = 0, a = 255})
    ClearWindow()

    local _rect = {
        x = 100, y = 100, 
        w = width_image_text, h = height_image_text
    }

    CopyTexture(texture_text, _rect)

    SetDrawColor({r = 195, g = 195, b = 195, a = 200})
    FillRectangle(_rect)

    if UpdateEvent() then
        local _event = GetEventType()
        if _event == EVENT_QUIT then
            break
        end
    end

    UpdateWindow()

end