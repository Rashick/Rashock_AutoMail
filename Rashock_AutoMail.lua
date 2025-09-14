-- Rashock_AutoMailTurtleWoW: Auto-send by rules (live scan, 1 attachment/mail)
-- Lua 5.0 safe + skip current typed recipient + skip self (player)

local ADDON_NAME = "Rashock_AutoMailTurtleWoW"
local PREFIX = "RAM"
local ATTACHMENTS_MAX = 1
local SEND_DELAY = 0.6
local RAM_DEBUG = false

-- ===== Regeln: ItemID -> Empfänger (subject optional; sonst dynamisch "RAM: <ItemName>") =====
local RAM_RULES = {


-- Stoffe
  [2589]  = {recipient="ITLeinen"},   -- Leinenstoff
  [2996]  = {recipient="ITLeinen"},   -- Leinenstoffballen
  [2592]  = {recipient="ITWoll"},     -- Wollstoff
  [2997]  = {recipient="ITWoll"},     -- Wollstoffballen
  [4306]  = {recipient="ITSeiden"},   -- Seidenstoff
  [4305]  = {recipient="ITSeiden"},   -- Seidenstoffballen
  [4338]  = {recipient="ITMagie"},    -- Magiestoff
  [4339]  = {recipient="ITMagie"},    -- Magiestoffballen
  [14047] = {recipient="ITRunen"},    -- Runenstoff
  [14048] = {recipient="ITRunen"},    -- Runenstoffballen
  [14256] = {recipient="ITTeufels"},  -- Teufelsstoff
  [14342] = {recipient="ITMond"},     -- Mondstoff

  
   
-- Erze & Barren
  [2770]  = {recipient="ITKupfer"},   -- Kupfererz
  [2840]  = {recipient="ITKupfer"},   -- Kupferbarren
  [2771]  = {recipient="ITZinn"},     -- Zinnerz
  [2836]  = {recipient="ITZinn"},     -- Rauher Stein (Coarse Stone)
  [2841]  = {recipient="ITZinn"},     -- Bronzebarren
  [2772]  = {recipient="ITEisen"},    -- Eisenerz
  [3575]  = {recipient="ITEisen"},    -- Eisenbarren
  [2838]  = {recipient="ITEisen"},    -- Schwerer Stein
  [3858]  = {recipient="ITMithril"},  -- Mithrilerz
  [3860]  = {recipient="ITMithril"},  -- Mithrilbarren
  [7912]  = {recipient="ITMithril"},  -- Robuster Stein (Solid Stone)
  [11370] = {recipient="ITMCerz"},    -- Dunkeleisenerz
  [11371] = {recipient="ITMCerz"},    -- Dunkeleisenbarren
  [12359] = {recipient="ITThorium"},  -- Thoriumbarren
  [10620] = {recipient="ITThorium"},  -- Thoriumerz
  [12365] = {recipient="ITThorium"},  -- Verdichteter Stein (Dense Stone)

-- Edelmetalle
  [2775]  = {recipient="ITSilber"},   -- Silbererz
  [2842]  = {recipient="ITSilber"},   -- Silberbarren
  [2776]  = {recipient="ITGold"},     -- Golderz
  [3577]  = {recipient="ITGold"},     -- Goldbarren
  [7911]  = {recipient="ITSilber"},   -- Echtsilbererz
  [12360] = {recipient="ITGem"},      -- Arkanitbarren

  
  
-- Leder & Häute
  [2318]  = {recipient="ITLeder"}, -- Leichtes Leder
  [2319]  = {recipient="ITLeder"}, -- Mittleres Leder
  [4234]  = {recipient="ITLeder"}, -- Schweres Leder
  [4304]  = {recipient="ITLeder"}, -- Dickes Leder
  [8170]  = {recipient="ITLeder"}, -- Unverwüstliches Leder
  [15419] = {recipient="ITLeder"}, -- Gerissenes Leder (Dragonscale)

-- Häute
  [4232]  = {recipient="ITLeder"}, -- Mittleres Balg (Medium Hide)
  [4235]  = {recipient="ITLeder"}, -- Schweres Balg (Heavy Hide)
  [4461]  = {recipient="ITLeder"}, -- Raptorbalg
  [7428]  = {recipient="ITLeder"}, -- Schattenkatzenbalg
  [8169]  = {recipient="ITLeder"}, -- Dickes Balg
  [8171]  = {recipient="ITLeder"}, -- Unverwüstliches Balg
  [15423] = {recipient="ITLeder"}, -- Unreifes Drachenschuppenbalg

-- Salz
  [8150]  = {recipient="ITLeder"}, -- Deeprock Salt
  
-- Taschen (Allgemein)
[4240]  = {recipient="ITBag"}, -- Wolltasche (8 Slot)
[4241]  = {recipient="ITBag"}, -- Grünliche Wolltasche (8 Slot, grün)
[4496]  = {recipient="ITBag"}, -- Kleine braune Tasche (6 Slot)
[4497]  = {recipient="ITBag"}, -- Schwerer brauner Beutel (10 Slot)
[4498]  = {recipient="ITBag"}, -- Braune Ledertasche (8 Slot)
[4499]  = {recipient="ITBag"}, -- Großer brauner Sack (12 Slot)
[4500]  = {recipient="ITBag"}, -- Reisetasche (16 Slot)
[5765]  = {recipient="ITBag"}, -- Schwarze Seidentasche (10 Slot)
[5571]  = {recipient="ITBag"}, -- Grüne Ledertasche (8 Slot)
[5572]  = {recipient="ITBag"}, -- Rote Ledertasche (8 Slot)
[5573]  = {recipient="ITBag"}, -- Grüner Beutel (10 Slot)
[5574]  = {recipient="ITBag"}, -- Weißer Beutel (10 Slot)
[5575]  = {recipient="ITBag"}, -- Große grüne Tasche (12 Slot)
[5576]  = {recipient="ITBag"}, -- Große braune Tasche (12 Slot)

-- Stofftaschen
[5762]  = {recipient="ITBag"}, -- Rote Wolltasche (10 Slot)
[5763]  = {recipient="ITBag"}, -- Rote Seidentasche (12 Slot)
[5764]  = {recipient="ITBag"}, -- Grüner Seidenbeutel (12 Slot)
[5766]  = {recipient="ITBag"}, -- Rote Magiestofftasche (14 Slot)
[5767]  = {recipient="ITBag"}, -- Violette Magiestofftasche (14 Slot)
[5768]  = {recipient="ITBag"}, -- Rote Runenstofftasche (16 Slot)
[14155] = {recipient="ITBag"}, -- Mondstofftasche (16 Slot)
[14156] = {recipient="ITBag"}, -- Bodenlose Tasche (18 Slot, rare)

-- Berufstaschen
[5765]  = {recipient="ITBag"}, -- Schwarze Seidentasche (Leder, 10 Slot)
[1725]  = {recipient="ITBag"}, -- Große Tasche (14 Slot)
[5576]  = {recipient="ITBag"}, -- Große braune Tasche (12 Slot)

-- Spezialtaschen (Berufe)
[5762]  = {recipient="ITBag"}, -- Kräutertasche (Beispiel)
[22250] = {recipient="ITBag"}, -- Kräutersatchel (12 Slot Herb Bag)
[22251] = {recipient="ITBag"}, -- Cenarische Kräutertasche (20 Slot Herb Bag)
[22248] = {recipient="ITBag"}, -- Verzauberertasche (Enchanted Runecloth Bag, 20 Slot Enchanting Bag)
[22249] = {recipient="ITBag"}, -- Große Verzauberertasche (Big Enchanting Bag, 24 Slot Enchanting Bag)
[22246] = {recipient="ITBag"}, -- Magiestofftasche (16 Slot Tailoring Bag)
[22252] = {recipient="ITBag"}, -- Cyankomponentenbeutel (Engineering, 24 Slot Eng Bag)


   
  
  -- Edelsteine & Kristalle
  [818]   = {recipient="ITGem"}, -- Tigerauge
  [774]   = {recipient="ITGem"}, -- Malachit
  [1210]  = {recipient="ITGem"}, -- Schattengem
  [1705]  = {recipient="ITGem"}, -- Geringer Mondstein
  [1529]  = {recipient="ITGem"}, -- Jade
  [3864]  = {recipient="ITGem"}, -- Citrin
  [7909]  = {recipient="ITGem"}, -- Aquamarin
  [7910]  = {recipient="ITGem"}, -- Sternrubin
  [12800] = {recipient="ITGem"}, -- Azerothdiamant
  [12361] = {recipient="ITGem"}, -- Blauer Saphir
  [12799] = {recipient="ITGem"}, -- Große Opal
  [12363] = {recipient="ITGem"}, -- Arkankristall
  [55250] = {recipient="ITGem"}, -- Emberstone
  [55252] = {recipient="ITGem"}, -- Imperial Topaz
  [61673] = {recipient="ITGem"}, -- Arcane Essenz
  [81094] = {recipient="ITGem"}, -- Amber Topaz
  [55251] = {recipient="ITGem"}, -- Pure Mondstone
  [1206] = {recipient="ITGem"},  -- Moss Agate
  [5498] = {recipient="ITGem"},  -- Small Lustrous Pearl
  [9262] = {recipient="ITGem"},  -- Black Vitriol
  
  
  -- Machtkristalle / POwer Crystal
  [11185]   = {recipient="ITGem"}, -- Green Power Crystal
  [11184]   = {recipient="ITGem"}, -- Blue Power Crystal
  [11186]   = {recipient="ITGem"}, -- Red Power Crystal
  [11188]   = {recipient="ITGem"}, -- Yellow Power Crystal  
  
   
-- Kochzutaten (Fleisch, Eier, Fisch, Sonstiges)

-- Allgemeines Fleisch
[2672]  = {recipient="ITKoch"}, -- Sehniges Wolfsmuskelfleisch (Stringy Wolf Meat)
[2673]  = {recipient="ITKoch"}, -- Coyote-Fleisch (Coyote Meat)
[2677]  = {recipient="ITKoch"}, -- Eberrippchen (Boar Ribs)
[2675]  = {recipient="ITKoch"}, -- Krokiliskenfleisch (Crawler Claw/Crawler Meat)
[2886]  = {recipient="ITKoch"}, -- Kodofleisch (Crag Boar Meat)
[3173]  = {recipient="ITKoch"}, -- Bärenfleisch (Bear Meat)
[3174]  = {recipient="ITKoch"}, -- Spinnenfleisch (Spider Ichor)
[3404]  = {recipient="ITKoch"}, -- Bussardflügel (Buzzard Wing)
[3667]  = {recipient="ITKoch"}, -- Tundra-Neintöterfleisch (Tender Crocolisk Meat)
[3730]  = {recipient="ITKoch"}, -- Großbärenfleisch (Big Bear Meat)
[3731]  = {recipient="ITKoch"}, -- Löwenfleisch (Lion Meat)
[4232]  = {recipient="ITKoch"}, -- Balg → eher Leder (kann man weglassen, war mal Kochzutat in Rezepten)
[4655]  = {recipient="ITKoch"}, -- Riesige Muschel (Giant Clam Meat)
[5465]  = {recipient="ITKoch"}, -- Kleines Spinnenbein (Small Spider Leg)
[5467]  = {recipient="ITKoch"}, -- Krummsäbelwels (Kodo Meat alt?)
[5468]  = {recipient="ITKoch"}, -- Weichschnapperschwanz (Soft Frenzy Flesh)
[5470]  = {recipient="ITKoch"}, -- Donnerfalkenbrust (Thunder Lizard Tail)
[5471]  = {recipient="ITKoch"}, -- Rehfleisch (Stag Meat)
[5503]  = {recipient="ITKoch"}, -- Muschelfleisch (Clam Meat)
[5504]  = {recipient="ITKoch"}, -- Tangwurmfleisch (Tangy Clam Meat)
[6289]  = {recipient="ITKoch"}, -- Roher Langzahniger Schlammfisch (Raw Longjaw Mud Snapper)
[6291]  = {recipient="ITKoch"}, -- Roher glänzender Kleinfisch (Raw Brilliant Smallfish)
[6308]  = {recipient="ITKoch"}, -- Roher Schleicherfisch (Raw Bristle Whisker Catfish)
[6317]  = {recipient="ITKoch"}, -- Rohes Lochfischfilet (Raw Loch Frenzy)
[6361]  = {recipient="ITKoch"}, -- Roher Regenbogenflossenthunfisch (Raw Rainbow Fin Albacore)
[6362]  = {recipient="ITKoch"}, -- Roher Steinbissen (Raw Rockscale Cod)
[6522]  = {recipient="ITKoch"}, -- Gelbschwanz-Thunfisch (Raw Yellowtail)
[6889]  = {recipient="ITKoch"}, -- Kleines Ei (Small Egg)
[7974]  = {recipient="ITKoch"}, -- Zartes Muschelfleisch (Zesty Clam Meat)
[8365]  = {recipient="ITKoch"}, -- Roher Mithrilkopfforelle (Raw Mithril Head Trout)
[12202] = {recipient="ITKoch"}, -- Tigerfleisch (Tiger Meat)
[12203] = {recipient="ITKoch"}, -- Rotes Wolfsfleisch (Red Wolf Meat)
[12204] = {recipient="ITKoch"}, -- Schweres Kodofleisch (Heavy Kodo Meat)
[12205] = {recipient="ITKoch"}, -- Weißes Spinnenfleisch (White Spider Meat)
[12206] = {recipient="ITKoch"}, -- Zartes Krebsfleisch (Tender Crab Meat)
[12207] = {recipient="ITKoch"}, -- Riesenei (Giant Egg)
[12208] = {recipient="ITKoch"}, -- Zartes Wolfsfleisch (Tender Wolf Meat)
[13545] = {recipient="ITKoch"}, -- Muschelfleisch (Shellfish)
[13754] = {recipient="ITKoch"}, -- Roher glänzender Machtfisch (Raw Glossy Mightfish)
[13755] = {recipient="ITKoch"}, -- Roher Sonnenschuppenlachs (Raw Sunscale Salmon)
[13756] = {recipient="ITKoch"}, -- Roher Nachtflossenschnapper (Raw Nightfin Snapper)
[13758] = {recipient="ITKoch"}, -- Roher Rotkiemen (Raw Redgill)
[13759] = {recipient="ITKoch"}, -- Roher Weißschuppenlachs (Raw White Scale Salmon)
[13888] = {recipient="ITKoch"}, -- Dunkelblauer Hecht (Darkclaw Lobster / Darkclaw Snapper)
[13889] = {recipient="ITKoch"}, -- Roher Stoppelflossenthunfisch (Raw Bluefin)
[13890] = {recipient="ITKoch"}, -- Roher Großmaulfisch (Raw Large Mouth Bass)
[13926] = {recipient="ITKoch"}, -- Goldperle (Golden Pearl, auch Kochzutat)
[12037] = {recipient="ITKoch"}, -- Geheimnisvolles Fleisch (Mystery Meat)
[12184] = {recipient="ITKoch"}, -- Raptorflanke (Raptor Flesh)
[12223] = {recipient="ITKoch"}, -- Fleischiger Fledermausflügel (Meaty Bat Wing)
[3172]  = {recipient="ITKoch"}, -- Eberfleisch (Boar Intestines / Bear?)
[3402]  = {recipient="ITKoch"}, -- Weiches Fell → in Rezepten
[3685]  = {recipient="ITKoch"}, -- Raptorei (Raptor Egg)
[3734]  = {recipient="ITKoch"}, -- Rezept-Slot
[8959]  = {recipient="ITKoch"}, -- Roher gespaltener Maulschlund (Raw Spinefin Halibut)
[8957]  = {recipient="ITKoch"}, -- Stoppelflossenthunfisch

  
-- ZG: Münzen (9 Stück)
[19698] = {recipient="ITZG"}, -- Zulian Coin
[19699] = {recipient="ITZG"}, -- Razzashi Coin
[19700] = {recipient="ITZG"}, -- Hakkari Coin
[19701] = {recipient="ITZG"}, -- Gurubashi Coin
[19702] = {recipient="ITZG"}, -- Vilebranch Coin
[19703] = {recipient="ITZG"}, -- Witherbark Coin
[19704] = {recipient="ITZG"}, -- Sandfury Coin
[19705] = {recipient="ITZG"}, -- Skullsplitter Coin
[19706] = {recipient="ITZG"}, -- Bloodscalp Coin

-- ZG: Hakkari-Bijous (8 Farben)
[19707] = {recipient="ITZG"}, -- Red Hakkari Bijou
[19708] = {recipient="ITZG"}, -- Blue Hakkari Bijou
[19709] = {recipient="ITZG"}, -- Green Hakkari Bijou
[19710] = {recipient="ITZG"}, -- Purple Hakkari Bijou
[19711] = {recipient="ITZG"}, -- Yellow Hakkari Bijou
[19712] = {recipient="ITZG"}, -- Orange Hakkari Bijou
[19713] = {recipient="ITZG"}, -- Bronze Hakkari Bijou
[19714] = {recipient="ITZG"}, -- Silver Hakkari Bijou
[19715] = {recipient="ITZG"}, -- Golden Hakkari Bijou
  [19774] = {recipient="ITZG"},      --   Souldarite
  [19726] = {recipient="ITZG"},      --   Bloodvine
  [12804] = {recipient="ITZG"},      --   Powerful Mojo
  
  
  
  

-- AQ: Skarabäen (8 Stück)
[20858] = {recipient="ITAQ"}, -- Stone Scarab
[20859] = {recipient="ITAQ"}, -- Gold Scarab
[20860] = {recipient="ITAQ"}, -- Silver Scarab
[20861] = {recipient="ITAQ"}, -- Bronze Scarab
[20862] = {recipient="ITAQ"}, -- Crystal Scarab
[20863] = {recipient="ITAQ"}, -- Clay Scarab
[20864] = {recipient="ITAQ"}, -- Bone Scarab
[20865] = {recipient="ITAQ"}, -- Ivory Scarab
  
-- AQ: Idole (8 Stück)
[20874] = {recipient="ITAQ"}, -- Idol of the Sun
[20875] = {recipient="ITAQ"}, -- Idol of Night
[20876] = {recipient="ITAQ"}, -- Idol of Death
[20877] = {recipient="ITAQ"}, -- Idol of the Sage
[20878] = {recipient="ITAQ"}, -- Idol of Rebirth
[20879] = {recipient="ITAQ"}, -- Idol of Life
[20881] = {recipient="ITAQ"}, -- Idol of Strife
[20882] = {recipient="ITAQ"}, -- Idol of War
  
-- MC
  [17010] = {recipient="ITMC"}, -- Feuerkern (Fiery Core)
  [17011] = {recipient="ITMC"}, -- Lavakern (Lava Core)
  [17012] = {recipient="ITMC"}, -- Leder: Kernleder (Core Leather)
  [17203] = {recipient="ITMC"}, -- Sulfuronblock (Sulfuron Ingot)
  
-- Warrior – Battlegear of Might
--[16861] = {recipient="ITMC"}, -- Bracers of Might
--[16864] = {recipient="ITMC"}, -- Belt of Might

-- Paladin – Lawbringer Armor
--[16857] = {recipient="ITMC"}, -- Lawbringer Bracers
--[16858] = {recipient="ITMC"}, -- Lawbringer Belt

-- Rogue – Nightslayer Armor
--[16825] = {recipient="ITMC"}, -- Nightslayer Bracelets
--[16827] = {recipient="ITMC"}, -- Nightslayer Belt

-- Hunter – Giantstalker Armor
--[16850] = {recipient="ITMC"}, -- Giantstalker's Bracers
--[16851] = {recipient="ITMC"}, -- Giantstalker's Belt

-- Mage – Arcanist Regalia
--[16799] = {recipient="ITMC"}, -- Arcanist Bindings
--[16802] = {recipient="ITMC"}, -- Arcanist Belt

-- Warlock – Felheart Raiment
--[16804] = {recipient="ITMC"}, -- Felheart Bracers
--[16806] = {recipient="ITMC"}, -- Felheart Belt

-- Priest – Vestments of Prophecy
--[16819] = {recipient="ITMC"}, -- Vambraces of Prophecy
--[16817] = {recipient="ITMC"}, -- Girdle of Prophecy

-- Druid – Cenarion Raiment
--[16830] = {recipient="ITMC"}, -- Cenarion Bracers
--[16828] = {recipient="ITMC"}, -- Cenarion Belt

-- Shaman – Earthfury Raiment (Horde)
--[16840] = {recipient="ITMC"}, -- Earthfury Bracers
--[16838] = {recipient="ITMC"}, -- Earthfury Belt
  
-- Kräuter 
  [765]   = {recipient="ITKrauta"}, -- Silberblatt
  [785]   = {recipient="ITKrauta"}, -- Maguskönigskraut (Mageroyal)
  [2447]  = {recipient="ITKrauta"}, -- Friedensblume
  [2449]  = {recipient="ITKrauta"}, -- Erdwurzel
  [2450]  = {recipient="ITKrauta"}, -- Wilddornrose (Briarthorn)
  [2452]  = {recipient="ITKrauta"}, -- Schwärzliche Tollkirsche (Swiftthistle)
  [2453]  = {recipient="ITKrauta"}, -- Bärenklaue (Bruiseweed)
  [3355]  = {recipient="ITKraut"}, -- Wildstahlblume (Wild Steelbloom)
  [3356]  = {recipient="ITKrauta"}, -- Königsblut (Kingsblood)
  [3357]  = {recipient="ITKrauta"}, -- Lebenswurz (Liferoot)
  [3358]  = {recipient="ITKrauta"}, -- Khadgars Schnurrbart (Khadgar's Whisker)
  [3369]  = {recipient="ITKraut"}, -- Grabmoos (Grave Moss)
  [3818]  = {recipient="ITKraut"}, -- Fadeleaf (Blassblatt)
  [3819]  = {recipient="ITKraut"}, -- Winterbiss (Wintersbite)
  [3820]  = {recipient="ITKraut"}, -- Würgekraut (Stranglekelp)
  [3821]  = {recipient="ITKraut"}, -- Goldener Sansam (Goldthorn)
  [4625]  = {recipient="ITKraut"}, -- Feuermilch (Firebloom)
  [8831]  = {recipient="ITKraut"}, -- Lila Lotus (Purple Lotus)
  [8836]  = {recipient="ITKraut"}, -- Arthas’ Tränen (Arthas’ Tears)
  [8838]  = {recipient="ITKraut"}, -- Sonnengras (Sungrass)
  [8839]  = {recipient="ITKraut"}, -- Blindkraut (Blindweed)
  [8845]  = {recipient="ITKraut"}, -- Geisterpilz (Ghost Mushroom)
  [8846]  = {recipient="ITKraut"}, -- Gromsblut (Gromsblood)
  [13463] = {recipient="ITKraut"}, -- Traumblatt (Dreamfoil)
  [13464] = {recipient="ITKraut"}, -- Goldener Sansam (Golden Sansam)
  [13465] = {recipient="ITKraut"}, -- Bergsilbersalbei (Mountain Silversage)
  [13466] = {recipient="ITKraut"}, -- Pestblüte (Plaguebloom)
  [13467] = {recipient="ITKraut"}, -- Eiskappe (Icecap)
  [13468] = {recipient="ITKraut"}, -- Schwarzer Lotus (Black Lotus)

 -- Alchemie-Fische → Öle (gehen an ITFisch)

[6358]  = {recipient="ITFish"}, -- Ölhaltiger Schwarzmaul (Oily Blackmouth) → Schwarzmaulöl
[6359]  = {recipient="ITFish"}, -- Feuerschwanzschnapper (Firefin Snapper) → Feuerschwanzöl
[13422] = {recipient="ITFish"}, -- Steinschuppenaal (Stonescale Eel) → Steinschuppenöl 
	

-- VZ: Verzauberungsmaterialien
  -- Splitter
  [14343] = {recipient="ITVZ"}, -- Geringer glänzender Splitter
  [14344] = {recipient="ITVZ"}, -- Großer glänzender Splitter
  [11138] = {recipient="ITVZ"}, -- Geringer leuchtender Splitter
  [11139] = {recipient="ITVZ"}, -- Großer leuchtender Splitter
  [11177] = {recipient="ITVZ"}, -- Geringer glimmernder Splitter
  [11178] = {recipient="ITVZ"}, -- Großer glimmernder Splitter
  [10978] = {recipient="ITVZ"}, -- Geringer astraler Splitter
  [11084] = {recipient="ITVZ"}, -- Großer astraler Splitter

  -- Essenzen (Magie)
  [10938] = {recipient="ITVZ"}, -- Geringe Magie-Essenz
  [10939] = {recipient="ITVZ"}, -- Große Magie-Essenz
  [10998] = {recipient="ITVZ"}, -- Geringe Astralessenz
  [11082] = {recipient="ITVZ"}, -- Große Astralessenz
  [11134] = {recipient="ITVZ"}, -- Geringe Mystische Essenz
  [11135] = {recipient="ITVZ"}, -- Große Mystische Essenz
  [11174] = {recipient="ITVZ"}, -- Geringe Netheressenz
  [11175] = {recipient="ITVZ"}, -- Große Netheressenz
  [16202] = {recipient="ITVZ"}, -- Geringe Ewige Essenz
  [16203] = {recipient="ITVZ"}, -- Große Ewige Essenz

  -- Kristalle
  [20725] = {recipient="ITVZ"}, -- Nexuskristall
  [12811] = {recipient="ITVZ"}, -- Righteoous Orb
  
  -- Staub
  [10940] = {recipient="ITVZ"}, -- Seltsamer Staub
  [11083] = {recipient="ITVZ"}, -- Seelenstaub
  [11137] = {recipient="ITVZ"}, -- Visionenstaub
  [11176] = {recipient="ITVZ"}, -- Traumstaub
  [16204] = {recipient="ITVZ"}, -- Illusionsstaub


-- Schließkassetten
  [4632] = {recipient="Rshock"}, -- Ornate Bronze Lockbox
  [4633] = {recipient="Rshock"}, -- Heavy Bronze Lockbox
  [4634] = {recipient="Rshock"}, -- Iron Lockbox
  [4636] = {recipient="Rshock"}, -- Strong Iron Lockbox
  [4637] = {recipient="Rshock"}, -- Steel Lockbox
  [4638] = {recipient="Rshock"}, -- Reinforced Steel Lockbox
  [5758] = {recipient="Rshock"}, -- Mithril Lockbox
  [5759] = {recipient="Rshock"}, -- Thorium Lockbox
  [5760] = {recipient="Rshock"}, -- Eternium Lockbox

 
 
 -- IT Bank
[22525] = {recipient="ITBank"},      -- Crypt Fiend Parts (Spinnen dinger)
[19933] = {recipient="ITZeugs"},      -- Glowing Scoripd Blood
[7972] = {recipient="ITZeugs"},      -- Ichor of Undeath
[12809] = {recipient="ITBank"},      -- Guardian Stone
[11018] = {recipient="ITBank"},      -- Un'Goro Soil / Ungoro Erde
[22528] = {recipient="ITBank"},      -- Dark Iron Scraps




  
-- Feuer
  [7077] = {recipient="ITEle"}, -- Herz des Feuers (Heart of Fire)
  [7078] = {recipient="ITEle"}, -- Essenz des Feuers (Essence of Fire)
  [7068] = {recipient="ITEle"}, -- Elementarfeuer (Elemental Fire)

-- Erde
  [7067] = {recipient="ITEle"}, -- Elementarerde (Elemental Earth)
  [7075] = {recipient="ITEle"}, -- Kern der Erde (Core of Earth)
  [7076] = {recipient="ITEle"}, -- Essenz der Erde (Essence of Earth)
  

-- Wasser
  [7070] = {recipient="ITEle"}, -- Elementarwasser (Elemental Water)
  [7079] = {recipient="ITEle"}, -- Essenz des Wassers (Essence of Water)

-- Luft
  [7069] = {recipient="ITEle"}, -- Elementarluft (Elemental Air)
  [7080] = {recipient="ITEle"}, -- Essenz der Luft (Essence of Air)
  [7081] = {recipient="ITEle"}, -- Atem des Windes (Breath of Wind)

-- Natur
  [7082] = {recipient="ITEle"}, -- Essenz der Natur (Essence of Life/Nature)

-- Untod
  [12808] = {recipient="ITEle"}, -- Essenz des Untodes (Essence of Undead)

-- Leben
  [12803] = {recipient="ITEle"}, -- Essenz des Lebens (Living Essence)


-- Kerne & andere wichtige Drops
  [22527] = {recipient="ITEle"}, -- Kern der Elemente (Core of Elements)
  [22526] = {recipient="ITBank"}, -- Bonen Fragments 
  
  


-- Dunkelmondkarten & Sets → ITCard

-- Set: Bestien
[19227] = {recipient="ITCard"}, -- Deck des Dunkelmond-Jahrmarkts: Bestien
[19228] = {recipient="ITCard"}, -- Dunkelmond-Kartenset: Bestien
[19229] = {recipient="ITCard"}, -- Beasts Deck Reward Placeholder
[19230] = {recipient="ITCard"}, -- Dunkelmondkarte: Panther
[19231] = {recipient="ITCard"}, -- Dunkelmondkarte: Krokilisk
[19232] = {recipient="ITCard"}, -- Dunkelmondkarte: Hyäne
[19233] = {recipient="ITCard"}, -- Dunkelmondkarte: Bär
[19234] = {recipient="ITCard"}, -- Dunkelmondkarte: Affe
[19235] = {recipient="ITCard"}, -- Dunkelmondkarte: Tiger
[19236] = {recipient="ITCard"}, -- Dunkelmondkarte: Drache

-- Dunkelmond: Warlords (Deck + Einzelkarten) → ITCard
[19257] = {recipient="ITCard"}, -- Warlords Deck

[19258] = {recipient="ITCard"}, -- Ace of Warlords
[19259] = {recipient="ITCard"}, -- Two of Warlords
[19260] = {recipient="ITCard"}, -- Three of Warlords
[19261] = {recipient="ITCard"}, -- Four of Warlords
[19262] = {recipient="ITCard"}, -- Five of Warlords
[19263] = {recipient="ITCard"}, -- Six of Warlords
[19264] = {recipient="ITCard"}, -- Seven of Warlords
[19265] = {recipient="ITCard"}, -- Eight of Warlords

-- Set: Portale
[19267] = {recipient="ITCard"}, -- Deck des Dunkelmond-Jahrmarkts: Portale
[19268] = {recipient="ITCard"}, -- Dunkelmond-Kartenset: Portale
[19269] = {recipient="ITCard"}, -- Dunkelmondkarte: Portale (Ace of Portals)
[19270] = {recipient="ITCard"}, -- Zwei der Portale
[19271] = {recipient="ITCard"}, -- Drei der Portale
[19272] = {recipient="ITCard"}, -- Vier der Portale
[19273] = {recipient="ITCard"}, -- Fünf der Portale
[19274] = {recipient="ITCard"}, -- Sechs der Portale
[19275] = {recipient="ITCard"}, -- Sieben der Portale
[19276] = {recipient="ITCard"}, -- Acht der Portale

-- Set: Elemente
[19277] = {recipient="ITCard"}, -- Deck des Dunkelmond-Jahrmarkts: Elemente
[19278] = {recipient="ITCard"}, -- Dunkelmond-Kartenset: Elemente
[19279] = {recipient="ITCard"}, -- Ass der Elemente
[19280] = {recipient="ITCard"}, -- Zwei der Elemente
[19281] = {recipient="ITCard"}, -- Drei der Elemente
[19282] = {recipient="ITCard"}, -- Vier der Elemente
[19283] = {recipient="ITCard"}, -- Fünf der Elemente
[19284] = {recipient="ITCard"}, -- Sechs der Elemente
[19285] = {recipient="ITCard"}, -- Sieben der Elemente
[19286] = {recipient="ITCard"}, -- Acht der Elemente

-- Set: Krieg
[19287] = {recipient="ITCard"}, -- Deck des Dunkelmond-Jahrmarkts: Krieg
[19288] = {recipient="ITCard"}, -- Dunkelmond-Kartenset: Krieg
[19289] = {recipient="ITCard"}, -- Ass des Krieges
[19290] = {recipient="ITCard"}, -- Zwei des Krieges
[19291] = {recipient="ITCard"}, -- Drei des Krieges
[19292] = {recipient="ITCard"}, -- Vier des Krieges
[19293] = {recipient="ITCard"}, -- Fünf des Krieges
[19294] = {recipient="ITCard"}, -- Sechs des Krieges
[19295] = {recipient="ITCard"}, -- Sieben des Krieges
[19296] = {recipient="ITCard"}, -- Acht des Krieges



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

-- aktuell getippter Empfänger (für Skip)
local function RAM_GetCurrentTypedRecipientLower()
  if SendMailNameEditBox and SendMailNameEditBox.GetText then
    return RAM_sanitizeName(SendMailNameEditBox:GetText())
  end
  return nil
end

-- eigener Charname (für Skip Self)
local function RAM_GetPlayerLower()
  local n = UnitName and UnitName("player") or nil
  return RAM_sanitizeName(n)
end

-- Gibt es noch Items, die an NICHT übersprungene Empfänger gehen?
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

-- Nächsten Stack für einen Empfänger finden (achtet auf Skip & Self)
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

-- Empfängerliste aus Taschen (achtet auf Skip & Self)
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
            table.insert(list, rule.recipient) -- Original-Schreibweise für UI/Logs
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
  if skipLower then RAM_Print("Skip aktiv für Empfänger (getippt): "..(SendMailNameEditBox:GetText() or "?")) end
  if selfLower then RAM_Print("Eigener Char wird immer übersprungen: "..(UnitName("player") or "?")) end

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
      -- Notbremse: falscher Empfänger -> direkt zum nächsten
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
      SendMail(current, subject, "")

      -- zählen
      sending.totals[current] = sending.totals[current] or {}
      sending.totals[current][itemID] = (sending.totals[current][itemID] or 0) + count
      sending.totalAll = sending.totalAll + count

      if RAM_DEBUG then
        RAM_Print(" -> Mail: "..itemName.." x"..tostring(count).." an "..current.." (Subj: "..subject..")")
      end

      sending.lastT = now
      return
    else
      -- für diesen Empfänger nichts mehr -> nächster
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
