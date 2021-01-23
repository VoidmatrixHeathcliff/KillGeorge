UsingMoudle("All")

Timer = require("Timer")
Knapsack = require("Knapsack")

-- 窗口尺寸
WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720

-- 帧率
_FPS_ = 60

-- 创建游戏窗口
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
-- 割草机动画定时器
timer_grasscutter_run = Timer.AddTimer(
    100,
    function()
        animation_GrassCutterRun.index = animation_GrassCutterRun.index % #animation_GrassCutterRun.clips + 1
    end,
    {}
)
-- 玩家默认状态动画定时器
timer_player_idle = Timer.AddTimer(
    200,
    function()
        animation_PlayerIdle.index = animation_PlayerIdle.index % #animation_PlayerIdle.clips + 1
    end,
    {}
)
-- 玩家行走动画定时器
timer_player_walk = Timer.AddTimer(
    100,
    function()
        animation_PlayerWalk.index = animation_PlayerWalk.index % #animation_PlayerWalk.clips + 1
    end,
    {}
)
-- 提示文本颜色
color_tips = {r = 255, g = 204, b = 51, a = 255}

-- 加载字体资源
font_tips = LoadFont("Resource/Font/Silver.ttf", 30)

-- 加载图片资源
image_Background = LoadImage("Resource/Image/Background/level_1_bg_1 - 副本.jpg")
image_GrassCutter_1 = LoadImage("Resource/Image/GrassCutter/1.png")
image_GrassCutter_2 = LoadImage("Resource/Image/GrassCutter/2.png")
image_GrassCutter_3 = LoadImage("Resource/Image/GrassCutter/3.png")
image_Character_Idle_1 = LoadImage("Resource/Image/Character/Player/idle_1.png")
image_Character_Idle_2 = LoadImage("Resource/Image/Character/Player/idle_2.png")
image_Character_Walk_1 = LoadImage("Resource/Image/Character/Player/walk_1.png")
image_Character_Walk_2 = LoadImage("Resource/Image/Character/Player/walk_2.png")
image_Character_Walk_3 = LoadImage("Resource/Image/Character/Player/walk_3.png")
image_Character_Walk_4 = LoadImage("Resource/Image/Character/Player/walk_4.png")
image_Haystack_1 = LoadImage("Resource/Image/Haystack/1.png")
image_Haystack_2 = LoadImage("Resource/Image/Haystack/2.png")
image_Haystack_3 = LoadImage("Resource/Image/Haystack/3.png")
image_Haystack_4 = LoadImage("Resource/Image/Haystack/4.png")
image_Haystack_5 = LoadImage("Resource/Image/Haystack/5.png")
image_Haystack_6 = LoadImage("Resource/Image/Haystack/6.png")
image_Haystack_7 = LoadImage("Resource/Image/Haystack/7.png")
image_Haystack_8 = LoadImage("Resource/Image/Haystack/8.png")
image_Haystack_9 = LoadImage("Resource/Image/Haystack/9.png")
image_Haystack_10 = LoadImage("Resource/Image/Haystack/10.png")
image_Haystack_11 = LoadImage("Resource/Image/Haystack/11.png")
image_George_Idle_1 = LoadImage("Resource/Image/Character/George/idle_1.png")
image_George_Idle_2 = LoadImage("Resource/Image/Character/George/idle_2.png")
image_George_Idle_3 = LoadImage("Resource/Image/Character/George/idle_3.png")
image_George_run_1 = LoadImage("Resource/Image/Character/George/run_1.png")
image_George_run_2 = LoadImage("Resource/Image/Character/George/run_2.png")
image_George_run_3 = LoadImage("Resource/Image/Character/George/run_3.png")
image_George_run_4 = LoadImage("Resource/Image/Character/George/run_4.png")
image_George_run_5 = LoadImage("Resource/Image/Character/George/run_5.png")
image_George_run_6 = LoadImage("Resource/Image/Character/George/run_6.png")

-- 生成背景图片纹理数据
texture_background = CreateTexture(image_Background)

-- 图片尺寸
width_image_Background, height_image_Background = GetImageSize(image_Background)
width_image_GrassCutter, height_image_GrassCutter = GetImageSize(image_GrassCutter_1)
width_image_Player, height_image_Player = GetImageSize(image_Character_Idle_1)
width_image_Haystack, height_image_Haystack = GetImageSize(image_Haystack_1)
width_image_George, height_image_George = GetImageSize(image_George_Idle_1)

-- 割草机运动动画
animation_GrassCutterRun = {
    index = 1,
    clips = {
        CreateTexture(image_GrassCutter_1),
        CreateTexture(image_GrassCutter_2),
        CreateTexture(image_GrassCutter_3),
    },
    rect = {w = width_image_GrassCutter, h = height_image_GrassCutter}
}

-- 玩家静止状态动画
animation_PlayerIdle = {
    index = 1,
    clips = {
        CreateTexture(image_Character_Idle_1),
        CreateTexture(image_Character_Idle_2),
    },
    rect = {w = width_image_Player, h = height_image_Player}
}

-- 玩家行走动画
animation_PlayerWalk = {
    index = 1,
    clips = {
        CreateTexture(image_Character_Walk_1),
        CreateTexture(image_Character_Walk_2),
        CreateTexture(image_Character_Walk_3),
        CreateTexture(image_Character_Walk_4),
    },
    rect = {w = width_image_Player, h = height_image_Player}
}

-- 乔治静止状态动画
animation_GeorgeIdle = {
    index = 1,
    clips = {
        CreateTexture(image_George_Idle_1),
        CreateTexture(image_George_Idle_2),
        CreateTexture(image_George_Idle_3),
    },
    rect = {w = width_image_George, h = height_image_George}
}

-- 乔治行走动画
animation_GeorgeRun = {
    index = 1,
    clips = {
        CreateTexture(image_George_run_1),
        CreateTexture(image_George_run_2),
        CreateTexture(image_George_run_3),
        CreateTexture(image_George_run_4),
        CreateTexture(image_George_run_5),
        CreateTexture(image_George_run_6),
    },
    rect = {w = width_image_George, h = height_image_George}
}

-- 干草堆倒下动画
animation_Haystack = {
    index = 1,
    clips = {
        CreateTexture(image_Haystack_1),
        CreateTexture(image_Haystack_2),
        CreateTexture(image_Haystack_3),
        CreateTexture(image_Haystack_4),
        CreateTexture(image_Haystack_5),
        CreateTexture(image_Haystack_6),
        CreateTexture(image_Haystack_7),
        CreateTexture(image_Haystack_8),
        CreateTexture(image_Haystack_9),
        CreateTexture(image_Haystack_10),
        CreateTexture(image_Haystack_11),
    },
    rect = {w = width_image_Haystack, h = height_image_Haystack}
}

-- 背景图片定位矩形
rect_background = {
    x = 0,
    y = 0,
    w = width_image_Background,
    h = height_image_Background
}

-- 玩家定位矩形
rect_player = {
    -- x = 200,
    x = 4660,
    y = 0,
    w = width_image_Player,
    h = height_image_Player
}

-- 乔治定位矩形
rect_george = {
    x = 5000,
    y = WINDOW_HEIGHT - height_image_George - 15
}

-- 视窗定位矩形
rect_viewport = {
    x = 0,
    y = 0,
    w = WINDOW_WIDTH,
    h = WINDOW_HEIGHT
}

-- 割草机定位矩形
rect_grasscutter = {
    x = 3117,
    y = WINDOW_HEIGHT - 100,
    w = width_image_GrassCutter,
    h = height_image_GrassCutter
}

-- 玩家立绘翻转模式
flipmode_player = FLIP_NONE

-- 割草机图片翻转模式
flipmode_grasscutter = FLIP_NONE

-- 乔治立绘翻转模式
flipmode_george = FLIP_NONE

-- 当前触发器按键回调函数
trigger_handler = function() end

-- 障碍物列表
obstacle_list = {
        -- 割草机附近转弯处
        {
            offset = 35,
            position = {_start = 2920, _corner_1 = 3010, _corner_2 = 3305, _end = 3430}
        },
        -- 喷泉附近转弯处
        {
            offset = 60,
            position = {_start = 4110, _corner_1 = 4215, _corner_2 = 4540, _end = 4660}
        },
}

-- 触发器列表
trigger_list = {
        -- 住宅大门
        door_house = {
            tips = {
                {
                    text = "Z：进入",
                    condition = function() return true end
                }
            },
            position = {isOutside = true, _startX = 430, _endX = 550},
            handler = function(event)
                -- 处理进门
                if event == EVENT_KEYDOWN_Z then
                    Knapsack.AddItem({name = "Battery"})
                -- 判断当前玩家是否手持锁栓，手持则锁门
                elseif event == EVENT_KEYDOWN_C then
                    print("locked!")
                end
            end
        },
        -- 割草机
        grass_cutter = {
            tips = {
                {
                    text = "X：转向",
                    condition = function() return not isMove_grasscutter end
                },
                {
                    text = "Z：启动",
                    condition = function()
                        return Knapsack.ExistItem("Battery")
                    end
                }
            },
            position = {isOutside = true, _startX = 3110, _endX = 3245},
            handler = function(event)
                -- 处理启动割草机
                if event == EVENT_KEYDOWN_Z then
                    if (not isMove_grasscutter) and Knapsack.ExistItem("Battery") and IsTriggerOn(trigger_list.grass_cutter) then
                        isMove_grasscutter = true
                        Knapsack.RemoveItem("Battery")
                    end
                -- 处理割草机转向
                elseif event == EVENT_KEYDOWN_X then
                    if not isMove_grasscutter then
                        if flipmode_grasscutter == FLIP_HORIZONTAL then
                            flipmode_grasscutter = FLIP_NONE
                        else
                            flipmode_grasscutter = FLIP_HORIZONTAL
                        end
                    end
                end
            end
        },
        -- 割草机电池
        battery = {
            tips = {
                {
                    text = "Z：拾取",
                    condition = function()
                        return true
                    end
                }
            },
            position = {isOutside = false, _startX = 0, _startY = 0, _endX = 0, _endY = 0},
            handler = function(event)
                -- 捡起割草机电池
                if event == EVENT_KEYDOWN_Z then
                    Knapsack.AddItem({name = "Battery"})
                end
            end
        }
}

-- 玩家跳跃高度位移
height_addition_list = {
    index = 1,
    values = {-25, -45, -45, -61, -61, -69, -69, -69, -73, -73, -73, -73, -73, -69, -69, -69, -61, -61, -45, -45, -25}
}

-- 玩家移动速度
speed_player = 5

-- 玩家移动方向
isMoveLeft_player, isMoveRight_player = false, false

-- 割草机移动速度
speed_grasscutter = 10

-- 割草机是否启动
isMove_grasscutter = false

-- 玩家是否正在跳跃
isJump_player = false

-- 玩家是否在室外
isPlayerOutside = true

-- 干草垛是否倒下
isHaystackLaid = false

-- 获取当前玩家位置的基础高度
function GetPlayerBaseHeight()
    local _default = nil
    if rect_player.x > 4660 then
        _default = WINDOW_HEIGHT - height_image_Player - 15
    else
        _default = WINDOW_HEIGHT - height_image_Player - 30
    end
    
    for _, obstacle in pairs(obstacle_list) do
        if rect_player.x > obstacle.position._start
            and rect_player.x < obstacle.position._end
        then
            if rect_player.x < obstacle.position._corner_1 then
                return _default - (rect_player.x - obstacle.position._start)
                    * obstacle.offset / (obstacle.position._corner_1 - obstacle.position._start)
            elseif rect_player.x > obstacle.position._corner_2 then
                return _default - obstacle.offset + (rect_player.x - obstacle.position._corner_2)
                    * obstacle.offset / (obstacle.position._end - obstacle.position._corner_2)
            else
                return _default - obstacle.offset
            end
        end
    end
    return _default
end

-- 检测当前位置的玩家是否触发触发器
function IsTriggerOn(trigger)
    if
        isPlayerOutside
        and trigger.position.isOutside
        and (rect_player.x + rect_player.w / 2) >= trigger.position._startX
        and (rect_player.x + rect_player.w / 2) <= trigger.position._endX
    then
        return true
    elseif
    (not isPlayerOutside)
        and (not trigger.position.isOutside)
        and (rect_player.x + rect_player.w / 2) >= trigger.position._startX
        and (rect_player.x + rect_player.w / 2) <= trigger.position._endX
        and (rect_player.y + rect_player.h / 2) >= trigger.position._startY
        and (rect_player.y + rect_player.h / 2) <= trigger.position._endY
    then
        return true
    else
        return false
    end
end

-- 游戏主循环
while true do

    local _start = GetInitTime()
    
    SetDrawColor({r = 200, g = 200, b = 200, a = 255})
    ClearWindow()
    
    Timer.Update()
    
    if UpdateEvent() then
        local _event = GetEventType()
        if _event == EVENT_QUIT then
            break
        elseif _event == EVENT_KEYDOWN_LEFT then
            isMoveLeft_player = true
        elseif _event == EVENT_KEYUP_LEFT then
            isMoveLeft_player = false
        elseif _event == EVENT_KEYDOWN_RIGHT then
            isMoveRight_player = true
        elseif _event == EVENT_KEYUP_RIGHT then
            isMoveRight_player = false
        elseif _event == EVENT_KEYDOWN_UP then
            if not isJump_player then
                isJump_player = true
            end
        end
        
        trigger_handler(_event)
    end
    
    if isMoveLeft_player then
        flipmode_player = FLIP_HORIZONTAL
        rect_player.x = rect_player.x - speed_player
    end
    if isMoveRight_player then
        flipmode_player = FLIP_NONE
        rect_player.x = rect_player.x + speed_player
    end
    
    rect_player.y = GetPlayerBaseHeight()
    if isJump_player then
        if height_addition_list.index < #height_addition_list.values then
            rect_player.y = rect_player.y + height_addition_list.values[height_addition_list.index]
            height_addition_list.index = height_addition_list.index + 1
        else
            isJump_player = false
            height_addition_list.index = 1
        end
    end
    
    if rect_player.x < 0 then rect_player.x = 0 end
    if rect_player.x + rect_player.w > rect_background.x + rect_background.w then
        rect_player.x = rect_background.x + rect_background.w - rect_player.w
    end
    
    rect_viewport.x = rect_player.x + rect_player.w / 2 - rect_viewport.w / 2
    -- rect_viewport.y = rect_player.y - rect_viewport.h / 2
    if rect_viewport.x < 0 then rect_viewport.x = 0 end
    if rect_viewport.x + rect_viewport.w > rect_background.x + rect_background.w then
        rect_viewport.x = rect_background.x + rect_background.w - rect_viewport.w
    end
    -- if rect_viewport.y < 0 then rect_viewport.y = 0 end
    -- if rect_viewport.y + rect_viewport.h > rect_background.h then rect_viewport.y = rect_background.h - rect_viewport.h end
    if isMove_grasscutter then
        if flipmode_grasscutter == FLIP_NONE then
            rect_grasscutter.x = rect_grasscutter.x - speed_grasscutter
        else
            rect_grasscutter.x = rect_grasscutter.x + speed_grasscutter
        end
    end
    
    -- 如果玩家第一次经过干草堆
    if
    (not isHaystackLaid)
        and isPlayerOutside
        and rect_player.x >= 2845
        and rect_player.x <= 2940
    then
        -- 干草垛倒下动画定时器
        isHaystackLaid = true
        timer_haystack_lay = Timer.AddTimer(
            50,
            function()
                if animation_Haystack.index < #animation_Haystack.clips then
                    animation_Haystack.index = animation_Haystack.index + 1
                end
            end,
            {}
    )
    end
    
    -- 显示背景图
    CopyReshapeTexture(
        texture_background,
        rect_viewport,
        {
            x = 0,
            y = 0,
            w = WINDOW_WIDTH,
            h = WINDOW_HEIGHT
        }
    )
    -- 绘制干草堆部分
    CopyTexture(
        animation_Haystack.clips[animation_Haystack.index],
        {
            x = 2725 - rect_viewport.x,
            y = 500 - rect_viewport.y,
            w = animation_Haystack.rect.w,
            h = animation_Haystack.rect.h
        }
    )
    -- 显示人物立绘
    if isJump_player then
        CopyRotateTexture(
            animation_PlayerWalk.clips[1],
            0,
            {
                x = rect_player.x + rect_player.w / 2,
                y = rect_player.y + rect_player.h / 2
            },
            {flipmode_player},
            {
                x = rect_player.x - rect_viewport.x,
                y = rect_player.y - rect_viewport.y,
                w = rect_player.w,
                h = rect_player.h
            }
    )
    elseif isMoveLeft_player or isMoveRight_player then
        CopyRotateTexture(
            animation_PlayerWalk.clips[animation_PlayerWalk.index],
            0,
            {
                x = rect_player.x + rect_player.w / 2,
                y = rect_player.y + rect_player.h / 2
            },
            {flipmode_player},
            {
                x = rect_player.x - rect_viewport.x,
                y = rect_player.y - rect_viewport.y,
                w = rect_player.w,
                h = rect_player.h
            }
    )
    else
        CopyRotateTexture(
            animation_PlayerIdle.clips[animation_PlayerIdle.index],
            0,
            {
                x = rect_player.x + rect_player.w / 2,
                y = rect_player.y + rect_player.h / 2
            },
            {flipmode_player},
            {
                x = rect_player.x - rect_viewport.x,
                y = rect_player.y - rect_viewport.y,
                w = rect_player.w,
                h = rect_player.h
            }
    )
    end
    
    -- 如果割草机正在移动则渲染动态帧序列
    if isMove_grasscutter then
        CopyRotateTexture(
            animation_GrassCutterRun.clips[animation_GrassCutterRun.index],
            0,
            {
                x = rect_grasscutter.x + rect_grasscutter.w / 2,
                y = rect_grasscutter.y + rect_grasscutter.h / 2
            },
            {flipmode_grasscutter},
            {
                x = rect_grasscutter.x - rect_viewport.x,
                y = rect_grasscutter.y - rect_viewport.y,
                w = animation_GrassCutterRun.rect.w,
                h = animation_GrassCutterRun.rect.h
            }
    )
    -- 否则渲染静态帧
    else
        CopyRotateTexture(
            animation_GrassCutterRun.clips[3],
            0,
            {
                x = rect_grasscutter.x + rect_grasscutter.w / 2,
                y = rect_grasscutter.y + rect_grasscutter.h / 2
            },
            {flipmode_grasscutter},
            {
                x = rect_grasscutter.x - rect_viewport.x,
                y = rect_grasscutter.y - rect_viewport.y,
                w = animation_GrassCutterRun.rect.w,
                h = animation_GrassCutterRun.rect.h
            }
    )
    end
    
    -- 检测触发器
    trigger_handler = function() end
    for _, trigger in pairs(trigger_list) do
        if IsTriggerOn(trigger) then
            -- 显示提示信息
            for index, tip in ipairs(trigger.tips) do
                if tip.condition() then
                    local _image = CreateUTF8TextImageBlended(font_tips, tip.text, color_tips)
                    local _texture = CreateTexture(_image)
                    local _width, _height = GetImageSize(_image)
                    local _rect = {
                        x = rect_player.x + rect_player.w / 2 - _width / 2 - rect_viewport.x,
                        y = rect_player.y - _height * index - rect_viewport.y,
                        w = _width,
                        h = _height
                    }
                    CopyTexture(_texture, _rect)
                    DestroyTexture(_texture)
                    UnloadImage(_image)
                end
            end
            -- 设置当前按键回调为此触发器回调函数
            trigger_handler = trigger.handler
        end
    end
    
    UpdateWindow()
    
    local _end = GetInitTime()
    
    if _end - _start < 1000 / _FPS_ then
        Sleep(1000 / _FPS_ - (_end - _start))
    end

end
