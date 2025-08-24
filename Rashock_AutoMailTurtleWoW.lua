-- Rashock_AutoMailTurtleWoW: Auto-send by rules (live scan, 1 attachment/mail)
-- Lua 5.0 safe + skip current typed recipient + skip self (player)

local ADDON_NAME = "Rashock_AutoMailTurtleWoW"
local PREFIX = "RAM"
local ATTACHMENTS_MAX = 1
local SEND_DELAY = 0.6
local RAM_DEBUG = false

-- ===== Regeln: ItemID -> Empf�nger (subject optional; sonst dynamisch "RAM: <ItemName>") =====
local RAM_RULES = {

-- Stoffe:
  [2589]  = {recipient="ITLeinen"}, -- Leinenstoff
  [2592]  = {recipient="ITWoll"}, -- Wollstoff
  [4306]  = {recipient="ITSeiden"}, -- Seidenstoff
  [4338]  = {recipient="ITMagie"}, -- Magiestoff
  [14047] = {recipient="ITRunen"}, -- Runenstoff
  [14256] = {recipient="ITTeufels"}, -- Teufelsstoff
  [14342] = {recipient="ITMond"},  -- Mondstoff
  
   
-- Erze und Steine: 
  [2770] = {recipient="ITKupfer"},      -- Kupfererz
  [2840] = {recipient="ITKupfer"},      -- Kupferbarren

  [2771] = {recipient="ITZinn"},      -- Zinn Erz
  [2836] = {recipient="ITZinn"},      -- Coarse Stone
  [2841] = {recipient="ITZinn"},      -- Bronze Barren
  [2772] = {recipient="ITEisen"},      -- Iron Erz
  [2838] = {recipient="ITEisen"},      -- Schwerer Stein
  [11370] = {recipient="ITMCerz"},      -- Duneleisenerz
  [7911] = {recipient="ITSilber"},      -- Echt Silber
  [3577] = {recipient="ITSilber"},      -- Gold Barren
  [2842] = {recipient="ITSilber"},      -- Silber Barren
  [10620] = {recipient="ITThorium"},      -- Thorium Erz
  [12365] = {recipient="ITThorium"},      -- Dense Stone
  
  
 -- Leder
  [2318]  = {recipient="ITLeder"}, -- Leichtes Leder
[2319]  = {recipient="ITLeder"}, -- Mittleres Leder
[4234]  = {recipient="ITLeder"}, -- Schweres Leder
[4232]  = {recipient="ITLeder"}, -- Medium Hide

-- Edelsteine
  [7910]  = {recipient="ITGem"}, -- Sternrubin
  [55250] = {recipient="ITGem"}, -- Emberstone
  [61673] = {recipient="ITGem"}, -- Arcane Essenz
  [12363] = {recipient="ITGem"}, -- Arcane Kristall
  [7909]  = {recipient="ITGem"}, -- Aquamarine
  [55252] = {recipient="ITGem"}, -- Imperial Topaz
  [818]   = {recipient="ITGem"}, -- Tigerauge
  [81094] = {recipient="ITGem"}, -- Amber Topaz
  [3864] = {recipient="ITGem"}, -- Citrine
  [1529] = {recipient="ITGem"}, -- Jade
  [7076] = {recipient="ITGem"}, -- Essenz der Erde
  [12800] = {recipient="ITGem"}, -- Azerothian Diamond


    
   
-- Kochzeugs
  [12205] = {recipient="ITKoch"},      -- Wei�es Spinenfleisch
  [3685] = {recipient="ITKoch"},      -- Rapoter Eier
  [12203] = {recipient="ITKoch"},      -- Red Wolf Meat
  
-- ZG
  [19699] = {recipient="ITZG"},      --   Schmuck & M�nzen
  [19700] = {recipient="ITZG"},      --    Schmuck & M�nzen
  [19701] = {recipient="ITZG"},      --   Schmuck & M�nzen
  [19702] = {recipient="ITZG"},      --  Schmuck & M�nzen
  [19703] = {recipient="ITZG"},      --    Schmuck & M�nzen
  [19704] = {recipient="ITZG"},      --  Schmuck & M�nzen
  [19705] = {recipient="ITZG"},      --  Schmuck & M�nzen
  [19706] = {recipient="ITZG"},      --  Schmuck & M�nzen
  [19707] = {recipient="ITZG"},      --  Schmuck & M�nzen
  [19708] = {recipient="ITZG"},      --  Schmuck & M�nzen
  [19709] = {recipient="ITZG"},      --   Schmuck & M�nzen 
  [19710] = {recipient="ITZG"},      --   Schmuck & M�nzen
  [19711] = {recipient="ITZG"},      --   Schmuck & M�nzen
  [19712] = {recipient="ITZG"},      --   Schmuck & M�nzen
  [19713] = {recipient="ITZG"},      --   Schmuck & M�nzen
  [19714] = {recipient="ITZG"},      --   Schmuck & M�nzen
  [19715] = {recipient="ITZG"},      --   Schmuck & M�nzen
  
-- AQ
  [22202] = {recipient="ITZG"},      --   Small Obsidian Shard
  [20863] = {recipient="ITZG"},      --   Scarab and Idol
  [20864] = {recipient="ITZG"},      --   Scarab and Idol
  [20865] = {recipient="ITZG"},      --   Scarab and Idol
  [20866] = {recipient="ITZG"},      --   Scarab and Idol
  [20867] = {recipient="ITZG"},      --   Scarab and Idol
  
-- Kraut
  [13463] = {recipient="ITKraut"}, -- Traumblatt
  [3355]  = {recipient="ITKraut"}, -- Wildstahlblume
  [3818]  = {recipient="ITKraut"}, -- Fadeleaf
  [3820]  = {recipient="ITKrauta"}, -- Stranglekelp 
  [3356]  = {recipient="ITKraut"}, -- Kingsblood
  [785]  = {recipient="ITKrauta"}, -- Mageroyal 
--  [3820]  = {recipient="ITKraut"}, -- Stranglekelp 
  [2450]  = {recipient="ITKrauta"}, -- Briathorn 
  [2453]  = {recipient="ITKrauta"}, -- Bruiseweed 
  [8845]  = {recipient="ITKrauta"}, -- Geisterpilz 
  
	

-- VZ
  [14344] = {recipient="ITVZ"},      --  Gro�er Gl�nzener Splitter

-- Schlie�kassetten
  [4633] = {recipient="Rshock"},      -- Heavy Bronze Lockbox
  [4636] = {recipient="Rshock"},      -- Strong Iron Lockbox
 -- [4636] = {recipient="Rshock"},      -- Strong Iron Lockbox
 -- [4636] = {recipient="Rshock"},      -- Strong Iron Lockbox
 -- [4636] = {recipient="Rshock"},      -- Strong Iron Lockbox
 -- [4636] = {recipient="Rshock"},      -- Strong Iron Lockbox
 -- [4636] = {recipient="Rshock"},      -- Strong Iron Lockbox 
}

-- ===== Utils =====
local function RAM_Print(msg)
  if DEFAULT_CHAT_FRAME then DEFAULT_CHAT_FRAME:AddMessage("RAM: "..tostring(msg)) end
end

SLASH_RASHOCKRAM1 = "/ram"
SLASH_RASHOCKRAM2 = "/RAM"
SlashCmdList["RASHOCKRAM"] = function(msg)
  msg = msg and string.lower(msg) or ""
  if msg == "debug" then
    RAM_DEBUG = not RAM_DEBUG
    RAM_Print("debug = "..tostring(RAM_DEBUG))
  else
    RAM_Print("commands: /ram debug (toggle)")
  end
end

-- Load info
local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(_, _, name)
  if name == ADDON_NAME then
    RAM_Print("loaded ("..ADDON_NAME..")")
    loader:UnregisterEvent("ADDON_LOADED")
  end
end)

-- ===== Helpers (Lua 5.0 safe) =====
local function RAM_GetItemID(link)
  if not link then return nil end
  local _, _, id = string.find(link, "Hitem:(%d+):")
  if not id then _, _, id = string.find(link, "item:(%d+)") end
  if id then return tonumber(id) end
  return nil
end

local function RAM_ClearAttachments()
  for i = 1, ATTACHMENTS_MAX do
    local btn = _G["SendMailAttachment"..i]
    if btn and btn.hasItem then
      ClickSendMailItemButton(i, 1)
    end
  end
end

-- trim + lowercase
local function RAM_sanitizeName(s)
  if not s then return nil end
  s = string.gsub(s, "^%s+", "")
  s = string.gsub(s, "%s+$", "")
  if s == "" then return nil end
  return string.lower(s)
end

-- aktuell getippter Empf�nger (f�r Skip)
local function RAM_GetCurrentTypedRecipientLower()
  if SendMailNameEditBox and SendMailNameEditBox.GetText then
    return RAM_sanitizeName(SendMailNameEditBox:GetText())
  end
  return nil
end

-- eigener Charname (f�r Skip Self)
local function RAM_GetPlayerLower()
  local n = UnitName and UnitName("player") or nil
  return RAM_sanitizeName(n)
end

-- Gibt es noch Items, die an NICHT �bersprungene Empf�nger gehen?
local function RAM_AnyItemsLeft(skipLower, selfLower)
  for bag = 0, 4 do
    local n = GetContainerNumSlots(bag) or 0
    for slot = 1, n do
      local link = GetContainerItemLink(bag, slot)
      if link then
        local id = RAM_GetItemID(link)
        local rule = id and RAM_RULES[id]
        if rule then
          local rLower = RAM_sanitizeName(rule.recipient)
          if (not skipLower or rLower ~= skipLower) and (not selfLower or rLower ~= selfLower) then
            return true
          end
        end
      end
    end
  end
  return false
end

-- N�chsten Stack f�r einen Empf�nger finden (achtet auf Skip & Self)
local function RAM_FindNextForRecipient(recipient, skipLower, selfLower)
  local recLower = RAM_sanitizeName(recipient)
  if selfLower and recLower == selfLower then
    return nil
  end
  for bag = 0, 4 do
    local n = GetContainerNumSlots(bag) or 0
    for slot = 1, n do
      local link = GetContainerItemLink(bag, slot)
      if link then
        local id = RAM_GetItemID(link)
        local rule = id and RAM_RULES[id]
        if rule then
          local rLower = RAM_sanitizeName(rule.recipient)
          if rLower == recLower and (not skipLower or rLower ~= skipLower) and (not selfLower or rLower ~= selfLower) then
            local _, count = GetContainerItemInfo(bag, slot)
            return bag, slot, (count or 1), id
          end
        end
      end
    end
  end
  return nil
end

-- Empf�ngerliste aus Taschen (achtet auf Skip & Self)
local function RAM_BuildRecipientList(skipLower, selfLower)
  local set = {}
  local list = {}
  for bag = 0, 4 do
    local n = GetContainerNumSlots(bag) or 0
    for slot = 1, n do
      local link = GetContainerItemLink(bag, slot)
      if link then
        local id = RAM_GetItemID(link)
        local rule = id and RAM_RULES[id]
        if rule then
          local rLower = RAM_sanitizeName(rule.recipient)
          if (not skipLower or rLower ~= skipLower) and (not selfLower or rLower ~= selfLower) and not set[rLower] then
            set[rLower] = true
            table.insert(list, rule.recipient) -- Original-Schreibweise f�r UI/Logs
          end
        end
      end
    end
  end
  return list
end

-- ===== Send loop (live scan) =====
local sendFrame = CreateFrame("Frame")
local sending = {
  active = false,
  recipients = nil,
  idx = 0,
  totals = {},   -- [recipient] = { [itemID] = count }
  totalAll = 0,
  lastT = 0,
  skipLower = nil,
  selfLower = nil,
}

local function RAM_FinishAndReport()
  RAM_Print("Versand beendet. Insgesamt "..sending.totalAll.." Items verschickt.")
  for recipient, items in pairs(sending.totals) do
    for itemID, cnt in pairs(items) do
      local name = GetItemInfo(itemID) or ("ItemID "..itemID)
      RAM_Print(" -> "..recipient..": "..cnt.."x "..name)
    end
  end
end

local function RAM_StartSending()
  if sending.active then
    RAM_Print("already running")
    return
  end

  -- dynamische Skips festlegen
  local skipLower = RAM_GetCurrentTypedRecipientLower()
  local selfLower = RAM_GetPlayerLower()
  if skipLower then RAM_Print("Skip aktiv f�r Empf�nger (getippt): "..(SendMailNameEditBox:GetText() or "?")) end
  if selfLower then RAM_Print("Eigener Char wird immer �bersprungen: "..(UnitName("player") or "?")) end

  local recipients = RAM_BuildRecipientList(skipLower, selfLower)
  if table.getn(recipients) == 0 then
    RAM_Print("Keine Items zum Verschicken gefunden.")
    return
  end

  sending.active = true
  sending.recipients = recipients
  sending.idx = 1
  sending.totals = {}
  sending.totalAll = 0
  sending.lastT = 0
  sending.skipLower = skipLower
  sending.selfLower = selfLower

  RAM_Print("Starte Versand...")

  sendFrame:SetScript("OnUpdate", function()
    local now = GetTime and GetTime() or 0
    if sending.lastT == 0 then sending.lastT = now end
    if now - sending.lastT < SEND_DELAY then return end

    local current = sending.recipients[sending.idx]
    if current and sending.selfLower and RAM_sanitizeName(current) == sending.selfLower then
      -- Notbremse: falscher Empf�nger -> direkt zum n�chsten
      if RAM_DEBUG then RAM_Print("Skip (self): "..current) end
      sending.idx = sending.idx + 1
      sending.lastT = now
      return
    end

    if not current then
      if RAM_AnyItemsLeft(sending.skipLower, sending.selfLower) then
        sending.recipients = RAM_BuildRecipientList(sending.skipLower, sending.selfLower)
        sending.idx = 1
        if table.getn(sending.recipients) == 0 then
          RAM_FinishAndReport()
          sendFrame:SetScript("OnUpdate", nil)
          sending.active = false
          return
        end
        current = sending.recipients[sending.idx]
      else
        RAM_FinishAndReport()
        sendFrame:SetScript("OnUpdate", nil)
        sending.active = false
        return
      end
    end

    local bag, slot, count, itemID = RAM_FindNextForRecipient(current, sending.skipLower, sending.selfLower)
    if bag then
      -- Betreff: fix aus Regel falls vorhanden, sonst dynamisch "RAM: <ItemName>"
      local rule = RAM_RULES[itemID]
      local itemName = GetItemInfo(itemID) or ("ItemID "..itemID)
      local subject = (rule and rule.subject) or (PREFIX..": "..itemName)

      RAM_ClearAttachments()
      PickupContainerItem(bag, slot)
      ClickSendMailItemButton(1)

      SendMailNameEditBox:SetText(current)
      SendMailSubjectEditBox:SetText(subject)
      SendMailBodyEditBox:SetText("")
-- Safety: nur senden, wenn wirklich ein Item angeheftet ist
local a1 = _G["SendMailAttachment1"]
if not (a1 and a1.hasItem) then
  -- kein Anhang? Dann brechen wir diese Iteration ab und versuchen im n�chsten Tick erneut
  RAM_Print("Kein Anhang erkannt � versuche erneut �")
  return
end

SendMail(current, subject, "")





      -- z�hlen
      sending.totals[current] = sending.totals[current] or {}
      sending.totals[current][itemID] = (sending.totals[current][itemID] or 0) + count
      sending.totalAll = sending.totalAll + count

      if RAM_DEBUG then
        RAM_Print(" -> Mail: "..itemName.." x"..tostring(count).." an "..current.." (Subj: "..subject..")")
      end

      sending.lastT = now
      return
    else
      -- f�r diesen Empf�nger nichts mehr -> n�chster
      sending.idx = sending.idx + 1
      sending.lastT = now
      return
    end
  end)
end

-- ===== UI =====
local function RAM_CreateButton()
  if RAM_TestButton then return end
  if not SendMailFrame then RAM_Print("SendMailFrame missing"); return end

  local btn = CreateFrame("Button", "RAM_TestButton", SendMailFrame, "UIPanelButtonTemplate")
  btn:SetText("RAM Send")
  btn:SetWidth(120); btn:SetHeight(24)
  btn:SetPoint("TOPRIGHT", SendMailFrame, "TOPRIGHT", -35, -65)

  btn:SetFrameStrata("HIGH")
  if SendMailScrollFrame and SendMailScrollFrame.GetFrameLevel then
    btn:SetFrameLevel(SendMailScrollFrame:GetFrameLevel() + 5)
  end

  btn:SetScript("OnClick", RAM_StartSending)
  RAM_Print("button created")
end

local mailbox = CreateFrame("Frame")
mailbox:RegisterEvent("MAIL_SHOW")
mailbox:SetScript("OnEvent", RAM_CreateButton)
