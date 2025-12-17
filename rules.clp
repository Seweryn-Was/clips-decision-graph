(deffacts initial
  ; Stan początkowy (q-start)
  (pytanie "Search your feelings. Why are you traveling?" "q-start" 
           "Vacation? Now that's a word I haven't heard in a long time." 
           "I just want to teleport off this rock.")
)

;;; --- REGUŁY DLA PYTAŃ (PRZEJŚCIA) ---

(defrule start-vacation
  (not (odpowiedz $?))
  (not (pytanie ? "q-break" $?))
  (not (q-break $?))
  (q-start "Vacation? Now that's a word I haven't heard in a long time.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "What could you use a break from?" "q-break" "Work" "The city" "The same faces at the cantina"))
)

(defrule start-teleport
  (not (odpowiedz $?))
  (not (pytanie ? "q-longdistance" $?))
  (not (q-longdistance $?))
  (q-start "I just want to teleport off this rock.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Are you willing to travel far?" "q-longdistance" "Yes" "No"))
)

(defrule break-work
  (not (odpowiedz $?))
  (not (pytanie ? "q-work" $?))
  (not (q-work $?))
  (q-break "Work")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "What kind of work are you in?" "q-work" "Business" "Retail" "Creative field"))
)

(defrule break-city
  (not (odpowiedz $?))
  (not (pytanie ? "q-sounds" $?))
  (not (q-sounds $?))
  (q-break "The city")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Sounds like you need to commune with nature." "q-sounds" "Yes" "OK but I'm not sleeping outside, right?"))
)

(defrule break-faces
  (not (odpowiedz $?))
  (not (pytanie ? "q-destructive" $?))
  (not (q-destructive $?))
  (q-break "The same faces at the cantina")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Are you self-destructive?" "q-destructive" "Yes" "No"))
)

(defrule destructive-yes
  (not (odpowiedz $?))
  (not (pytanie ? "q-mentally" $?))
  (not (q-mentally $?))
  (q-destructive "Yes")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Mentally or physically?" "q-mentally" "Mentally" "Physically"))
)

(defrule destructive-no
  (not (odpowiedz $?))
  (not (pytanie ? "q-social" $?))
  (not (q-social $?))
  (q-destructive "No")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Are you social?" "q-social" "No" "Yes" "I prefer animals over people."))
)

(defrule social-no
  (not (odpowiedz $?))
  (not (pytanie ? "q-choice" $?))
  (not (q-choice $?))
  (q-social "No")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "By choice?" "q-choice" "No, most of my friends have moved away." "Yes, I can't stand pathetic life forms."))
)

(defrule social-yes
  (not (odpowiedz $?))
  (not (pytanie ? "q-friends" $?))
  (not (q-friends $?))
  (q-social "Yes")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Describe your friends." "q-friends" "A bunch of scruffy-lookin' nerfherders" "A ton of party animals. Mos Eisley is old news." "Tight-knit. I'd do anything for them."))
)

(defrule social-animals
  (not (odpowiedz $?))
  (not (pytanie ? "q-animal" $?))
  (not (q-animal $?))
  (q-social "I prefer animals over people.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Choose an animal." "q-animal" "Bear" "Squid"))
)

(defrule choice-no
  (not (odpowiedz $?))
  (not (pytanie ? "q-pouting" $?))
  (not (q-pouting $?))
  (q-choice "No, most of my friends have moved away.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Aw, QQ. Stop pouting and go find them!" "q-pouting" "Continue"))
)

(defrule choice-yes
  (not (odpowiedz $?))
  (not (pytanie ? "q-color" $?))
  (not (q-color $?))
  (q-choice "Yes, I can't stand pathetic life forms.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "What color is your lightsaber?" "q-color" "Blue" "Red"))
)

(defrule pouting-continue
  (not (odpowiedz $?))
  (not (pytanie ? "q-friends" $?))
  (not (q-friends $?))
  (q-pouting "Continue")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Describe your friends." "q-friends" "A bunch of scruffy-lookin' nerfherders" "A ton of party animals. Mos Eisley is old news." "Tight-knit. I'd do anything for them."))
)

(defrule friends-party
  (not (odpowiedz $?))
  (not (pytanie ? "q-poison" $?))
  (not (q-poison $?))
  (q-friends "A ton of party animals. Mos Eisley is old news.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Pick your poison." "q-poison" "Glyterrill" "Death Sticks" "Rhyll"))
)

(defrule friends-tight
  (not (odpowiedz $?))
  (not (pytanie ? "q-spend" $?))
  (not (q-spend $?))
  (q-friends "Tight-knit. I'd do anything for them.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "How do you spend your time together?" "q-spend" "Playing video games" "Long talks" "Eat sushi"))
)

(defrule mentally-mentally
  (not (odpowiedz $?))
  (not (pytanie ? "q-anger" $?))
  (not (q-anger $?))
  (q-mentally "Mentally")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Beware. Anger, fear, aggression. The Dark Side are they." "q-anger" "I am the Dark Side." "Help me Obi-Wan Kenobi!"))
)

(defrule mentally-phys
  (not (odpowiedz $?))
  (not (pytanie ? "q-deathwish" $?))
  (not (q-deathwish $?))
  (q-mentally "Physically")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Do you have a death wish?" "q-deathwish" "Yes" "No"))
)

(defrule anger-obiwan
  (not (odpowiedz $?))
  (not (pytanie ? "q-clear" $?))
  (not (q-clear $?))
  (q-anger "Help me Obi-Wan Kenobi!")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Clear your mind you must. How do you unwind?" "q-clear" "Oil baths" "Braid my hair" "Listen to music" "Sports"))
)

(defrule work-business
  (not (odpowiedz $?))
  (not (pytanie ? "q-business" $?))
  (not (q-business $?))
  (q-work "Business")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Who would you never do business with?" "q-business" "Alderaan" "A talking squid" "Dugs or Toydarians"))
)

(defrule work-retail
  (not (odpowiedz $?))
  (not (pytanie ? "q-canttravel" $?))
  (not (q-canttravel $?))
  (q-work "Retail")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "What's one thing you can't travel without?" "q-canttravel" "A GoPro" "My brand-new hologram cell phone" "My camera" "A good book"))
)

(defrule work-creative
  (not (odpowiedz $?))
  (not (pytanie ? "q-inspired" $?))
  (not (q-inspired $?))
  (q-work "Creative field")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "What are you more inspired by?" "q-inspired" "Great artists before me" "Posters with eagles and inspirational quotes"))
)

(defrule inspired-artist
  (not (odpowiedz $?))
  (not (pytanie ? "q-painting" $?))
  (not (q-painting $?))
  (q-inspired "Great artists before me")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Whose painting would you frame on your wall?" "q-painting" "M.C. Escher" "Hokusai"))
)

(defrule inspired-posters
  (not (odpowiedz $?))
  (not (pytanie ? "q-motto" $?))
  (not (q-motto $?))
  (q-inspired "Posters with eagles and inspirational quotes")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Which motto do you live by?" "q-motto" "There's always a bigger fish." "Hokey religions are no match for a good blaster at your side." "Live long and prosper."))
)

(defrule motto-religions
  (not (odpowiedz $?))
  (not (pytanie ? "q-blast" $?))
  (not (q-blast $?))
  (q-motto "Hokey religions are no match for a good blaster at your side.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "What would you rather blast?" "q-blast" "A Dug" "A Wampa" "Womp rats"))
)

(defrule canttravel-book
  (not (odpowiedz $?))
  (not (pytanie ? "q-genre" $?))
  (not (q-genre $?))
  (q-canttravel "A good book")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "What genre?" "q-genre" "Non-fiction" "Sci-fi fantasy"))
)

(defrule business-alderaan
  (not (odpowiedz $?))
  (not (pytanie ? "q-toosoon" $?))
  (not (q-toosoon $?))
  (q-business "Alderaan")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Aw, too soon?" "q-toosoon" "Continue"))
)

(defrule longdistance-yes
  (not (odpowiedz $?))
  (not (pytanie ? "q-midichlorian" $?))
  (not (q-midichlorian $?))
  (q-longdistance "Yes")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "What's your midi-chlorian count?" "q-midichlorian" "WTF is a midi-chlorian?" "Off the charts" "DGAF! No mystical energy field controls my destiny."))
)

(defrule midichlorian-crazy
  (not (odpowiedz $?))
  (not (pytanie ? "q-cocky" $?))
  (not (q-cocky $?))
  (q-midichlorian "Off the charts")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Great kid, don't get cocky." "q-cocky" "Continue"))
)

(defrule midichlorian-less
  (not (odpowiedz $?))
  (not (pytanie ? "q-destiny" $?))
  (not (q-destiny $?))
  (q-midichlorian "DGAF! No mystical energy field controls my destiny.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "What controls your destiny?" "q-destiny" "Money" "Love" "Adrenaline"))
)

(defrule cocky-continue
  (not (odpowiedz $?))
  (not (pytanie ? "q-searching" $?))
  (not (q-searching $?))
  (q-cocky "Continue")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Are you searching for something or hiding from something?" "q-searching" "Hiding" "Searching"))
)

(defrule searching-hiding
  (not (odpowiedz $?))
  (not (pytanie ? "q-fromwhat" $?))
  (not (q-fromwhat $?))
  (q-searching "Hiding")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "From what?" "q-fromwhat" "The past" "Don't worry about it." "Jar Jar Binks" "A slimy piece of worm-ridden filth"))
)

(defrule searching-searching
  (not (odpowiedz $?))
  (not (pytanie ? "q-scavenging" $?))
  (not (q-scavenging $?))
  (q-searching "Searching")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Searching or scavenging?" "q-scavenging" "Scavenging" "Searching"))
)

(defrule scavenging-searching
  (not (odpowiedz $?))
  (not (pytanie ? "q-foradventure" $?))
  (not (q-foradventure $?))
  (q-scavenging "Searching")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "For adventure?" "q-foradventure" "Yes" "Adventure. Excitement. A Jedi craves not these things."))
)

(defrule foradventure-yes
  (not (odpowiedz $?))
  (not (pytanie ? "q-bluemilk" $?))
  (not (q-bluemilk $?))
  (q-foradventure "Yes")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "How do you like your blue milk?" "q-bluemilk" "Warm" "Cold"))
)

(defrule foradventure-adv
  (not (odpowiedz $?))
  (not (pytanie ? "q-adegen" $?))
  (not (q-adegen $?))
  (q-foradventure "Adventure. Excitement. A Jedi craves not these things.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "What about Adegen crystals?" "q-adegen" "Now you're talking!"))
)

(defrule bluemilk-warm
  (not (odpowiedz $?))
  (not (pytanie ? "q-trap" $?))
  (not (q-trap $?))
  (q-bluemilk "Warm")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "It's a trap!" "q-trap" "Continue"))
)

(defrule bluemilk-cold
  (not (odpowiedz $?))
  (not (pytanie ? "q-tauntaun" $?))
  (not (q-tauntaun $?))
  (q-bluemilk "Cold")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Don't forget your tauntaun!" "q-tauntaun" "Continue"))
)

(defrule fromwhat-past
  (not (odpowiedz $?))
  (not (pytanie ? "q-whathappened" $?))
  (not (q-whathappened $?))
  (q-fromwhat "The past")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "What happened?" "q-whathappened" "Ever heard of Order 66?" "I came home to the charred remains of my relatives."))
)

(defrule fromwhat-jarjar
  (not (odpowiedz $?))
  (not (pytanie ? "q-gungans" $?))
  (not (q-gungans $?))
  (q-fromwhat "Jar Jar Binks")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Gungans no liking hot, dry weather." "q-gungans" "Continue"))
)

(defrule fromwhat-slimy
  (not (odpowiedz $?))
  (not (pytanie ? "q-lightspeed" $?))
  (not (q-lightspeed $?))
  (q-fromwhat "A slimy piece of worm-ridden filth")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Lightspeed!" "q-lightspeed" "Continue"))
)

(defrule whathappened-order
  (not (odpowiedz $?))
  (not (pytanie ? "q-sithbastard" $?))
  (not (q-sithbastard $?))
  (q-whathappened "Ever heard of Order 66?")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "No vacation can heal that, you Sith bastard." "q-sithbastard" "Noooooooooooo!"))
)

(defrule whathappened-remains
  (not (odpowiedz $?))
  (not (pytanie ? "q-relieved" $?))
  (not (q-relieved $?))
  (q-whathappened "I came home to the charred remains of my relatives.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "...but weren't you mildly relieved it meant you finally got to fly away?" "q-relieved" "Yes" "No, I love living in a remote desert"))
)

(defrule relieved-yes
  (not (odpowiedz $?))
  (not (pytanie ? "q-burned" $?))
  (not (q-burned $?))
  (q-relieved "Yes")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Before your house burned down, what was your favorite toy as a kid?" "q-burned" "Furby" "Magic 8 Ball" "Super Soaker" "An RC Car" "A chemistry set"))
)

(defrule burned-furby
  (not (odpowiedz $?))
  (not (pytanie ? "q-glutton" $?))
  (not (q-glutton $?))
  (q-burned "Furby")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Are you a glutton for pain?" "q-glutton" "Yes" "No"))
)

(defrule burned-magic
  (not (odpowiedz $?))
  (not (pytanie ? "q-future" $?))
  (not (q-future $?))
  (q-burned "Magic 8 Ball")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "True or false? Impossible to see, the future is." "q-future" "True" "False"))
)

(defrule glutton-yes
  (not (odpowiedz $?))
  (not (pytanie ? "q-fate" $?))
  (not (q-fate $?))
  (q-glutton "Yes")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Which fate would you rather be dealt?" "q-fate" "Being frozen in carbonite" "Being slowly digested for 1000 years"))
)

(defrule fate-carbonite
  (not (odpowiedz $?))
  (not (pytanie ? "q-ilove" $?))
  (not (q-ilove $?))
  (q-fate "Being frozen in carbonite")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "I love you." "q-ilove" "I know"))
)

(defrule destiny-money
  (not (odpowiedz $?))
  (not (pytanie ? "q-lovemoney" $?))
  (not (q-lovemoney $?))
  (q-destiny "Money")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "If money is what you love, then that's what you'll receive." "q-lovemoney" "Continue"))
)

(defrule lovemoney-continue
  (not (odpowiedz $?))
  (not (pytanie ? "q-gambling" $?))
  (not (q-gambling $?))
  (q-lovemoney "Continue")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Are you a gambling type?" "q-gambling" "Yes, never tell me the odds." "No"))
)

(defrule destiny-love
  (not (odpowiedz $?))
  (not (pytanie ? "q-relationship" $?))
  (not (q-relationship $?))
  (q-destiny "Love")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Are you in a serious relationship?" "q-relationship" "Yes" "No, she died giving birth to twins." "I don't know... You think a princess and a guy like me..."))
)

(defrule destiny-adrenaline
  (not (odpowiedz $?))
  (not (pytanie ? "q-deathwish" $?))
  (not (q-deathwish $?))
  (q-destiny "Adrenaline")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Do you have a death wish?" "q-deathwish" "Yes" "No"))
)

(defrule deathwish-yes
  (not (odpowiedz $?))
  (not (pytanie ? "q-howdie" $?))
  (not (q-howdie $?))
  (q-deathwish "Yes")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "How do you want to die?" "q-howdie" "In a fiery explosion" "In a knife fight"))
)

(defrule deathwish-no
  (not (odpowiedz $?))
  (not (pytanie ? "q-drink" $?))
  (not (q-drink $?))
  (q-deathwish "No")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Do you drink?" "q-drink" "Does blue milk count?" "Yes"))
)

(defrule drink-yes
  (not (odpowiedz $?))
  (not (pytanie ? "q-clubsbars" $?))
  (not (q-clubsbars $?))
  (q-drink "Yes")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "At clubs or bars?" "q-clubsbars" "Clubs" "Bars"))
)

(defrule clubsbars-bars
  (not (odpowiedz $?))
  (not (pytanie ? "q-whatdrink" $?))
  (not (q-whatdrink $?))
  (q-clubsbars "Bars")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "What are you ordering?" "q-whatdrink" "Knockback rum" "Fireball shots" "Mai tai" "An oaky scotch"))
)

(defrule gambling-yes
  (not (odpowiedz $?))
  (not (pytanie ? "q-podracerslava" $?))
  (not (q-podracerslava $?))
  (q-gambling "Yes, never tell me the odds.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Podracers or lavaracers?" "q-podracerslava" "Podracers" "Lavaracers"))
)

(defrule gambling-no
  (not (odpowiedz $?))
  (not (pytanie ? "q-holding" $?))
  (not (q-holding $?))
  (q-gambling "No")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Are you holding?" "q-holding" "Who's asking?" "No"))
)

(defrule holding-who
  (not (odpowiedz $?))
  (not (pytanie ? "q-rethink" $?))
  (not (q-rethink $?))
  (q-holding "Who's asking?")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "You may want to rethink your life choices." "q-rethink" "Help me Obi-Wan Kenobi!" "Your Jedi mind tricks don't work on me."))
)

(defrule rethink-mind
  (not (odpowiedz $?))
  (not (pytanie ? "q-clear" $?))
  (not (q-clear $?))
  (q-rethink "Your Jedi mind tricks don't work on me.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Clear your mind you must. How do you unwind?" "q-clear" "Oil baths" "Braid my hair" "Listen to music" "Sports"))
)

(defrule clear-music
  (not (odpowiedz $?))
  (not (pytanie ? "q-whattype" $?))
  (not (q-whattype $?))
  (q-clear "Listen to music")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "What type?" "q-whattype" "Pop" "Rock" "Instrumental"))
)

(defrule clear-sport
  (not (odpowiedz $?))
  (not (pytanie ? "q-playwatch" $?))
  (not (q-playwatch $?))
  (q-clear "Sports")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Do you play or watch?" "q-playwatch" "Watch" "Play"))
)

(defrule playwatch-play
  (not (odpowiedz $?))
  (not (pytanie ? "q-podracerslava" $?))
  (not (q-podracerslava $?))
  (q-playwatch "Play")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Podracers or lavaracers?" "q-podracerslava" "Podracers" "Lavaracers"))
)

(defrule whattype-instrumental
  (not (odpowiedz $?))
  (not (pytanie ? "q-john" $?))
  (not (q-john $?))
  (q-whattype "Instrumental")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "John Williams or Danny Elfman?" "q-john" "John Williams" "Danny Elfman"))
)

(defrule relationship-yes
  (not (odpowiedz $?))
  (not (pytanie ? "q-prisoner" $?))
  (not (q-prisoner $?))
  (q-relationship "Yes")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "The love of your life has been taken prisoner. Do you risk your life to save theirs?" "q-prisoner" "No, better them than me." "I'm already holding my detonator."))
)

(defrule relationship-no
  (not (odpowiedz $?))
  (not (pytanie ? "q-badfeeling" $?))
  (not (q-badfeeling $?))
  (q-relationship "No, she died giving birth to twins.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "I have a bad feeling about this." "q-badfeeling" "Continue"))
)

(defrule relationship-idk
  (not (odpowiedz $?))
  (not (pytanie ? "q-kisssibling" $?))
  (not (q-kisssibling $?))
  (q-relationship "I don't know... You think a princess and a guy like me...")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Would you kiss your sibling to make them jealous?" "q-kisssibling" "Yes" "No"))
)

(defrule badfeeling-continue
  (not (odpowiedz $?))
  (not (pytanie ? "q-finish" $?))
  (not (q-finish $?))
  (q-badfeeling "Continue")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Finish the phrase: 'Fear leads to anger. Anger leads to hate. Hate leads to...'" "q-finish" "Suffering" "Revenge"))
)

(defrule kisssibling-yes
  (not (odpowiedz $?))
  (not (pytanie ? "q-regret" $?))
  (not (q-regret $?))
  (q-kisssibling "Yes")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "You're gonna regret that." "q-regret" "Continue"))
)

(defrule prisoner-no
  (not (odpowiedz $?))
  (not (pytanie ? "q-firstshot" $?))
  (not (q-firstshot $?))
  (q-prisoner "No, better them than me.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Who shot first?" "q-firstshot" "Greedo" "Han"))
)

(defrule prisoner-detonator
  (not (odpowiedz $?))
  (not (pytanie ? "q-adventure" $?))
  (not (q-adventure $?))
  (q-prisoner "I'm already holding my detonator.")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Sounds like you're up for an adventure." "q-adventure" "Yes" "Those days are long behind us."))
)

(defrule firstshot-greedo
  (not (odpowiedz $?))
  (not (pytanie ? "q-nope" $?))
  (not (q-nope $?))
  (q-firstshot "Greedo")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Nope." "q-nope" "Han"))
)

(defrule sithbastard-order
  (not (odpowiedz $?))
  (not (pytanie ? "q-no" $?))
  (not (q-no $?))
  (q-sithbastard "Noooooooooooo!")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "No" "q-no" "Continue"))
)

(defrule drink-bluemilk
  (not (odpowiedz $?))
  (not (pytanie ? "q-no" $?))
  (not (q-no $?))
  (q-drink "Does blue milk count?")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "No" "q-no" "Continue"))
)

(defrule holding-no
  (not (odpowiedz $?))
  (not (pytanie ? "q-drink" $?))
  (not (q-drink $?))
  (q-holding "No")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (pytanie "Do you drink?" "q-drink" "Does blue milk count?" "Yes"))
)

;;; --- REGUŁY WYNIKOWE (Destinations) ---

(defrule dest-malastare
  (not (odpowiedz $?))
  (or (q-friends "A bunch of scruffy-lookin' nerfherders")
      (q-poison "Glyterrill")
      (q-blast "A Dug")
      (q-burned "An RC Car")
      (q-howdie "In a knife fight")
      (q-podracerslava "Podracers")
      (q-rethink "Help me Obi-Wan Kenobi!")
      (q-whattype "Rock")
      (q-finish "Revenge"))
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (odpowiedz "Malastare: Podracing is very fast and very dangerous, but if you're up for it, there's no place better to attempt it than on Malastare. The planet hosts regular tournaments like the Malastare 100 and the Dug Derby."))
)

(defrule dest-ryloth
  (not (odpowiedz $?))
  (or (q-spend "Playing video games")
      (q-poison "Rhyll")
      (q-painting "M.C. Escher")
      (q-canttravel "My camera")
      (q-genre "Sci-fi fantasy")
      (q-future "False")
      (q-regret "Continue")
      (q-adventure "Yes"))
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (odpowiedz "Ryloth: A long-time major exporter of medicinal products, Ryloth doubles as a safari destination thanks to its incredible biodiversity. Your Twi'lek guides will take you across lush valleys, thriving jungles, and breathtaking volcanoes."))
)

(defrule dest-naboo
  (not (odpowiedz $?))
  (or (q-spend "Long talks")
      (q-genre "Non-fiction")
      (q-toosoon "Continue")
      (q-no "Continue")
      (q-kisssibling "No")
      (q-adventure "Those days are long behind us."))
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (odpowiedz "Naboo: Naboo isn't just a beautiful planet with an undersea society of Gungans. It's also full of beautiful ruins and museums dedicated to Outer Rim history. Visit the capital city of Theed."))
)

(defrule dest-moncala
  (not (odpowiedz $?))
  (or (q-spend "Eat sushi")
      (q-animal "Squid")
      (q-sounds "OK but I'm not sleeping outside, right?")
      (q-motto "There's always a bigger fish.")
      (q-painting "Hokusai")
      (q-trap "Continue")
      (q-burned "Super Soaker")
      (q-whatdrink "Mai tai"))
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (odpowiedz "Mon cala (DAC): Mon Cala, best known as the home of the gregarious species of the same name, is one of the galaxy's most beautiful SCUBA diving destinations."))
)

(defrule dest-coruscant
  (not (odpowiedz $?))
  (or (q-poison "Death Sticks")
      (q-canttravel "My brand-new hologram cell phone")
      (q-business "Dugs or Toydarians")
      (q-glutton "No")
      (q-future "True")
      (q-clubsbars "Clubs")
      (q-clear "Oil baths")
      (q-whattype "Pop")
      (q-john "Danny Elfman"))
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (odpowiedz "Coruscant: Coruscant has developed into an ecumenopolis, with a total of 5,127 levels of city built up from the crust. This planet is a 12-layer cake of urban sprawl."))
)

(defrule dest-ilum
  (not (odpowiedz $?))
  (or (q-color "Blue")
      (q-blast "A Wampa")
      (q-tauntaun "Continue")
      (q-adegen "Now you're talking!")
      (q-burned "A chemistry set")
      (q-ilove "I know")
      (q-finish "Suffering"))
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (odpowiedz "Ilum: If you're the prospecting type, consider a visit to icy Ilum in search of the rare kyber crystals. The legendary Jedi Knights power their lightsabers with these crystals."))
)

(defrule dest-jakku
  (not (odpowiedz $?))
  (or (q-color "Red")
      (q-blast "Womp rats")
      (q-scavenging "Scavenging")
      (q-fromwhat "Don't worry about it.")
      (q-gungans "Continue")
      (q-relieved "No, I love living in a remote desert")
      (q-fate "Being slowly digested for 1000 years")
      (q-whatdrink "Knockback rum")
      (q-playwatch "Watch"))
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (odpowiedz "Jakku: If you're an explorer at heart, you'll love the eerie shipwrecks on Jakku. They're begging to be explored and scavenged! Jakku is made up of vast, dry deserts."))
)

(defrule dest-endor
  (not (odpowiedz $?))
  (or (q-animal "Bear")
      (q-sounds "Yes")
      (q-lightspeed "Continue")
      (q-whatdrink "An oaky scotch")
      (q-clear "Braid my hair")
      (q-john "John Williams"))
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (odpowiedz "Endor: If you love a good camping trip, Endor is where you want to be. The native Ewoks have become more accustomed to visitors ever since the Battle of Endor thrust their world into the galactic spotlight."))
)

(defrule dest-mustafar
  (not (odpowiedz $?))
  (or (q-canttravel "A GoPro")
      (q-business "A talking squid")
      (q-howdie "In a fiery explosion")
      (q-whatdrink "Fireball shots")
      (q-podracerslava "Lavaracers"))
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (odpowiedz "Mustafar: A fiery volcanic world where lava is mined like a precious natural resource. Don't let its drab mining outposts fool you–Mustafar offers some of the hottest thrills in the Outer Rim."))
)

(defrule dest-vacation
  (not (odpowiedz $?))
  (or (q-anger "I am the Dark Side.")
      (q-firstshot "Han")
      (q-nope "Han"))
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (odpowiedz "No need: You don't need A vacation. The force will set you free."))
)

(defrule dest-thisisnot
  (not (odpowiedz $?))
  (or (q-motto "Live long and prosper.")
      (q-midichlorian "WTF is a midi-chlorian?"))
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (odpowiedz "Not for you: This is not the flowchart you're looking for."))
)

(defrule dest-notry
  (not (odpowiedz $?))
  (q-longdistance "No")
  ?p <- (pytanie $?)
  =>
  (retract ?p)
  (assert (odpowiedz "Do or do not: Do or do not; there is no try."))
)