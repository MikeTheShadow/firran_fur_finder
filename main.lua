local api = require("api")
local firran_fluff_finder = {
    name = "Firran Fluff Finder",
    version = "1.0",
    author = "Mike",
    desc = "Will let you know if your undies are expired."
}

local function ShowWindow(text)
    -- Create the window
    local Canvas = api.Interface:CreateEmptyWindow("simpleWindow", "UIParent")
    Canvas.bg = Canvas:CreateNinePartDrawable(TEXTURE_PATH.HUD, "background")
    Canvas.bg:SetTextureInfo("bg_quest")
    Canvas.bg:SetColor(0, 0, 0, 0.7)        -- semi‑transparent dark bg
    Canvas.bg:AddAnchor("TOPLEFT", Canvas, 0, 0)
    Canvas.bg:AddAnchor("BOTTOMRIGHT", Canvas, 0, 0)

    -- Position and size
    local width, height = 300, 150
    Canvas:AddAnchor("CENTER", "UIParent", 0, 0)
    Canvas:SetExtent(width, height)
    Canvas:Show(true)

    -- Close button
    local closeBtn = Canvas:CreateChildWidget("button", "simple.closeBtn", 0, true)
    closeBtn:SetText(text)
    closeBtn:AddAnchor("TOPLEFT", Canvas, 10, 0)
    api.Interface:ApplyButtonSkin(closeBtn, BUTTON_BASIC.DEFAULT)
    closeBtn:Show(true)
    closeBtn:SetExtent(280, 150)
    closeBtn:SetHandler("OnClick", function()
        Canvas:Show(false)
        Canvas = nil
    end)
end

local function checkDirty(item,name)
    if item and item.evolvingInfo and item.evolvingInfo.remainTime then
            local rt = item.evolvingInfo.remainTime
            if rt.day == 0 and rt.hour == 0 and rt.minute == 0 and rt.second == 0 then
                ShowWindow("YOUR " .. name .. " IS DIRTY!")
            end
    end
end

local function OnLoad()
    local undies = api.Equipment:GetEquippedItemTooltipInfo(15)
    local costume = api.Equipment:GetEquippedItemTooltipInfo(28)
    checkDirty(undies,"UNDERWEAR")
    checkDirty(costume,"COSTUME")
end

firran_fluff_finder.OnLoad = OnLoad

return firran_fluff_finder