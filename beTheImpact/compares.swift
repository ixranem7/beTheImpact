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
        // Categories
        ("jeans", "t-shirt"),  // Classic casual
        ("skirt", "blouse"),  // Feminine and balanced
        ("boots", "jeans"),  // Rugged and functional
        ("sandals", "shorts"),  // Perfect for summer
        ("coat", "trousers"),  // Winter-ready and formal
        ("sneakers", "joggers"),  // Activewear
        ("heels", "dress"),  // Formal and elegant
        ("scarf", "jacket"),  // Layered look
        ("blazer", "slacks"),  // Business formal
        ("cardigan", "midi dress"),

        // Specific Items
        ("a floral summer dress", "a pair of white flat shoes"),  // Light and airy
        ("a pair of skinny blue jeans", "a white cotton shirt with long sleeves"),  // Casual chic
        ("a red cotton T-shirt", "a pair of navy sports leggings"),  // Comfortable and sporty
        ("a beige knitted cardigan", "a pair of navy classic shoes"),  // Warm and professional
        ("a black midi pencil skirt", "a white linen blouse"),  // Office-ready
        ("a cream crochet blouse", "a light pink chiffon scarf"),  // Feminine and graceful
        ("a camel wrap coat", "a pair of brown leather boots"),  // Winter stylish
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
            ("a red velvet wrap midi skirt", "a black satin bell-sleeve top"),  // Elegant and festive// Summer formal
    ]


    // Define incompatible pairs
    let incompatiblePairs =  [
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
          ("bikini", "heavy winter jacket"),  // Contradictory seasonal wear

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

        // Occasions
        ("a blush pink chiffon wrap dress", "a pair of black climbing shoes"),  // Feminine with rugged
        ("a burgundy velvet gown", "a pair of grey sports shoes"),  // Formal with athletic
        ("a navy blue sleeveless midi dress", "a black hooded parka with fur trim"),  // Summer with winter
        ("a camel faux fur vest", "a turquoise bikini top"),  // Winter with beachwear
        ("a white satin maxi dress", "a pair of black leather combat boots"),  // Bridal with edgy
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
