//
//  compares.swift
//  beTheImpact
//
//  Created by Reem on 29/06/1446 AH.
//

func checkIfItemsMatch(firstItem: String, secondItem: String) -> String {
    let normalizedFirstItem = firstItem.lowercased()
    let normalizedSecondItem = secondItem.lowercased()    // Define compatible pairs
    let compatiblePairs = [
        ("jeans", "t-shirt"),  // Classic casual
        ("skirt", "blouse"),  // Feminine and balanced
        ("boots", "jeans"),  // Rugged and functional
        ("dress", "jeans"),  // Rugged and functional
        ("sandals", "shorts"),  // Perfect for summer
        ("coat", "trousers"),  // Winter-ready and formal
        ("sneakers", "joggers"),  // Activewear
        ("heels", "dress"),  // Formal and elegant
        ("scarf", "jacket"),  // Layered look
        ("blazer", "slacks"),  // Business formal
        ("cardigan", "midi dress"),
        ("cropped jeans", "tank top"),  // Summery and casual
         ("joggers", "graphic t-shirt"),  // Relaxed and trendy
         ("leather jacket", "black skinny jeans"),  // Edgy and sleek
         ("cardigan", "leggings"),  // Cozy casual
         ("peacoat", "scarf"),  // Classic winter style
        ("jeans", "shirt"),  // Classic casual
         ("a white button-down shirt", "a pair of tan chinos"),  // Clean and
         ("a black turtleneck sweater", "a plaid midi skirt"),  // Cozy and
         ("a pair of white sneakers", "a denim romper"),  // Fun and youthful
         ("a navy wool blazer", "a pair of grey dress pants"),  // Office ready
         ("a pair of suede ankle boots", "a floral wrap dress"),  // Elegant and
         ("black", "gold"),  // Chic and elegant
         ("purple", "silver"),  // Futuristic and stylish
         ("emerald green", "white"),  // Crisp and rich
         ("navy blue", "light grey"),  // Subtle and modern
         ("peach", "cream"),
        ("a floral summer dress", "a pair of white flat shoes"),  // Light and
        ("a pair of skinny blue jeans", "a white cotton shirt with long sleeves"),  // Casual chic
        ("a red cotton T-shirt", "a pair of navy sports leggings"),  //  and
        ("a beige knitted cardigan", "a pair of navy classic shoes"),  // Warm
        ("a black midi pencil skirt", "a white linen blouse"),  // Office-ready
        ("a cream crochet blouse", "a light pink chiffon scarf"),  // Feminine
        ("a camel wrap coat", "a pair of brown leather boots"),  // Winter
        ("a coral maxi dress", "a pair of tan espadrille wedges"),  // Breezy and summery
        ("a pair of dark brown Chelsea boots", "a beige coat with a belt"),  // Polished casual
        ("a navy turtleneck sweater", "a pair of grey wool trousers"),  // Smart winter look

        // Colors
        ("red", "black"),  // Bold and striking
        ("blue", "white"),  // Clean and timeless
        ("green", "gold"),  // Luxurious and complementary
        ("navy", "beige"),  // Neutral and sophisticated
        ("lavender", "white"),  // Soft and delicate
        ("maroon", "grey"),  // Refined and moody
        ("pink", "white"),  // Light and feminine

        // Occasions
        ("a black satin pencil skirt", "a red velvet halter-neck top"),  // Party-ready
        ("a navy blue ribbed knit sweater dress", "a pair of beige ankle boots"),  // Cozy winter
        ("a sky-blue chiffon blouse", "a pair of tan leather loafers"),  // Spring office look
        ("a black sleeveless blouse", "a pair of black formal fabric pants"),  // Sleek professional
        ("a white eyelet lace sundress", "a pair of gold wedge sandals"),
        ("boots", "jeans"),  // Rugged and functional
            ("heels", "dress"),  // Formal and elegant
            ("sneakers", "t-shirt"),  // Casual and comfortable
            ("flip-flops", "swimsuit"),  // Summer-ready
            ("loafers", "blazer"),  // Professional yet comfortable
            ("ballet flats", "skirt"),  // Light and elegant
            ("hiking boots", "cargo pants"),  // Outdoor casual

            // Layering
            ("jeans", "jacket"),  // Casual and stylish
            ("sweater", "scarf"),  // Cozy layering
            ("blazer", "shirt"),  // Professional and sharp
            ("cardigan", "t-shirt"),  // Relaxed yet put together
            ("coat", "scarf"),  // Winter-ready
            ("puffer jacket", "jeans"),  // Cold-weather casual
            ("hoodie", "joggers"),  // Casual lounge wear
        ("purple", "yellow"),  // Too bold and clashing
        ("red", "purple"),  // Overwhelming warm tones
        ("bright blue", "neon green"),  // Overpowering vibrancy
        ("brown", "purple"),  // Heavy and mismatched
        ("teal", "bright orange"),  // Overly bright and competing

        // New Seasonal Mismatches
        ("a summer hat", "a wool coat"),  // Seasonal mismatch
        ("flip-flops", "a trench coat"),  // Casual with formal cold-weather wear
        ("a bikini", "a knit sweater"),  // Beachwear with winter warmth
        ("swim trunks", "a fleece jacket"),  // Summer with winter

        // New Formality Clashes
        ("formal trousers", "a hoodie"),  // Dressy with casual
        ("a sequin top", "hiking boots"),  // Glamorous with rugged
        ("a ball gown", "a denim jacket"),  // High-end formal with casual
        ("a tuxedo", "flip-flops"),  // Ultra-formal with casual
        ("a velvet blazer", "cargo shorts"),  // Luxurious with rugged

        // New Functional Mismatches
        ("ski boots", "a sundress"),  // Winter gear with summer wear
        ("hiking boots", "a maxi dress"),  // Rugged with flowing
        ("raincoat", "formal suit"),  // Functional with business
        ("track pants", "a silk blouse"),  // Athletic with elegant
        ("climbing shoes", "a chiffon dress"),

            // Formality
            ("formal jacket", "dress shirt"),  // Office-ready
            ("ball gown", "statement necklace"),  // Formal elegance
            ("tuxedo", "black bow tie"),  // Classic formal
            ("dress shoes", "suit"),  // Business formal
            ("pencil skirt", "blouse"),  // Office chic
            ("blazer", "trousers"),  // Professional business wear
            ("silk blouse", "pencil skirt"),  // Elegant office look

            // Occasions
            ("summer dress", "sandals"),  // Perfect for a day out
            ("sporty jacket", "athletic leggings"),  // Ideal for outdoor activities
            ("floral dress", "sunhat"),  // Day at the park or picnic
            ("peacoat", "winter boots"),  // Stylish winter wear
            ("raincoat", "rain boots"),  // Functional for wet weather
            ("sundress", "flats"),  // Light and comfortable for summer
            ("cocktail dress", "heels"),  // Elegant night out

            // Specific Items
            ("a floral summer dress", "a pair of white flat shoes"),  // Light and breezy
            ("a red cotton T-shirt", "a pair of skinny blue jeans"),  // Casual but stylish
            ("a beige coat with a belt", "a red leather handbag"),  // Polished and coordinated
            ("a white silk blouse with lace", "a navy pencil skirt"),  // Classy and elegant
            ("a navy turtleneck sweater", "a pair of grey wool trousers"),  // Cozy and professional
            ("a burgundy velvet midi dress", "a pair of gold block heels"),  // Luxe and festive
            ("a grey wool coat", "a pair of black leather gloves"),  // Winter-ready
            ("a black leather wallet", "a pair of black climbing shoes"),  // Casual yet coordinated
            ("a cream crochet blouse", "a light pink midi skirt"),  // Feminine and soft
            ("a black sequined pencil skirt", "a black satin off-shoulder blouse"),  // Evening glamour
            ("a navy blue wool trench coat", "a pair of tan leather boots"),  // Sleek and winter-ready
            ("a pair of dark brown Chelsea boots", "a beige knitted cardigan"),  // Cozy and stylish

            // Colors
            ("red", "black"),  // Bold and striking
            ("blue", "white"),  // Clean and timeless
            ("green", "gold"),  // Luxurious and complementary
            ("navy", "beige"),  // Neutral and sophisticated
            ("lavender", "white"),  // Soft and delicate
            ("maroon", "grey"),  // Deep and refined
            ("pink", "white"),  // Feminine and light
            ("burgundy", "charcoal gray"),  // Deep and elegant
            ("mint green", "blush pink"),  // Light and fresh
            ("teal", "peach"),  // Vibrant and complementary

            // General
            ("a beige knitted cardigan", "a pair of navy classic shoes"),  // Comfortable yet professional
            ("a pair of skinny blue jeans", "a red cotton T-shirt"),  // Simple and stylish
            ("a light pink chiffon scarf", "a white silk blouse with lace"),  // Soft and coordinated
            ("a white cotton shirt with long sleeves", "a pair of skinny blue jeans"),  // Classic casual
            ("a coral maxi dress", "a pair of tan espadrille wedges"),  // Bright and breezy
            ("a wool sweater", "a plaid skirt"),  // Cozy and autumn-ready
            ("a formal black blazer", "a white dress shirt"),  // Business-ready
            ("a black leather wallet", "a pair of grey sweatpants"),  // Casual and coordinated
            ("a floral chiffon scarf", "a beige coat with belt"),  // Warm and feminine
            ("a navy velvet pleated skirt", "a sky-blue chiffon ruffle top"),  // Elegant and coordinated
            ("a dark grey formal jacket", "a pair of beige classic shoes"),  // Sharp and professional
            ("a navy blue wool trench coat", "a pair of black leather gloves"),  // Stylish winter wear
            ("a red satin A-line dress", "a pair of black ballet flats"),  // Simple yet elegant
            ("a white sleeveless crop top", "a pair of navy sports leggings"),  // Casual active wear
            ("a beige linen shirt with rolled sleeves", "a pair of navy sports leggings"),  // Comfortable casual look
            ("a pair of black skinny pants", "a cream crochet blouse"),  // Light and elegant

            // Occasions and Events
            ("a black midi pencil skirt", "a black satin off-shoulder blouse"),  // Perfect for a night out
            ("a dark blue sleeveless dress", "a pair of white flat shoes"),  // Daytime chic
            ("a navy pencil skirt", "a white linen shirt"),  // Office-ready
            ("a maroon velvet midi dress", "a pair of gold block heels"),  // Luxurious evening wear
            ("a pair of beige hiking sandals", "a cream crochet blouse"),  // Relaxed and casual
            ("a red velvet wrap midi skirt", "a black satin bell-sleeve top"),
        ("cropped blazer", "high-waisted trousers"),  // Trendy and chic
        ("denim skirt", "striped sweater"),  // Casual and stylish
        ("wide-leg pants", "wrap blouse"),  // Elegant and flowy
        ("lace dress", "wool coat"),  // Feminine and winter-ready
        ("floral skirt", "chunky knit sweater"),  // Spring meets cozy
        ("tailored shorts", "silk blouse"),  // Polished summer look
        ("midi skirt", "turtleneck sweater"),  // Classic and cozy
        ("leather pants", "oversized blazer"),  // Edgy and structured
        ("sequined dress", "faux fur coat"),  // Glamorous and warm
        ("denim skirt", "graphic t-shirt"),  // Relaxed and fun
        ("joggers", "crop top"),  // Comfortable and trendy
        ("boyfriend jeans", "knit sweater"),  // Cozy and stylish
        ("chinos", "polo shirt"),  // Clean and casual
        ("cargo pants", "henley shirt"),  // Rugged and relaxed
        ("shorts", "tank top"),  // Summer-ready
        ("leggings", "oversized hoodie"),  // Comfortable athleisure
        ("denim jacket", "striped t-shirt"),  // Classic casual
        ("cropped jeans", "off-shoulder top"),  // Chic and summery
        ("sneakers", "casual dress"),  // Sporty and feminine
        ("pencil skirt", "button-down shirt"),  // Sleek and professional
        ("trousers", "blazer"),  // Classic business formal
        ("wrap dress", "pointed flats"),  // Polished and comfortable
        ("high-waisted trousers", "silk blouse"),  // Elegant and modern
        ("midi skirt", "turtleneck sweater"),  // Sophisticated and cozy
        ("cardigan", "shift dress"),  // Layered office look
        ("peacoat", "slacks"),  // Winter office wear
        ("heels", "tailored jumpsuit"),  // Stylish and professional
        ("blazer", "wide-leg trousers"),  // Structured and sleek
        ("white blouse", "pleated skirt"),  // Feminine and professional
        ("sequined dress", "stiletto heels"),  // Glamorous and elegant
        ("long gown", "statement necklace"),  // Classic evening wear
        ("velvet blazer", "dress pants"),  // Luxe and sharp
        ("midi dress", "strappy sandals"),  // Sophisticated and chic
        ("wrap dress", "ankle boots"),  // Versatile and stylish
        ("a-line skirt", "lace blouse"),  // Feminine and elegant
        ("cocktail dress", "peep-toe heels"),  // Perfect for parties
        ("jumpsuit", "metallic clutch"),  // Modern and sleek
        ("maxi dress", "shawl"),  // Evening-ready
        ("suit", "oxford shoes"),  // Timeless and formal
        ("floral dress", "light cardigan"),  // Fresh and breezy
        ("pastel skirt", "white blouse"),  // Soft and feminine
        ("capri pants", "peasant top"),  // Airy and casual
        ("denim jacket", "sundress"),  // Layered and spring-ready
        ("chiffon blouse", "pleated trousers"),  // Flowing and lig
        ("linen pants", "crop top"),  // Cool and breathable
        ("sundress", "straw hat"),  // Ideal for warm weather
        ("shorts", "breezy tank top"),  // Effortless and cool
        ("espadrilles", "maxi dress"),  // Summery and chic
        ("denim shorts", "halter top"),  // Casual and fun
        ("wool coat", "chunky scarf"),  // Cozy and timeless
        ("puffer jacket", "thermal leggings"),  // Practical and warm
        ("sweater dress", "tall boots"),  // Feminine and cozy
        ("cashmere sweater", "wide-leg pants"),  // Elegant and warm
        ("knit sweater", "faux fur vest"),  // Luxe and
        ("plaid shirt", "corduroy pants"),  // Cozy and seasonal
        ("ankle boots", "knit dress"),  // Stylish and warm
        ("turtleneck sweater", "wool skirt"),  // Classic fall look
        ("long cardigan", "high-waisted jeans"),  // Relaxed and chic
        ("trench coat", "midi dress"),  // Layered for crisp weather
        ("leggings", "sports bra"),  // Workout-ready
        ("track pants", "hoodie"),  // Comfortable and sporty
        ("biker shorts", "oversized t-shirt"),  // Trendy and functional
        ("running shoes", "joggers"),  // Active and comfortable
        ("tank top", "athletic skirt"),  // Sporty and feminine
        ("windbreaker", "compression pants"),  // Weather-resistant
        ("sneakers", "cargo joggers"),  // Rugged yet athletic
        ("turtleneck", "pinafore dress"),  // Cozy and layered
        ("denim jacket", "maxi dress"),  // Casual and balanced
        ("long cardigan", "belted jeans"),  // Stylish and warm
        ("scarf", "wool coat"),  // Classic and functional
        ("blazer", "cropped trousers"),  // Sleek and modern
        ("coat", "ankle boots"),  // Winter-ready
        ("button-up shirt", "sweater"),  // Preppy and warm
    ]


    // Define incompatible pairs
    let incompatiblePairs =  [
        ("flip-flops", "puffer jacket"), // Summer footwear with winter gear
        ("wool sweater", "shorts"),// Winter top with summer bottoms
        ("ski pants", "tank top"), // Cold-weather bottoms with summer top
        ("parka", "sundress"), // Heavy coat with lightweight dress
        ("snow boots", "bikini"), // Extreme winter with beachwear

        ("ball gown", "denim jacket"), // High formal with casual
        ("formal trousers", "graphic t-shirt"), // Business with casual
        ("evening gown", "sneakers"), // Elegant with athletic
        ("tuxedo", "flip-flops"), // Ultra-formal with casual
        ("pencil skirt", "sweatshirt"),// Office with relaxed

        ("rain boots", "formal dress"), // Practical with elegant
        ("ski boots", "maxi dress"), // Rugged with flowing
        ("track pants", "high heels"), // Athletic with formal
        ("climbing shoes", "evening gown"), // Rugged with delicate
        ("swimsuit", "heavy coat"), // Beachwear with winter gear

        ("sports jersey", "business suit"), // Athletic vs. professional
        ("crocs", "cocktail dress"), // Casual with formal
        ("puffer jacket", "ball gown"), // Casual winter with high-end
        ("shorts", "formal blazer"), // Casual vs. business
        ("denim jacket", "evening gown"), // Casual vs. glamorous

        ("bright orange", "hot pink"), // Overwhelming vibrancy
        ("lime green", "red"), // Strong and clashing
        ("yellow", "neon green"),// Too loud
        ("navy", "black"), // Too dark together
        ("brown", "purple"), // Muted and heavy
        // Categories
        ("boots", "flip-flops"),  // Conflicting seasonal footwear
          ("heels", "sandals"),  // Formal vs. casual
          ("sneakers", "formal shoes"),  // Athletic vs. formal
          ("high heels", "athletic shoes"),  // Elegant with sporty
          ("loafers", "flip-flops"),  // Casual vs. dressy
          ("ballet flats", "climbing shoes"),  // Elegant with rugged
          ("snow boots", "sandals"),  // Winter vs. summer

          // Layering Conflicts
          ("shorts", "winter coat"),  // Mismatched season
          ("jeans", "leggings"),  // Overlapping casual wear
          ("blazer", "tank top"),  // Formal with informal
          ("t-shirt", "formal pants"),  // Casual with business attire
          ("parka", "sundress"),  // Winter vs. summer clothing
          ("cardigan", "sports bra"),  // Casual vs. athletic
          ("raincoat", "party dress"),  // Functional with elegant
          ("sweater", "button-up shirt"),  // Double layering clash

          // Seasonal Mismatches
          ("shorts", "long-sleeve shirt"),  // Conflicting temperatures
          ("swimsuit", "faux fur coat"),  // Beachwear with winter wear
          ("tank top", "wool scarf"),  // Summer vs. winter wear
          ("flip-flops", "heavy coat"),  // Beach with winter
          ("flannel shirt", "sundress"),  // Winter shirt with summer dress
          ("parka", "sundress"),  // Winter wear with spring dress
          ("bikini", "heavy winter jacket"),
        // Contradictory seasonal wear
        ("dress", "jeans"),
        ("dress", "pants"),
        ("dress", "skirt"),



          // Formality Clashes
          ("formal suit", "t-shirt"),  // Professional vs. casual
          ("dress shoes", "hiking boots"),  // Dressy vs. rugged
          ("pencil skirt", "sweatshirt"),  // Formal vs. relaxed
          ("dress shirt", "athletic shorts"),  // Business wear with casual
          ("evening gown", "denim jacket"),  // Formal with casual
          ("tuxedo", "flip-flops"),  // High-end formal with casual
          ("formal jacket", "joggers"),  // Business vs. sportswear
          ("suit", "cargo pants"),  // Business formal with casual
          ("ball gown", "gym sneakers"),  // Formal wear with athletic shoes

          // Functional Mismatches
          ("scarf", "swimsuit"),  // Functional accessory with beachwear
          ("swimsuit", "ski pants"),  // Beachwear with snow gear
          ("jacket", "swimsuit"),  // Outdoor wear with beachwear
          ("track pants", "formal shoes"),  // Athletic wear with formal shoes
          ("leggings", "pencil skirt"),  // Casual with formal
          ("climbing shoes", "evening gown"),  // Rugged with elegant
          ("bikini", "high heels"),  // Beachwear with formal footwear
          ("jumpsuit", "party shoes"),  // Casual with formal
          ("parka", "shorts"),  // Cold-weather wear with summer casual

          // General Contradictions
          ("jeans", "blazer"),  // Casual with formal
          ("graphic t-shirt", "formal trousers"),  // Casual with business
          ("dress", "jacket"),  // Overly formal and unbalanced
          ("casual hoodie", "business shoes"),  // Casual and formal clash
          ("denim jacket", "evening gown"),  // Casual and formal clash
          ("puffer jacket", "floral dress"),  // Casual winter with feminine
          ("button-up shirt", "sweatpants"),  // Formal vs. loungewear
          ("shorts", "long winter coat"),  // Seasonal mismatch
          ("athletic shorts", "blazer"),  // Sportswear with formal
          ("tank top", "dress pants"),  // Casual with formal
          ("dress shirt", "cargo shorts"),  // Formal with casual
          ("t-shirt", "pencil skirt"),  // Casual with office wear

          // Overly Casual vs. Formal
          ("lounge pants", "blazer"),  // Comfort wear vs. business attire
          ("flannel shirt", "formal trousers"),  // Casual with business
          ("flannel shirt", "formal shoes"),  // Casual with formal
          ("sweatshirt", "formal pants"),  // Loungewear with office attire
          ("casual dress", "dress shoes"),  // Casual wear with formal shoes
          ("sports jersey", "business suit"),  // Athletic vs. formal
          ("sneakers", "formal suit"),  // Casual with business attire
          ("t-shirt", "dress shoes"),  // Casual with formal footwear
          ("denim jacket", "dress shoes"),  // Casual with formal footwear

          // Season vs. Occasion Mismatches
          ("snow boots", "summer dress"),  // Winter boots with a light dress
          ("bikini", "fleece jacket"),  // Beachwear with winter gear
          ("swimsuit", "leather jacket"),  // Beachwear with edgy style
          ("flip-flops", "winter gloves"),  // Seasonal mismatch
          ("summer dress", "wool scarf"),  // Summer with winter accessories
          ("wool coat", "tank top"),  // Winter with summer casual
          ("parka", "t-shirt"),  // Winter with summer wear

          // Contradictory Items
          ("knee-high boots", "flip-flops"),  // Heavy footwear with light sandals
          ("faux fur coat", "bikini"),  // Cold-weather wear with beachwear
          ("athletic leggings", "formal shoes"),  // Casual with business
          ("ski pants", "swim trunks"),  // Winter gear with beachwear
          ("parka", "sundress"),  // Heavy coat with lightweight dress
          ("raincoat", "suit jacket"),  // Functional outerwear with formal attire
          ("sweatpants", "blazer"),  // Loungewear with business attire
          ("suit jacket", "cargo shorts"),  // Formal with rugged wear
          ("formal gown", "t-shirt"),  // Formal with casual
          ("high heels", "cargo pants"),  // Dressy with casual
          ("jacket", "swimwear"),  // Outerwear with beachwear
             // Specific Items
        ("a pair of black climbing shoes", "a floral summer dress"),  // Rugged with delicate
        ("a burgundy velvet bomber jacket", "a light pink tulle mini skirt"),  // Heavy with airy
        ("a black leather bomber jacket", "a coral maxi dress"),  // Edgy with summery
        ("a white sleeveless peplum top", "a pair of grey sweatpants"),  // Formal with loungewear
        ("a pair of gold metallic stilettos", "a camo print T-shirt"),  // Elegant with rugged
        ("a navy double-breasted trench coat", "a pair of flip-flops"),  // Polished with casual
        ("a dark green satin wrap dress", "a pair of brown hiking boots"),  // Elegant with rugged

        // Colors
        ("red", "yellow"),  // Too bold and clashing
        ("pink", "orange"),  // Overwhelming warm tones
        ("lime green", "red"),  // Vibrancy clash
        ("navy", "black"),  // Too dark together
        ("grey", "beige"),  // Muted and unappealing
        ("bright orange", "pastel yellow"),  // Overly vibrant mismatch
        ("red", "brown"),  // Overly vibrant mismatch

        // Occasions
        ("a blush pink chiffon wrap dress", "a pair of black climbing shoes"),  // Feminine with rugged
        ("a burgundy velvet gown", "a pair of grey sports shoes"),  // Formal with athletic
        ("a navy blue sleeveless midi dress", "a black hooded parka with fur trim"),  // Summer with winter
        ("a camel faux fur vest", "a turquoise bikini top"),  // Winter with beachwear
        ("a white satin maxi dress", "a pair of black leather combat boots"),
        ("skirt", "skirt"),  // Redundant
        ("dress", "dress"),  // Overlapping purpose
        ("jeans", "jeans"),  // Impractical
        ("pants", "pants"),  // Overlap

        // Overlapping items
        ("skirt", "dress"),  // Overlapping wear
        ("pants", "skirt"),  // Clashing function
        ("jeans", "dress"),  // Redundant and mismatched
        ("shorts", "skirt"),  // Layering conflict
        ("leggings", "jeans"),  // Overlapping bottoms

        // Additional specific cases
        ("trench coat", "blazer"),  // Overlap of formal outerwear
        ("jacket", "coat"),  // Too many layers
        ("swimsuit", "dress"),  // Clashing functions
        ("parka", "cardigan"),  // Conflicting outerwear
        ("jeans", "leggings"),
        ("skirt", "skirt"),  // Two skirts are redundant
        ("dress", "dress"),  // Two dresses are overlapping
        ("jeans", "jeans"),  // Duplicate casual wear
        ("pants", "pants"),  // Redundant formal or casual bottoms
        ("shorts", "shorts"),  // Impractical layering
        ("leggings", "leggings"),  // Duplicate casual layer
        ("trench coat", "trench coat"),  // Overly layered and heavy
        ("cardigan", "cardigan"),  // Redundant and unnecessary
        ("t-shirt", "t-shirt"),  // Impractical layering
        ("tank top", "tank top"),  // Duplicate summer top
        ("sweater", "sweater"),  // Overlapping layers
        ("jacket", "jacket"),  // Over-layered
        ("blazer", "blazer"),  // Two formal outerwear pieces
        ("boots", "boots"),  // Overlapping footwear
        ("skirt", "dress"),  // Dress overlaps with a skirt
        ("pants", "skirt"),  // Bottoms clash
        ("jeans", "dress"),  // Redundant and clashing
        ("shorts", "skirt"),  // Unnecessary layering
        ("leggings", "jeans"),  // Overlapping casual bottoms
        ("coat", "jacket"),  // Conflicting outerwear
        ("blazer", "cardigan"),  // Two formal layers
        ("sweater", "blazer"),  // Overlap between casual and formal layers
        ("boots", "sandals"),  // Conflicting seasonal footwear
        ("heels", "flats"),  // Clashing formal and casual
        ("scarf", "scarf"),  // Duplicate accessory
        ("belt", "belt"),  // Redundant
        ("skirt", "pants"),  // Formal vs casual bottoms
        ("dress", "shorts"),  // Full outfit with casual wear
        ("jumpsuit", "skirt"),  // Complete outfit clashes with layering
        ("tank top", "coat"),  // Summer wear vs. winter
        ("blazer", "hoodie"),  // Formal with casual layering
        ("heels", "hiking boots"),  // Formal vs rugged
        ("flannel", "trench coat"),  // Casual vs formal clash
        ("suit", "shorts"),  // Business with summer wear
        ("gown", "denim jacket"),  // Glamorous with casual
        ("tuxedo", "cargo pants"),  //
        ("bikini", "wool coat"),  // Beachwear with winter gear
        ("shorts", "puffer jacket"),  // Summer vs winter
        ("sundress", "snow boots"),  // Summer with extreme winter
        ("flip-flops", "parka"),  // Summer footwear with winter outerwear
        ("tank top", "fleece jacket"),  // Lightweight with heavy
        ("swimsuit", "boots"),  // Beachwear with rugged footwear
        ("shorts", "scarf"),  // Sum
        ("dress", "jeans"),  // Redundant and bulky
        ("skirt", "leggings"),  // Overlapping bottoms
        ("jacket", "cardigan"),  // Too many outer layers
        ("blazer", "tank top"),  // Formal with casual
        ("jeans", "shorts"),  // Layering clash
        ("t-shirt", "button-down shirt"),  // Overlapping casual tops
        ("parka", "sweater"),  // Excessive layering
        ("a-line skirt", "pencil skirt"),  // Two skirts of different cuts
        ("shift dress", "wrap dress"),  // Overlapping dress styles
        ("straight-leg jeans", "skinny jeans"),  // Redundant casual bottoms
        ("crew neck sweater", "v-neck sweater"),  // Duplicate winter tops
        ("leather jacket", "denim jacket"),  // Too many heavy layers
        ("formal trousers", "cargo pants"),  // Formal vs casual clash
        ("swim trunks", "ski pants"),  // Beach vs winter gear
        ("sandals", "snow boots"),  // Summer vs extreme winter
        ("cropped jeans", "leggings"),  // Over
]


    // Check for compatibility
    for (cat1, cat2) in incompatiblePairs {
         if (normalizedFirstItem.contains(cat1) && normalizedSecondItem.contains(cat2)) ||
            (normalizedFirstItem.contains(cat2) && normalizedSecondItem.contains(cat1)) {
             return "These items do not match."
         }
     }
    // Check for incompatibility
    for (cat1, cat2) in compatiblePairs {
         if (normalizedFirstItem.contains(cat1) && normalizedSecondItem.contains(cat2)) ||
            (normalizedFirstItem.contains(cat2) && normalizedSecondItem.contains(cat1)) {
             return "These items match perfectly!"
         }
     }

    // Default case
    return "These items might match depending on style preferences."
}
