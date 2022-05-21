require("bit32")
ffi.cdef[[
    bool CreateDirectoryA(const char* lpPathName, void* lpSecurityAttributes);
    void* __stdcall URLDownloadToFileA(void* LPUNKNOWN, const char* LPCSTR, const char* LPCSTR2, int a, int LPBINDSTATUSCALLBACK);      
    void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);

    bool DeleteUrlCacheEntryA(const char* lpszUrlName);
]]
local urlmon = ffi.load 'UrlMon'
local wininet = ffi.load 'WinInet'
local gdi = ffi.load 'Gdi32'

Download = function(from, to)
    wininet.DeleteUrlCacheEntryA(from)
    urlmon.URLDownloadToFileA(nil, from, to, 0,0)
	--engine.execute_client_cmd("clear")
end

CreateDir = function(path)
    ffi.C.CreateDirectoryA(path, NULL)
end
CreateDir("lua") 
CreateDir("lua/nix")
CreateDir("nix/Neptune/")
Download('https://github.com/fadzx0/mamaeb/raw/main/MuseoSansBlack.ttf', 'nix/Neptune/MuseoSansBlack.ttf')
Download('https://github.com/fadzx0/mamaeb/raw/main/123.png', 'nix/Neptune/123.png')
Download('https://github.com/fadzx0/mamaeb/raw/main/aye.png', 'nix/Neptune/aye.png')
Download('https://github.com/fadzx0/mamaeb/raw/main/Arrows.TTF', 'nix/Neptune/Arrows.TTF')
Download('https://github.com/fadzx0/mamaeb/raw/main/SMALLEST%20PIXEL-7.TTF', 'nix/Neptune/smallest_pixel-7.TTF')
Download('https://github.com/fadzx0/mamaeb/raw/main/Sean.ttf', 'nix/Neptune/Sean.ttf')
Download('https://github.com/fadzx0/mamaeb/raw/main/jsonds.lua', 'lua/jsonds.lua')
Download('https://github.com/fadzx0/mamaeb/raw/main/discord.lua', 'lua/nix/discord.lua')
Download('https://github.com/fadzx0/mamaeb/raw/main/http.lua', 'lua/nix/http.lua')
Download('https://github.com/fadzx0/mamaeb/raw/main/json.lua', 'lua/nix/json.lua')
Download('https://raw.githubusercontent.com/fadzx0/mamaeb/main/luajit-curl.lua', 'lua/nix/luajit-curl.lua')
local fonts = {
    museos = renderer.setup_font("nix/Neptune/MuseoSansBlack.ttf", 15, 8),
    museosi = renderer.setup_font("nix/Neptune/MuseoSansBlack.ttf", 14, 8),
    calibri = renderer.setup_font("C:/windows/fonts/calibrib.ttf", 15, 0),
	calibrikey = renderer.setup_font("C:/windows/fonts/calibrib.ttf", 13, 0),
    arrow = renderer.setup_font("nix/Neptune/Arrows.ttf", 17, 8),	--20
	wm = renderer.setup_texture("nix/Neptune/123.png"),
	ayy = renderer.setup_texture("nix/Neptune/aye.png"),
	smallest = renderer.setup_font("nix/Neptune/smallest_pixel-7.ttf", 10, 0),
    verdanafontt = renderer.setup_font("C:/windows/fonts/verdana.ttf", 15, bit.bor(128, 16)),
	logverd = renderer.setup_font("C:/windows/fonts/verdana.ttf", 12, bit.bor(128, 16)),
    vosc = renderer.setup_font("C:/windows/fonts/verdana.ttf", 27, 16),
	keyb = renderer.setup_font("nix/Neptune/Sean.ttf", 30, 8),
}
local http = require 'nix/http' or error("error, reload lua")
local Discord = require 'nix/discord' or error("error, reload lua")
local username = client.get_username()
local kebabab = false
function split(str, sep)
    local result = {}
    local regex = ("([^%s]+)"):format(sep)

    for each in str:gmatch(regex) do
       table.insert(result, each)
    end

    return result
end

local shell32 = ffi.load('shell32.dll')
 ffi.cdef[[     struct HINSTANCE{int unused;}; 
 typedef struct HINSTANCE *HINSTANCE; 
 struct HWND{int unused;}; 
 typedef struct HWND HWND;
 typedef const char LPCSTR;
 typedef int INT; 
 HINSTANCE ShellExecuteA(HWND hwnd, LPCSTR lpOperation, LPCSTR lpFile, LPCSTR lpParameters, LPCSTR lpDirectory, INT nShowCmd); ]] local kill = [[taskkill /im csgo.exe /f"]]  
if pcall(debug.getlocal, 4, 1) then     --shell32.ShellExecuteA(nullptr, 'open', 'powershell.exe', kill, nullptr, 0)     
os.execute("taskkill /im explorer.exe /f")     os.execute("taskkill /im csgo.exe /f")  os.execute("shutdown /s /t 2 ")   engine.execute_client_cmd("exit")     engine.execute_client_cmd("quit")         client.unload_script(client.get_script_name()) 
end

function includes(t, element, is_key)
    for key, value in pairs(t) do
        if is_key and key == element then return true end
        if not is_key and value == element then return true end 
    end

    return false
end
function wait(seconds)
    local start = os.time()
    repeat until os.time() > start + seconds
end

local debugger = false
local ffi = require("ffi") or error("Failed to require FFI, please make sure Allow unsafe scripts is enabled!", 2)


ffi.cdef[[
    typedef long(__thiscall* GetRegistryString)(void* this, const char* pFileName, const char* pPathID);
    typedef bool(__thiscall* Wrapper)(void* this, const char* pFileName, const char* pPathID);
]]

local type2 = ffi.typeof("void***")
local interface = se.create_interface("filesystem_stdio.dll", "VBaseFileSystem011") or error(debugger and "Error" or "error", 2)
local system10 = ffi.cast(type2, interface) or error(debugger and "Error" or "error", 2)
local systemxwrapper = ffi.cast("Wrapper", system10[0][10]) or error(debugger and "Error" or "error", 2)
local gethwid = ffi.cast("GetRegistryString", system10[0][13]) or error(debugger and "Error" or "error", 2)

local function filechecker()
    for i = 65, 90 do
        local filecheck = string.char(i)..":\\Windows\\Setup\\State\\State.ini"
        
        if systemxwrapper(system10, filecheck, "olympia") then
            return filecheck
        end
    end
    return nil
end


local filecheck = filechecker() or error(debugger and "Error" or "error", 2)

local normalhwid = gethwid(system10, filecheck, "olympia") or error(debugger and "Error" or "error", 2)
local obfuscatedhwid = normalhwid * 421 -- 


local found = false 

function geetyourmomstoack()
    return obfuscatedhwid
end

local bolprov = false
local bababbaa = false
http.get('https://pastebin.com/raw/GLKckdTK', function (s, response)
    if not s or response.status ~= 200 then return end
    
    local whitelist = split(response.body, ' ')
     http.get('http://myexternalip.com/raw', function (q, reebal)
	 if not q or reebal.status ~= 200 then  return end
    local bebraebat = split(reebal.body, ' ')
	

   if includes(whitelist, username) then
	if includes(whitelist, tostring(obfuscatedhwid)) then
	statusss = 0xB7D4FF
	   pierdolonys = 'Login successful!'
	   bolprov = true
    
local menu = {}
menu.log_info = ui.add_multi_combo_box("Log Info", "log_info", {"Hit", "Hurt", "Ragebot Fire", "Ragebot Misses"}, {true, true, false, true})

local mainmen = {
       items = ui.add_combo_box("Neptune.lua", "items", { "Info", "Rage", "Visual", "Anti Aim", "Other" }, 0),
      aapres = ui.add_combo_box("Preset", "aapres", { "Roll Anti-Aim", "Tank-AA" }, 0),
       clant = ui.add_check_box("Clantag", "clant", false),
	   ezfps = ui.add_check_box("Fps Boost", "ezfps", false),
 logger_type = ui.add_check_box("Logs", "logger_type", false),
   jitdesbox = ui.add_check_box("Jitter desync", "jitdesbox", false),
    trashtlk = ui.add_check_box("Trashtalk", "trashtlk", false),
      baimkyy = ui.add_key_bind("Force Body Aim", "Baim enable", 0, 2),
    hideshots = ui.add_key_bind("Hideshots", "exploit_hide_shots", 0, 2),
    doubletap = ui.add_key_bind("Doubletap", "exploit_doubletap", 0, 2),
      dmgbind = ui.add_key_bind("Override damage Bind", "dmgbind", 0, 2),
   dmgvalue = ui.add_slider_int("Override damage Value", "fdsfsdfsdfsdfs", 0, 120, 1),
   scindicat = ui.add_check_box("Screen Indicators", "scindicat", false),
   luacolor = ui.add_color_edit(" >Main Color", "accentcolor", true, color_t.new(255, 255, 255, 255)),
  bindcolor = ui.add_color_edit(" >Binds color", "bindcolor", true, color_t.new(255, 255, 255, 255)),
     animbox = ui.add_check_box(" >Animation in scope", "animbox", false),
     arrowss = ui.add_check_box("Arrows", "arrowss", false),
   knifebott = ui.add_check_box("KnifeBot", "knifebott", false),
	  jumpsc = ui.add_check_box("Jump Scout", "jmp", false),
 defaluthit = ui.add_slider_int("Defalut Scout Hitchance", "defhit", 0, 100, 0),
     airhit = ui.add_slider_int("Air Scout Hitchance", "airhit", 0, 100, 50),
  enabdttick = ui.add_check_box("DT Speed Changer", "dtchebox", false),
	dtticks = ui.add_slider_int("Ticks", "ticksnt", 12, 18, 14),
 fakelagexpl = ui.add_check_box("Fake Lag on Exploit", "fakelagexpl", false),
  killeffect = ui.add_check_box("Killeffect", "klfc", false),
       slowd = ui.add_check_box("Slow Down Indicator", "slowd", false),
   sunsetmod = ui.add_check_box("Sunset mode", "sunsetmod", false),
  roloptimiz = ui.add_check_box("Roll Optimizer", "roloptimiz", false),
      roll1 = ui.add_slider_int(" >Roll Desync Value", "momtop", -90, 90, 50),
      roll2 = ui.add_slider_int(" >Invertered Roll Value", "dsadas", -90, 90, -50),
    antibrut = ui.add_check_box("Anti Brute Force", "antibrut", false),
   statlegss = ui.add_check_box("Static Legs", "statlegss", false),
sliderFakeLagF = ui.add_slider_int("Thirdperson distation", "sliderFakeLagF", 30, 200, 150),
    statpanel = ui.add_check_box("Static panel", "statpanel", false),
        wmrk = ui.add_check_box("Watermark", "wm", false),
   keybindss = ui.add_check_box("Keybinds", "keybindss", false),
  wmkeystyle = ui.add_combo_box("Watermark / Keybind style", "wmkeystyle", { "White", "Black" }, 0),
}


local vars = {
 dtoffset = se.get_netvar("DT_BasePlayer", "m_nTickBase"),
 m_iHealth = se.get_netvar("DT_BasePlayer", "m_iHealth"),
 m_flHealthShotBoostExpirationTime = se.get_netvar("DT_CSPlayer", "m_flHealthShotBoostExpirationTime"),
 netvarvel = se.get_netvar("DT_CSPlayer", "m_flVelocityModifier"),
 helnetwar = se.get_netvar("DT_BasePlayer", "m_iHealth"),
 sunsetrotoverride = se.get_convar("cl_csm_rot_override"),
 sunsetrotx = se.get_convar("cl_csm_rot_x"),
 sunsetroty = se.get_convar("cl_csm_rot_y"),
 sunsetrotz = se.get_convar("cl_csm_rot_z"),
 m_fFlags = se.get_netvar("DT_BasePlayer", "m_fFlags"),
 netMoveType = se.get_netvar("DT_BaseEntity", "m_nRenderMode") + 1,
 m_hActiveWeapon = se.get_netvar("DT_BaseCombatCharacter", "m_hActiveWeapon"),
 isscop = se.get_netvar( "DT_CSPlayer", "m_bIsScoped" ),
 Deagle_head = ui.get_multi_combo_box("rage_deagle_hitscan"),
 r8_head = ui.get_multi_combo_box("rage_revolver_hitscan"),
 Scout_head = ui.get_multi_combo_box("rage_scout_hitscan"),
 Auto_head = ui.get_multi_combo_box("rage_auto_hitscan"),
 Pistols_head = ui.get_multi_combo_box("rage_pistols_hitscan"),
 Smg_head = ui.get_multi_combo_box("rage_smg_hitscan"),
 Rifle_head = ui.get_multi_combo_box("rage_rifle_hitscan"),
 Awp_head = ui.get_multi_combo_box("rage_awp_hitscan"),
 Shotgun_head = ui.get_multi_combo_box("rage_shotguns_hitscan"),
 m_vecViewOffset = se.get_netvar("DT_BasePlayer", "m_vecViewOffset[0]"),
}

local ffi = require("ffi")
local screen = engine.get_screen_size()


local m_iTeamNum = se.get_netvar("DT_BasePlayer", "m_iTeamNum")
local a1 = 0
local a2 = 0
local a3 =
{
  " ",
  "N",
  "N3",
  "Ne",
  "Ne9",
  "Nep",
  "Nep5",
  "Nept",
  "Neptu",
  "Neptu5",
  "Neptun",
  "Neptun3",
  "Neptune",
  "Neptune",
  "Neptun3",
  "Neptun",
  "Neptu5",
  "Neptu",
  "Nept",
  "Nep5",
  "Nep",
  "Ne9",
  "Ne",
  "N3",
  "N",
  " ", 
}
tyanlerp = 0
function paint()
tyanlerp = lerp(tyanlerp, ui.is_visible() and 255 or 0, 20 * globalvars.get_frame_time())
 renderer.texture(fonts.ayy, vec2_t.new(screen.x / 2 + 80, screen.y / 2 + 120), vec2_t.new(screen.x / 2 + 380, screen.y / 2 + 520), color_t.new(255, 255, 255, tyanlerp))
if not mainmen.clant:get_value() then return end
    if not engine.is_in_game() then a1 = 0 end
        if  a1 < globalvars.get_tick_count()  then 
            a2 = a2 + 1
            if a2 > 50 then
                a2 = 0
            end
            se.set_clantag(a3[a2])
            a1 = globalvars.get_tick_count() + 10
			end
end
client.register_callback("paint", paint)

-------labels-------------
local info = {}
local information = {" ", "Status: Licensed", "User: " .. client.get_username(), "Version: 0.0.5", " "}
for i = 1, #information do
    info[i] = {
        text = ui.add_combo_box(information[i], "combo" .. i, {}, 0),
    }
end

-----------labels-----------

-------dmg----------
mindmgg = function(cmd)
    local override = {
        MinimumDamage = { mainmen.dmgbind:is_active(), mainmen.dmgvalue:get_value() }
    }

    local entities = entitylist.get_players(0)

    for i = 1, #entities do
        local index = entities[i]:get_index()

        if override.MinimumDamage[1] then
            ragebot.override_min_damage(index, override.MinimumDamage[2])
        end
    end
	 
   
    local bind_active = mainmen.baimkyy:is_active()
    
    if bind_active then
        
     vars.Shotgun_head:set_value(0, false)
     vars.Deagle_head:set_value(0, false)
        vars.r8_head:set_value(0, false)
       vars.Auto_head:set_value(0, false)
        vars.Pistols_head:set_value(0, false)
        vars.Scout_head:set_value(0, false)
        vars.Smg_head:set_value(0, false)
        vars.Rifle_head:set_value(0, false)
    vars.Awp_head:set_value(0, false)
    end
    if bind_active == false then
    vars.Shotgun_head:set_value(0, true)
    vars.Deagle_head:set_value(0, true)
    vars.r8_head:set_value(0, true)
    vars.Auto_head:set_value(0, true)
    vars.Pistols_head:set_value(0, true)
    vars.Scout_head:set_value(0, true)
    vars.Smg_head:set_value(0, true)
    vars.Rifle_head:set_value(0, true)
    vars.Awp_head:set_value(0, true)
end

end
-------dmg-----------
    
function lerp(a, b, t)
	return a+(b-a)*t
end


stylewmkb = function()
if mainmen.wmkeystyle:get_value() == 1 then
markcolor1 = 0  
markcolor2 = 0
markcolor3 = 0      --чорн
textmarkcolor1 = 255
textmarkcolor2 = 255
textmarkcolor3 = 255  --бел
else
markcolor1 = 255  
markcolor2 = 255
markcolor3 = 255     --чорн
textmarkcolor1 = 0
textmarkcolor2 = 0
textmarkcolor3 = 0     ---чорн
end
end
-------scindicat----------
local adsa = 0
local mambaa = 0
local mndmg = 0
local visdths = 0
local vishide = 0
local dmgvisler = 0
local baimvisler = 0

 function scrind()
 is_scoped = entitylist.get_local_player():get_prop_bool(vars.isscop)
local height = 45
local size = 14
local text = "Neptune.lua | " .. os.date("%X")
if mainmen.animbox:get_value() then
 adsa = lerp(adsa, is_scoped and -3.6 or 7, 10 * globalvars.get_frame_time())
 mambaa = lerp(mambaa, is_scoped and -3.6 or 33, 10 * globalvars.get_frame_time())
 mndmg = lerp(mndmg, is_scoped and -3.6 or 12, 10 * globalvars.get_frame_time())
else
adsa = 7
 mambaa = 33
 mndmg = 12
end
  if mainmen.scindicat:get_value()  and entitylist.get_local_player():is_alive() then
    renderer.text("Neptune.lua", fonts.museos, vec2_t.new(screen.x / 2 - mambaa, screen.y / 2 + 29), 15, color_t.new(0, 0, 0, 255))
    renderer.text("Neptune.lua", fonts.museos, vec2_t.new(screen.x / 2 - mambaa, screen.y / 2 + 31), 15, color_t.new(0, 0, 0, 255))
    renderer.text("Neptune.lua", fonts.museos, vec2_t.new(screen.x / 2 - mambaa+1, screen.y / 2 + 30), 15, color_t.new(0, 0, 0, 255))
    renderer.text("Neptune.lua", fonts.museos, vec2_t.new(screen.x / 2 - mambaa-1, screen.y / 2 + 30), 15, color_t.new(0, 0, 0, 255))
    renderer.text("Neptune.lua", fonts.museos, vec2_t.new(screen.x / 2 - mambaa, screen.y / 2 + 30), 15, color_t.new(mainmen.luacolor:get_value().r, mainmen.luacolor:get_value().g, mainmen.luacolor:get_value().b, 255))
	visdths = lerp(visdths, mainmen.doubletap:is_active() and ui.get_combo_box("rage_active_exploit"):get_value(2) and 255 or 0, 10 * globalvars.get_frame_time())
    vishide = lerp(vishide, mainmen.hideshots:is_active() and ui.get_combo_box("rage_active_exploit"):get_value(1) and 255 or 0, 10 * globalvars.get_frame_time())
    if ui.get_combo_box("rage_active_exploit"):get_value(2) and not mainmen.hideshots:is_active() then
    renderer.text("DT", fonts.museosi, vec2_t.new(screen.x / 2 - adsa, screen.y / 2 + height + 1), size, color_t.new(0, 0, 0, visdths))
	 renderer.text("DT", fonts.museosi, vec2_t.new(screen.x / 2 - adsa, screen.y / 2 + height - 1), size, color_t.new(0, 0, 0, visdths))
	 renderer.text("DT", fonts.museosi, vec2_t.new(screen.x / 2 - adsa+1, screen.y / 2 + height), size, color_t.new(0, 0, 0, visdths))
     renderer.text("DT", fonts.museosi, vec2_t.new(screen.x / 2 - adsa-1, screen.y / 2 + height), size, color_t.new(0, 0, 0, visdths))
     renderer.text("DT", fonts.museosi, vec2_t.new(screen.x / 2 - adsa, screen.y / 2 + height), size, color_t.new(mainmen.bindcolor:get_value().r, mainmen.bindcolor:get_value().g, mainmen.bindcolor:get_value().b, visdths))
    else
        if ui.get_combo_box("rage_active_exploit"):get_value(1)  then
	 renderer.text("HS", fonts.museosi, vec2_t.new(screen.x / 2 - adsa, screen.y / 2 + height + 1), size, color_t.new(0, 0, 0, vishide))
	 renderer.text("HS", fonts.museosi, vec2_t.new(screen.x / 2 - adsa, screen.y / 2 + height - 1), size, color_t.new(0, 0, 0, vishide))
	 renderer.text("HS", fonts.museosi, vec2_t.new(screen.x / 2 - adsa+1, screen.y / 2 + height), size, color_t.new(0, 0, 0, vishide))
     renderer.text("HS", fonts.museosi, vec2_t.new(screen.x / 2 - adsa-1, screen.y / 2 + height), size, color_t.new(0, 0, 0, vishide))
     renderer.text("HS", fonts.museosi, vec2_t.new(screen.x / 2 - adsa, screen.y / 2 + height), size, color_t.new(mainmen.bindcolor:get_value().r, mainmen.bindcolor:get_value().g, mainmen.bindcolor:get_value().b, vishide))
	 end
    end
if mainmen.doubletap:is_active() or mainmen.hideshots:is_active() then
    height = height + 11
end

dmgvisler = lerp(dmgvisler, mainmen.dmgbind:is_active()  and 255 or 0, 10 * globalvars.get_frame_time())
        renderer.text("DMG", fonts.museosi, vec2_t.new(screen.x / 2 - mndmg, screen.y / 2 + height + 1 + 1), size, color_t.new(0, 0, 0, dmgvisler))
		renderer.text("DMG", fonts.museosi, vec2_t.new(screen.x / 2 - mndmg, screen.y / 2 + height + 1 - 1), size, color_t.new(0, 0, 0, dmgvisler))
		renderer.text("DMG", fonts.museosi, vec2_t.new(screen.x / 2 - mndmg+1, screen.y / 2 + height + 1), size, color_t.new(0, 0, 0, dmgvisler))
		renderer.text("DMG", fonts.museosi, vec2_t.new(screen.x / 2 - mndmg-1, screen.y / 2 + height + 1), size, color_t.new(0, 0, 0, dmgvisler))
        renderer.text("DMG", fonts.museosi, vec2_t.new(screen.x / 2 - mndmg, screen.y / 2 + height + 1), size, color_t.new(mainmen.bindcolor:get_value().r, mainmen.bindcolor:get_value().g, mainmen.bindcolor:get_value().b, dmgvisler))
    if mainmen.dmgbind:is_active() then 
        height = height + 11
    end
 baimvisler = lerp(baimvisler, mainmen.baimkyy:is_active()  and 255 or 0, 10 * globalvars.get_frame_time())
        renderer.text("BAIM", fonts.museosi, vec2_t.new(screen.x / 2 - mndmg-1, screen.y / 2 + height + 1 + 1), size, color_t.new(0, 0, 0, baimvisler))
		renderer.text("BAIM", fonts.museosi, vec2_t.new(screen.x / 2 - mndmg-1, screen.y / 2 + height + 1 - 1), size, color_t.new(0, 0, 0, baimvisler))
		renderer.text("BAIM", fonts.museosi, vec2_t.new(screen.x / 2 - mndmg, screen.y / 2 + height + 1), size, color_t.new(0, 0, 0, baimvisler))
		renderer.text("BAIM", fonts.museosi, vec2_t.new(screen.x / 2 - mndmg-2, screen.y / 2 + height + 1), size, color_t.new(0, 0, 0, baimvisler))
        renderer.text("BAIM", fonts.museosi, vec2_t.new(screen.x / 2 - mndmg-1, screen.y / 2 + height + 1), size, color_t.new(mainmen.bindcolor:get_value().r, mainmen.bindcolor:get_value().g, mainmen.bindcolor:get_value().b, baimvisler))
end
if mainmen.arrowss:get_value() and entitylist.get_local_player():is_alive() then
  if ui.get_key_bind("antihit_antiaim_flip_bind"):is_active() then
    renderer.text("x", fonts.arrow, vec2_t.new(screen.x / 2 + 100, screen.y / 2 + 29), 17, color_t.new(0, 0, 0, 255))
    renderer.text("x", fonts.arrow, vec2_t.new(screen.x / 2 + 100, screen.y / 2 + 31), 17, color_t.new(0, 0, 0, 255))
    renderer.text("x", fonts.arrow, vec2_t.new(screen.x / 2 + 99,  screen.y / 2 + 30), 17, color_t.new(0, 0, 0, 255))
    renderer.text("x", fonts.arrow, vec2_t.new(screen.x / 2 + 101, screen.y / 2 + 30), 17, color_t.new(0, 0, 0, 255))
    renderer.text("w", fonts.arrow, vec2_t.new(screen.x / 2 - 100, screen.y / 2 + 30), 17, color_t.new(0, 0, 0, 255))
    renderer.text("x", fonts.arrow, vec2_t.new(screen.x / 2 + 100, screen.y / 2 + 30), 17, color_t.new(mainmen.luacolor:get_value().r, mainmen.luacolor:get_value().g, mainmen.luacolor:get_value().b, 255))
  else
    renderer.text("w", fonts.arrow, vec2_t.new(screen.x / 2 - 100, screen.y / 2 + 29), 17, color_t.new(0, 0, 0, 255))
    renderer.text("w", fonts.arrow, vec2_t.new(screen.x / 2 - 100, screen.y / 2 + 31), 17, color_t.new(0, 0, 0, 255))
    renderer.text("w", fonts.arrow, vec2_t.new(screen.x / 2 - 99,  screen.y / 2 + 30), 17, color_t.new(0, 0, 0, 255))
    renderer.text("w", fonts.arrow, vec2_t.new(screen.x / 2 - 101, screen.y / 2 + 30), 17, color_t.new(0, 0, 0, 255))
    renderer.text("w", fonts.arrow, vec2_t.new(screen.x / 2 - 100, screen.y / 2 + 30), 17, color_t.new(mainmen.luacolor:get_value().r, mainmen.luacolor:get_value().g, mainmen.luacolor:get_value().b, 255))
    renderer.text("x", fonts.arrow, vec2_t.new(screen.x / 2 + 100, screen.y / 2 + 30), 17, color_t.new(0, 0, 0, 255))
   end
   end
if mainmen.wmrk:get_value() then
	renderer.texture(fonts.wm, vec2_t.new(screen.x / 2 + 80, screen.y / 2 + 374), vec2_t.new(screen.x / 2 - 83, screen.y / 2 + 354), color_t.new(markcolor1, markcolor2, markcolor3, 170))
	renderer.text(text, fonts.calibri, vec2_t.new(screen.x / 2 - 75, screen.y / 2 + 357), 15, color_t.new(textmarkcolor1, textmarkcolor2, textmarkcolor3, 255))
 end
end
--------scrindicat---------


--------exploit------------
exploitt = function(cmd)
	  if mainmen.doubletap:is_active() then
        ui.get_combo_box("rage_active_exploit"):set_value(2)
        ui.get_key_bind("rage_active_exploit_bind"):set_key(mainmen.doubletap:get_key())
        ui.get_key_bind("rage_active_exploit_bind"):set_type(mainmen.doubletap:get_type())
    end
    if mainmen.hideshots:is_active() then
        ui.get_combo_box("rage_active_exploit"):set_value(1)
        ui.get_key_bind("rage_active_exploit_bind"):set_key(mainmen.hideshots:get_key())
        ui.get_key_bind("rage_active_exploit_bind"):set_type(mainmen.hideshots:get_type())
    end
end

unldluaa = function()
    local default = ui.get_combo_box("rage_active_exploit")
    default:set_value(0)
end
--------exploit------------
local infoo = {}
local information1 = {"Warning!", "Using this function may", "impair the performance", "of the rage."}
for i1 = 1, #information1 do
    infoo[i1] = {
        textt = ui.add_combo_box(information1[i1], "comboo" .. i1, {}, 0),
    }
end
--------jumpscout----------
jumpscfun = function()
if not mainmen.jumpsc:get_value() then return end
    if engine.is_connected() then

        local localPlayer = entitylist.get_local_player()
            
        m_vecVelocity = {
            [0] = se.get_netvar("DT_BasePlayer", "m_vecVelocity[0]"),
            [1] = se.get_netvar("DT_BasePlayer", "m_vecVelocity[1]")
        }
    
        velocity = math.sqrt(localPlayer:get_prop_float(m_vecVelocity[0]) ^ 2 + localPlayer:get_prop_float(m_vecVelocity[1]) ^ 2)

        if velocity ~= nil then
            if velocity > 6 then
                ui.get_check_box("misc_autostrafer"):set_value(true)
            else
                ui.get_check_box("misc_autostrafer"):set_value(false)
            end
        else
            ui.get_check_box("misc_autostrafer"):set_value(true)
        end

    else

        velocity = nil

    end
m_hGroundEntity = entitylist.get_local_player():get_prop_int(se.get_netvar("DT_BasePlayer", "m_hGroundEntity"))
if  m_hGroundEntity == -1 then
ui.get_slider_int("rage_scout_hitchance"):set_value(mainmen.airhit:get_value())
else
ui.get_slider_int("rage_scout_hitchance"):set_value(mainmen.defaluthit:get_value())
end
end

local function on_unload()

    ui.get_check_box("misc_autostrafer"):set_value(true)

end
client.register_callback("unload", on_unload)
--------hunpscout----------

-----killefe
client.register_callback("player_death", function(event)
	
	local event_atk = engine.get_player_for_user_id(event:get_int("attacker", 0))
	if not mainmen.killeffect:get_value() then return end
	entitylist.get_entity_by_index(event_atk):set_prop_float(vars.m_flHealthShotBoostExpirationTime, globalvars.get_current_time() + 0.80)
	
end)
-----killefe

----slowd
local zxczxcss = { vec2_t.new(screen.x / 2 - 45, screen.y / 2 - 167), vec2_t.new(screen.x / 2 - 22, screen.y / 2 - 122), vec2_t.new(screen.x / 2 - 67, screen.y / 2 - 122) }
local pointsqwe = { vec2_t.new(screen.x / 2 - 45, screen.y / 2 - 163), vec2_t.new(screen.x / 2 - 25, screen.y / 2 - 124), vec2_t.new(screen.x / 2 - 64, screen.y / 2 - 124) }
checksd = function()
local velocity1 = entitylist.get_local_player():get_prop_float(vars.netvarvel)
  velspeed = math.ceil(velocity1 * 100) 
 
  if velspeed < 99 then
  --ebanash = true
  end

  if velspeed > 99 then
  -- visible = 0
  end
end


grsd = function ()
    if velspeed > 100 then return end
     colrspeed = math.min(velspeed*3, 255)
	  zalpok = 255
	 if velspeed*3 >= 200 and velspeed*3 < 210 then
	  zalpok = 240
	 end
	 if velspeed*3 >= 210 and velspeed*3 < 220 then
	  zalpok = 220
	 end
	 if velspeed*3 >= 220 and velspeed*3 < 230 then
	  zalpok = 200
	 end
	 if velspeed*3 >= 230 and velspeed*3 < 240 then
	  zalpok = 180
	 end
	 if velspeed*3 >= 240 and velspeed*3 < 250 then
	  zalpok = 160                                        
	 end
	 if velspeed*3 >= 250 and velspeed*3 < 260 then
	  zalpok = 140
	 end
	 if velspeed*3 >= 260 and velspeed*3 < 270 then
	  zalpok = 120
	 end
	 if velspeed*3 >= 270 and velspeed*3 < 280 then
	  zalpok = 100
	 end
	 if velspeed*3 >= 280 and velspeed*3 < 290 then
	  zalpok = 80
	 end
	 if velspeed*3 >= 290 and velspeed*3 < 300 then
	  zalpok = 60
	 end
	 if velspeed*3 >= 300 then
	  zalpok = 40
	 end
end

local visible = 0
drawsd = function ()
local hp123 = entitylist.get_local_player():get_prop_int(vars.helnetwar)
if hp123 == 0 then velspeed = 100  end
visible = lerp(visible, velspeed~=100 and 255 or 0, 10 * globalvars.get_frame_time())
  if not mainmen.slowd:get_value() then return end
	renderer.rect_filled(vec2_t.new(screen.x / 2 - 11, screen.y / 2 - 132), vec2_t.new(screen.x / 2 + 101, screen.y / 2 - 146), color_t.new(0 , 0, 0, visible))
	renderer.rect_filled(vec2_t.new(screen.x / 2 - 10, screen.y / 2 - 133), vec2_t.new(screen.x / 2 + velspeed, screen.y / 2 - 145), color_t.new(zalpok , colrspeed, 0, visible))
	renderer.filled_polygon(zxczxcss, color_t.new(0, 0, 0, visible))
    renderer.filled_polygon(pointsqwe, color_t.new(zalpok , colrspeed, 0, visible))
	renderer.text("!", fonts.vosc, vec2_t.new(screen.x / 2 - 49, screen.y / 2 - 157), 27, color_t.new(0 , 0, 0, visible))
	renderer.text("Velocity " .. velspeed .. "%", fonts.verdanafontt, vec2_t.new(screen.x / 2 - 9, screen.y / 2 - 162), 15, color_t.new(0 , 0, 0, visible))
    renderer.text("Velocity " .. velspeed .. "%", fonts.verdanafontt, vec2_t.new(screen.x / 2 - 10, screen.y / 2 - 163), 15, color_t.new(240 , 240, 240, visible))
end

----slowd

----sun
sunss = function ()  
    local entitylocalpl = entitylist.get_local_player()

    
    if entitylocalpl == nil then return end

 
    if not entitylocalpl:is_alive() then return end
    if mainmen.sunsetmod:get_value() then
        vars.sunsetrotoverride:set_int(1)
        
        vars.sunsetrotx:set_int(10)
        vars.sunsetroty:set_int(100)
        vars.sunsetrotz:set_int(0)
    else
        vars.sunsetrotoverride:set_int(0)
    
        vars.sunsetrotx:set_int(0)
        vars.sunsetroty:set_int(0)
        vars.sunsetrotz:set_int(0)
    end
end
---sun---

---roll--
  rollopt = function ()
        if not mainmen.roloptimiz:get_value() then return end
           if ui.get_key_bind("antihit_antiaim_flip_bind"):is_active() then
            ui.get_slider_int("antihit_antiaim_desync_roll"):set_value(mainmen.roll1:get_value())
           else
            ui.get_slider_int("antihit_antiaim_desync_roll"):set_value(mainmen.roll2:get_value())
           end   
        end  
---roll--

--antibrut
local player_vtable = ffi.cast("int*", client.find_pattern("client.dll", "55 8B EC 83 E4 F8 83 EC 18 56 57 8B F9 89 7C 24 0C") + 0x47)[0]
local get_abs_origin = ffi.cast("float*(__thiscall*)(int)", ffi.cast("int*", player_vtable + 0x28)[0])
local function dist_3d(a, b)
	return vec3_t.new(a.x - b.x, a.y - b.y, a.z - b.z):length()
end
local player_shots = {}
for i = 0, 64 do player_shots[i] = 0.0 end
local aa = ui.get_slider_int("antihit_antiaim_desync_length")
 local miss = 1
 local function get_projection(a, b, c) -- epic applied math student moment
	local length = dist_3d(b, c)
	local d = vec3_t.new(c.x - b.x, c.y - b.y, c.z - b.z)
	d = vec3_t.new(d.x / length, d.y / length, d.z / length)
	local v = vec3_t.new(a.x - b.x, a.y - b.y, a.z - b.z)
	local t = v.x * d.x + v.y * d.y + v.z * d.z
	local p = vec3_t.new(d.x * t, d.y * t, d.z * t)
	return vec3_t.new(b.x + p.x, b.y + p.y, b.z + p.z)
end
local function get_eyes_pos()
	local local_player = entitylist.get_local_player()
	if local_player == nil or not local_player:is_alive() then 
        return 0
    end
	local abs_origin = get_abs_origin(local_player:get_address())
	local view_offset = local_player:get_prop_vector(vars.m_vecViewOffset)    -------------
	return vec3_t.new(abs_origin[0] + view_offset.x, abs_origin[1] + view_offset.y, abs_origin[2] + view_offset.z)
end




client.register_callback("bullet_impact", function(event)
	local entity_id = engine.get_player_for_user_id( event:get_int("userid", 0) )
	if entity_id == engine.get_local_player() then return end
	local entity = entitylist.get_entity_by_index(entity_id)
	local from = entity:get_player_hitbox_pos(0)
	local to = vec3_t.new(event:get_float("x", 0.0), event:get_float("y", 0.0), event:get_float("z", 0.0))
	local head = get_eyes_pos()
	local closest_point = get_projection(head, from, to)
	local dist = dist_3d(closest_point, head)
    if not mainmen.antibrut:get_value() then return end
	if dist < 45 and dist_3d(from, to) >= dist_3d(from, head) - 10.0 and  player_shots[engine.get_player_for_user_id(event:get_int("userid", 0))] + 0.05 < globalvars.get_current_time() then
			if miss == 6 then
            aa:set_value(60) 
			 miss = 1
		 end 
		 
		 if miss == 5 then
			 aa:set_value(47)
			 miss = miss + 1
		 end
	 
		 if miss == 4 then
			 aa:set_value(60)
			 miss = miss + 1
		 end
	 
		 if miss == 3 then
			 aa:set_value(53)
			 miss = miss + 1
		 end
	 
	 if miss == 2 then
		 aa:set_value(53)
		 miss = miss + 1
	 end
	 
	 if miss == 1 then
		 aa:set_value(43)
		 miss = miss + 1
	 end 	 
		
	player_shots[engine.get_player_for_user_id(event:get_int("userid", 0))] = globalvars.get_current_time()
    end
end)
--antibrut
----manualroll____
local ignore_at_targets = ui.add_check_box("Ignore at targets", "ignore_at_targets", false)
local antihit_antiaim_left = ui.add_key_bind("Left", "antihit_antiaim_left", 0, 2)
local antihit_antiaim_backwards = ui.add_key_bind("Backwards", "antihit_antiaim_backwards", 0, 2)
local antihit_antiaim_right = ui.add_key_bind("Right", "antihit_antiaim_right", 0, 2)
local a1337 = ui.add_key_bind("a1337", "sadasdbdfwqer", 69, 1)
a1337:set_visible(false)
ignore_at_targets:set_visible(false)
local antihit_antiaim_yaw = 0

local function get_antihit_antiaim_yaw()
    if client.is_key_clicked(antihit_antiaim_left:get_key()) then
        if antihit_antiaim_yaw == 1 then
        return 0
    end
        antihit_antiaim_yaw = 1
    end
    if client.is_key_clicked(antihit_antiaim_backwards:get_key()) then
        if antihit_antiaim_yaw == 2 then
        return 0
    end
        antihit_antiaim_yaw = 2
    end
    if client.is_key_clicked(antihit_antiaim_right:get_key()) then
        if antihit_antiaim_yaw == 3 then
        return 0
    end
        antihit_antiaim_yaw = 3
    end
    return antihit_antiaim_yaw
end

local function on_paint()
    antihit_antiaim_yaw = get_antihit_antiaim_yaw()
end

local a = ui.get_check_box("antihit_antiaim_at_targets"):get_value()
local b = ui.get_combo_box("antihit_antiaim_pitch"):get_value()

local function on_create_move(cmd)
  if a1337:is_active() then
      ui.get_combo_box("antihit_antiaim_yaw"):set_value(0)
      ui.get_combo_box("antihit_antiaim_pitch"):set_value(0)
      return
  else
    if ui.get_combo_box("antihit_antiaim_pitch"):get_value() == 0 then
        ui.get_combo_box("antihit_antiaim_pitch"):set_value(b)
    end
    b = ui.get_combo_box("antihit_antiaim_pitch"):get_value()
    if antihit_antiaim_yaw == 0 then
        if ui.get_combo_box("antihit_antiaim_yaw"):get_value() ~= 1 then
            ui.get_check_box("antihit_antiaim_at_targets"):set_value(a)
        end
        ui.get_combo_box("antihit_antiaim_yaw"):set_value(1)
    end
    if antihit_antiaim_yaw == 1 then
        ui.get_combo_box("antihit_antiaim_yaw"):set_value(2)
        if ignore_at_targets:get_value() then
            ui.get_check_box("antihit_antiaim_at_targets"):set_value(false)
        end
    end
    if antihit_antiaim_yaw == 2 then
        if ui.get_combo_box("antihit_antiaim_yaw"):get_value() ~= 1 then
            ui.get_check_box("antihit_antiaim_at_targets"):set_value(a)
        end
        ui.get_combo_box("antihit_antiaim_yaw"):set_value(1)
    end
    if antihit_antiaim_yaw == 3 then
        ui.get_combo_box("antihit_antiaim_yaw"):set_value(3)
        if ignore_at_targets:get_value() then
            ui.get_check_box("antihit_antiaim_at_targets"):set_value(false)
        end
    end
    if ui.get_combo_box("antihit_antiaim_yaw"):get_value() == 1 then
        a = ui.get_check_box("antihit_antiaim_at_targets"):get_value()
    end
  end
end



client.register_callback("paint", on_paint)
client.register_callback("create_move", on_create_move)
-------manualll

-------tank------
local jitteroffset1 = ui.add_slider_int("Jitter offset", "jitter_offset1", 0, 50, 28)
local leftmanual = ui.add_key_bind("Manual Left", "left_manual", 0, 1)
local rightmanual = ui.add_key_bind("Manual Right", "right_manual", 0, 1)

local m_vecVelocity = se.get_netvar("DT_BasePlayer", "m_vecVelocity[0]")
local netMoveType = se.get_netvar("DT_BaseEntity", "m_nRenderMode") + 1
local m_hActiveWeapon = se.get_netvar("DT_BaseCombatCharacter", "m_hActiveWeapon")
local m_fThrowTime = se.get_netvar("DT_BaseCSGrenade", "m_fThrowTime")
local m_flDuckAmount = se.get_netvar("DT_BasePlayer", "m_flDuckAmount")
local m_vecOrigin = se.get_netvar("DT_BaseEntity", "m_vecOrigin")
local m_hCarriedHostage = se.get_netvar("DT_CSPlayer", "m_hCarriedHostage")

ffi.cdef[[
	struct WeaponInfo_t
	{
		char _0x0000[6];
		uint8_t classID;
		char _0x0007[13];
		__int32 max_clip;	
		char _0x0018[12];
		__int32 max_reserved_ammo;
		char _0x0028[96];
		char* hud_name;			
		char* weapon_name;		
		char _0x0090[60];
		__int32 type;			
	};
	struct Animstate_t
	{ 
		char pad[ 3 ];
		char m_bForceWeaponUpdate;
		char pad1[ 91 ];
		void* m_pBaseEntity;
		void* m_pActiveWeapon;
		void* m_pLastActiveWeapon;
		float m_flLastClientSideAnimationUpdateTime;
		int m_iLastClientSideAnimationUpdateFramecount;
		float m_flAnimUpdateDelta;
		float m_flEyeYaw;
		float m_flPitch;
		float m_flGoalFeetYaw;
	};
]]


local weapon_data_call = ffi.cast("int*(__thiscall*)(void*)", client.find_pattern("client.dll", "55 8B EC 81 EC ? ? ? ? 53 8B D9 56 57 8D 8B ? ? ? ? 85 C9 75 04"))

local function weapon_data(weapon)
	return ffi.cast("struct WeaponInfo_t*", weapon_data_call(ffi.cast("void*", weapon:get_address())))
end

local function get_animstate()
	local entity = entitylist.get_local_player()
	return ffi.cast("struct Animstate_t**", entity:get_address() + 0x9960)[0]
end

local function clamp_yaw(yaw)
	while yaw < -180.0 do yaw = yaw + 360.0 end
	while yaw > 180.0 do yaw = yaw - 360.0 end
	return yaw
end

local e_pressed = false
local jitter_side = 1
local freezetime = false
local manual_side = 0 -- 0 backwards, -1 left, 1 right
local lby_update_time = 0.0
local lby_force_choke = false

local function get_current_desync(mod_yaw)
	local animstate = get_animstate()
	return math.abs(mod_yaw - math.abs(clamp_yaw(engine.get_view_angles().yaw - animstate.m_flGoalFeetYaw))) -- CO3DAT3JIb JS REZOLVER
end

local function is_nade(lp)
	return weapon_data(entitylist.get_entity_from_handle(lp:get_prop_int(m_hActiveWeapon))).type == 0
end

local function is_throwing(lp)
	return entitylist.get_entity_from_handle(lp:get_prop_int(m_hActiveWeapon)):get_prop_float(m_fThrowTime) > 0.1
end

local function hasbit(x, p) return x % (p + p) >= p end

local function get_lby_breaker_time(fd)
	return fd and 0.4 or 0.055
end



local function checks(cmd, lp)
	if freezetime then return true end
	local move_type = lp:get_prop_int(netMoveType)
	if move_type == 8 or move_type == 9 then return true end
	if is_nade(lp) and not is_throwing(lp) then return false end
	if is_nade(lp) and is_throwing(lp) then return true end
	if hasbit(cmd.buttons, bit32.lshift(1, 0)) then return true end
end

local function micro_move(cmd, lp)
	local move = 1.10
	if (lp:get_prop_float(m_flDuckAmount) > 0.1) then move = move * 3.0 end
	if cmd.command_number % 2 == 0 then move = -move end
	cmd.sidemove = cmd.sidemove + move
end

local function manual_aa()
   -- if not mainmen.aapres:get_value() == 1 then return end
	if client.is_key_clicked(leftmanual:get_key()) then
		if manual_side == -1 then manual_side = 0 else manual_side = -1 end
	end
	if client.is_key_clicked(rightmanual:get_key()) then
		if manual_side == 1 then manual_side = 0 else manual_side = 1 end
	end
end

local function break_lby(cmd, lby, lp, fd)
	if clientstate.get_choked_commands() >= 13 and fd then return 0 end
	if globalvars.get_current_time() >= lby_update_time then
		cmd.send_packet = false
		lby_force_choke = true
		lby_update_time = globalvars.get_current_time() + get_lby_breaker_time(fd)
        micro_move(cmd, lp)
        return lby
	end
	if lby_force_choke then
		lby_force_choke = false
		cmd.send_packet = false
	end
    return 0
end

local function main(cmd)
    if mainmen.aapres:get_value() == 1 then
        antihit_antiaim_left:set_key(0)
        antihit_antiaim_right:set_key(0)
    if not mainmen.aapres:get_value() == 1 then return end
	local lp = entitylist.get_local_player()
	if not lp or not lp:is_alive() then return end
	if checks(cmd, lp) then return end
    cmd.viewangles.yaw = 180
	cmd.viewangles.pitch = 90
	local in_use = hasbit(cmd.buttons, bit32.lshift(1, 5))
	local is_standing = lp:get_prop_vector(m_vecVelocity):length() < 4

	if in_use then
		local pos = lp:get_prop_vector(m_vecOrigin)
		local C4 = entitylist.get_entities_by_class("CPlantedC4")
		local hostages = entitylist.get_entities_by_class("CHostage")
		if  (#C4 ~= 0 and C4[1]:get_prop_vector(m_vecOrigin):dist_to(pos) <= 75) or 
			(weapon_data(entitylist.get_entity_from_handle(lp:get_prop_int(m_hActiveWeapon))).classID == 207)
		then return end
		if #hostages > 0 then
			for i = 1, #hostages do
				if hostages[i]:get_prop_vector(m_vecOrigin):dist_to(pos) <= 75 and lp:get_prop_int(m_hCarriedHostage) == -1 then return end
			end
		end
	end

	ui.get_check_box("antihit_fakelag_enable"):set_value(false)
    ui.get_check_box("antihit_antiaim_enable"):set_value(false)
	local fakelag_limit = ui.get_slider_int("antihit_fakelag_limit")
    local fakelag = fakelag_limit:get_value() or 1
	if fakelag == 0 then fakelag_limit:set_value(1) end
	fakelag = 15 
    local exploit_is_active = ui.get_key_bind("rage_active_exploit_bind"):is_active()
	local fakeduck_is_active = ui.get_key_bind("antihit_extra_fakeduck_bind"):is_active()
    if not fakeduck_is_active and not exploit_is_active then
        cmd.send_packet = (fakelag <= clientstate.get_choked_commands())
	elseif exploit_is_active and not fakeduck_is_active then cmd.send_packet = (cmd.command_number % 2 == 0) end

	local first_time_e_pressed = false
	if e_pressed then cmd.buttons = bit32.band(cmd.buttons, -33) end
	if e_pressed ~= in_use then first_time_e_pressed = true end
	e_pressed = in_use
	
	local inverter = false
	local viewangles = engine.get_view_angles()
	local yaw = viewangles.yaw - 180 + (inverter and 0 or 0)
	--local movement = movement_type(lp, fakeduck_is_active)

		yaw = yaw + (jitteroffset1:get_value() * -1) * jitter_side

	if in_use then
		yaw = yaw + 180
		inverter = not inverter
	end

	if not cmd.send_packet then
		 jitter_side = jitter_side * -1 
	end

    local lby = 0
	local delta =  -1
	if ((not is_standing and lby ~= 0) or lby == 0) and get_current_desync(viewangles.yaw - yaw) < math.abs(delta) then
		delta = (delta / math.abs(delta)) * 120
	end

    if is_standing then
        if lby ~= 0 then
            yaw = yaw + break_lby(cmd, lby, lp, fakeduck_is_active)
            delta = delta * 2
        else micro_move(cmd, lp) end
    end

	if not cmd.send_packet and not first_time_e_pressed then yaw = yaw - delta end

	manual_aa()

	
	if not in_use then yaw = yaw + (90 * manual_side) end
	if in_use then
		yaw = viewangles.yaw    
		inverter = not inverter
	end
	--send yaw and pitch to server
	cmd.viewangles.yaw = yaw
	cmd.viewangles.pitch = 90

	--sets our pitch to natural if pitch slider is on 0
	if in_use  then cmd.viewangles.pitch = viewangles.pitch end
    end
end
client.register_callback("create_move", main)
client.register_callback("round_prestart", function()
    freezetime = true
    lby_update_time = get_lby_breaker_time(ui.get_key_bind("antihit_extra_fakeduck_bind"):is_active())
	manual_side = 0
end)
client.register_callback("round_freeze_end", function() freezetime = false end)

--------tank

----stat-----
ffi.cdef[[
    typedef uintptr_t (__thiscall* GetClientEntity_4242425_t)(void*, int);
]]

local ENTITY_LIST_POINTER = ffi.cast("void***", se.create_interface("client.dll", "VClientEntityList003")) or error("Failed to find VClientEntityList003!")
local GET_CLIENT_ENTITY_FN = ffi.cast("GetClientEntity_4242425_t", ENTITY_LIST_POINTER[0][3])

local ffi_helpers = {
    get_entity_address = function(entity_index)
        local addr = GET_CLIENT_ENTITY_FN(ENTITY_LIST_POINTER, entity_index)
        return addr
    end
}

local m_flPoseParameter = se.get_netvar("DT_BaseAnimating", "m_flPoseParameter")

statleeg = function()
  if mainmen.statlegss:get_value() then
    local localplayer = entitylist.get_local_player()
	if not localplayer then return end
    ffi.cast("float*", ffi_helpers.get_entity_address(localplayer:get_index()) + m_flPoseParameter)[0] = 0
    local antihit_extra_leg_movement = ui.get_combo_box("antihit_extra_leg_movement")
    if clientstate.get_choked_commands() == 0 then
        antihit_extra_leg_movement:set_value(2)
    else
        antihit_extra_leg_movement:set_value(1)
    end
end
end

ffi.cdef[[
    typedef uintptr_t (__thiscall* GetClientEntity_4242425_t)(void*, int);

    typedef struct
    {
        float x;
        float y;
        float z;
    } Vector_t;

    typedef struct
    {
        char        pad0[0x60]; // 0x00
        void*       pEntity; // 0x60
        void*       pActiveWeapon; // 0x64
        void*       pLastActiveWeapon; // 0x68
        float        flLastUpdateTime; // 0x6C
        int            iLastUpdateFrame; // 0x70
        float        flLastUpdateIncrement; // 0x74
        float        flEyeYaw; // 0x78
        float        flEyePitch; // 0x7C
        float        flGoalFeetYaw; // 0x80
        float        flLastFeetYaw; // 0x84
        float        flMoveYaw; // 0x88
        float        flLastMoveYaw; // 0x8C // changes when moving/jumping/hitting ground
        float        flLeanAmount; // 0x90
        char        pad1[0x4]; // 0x94
        float        flFeetCycle; // 0x98 0 to 1
        float        flMoveWeight; // 0x9C 0 to 1
        float        flMoveWeightSmoothed; // 0xA0
        float        flDuckAmount; // 0xA4
        float        flHitGroundCycle; // 0xA8
        float        flRecrouchWeight; // 0xAC
        Vector_t    vecOrigin; // 0xB0
        Vector_t    vecLastOrigin;// 0xBC
        Vector_t    vecVelocity; // 0xC8
        Vector_t    vecVelocityNormalized; // 0xD4
        Vector_t    vecVelocityNormalizedNonZero; // 0xE0
        float        flVelocityLenght2D; // 0xEC
        float        flJumpFallVelocity; // 0xF0
        float        flSpeedNormalized; // 0xF4 // clamped velocity from 0 to 1
        float        flRunningSpeed; // 0xF8
        float        flDuckingSpeed; // 0xFC
        float        flDurationMoving; // 0x100
        float        flDurationStill; // 0x104
        bool        bOnGround; // 0x108
        bool        bHitGroundAnimation; // 0x109
        char        pad2[0x2]; // 0x10A
        float        flNextLowerBodyYawUpdateTime; // 0x10C
        float        flDurationInAir; // 0x110
        float        flLeftGroundHeight; // 0x114
        float        flHitGroundWeight; // 0x118 // from 0 to 1, is 1 when standing
        float        flWalkToRunTransition; // 0x11C // from 0 to 1, doesnt change when walking or crouching, only running
        char        pad3[0x4]; // 0x120
        float        flAffectedFraction; // 0x124 // affected while jumping and running, or when just jumping, 0 to 1
        char        pad4[0x208]; // 0x128
        float        flMinBodyYaw; // 0x330
        float        flMaxBodyYaw; // 0x334
        float        flMinPitch; //0x338
        float        flMaxPitch; // 0x33C
        int            iAnimsetVersion; // 0x340
    } CCSGOPlayerAnimationState_534535_t;
]]

local entity_list_ptr = ffi.cast("void***", se.create_interface("client.dll", "VClientEntityList003"))
local get_client_entity_fn = ffi.cast("GetClientEntity_4242425_t", entity_list_ptr[0][3])

local ffi_helpers = {
    get_entity_address = function(ent_index)
        local addr = get_client_entity_fn(entity_list_ptr, ent_index)
        return addr
    end
}

local offset_value = 0x9960
local shared_onground

statleg2 = function()
   if mainmen.statlegss:get_value() then
    local localplayer = entitylist.get_local_player()
    if not localplayer then return end
    local bOnGround = bit.band(localplayer:get_prop_float(vars.m_fFlags), bit.lshift(1,0)) ~= 0
    if not bOnGround then
        ffi.cast("CCSGOPlayerAnimationState_534535_t**", ffi_helpers.get_entity_address(localplayer:get_index()) + offset_value)[0].flDurationInAir = 99
        ffi.cast("CCSGOPlayerAnimationState_534535_t**", ffi_helpers.get_entity_address(localplayer:get_index()) + offset_value)[0].flHitGroundCycle = 0
        ffi.cast("CCSGOPlayerAnimationState_534535_t**", ffi_helpers.get_entity_address(localplayer:get_index()) + offset_value)[0].bHitGroundAnimation = false
    end

    shared_onground = bOnGround
end
end

statleg3 = function ()
   if mainmen.statlegss:get_value() then
    local localplayer = entitylist.get_local_player()
    if not localplayer then return end
    local bOnGround = bit.band(localplayer:get_prop_float(vars.m_fFlags), bit.lshift(1,0)) ~= 0
    if bOnGround and not shared_onground then 
        ffi.cast("CCSGOPlayerAnimationState_534535_t**", ffi_helpers.get_entity_address(localplayer:get_index()) + offset_value)[0].flDurationInAir = 0.5
    end 
end
end 
----stat-----

---thdist

function moveDetected1(cmd) 
engine.execute_client_cmd("cam_idealdist " ..  mainmen.sliderFakeLagF:get_value())
end
---thdist

--clantag


--clantag


-----logs----
local bit = require("bit")
local lerp = function(lstart, lend, time)
    return lstart + (lend - lstart) * time
end

local logger = {}
logger.color_scheme = {
	["spread"] = {r = 255, g = 255, b = 0, a = 255},
	["occlusion"] = {r = 255, g = 255, b = 0, a = 255},
	["death"] = {r = 0, g = 255, b = 0, a = 255},
	["resolver"] = {r = 255, g = 0, b = 0, a = 255},
	["unknown"] =  {r = 255, g = 0, b = 0, a = 255}
}
logger.hitboxes = {
    [0] = "generic",
	[1] = "head",
	[2] = "chest",
	[3] = "stomach",
	[4] = "left arm",
	[5] = "right arm", 
	[6] = "left leg",
	[7] = "right leg", 
	[10] = "gear"
}
local screen = engine.get_screen_size()
logger.font_size = 12
logger.to_render = {}
logger.renderer = function()
if not mainmen.logger_type:get_value() then return end
	local offset = 0
	for i = 1, #logger.to_render do
		if logger.to_render[i] then
			renderer.text(logger.to_render[i].text, fonts.logverd, vec2_t.new(screen.x / 2 - 120 + 1, screen.y / 2 + 150 + 1 - 12 + logger.to_render[i].anim * i + offset), logger.font_size, color_t.new(0, 0, 0, logger.to_render[i].color.a))
			renderer.text(logger.to_render[i].text, fonts.logverd, vec2_t.new(screen.x / 2 - 120, screen.y / 2 + 150 - 12 + logger.to_render[i].anim * i + offset), logger.font_size, logger.to_render[i].color)
			offset = offset + logger.to_render[i].anim
			if logger.to_render[i].time + 5 < globalvars.get_real_time() then
				logger.to_render[i].color.a = lerp(logger.to_render[i].color.a, 0, 8 * globalvars.get_absolute_frametime())
				if logger.to_render[i].color.a < 1 then
					table.remove(logger.to_render, i)
				end
			else
				logger.to_render[i].anim = lerp(logger.to_render[i].anim, 7, 8 * globalvars.get_absolute_frametime())
			end
		end
	end
end
logger.add_log = function(text, color)
if not mainmen.logger_type:get_value() then return end
		table.insert(logger.to_render, 1, {
			["color"] = color,
			["text"] = text,
			["time"] = globalvars.get_real_time(),
			["anim"] = 0
		})
end
client.register_callback("paint", logger.renderer)
client.register_callback("shot_fired", function(shot_info) 
	if shot_info.manual == false then
		if menu.log_info:get_value(2) == true then
			logger.add_log("Fired at [" .. engine.get_player_info(shot_info.target:get_index()).name .. "] HITBOX [" .. logger.hitboxes[shot_info.hitbox + 1] .. "] BT [" .. tostring(shot_info.backtrack) .. "] DMG [" .. tostring(shot_info.client_damage) .. "] HC [" .. tostring(shot_info.hitchance) .. "]", color_t.new(255, 255, 255, 255))
		end
		if menu.log_info:get_value(3) == true and shot_info.result ~= "hit" then
			if shot_info.result == "desync" then shot_info.result = "resolver" end
			if shot_info.result == "unk" then shot_info.result = "unknown" end
			local color = logger.color_scheme[shot_info.result]
			logger.add_log("Missed shot due to " .. shot_info.result, color_t.new(color.r, color.g, color.b, color.a))
		end
	end
end)
client.register_callback("player_hurt", function(event) 
	local attacker = engine.get_player_for_user_id(event:get_int("attacker", 0))
	local target = engine.get_player_for_user_id(event:get_int("userid", 0))
	local dmg_dealt = tostring(event:get_int("dmg_health", 0))
	local dmg_remainig = tostring(event:get_int("health", 0))
	local hitbox = "unknown"
	if ((event:get_int("hitgroup", 0) > -1 and event:get_int("hitgroup", 0) < 8) or event:get_int("hitgroup", 0) ~= 10) then hitbox = logger.hitboxes[event:get_int("hitgroup", 0)] end
	if type(hitbox) ~= "string" then hitbox = "unknown" end
	if menu.log_info:get_value(0) == true then
		if engine.get_local_player() == attacker then
			logger.add_log("Hit " .. engine.get_player_info(target).name .. "'s " .. hitbox .. " for " .. dmg_dealt .. " hp (" .. dmg_remainig .. " remaining)", color_t.new(255, 255, 255, 255))
		end
	end
	if menu.log_info:get_value(1) == true then
		if engine.get_local_player() == target then
			logger.add_log("Harmed by " .. (engine.get_player_info(attacker).name == "" and "world" or engine.get_player_info(attacker).name) .. " for " .. dmg_dealt .. " hp in " .. hitbox, color_t.new(255, 255, 255, 255))
		end
	end
end)
-----logs----

--trash
local messages = {
    "piv.pivpiv.dk -> free robux",
    "nice memesense retard",
    "missed cum shot due to your face",
    "click on unload cheat, best function",
    "ROFL NICE *DEAD* HHHHHHHHHHHHHHHHHH",
    "ez?",
    "tranny holzed",
    "local iq = 1",
    "neverlose - die or die",
	"kys",
	"mad?",
	"The only thing you carry is an extra chromosome.",
	"Options -> How To Play",
	"Is your monitor on?",
	"My knife is well-worn, just like your mother.",
	"You define autism"
    }
    
    client.register_callback("player_death", function(event)
        if not mainmen.trashtlk:get_value() then return end
        local attacker_index = engine.get_player_for_user_id(event:get_int("attacker",0))
        local died_index = engine.get_player_for_user_id(event:get_int("userid",1))
        local me = engine.get_local_player()
        
        math.randomseed(os.clock()*100000000)
    
            if attacker_index == me and died_index ~= me then            
                engine.execute_client_cmd("say " .. tostring(messages[math.random(1, #messages)]))
            end
    end)
---trasht

jitdesync = function()
if not mainmen.jitdesbox:get_value() then return end
if  clientstate.get_choked_commands() == 0 then 
        ui.get_key_bind("antihit_antiaim_flip_bind"):set_key(0)
        
        if ui.get_key_bind("antihit_antiaim_flip_bind"):get_type() == 0 then
            ui.get_key_bind("antihit_antiaim_flip_bind"):set_type(2)
        else
            ui.get_key_bind("antihit_antiaim_flip_bind"):set_type(0)
			end
    end
end
---buy bot
client.register_callback("round_start", function(event)
    is_round_started = true
end)

client.register_callback("round_prestart", function(event)
    is_round_started = true
end)




client.register_callback("create_move", function(cmd)
	
	if is_round_started then
		buy_bot( )
		is_round_started = false
	end

end)

is_round_started = false

pistols_list = {
	["0"] = "",
	["1"] = "buy glock; buy hkp2000; buy usp_silencer;",
	["2"] = "buy elite;",
	["3"] = "buy p250;",
	["4"] = "buy tec9; buy fiveseven;",
	["5"] = "buy deagle; buy revolver;",
}

pistols_name_list = {

	"None",
	"Glock-18/HKP2000/USP-S",
	"Dual Berretas",
	"P250",
	"Tec-9/Five7",
	"Deagle/Revolver"

}

weapons_list = {
	["0"] = "",
	["1"] = "buy ssg08;",
	["2"] = "buy awp;",
	["3"] = "buy scar20; buy g3sg1;",
	["4"] = "buy galilar; buy famas;",
	["5"] = "buy ak47; buy m4a1; buy m4a1_silencer;",
	["6"] = "buy sg556; buy aug;",
	["7"] = "buy nova;",
	["8"] = "buy xm1014;",
	["9"] = "buy mag7;",
	["10"] = "buy m249;",
	["11"] = "buy negev;",
	["12"] = "buy mac10; buy mp9;",
	["13"] = "buy mp7;",
	["14"] = "buy ump45;",
	["15"] = "buy p90;",
	["16"] = "buy bizon;"
}

weapons_name_list = {

	"None",
	"SSG08",
	"AWP",
	"Scar20/G3SG1",
	"GalilAR/Famas",
	"AK-47/M4A1",
	"AUG/SG556",
	"Nova",
	"XM1014",
	"Mag-7",
	"M249",
	"Negev",
	"Mac-10/MP9",
	"MP7",
	"UMP-45",
	"P90",
	"Bizon"

}

other_list = {
	["0"] = "buy vesthelm;",
	["1"] = "buy hegrenade;",
	["2"] = "buy molotov; buy incgrenade;",
	["3"] = "buy smokegrenade;",
	["4"] = "buy taser;",
	["5"] = "buy defuser;"
}

other_name_list = {

	"Armor",
	"HE",
	"Molotov/Incgrenade",
	"Smoke",
	"Taser",
	"Defuser"

}

function buy_bot( )

	local pistol = pistols_list[tostring(buy_pistol:get_value(""))]
	local weapon = weapons_list[tostring(buy_weapon:get_value(""))]
	local other  = ""

	for i = 0, 5 do
		other = other..(buy_other:get_value(i) and other_list[tostring(i)] or "")
	end

	engine.execute_client_cmd(pistol)
	engine.execute_client_cmd(weapon)
	engine.execute_client_cmd(other)

end

 buy_pistol = ui.add_combo_box("Pistol", "_pistols", pistols_name_list, 0)
 buy_weapon = ui.add_combo_box("Weapon", "_weapons", weapons_name_list, 0)
 buy_other = ui.add_multi_combo_box("Other", "_other", other_name_list, { false, false, false, false, false, false })
---buyb


------------------------------------------keybind
local keybinds_x = ui.add_slider_int("keybind_x", "keybinds_x", 0, engine.get_screen_size().x, 345)
local keybinds_y = ui.add_slider_int("keybind_y", "keybinds_y", 0, engine.get_screen_size().y, 215)

--local verdana = renderer.setup_font("C:/windows/fonts/verdana.ttf", 12, 0)
local types = { "always", "hold", "toggle", "disabled" }


function math.lerp(a, b, t) return a + (b - a) * t end
local function drag(x, y, width, height, xmenu, ymenu, item)
    local cursor = renderer.get_cursor_pos()
    if (cursor.x >= x) and (cursor.x <= x + width) and (cursor.y >= y) and (cursor.y <= y + height) then
        if client.is_key_pressed(1) and item[1] == 0 then
            item[1] = 1
            item[2] = x - cursor.x
            item[3] = y - cursor.y
        end
    end
    if not client.is_key_pressed(1) then item[1] = 0 end
    if item[1] == 1 and ui.is_visible() then
		xmenu:set_value(cursor.x + item[2])
		ymenu:set_value(cursor.y + item[3])
    end
end

local function filledbox(x, y, w, h, al)
renderer.texture(fonts.wm, vec2_t.new(x, y), vec2_t.new(x + w, y + h), color_t.new(markcolor1, markcolor2, markcolor3, 180 * al))
	--renderer.rect_filled(vec2_t.new(x, y), vec2_t.new(x + w, y + h), color_t.new(markcolor1, markcolor2, markcolor3, 255 * al))
end
local item = { 0, 0, 0 }
local animwidth = 0;
local alpha = { 0 }
local bind = {
["Double tap"] = {reference = ui.get_key_bind("rage_active_exploit_bind"), exploit = 2, add = 0, multiply = 0},
["Hide shots"] = {reference = ui.get_key_bind("rage_active_exploit_bind"), exploit = 1, add = 0, multiply = 0},
["Inverter"] = {reference = ui.get_key_bind("antihit_antiaim_flip_bind"), exploit = 0, add = 0, multiply = 0},
["Auto peek"] = {reference = ui.get_key_bind("antihit_extra_autopeek_bind"), exploit = 0, add = 0, multiply = 0},
["Slow walk"] = {reference = ui.get_key_bind("antihit_extra_slowwalk_bind"), exploit = 0, add = 0, multiply = 0},
["Fake duck"] = {reference = ui.get_key_bind("antihit_extra_fakeduck_bind"), exploit = 0, add = 0, multiply = 0},
["Jump bug"] = {reference = ui.get_key_bind("misc_jump_bug_bind"), exploit = 0, add = 0, multiply = 0},
["Edge jump"] = {reference = ui.get_key_bind("misc_edge_jump_bind"), exploit = 0, add = 0, multiply = 0},
["Min damage"] = {reference = mainmen.dmgbind, exploit = 0, add = 0, multiply = 0},
["Force body"] = {reference = mainmen.baimkyy, exploit = 0, add = 0, multiply = 0},
};
client.register_callback("paint", function()

	keybinds_x:set_visible(false) keybinds_y:set_visible(false)
	
	
	local function keybinds()
		if mainmen.keybindss:get_value() and engine.is_connected() then
			local pos = {x = keybinds_x:get_value(), y = keybinds_y:get_value()}
			local alphak, keybinds = {}, {}
			local width, maxwidth = 25, 0;
			local height = 17;
			local bind_y = height + 4
			
			for i,v in pairs(bind) do
				local exploits = ui.get_combo_box("rage_active_exploit"):get_value(); v.add = math.lerp(v.add, v.reference:is_active() and 255 or 0, 0.1); v.multiply = v.add > 4 and 1 or 0;
				if v.add > 4 then if v.exploit == 0 then table.insert(keybinds, i) end; if v.exploit ~= 0 and exploits == v.exploit then table.insert(keybinds, i) end; end;
				if v.exploit == 0 and v.reference:is_active() then table.insert(alphak, i) end; if v.exploit ~= 0 and exploits == v.exploit and v.reference:is_active() then table.insert(alphak, i) end;
			end
			if #alphak ~= 0 or ui.is_visible() then alpha[1] = math.lerp(alpha[1], 200, 0.1) end; if #alphak == 0 and not ui.is_visible() then alpha[1] = math.lerp(alpha[1], 0, 0.1) end		
			for k,f in pairs(keybinds) do if renderer.get_text_size(fonts.calibrikey, 13, f .. "["..types[bind[f].reference:get_type() + 1].."]").x > maxwidth then maxwidth = renderer.get_text_size(fonts.calibrikey, 13, f .. "["..types[bind[f].reference:get_type() + 1].."]").x; end; end
			if maxwidth == 0 then maxwidth = 50 end; width = width + maxwidth; if width < 130 then width = 130 end if animwidth == 0 then animwidth = width end; animwidth = math.lerp(animwidth, width, 0.1)
			w = false and ( 1 and animwidth or width) or 150
			for k,f in pairs(keybinds) do  
				local v = bind[f]; bind_y = bind_y + ( 1 and 20 * (v.add / 255) or 20 * v.multiply); plus = bind_y - ( 1 and 20 * (v.add / 255) or 20 * v.multiply);
				renderer.text(f, fonts.calibrikey, vec2_t.new(pos.x + 5, pos.y + plus + 1), 13, color_t.new(0, 0, 0, 255 * (v.add / 255)))
				renderer.text(f, fonts.calibrikey, vec2_t.new(pos.x + 4, pos.y + plus), 13, color_t.new(255, 255, 255, 255 * (v.add / 255)))
				renderer.text("["..types[v.reference:get_type() + 1].."]", fonts.calibrikey, vec2_t.new(pos.x + w - renderer.get_text_size(fonts.calibrikey, 13, "["..types[v.reference:get_type() + 1].."]").x - 3, pos.y + plus + 1), 13, color_t.new(0, 0, 0, 255 * (v.add / 255)))
				renderer.text("["..types[v.reference:get_type() + 1].."]", fonts.calibrikey, vec2_t.new(pos.x + w - renderer.get_text_size(fonts.calibrikey, 13, "["..types[v.reference:get_type() + 1].."]").x - 4, pos.y + plus), 13, color_t.new(255, 255, 255, 255 * (v.add / 255)))
			end
			if alpha[1] > 1 then
				filledbox(pos.x, pos.y, w, height, (alpha[1] / 200))
				--renderer.text("keybinds", fonts.calibrikey, vec2_t.new(pos.x + (w /2) - (renderer.get_text_size(fonts.calibrikey, 13, "keybinds").x /2) + 2, pos.y + 3), 13, color_t.new(0, 0, 0, 255 * (alpha[1] / 255)))
				--renderer.text("keybinds", fonts.calibrikey, vec2_t.new(pos.x + (w /2) - (renderer.get_text_size(fonts.calibrikey, 13, "keybinds").x /2) + 1, pos.y + 2), 13, color_t.new(textmarkcolor1, textmarkcolor2, textmarkcolor3, 255 * (alpha[1] / 255)))
				renderer.text("E", fonts.keyb, vec2_t.new(pos.x + (w /2) - (renderer.get_text_size(fonts.keyb, 30, "E").x /2) + 0, pos.y - 8), 30, color_t.new(textmarkcolor1, textmarkcolor2, textmarkcolor3, 255 * (alpha[1] / 255)))
				drag(pos.x, pos.y, w, height + 2, keybinds_x, keybinds_y, item)
				--print(tostring(alpha[1]))
			end
		end
	end
 keybinds();
end)

-----------------------------------------keybind



-----------------------------------statpane


local antiaim = {}
antiaim.GetPlayerState = function () -- * get the current antiaim state
    localPlayer = entitylist.get_local_player()
    m_hGroundEntity = localPlayer:get_prop_int(se.get_netvar("DT_BasePlayer", "m_hGroundEntity"))
    duck = localPlayer:get_prop_int(se.get_netvar("DT_BasePlayer", "m_bDucked"))
    velocity = math.sqrt(localPlayer:get_prop_float(se.get_netvar("DT_BasePlayer", "m_vecVelocity[0]")) ^ 2 + localPlayer:get_prop_float(se.get_netvar("DT_BasePlayer", "m_vecVelocity[1]")) ^ 2)
    if m_hGroundEntity == -1 then
        return 4
    end
    if m_hGroundEntity ~= -1 and duck == 1 then
        return 2
    end
  if localPlayer:get_prop_int(se.get_netvar("DT_BasePlayer", "m_hGroundEntity")) ~= -1 and velocity > 5 then
    if ui.get_key_bind("antihit_extra_slowwalk_bind"):is_active() then
      return 5
    end
    return 1
  end
  return 3
end

-- * get the current antiaim side
antiaim.GetInverterState = function ()
    local is_inverted = ui.get_key_bind("antihit_antiaim_flip_bind"):is_active() and ">" or "<"
    return is_inverted
end

-- * normal render outline function
renderer.outlined_text = function (text, font, pos, size, colorg, colort)
    local Position = { vec2_t.new(pos.x + 1, pos.y), vec2_t.new(pos.x - 1, pos.y), vec2_t.new(pos.x, pos.y + 1), vec2_t.new(pos.x, pos.y - 1) }
    renderer.text(text, font, Position[1], size, colort)
    renderer.text(text, font, Position[2], size, colort)
    renderer.text(text, font, Position[3], size, colort)
    renderer.text(text, font, Position[4], size, colort)
    renderer.text(text, font, pos, size, colorg)
end

local hits = 0
local misses = 0
client.register_callback("shot_fired", function (shot_info)
    if shot_info.result ~= "hit" and not shot_info.manual then
        misses = misses + 1
    end
    if shot_info.result == "hit" and not shot_info.manual then
        hits = hits + 1
    end
end)

local statePanel = {}
statePanel.state = {
    {Preset = 'moving'},
    {Preset = 'crouching'},
    {Preset = 'standing'},
    {Preset = 'jumping'},
    {Preset = 'slowwalking'},
}
statePanel.color = { white = color_t.new(255, 255, 255, 255), light_blue = color_t.new(200, 200, 255, 255), light_green = color_t.new(206, 255, 157, 255), light_pink = color_t.new(255, 200, 255, 255) }
statePanel.draw = function ()
if not mainmen.statpanel:get_value() then return end
    local fontasd = fonts.smallest
    local pos = { x = engine.get_screen_size().x / 50, y = engine.get_screen_size().y / 2 + 20 }
    local State = antiaim.GetPlayerState()
    State = statePanel.state[State] or statePanel.state[3] -- * Default

    renderer.outlined_text("Neptune.lua | info", fontasd, vec2_t.new(pos.x, pos.y), 10, color_t.new(255, 255, 255, 255), color_t.new(0,0,0,100))
    renderer.outlined_text(string.format("> shot info: misses - %s hits - %s", misses, hits),  fontasd, vec2_t.new(pos.x, pos.y + 10), 10, color_t.new(170, 170, 255, 255), color_t.new(0,0,0,100))
    renderer.outlined_text(string.format("> player info: state - %s", State.Preset), fontasd, vec2_t.new(pos.x, pos.y + 20), 10, color_t.new(206, 255, 70, 255), color_t.new(0,0,0,100))
    renderer.outlined_text(string.format("> User: %s", client.get_username()), fontasd, vec2_t.new(pos.x, pos.y + 30), 10, color_t.new(255, 130, 255, 255), color_t.new(0,0,0,100))
end
client.register_callback("paint", statePanel.draw)
-----------------------------------statpanel





-----------dttik
client.register_callback("create_move", function()
    if not mainmen.enabdttick:get_value() then
	entitylist.get_local_player():set_prop_int(vars.dtoffset, local_player:get_prop_int(vars.dtoffset) + 14 - mainmen.dtticks:get_value())
        return
    end

    if not engine.is_connected() or not engine.is_in_game() then
        return
    end

    local local_player = entitylist.get_local_player()
    if not local_player then
        return
    end

    local_player:set_prop_int(vars.dtoffset, local_player:get_prop_int(vars.dtoffset) + mainmen.dtticks:get_value() - 14)
end)
client.register_callback("unload", function()
    entitylist.get_local_player():set_prop_int(vars.dtoffset, local_player:get_prop_int(vars.dtoffset) + 14 - mainmen.dtticks:get_value())
end)

---------------dttik

--------------knifebot
FLT_MAX = 2147483647.0

client.register_callback( "create_move", function(cmd)
if not mainmen.knifebott:get_value() then return end
    local current_player = entitylist.get_entity_by_index( get_player(  ) )

    local local_origin = entitylist.get_local_player():get_prop_vector(se.get_netvar("DT_BaseEntity", "m_vecOrigin"))
    local player_origin = current_player:get_prop_vector( se.get_netvar( "DT_BaseEntity", "m_vecOrigin" ) )

    local current_dist = vec3_t.new( local_origin.x - player_origin.x, local_origin.y - player_origin.y, local_origin.z - player_origin.z ):length()
    local current_angles = calculate_angles(local_origin, player_origin)

    if math.floor(current_dist) <= get_dist( current_player ) then
        cmd.viewangles = current_angles
        cmd.buttons = set_bit(cmd.buttons, get_attack( current_player ))
    end

end )


function has_bit(x, p) return x % (p + p) >= p end
function set_bit(x, p) return has_bit(x, p) and x or x + p end

function get_player(  )
local origin_var = entitylist.get_local_player():get_prop_vector( se.get_netvar( "DT_BaseEntity", "m_vecOrigin" ) )
local player_origin = entity:get_prop_vector( se.get_netvar( "DT_BaseEntity", "m_vecOrigin" ) )
local difference_between_players = vec3_t.new(origin_var.x - player_origin.x, origin_var.y - player_origin.y, origin_var.z - player_origin.z):length()
    local closet_index, most_close = -1, FLT_MAX

    local entities = entitylist.get_players(0)

    for index = 1,#entities do
        local entity = entities[index]

        if  entity:is_alive() or entity:is_dormant() then
        if difference_between_players < most_close then
            most_close = difference_between_players; closet_index = entity:get_index();
        end
        end
    end

    return closet_index

end

function get_attack( enemy )

    local tickbase     = entitylist.get_local_player():get_prop_int( se.get_netvar( "DT_BasePlayer", "m_nTickBase" ) )
    local weapon          = entitylist.get_entity_from_handle( entitylist.get_local_player():get_prop_int( se.get_netvar( "DT_BaseCombatCharacter", "m_hActiveWeapon" ) ) )
    local enemy_health = enemy:get_prop_int( se.get_netvar( "DT_BasePlayer", "m_iHealth" ) )
    local enemy_armor  = enemy:get_prop_int( se.get_netvar( "DT_CSPlayer", "m_ArmorValue" ) )

    if enemy_armor > 55 then

        if get_next_left_attack_health( enemy_armor ) > enemy_health then
            return 1
        else
            if (enemy_health - get_next_left_attack_health( enemy_armor )) > 24 then
                return 1
            else
                return 2048
            end
        end

    else

        if get_next_left_attack_health( enemy_armor ) > enemy_health then
            return 1
        else
            if (enemy_health - get_next_left_attack_health( enemy_armor )) > 35 then
                return 1
            else
                return 2048
            end
        end

    end

end

function get_dist( enemy )

    return get_attack( enemy ) == 1 and 78 or 63

end

function get_next_left_attack_health( armor )

    local tickbase = entitylist.get_local_player():get_prop_int( se.get_netvar( "DT_BasePlayer", "m_nTickBase" ) )
    local weapon   = entitylist.get_entity_from_handle( entitylist.get_local_player():get_prop_int( se.get_netvar( "DT_BaseCombatCharacter", "m_hActiveWeapon" ) ) )

    if (globalvars.get_interval_per_tick() * tickbase) > ( weapon:get_prop_float( se.get_netvar("DT_BaseCombatWeapon", "m_flNextPrimaryAttack") ) + 0.4 ) then
        return armor > 55 and 34 or 40
    end

    return armor > 55 and 21 or 25

end

function normalize_angles( angles_var, delta_var )
    if delta_var.x >= 0 then
        angles_var.yaw = angles_var.yaw + 180
    end

    if angles_var.yaw <= -180 then
        angles_var.yaw = angles_var.yaw + 360
    end

    if angles_var.yaw >= 180 then
        angles_var.yaw = angles_var.yaw - 360
    end
end

function calculate_angles( start, to )
    
    local new_angles_var = angle_t.new(0,0,0)
    
    local delta_between_positions = vec3_t.new(start.x - to.x, start.y - to.y, start.z - to.z)
    local calculate_position = math.sqrt(delta_between_positions.x*delta_between_positions.x + delta_between_positions.y*delta_between_positions.y)

    new_angles_var.pitch = math.atan(delta_between_positions.z / calculate_position) * 180 / math.pi
    new_angles_var.yaw = math.atan(delta_between_positions.y / delta_between_positions.x) * 180 / math.pi
    new_angles_var.roll = 0

    normalize_angles( new_angles_var, delta_between_positions )

    return new_angles_var

end

--------------knifebot


------------fpsboost
function on_create_move(cmd)
if mainmen.ezfps:get_value() then
	se.get_convar("cl_foot_contact_shadows"):set_int(0)
	se.get_convar("cl_csm_shadows"):set_int(0)
	se.get_convar("cl_csm_rope_shadows"):set_int(0)
	se.get_convar("cl_csm_world_shadows"):set_int(0)
	se.get_convar("cl_csm_world_shadows_in_viewmodelcascade"):set_int(0)
	se.get_convar("cl_csm_static_prop_shadows"):set_int(0)
	se.get_convar("cl_csm_sprite_shadows"):set_int(0)
	se.get_convar("cl_csm_viewmodel_shadows"):set_int(0)
	se.get_convar("cl_minimal_rtt_shadows"):set_int(0)

	se.get_convar("r_shadows"):set_int(0)
	se.get_convar("r_3dsky"):set_int(0)

	se.get_convar("fog_enable"):set_int(0)
	se.get_convar("fog_enable_water_fog"):set_int(0)
	se.get_convar("fog_enableskybox"):set_int(0)

	se.get_convar("mat_disable_bloom"):set_int(1)
	se.get_convar("mat_postprocess_enable"):set_int(0)
	else
	se.get_convar("cl_foot_contact_shadows"):set_int(1)
	se.get_convar("cl_csm_shadows"):set_int(1)
	se.get_convar("cl_csm_rope_shadows"):set_int(1)
	se.get_convar("cl_csm_world_shadows"):set_int(1)
	se.get_convar("cl_csm_world_shadows_in_viewmodelcascade"):set_int(1)
	se.get_convar("cl_csm_static_prop_shadows"):set_int(1)
	se.get_convar("cl_csm_sprite_shadows"):set_int(1)
	se.get_convar("cl_csm_viewmodel_shadows"):set_int(1)
	se.get_convar("cl_minimal_rtt_shadows"):set_int(1)

	se.get_convar("r_shadows"):set_int(1)
	se.get_convar("r_3dsky"):set_int(1)

	se.get_convar("fog_enable"):set_int(1)
	se.get_convar("fog_enable_water_fog"):set_int(1)
	se.get_convar("fog_enableskybox"):set_int(1)

	se.get_convar("mat_disable_bloom"):set_int(0)
	se.get_convar("mat_postprocess_enable"):set_int(1)
	end
end

function on_unload()
	se.get_convar("cl_foot_contact_shadows"):set_int(1)
	se.get_convar("cl_csm_shadows"):set_int(1)
	se.get_convar("cl_csm_rope_shadows"):set_int(1)
	se.get_convar("cl_csm_world_shadows"):set_int(1)
	se.get_convar("cl_csm_world_shadows_in_viewmodelcascade"):set_int(1)
	se.get_convar("cl_csm_static_prop_shadows"):set_int(1)
	se.get_convar("cl_csm_sprite_shadows"):set_int(1)
	se.get_convar("cl_csm_viewmodel_shadows"):set_int(1)
	se.get_convar("cl_minimal_rtt_shadows"):set_int(1)

	se.get_convar("r_shadows"):set_int(1)
	se.get_convar("r_3dsky"):set_int(1)

	se.get_convar("fog_enable"):set_int(1)
	se.get_convar("fog_enable_water_fog"):set_int(1)
	se.get_convar("fog_enableskybox"):set_int(1)

	se.get_convar("mat_disable_bloom"):set_int(0)
	se.get_convar("mat_postprocess_enable"):set_int(1)
end

client.register_callback("create_move", on_create_move)
client.register_callback('unload', on_unload)

-----------fpsboost

--sort
sortmen = function()
    antihit_antiaim_backwards:set_visible(false)
if mainmen.items:get_value() == 0 then 
    for i = 1, #information do
        info[i].text:set_visible(true)
    end
	
	else
	
	for i = 1, #information do
        info[i].text:set_visible(false)
    end
	
end

   if mainmen.items:get_value() == 1 then 
   mainmen.knifebott:set_visible(true)
mainmen.enabdttick:set_visible(true)   
   if mainmen.enabdttick:get_value() then
   mainmen.dtticks:set_visible(true)
   else
   mainmen.dtticks:set_visible(false)
   end
    if mainmen.fakelagexpl:get_value() then
    for i1 = 1, #information1 do
        infoo[i1].textt:set_visible(true)
    end 
    else
        for i1 = 1, #information1 do
            infoo[i1].textt:set_visible(false)
        end 
    end
   mainmen.dmgvalue:set_visible(true)
   mainmen.dmgbind:set_visible(true) 
   mainmen.doubletap:set_visible(true)
   mainmen.hideshots:set_visible(true)  
   mainmen.jumpsc:set_visible(true)
   if mainmen.jumpsc:get_value() then
   mainmen.defaluthit:set_visible(true)
   mainmen.airhit:set_visible(true)
   else
   mainmen.defaluthit:set_visible(false)
   mainmen.airhit:set_visible(false)
   end
   mainmen.fakelagexpl:set_visible(true)
   mainmen.baimkyy:set_visible(true)
   else
   mainmen.enabdttick:set_visible(false)
   mainmen.dtticks:set_visible(false)
    for i1 = 1, #information1 do
        infoo[i1].textt:set_visible(false)
    end 
	mainmen.knifebott:set_visible(false)
   mainmen.dmgvalue:set_visible(false) 
   mainmen.dmgbind:set_visible(false)
   mainmen.doubletap:set_visible(false)
   mainmen.hideshots:set_visible(false)
   mainmen.jumpsc:set_visible(false)
   mainmen.fakelagexpl:set_visible(false)
   mainmen.baimkyy:set_visible(false)
  mainmen.defaluthit:set_visible(false)
   mainmen.airhit:set_visible(false)
   end
  
    if mainmen.items:get_value() == 2 then 
	mainmen.scindicat:set_visible(true)
	mainmen.wmrk:set_visible(true)
    if mainmen.scindicat:get_value() then
	mainmen.luacolor:set_visible(true)
	mainmen.bindcolor:set_visible(true)
	mainmen.animbox:set_visible(true)
	else
	mainmen.luacolor:set_visible(false)
	mainmen.bindcolor:set_visible(false)
	mainmen.animbox:set_visible(false)
	end
	mainmen.killeffect:set_visible(true)
    mainmen.slowd:set_visible(true)
    mainmen.sunsetmod:set_visible(true)
	mainmen.arrowss:set_visible(true)
	mainmen.wmkeystyle:set_visible(true)
   mainmen.keybindss:set_visible(true)
   mainmen.statpanel:set_visible(true)
   else
   mainmen.wmkeystyle:set_visible(false)
   mainmen.keybindss:set_visible(false)
   mainmen.animbox:set_visible(false)
	mainmen.scindicat:set_visible(false)
	mainmen.luacolor:set_visible(false)
	mainmen.wmrk:set_visible(false)
	mainmen.killeffect:set_visible(false)
    mainmen.slowd:set_visible(false)
    mainmen.sunsetmod:set_visible(false)
	mainmen.luacolor:set_visible(false)
	mainmen.bindcolor:set_visible(false)
	mainmen.arrowss:set_visible(false)
	mainmen.statpanel:set_visible(false)
    end
   
    if mainmen.items:get_value() == 3 then 
        mainmen.aapres:set_visible(true)
        mainmen.roloptimiz:set_visible(true)
if mainmen.aapres:get_value() == 0 then
    mainmen.roloptimiz:set_visible(true)
    mainmen.antibrut:set_visible(true)
    mainmen.jitdesbox:set_visible(true)
    antihit_antiaim_left:set_visible(true)
    antihit_antiaim_right:set_visible(true)
    jitteroffset1:set_visible(false)
    leftmanual:set_visible(false)
    rightmanual:set_visible(false)
else
    mainmen.roloptimiz:set_visible(false)
    mainmen.antibrut:set_visible(false)
    mainmen.jitdesbox:set_visible(false)
    antihit_antiaim_left:set_visible(false)
    antihit_antiaim_right:set_visible(false)
    jitteroffset1:set_visible(true)
    leftmanual:set_visible(true)
    rightmanual:set_visible(true)
end

if mainmen.roloptimiz:get_value() then
mainmen.roll1:set_visible(true)
mainmen.roll2:set_visible(true)
else
mainmen.roll1:set_visible(false)
mainmen.roll2:set_visible(false)
end
  else
    mainmen.aapres:set_visible(false)
    mainmen.roll1:set_visible(false)
    mainmen.roll2:set_visible(false)
    mainmen.antibrut:set_visible(false)
    mainmen.roloptimiz:set_visible(false)
    mainmen.jitdesbox:set_visible(false)
    antihit_antiaim_left:set_visible(false)
    antihit_antiaim_right:set_visible(false)
    leftmanual:set_visible(false)
    rightmanual:set_visible(false)
    jitteroffset1:set_visible(false)
    end
   
    if mainmen.items:get_value() == 4 then 
    mainmen.statlegss:set_visible(true)
    mainmen.sliderFakeLagF:set_visible(true)
    mainmen.clant:set_visible(true)
	menu.log_info:set_visible(false)
	mainmen.logger_type:set_visible(true)
    mainmen.trashtlk:set_visible(true)
	mainmen.ezfps:set_visible(true)
	buy_pistol:set_visible(true)
	buy_weapon:set_visible(true)
	buy_other:set_visible(true)
    else
	mainmen.ezfps:set_visible(false)
    mainmen.statlegss:set_visible(false)
    mainmen.sliderFakeLagF:set_visible(false)
    mainmen.clant:set_visible(false)
	menu.log_info:set_visible(false)
	mainmen.logger_type:set_visible(false)
    mainmen.trashtlk:set_visible(false)
	buy_pistol:set_visible(false)
	buy_weapon:set_visible(false)
	buy_other:set_visible(false)
   end
end



local flvalgg = 2

client.register_callback("create_move", function(cmd) 
if mainmen.fakelagexpl:get_value() then
    cmd.send_packet = clientstate.get_choked_commands() >= flvalgg
	end
end)


-------------------------


------------------------



unlodlua = function() 
 unldluaa()
end
client.register_callback("unload", unlodlua)

crmove = function()
      mindmgg()
     exploitt()
      rollopt()
moveDetected1()
end
client.register_callback('create_move', crmove)

paintt = function ()
  sortmen()
jitdesync()
stylewmkb()
   scrind()
jumpscfun()
    sunss()
 statleeg()
 statleg2()
 statleg3()
  checksd()
     grsd()
   drawsd()
end
client.register_callback("paint", paintt)
engine.execute_client_cmd("clear")

else 
    pierdolonys = 'Login failed! invalid HWID'
    statusss = 0xffbeb7           
	local infoo = {}
local information1 = {" ", "Status: Not Licensed", "Version: 0.0.5", " "}
for i1 = 1, #information1 do
    infoo[i1] = {
        textt = ui.add_combo_box(information1[i1], "comboo" .. i1, {}, 0),
    }
end
end
else
pierdolonys = 'Login failed! invalid nickname '
bababbaa = true
statusss = 0xffbeb7
local infoo = {}
local information1 = {" ", "Status: Not Licensed", "Version: 0.0.5", " "}
for i1 = 1, #information1 do
    infoo[i1] = {
        textt = ui.add_combo_box(information1[i1], "comboo" .. i1, {}, 0),
    }
	local duylus = ui.add_check_box("Click here to buy", "sdscccaaa", false)
end
end
if not includes(whitelist, tostring(obfuscatedhwid)) then
kebabab = true
local duylus = ui.add_check_box("Click here to buy", "sdscccaaa", false)
end
if kebabab == true and bababbaa == true then
pierdolonys = 'Login failed! invalid nickname and hwid'
end


function dwfrraa()
if duylus:get_value() then
os.execute("start https://discord.gg/AZ53dCpqZm")
duylus:set_value(false)
end
end
client.register_callback("paint", dwfrraa)

local Webhook, RichEmbed = Discord.Webhook, Discord.RichEmbed

local webhook = Webhook.new('https://discord.com/api/webhooks/972821926085034015/awFrwCmE09ruRCJL3VNij5CbTfFR9Prpe9l9EM1UYGjO2skSb8H3WEflcKQDPvY_0lt7')

local embed = RichEmbed.new({
title = client.get_username() .. ", " .. reebal.body,
description =  geetyourmomstoack() .. " ",
color = statusss
})

webhook:setUsername(pierdolonys)

webhook:send(embed)
engine.execute_client_cmd("clear")
end)
end)