local _, ns = ...

local M = {}
ns:RegisterModule("minimap", M)

local ICON      = 7195162  -- Garrote
local BUTTON_SZ = 32
local RADIUS    = 100      -- distancia al centro del minimapa (afuera del borde)

local button

local function updatePosition()
    if not button then return end
    local angle = math.rad(ns.db.minimapAngle or 45)
    local x = math.cos(angle) * RADIUS
    local y = math.sin(angle) * RADIUS
    button:ClearAllPoints()
    button:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

local function onDragUpdate()
    local mx, my = Minimap:GetCenter()
    if not mx then return end
    local scale = Minimap:GetEffectiveScale()
    local cx, cy = GetCursorPosition()
    cx, cy = cx / scale, cy / scale
    local angle = math.deg(math.atan2(cy - my, cx - mx))
    ns.db.minimapAngle = angle
    updatePosition()
end

local function createButton()
    button = CreateFrame("Button", "RBTMinimapButton", Minimap)
    button:SetSize(BUTTON_SZ, BUTTON_SZ)
    button:SetFrameStrata("MEDIUM")
    button:SetFrameLevel(8)
    button:SetMovable(true)
    button:SetClampedToScreen(true)
    button:RegisterForClicks("AnyUp")
    button:RegisterForDrag("LeftButton", "RightButton")

    -- Borde circular (el "hueco" queda en el centro)
    button.bg = button:CreateTexture(nil, "BACKGROUND")
    button.bg:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    button.bg:SetSize(54, 54)
    button.bg:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)

    -- Icono con máscara circular para no ver las esquinas cuadradas
    button.icon = button:CreateTexture(nil, "BACKGROUND", nil, 1)
    button.icon:SetSize(22, 22)
    button.icon:SetPoint("CENTER", button, "CENTER", 0, 0)
    button.icon:SetTexture(ICON)
    button.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

    local mask = button:CreateMaskTexture()
    mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask",
                    "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    mask:SetAllPoints(button.icon)
    button.icon:AddMaskTexture(mask)

    -- Highlight al pasar el ratón
    button.highlight = button:CreateTexture(nil, "HIGHLIGHT")
    button.highlight:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    button.highlight:SetSize(32, 32)
    button.highlight:SetPoint("CENTER", button, "CENTER", 0, 0)
    button.highlight:SetBlendMode("ADD")

    button:SetScript("OnClick", function(_, mouseButton)
        ns:Debug("minimap click: %s", tostring(mouseButton))
            if mouseButton == "LeftButton" then
            local opts = ns.modules.options
            if opts and opts.Toggle then
                opts:Toggle()
            else
                ns:Print("options panel not available, use /rbt")
            end
        elseif mouseButton == "RightButton" then
            ns:SetLocked(not ns.db.locked)
        end
    end)

    button:SetScript("OnDragStart", function()
        button:SetScript("OnUpdate", onDragUpdate)
    end)
    button:SetScript("OnDragStop", function()
        button:SetScript("OnUpdate", nil)
    end)

        button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine("|cffff3333RBT|r - Rogues Bleed Tracker")
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Left click: open options", 1, 1, 1)
        GameTooltip:AddLine("Right click: lock / unlock", 1, 1, 1)
        GameTooltip:AddLine("Drag: move icon", 1, 1, 1)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    updatePosition()
end

function M:Refresh()
    if not button then return end
    button:SetShown(not ns.db.minimapHide)
    updatePosition()
end

function M:OnPlayerLogin()
    createButton()
    self:Refresh()
end