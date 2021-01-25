UsingMoudle("All")

Timer = require("Timer")
Knapsack = require("Knapsack")

-- 窗口尺寸
WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720

-- 帧率
_FPS_ = 144

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

-- 玩家位移定时器
timer_player_move = Timer.AddTimer(
    1000 / 60,
    function()
        if (not isHidden_player) and isMoveLeft_player then
            flipmode_player = FLIP_HORIZONTAL
            rect_player.x = rect_player.x - speed_player
        end
        if (not isHidden_player) and isMoveRight_player then
            flipmode_player = FLIP_NONE
            rect_player.x = rect_player.x + speed_player
        end
        rect_player.y = GetBaseHeight(rect_player)
        if isJump_player then
            if height_addition_list.index < #height_addition_list.values then
                rect_player.y = rect_player.y + height_addition_list.values[height_addition_list.index]
                height_addition_list.index = height_addition_list.index + 1
            else
                isJump_player = false
                height_addition_list.index = 1
        end
    end
    end,
    {}
)

-- 乔治位移定时器
timer_george_move = Timer.AddTimer(
    1000 / 60,
    function()
        -- 在乔治默认状态下，根据当前乔治行动修改其位置
        if isGeorgeIdle and states_george_idle.values[states_george_idle.index].state == "Walking" then
            if states_george_idle.toward == "Right" then
                rect_george.x = rect_george.x + speed_george
                if rect_george.x > 5300 then 
                    rect_george.x = 5300
                    states_george_idle.toward = "Left"
                    flipmode_george = FLIP_HORIZONTAL
                end
            else
                rect_george.x = rect_george.x - speed_george
                if rect_george.x < 4900 then 
                    rect_george.x = 4900
                    states_george_idle.toward = "Right"
                    flipmode_george = FLIP_NONE
                end
            end
        elseif (not isGeorgeIdle) and hp_george > 0 then
            if 
                rect_george.x >= (trigger_list.door_house.position._startX + trigger_list.door_house.position._endX) / 2 
            then
                rect_george.x = rect_george.x - speed_george
            else
                isGeorgeOutside = false
            end
        end

        -- 乔治默认状态下行动状态切换计时
        if states_george_idle.timer >= states_george_idle.values[states_george_idle.index].delay then
            states_george_idle.index = states_george_idle.index % #states_george_idle.values + 1
            states_george_idle.timer = 0
        else
            states_george_idle.timer = states_george_idle.timer + 1
        end

        rect_george.y = GetBaseHeight(rect_george)
    end,
    {}
)

-- 割草机位移定时器
timer_grasscutter_move = Timer.AddTimer(
    1000 / 60,
    function()
        if isMove_grasscutter then
            if flipmode_grasscutter == FLIP_NONE then
                rect_grasscutter.x = rect_grasscutter.x - speed_grasscutter
            else
                rect_grasscutter.x = rect_grasscutter.x + speed_grasscutter
            end
        end
    end,
    {}
)

-- 背景图片动画定时器
timer_background = Timer.AddTimer(
    450,
    function()
        animation_Background.index = animation_Background.index % #animation_Background.clips + 1
    end,
    {}
)

-- 云图片动画定时器
timer_cloud = Timer.AddTimer(
    45,
    function()
        if rect_cloud_cut_1.w <= width_image_Cloud then
            rect_cloud_cut_1.w = rect_cloud_cut_1.w + 1
        else
            rect_cloud_cut_1.w = 0
        end
    end,
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

-- 乔治默认状态动画定时器
timer_george_idle = Timer.AddTimer(
    150,
    function()
        animation_GeorgeIdle.index = animation_GeorgeIdle.index % #animation_GeorgeIdle.clips + 1
    end,
    {}
)

-- 乔治奔跑状态动画定时器
timer_george_run = Timer.AddTimer(
    150,
    function()
        animation_GeorgeRun.index = animation_GeorgeRun.index % #animation_GeorgeRun.clips + 1
    end,
    {}
)

-- 雕像动画定时器
timer_statue = Timer.AddTimer(
    400,
    function()
        animation_Statue.index = animation_Statue.index % #animation_Statue.clips + 1
    end,
    {}
)

-- 喷泉动画定时器
timer_statue = Timer.AddTimer(
    100,
    function()
        animation_Fountain.index = animation_Fountain.index % #animation_Fountain.clips + 1
    end,
    {}
)

-- 花圃动画定时器
timer_fountain = Timer.AddTimer(
    550,
    function()
        animation_FlowerBed.index = animation_FlowerBed.index % #animation_FlowerBed.clips + 1
    end,
    {}
)

-- 前草动画定时器
timer_frontgrass = Timer.AddTimer(
    450,
    function()
        animation_FrontGrass.index = animation_FrontGrass.index % #animation_FrontGrass.clips + 1
    end,
    {}
)

-- 花盆动画定时器
timer_flowerpot = Timer.AddTimer(
    450,
    function()
        animation_Flowerpot.index = animation_Flowerpot.index % #animation_Flowerpot.clips + 1
    end,
    {}
)

-- 开关门动画定时器
timer_irondoor = Timer.AddTimer(
    250,
    function()
        animation_IronGate.index = animation_IronGate.index % #animation_IronGate.clips + 1
    end,
    {}
)

-- 提示文本颜色
color_tips = {r = 255, g = 204, b = 51, a = 255}

-- 加载字体资源
font_tips = LoadFont("Resource/Font/Silver.ttf", 30)

-- 加载图片资源
image_Background_1 = LoadImage("Resource/Image/Background/level_1_bg_1.png")
image_Background_2 = LoadImage("Resource/Image/Background/level_1_bg_2.png")
image_Background_3 = LoadImage("Resource/Image/Background/level_1_bg_3.png")
image_Background_4 = LoadImage("Resource/Image/Background/level_1_bg_4.png")
image_Background_5 = LoadImage("Resource/Image/Background/level_1_bg_5.png")
image_Background_6 = LoadImage("Resource/Image/Background/level_1_bg_6.png")
image_Background_7 = LoadImage("Resource/Image/Background/level_1_bg_7.png")
image_Background_8 = LoadImage("Resource/Image/Background/level_1_bg_8.png")
image_Background_9 = LoadImage("Resource/Image/Background/level_1_bg_9.png")
image_Background_10 = LoadImage("Resource/Image/Background/level_1_bg_10.png")
image_Background_11 = LoadImage("Resource/Image/Background/level_1_bg_11.png")
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
image_George_Idle_1 = LoadImage("Resource/Image/Character/George/idle_1.png")
image_George_Idle_2 = LoadImage("Resource/Image/Character/George/idle_2.png")
image_George_Idle_3 = LoadImage("Resource/Image/Character/George/idle_3.png")
image_George_run_1 = LoadImage("Resource/Image/Character/George/run_1.png")
image_George_run_2 = LoadImage("Resource/Image/Character/George/run_2.png")
image_George_run_3 = LoadImage("Resource/Image/Character/George/run_3.png")
image_George_run_4 = LoadImage("Resource/Image/Character/George/run_4.png")
image_George_run_5 = LoadImage("Resource/Image/Character/George/run_5.png")
image_George_run_6 = LoadImage("Resource/Image/Character/George/run_6.png")
image_Statue_1 = LoadImage("Resource/Image/Statue/1.png")
image_Statue_2 = LoadImage("Resource/Image/Statue/2.png")
image_Fountain_1 = LoadImage("Resource/Image/Fountain/1.png")
image_Fountain_2 = LoadImage("Resource/Image/Fountain/2.png")
image_Fountain_3 = LoadImage("Resource/Image/Fountain/3.png")
image_Fountain_4 = LoadImage("Resource/Image/Fountain/4.png")
image_IronGateWall = LoadImage("Resource/Image/IronGate/Wall.png")
image_IronGate_1 = LoadImage("Resource/Image/IronGate/1.png")
image_IronGate_2 = LoadImage("Resource/Image/IronGate/2.png")
image_IronGate_3 = LoadImage("Resource/Image/IronGate/3.png")
image_IronGate_4 = LoadImage("Resource/Image/IronGate/4.png")
image_FlowerBed_1 = LoadImage("Resource/Image/FlowerBed/1.png")
image_FlowerBed_2 = LoadImage("Resource/Image/FlowerBed/2.png")
image_FlowerBed_3 = LoadImage("Resource/Image/FlowerBed/3.png")
image_Shadow = LoadImage("Resource/Image/Shadow/1.png")
image_FrontGrass_1 = LoadImage("Resource/Image/FrontGrass/1.png")
image_FrontGrass_2 = LoadImage("Resource/Image/FrontGrass/2.png")
image_FrontGrass_3 = LoadImage("Resource/Image/FrontGrass/3.png")
image_Ground = LoadImage("Resource/Image/Ground/level_1_ground_1.png")
image_Sky = LoadImage("Resource/Image/Sky/1.png")
image_Cloud = LoadImage("Resource/Image/Cloud/1.png")
image_Flowerpot_1 = LoadImage("Resource/Image/Flowerpot/1.png")
image_Flowerpot_2 = LoadImage("Resource/Image/Flowerpot/2.png")
image_Flowerpot_3 = LoadImage("Resource/Image/Flowerpot/3.png")
image_StreetLamp = LoadImage("Resource/Image/StreetLamp/1.png")
image_Crow_1 = LoadImage("Resource/Image/Crow/1.png")
image_Crow_2 = LoadImage("Resource/Image/Crow/2.png")
image_Crow_3 = LoadImage("Resource/Image/Crow/3.png")
image_Crow_4 = LoadImage("Resource/Image/Crow/4.png")
image_Crow_5 = LoadImage("Resource/Image/Crow/5.png")

-- 生成图片纹理数据
texture_IronGateWall = CreateTexture(image_IronGateWall)
texture_Shadow = CreateTexture(image_Shadow)
texture_Ground = CreateTexture(image_Ground)
texture_Sky = CreateTexture(image_Sky)
texture_Cloud = CreateTexture(image_Cloud)
texture_StreetLamp = CreateTexture(image_StreetLamp)

-- 设置阴影图片透明度
SetTextureAlpha(texture_Shadow, 200)

-- 图片尺寸
width_image_Background, height_image_Background = GetImageSize(image_Background_1)
width_image_Ground, height_image_Ground = GetImageSize(image_Ground)
width_image_GrassCutter, height_image_GrassCutter = GetImageSize(image_GrassCutter_1)
width_image_Player, height_image_Player = GetImageSize(image_Character_Idle_1)
width_image_Haystack, height_image_Haystack = GetImageSize(image_Haystack_1)
width_image_George, height_image_George = GetImageSize(image_George_Idle_1)
width_image_Statue, height_image_Statue = GetImageSize(image_Statue_1)
width_image_Fountain, height_image_Fountain = GetImageSize(image_Fountain_1)
width_image_IronGateWall, height_image_IronGateWall = GetImageSize(image_IronGateWall)
width_image_FlowerBed, height_image_FlowerBed = GetImageSize(image_FlowerBed_1)
width_image_Shadow, height_image_Shadow = GetImageSize(image_Shadow)
width_image_FrontGrass, height_image_FrontGrass = GetImageSize(image_FrontGrass_1)
width_image_Sky, height_image_Sky = GetImageSize(image_Sky)
width_image_Cloud, height_image_Cloud = GetImageSize(image_Cloud)
width_image_Flowerpot, height_image_Flowerpot = GetImageSize(image_Flowerpot_1)
width_image_StreetLamp, height_image_StreetLamp = GetImageSize(image_StreetLamp)
width_image_Crow, height_image_Crow = GetImageSize(image_Crow_1)
width_image_IronGate, height_image_IronGate = GetImageSize(image_IronGate_1)

-- 背景图片动画
animation_Background = {
    index = 1,
    clips = {
        CreateTexture(image_Background_1),
        CreateTexture(image_Background_2),
        CreateTexture(image_Background_3),
        CreateTexture(image_Background_4),
        CreateTexture(image_Background_5),
        CreateTexture(image_Background_6),
        CreateTexture(image_Background_7),
        CreateTexture(image_Background_8),
        CreateTexture(image_Background_9),
        CreateTexture(image_Background_10),
        CreateTexture(image_Background_11),
    },
    rect = {w = width_image_Background, h = height_image_Background}
}

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
    },
    rect = {w = width_image_Haystack, h = height_image_Haystack}
}

-- 开关门动画
animation_IronGate = {
    index = 1,
    clips = {
        CreateTexture(image_IronGate_1),
        CreateTexture(image_IronGate_2),
        CreateTexture(image_IronGate_3),
        CreateTexture(image_IronGate_4),
    },
    rect = {w = width_image_IronGate, h = height_image_IronGate}
}

-- 雕像动画
animation_Statue = {
    index = 1,
    clips = {
        CreateTexture(image_Statue_1),
        CreateTexture(image_Statue_2),
    },
    rect = {w = width_image_Statue, h = height_image_Statue}
}

-- 喷泉动画
animation_Fountain = {
    index = 1,
    clips = {
        CreateTexture(image_Fountain_1),
        CreateTexture(image_Fountain_2),
        CreateTexture(image_Fountain_3),
        CreateTexture(image_Fountain_4),
    },
    rect = {w = width_image_Fountain, h = height_image_Fountain}
}

-- 设置喷泉纹理透明度
for _, texture in pairs(animation_Fountain.clips) do
    SetTextureAlpha(texture, 200)
end 

-- 花圃动画
animation_FlowerBed = {
    index = 1,
    clips = {
        CreateTexture(image_FlowerBed_1),
        CreateTexture(image_FlowerBed_2),
        CreateTexture(image_FlowerBed_3),
    },
    rect = {w = width_image_FlowerBed, h = height_image_FlowerBed}
}

-- 前草动画
animation_FrontGrass = {
    index = 1,
    clips = {
        CreateTexture(image_FrontGrass_1),
        CreateTexture(image_FrontGrass_2),
        CreateTexture(image_FrontGrass_3),
    },
    rect = {w = width_image_FrontGrass, h = height_image_FrontGrass}
}

-- 花盆动画
animation_Flowerpot = {
    index = 1,
    clips = {
        CreateTexture(image_Flowerpot_1),
        CreateTexture(image_Flowerpot_2),
        CreateTexture(image_Flowerpot_3),
    },
    rect = {w = width_image_Flowerpot, h = height_image_Flowerpot}
}

-- 乌鸦动画
animation_Crow = {
    index = 1,
    clips = {
        CreateTexture(image_Crow_1),
        CreateTexture(image_Crow_2),
        CreateTexture(image_Crow_3),
        CreateTexture(image_Crow_4),
        CreateTexture(image_Crow_5),
    },
    rect = {w = width_image_Crow, h = height_image_Crow}
}

-- 默认状态下乔治行动状态列表
states_george_idle = {
    index = 1,
    timer = 0,
    toward = "Right",
    values = {}
}

-- 随机初始化乔治默认状态下行动
for i = 1, 50 do
    table.insert(states_george_idle.values, {
        state = "Walking",
        delay = math.random(180, 400)
    })
    table.insert(states_george_idle.values, {
        state = "Working",
        delay = math.random(240, 480)
    })
end

-- 乔治生命值
hp_george = 50

-- 玩家生命值
hp_player = 50

-- 玩家基础伤害
damage_base_player = 5

-- 背景图片定位矩形
rect_background = {
    x = 0,
    y = 0,
    w = width_image_Background,
    h = height_image_Background
}

-- 云图片渲染相关矩形
rect_cloud_cut_1 = {
    x = 0, 
    y = 0,
    w = 0,
    h = height_image_Cloud
}
rect_cloud_cut_2 = {
    x = rect_cloud_cut_1.w,
    y = 0,
    w = width_image_Cloud - rect_cloud_cut_1.w,
    h = height_image_Cloud
}

-- 玩家定位矩形
rect_player = {
    x = 200,
    -- x = 3430,
    y = 0,
    w = width_image_Player,
    h = height_image_Player
}

-- 乔治定位矩形
rect_george = {
    x = 5000,
    y = WINDOW_HEIGHT - height_image_George - 20,
    w = width_image_George,
    h = height_image_George
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
        offset = 45,
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
                },
                {
                    text = "X：锁门",
                    condition = function()
                        return Knapsack.GetItem(index_holding).name == "Bolt"
                    end
                }
            },
            position = {isOutside = true, _startX = 430, _endX = 550},
            handler = function(event)
                -- 处理进门
                if event == EVENT_KEYDOWN_Z then
                    Knapsack.AddItem({name = "Battery", damage = damage_base_player})
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
                    Knapsack.AddItem({name = "Battery", damage = damage_base_player})
                end
            end
        },
        -- 可躲藏草丛
        grass = {
            tips = {
                {
                    text = "Z：躲藏",
                    condition = function()
                        return not isHidden_player
                    end
                },
                {
                    text = "Z：跳出",
                    condition = function()
                        return isHidden_player
                    end
                }
            },
            position = {isOutside = true, _startX = 1850, _endX = 1970},
            handler = function(event)
                if event == EVENT_KEYDOWN_Z then
                    isHidden_player = not isHidden_player
                    if isHidden_player then
                        num_playerhidden = num_playerhidden + 1
                        rect_player.x = 1890
                    end
                end
            end
        }
}

-- 玩家跳跃高度位移
height_addition_list = {
    index = 1,
    values = {
        -25, -45, -45, -61, -61, -69, -69, -69, -73, -73, 
        -73,
        -73, -73, -69, -69, -69, -61, -61, -45, -45, -25
    }
}

-- 玩家移动速度
speed_player = 5

-- 乔治移动速度
speed_george = 1

-- 玩家移动方向
isMoveLeft_player, isMoveRight_player = false, false

-- 割草机移动速度
speed_grasscutter = 10

-- 割草机是否启动
isMove_grasscutter = false

-- 玩家是否正在跳跃
isJump_player = false

-- 玩家是否正在躲藏
isHidden_player = false

-- 玩家是否在室外
isPlayerOutside = true

-- 乔治是否在室外
isGeorgeOutside = true

-- 乔治是否处于默认状态
isGeorgeIdle = true

-- 干草垛是否倒下
isHaystackLaid = false

-- 乌鸦是否飞起
isCrowFlew = false

-- 玩家背包是否显示
isShowingKnapsack = false

-- 玩家手持物品索引
index_holding = 1

-- 玩家进入草丛次数
num_playerhidden = 0

-- 铁栓是否掉落
isBoltDropped = false

-- 玩家脚底阴影缩放比率
ratio_shadow = 1

-- 铁门是否打开
isIronGateOpen = true

-- 获取当前玩家位置的基础高度
function GetBaseHeight(rect)
    local _default = nil
    if isHidden_player and rect == rect_player then
        return 535
    end
    if rect.x > 4660 then
        _default = WINDOW_HEIGHT - height_image_Player - 15
    else
        _default = WINDOW_HEIGHT - height_image_Player - 30
    end
    for _, obstacle in pairs(obstacle_list) do
        if rect.x > obstacle.position._start
            and rect.x < obstacle.position._end
        then
            if rect.x < obstacle.position._corner_1 then
                speed_player = 4
                return _default - (rect.x - obstacle.position._start)
                    * obstacle.offset / (obstacle.position._corner_1 - obstacle.position._start)
            elseif rect.x > obstacle.position._corner_2 then
                speed_player = 4
                return _default - obstacle.offset + (rect.x - obstacle.position._corner_2)
                    * obstacle.offset / (obstacle.position._end - obstacle.position._corner_2)
            else
                speed_player = 5
                return _default - obstacle.offset
            end
        end
    end
    speed_player = 5
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

-- 绘制玩家背包内容
function DrawKnapsack()
    local _size_cell = 25
    local _size_border = 3
    local _rect_knapsack = {
        x = rect_player.x + rect_player.w / 2 - 
            (Knapsack.GetMaxSpace() * (_size_cell + _size_border) + _size_border) / 2 - rect_viewport.x,
        y = rect_player.y - (_size_cell + _size_border * 2) - 10 - rect_viewport.y,
        w = Knapsack.GetMaxSpace() * (_size_cell + _size_border) + _size_border,
        h = _size_cell + _size_border * 2
    }
    SetDrawColor({r = 200, g = 200, b = 200, a = 200})
    FillRectangle(_rect_knapsack)
    SetDrawColor({r = 178, g = 223, b = 238, a = 225})
    FillRectangle({
        x = _rect_knapsack.x + _size_border * index_holding + _size_cell * (index_holding - 1) - 2,
        y = _rect_knapsack.y + _size_border - 2,
        w = _size_cell + 4,
        h = _size_cell + 4
    })
    SetDrawColor({r = 125, g = 125, b = 125, a = 175})
    for i = 1, Knapsack.GetMaxSpace() do
        FillRectangle({
            x = _rect_knapsack.x + _size_border * i + _size_cell * (i - 1),
            y = _rect_knapsack.y + _size_border,
            w = _size_cell,
            h = _size_cell
        })
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
        elseif 
            _event == EVENT_KEYDOWN_LEFT 
            or _event == EVENT_KEYDOWN_A
        then
            isMoveLeft_player = true
        elseif 
            _event == EVENT_KEYUP_LEFT 
            or _event == EVENT_KEYUP_A
        then
            isMoveLeft_player = false
        elseif 
            _event == EVENT_KEYDOWN_RIGHT 
            or _event == EVENT_KEYDOWN_D
        then
            isMoveRight_player = true
        elseif 
            _event == EVENT_KEYUP_RIGHT
            or _event == EVENT_KEYUP_D
        then
            isMoveRight_player = false
        elseif 
            _event == EVENT_KEYDOWN_UP
            or _event == EVENT_KEYDOWN_W
        then
            if (not isJump_player) and (not isHidden_player) then
                isJump_player = true
            end
        elseif _event == EVENT_KEYDOWN_SPACE then
            isShowingKnapsack = not isShowingKnapsack
        elseif 
            _event == EVENT_KEYDOWN_LEFTCTRL
            or _event == EVENT_KEYDOWN_RIGHTCTRL
        then
            index_holding = index_holding % Knapsack.GetMaxSpace() + 1
        elseif _event == EVENT_KEYDOWN_ENTER then
            isIronGateOpen = not isIronGateOpen
        elseif _event == EVENT_KEYDOWN_C then
            -- 如果乔治生命值低于50%，乔治将反击玩家导致玩家跌倒
            if hp_george < 0.5 * hp_george then

---------------------------------------------------------------------------------------------------------
            
            end
            -- 若玩家位于乔治身边且面向乔治按下C键，则对乔治造成伤害
            if 
                math.abs(rect_player.x - rect_george.x) <= 50 
                and (
                    (rect_player.x < rect_george.x and flipmode_player == FLIP_NONE)
                    or (rect_player.x > rect_george.x and flipmode_player == FLIP_HORIZONTAL)
                )
            then
                isGeorgeIdle = false
                speed_george = speed_player - 0.2
                hp_george = hp_george - (Knapsack.GetItem(index_holding).damage or damage_base_player)
            end
        end
        
        trigger_handler(_event)
    end
    
    if rect_player.x < 0 then rect_player.x = 0 end
    if rect_player.x + rect_player.w > rect_background.x + rect_background.w then
        rect_player.x = rect_background.x + rect_background.w - rect_player.w
    end
    
    rect_viewport.x = rect_player.x + rect_player.w / 2 - rect_viewport.w / 2
    if rect_viewport.x < 0 then rect_viewport.x = 0 end
    if rect_viewport.x + rect_viewport.w > rect_background.x + rect_background.w then
        rect_viewport.x = rect_background.x + rect_background.w - rect_viewport.w
    end
    
    -- 如果玩家躲入草丛的次数为5次
    if num_playerhidden == 5 and (not isBoltDropped) then
        print("Generate !")
        isBoltDropped = true
    end

    -- 如果玩家第一次经过干草堆
    if
    (not isHaystackLaid)
        and isPlayerOutside
        and rect_player.x >= 2705
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

    -- 如果干草堆完全倒下
    if (not isCrowFlew) and animation_Haystack.index == #animation_Haystack.clips then
        isCrowFlew = true
        timer_crow_fly = Timer.AddTimer(
            150,
            function()
                if animation_Crow.index < #animation_Crow.clips + 1 then
                    animation_Crow.index = animation_Crow.index + 1
                end
            end,
            {}
        )
    end

    -- 绘制天空图片
    CopyReshapeTexture(
        texture_Sky,
        rect_viewport,
        {
            x = 0,
            y = 0,
            w = rect_viewport.w,
            h = height_image_Sky
        }
    )

    -- 绘制云图片
    rect_cloud_cut_2 = {
        x = rect_cloud_cut_1.w,
        y = 0,
        w = width_image_Cloud - rect_cloud_cut_1.w,
        h = height_image_Cloud
    }
    CopyReshapeTexture(
        texture_Cloud,
        rect_cloud_cut_2,
        {
            x = 0,
            y = -14,
            w = rect_cloud_cut_2.w,
            h = rect_cloud_cut_2.h
        }
    )
    CopyReshapeTexture(
        texture_Cloud,
        rect_cloud_cut_1,
        {
            x = rect_cloud_cut_2.w,
            y = -14,
            w = rect_cloud_cut_1.w,
            h = rect_cloud_cut_1.h
        }
    )

    -- 绘制地面图片
    CopyReshapeTexture(
        texture_Ground,
        rect_viewport,
        {
            x = 0,
            y = rect_viewport.h - height_image_Ground,
            w = rect_viewport.w,
            h = height_image_Ground
        }
    )

    -- 绘制背景图片
    CopyReshapeTexture(
        animation_Background.clips[animation_Background.index],
        rect_viewport,
        {
            x = 0,
            y = 0,
            w = rect_viewport.w,
            h = rect_viewport.h
        }
    )

    -- 如果乌鸦动画未播放完毕则绘制乌鸦图片
    if animation_Crow.index <= #animation_Crow.clips then
        CopyTexture(
            animation_Crow.clips[animation_Crow.index],
            {
                x = 2355 - rect_viewport.x,
                y = 45 - rect_viewport.y,
                w = animation_Crow.rect.w,
                h = animation_Crow.rect.h
            }
        )
    end 

    -- 绘制花盆
    CopyTexture(
        animation_Flowerpot.clips[animation_Flowerpot.index],
        {
            x = 3060 - rect_viewport.x,
            y = 530 - rect_viewport.y,
            w = animation_Flowerpot.rect.w,
            h = animation_Flowerpot.rect.h
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

    -- 渲染玩家脚底阴影
    if not isHidden_player then
        if isJump_player then
            ratio_shadow = 0.7
        else
            ratio_shadow = 1
        end
        CopyTexture(
            texture_Shadow,
            {
                x = rect_player.x + rect_player.w / 2 - width_image_Shadow * ratio_shadow / 2 - rect_viewport.x,
                y = GetBaseHeight(rect_player) + rect_player.h - 15 - rect_viewport.y,
                w = width_image_Shadow * ratio_shadow,
                h = height_image_Shadow
            }
        )
    end

    -- 渲染乔治脚底阴影
    if 
        (isPlayerOutside and isGeorgeOutside) 
        and ((not isPlayerOutside) and (not isGeorgeOutside)) 
    then
        CopyTexture(
            texture_Shadow,
            {
                x = rect_george.x + rect_george.w / 2 - width_image_Shadow / 2 - 5 - rect_viewport.x,
                y = GetBaseHeight(rect_george) + rect_george.h - 15 - rect_viewport.y,
                w = width_image_Shadow,
                h = height_image_Shadow
            }
        )
    end
    
    -- 如果没有躲避优先绘制前草动画
    if not isHidden_player then
        CopyTexture(
            animation_FrontGrass.clips[animation_FrontGrass.index],
            {
                x = 1870 - rect_viewport.x,
                y = 438 - rect_viewport.y,
                w = animation_FrontGrass.rect.w,
                h = animation_FrontGrass.rect.h
            }
        )
    end
    
    -- 如果铁门打开
    if isIronGateOpen then
        CopyTexture(
            animation_IronGate.clips[4],
            {
                x = 3684 - rect_viewport.x,
                y = 515 - rect_viewport.y,
                w = animation_IronGate.rect.w,
                h = animation_IronGate.rect.h
            }
        )
    end

    -- 显示玩家立绘
    if isHidden_player then
        CopyTexture(
            animation_PlayerIdle.clips[1],
            {
                x = 1890 - rect_viewport.x,
                y = 540 - rect_viewport.y,
                w = rect_player.w,
                h = rect_player.h
            }
        )
    else
        if isJump_player then
            CopyRotateTexture(
                animation_PlayerWalk.clips[2],
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
    end

    
    -- 显示乔治死亡状态立绘
    if hp_george <= 0 then
        print("die")
    -- 显示乔治默认状态立绘
    elseif isGeorgeOutside then
        if isGeorgeIdle then
            CopyRotateTexture(
                animation_GeorgeIdle.clips[animation_GeorgeIdle.index],
                0,
                {
                    x = rect_george.x + rect_george.w / 2,
                    y = rect_george.y + rect_george.h / 2
                },
                {flipmode_george},
                {
                    x = rect_george.x - rect_viewport.x,
                    y = rect_george.y - rect_viewport.y,
                    w = rect_george.w,
                    h = rect_george.h
                }
            )
        -- 显示乔治奔跑状态立绘
        elseif (not isGeorgeIdle) and hp_george > 0 then
            CopyRotateTexture(
                animation_GeorgeRun.clips[animation_GeorgeRun.index],
                0,
                {
                    x = rect_george.x + rect_george.w / 2,
                    y = rect_george.y + rect_george.h / 2
                },
                {FLIP_HORIZONTAL},
                {
                    x = rect_george.x - rect_viewport.x,
                    y = rect_george.y - rect_viewport.y,
                    w = rect_george.w,
                    h = rect_george.h
                }
            )
        end
    end

    -- 如果正在躲避稍后绘制前草动画
    if isHidden_player then
        CopyTexture(
            animation_FrontGrass.clips[animation_FrontGrass.index],
            {
                x = 1870 - rect_viewport.x,
                y = 438 - rect_viewport.y,
                w = animation_FrontGrass.rect.w,
                h = animation_FrontGrass.rect.h
            }
        )
    end

    -- 如果显示玩家背包则渲染玩家背包
    if isShowingKnapsack then
        DrawKnapsack()
    end

    -- 检测触发器
    trigger_handler = function() end
    for _, trigger in pairs(trigger_list) do
        if IsTriggerOn(trigger) then
            if not isShowingKnapsack then
                -- 显示提示信息
                local _showing_index = 1
                for _, tip in ipairs(trigger.tips) do
                    if tip.condition() then
                        local _image = CreateUTF8TextImageBlended(font_tips, tip.text, color_tips)
                        local _texture = CreateTexture(_image)
                        local _width, _height = GetImageSize(_image)
                        local _rect = {
                            x = rect_player.x + rect_player.w / 2 - _width / 2 - rect_viewport.x,
                            y = rect_player.y - _height * _showing_index - rect_viewport.y,
                            w = _width,
                            h = _height
                        }
                        CopyTexture(_texture, _rect)
                        DestroyTexture(_texture)
                        UnloadImage(_image)
                        _showing_index = _showing_index + 1
                    end
                end
            end
            -- 设置当前按键回调为此触发器回调函数
            trigger_handler = trigger.handler
        end
    end

    -- 如果没有开门绘制铁门动画
    if not isIronGateOpen then
        CopyTexture(
            animation_IronGate.clips[animation_IronGate.index],
            {
                x = 3684 - rect_viewport.x,
                y = 515 - rect_viewport.y,
                w = animation_IronGate.rect.w,
                h = animation_IronGate.rect.h
            }
        )
    end

    -- 绘制铁门墙
    CopyTexture(
        texture_IronGateWall,
        {
            x = 3730 - rect_viewport.x,
            y = 555 - rect_viewport.y,
            w = width_image_IronGateWall,
            h = height_image_IronGateWall
        }
    )

    -- 绘制雕像
    CopyTexture(
        animation_Statue.clips[animation_Statue.index],
        {
            x = 4190 - rect_viewport.x,
            y = 378 - rect_viewport.y,
            w = animation_Statue.rect.w,
            h = animation_Statue.rect.h
        }
    )
    
    -- 绘制喷泉
    CopyTexture(
        animation_Fountain.clips[animation_Fountain.index],
        {
            x = 4270 - rect_viewport.x,
            y = 540 - rect_viewport.y,
            w = animation_Fountain.rect.w,
            h = animation_Fountain.rect.h
        }
    )

    -- 绘制花圃
    CopyTexture(
        animation_FlowerBed.clips[animation_FlowerBed.index],
        {
            x = width_image_Background - width_image_FlowerBed - rect_viewport.x + 35,
            y = height_image_Background - height_image_FlowerBed - rect_viewport.y + 5,
            w = animation_FlowerBed.rect.w,
            h = animation_FlowerBed.rect.h
        }
    )

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

    -- 绘制路灯图片
    CopyReshapeTexture(
        texture_StreetLamp,
        rect_viewport,
        {
            x = 0,
            y = rect_viewport.h - height_image_StreetLamp + 60,
            w = rect_viewport.w,
            h = height_image_StreetLamp
        }
    )

    UpdateWindow()
    
    local _end = GetInitTime()
    
    if _end - _start < 1000 / _FPS_ then
        Sleep(1000 / _FPS_ - (_end - _start))
    end

end
