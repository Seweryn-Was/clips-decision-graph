(deffacts starwars-graph
  ; -------------------------------------------------------------------------
  ; DEFINICJA WĘZŁÓW - PYTANIA (kolejność z questions.json)
  ; -------------------------------------------------------------------------
  (node (id q-start)         (type question))
  (node (id q-longdistance)  (type question))
  (node (id q-notry)         (type question))
  (node (id q-midichlorian)  (type question))
  (node (id q-cocky)         (type question))
  (node (id q-searching)     (type question))
  (node (id q-scavenging)    (type question))
  (node (id q-foradventure)  (type question))
  (node (id q-bluemilk)      (type question))
  (node (id q-trap)          (type question))
  (node (id q-lovemoney)     (type question))
  (node (id q-tauntaun)      (type question))
  (node (id q-adegen)        (type question))
  (node (id q-fromwhat)      (type question))
  (node (id q-lightspeed)    (type question))
  (node (id q-gungans)       (type question))
  (node (id q-whathappened)  (type question))
  (node (id q-relieved)      (type question))
  (node (id q-burned)        (type question))
  (node (id q-glutton)       (type question))
  (node (id q-fate)          (type question))
  (node (id q-ilove)         (type question))
  (node (id q-future)        (type question))
  (node (id q-sithbastard)   (type question))
  (node (id q-destiny)       (type question))
  (node (id q-deathwish)     (type question))
  (node (id q-howdie)        (type question))
  (node (id q-drink)         (type question))
  (node (id q-clubsbars)     (type question))
  (node (id q-whatdrink)     (type question))
  (node (id q-no)            (type question))
  (node (id q-gambling)      (type question))
  (node (id q-podracerslava) (type question))
  (node (id q-holding)       (type question))
  (node (id q-rethink)       (type question))
  (node (id q-clear)         (type question))
  (node (id q-playwatch)     (type question))
  (node (id q-whattype)      (type question))
  (node (id q-john)          (type question))
  (node (id q-relationship)  (type question))
  (node (id q-badfeeling)    (type question))
  (node (id q-finish)        (type question))
  (node (id q-kisssibling)   (type question))
  (node (id q-regret)        (type question))
  (node (id q-prisoner)      (type question))
  (node (id q-adventure)     (type question))
  (node (id q-firstshot)     (type question))
  (node (id q-nope)          (type question))
  (node (id q-wretched)      (type question))

  ; -------------------------------------------------------------------------
  ; DEFINICJA WĘZŁÓW - CELE
  ; -------------------------------------------------------------------------
  (node (id dest-naboo)      (type destination))
  (node (id dest-coruscant)  (type destination))
  (node (id dest-endor)      (type destination))
  (node (id dest-ryloth)     (type destination))
  (node (id dest-malastare)  (type destination))
  (node (id dest-moncala)    (type destination))
  (node (id dest-mustafar)   (type destination))
  (node (id dest-jakku)      (type destination))
  (node (id dest-ilum)       (type destination))
  (node (id dest-thisisnot)  (type destination))
  (node (id dest-no)  (type destination))

  ; -------------------------------------------------------------------------
  ; PRZEJŚCIA (TRANSITIONS)
  ; Kolejność zgodna z questions.json
  ; -------------------------------------------------------------------------

  ; 1. q-start: Search your feelings. Why are you traveling?
  ;(transition (from q-start) (answer want-vacation)      (to do-uzupelnienia))
  (transition (from q-start) (answer want-teleportation) (to q-longdistance))

  ; 2. q-longdistance: Are you willing to travel far?
  (transition (from q-longdistance) (answer longdistance-yes) (to q-midichlorian))
  (transition (from q-longdistance) (answer longdistance-no)  (to q-notry))

  ; 3. q-notry: Do or do not; there is no try
  (transition (from q-notry) (answer notry-continue) (to q-longdistance))

  ; 4. q-midichlorian: What's your midi-chlorian count?
  (transition (from q-midichlorian) (answer midichlorian-what)  (to dest-thisisnot))
  (transition (from q-midichlorian) (answer midichlorian-crazy) (to q-cocky))
  (transition (from q-midichlorian) (answer midichlorian-less)  (to q-destiny))

  ; 5. q-cocky: Great kid, dont't get cocky.
  (transition (from q-cocky) (answer cocky-continue) (to q-searching))

  ; 6. q-searching: Are you serching for something or hiding from something
  (transition (from q-searching) (answer searching-hiding)    (to q-fromwhat))
  (transition (from q-searching) (answer searching-searching) (to q-scavenging))

  ; 6. q-scavenging: Searching or scavenging
  (transition (from q-scavenging) (answer scavenging-scavenging)    (to dest-jakku))
  (transition (from q-scavenging) (answer scavenging-searching)     (to q-foradventure))

  ; 7. q-foradventure: For adventure?
  (transition (from q-foradventure) (answer foradventure-yes) (to q-bluemilk))
  (transition (from q-foradventure) (answer foradventure-adv) (to q-adegen))

  ; 8. q-bluemilk: How do you like your blue milk?
  (transition (from q-bluemilk) (answer bluemilk-warm) (to q-trap))
  (transition (from q-bluemilk) (answer bluemilk-Cold) (to q-tauntaun))

  ; 9. q-trap: It's a trap!
  (transition (from q-trap) (answer trap-continue) (to dest-moncala))
  ; 9. q-tauntaun: Don't forget your tauntaun!
  (transition (from q-tauntaun) (answer tauntaun-continue) (to dest-ilum))

  ; 10. q-adegen: What about Adegen crystals?
  (transition (from q-adegen) (answer adegen-yeah) (to dest-ilum))

  ; 11. q-fromwhat: From what?
  (transition (from q-fromwhat) (answer fromwhat-past)      (to q-whathappened))
  (transition (from q-fromwhat) (answer fromwhat-dontworry) (to dest-jakku))
  (transition (from q-fromwhat) (answer fromwhat-jarjar)    (to q-gungans))
  (transition (from q-fromwhat) (answer fromwhat-slimy)     (to q-lightspeed))

  ; 12. q-lightspeed: Lightspeed!
  (transition (from q-lightspeed) (answer lightspeed-continue) (to dest-endor))

  ; 13. q-gungans: Gungans no liking hot, dry weather.
  (transition (from q-gungans) (answer gungans-continue) (to dest-jakku))

  ; 14. q-whathappened: What happened?
  (transition (from q-whathappened) (answer whathappened-order)   (to q-sithbastard))
  (transition (from q-whathappened) (answer whathappened-remains) (to q-relieved))

  ; 15. q-relieved: ...but weren't you mildly relieved it meant you finally got to fly away?
  (transition (from q-relieved) (answer relieved-yes) (to q-burned))
  (transition (from q-relieved) (answer relieved-no)  (to dest-jakku))

  ; 16. q-burned: Before your house burned down, what was your favorite toy as a kid?
  (transition (from q-burned) (answer burned-Furby)     (to q-glutton))
  (transition (from q-burned) (answer burned-magic)     (to q-future))
  (transition (from q-burned) (answer burned-super)     (to dest-moncala))
  (transition (from q-burned) (answer burned-rc)        (to dest-malastare))
  (transition (from q-burned) (answer burned-chemistry) (to dest-ilum))

  ; 17. q-glutton: Are you a glutton for pain
  (transition (from q-glutton) (answer glutton-yes) (to q-fate))
  (transition (from q-glutton) (answer glutton-no)  (to dest-coruscant))

  ; 18. q-fate: Which fate would you rather be dealt?
  (transition (from q-fate) (answer fate-carbonite) (to q-ilove))
  (transition (from q-fate) (answer fate-digested)  (to dest-jakku))

  ; 19. q-ilove: I love you
  (transition (from q-ilove) (answer ilove-know) (to dest-ilum))

  ; 20. q-future: True or false? Impossible to see, the future is.
  (transition (from q-future) (answer future-true)  (to dest-coruscant))
  (transition (from q-future) (answer future-false) (to dest-ryloth))

  ; 21. q-sithbastard: No vacation can heal that, you Sith bastard
  (transition (from q-sithbastard) (answer sithbastard-order) (to q-no))

  ; 22. q-destiny: What controls your destiny?
  (transition (from q-destiny) (answer destiny-money)      (to q-lovemoney))
  (transition (from q-destiny) (answer destiny-love)       (to q-relationship))
  (transition (from q-destiny) (answer destiny-adrenaline) (to q-deathwish))

  ; 19. q-lovemoney: If money is what you love, then that's what you'll receive
  (transition (from q-lovemoney) (answer lovemoney-continue) (to q-gambling))

  ; 23. q-deathwish: Do you have a death wish?
  (transition (from q-deathwish) (answer deathwish-yes) (to q-howdie))
  (transition (from q-deathwish) (answer deathwish-no)  (to q-drink))

  ; 24. q-howdie: How do you want to die?
  (transition (from q-howdie) (answer howdie-explosion) (to dest-mustafar))
  (transition (from q-howdie) (answer howdie-knife)     (to dest-malastare))

  ; 25. q-drink: Do you drink?
  (transition (from q-drink) (answer drink-bluemilk) (to q-no))
  (transition (from q-drink) (answer drink-yes)      (to q-clubsbars))

  ; 26. q-clubsbars: At clubs or bars?
  (transition (from q-clubsbars) (answer clubsbars-clubs) (to dest-coruscant))
  (transition (from q-clubsbars) (answer clubsbars-bars)  (to q-whatdrink))

  ; 27. q-whatdrink: What are you ordering?
  (transition (from q-whatdrink) (answer whatdrink-knockback) (to dest-jakku))
  (transition (from q-whatdrink) (answer whatdrink-mai)       (to dest-moncala))
  (transition (from q-whatdrink) (answer whatdrink-fireball)  (to dest-mustafar))
  (transition (from q-whatdrink) (answer whatdrink-oaky)      (to dest-endor))

  ; 28. q-no: No
  (transition (from q-no) (answer no-continue) (to dest-naboo))

  ; 29. q-gambling: Are you a gambling type?
  (transition (from q-gambling) (answer gambling-yes) (to q-podracerslava))
  (transition (from q-gambling) (answer gambling-no)  (to q-holding))

  ; 30. q-podracerslava: Podracers or lavaracers?
  (transition (from q-podracerslava) (answer podracerslava-podracers)  (to dest-malastare))
  (transition (from q-podracerslava) (answer podracerslava-lavaracers) (to dest-mustafar))

  ; 31. q-holding: Are you holding?
  (transition (from q-holding) (answer holding-who) (to q-rethink))
  (transition (from q-holding) (answer holding-no)  (to q-drink))

  ; 32. q-rethink: You may want to rethink your life choices.
  (transition (from q-rethink) (answer rethink-jedi) (to dest-malastare))
  (transition (from q-rethink) (answer rethink-mind) (to q-clear))

  ; 33. q-clear: Clear your mind you must. How do you unwind?
  (transition (from q-clear) (answer clear-oil)   (to dest-coruscant))
  (transition (from q-clear) (answer clear-braid) (to dest-endor))
  (transition (from q-clear) (answer clear-music) (to q-whattype))
  (transition (from q-clear) (answer clear-sport) (to q-playwatch))

  ; 34. q-playwatch: Do you play or watch?
  (transition (from q-playwatch) (answer playwatch-watch) (to q-dest-jakku))
  (transition (from q-playwatch) (answer playwatch-play)  (to q-podracerslava))

  ; 35. q-whattype: What type?
  (transition (from q-whattype) (answer whattype-pop)          (to dest-coruscant))
  (transition (from q-whattype) (answer whattype-rock)         (to dest-malastare))
  (transition (from q-whattype) (answer whattype-instrumental) (to q-john))

  ; 36. q-john: John Williams or Danny Elfman
  (transition (from q-john) (answer john-john)  (to dest-endor))
  (transition (from q-john) (answer john-danny) (to dest-coruscant))

  ; 37. q-relationship: Are you in a serious relationship?
  (transition (from q-relationship) (answer relationship-yes) (to q-prisoner))
  (transition (from q-relationship) (answer relationship-no)  (to q-badfeeling))
  (transition (from q-relationship) (answer relationship-idk) (to q-kisssibling))

  ; 38. q-badfeeling: I have a bad feeling about this.
  (transition (from q-badfeeling) (answer badfeeling-continue) (to q-finish))

  ; 39. q-finish: Finish the phrase...
  (transition (from q-finish) (answer finish-suffering) (to dest-ilum))
  (transition (from q-finish) (answer finish-revenge)   (to dest-malastare))

  ; 40. q-kisssibling: Would you kiss your sibling to make them jealous?
  (transition (from q-kisssibling) (answer kisssibling-yes) (to q-regret))
  (transition (from q-kisssibling) (answer kisssibling-no)  (to dest-naboo))

  ; 41. q-regret: You're gonna regret that
  (transition (from q-regret) (answer regret-continue) (to dest-ryloth))

  ; 42. q-prisoner: The love of your life has been taken prisoner...
  (transition (from q-prisoner) (answer prisoner-no)        (to q-firstshot))
  (transition (from q-prisoner) (answer prisoner-detonator) (to q-adventure))

  ; 43. q-adventure: Sound like you're up for an adventure.
  (transition (from q-adventure) (answer adventure-yes)    (to dest-ryloth))
  (transition (from q-adventure) (answer adventure-behind) (to dest-naboo))

  ; 44. q-firstshot: Who shot first?
  (transition (from q-firstshot) (answer firstshot-greedo) (to q-nope))
  (transition (from q-firstshot) (answer firstshot-han)    (to q-wretched))

  ; 45. q-nope: Nope
  (transition (from q-nope) (answer nope-han) (to q-wretched))

  ; 46. q-wretched: Does a "wretched hive of villainy and scum" sound like a good time to you?
  (transition (from q-wretched) (answer wretched-yes) (to dest-malastare))
  (transition (from q-wretched) (answer wretched-no)  (to dest-endor))

  ; -------------------------------------------------------------------------
  ; PUNKT STARTOWY
  ; -------------------------------------------------------------------------
  (current-node (id q-start))
)