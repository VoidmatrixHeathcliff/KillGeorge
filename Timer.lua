--[[ 帧累加定时器模块 ]] --
Timer = {}

-- 当前存在的定时器列表
local _timer_list = {}

--[[
    添加定时器
    参数：
        - delay：延时间隔
        - callback：计时器回调函数
        - params：回调函数参数
        - disposal：是否到达计时时间自动移除，默认为 false
    返回值：
        - 定时器在定时器列表中的ID
--]]

function Timer.AddTimer(delay, callback, params, disposal)
    assert(type(delay) == "number", "Timer.AddTimer()：参数#1类型必须为number")
    assert(type(callback) == "function", "Timer.AddTimer()：参数#2类型必须为function")
    assert(type(params) == "table", "Timer.AddTimer()：参数#3类型必须为table")
    table.insert(_timer_list, {
        _last = GetInitTime(),
        _delay = delay,
        _duration = 0,
        _callback = callback,
        _params = params,
        _disposal = disposal or false
    })
    return #_timer_list
end

--[[
    移除指定ID的定时器
    参数：
        - id：定时器ID
    返回值：
        无
--]]
function Timer.RemoveTimer(id)
    assert(type(id) == "number", "Timer.RemoveTimer()：参数#1类型必须为number")
    assert(id > 0 and id <= #_timer_list, "Timer.RemoveTimer()：参数#1必须为有效计时器ID")
    table.remove(_timer_list, id)
end

--[[
    更新定时器时间
    参数：
        无
    返回值：
        无
--]]
function Timer.Update()
    local _current = GetInitTime()
    for i = #_timer_list, 1, -1 do
        _timer_list[i]._duration = _timer_list[i]._duration + (_current - _timer_list[i]._last)
        _timer_list[i]._last = _current
        if _timer_list[i]._delay <= _timer_list[i]._duration then
            _timer_list[i]._callback(_timer_list[i]._params)
            if _timer_list[i] then
                _timer_list[i]._duration = 0
                if _timer_list[i]._disposal then table.remove(_timer_list, i) end
            end
        end
    end
end

--[[
    清空定时器列表
    参数：
        无
    返回值：
        无
--]]
function Timer.ClearAll()
    _timer_list = {}
end

return Timer