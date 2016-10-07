# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

category_types = CategoryType.create({name: "Regional"}, {name: "Races"}, 
                                     {name: "Interests"})

tags = Tag.create(
  {name: "dusseldorf"}, {name: "germany"}, {name: "france"}, {name: "italy"},
  {name: "malta"}, {name: "spain"}, {name: "barcelona"}, {name: "great britain"},
  {name: "uk "}, {name: "united kingdom"}, {name: "england"}, {name: "ireland"},
  {name: "sweden"}, {name: "norway"}, {name: "finland"}, {name: "netherlands"},
  {name: "amsterdam"}, {name: "scotland"}, {name: "belgium"}, {name: "brussels"},
  {name: "greece"}, {name: "azores"}, {name: "gibraltar"}, {name: "canary"},
  {name: "portugal"}, {name: "croatia"}, {name: "romania"}, {name: "bulgaria"},
  {name: "maldova"}, {name: "ukraine"}, {name: "russia"}, {name: "black sea"},
  {name: "north sea"}, {name: "baltic sea"}, {name: "poland"}, {name: "lithuania"},
  {name: "latvia"}, {name: "estonia"}, {name: "english channel"}, {name: "celtic sea"},
  {name: "isle of man"}, 
  {name: "australia"}, {name: "sydney"}, {name: "new zealand"}, {name: "fiji"},
  {name: "tonga"}, {name: "tahiti"}, {name: "marquesas"}, {name: "hawaii"},
  {name: "solomon"}, {name: "cook islands"}, {name: "indonesia"}, {name: "kiribati"},
  {name: "marshall islands"}, {name: "micronesia"}, {name: "nauru"}, {name: "niue"},
  {name: "palau"}, {name: "papua"}, {name: "samoa"}, {name: "solomon islands"},
  {name: "tuvalu"}, {name: "vanuatu"}, {name: "tasman"}, {name: "polynesia"},
  {name: "picairn"},
  {name: "albania"}, {name: "montenegro"}, {name: "corsica"}, {name: "cyprus"},
  {name: "sardinia"}, {name: "morocco"}, {name: "algeria"}, {name: "tunisia"},
  {name: "libya"}, {name: "egypt"}, {name: "israel"}, {name: "lebanon"},
  {name: "jordan"}, {name: "syria"}, {name: "turkey"}, {name: "monaco"},
  {name: "turkey"}, {name: "jordan"}, {name: "syria"}, {name: "israel"},
  {name: "saudi"}, {name: "oman"}, {name: "qatar"}, {name: "egypt"},
  {name: "caspian sea"}, {name: "lebanon"}, {name: "saudi"}, {name: "bahrain"},
  {name: "yemen"}, {name: "arabian sea"}, {name: "iran"}, {name: "gulf of aden"},
  {name: "suez canal"}, {name: "red sea"}, {name: "pakistan"},
  {name: "morocco"}, {name: "algeria"}, {name: "tunisia"}, {name: "libya"},
  {name: "egypt"}, {name: "mauritania"}, {name: "sahara"}, {name: "senegal"},
  {name: "cape verde"}, {name: "gambia"}, {name: "guinea"}, {name: "sierra leone"},
  {name: "liberia"}, {name: "ivory coast"}, {name: "cote d'ivoire"}, {name: "ghana}",
  {name: "togo"}, {name: "benin"}, {name: "nigeria"}, {name: "cameroon"}, 
  {name: "gabon"}, {name: "congo"}, {name: "angola"}, {name: "namibia"},
  {name: "south africa"}, {name: "mozambique"}, {name: "madagascar"},
  {name: "mauritius"}, {name: "reunion"}, {name: "mozambique"}, {name: "tanzania"},
  {name: "kenya"}, {name: "somalia"}, {name: "djibouti"}, {name: "eritrea"},
  {name: "sudan"}, {name: "good hope"}, {name: "seychelles"},
  {name: "brazil"}, {name: "patagonia"}, {name: "galapagos"}, {name: "easter island"},
  {name: "venezuela"}, {name: "guyana"}, {name: "colombia"}, {name: "ecuador"},
  {name: "peru"}, {name: "chile"}, {name: "argentina"}, {name: "cape horn"},
  {name: "uruguay"}, {name: "falkland"}, {name: "surinam"}, {name: "guiana"},
  {name: "cuba"}, {name: "bahama"}, {name: "cayman"}, {name: "turks and caicos"},
  {name: "jamaica"}, {name: "exumas"}, {name: "abaco"}, {name: "eleuthera"},
  {name: "nassau"}, {name: "haita"}, {name: "dominican"}, {name: "puerto rico"},
  {name: "vieques"}, {name: "culebra"}, {name: "bvi"}, {name: "usvi"},
  {name: "virgin islands"}, {name: "anguilla"}, {name: "kitts"}, {name: "nevis"},
  {name: "antigua"}, {name: "barbuda"}, {name: "montserrat"}, {name: "st john"},
  {name: "guadeloupe"}, {name: "dominica"}, {name: "martinique"}, {name: "st lucia"},
  {name: "st vincent"}, {name: "grenadines"}, {name: "barbados"}, {name: "tobago"},
  {name: "trinidad"}, {name: "grenada"}, {name: "curacao"}, {name: "aruba"},
  {name: "tortuga"}, {name: "bonaire"},
  {name: "china"}, {name: "hong kong"}, {name: "korea"}, {name: "japan"},
  {name: "taiwan"}, {name: "beijing"},
  {name: "india"}, {name: "sri lanka"}, {name: "bangladesh"}, {name: "bengal"},
  {name: "nicobar"}, {name: "burma"}, {name: "myanmar"}, {name: "thailand"},
  {name: "malaysia"}, {name: "singapore"}, {name: "cambodia"}, {name: "vietnam"},
  {name: "philippines"}, {name: "bali"}, {name: "malacca"},
  {name: "united states"}, {name: "u.s.a."}, {name: "bermuda"}, {name: "hawaii"},
  {name: "usa"}, {name: "alaska"}, {name: "icw"}, {name: "new england"},
  {name: "intercoastal waterway"}, {name: "american"}, {name: "hudson"},
  {name: "iceland"}, {name: "canada"}, {name: "mexico"}, {name: "cortez"},
  {name: "newport"}, {name: "seattle"}, {name: "san francisco"}, {name: "monterrey"},
  {name: "oregon"}, {name: "california"}, {name: "catalina"}, {name: "santa barabara"},
  {name: "san diego"}, {name: "los angeles"}, {name: "channel islands"}, 
  {name: "texas"}, {name: "new orleans"}, {name: "corpus christi"}, {name: "florida"},
  {name: "miami"}, {name: "georgia"}, {name: "carolina"}, {name: "charleston"},
  {name: "maryland"}, {name: "virginia"}, {name: "deleware"}, {name: "delmarva"},
  {name: "annapolis"}, {name: "new jersey"}, {name: "new york"}, {name: "connecticut"},
  {name: "rhode island"}, {name: "massachusetts"}, {name: "nantucket"},
  {name: "martha's vineyard"}, {name: "cape cod"}, {name: "new hampshire"},
  {name: "maine"}, {name: "nova scotia"}, {name: "prince edward"}, {name: "labrador"},
  {name: "greenland"}, {name: "cape sable"}, {name: "newfoundland"},
  {name: "british columbia"}, {name: "vancouver"}, {name: "michigan"}, {name: "ohio"},
  {name: "chicago"}, {name: "great lakes"}, {name: "toronto"}, {name: "wisconsin"},
  {name: "illinois"}, {name: "minnesota"}, {name: "ontario"}, {name: "quebec"},
  {name: "panama"}, {name: "costa rica"}, {name: "nicaragua"}, {name: "honduras"},
  {name: "salvador"}, {name: "guatemala"}, {name: "belize"},
  
  {name: "america's cup"}, {name: "americas cup"}, {name: "outteridge"},
  {name: "artemis"}, {name: "ashby"}, {name: "emirates"}, {name: "cammas"},
  {name: "groupama"}, {name: "ainsle"}, {name: "land rover"}, {name: "spithill"},
  {name: "oracle"}, {name: "barker"}, {name: "softbank"},
  {name: "vendee"}, {name: "jean-francois pellet"}, {name: "jean pellet"},
  {name: "didac costa"}, {name: "romain attanasio"}, {name: "pieter heerema"},
  {name: "stephan le diraison"}, {name: "alan roura"}, {name: "richard tolkein"},
  {name: "arnaud boissieres"}, {name: "alex thompson"}, {name: "rich wilson"},
  {name: "nandor fa"}, {name: "louis burton"}, {name: "bertrand de broc"},
  {name: "jean le cam"}, {name: "kito de pavant"}, {name: "nicolas boidevezi"},
  {name: "thomas ruyant"}, {name: "yann elies"}, {name: "sebastien josse"},
  {name: "fabrice amedeo"}, {name: "jean-pierre dick"}, {name: "jean pierre dick"},
  {name: "eric bellion"}, {name: "sebastien destremau"}, {name: "paul meilhat"},
  {name: "armel le cleac'h"}, {name: "armel le cleach"}, {name: "morgan lagraviere"},
  {name: "vincent riou"}, {name: "tanguy de lamotte"}, {name: "jeremie beyou"},
  {name: "clipper"}, {name: "matt mitchell"}, {name: "telemed"}, {name: "wendy tuck"},
  {name: "da nang"}, {name: "daniel smith"}, {name: "londonderry"}, 
  {name: "ashley skett"}, {name: "peter thornton"}, {name: "great britain"},
  {name: "darren ladd"}, {name: "ichorcoal"}, {name: "olivier cardin"}, {name: "lmax"},
  {name: "greg miller"}, {name: "mission performance"}, {name: "max stunell"},
  {name: "psp"}, {name: "bob beggs"}, {name: "qingdao"}, {name: "paul atwood"},
  {name: "unicef"}, {name: "huw fernie"}, {name: "visit seattle"},
  {name: "olympic"}, {name: "ioc"}, {name: "470"}, {name: "49er"}, {name: "finn"},
  {name: "laser radial"}, {name: "laser"}, {name: "rs:x"}, {name: "elliott 6m"},
  {name: "gold medal"}, {name: "silver medal"}, {name: "bronze medal"},
  
  {name: "gear"}, {name: "radar"}, {name: "plotter"}, {name: "anchor"}, {name: "tech"},
  {name: "technology"}, {name: "review"}, {name: "flashlight"}, {name: "sunglasses"},
  {name: "pfd"}, {name: "foulies"}, {name: "jacket"}, {name: "watch"}, {name: "gps "},
  {name: "beer can"}, {name: "class"}, {name: "mount gay"}, {name: "rolex"},
  {name: "hugo boss"}, {name: "cup"}, {name: "match"}, {name: "foiler"},
  {name: "hall of fame"}, {name: "hugo boss"}, {name: "issa"}, {name: "laser"},
  {name: "m32"}, {name: "melges"}, {name: "moth"}, {name: "olympic"}, {name: "open 60"},
  {name: "racing"}, {name: "regatta"}, {name: "challenge"}, {name: "record"},
  {name: "rorc"}, {name: "sydney hobart"}, {name: "team"}, {name: "vendee"},
  {name: "farr"}, {name: "j/22"}, {name: "j/24"}, {name: "j/70"}, {name: "j/80"},
  {name: "j/88"}, {name: "j/95"}, {name: "j/112"}, {name: "j/97E"}, {name: "j/97"},
  {name: "j/100"}, {name: "j/105"}, {name: "j/111"}, {name: "j/112E"}, {name: "j/122"},
  {name: "j/122E"}, {name: "clipper"}, {name: "470"}, {name: "49er"}, {name: "finn"},
  {name: "rs:x"}, {name: "nacra"}, {name: "29er"}, {name: "420"}, {name: "505"},
  {name: "b14"}, {name: "byte"}, {name: "cadet"}, {name: "contender"},
  {name: "fireball"}, {name: "flying dutchman"}, {name: "flying junior"}, 
  {name: "gp14"}, {name: "international 14"}, {name: "isaf"}, {name: "sunfish"},
  {name: "vuitton"}, {name: "fastnet"}, {name: "cowes week"}, {name: "paccup"},
  {name: "arc"}, {name: "baja ha ha"}, {name: "caribbean 1500"}, {name: "transat"},
  {name: "fire"}, {name: "border patrol"}, {name: "mrsa"}, {name: "coast guard"},
  {name: "zika"}, {name: "rescue"}, {name: "grounding"}, {name: "sos"}, {name: "pfd"},
  {name: "liferaft"}, {name: "life raft"}, {name: "flare"}, {name: "piracy"},
  {name: "pirate"}, {name: "crime"}, {name: "lifevest"},{name: "life vest"},
  {name: "cpr"}, {name: "first aid"}, {name: "right of way"}, {name: "traffic lanes"},
  {name: "heavy weather"}, {name: "mob"}, {name: "overboard"}, {name: "swept o"},
  {name: "thief"}, {name: "theft"}, {name: "hurricane"}, {name: "insurance"},
  {name: "provision"}, {name: "repair"}, {name: "fix"}, {name: "rebuild"}, 
  {name: "replace"}, {name: "paint"}, {name: "clean"}, {name: "reseal"}, 
  {name: "juryrig"}, {name: "varnish"},
  {name: "travel"}, {name: "lifestyle"}, {name: "bareboat"},  {name: "charter"},
  {name: "marina"}, {name: "restaurant"}, {name: "bar "}, {name: "anchorage"},
  {name: "provision"},
  
  {name: "multihull"}, {name: "catamaran"}, {name: "trimaran"},
  {name: "family"}, {name: "families"}, {name: "kids"},
  {name: "solo"}, {name: "singlehand"}, {name: "single hand"},
  {name: "audio"}, {name: "podcast"}, {name: "podcasts"},
  {name: "video"}, {name: "videos"}, {name: "vlog"}, {name: "web series"}
)

regional_tags = {
  europe: ["dusseldorf", "germany", "france", "italy", "malta", "spain", 
                 "barcelona", "great britain", "uk ", "united kingdom", "england", 
                 "ireland", "sweden", "norway", "finland", "netherlands", "amsterdam", 
                 "scotland", "belgium", "brussels", "greece", "azores", "gibraltar", 
                 "canary", "portugal", "croatia", "romania", "bulgaria", "maldova", 
                 "ukraine", "russia", "black sea", "north sea", "baltic sea", "poland", 
                 "lithuania", "latvia", "estonia", "english channel", "celtic sea",
                 "isle of man"]

  oceania: = ["australia", "sydney", "new zealand", "fiji", "tonga", "tahiti", 
                  "marquesas", "hawaii", "solomon", "cook islands", "indonesia", 
                  "kiribati", "marshall islands", "micronesia", "nauru", "niue",
                  "palau", "papua", "samoa", "solomon islands", "tuvalu", "vanuatu", 
                  "tasman", "polynesia", "picairn", "hawaii"]

  mediterranean: ["malta", "italy", "france", "spain", "gibraltar", "monaco", "croatia", 
              "greece", "albania", "montenegro", "corsica", "cyprus", "sardinia", 
              "morocco", "algeria", "tunisia", "libya", "egypt", "israel", "lebanon",
              "jordan", "syria", "turkey"]

  middle_east: ["turkey", "jordan", "syria", "israel", "saudi", "oman", "qatar",
                   "egypt", "caspian sea", "lebanon", "bahrain", "yemen",
                   "arabian sea", "iran", "gulf of aden", "suez canal",
                   "red sea", "pakistan"]

  africa: ["morocco", "algeria", "tunisia", "libya", "egypt", "mauritania",
                 "sahara", "senegal", "cape verde", "gambia", "guinea", "sierra leone",
                 "liberia", "ivory coast", "cote d'ivoire", "ghana", "togo", "benin",
                 "nigeria", "cameroon", "gabon", "congo", "angola", "namibia",
                 "south africa", "mozambique", "madagascar", "mauritius", "reunion",
                 "mozambique", "tanzania", "kenya", "somalia", "djibouti", "eritrea",
                 "sudan", "good hope", "seychelles"]

  south_america: ["brazil", "patagonia", "galapagos", "easter island", "venezuela",
                        "guyana", "colombia", "ecuador", "peru", "chile", "argentina",
                        "cape horn", "uruguay", "falkland", "surinam", "guiana"]

  caribbean: ["cuba", "bahama", "cayman", "turks and caicos", "jamaica", "exumas", 
                    "abaco", "eleuthera", "nassau", "haiti", "dominican", "puerto rico", 
                    "vieques", "culebra", "bvi", "usvi", "virgin islands", "anguilla", 
                    "kitts", "nevis", "antigua", "barbuda", "montserrat", "st john", 
                    "guadeloupe", "dominica", "martinique", "st lucia", "st vincent", 
                    "grenadines", "barbados", "tobago", "trinidad", "grenada", "curacao", 
                    "aruba", "tortuga", "bonaire"]

  asia: ["china", "hong kong", "korea", "japan", "taiwan", "beijing"]

  southeast_asia: ["india", "sri lanka", "bangladesh", "bengal", "nicobar", 
                         "burma", "myanmar", "thailand", "malaysia", "singapore", 
                         "cambodia", "vietnam", "philippines", "bali", "malacca"]

  north_america: ["united states", "u.s.a.", "bermuda", "hawaii", "alaska", "icw", 
                        "new england", "intercoastal waterway", "american", "hudson", 
                        "iceland", "canada", "mexico", "cortez", "newport", "seattle", 
                        "san francisco", "monterrey", "oregon", "california", "catalina",
                        "santa barabara", "san diego", "los angeles", "channel islands", 
                        "texas", "new orleans", "corpus christi", "florida", "miami", 
                        "georgia", "carolina", "charleston", "maryland", "virginia", 
                        "deleware", "delmarva", "annapolis", "new jersey", "new york", 
                        "connecticut", "rhode island", "massachusetts", "nantucket", 
                        "martha's vineyard", "cape cod", "new hampshire", "maine", 
                        "nova scotia", "prince edward", "labrador", "greenland", 
                        "cape sable", "newfoundland", "british columbia", "vancouver", 
                        "michigan", "ohio", "chicago", "great lakes", "toronto", 
                        "wisconsin", "illinois", "minnesota", "ontario", "quebec"]

  central_america: ["panama", "costa rica", "nicaragua", "honduras",
                          "salvador", "guatemala", "belize"]
}

race_tags = {
  americas_cup: ["america's cup", "americas cup", "outteridge", "artemis", 
                       "ashby", "emirates", "cammas", "groupama", "ainsle", 
                       "land rover", "spithill", "oracle", "barker", "softbank"]

  vendee_globe: ["vendee", "jean-francois pellet", "jean pellet", "didac costa", 
                 "romain attanasio", "pieter heerema", "stephan le diraison", 
                 "alan roura", "richard tolkein", "arnaud boissieres", "alex thompson", 
                 "rich wilson", "nandor fa", "louis burton", "bertrand de broc",
                 "jean le cam", "kito de pavant", "nicolas boidevezi", "thomas ruyant", 
                 "yann elies", "sebastien josse", "fabrice amedeo", "jean-pierre dick", 
                 "jean pierre dick", "eric bellion", "sebastien destremau", 
                 "paul meilhat", "armel le cleac'h", "armel le cleach", 
                 "morgan lagraviere", "vincent riou", "tanguy de lamotte", 
                 "jeremie beyou"]

  clipper_race: ["clipper", "matt mitchell", "telemed", "wendy tuck", "da nang",
                  "daniel smith", "londonderry", "ashley skett", "garmin",
                  "peter thornton", "great britain", "darren ladd", "ichorcoal",
                  "olivier cardin", "lmax", "greg miller", "mission performance",
                  "max stunell", "psp", "bob beggs", "qingdao", "paul atwood",
                  "unicef", "huw fernie", "visit seattle"]

  olympics: ["olympic", "ioc", "470", "49er", "finn", "laser radial", "laser", 
                   "rs:x", "elliott 6m", "gold medal", "silver medal", "bronze medal"]
}

interest_tags {                 
  gear: ["gear", "radar", "plotter", "anchor", "tech", "technology",
               "review", "flashlight", "sunglasses", "epirb", "pfd", "foulies",
               "jacket", "watch", "gps "]
             
  racing: ["beer can", "class", "mount gay", "rolex", "hugo boss", "cup",
                 "match", "foiler", "hall of fame", "hugo boss", "issa", "laser",
                 "m32", "melges", "moth", "olympic", "open 60", "racing", "regatta",
                 "challenge", "record", "rorc", "sydney hobart", "team", "vendee",
                 "farr", "j/22", "j/24", "j/70", "j/80", "j/88", "j/95", "j/112",
                 "j/97E", "j/97", "j/100", "j/105", "j/111", "j/112E", "j/122",
                 "j/122E", "clipper", "470", "49er", "finn", "rs:x", "nacra", "29er",
                 "420", "505", "b14", "byte", "cadet", "contender", "fireball",
                 "flying dutchman", "flying junior", "gp14", "international 14",
                 "isaf", "sunfish", "vuitton", "fastnet", "cowes week", "paccup",
                 "arc", "baja ha ha", "caribbean 1500", "transat"]
             
  safety: ["fire", "border patrol", "mrsa", "coast guard", "zika", "rescue", 
                 "grounding", "sos", "pfd", "liferaft", "life raft", "flare", "piracy", 
                 "pirate", "crime", "lifevest", "life vest", "cpr", "first aid", 
                 "right of way", "traffic lanes", "heavy weather", "mob", "overboard", 
                 "swept o", "thief", "theft", "insurance", "hurricane", "juryrig"]
             
  maintenance: = ["repair", "fix", "rebuild", "replace", "paint", 
                      "clean", "reseal", "juryrig", "varnish"]
             
  travel: = ["travel", "lifestyle", "bareboat", "charter", "marina", "restaurant", 
                 "beach bar ", "anchorage", "provision"]
                    
  multihull: = ["multihull", "multi-hull", "catamaran", "trimaran"]
  family: = ["family", "families", "kids"]
  single_hander: = ["solo", "singlehand", "single hand"]

  audio: ["audio", "podcast", "podcasts"]
  video: = ["video", "videos", "vlog", "web series"]
}

[regional_tags, race_tags, interest_tags].each do |tag_set|
  
end