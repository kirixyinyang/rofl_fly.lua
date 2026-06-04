-- J.A.R.V.I.S | Main Loader
-- Загружает fly.lua и другие модули

local repo = "https://raw.githubusercontent.com/kirixyinyang/mm2_script.lua/refs/heads/main/"

local function loadModule(name)
    local url = repo .. name
    local success, content = pcall(function()
        return game:HttpGet(url)
    end)
    if success then
        local func, err = loadstring(content)
        if func then
            return func
        else
            warn("Error in " .. name .. ": " .. err)
            return nil
        end
    else
        warn("Failed load " .. name .. ": " .. content)
        return nil
    end
end

-- Загружаем fly.lua
local fly = loadModule("fly.lua")
if fly then
    fly()
    print("✅ J.A.R.V.I.S | Fly module loaded")
else
    warn("❌ Failed to load fly.lua")
end
