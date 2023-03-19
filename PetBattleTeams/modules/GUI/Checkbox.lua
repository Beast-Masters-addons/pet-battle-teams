local PetBattleTeams = _G.LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")

---@type PetBattleTeamsGUI
local GUI = PetBattleTeams:GetModule("GUI")

---@class PetBattleTeamsCheckbox
local checkbox = PetBattleTeams:NewModule('Checkbox', "AceEvent-3.0")

function checkbox:OnEnable()
    self:RegisterEvent('ADDON_LOADED')
end

function checkbox:ADDON_LOADED(...)
    local _, addon = ...
    if addon == 'PetTracker_Journal' then
        --Re-align the checkbox if PetTracker is loaded
        --@debug@
        print(('%s loaded, align'):format(addon))
        --@end-debug@
        self:align()
    end
end

function checkbox:Create()
    self.frame = _G.CreateFrame('CheckButton', 'PetBattleTeamsCheckbox',
        _G.PetJournal, 'InterfaceOptionsCheckButtonTemplate')

    self.frame.Text:SetText('Show teams')
    --@debug@
    print('Frame created, align')
    --@end-debug@
    self:align()

    self.frame:RegisterForClicks("LeftButtonUp")
    self.frame:SetScript("OnClick", function(_, mouseButton)
        if mouseButton == "LeftButton" then
            GUI:ToggleMinimize(not GUI:GetIsMinimized())
        end
    end)
end

---Place the checkbox to the left of "Find Battle" button or "Track Pets" checkbox if PetTracker is installed
function checkbox:align()
    if not self.frame then
        --@debug@
        print('Frame not created, unable to align')
        --@end-debug@
        return
    end
    local relative = _G.PetTrackerTrackToggle or _G.PetJournalFindBattle
    if not relative then
        --@debug@
        print('No frame to align with')
        --@end-debug@
        return
    end
    --@debug@
    print('Align checkbox to', relative:GetName())
    --@end-debug@

    self.frame:SetPoint('RIGHT', relative, 'LEFT', -self.frame.Text:GetWidth() - 15, -1)
end

function checkbox:check()
    self.frame:SetChecked(true)
end

function checkbox:uncheck()
    self.frame:SetChecked(false)
end