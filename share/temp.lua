--[[ ----------------------------------------

    [Deps] Temp.

--]] ----------------------------------------

Fs = require "filesystem"

Temp = {
    baseDir = 'temp/'
}

local function getRandStr()
    math.randomseed(os.time())
    return string.gsub('********', '[*]', function (c)
        return string.format('%x', math.random(0,0xf))
    end)
end

function Temp:init()
    self:free()
    return true
end

function Temp:free()
    Fs:rmdir(self.baseDir)
    Fs:mkdir(self.baseDir)
end

function Temp:getFile()
    local n
    while true do
        n = self.baseDir..getRandStr()
        if not Fs:isExist(n) then
            break
        end
    end
    Fs:writeTo(n,'')
    return n
end

function Temp:getDirectory()
    local n
    while true do
        n = self.baseDir..getRandStr()
        if not Fs:isExist(n) then
            break
        end
    end
    Fs:mkdir(n)
    return n..'/'
end

return Temp