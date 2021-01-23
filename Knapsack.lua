--[[ 玩家背包模块 ]]--
Knapsack = {}

-- 当前背包内物品
local _item_list = {}

-- 背包空间上限
local _max_space = 3

--[[
    获取背包空间上限
    -- 参数：
        无
    -- 返回值：
        背包空间上限
--]]
function Knapsack.GetMaxSpace()
    return _max_space
end

--[[
    设置背包空间上限
    + 如果当前背包内物品数量大于所设置上限则报错
    -- 参数：
        背包空间上限
    -- 返回值：
        无
--]]
function Knapsack.SetMaxSpace(num)
    assert(type(item) == "number", "Knapsack.SetMaxSpace()：参数#1类型必须为table")
    assert(num > #_item_list, "Knapsack.SetMaxSpace()：背包中现有物品数量大于所设置上限")
    _max_space = num
end

--[[
    获取当前背包内物品数量
    -- 参数：
        无
    -- 返回值：
        当前背包内物品数量
--]]
function Knapsack.GetItemNum()
    return #_item_list
end

--[[
    向背包内添加指定物品
    + 若背包已满则报错
    -- 参数：
        物品
    -- 返回值:
        当前物品在背包中的索引（即当前背包内物品数量）
--]]
function Knapsack.AddItem(item)
    assert(type(item) == "table", "Knapsack.AddItem()：参数#1类型必须为table")
    assert(type(item.name) == "string", "Knapsack.AddItem()：参数#1中必须有类型为string的name成员")
    assert(#_item_list < _max_space, "Knapsack.AddItem()：背包空间已满")
    table.insert(_item_list, item)
    return #_item_list
end

--[[
    判断当前背包内是否存在指定名称的物品
    -- 参数：
        物品名称
    -- 返回值：
        是否存在
--]]
function Knapsack.ExistItem(_name)
    assert(type(_name) == "string", "Knapsack.RemoveItem()：参数#1类型必须为string")
    for _, item in pairs(_item_list) do
        if item.name == _name then 
            return true
        end
    end
    return false
end

--[[
    获取背包内指定名称或索引的物品
    -- 参数：
        物品名称或索引
    -- 返回值：
        物品
--]]
function Knapsack.GetItem(_flag)
    if type(_flag) == "string" then
        for _, item in pairs(_item_list) do
            if item.name == _flag then 
                return item
            end
        end
        error("Knapsack.GetItem()：指定名称的物品不存在")
    elseif type(_flag) == "number" then
        assert(_flag <= #_item_list, "Knapsack.GetItem()：背包空间索引越界")
        return _item_list[_flag]
    else
        error("Knapsack.GetItem()：参数#1必须为物品名或背包空间索引")
    end
end

--[[
    删除背包内指定名称或索引的物品
    -- 参数：
        物品名称或索引
    -- 返回值：
        无
--]]
function Knapsack.RemoveItem(_flag)
    if type(_flag) == "string" then
        for _, item in pairs(_item_list) do
            if item.name == _flag then 
                table.remove(_item_list, index)
                return
            end
        end
        error("Knapsack.RemoveItem()：指定名称的物品不存在")
    elseif type(_flag) == "number" then
        assert(_flag <= #_item_list, "Knapsack.RemoveItem()：背包空间索引越界")
        table.remove(_item_list, _flag)
    else
        error("Knapsack.RemoveItem()：参数#1必须为物品名或背包空间索引")
    end
end

--[[
    清空背包
    -- 参数：
        无
    -- 返回值：
        无
--]]
function Knapsack.EmptyKnapsack()
    _item_list = {}
end

return Knapsack