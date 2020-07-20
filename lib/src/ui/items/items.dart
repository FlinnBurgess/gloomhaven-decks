enum ItemType { head, body, oneHanded, twoHanded, feet, smallItem }

enum Usage { spend, consume, passive }

const items = {
  1: {
    'name': 'Boots of Striding',
    'cost': 20,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.feet
  },
  2: {
    'name': 'Winged Shoes',
    'cost': 20,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.feet
  },
  3: {
    'name': 'Hide Armor',
    'cost': 10,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.body
  },
  4: {
    'name': 'Leather Armor',
    'cost': 20,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.body
  },
  5: {
    'name': 'Cloak of Invisibility',
    'cost': 20,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.body
  },
  6: {
    'name': 'Eagle-Eye Goggles',
    'cost': 30,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.head
  },
  7: {
    'name': 'Iron Helmet',
    'cost': 10,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.head
  },
  8: {
    'name': 'Heater Shield',
    'cost': 20,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.oneHanded
  },
  9: {
    'name': 'Piercing Bow',
    'cost': 30,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.twoHanded
  },
  10: {
    'name': 'War Hammer',
    'cost': 30,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.twoHanded
  },
  11: {
    'name': 'Poison Dagger',
    'cost': 20,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.oneHanded
  },
  12: {
    'name': 'Minor Healing Potion',
    'cost': 10,
    'stock': 4,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  13: {
    'name': 'Minor Stamina Potion',
    'cost': 10,
    'stock': 4,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  14: {
    'name': 'Minor Power Potion',
    'cost': 10,
    'stock': 4,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  15: {
    'name': 'Boots of Speed',
    'cost': 30,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.feet
  },
  16: {
    'name': 'Cloak of Pockets',
    'cost': 20,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.body
  },
  17: {
    'name': 'Empowering Talisman',
    'cost': 45,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.head
  },
  18: {
    'name': 'Battle-Axe',
    'cost': 20,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.oneHanded
  },
  19: {
    'name': 'Weighted Net',
    'cost': 20,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.twoHanded
  },
  20: {
    'name': 'Minor Mana Potion',
    'cost': 10,
    'stock': 4,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  21: {
    'name': 'Stun Powder',
    'cost': 20,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  22: {
    'name': 'Heavy Greaves',
    'cost': 20,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.feet
  },
  23: {
    'name': 'Chainmail',
    'cost': 20,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.body
  },
  24: {
    'name': 'Amulet of Life',
    'cost': 20,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.head
  },
  25: {
    'name': 'Jagged Sword',
    'cost': 30,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.oneHanded
  },
  26: {
    'name': 'Long Spear',
    'cost': 30,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.twoHanded
  },
  27: {
    'name': 'Major Healing Potion',
    'cost': 30,
    'stock': 4,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  28: {
    'name': 'Moon Earring',
    'cost': 20,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  29: {
    'name': 'Comfortable Shoes',
    'cost': 30,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.feet
  },
  30: {
    'name': 'Studded Leather',
    'cost': 30,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.body
  },
  31: {
    'name': 'Hawk Helm',
    'cost': 20,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.head
  },
  32: {
    'name': 'Tower Shield',
    'cost': 40,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.oneHanded
  },
  33: {
    'name': 'Volatile Bomb',
    'cost': 30,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.oneHanded
  },
  34: {
    'name': 'Major Stamina Potion',
    'cost': 30,
    'stock': 4,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  35: {
    'name': 'Falcon Figurine',
    'cost': 50,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  36: {
    'name': 'Boots of Dashing',
    'cost': 40,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.feet
  },
  37: {
    'name': 'Robes of Evocation',
    'cost': 40,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.body
  },
  38: {
    'name': 'Heavy Basinet',
    'cost': 30,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.head
  },
  39: {
    'name': 'Hooked Chain',
    'cost': 40,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.twoHanded
  },
  40: {
    'name': 'Versatile Dagger',
    'cost': 25,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.oneHanded
  },
  41: {
    'name': 'Major Power Potion',
    'cost': 40,
    'stock': 4,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  42: {
    'name': 'Ring of Haste',
    'cost': 30,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  43: {
    'name': 'Boots of Quickness',
    'cost': 75,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.feet
  },
  44: {
    'name': 'Splintmail',
    'cost': 35,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.body
  },
  45: {
    'name': 'Pendant of Dark Pacts',
    'cost': 75,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.head
  },
  46: {
    'name': 'Spiked Shield',
    'cost': 40,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.oneHanded
  },
  47: {
    'name': 'Reaping Scythe',
    'cost': 40,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.twoHanded
  },
  48: {
    'name': 'Major Mana Potion',
    'cost': 30,
    'stock': 4,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  49: {
    'name': 'Sun Earring',
    'cost': 40,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  50: {
    'name': 'Steel Sabatons',
    'cost': 60,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.feet
  },
  51: {
    'name': 'Shadow Armor',
    'cost': 30,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.body
  },
  52: {
    'name': 'Protective Charm',
    'cost': 60,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.head
  },
  53: {
    'name': 'Black Knife',
    'cost': 25,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.oneHanded
  },
  54: {
    'name': 'Staff of Eminence',
    'cost': 60,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.twoHanded
  },
  55: {
    'name': 'Super Healing Potion',
    'cost': 50,
    'stock': 4,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  56: {
    'name': 'Ring of Brutality',
    'cost': 40,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  57: {
    'name': 'Serene Sandals',
    'cost': 75,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.feet
  },
  58: {
    'name': 'Cloak of Phasing',
    'cost': 75,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.body
  },
  59: {
    'name': 'Telescopic Lens',
    'cost': 50,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.head
  },
  60: {
    'name': 'Unstable Explosives',
    'cost': 45,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.oneHanded
  },
  61: {
    'name': 'Wall Shield',
    'cost': 60,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.twoHanded
  },
  62: {
    'name': 'Doom Powder',
    'cost': 40,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  63: {
    'name': 'Lucky Eye',
    'cost': 60,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  64: {
    'name': 'Boots of Sprinting',
    'cost': 75,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.feet
  },
  65: {
    'name': 'Platemail',
    'cost': 50,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.body
  },
  66: {
    'name': 'Mask of Terror',
    'cost': 50,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.head
  },
  67: {
    'name': 'Balanced Blade',
    'cost': 60,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.oneHanded
  },
  68: {
    'name': 'Halberd',
    'cost': 60,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.twoHanded
  },
  69: {
    'name': 'Star Earring',
    'cost': 70,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  70: {
    'name': 'Second Chance Ring',
    'cost': 75,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  71: {
    'name': 'Boots of Levitation',
    'cost': 50,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.feet
  },
  72: {
    'name': 'Shoes of Happiness',
    'cost': 50,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.feet
  },
  73: {
    'name': 'Blinking Cape',
    'cost': 50,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.body
  },
  74: {
    'name': 'Swordedge Armor',
    'cost': 40,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.body
  },
  75: {
    'name': 'Circlet of Elements',
    'cost': 25,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.head
  },
  76: {
    'name': 'Chain Hood',
    'cost': 40,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.head
  },
  77: {
    'name': 'Frigid Blade',
    'cost': 30,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.oneHanded
  },
  78: {
    'name': 'Storm Blade',
    'cost': 30,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.oneHanded
  },
  79: {
    'name': 'Inferno Blade',
    'cost': 30,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.oneHanded
  },
  80: {
    'name': 'Tremor Blade',
    'cost': 30,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.oneHanded
  },
  81: {
    'name': 'Brilliant Blade',
    'cost': 30,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.oneHanded
  },
  82: {
    'name': 'Night Blade',
    'cost': 30,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.oneHanded
  },
  83: {
    'name': 'Wand of Frost',
    'cost': 30,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.oneHanded
  },
  84: {
    'name': 'Wand of Storms',
    'cost': 30,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.oneHanded
  },
  85: {
    'name': 'Wand of Infernos',
    'cost': 30,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.oneHanded
  },
  86: {
    'name': 'Wand of Tremors',
    'cost': 30,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.oneHanded
  },
  87: {
    'name': 'Wand of Brilliance',
    'cost': 30,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.oneHanded
  },
  88: {
    'name': 'Wand of Darkness',
    'cost': 30,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.oneHanded
  },
  89: {
    'name': 'Minor Cure Potion',
    'cost': 10,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  90: {
    'name': 'Major Cure Potion',
    'cost': 30,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  91: {
    'name': 'Steel Ring',
    'cost': 20,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  92: {
    'name': 'Dampening Ring',
    'cost': 25,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  93: {
    'name': 'Scroll of Power',
    'cost': 30,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  94: {
    'name': 'Scroll of Healing',
    'cost': 30,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  95: {
    'name': 'Scroll of Stamina',
    'cost': 50,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  96: {
    'name': 'Rocket Boots',
    'cost': 80,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.feet
  },
  97: {
    'name': 'Endurance Footwraps',
    'cost': 40,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.feet
  },
  98: {
    'name': 'Drakescale Boots',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.feet
  },
  99: {
    'name': 'Magma Waders',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.feet
  },
  100: {
    'name': 'Robes of Summoning',
    'cost': 40,
    'stock': 1,
    'usage': Usage.spend,
    'type': ItemType.body
  },
  101: {
    'name': 'Second Skin',
    'cost': 30,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.body
  },
  102: {
    'name': 'Sacrificial Robes',
    'cost': 50,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.body
  },
  103: {
    'name': 'Drakescale Armor',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.body
  },
  104: {
    'name': 'Steam Armor',
    'cost': 50,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.body
  },
  105: {
    'name': 'Flea-Bitten Shawl',
    'cost': 10,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.body
  },
  106: {
    'name': 'Necklace of Teeth',
    'cost': 40,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.head
  },
  107: {
    'name': 'Horned Helm',
    'cost': 30,
    'stock': 2,
    'usage': Usage.passive,
    'type': ItemType.head
  },
  108: {
    'name': 'Drakescale Helm',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.head
  },
  109: {
    'name': 'Thief\'s Hood',
    'cost': 20,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.head
  },
  110: {
    'name': 'Helm of the Mountain',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.head
  },
  111: {
    'name': 'Wave Crest',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.head
  },
  112: {
    'name': 'Ancient Drill',
    'cost': 30,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.twoHanded
  },
  113: {
    'name': 'Skullbane Axe',
    'cost': 50,
    'stock': 1,
    'usage': Usage.spend,
    'type': ItemType.twoHanded
  },
  114: {
    'name': 'Staff of Xorn',
    'cost': 50,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.twoHanded
  },
  115: {
    'name': 'Mountain Hammer',
    'cost': 50,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.twoHanded
  },
  116: {
    'name': 'Fueled Falchion',
    'cost': 20,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.oneHanded
  },
  117: {
    'name': 'Bloody Axe',
    'cost': 40,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.oneHanded
  },
  118: {
    'name': 'Staff of Elements',
    'cost': 50,
    'stock': 2,
    'usage': Usage.spend,
    'type': ItemType.twoHanded
  },
  119: {
    'name': 'Skull of Hatred',
    'cost': 50,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.oneHanded
  },
  120: {
    'name': 'Staff of Summoning',
    'cost': 60,
    'stock': 1,
    'usage': Usage.spend,
    'type': ItemType.twoHanded
  },
  121: {
    'name': 'Orb of Dawn',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.oneHanded
  },
  122: {
    'name': 'Orb of Twilight',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.oneHanded
  },
  123: {
    'name': 'Ring of Skulls',
    'cost': 50,
    'stock': 2,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  124: {
    'name': 'Doomed Compass',
    'cost': 50,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  125: {
    'name': 'Curious Gear',
    'cost': 50,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  126: {
    'name': 'Remote Spider',
    'cost': 40,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  127: {
    'name': 'Giant Remote Spider',
    'cost': 60,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  128: {
    'name': 'Black Censer',
    'cost': 50,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  129: {
    'name': 'Black Card',
    'cost': 75,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  130: {
    'name': 'Helix Ring',
    'cost': 50,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  131: {
    'name': 'Heart of the Betrayer',
    'cost': 60,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  132: {
    'name': 'Power Core',
    'cost': 75,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  133: {
    'name': 'Resonant Crystal',
    'cost': 20,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  134: {
    'name': 'Imposing Blade',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.oneHanded
  },
  135: {
    'name': 'Focusing Ray',
    'cost': 50,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.oneHanded
  },
  136: {
    'name': 'Volatile Elixir',
    'cost': 50,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  137: {
    'name': 'Silent Stiletto',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.oneHanded
  },
  138: {
    'name': 'Stone Charm',
    'cost': 50,
    'stock': 1,
    'usage': Usage.spend,
    'type': ItemType.head
  },
  139: {
    'name': 'Psychic Knife',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.oneHanded
  },
  140: {
    'name': 'Sun Shield',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.oneHanded
  },
  141: {
    'name': 'Utility Belt',
    'cost': 50,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  142: {
    'name': 'Phasing Idol',
    'cost': 50,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  143: {
    'name': 'Smoke Elixir',
    'cost': 50,
    'stock': 1,
    'usage': Usage.consume,
    'type': ItemType.smallItem
  },
  144: {
    'name': 'Pendant of the Plague',
    'cost': 50,
    'stock': 1,
    'usage': Usage.spend,
    'type': ItemType.head
  },
  145: {
    'name': 'Mask of Death',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.head
  },
  146: {
    'name': 'Master\'s Lute',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.twoHanded
  },
  147: {
    'name': 'Cloak of the Hunter',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.body
  },
  148: {
    'name': 'Doctor\'s Coat',
    'cost': 50,
    'stock': 1,
    'usage': Usage.passive,
    'type': ItemType.body
  },
  149: {
    'name': 'Elemental Boots',
    'cost': 50,
    'stock': 1,
    'usage': Usage.spend,
    'type': ItemType.feet
  },
  150: {
    'name': 'Staff of Command',
    'cost': 50,
    'stock': 1,
    'usage': Usage.spend,
    'type': ItemType.twoHanded
  },
  151: {
    'name': 'Sword of the Sands',
    'cost': 50,
    'type': ItemType.oneHanded,
    'usage': Usage.consume,
    'stock': 1
  },
};
