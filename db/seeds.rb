# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

def clear_table(clazz)
  clazz.all.each do |rec|
    rec.destroy
  end
end


# Clear the tables before trying to rebuild them
puts "Clearing Tables"
clear_table(Feed)
clear_table(Publisher)
clear_table(Language)
clear_table(FeedType)
clear_table(Category)
clear_table(Tag)
clear_table(CategoryType)
clear_table(Policies)
clear_table(Users)

# Setup the Policies and the initial admin user
# ---------------------------------------------------------------
puts "Adding Policies"
policies = Policy.create!([
  {name: 'add_categories'},
  {name: 'add_publishers'},
  {name: 'edit_categories'},
  {name: 'edit_publishers'}
])

puts "Adding Admin User -- login: admin@marinerreport.com / password123"
admin = User.create!(
  email: "admin@marinerreport.com",
  password: "password123",
  password_confirmation: "password123",
  policies: policies)

# Tags
# ---------------------------------------------------------------
puts "Adding Tags"
t_europe = Tag.create!([
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
  {name: "isle of man"}
])

t_oceania = Tag.create!([
  {name: "australia"}, {name: "sydney"}, {name: "new zealand"}, {name: "fiji"},
  {name: "tonga"}, {name: "tahiti"}, {name: "marquesas"}, {name: "hawaii"},
  {name: "solomon"}, {name: "cook islands"}, {name: "indonesia"}, {name: "kiribati"},
  {name: "marshall islands"}, {name: "micronesia"}, {name: "nauru"}, {name: "niue"},
  {name: "palau"}, {name: "papua"}, {name: "samoa"}, {name: "solomon islands"},
  {name: "tuvalu"}, {name: "vanuatu"}, {name: "tasman"}, {name: "polynesia"},
  {name: "picairn"}
])

t_mediterranean = Tag.create!([
  {name: "albania"}, {name: "montenegro"}, {name: "corsica"}, {name: "cyprus"},
  {name: "sardinia"}, {name: "israel"}, {name: "lebanon"}, {name: "jordan"}, 
  {name: "syria"}, {name: "turkey"}, {name: "monaco"}
])

t_middle_east = Tag.create!([
  {name: "saudi"}, {name: "oman"}, {name: "qatar"}, {name: "egypt"},
  {name: "caspian sea"}, {name: "bahrain"}, {name: "yemen"}, {name: "arabian sea"}, 
  {name: "iran"}, {name: "gulf of aden"}, {name: "suez canal"}, {name: "red sea"}, 
  {name: "pakistan"}
])

t_africa = Tag.create!([
  {name: "morocco"}, {name: "algeria"}, {name: "tunisia"}, {name: "libya"},
  {name: "mauritania"}, {name: "sahara"}, {name: "senegal"},
  {name: "cape verde"}, {name: "gambia"}, {name: "guinea"}, {name: "sierra leone"},
  {name: "liberia"}, {name: "ivory coast"}, {name: "cote d'ivoire"}, {name: "ghana"},
  {name: "togo"}, {name: "benin"}, {name: "nigeria"}, {name: "cameroon"}, 
  {name: "gabon"}, {name: "congo"}, {name: "angola"}, {name: "namibia"},
  {name: "south africa"}, {name: "mozambique"}, {name: "madagascar"},
  {name: "mauritius"}, {name: "reunion"}, {name: "tanzania"},
  {name: "kenya"}, {name: "somalia"}, {name: "djibouti"}, {name: "eritrea"},
  {name: "sudan"}, {name: "good hope"}, {name: "seychelles"}
])

t_south_america = Tag.create!([
  {name: "brazil"}, {name: "patagonia"}, {name: "galapagos"}, {name: "easter island"},
  {name: "venezuela"}, {name: "guyana"}, {name: "colombia"}, {name: "ecuador"},
  {name: "peru"}, {name: "chile"}, {name: "argentina"}, {name: "cape horn"},
  {name: "uruguay"}, {name: "falkland"}, {name: "surinam"}, {name: "guiana"}
])

t_caribbean = Tag.create!([
  {name: "cuba"}, {name: "bahama"}, {name: "cayman"}, {name: "turks and caicos"},
  {name: "jamaica"}, {name: "exumas"}, {name: "abaco"}, {name: "eleuthera"},
  {name: "nassau"}, {name: "haita"}, {name: "dominican"}, {name: "puerto rico"},
  {name: "vieques"}, {name: "culebra"}, {name: "bvi"}, {name: "usvi"},
  {name: "virgin islands"}, {name: "anguilla"}, {name: "kitts"}, {name: "nevis"},
  {name: "antigua"}, {name: "barbuda"}, {name: "montserrat"}, {name: "st john"},
  {name: "guadeloupe"}, {name: "dominica"}, {name: "martinique"}, {name: "st lucia"},
  {name: "st vincent"}, {name: "grenadines"}, {name: "barbados"}, {name: "tobago"},
  {name: "trinidad"}, {name: "grenada"}, {name: "curacao"}, {name: "aruba"},
  {name: "tortuga"}, {name: "bonaire"}
])

t_asia = Tag.create!([
  {name: "china"}, {name: "hong kong"}, {name: "korea"}, {name: "japan"},
  {name: "taiwan"}, {name: "beijing"}
])

t_southeast_asia = Tag.create!([
  {name: "india"}, {name: "sri lanka"}, {name: "bangladesh"}, {name: "bengal"},
  {name: "nicobar"}, {name: "burma"}, {name: "myanmar"}, {name: "thailand"},
  {name: "malaysia"}, {name: "singapore"}, {name: "cambodia"}, {name: "vietnam"},
  {name: "philippines"}, {name: "bali"}, {name: "malacca"}
])

t_north_america = Tag.create!([
  {name: "united states"}, {name: "usa "}, {name: "bermuda"}, 
  {name: "alaska"}, {name: "icw"}, {name: "new england"},
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
  {name: "illinois"}, {name: "minnesota"}, {name: "ontario"}, {name: "quebec"}
])

t_central_america = Tag.create!([
  {name: "panama"}, {name: "costa rica"}, {name: "nicaragua"}, {name: "honduras"},
  {name: "salvador"}, {name: "guatemala"}, {name: "belize"}
])
  
t_americas_cup = Tag.create!([
  {name: "americas cup"}, {name: "outteridge"}, {name: "artemis"}, {name: "ashby"}, 
  {name: "emirates"}, {name: "cammas"}, {name: "groupama"}, {name: "ainsle"}, 
  {name: "land rover"}, {name: "spithill"}, {name: "oracle"}, {name: "barker"}, 
  {name: "softbank"}
])
  
t_vendee_globe = Tag.create!([
  {name: "vendee"}, {name: "jean-francois pellet"}, {name: "jean pellet"},
  {name: "didac costa"}, {name: "romain attanasio"}, {name: "pieter heerema"},
  {name: "stephan le diraison"}, {name: "alan roura"}, {name: "richard tolkein"},
  {name: "arnaud boissieres"}, {name: "alex thompson"}, {name: "rich wilson"},
  {name: "nandor fa"}, {name: "louis burton"}, {name: "bertrand de broc"},
  {name: "jean le cam"}, {name: "kito de pavant"}, {name: "nicolas boidevezi"},
  {name: "thomas ruyant"}, {name: "yann elies"}, {name: "sebastien josse"},
  {name: "fabrice amedeo"}, {name: "jean-pierre dick"}, {name: "jean pierre dick"},
  {name: "eric bellion"}, {name: "sebastien destremau"}, {name: "paul meilhat"},
  {name: "armel le cleach"}, {name: "morgan lagraviere"}, {name: "vincent riou"}, 
  {name: "tanguy de lamotte"}, {name: "jeremie beyou"}
])
  
t_volvo = Tag.create!([
  {name: "volvo"}
])

t_clipper_race = Tag.create!([
  {name: "clipper"}, {name: "matt mitchell"}, {name: "telemed"}, {name: "wendy tuck"},
  {name: "da nang"}, {name: "daniel smith"}, {name: "londonderry"}, 
  {name: "ashley skett"}, {name: "peter thornton"}, 
  {name: "darren ladd"}, {name: "ichorcoal"}, {name: "olivier cardin"}, {name: "lmax"},
  {name: "greg miller"}, {name: "mission performance"}, {name: "max stunell"},
  {name: "psp"}, {name: "bob beggs"}, {name: "qingdao"}, {name: "paul atwood"},
  {name: "unicef"}, {name: "huw fernie"}, {name: "visit seattle"}
])
  
t_olympics = Tag.create!([
  {name: "olympic"}, {name: "ioc"}, {name: "470"}, {name: "49er"}, {name: "finn"},
  {name: "laser radial"}, {name: "laser"}, {name: "rs:x"}, {name: "elliott 6m"},
  {name: "gold medal"}, {name: "silver medal"}, {name: "bronze medal"}
])
  
t_gear = Tag.create!([
  {name: "gear"}, {name: "radar"}, {name: "plotter"}, {name: "anchor"}, {name: "tech"},
  {name: "technology"}, {name: "review"}, {name: "flashlight"}, {name: "sunglasses"},
  {name: "foulies"}, {name: "jacket"}, {name: "watch"}, {name: "gps "}
])
  
t_racing = Tag.create!([
  {name: "beer can"}, {name: "class"}, {name: "mount gay"}, {name: "rolex"},
  {name: "hugo boss"}, {name: "cup"}, {name: "match"}, {name: "foiler"},
  {name: "hall of fame"}, {name: "issa"}, {name: "m32"}, {name: "melges"}, 
  {name: "moth"}, {name: "open 60"}, {name: "racing"}, {name: "regatta"}, 
  {name: "challenge"}, {name: "record"}, {name: "rorc"}, {name: "sydney hobart"}, 
  {name: "team"}, {name: "farr"}, {name: "j/22"}, {name: "j/24"}, 
  {name: "j/70"}, {name: "j/80"}, {name: "j/88"}, {name: "j/95"}, {name: "j/112"}, 
  {name: "j/97E"}, {name: "j/97"}, {name: "j/100"}, {name: "j/105"}, {name: "j/111"}, 
  {name: "j/112E"}, {name: "j/122"}, {name: "j/122E"}, 
  {name: "nacra"}, {name: "29er"}, {name: "420"}, 
  {name: "505"}, {name: "b14"}, {name: "byte"}, {name: "cadet"}, {name: "contender"},
  {name: "fireball"}, {name: "flying dutchman"}, {name: "flying junior"}, 
  {name: "gp14"}, {name: "international 14"}, {name: "isaf"}, {name: "sunfish"},
  {name: "vuitton"}, {name: "fastnet"}, {name: "cowes week"}, {name: "paccup"},
  {name: "arc"}, {name: "baja ha ha"}, {name: "caribbean 1500"}, {name: "transat"}
])
  
t_women_racing = Tag.create!([{name: "sca "}, {name: "magenta"}, {name: "sam davies"}])
  
t_safety = Tag.create!([
  {name: "fire"}, {name: "border patrol"}, {name: "mrsa"}, {name: "coast guard"},
  {name: "zika"}, {name: "rescue"}, {name: "grounding"}, {name: "sos"}, {name: "pfd"},
  {name: "liferaft"}, {name: "life raft"}, {name: "flare"}, {name: "piracy"},
  {name: "pirate"}, {name: "crime"}, {name: "lifevest"},{name: "life vest"},
  {name: "cpr"}, {name: "first aid"}, {name: "right of way"}, {name: "traffic lanes"},
  {name: "heavy weather"}, {name: "mob "}, {name: "overboard"}, {name: "swept over"},
  {name: "thief"}, {name: "theft"}, {name: "hurricane"}, {name: "insurance"}
])
  
t_maintenance = Tag.create!([
  {name: "repair"}, {name: "fix"}, {name: "rebuild"}, 
  {name: "replace"}, {name: "paint"}, {name: "clean"}, {name: "reseal"}, 
  {name: "juryrig"}, {name: "varnish"}
])

t_travel = Tag.create!([
  {name: "travel"}, {name: "lifestyle"}, {name: "bareboat"},  {name: "charter"},
  {name: "marina"}, {name: "restaurant"}, {name: "bar "}, {name: "anchorage"},
  {name: "provision"}
])
  
t_conservation = Tag.create!([
  {name: "whale"}, {name: "whaling"}, {name: "global warming"}, {name: "humpback"},
  {name: "climate change"}, {name: "reef"}, {name: "endangered"}, {name: "turtle"},
  {name: "plastics"}, {name: "garbage"}, {name: "salinity"}
])
  
t_multihull = Tag.create!([{name: "multihull"}, {name: "catamaran"}, {name: "trimaran"}])
t_families = Tag.create!([{name: "family"}, {name: "families"}, {name: "kids"}])
t_solo = Tag.create!([{name: "solo"}, {name: "singlehand"}, {name: "single hand"}])
t_video = Tag.create!([{name: "video"}, {name: "vlog"}, {name: "web series"}])
t_audio = Tag.create!([{name: "podcast"}, {name: "audio"}])

# Category Types
puts "Adding Category Types"
ct_regional = CategoryType.create!({name: "Regional"})
ct_races = CategoryType.create!({name: "Races"})
ct_interests = CategoryType.create!({name: "Interests"})

# Categories
puts "Adding Categories"
categories = Category.create!([
  {name: "Europe", active: true, tier: 1, category_type: ct_regional, tags: t_europe},
  {name: "Oceania", active: true, tier: 1, category_type: ct_regional, tags: t_oceania},
  {name: "Mediterranean", active: true, tier: 1, category_type: ct_regional, tags: t_mediterranean}, 
  {name: "Middle East", active: true, tier: 1, category_type: ct_regional, tags: t_middle_east}, 
  {name: "Africa", active: true, tier: 1, category_type: ct_regional, tags: t_africa}, 
  {name: "South America", active: true, tier: 1, category_type: ct_regional, tags: t_south_america}, 
  {name: "Caribbean", active: true, tier: 1, category_type: ct_regional, tags: t_caribbean}, 
  {name: "Asia", active: true, tier: 1, category_type: ct_regional, tags: t_asia}, 
  {name: "Southeast Asia", active: true, tier: 1, category_type: ct_regional, tags: t_southeast_asia}, 
  {name: "North America", active: true, tier: 1, category_type: ct_regional, tags: t_north_america}, 
  {name: "Central America", active: true, tier: 1, category_type: ct_regional, tags: t_central_america},

  {name: "Video", active: true, tier: 1, category_type: ct_interests, tags: t_video},
  {name: "Families", active: true, tier: 2, category_type: ct_interests, tags: t_families},
  {name: "Solo", active: true, tier: 2, category_type: ct_interests, tags: t_solo},
  {name: "Podcast", active: true, tier: 1, category_type: ct_interests, tags: t_audio},  
  {name: "Conservation", active: true, tier: 1, category_type: ct_interests, tags: t_conservation},
  {name: "Gear", active: true, tier: 1, category_type: ct_interests, tags: t_gear}, 
  {name: "Multihull", active: true, tier: 1, category_type: ct_interests, tags: t_multihull}, 
  {name: "Safety", active: true, tier: 1, category_type: ct_interests, tags: t_safety},  
  {name: "Travel", active: true, tier: 1, category_type: ct_interests, tags: t_travel}, 
  {name: "Maintenance", active: true, tier: 1, category_type: ct_interests, tags: t_maintenance}, 
  
  {name: "Americas Cup", active: true, tier: 2, category_type: ct_races, tags: t_americas_cup},
  {name: "Vendee", active: true, tier: 2, category_type: ct_races, tags: t_vendee_globe}, 
  {name: "Volvo Ocean Race", active: true, tier: 2, category_type: ct_races, tags: t_volvo}, 
  {name: "Clipper", active: true, tier: 2, category_type: ct_races, tags: t_clipper_race}, 
  {name: "Olympics", active: true, tier: 2, category_type: ct_races, tags: t_olympics}, 
  {name: "Women In Racing", active: true, tier: 2, category_type: ct_races, tags: t_women_racing}
])

c_magazines = Category.create!({name: "Magazines", active: true, tier: 1, category_type: ct_interests, tags: []})
c_racing = Category.create!({name: "Race", active: true, tier: 1, category_type: ct_races, tags: t_racing})
c_monohull = Category.create!({name: "Monohull", active: true, tier: 1, category_type: ct_interests, tags: []})
c_multihull = Category.where(slug: "multihull").first
c_couples = Category.create!({name: "Couples", active: true, tier: 1, category_type: ct_interests, tags: []})
c_families = Category.where(slug: "families").first
c_solo = Category.where(slug: "solo").first
c_audio = Category.where(slug: "podcast").first
c_video = Category.where(slug: "video").first
c_gear = Category.where(slug: "gear").first
c_travel = Category.where(slug: "travel").first
c_maintenance = Category.where(slug: "maintenance").first

# Languages
puts "Adding Languages"
l_en = Language.create!({name: "English", abbreviation: "en"})

# Feed Types
puts "Adding Feed Types"
ft_rss = FeedType.create!({name: "rss"})
ft_youtube = FeedType.create!({name: "youtube"})
ft_generic = FeedType.create!({name: "generic-news"})

# Publishers
puts "Adding Publishers and Feeds"

dflt_pub = {description: "", logo: nil, language: l_en, active: true}
dflt_feed = {feed_type: ft_rss,
             max_article_age_in_days: 60, scan_frequency_in_hours: 4, active: true,
             last_scan_on: "2016-10-09 13:00:03", next_scan_on: "2016-10-09 17:00:12"}

active_publishers = Publisher.create!([
  dflt_pub.merge({name: "Zero To Cruising", homepage: "http://www.zerotocruising.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.zerotocruising.com/feed/", 
            article_css_selector: ".post", last_article_from: "2016-10-09 13:00:03",
            categories: [c_monohull, c_couples]}))]
  }),
  dflt_pub.merge({name: "The Retirement Project", homepage: "http://theretirementproject.blogspot.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://theretirementproject.blogspot.com/feeds/posts/default", 
            article_css_selector: nil, last_article_from: "2016-10-07 13:00:03",
            categories: [c_monohull, c_couples]}))]
  }),
  dflt_pub.merge({name: "Pacific Sailors", homepage: "http://pacificsailors.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://pacificsailors.com/feed/", 
            article_css_selector: ".blog-content-wrapper", last_article_from: "2016-10-06 13:00:03",
            categories: [c_monohull, c_couples]}))]
  }),
  dflt_pub.merge({name: "Mount Ocean", homepage: "http://www.mountocean.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.mountocean.com/feed/", 
            article_css_selector: "#content", last_article_from: "2016-10-09 13:00:03",
            categories: [c_monohull, c_couples]}))]
  }),
  dflt_pub.merge({name: "Classic Boat", homepage: "http://www.classicboat.co.uk/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.classicboat.co.uk/feed/", 
            article_css_selector: "#content", last_article_from: "2016-10-09 13:00:03",
            categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1}))]
  }),
  dflt_pub.merge({name: "Royal Ocean Racing Club", homepage: "http://www.rorc.org/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.rorc.org/feed/rss.html", 
            article_css_selector: "#ja-content", last_article_from: "2016-10-03 13:00:03",
            categories: [c_racing]}))]
  }),
  dflt_pub.merge({name: "Sail Loot Podcast", homepage: "http://www.sailloot.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.sailloot.com/feed/", 
            article_css_selector: "#main", last_article_from: "2016-09-08 13:00:03",
            categories: [c_audio]}))]
  }),
  dflt_pub.merge({name: "The Newport To Bermuda Race", homepage: "http://bermudarace.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://bermudarace.com/feed/", 
            article_css_selector: "#main", last_article_from: "2016-07-27 13:00:03",
            categories: [c_racing, Category.where(slug: "north-america").first]}))]
  }),
  dflt_pub.merge({name: "My Sailing Boat", homepage: "http://mysailingboat.com.au/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://mysailingboat.com.au/?feed=rss2", 
            article_css_selector: nil, last_article_from: "2016-10-09 13:00:03",
            categories: [c_monohull, c_families]}))]
  }),
  dflt_pub.merge({name: "Mid-Life Cruising", homepage: "http://www.mid-lifecruising.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://feeds.feedburner.com/Mid-lifeCruising", 
            article_css_selector: "feedContent", last_article_from: "2016-10-09 13:00:03",
            categories: [c_monohull, c_couples]}))]
  }),
  dflt_pub.merge({name: "Windtraveler", homepage: "http://www.windtraveler.net/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://feeds.feedburner.com/Windtraveler", 
            article_css_selector: "#Blog1", last_article_from: "2016-09-16 13:00:03",
            categories: [c_monohull, c_families]}))]
  }),
  dflt_pub.merge({name: "Women and Cruising", homepage: "http://www.womenandcruising.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.womenandcruising.com/blog/feed/", 
            article_css_selector: ".post", last_article_from: "2016-08-22 13:00:03",
            categories: [c_magazines]}))]
  }),
  dflt_pub.merge({name: "Sailing Simplicity", homepage: "http://sailingsimplicity.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://sailingsimplicity.com/feed/", 
            article_css_selector: "#main", last_article_from: "2016-09-28 13:00:03",
            categories: [c_monohull, c_couples]}))]
  }),
  dflt_pub.merge({name: "Sailing Chance", homepage: "http://www.sailingchance.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.sailingchance.com/feed", 
            article_css_selector: "article", last_article_from: "2016-09-07 13:00:03",
            categories: [c_monohull, c_couples]}))]
  }),
  dflt_pub.merge({name: "Alex Thomson Racing", homepage: "http://www.alexthomsonracing.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.alexthomsonracing.com/feed/", 
            article_css_selector: "article", last_article_from: "2016-06-21 13:00:03",
            categories: [c_racing]}))]
  }),
  dflt_pub.merge({name: "Marine Conservation", homepage: "https://marine-conservation.org/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://blog.marine-conservation.org/feed/", 
            article_css_selector: "article", last_article_from: "2016-10-06 13:00:03",
            categories: [c_magazines, Category.where(slug: "conservation").first]}))]
  }),
  dflt_pub.merge({name: "Global Yacht Racer", homepage: "http://www.globalyachtracing.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.globalyachtracing.com/feed/", 
            article_css_selector: "#content", last_article_from: "2016-09-26 13:00:03",
            categories: [c_racing, c_magazines]}))]
  }),
  dflt_pub.merge({name: "59° North Sailing Podcast", homepage: "http://59-north.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://59north.libsyn.com/rss", 
            article_css_selector: ".postBody", last_article_from: "2016-10-04 13:00:03",
            categories: [c_audio]}))]
  }),
  dflt_pub.merge({name: "Sailing Detour", homepage: "http://blog.sailingdetour.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://blog.sailingdetour.com/?feed=rss2", 
            article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
            categories: [c_monohull, c_families]}))]
  }),
  dflt_pub.merge({name: "Sailing La Vagabonde", homepage: "http://sailing-lavagabonde.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://sailing-lavagabonde.com/feed/", 
            article_css_selector: ".entry-content", last_article_from: "2016-10-04 13:00:03",
            categories: [c_monohull, c_couples, c_video]}))]
  }),
  dflt_pub.merge({name: "Sound Discovery", homepage: "http://sound-discovery.blogspot.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://sound-discovery.blogspot.com/feeds/posts/default", 
            article_css_selector: "#Blog1", last_article_from: "2016-03-26 13:00:03",
            categories: [c_monohull, c_couples]}))]
  }),
  dflt_pub.merge({name: "Yacht Emoceans", homepage: "http://www.yachtemoceans.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.yachtemoceans.com/superyacht-news/sailing-yacht-news/feed/", 
            article_css_selector: "article", last_article_from: "2016-09-20 13:00:03",
            categories: [c_magazines]}))]
  }),
  dflt_pub.merge({name: "Sailing Britican", homepage: "http://www.sailingbritican.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.sailingbritican.com/feed/", 
                article_css_selector: "article", last_article_from: "2016-10-07 13:00:03",
                categories: [c_monohull, c_families]})),
            Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCAob5GmjrCYCHNk3S8O9yXQ", 
                article_css_selector: nil, last_article_from: "2016-10-08 13:00:03",
                categories: [c_monohull, c_families, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "Foiling Week", homepage: "http://www.foilingweek.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.foilingweek.com/feed/", 
            article_css_selector: "article", last_article_from: "2016-08-20 13:00:03",
            categories: [c_magazines, c_racing, c_multihull]}))]
  }),
  dflt_pub.merge({name: "Lazy Geckos", homepage: "http://lazygeckos.net/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://lazygeckos.net/feed/", 
                  article_css_selector: nil, last_article_from: "2016-10-04 13:00:03",
                  categories: [c_monohull, c_families]})),
            Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCwIThXjmw8eBlEfFZLgZ3-g", 
                  article_css_selector: nil, last_article_from: "2016-10-01 13:00:03",
                  categories: [c_monohull, c_families, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "S/V Terrapin", homepage: "http://www.sv-terrapin.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.sv-terrapin.com/feeds/posts/default?alt=rss", 
            article_css_selector: "#Blog1", last_article_from: "2016-08-29 13:00:03",
            categories: [c_monohull, c_families]}))]
  }),
  dflt_pub.merge({name: "Tubber", homepage: "https://www.tubbber.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.tubbber.com/blog/feed/", 
            article_css_selector: "article", last_article_from: "2016-09-23 13:00:03",
            categories: [c_magazines]}))]
  }),
  dflt_pub.merge({name: "Sailing Baby Blue", homepage: "http://feedingthecruisingkitty.blogspot.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://feedingthecruisingkitty.blogspot.com/feeds/posts/default", 
            article_css_selector: "#Blog1", last_article_from: "2016-08-24 13:00:03",
            categories: [c_monohull, c_couples]}))]
  }),
  dflt_pub.merge({name: "S/V Elizabeth Jean", homepage: "https://svelizabethjean.wordpress.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://svelizabethjean.wordpress.com/feed/", 
            article_css_selector: "#main-content", last_article_from: "2016-09-30 13:00:03",
            categories: [c_monohull, c_couples]}))]
  }),
  dflt_pub.merge({name: "The Sailing Rode Podcast", homepage: "http://thesailingrode.libsyn.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://thesailingrode.libsyn.com/rss/", 
            article_css_selector: ".libsyn-item", last_article_from: "2016-09-23 13:00:03",
            categories: [c_audio]}))]
  }),
  dflt_pub.merge({name: "Bella Mente Racing", homepage: "http://bellamenteracing.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://bellamenteracing.com/feed/", 
            article_css_selector: "article", last_article_from: "2016-09-19 13:00:03",
            categories: [c_racing]}))]
  }),
  dflt_pub.merge({name: "Sailing Podcast", homepage: "http://thesailingpodcast.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://feeds.feedburner.com/thesailingpodcast/feed?format=xml", 
            article_css_selector: ".l-content", last_article_from: "2016-04-12 13:00:03",
            categories: [c_audio]}))]
  }),
  dflt_pub.merge({name: "Sailing Unspoken", homepage: "http://sailingunspoken.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://sailingunspoken.com/feed/", 
            article_css_selector: "#primary", last_article_from: "2016-05-10 13:00:03",
            categories: [c_multihull, c_couples]}))]
  }),
  dflt_pub.merge({name: "Family Circus", homepage: "http://tzortzisfamily.blogspot.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://tzortzisfamily.blogspot.com/feeds/posts/default?alt=rss", 
            article_css_selector: "#Blog1", last_article_from: "2016-08-10 13:00:03",
            categories: [c_monohull, c_families]}))]
  }),
  dflt_pub.merge({name: "Team Phaedo", homepage: "http://blog.teamphaedo.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://blog.teamphaedo.com/feed/", 
            article_css_selector: "article", last_article_from: "2016-05-04 13:00:03",
            categories: [c_racing]}))]
  }),
  dflt_pub.merge({name: "Team Concise", homepage: "http://www.teamconcise.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.teamconcise.com/feed/", 
            article_css_selector: "article", last_article_from: "2016-07-28 13:00:03",
            categories: [c_racing]}))]
  }),
  dflt_pub.merge({name: "The Clipper Race", homepage: "https://www.clipperroundtheworld.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.clipperroundtheworld.com/news/rss", 
            article_css_selector: ".article", last_article_from: "2016-10-07 13:00:03",
            categories: [c_racing, Category.where(slug: "clipper").first]}))]
  }),
  dflt_pub.merge({name: "S/V Fluenta", homepage: "http://sv-fluenta.blogspot.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://sv-fluenta.blogspot.com/feeds/posts/default?alt=rss", 
            article_css_selector: "#Blog1", last_article_from: "2016-10-04 13:00:03",
            categories: [c_monohull, c_families]}))]
  }),
  dflt_pub.merge({name: "Three Sheets Northwest", homepage: "http://threesheetsnw.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://threesheetsnw.com/feed/", 
            article_css_selector: "article", last_article_from: "2016-10-09 13:00:03",
            categories: [c_magazines, Category.where(slug: "north-america").first]}))]
  }),
  dflt_pub.merge({name: "Let It Breeze", homepage: "http://letitbreeze.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://letitbreeze.com/feed/", 
            article_css_selector: "article", last_article_from: "2016-10-04 13:00:03",
            categories: [c_monohull, c_couples]}))]
  }),
  dflt_pub.merge({name: "Soundings Online", homepage: "http://www.soundingsonline.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.soundingsonline.com/columns-blogs?format=feed&type=rss", 
            article_css_selector: "#page", last_article_from: "2016-10-08 13:00:03",
            categories: [c_magazines]}))]
  }),
  dflt_pub.merge({name: "Coconuts", homepage: "http://coconuts.is/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://coconuts.is/happy-to-share-their-blog?format=RSS", 
            article_css_selector: "article", last_article_from: "2016-09-21 13:00:03",
            categories: [c_monohull, c_families]}))]
  }),
  dflt_pub.merge({name: "Multihulls Quarterly", homepage: "http://www.bwsailing.com/mq/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.bwsailing.com/mq/feed/", 
            article_css_selector: ".content", last_article_from: "2016-10-07 13:00:03",
            categories: [c_magazines, c_multihull]}))]
  }),
  dflt_pub.merge({name: "S/V Perry", homepage: "http://www.svperry.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.svperry.com/feeds/posts/default", 
            article_css_selector: "#Blog1", last_article_from: "2016-10-02 13:00:03",
            categories: [c_monohull, c_families]}))]
  }),
  dflt_pub.merge({name: "Yachting Australia", homepage: "http://www.yachting.org.au/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.yachting.org.au/feed/", 
            article_css_selector: "#content", last_article_from: "2016-06-03 13:00:03",
            categories: [c_magazines, Category.where(slug: "oceania").first]}))]
  }),
  dflt_pub.merge({name: "Skelton Crew", homepage: "http://www.skeltoncrew.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.skeltoncrew.com/feeds/posts/default?alt=rss", 
            article_css_selector: "#Blog1", last_article_from: "2016-03-31 13:00:03",
            categories: [c_monohull, c_couples]}))]
  }),
  dflt_pub.merge({name: "Yachting Magazine", homepage: "http://www.yachtingmagazine.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.yachtingmagazine.com/rss.xml?cmpid=rssheader", 
            article_css_selector: ".panel-pane", last_article_from: "2016-09-12 13:00:03",
            categories: [c_magazines]}))]
  }),
  dflt_pub.merge({name: "Ocean Navigator", homepage: "http://www.oceannavigator.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.oceannavigator.com/feeds/Ocean+Voyaging+Blog/blog", 
            article_css_selector: "#article-body", last_article_from: "2016-10-07 13:00:03",
            categories: [c_magazines]}))]
  }),
  dflt_pub.merge({name: "Cruising Compass", homepage: "http://www.bwsailing.com/cc/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.bwsailing.com/cc/feed/", 
            article_css_selector: ".content", last_article_from: "2016-10-06 13:00:03",
            categories: [c_magazines]}))]
  }),
  dflt_pub.merge({name: "Sunkissed Soeters", homepage: "http://www.sunkissedsoeters.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.sunkissedsoeters.com/feed/", 
            article_css_selector: "article", last_article_from: "2016-05-07 13:00:03",
            categories: [c_monohull, c_families]}))]
  }),
  dflt_pub.merge({name: "Sailing World", homepage: "http://www.sailingworld.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.sailingworld.com/rss.xml", 
                    article_css_selector: ".content", last_article_from: "2016-09-30 13:00:03",
                    categories: [c_magazines]})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingworld.com/taxonomy/term/2000049/rss.xml", 
                        article_css_selector: ".content", last_article_from: "2016-09-30 13:00:03",
                        categories: [c_magazines]}))]
  }),
  dflt_pub.merge({name: "Australian Sailing Team", homepage: "http://www.australiansailing.org/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.australiansailing.org/feed/", 
            article_css_selector: "#content", last_article_from: "2016-09-23 13:00:03",
            categories: [c_racing, Category.where(slug: "oceania").first]}))]
  }),
  dflt_pub.merge({name: "Sails Magazine", homepage: "http://www.sailsmagazine.com.au/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.sailsmagazine.com.au/j/index.php/livenews?format=feed&type=rss", 
            article_css_selector: "#main", last_article_from: "2016-05-05 13:00:03",
            categories: [c_magazines, Category.where(slug: "oceania").first]}))]
  }),
  dflt_pub.merge({name: "Yachting New Zealand", homepage: "http://www.yachtingnz.org.nz/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.yachtingnz.org.nz/news.xml", 
            article_css_selector: ".content", last_article_from: "2016-10-05 13:00:03",
            categories: [c_magazines, Category.where(slug: "oceania").first]}))]
  }),
  dflt_pub.merge({name: "A Family Afloat", homepage: "http://afamilyafloat.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://afamilyafloat.com/feed/?alt=rss", 
            article_css_selector: "#content", last_article_from: "2016-09-19 13:00:03",
            categories: [c_monohull, c_families]}))]
  }),
  dflt_pub.merge({name: "Barnacle Bill Holcomb", homepage: "http://barnaclebillholcomb.blogspot.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://barnaclebillholcomb.blogspot.com/feeds/posts/default?alt=rss", 
            article_css_selector: ".post", last_article_from: "2016-09-29 13:00:03",
            categories: [c_maintenance]}))]
  }),
  dflt_pub.merge({name: "Where the Coconuts Grow", homepage: "http://www.wherethecoconutsgrow.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.wherethecoconutsgrow.com/feed/", 
            article_css_selector: nil, last_article_from: "2016-07-24 13:00:03",
            categories: [c_monohull, c_couples]}))]
  }),
  dflt_pub.merge({name: "Blue Water Sailing", homepage: "http://www.bwsailing.com/bw/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.bwsailing.com/bw/feed/", 
            article_css_selector: ".post", last_article_from: "2016-10-06 13:00:03",
            categories: [c_magazines]}))]
  }),
  dflt_pub.merge({name: "Western Lens", homepage: "http://www.westernlens.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.westernlens.com/feed/", 
            article_css_selector: "#primary", last_article_from: "2016-07-31 13:00:03",
            categories: [c_monohull, c_couples]}))]
  }),
  dflt_pub.merge({name: "S/V Milou", homepage: "http://sailingmilou.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://sailingmilou.com/?feed=rss2", 
            article_css_selector: ".article", last_article_from: "2016-10-07 13:00:03",
            categories: [c_monohull, c_families]}))]
  }),
  dflt_pub.merge({name: "The Magenta Project", homepage: "http://themagentaproject.org/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://themagentaproject.org/feed/", 
            article_css_selector: ".post-title", last_article_from: "2016-05-19 13:00:03",
            categories: [c_racing, Category.where(slug: "women-in-racing").first]}))]
  }),

  dflt_pub.merge({name: "S/V Southern Lady", homepage: "https://www.youtube.com/channel/UCqQ8OWuC_jOt65PuJb9oAsw",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCqQ8OWuC_jOt65PuJb9oAsw", 
            article_css_selector: nil, last_article_from: "2016-10-09 13:00:03",
            categories: [c_monohull, c_couples, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "Trio Travels", homepage: "http://www.triotravels.ca/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCdAPAmdnkdFsH5R2Hxevucg", 
            article_css_selector: nil, last_article_from: "2016-10-08 13:00:03",
            categories: [c_multihull, c_families, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "S/V Corsair", homepage: "https://www.youtube.com/channel/UC8dsJQ_9CEwRmur_HFSXezA",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UC8dsJQ_9CEwRmur_HFSXezA", 
            article_css_selector: nil, last_article_from: "2016-09-20 13:00:03",
            categories: [c_monohull, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "Sailing Life", homepage: "https://www.youtube.com/user/madsdahlke",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UC5xDht2blPNWdVtl9PkDmgA", 
            article_css_selector: nil, last_article_from: "2016-10-02 13:00:03",
            categories: [c_monohull, c_solo, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "Sailing Uma", homepage: "https://www.youtube.com/channel/UCXbWsGV_cjG3gOsSnNJPVlg",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCXbWsGV_cjG3gOsSnNJPVlg", 
            article_css_selector: nil, last_article_from: "2016-10-09 13:00:03",
            categories: [c_monohull, c_couples, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "Sailing Shack", homepage: "http://sailingshack.com.au/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCLZ7U9JVUcUE4nTl1MtNqLg", 
            article_css_selector: nil, last_article_from: "2016-05-06 13:00:03",
            categories: [c_magazines, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "Boatworks Today", homepage: "http://boatworkstoday.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UC0kDqq-pSzdqFUk3oTaHBuA", 
            article_css_selector: nil, last_article_from: "2016-09-22 13:00:03",
            categories: [c_maintenance, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "Cruising Lealea", homepage: "http://cruisinglealea.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UC3Tzm1C2N2FHS0dg80oX6dQ", 
            article_css_selector: nil, last_article_from: "2016-10-03 13:00:03",
            categories: [c_monohull, c_families, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "S/V Prism", homepage: "https://www.youtube.com/channel/UCr9pCaMpbVNa6OHC4We2nTA",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCr9pCaMpbVNa6OHC4We2nTA", 
            article_css_selector: nil, last_article_from: "2016-10-06 13:00:03",
            categories: [c_monohull, c_couples, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "Resolute Sets Sail", homepage: "https://www.youtube.com/channel/UCV2qERQTaNHbI9lzMjAhslg",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCV2qERQTaNHbI9lzMjAhslg", 
            article_css_selector: nil, last_article_from: "2016-08-01 13:00:03",
            categories: [c_monohull, c_couples, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "S/V Delos", homepage: "http://svdelos.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCvLc83k5o11EIF1lEo0VmuQ", 
            article_css_selector: nil, last_article_from: "2016-10-07 13:00:03",
            categories: [c_monohull, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "World Sailing TV", homepage: "http://www.sailing.org/tv/#.VusEghhbKRs",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCihBCFVwHKZT_jHc3Y3j8YA", 
            article_css_selector: nil, last_article_from: "2016-09-18 13:00:03",
            categories: [c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "Monday Never", homepage: "http://www.mondaynever.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCk7fx_UC6Zjv08gc6OdCXuw", 
            article_css_selector: nil, last_article_from: "2016-10-02 13:00:03",
            categories: [c_video, c_couples, c_monohull], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "S/V Pearl", homepage: "https://www.youtube.com/channel/UCh-CzKElyiRTWncxS7mfgcA",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCh-CzKElyiRTWncxS7mfgcA", 
            article_css_selector: nil, last_article_from: "2016-07-09 13:00:03",
            categories: [c_monohull, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "Geoff Waller", homepage: "https://www.youtube.com/user/mobydk2",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCNogfmyQAGS3HLmCAez1mpQ", 
            article_css_selector: nil, last_article_from: "2016-10-07 13:00:03",
            categories: [c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "America's Cup", homepage: "https://www.americascup.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCS6qLhh5YBeL42HRMh3dc1A", 
            article_css_selector: nil, last_article_from: "2016-08-20 13:00:03",
            categories: [c_racing, c_video, Category.where(slug: "americas-cup").first], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "Volvo Ocean Race", homepage: "http://www.volvooceanrace.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCd-kj8ShMRRDKrONtkjVRgg", 
            article_css_selector: nil, last_article_from: "2016-10-05 13:00:03",
            categories: [c_racing, c_video, Category.where(slug: "volvo-ocean-race").first], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "Vendee Globe", homepage: "http://www.vendeeglobe.org/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UC0pdv_hgDx7oTT3kJAMnd5A", 
                    article_css_selector: nil, last_article_from: "2016-10-07 13:00:03",
                    categories: [c_racing, c_video, Category.where(slug: "vendee").first], feed_type: ft_youtube})),
            Feed.new(dflt_feed.merge({source: "http://page2rss.com/526e4a1074584439186ff5ea5833be25/7998546_8017005/survey", 
                    article_css_selector: "article", last_article_from: "2016-03-10 13:00:03",
                    active: false, categories: [c_racing, Category.where(slug: "vendee").first]}))]
  }),
  dflt_pub.merge({name: "Yachting World", homepage: "http://yachtingworld.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCwGLc9zirMhigiLCeIwWuqQ", 
            article_css_selector: nil, last_article_from: "2016-10-06 13:00:03",
            categories: [c_magazines, c_video], feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "Wicked Salty", homepage: "https://www.youtube.com/user/WickedSaltySailors",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCR_Bc26eSZCu9c8kHBR7lGw", 
            article_css_selector: nil, last_article_from: "2016-09-17 13:00:03",
            categories: [c_monohull, c_video], feed_type: ft_youtube}))]
  }),

  dflt_pub.merge({name: "Cruising World", homepage: "http://cruisingworld.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCzZgnCgEbmCSGuKJSnK3r3Q", 
            article_css_selector: nil, last_article_from: "2016-10-09 13:00:03",
            categories: [c_magazines, c_video], max_article_age_in_days: 14, scan_frequency_in_hours: 1,
            feed_type: ft_youtube}))]
  }),
  dflt_pub.merge({name: "Sailing Magazine", homepage: "http://sailmagazine.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "https://www.youtube.com/feeds/videos.xml?channel_id=UCycZuGVSylSSIX9IEtsS5rQ", 
                        article_css_selector: nil, last_article_from: "2016-10-09 13:00:03",
                        categories: [c_magazines, c_video], max_article_age_in_days: 14, scan_frequency_in_hours: 1,
                        feed_type: ft_youtube})),
            Feed.new(dflt_feed.merge({source: "http://sailingmagazine.net/rss-1-2-news.xml", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://sailingmagazine.net/rss-119-2-boat-test.xml", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines, c_gear], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://sailingmagazine.net/rss-117-2-launchings.xml", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://sailingmagazine.net/rss-113-2-perry-on-design.xml", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://sailingmagazine.net/rss-118-2-used-boat-notebook.xml", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://sailingmagazine.net/rss-120-2-technique.xml", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://sailingmagazine.net/rss-126-2-boat-doctor.xml", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines, c_maintenance], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://sailingmagazine.net/rss-116-2-features.xml", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://sailingmagazine.net/rss-130-2-splashes.xml", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://sailingmagazine.net/rss-136-2-columns-blogs.xml", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://sailingmagazine.net/rss-132-2-nautical-library.xml", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailmagazine.com/gear/feed/", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines, c_gear], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailmagazine.com/feed", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailmagazine.com/boats/feed/", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailmagazine.com/diy/feed/", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines, c_maintenance], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailmagazine.com/cruising/feed/", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines, c_travel], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailmagazine.com/racing/feed/", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines, c_racing], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailmagazine.com/charter/feed/", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines, c_travel], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailmagazine.com/multihulls/feed/", 
                        article_css_selector: "article", last_article_from: "2016-10-03 13:00:03",
                        categories: [c_magazines, c_multihull], max_article_age_in_days: 14, scan_frequency_in_hours: 1}))]
  }),
  dflt_pub.merge({name: "Sailing Today", homepage: "http://www.sailingtoday.co.uk/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines]})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/category/cruising/cruising-stories/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines, c_travel], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/category/cruising/cruising-tips/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/category/cruising/gulls-eye/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/category/boats/at-a-glance/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/category/gear/gear-on-test/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines, c_gear], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/category/gear/new-gear/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines, c_gear], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/category/practical/sailing-skills/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/category/practical/improve-the-boat/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines, c_maintenance], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/category/practical/technical-guides/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines, c_maintenance], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/category/editors-blog/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/category/duncans-boat-test-blog/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines, c_gear], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/category/riding-light/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.sailingtoday.co.uk/category/videos/feed/", 
                        article_css_selector: ".post-inner", last_article_from: "2016-09-27 13:00:03",
                        categories: [c_magazines, c_video], max_article_age_in_days: 14, scan_frequency_in_hours: 1}))]
  }),
  dflt_pub.merge({name: "Huffington Post", homepage: "http://www.huffingtonpost.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://feeds.huffingtonpost.com/c/35496/f/677540/index.rss", 
                        article_css_selector: "article", last_article_from: "2016-03-24 13:00:03", feed_type: ft_generic,
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://feeds.huffingtonpost.com/c/35496/f/677550/index.rss", 
                        article_css_selector: "article", last_article_from: "2016-03-24 13:00:03", feed_type: ft_generic,
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://feeds.huffingtonpost.com/c/35496/f/677549/index.rss", 
                        article_css_selector: "article", last_article_from: "2016-03-24 13:00:03", feed_type: ft_generic,
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1}))]
  }),
  dflt_pub.merge({name: "Practical Boat Owner", homepage: "http://www.pbo.co.uk/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.pbo.co.uk/feed/", 
                        article_css_selector: "article", last_article_from: "2016-03-24 13:00:03",
                        categories: [c_magazines], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.pbo.co.uk/gear/feed/", 
                        article_css_selector: "article", last_article_from: "2016-03-24 13:00:03",
                        categories: [c_magazines, c_gear], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.pbo.co.uk/cruising/feed/", 
                        article_css_selector: "article", last_article_from: "2016-03-24 13:00:03",
                        categories: [c_magazines, c_travel], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.pbo.co.uk/expert-advice/feed/", 
                        article_css_selector: "article", last_article_from: "2016-03-24 13:00:03",
                        categories: [c_magazines, c_maintenance], max_article_age_in_days: 14, scan_frequency_in_hours: 1})),
            Feed.new(dflt_feed.merge({source: "http://www.pbo.co.uk/video/feed/", 
                        article_css_selector: "article", last_article_from: "2016-03-24 13:00:03",
                        categories: [c_magazines, c_video], max_article_age_in_days: 14, scan_frequency_in_hours: 1}))]
  })
])

inactive_publishers = Publisher.create!([
  dflt_pub.merge({name: "Spinsheet", homepage: "http://www.spinsheet.com/", 
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.spinsheet.com/feed/", 
            active: false, max_article_age_in_days: 14, scan_frequency_in_hours: 1,
            article_css_selector: ".entry-content", last_article_from: "2016-03-26 13:00:03",
            categories: [c_magazines]})
  )]}),
  dflt_pub.merge({name: "Sailing Anarchy", homepage: "http://sailinganarchy.com/", 
    feeds: [Feed.new(dflt_feed.merge({source: "http://sailinganarchy.com/feed/", 
            active: false,
            article_css_selector: "#content", last_article_from: "2016-03-10 13:00:03",
            categories: [c_magazines, c_racing]})
  )]}),
  dflt_pub.merge({name: "Anasazi Racing", homepage: "http://anasaziracing.blogspot.com/", 
    feeds: [Feed.new(dflt_feed.merge({source: "http://anasaziracing.blogspot.com/feeds/posts/default?alt=rss", 
            active: false, max_article_age_in_days: 14, scan_frequency_in_hours: 1,
            article_css_selector: ".post", last_article_from: "2016-03-10 13:00:03",
            categories: [c_monohull, c_families]})
  )]}),
  dflt_pub.merge({name: "Twice in a Lifetime", homepage: "http://thelifegalactic.blogspot.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://feeds.feedburner.com/blogspot/ymYbO", 
            article_css_selector: "#Blog1", last_article_from: "2016-03-13 13:00:03",
            categories: [c_monohull, c_families], active: false}))]
  }),
  dflt_pub.merge({name: "Mario Vittone", homepage: "http://mariovittone.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://mariovittone.com/blog/feed/", 
            article_css_selector: ".post-content", last_article_from: "2016-03-13 13:00:03",
            categories: [Category.where(slug: "safety").first], active: false}))]
  }),
  dflt_pub.merge({name: "The Med-Sailor Podcast", homepage: "http://www.medsailor.com/",
    feeds: [Feed.new(dflt_feed.merge({source: "http://www.medsailor.com/feed/podcast/", 
            article_css_selector: ".entry-content", last_article_from: "2016-03-24 13:00:03",
            categories: [c_audio], active: false}))]
  }),
])
