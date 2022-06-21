import "../../GameEntity.dart";
import "SBURBClass.dart";
import "../../../SBURBSim.dart";

import "../../../Lands/FeatureTypes/QuestChainFeature.dart";
import "../../../Lands/Reward.dart";
import "../../../Lands/Quest.dart";
class Spy extends SBURBClass {
//I used the Scout.dart as a base for my first class
  @override
  String sauceTitle = "Pedestrian";
  //what sort of quests rewards do I get?
  @override
  double itemWeight = 1.10;
  @override
  double fraymotifWeight = 0.10;
  @override
  double companionWeight = 0.01;

  @override
  List<String> associatedScenes = <String>[
    "Spy I:___ N4IgdghgtgpiBcIDKBjA9gVwC4AICSIANCAGYA2EAbmgE4AqMAHlgiADwBGAfEngCIBRAIoBVAUjrw2Aem446ACxg4kAYQEA5AQH0A8gHUtAJW0aAggFkBOAJYBnHAHM0NsI5wQamMABMcWJVswFBsAB3tQpRoYQhxKexssV0dYplCyWmTYiF8cKAhQ8LccTFwMlAgktDAHMBhKGBocDhgSWmU7GBgwDwdQz1w0Ehw7NFgRmx8YAEcMGDssADp5JU6cdIgUeZwfaoByXE6YKH80HAUqZQgcDMHhyggyOf8FTEcFZcUYAE8btDQANbraJYLDfWJ2DDRWIcbAvRowPa1NC4R5kF6VPIYFAKDG4ALKNSaHQGYymSzWCo9XbNOGjCBAxJBT5KX4kLro65kRJYMjKFqgxoeDilHBpDI0ZLwnAAd1oZD8ATeHwAOmBODQuBquEQQFhPI4YFhdHVWFgaHNdeabI5DTRVNUfIkbNU7AAZGzxNysADawBVIBsUFCtH1YCw+loPgD8ADGmkZgDhDjujoMYDJEenSTAYAakY8EgANKJhAZrMwHPgaCVssgPB2JAwMgkKtBkM0MNYPDh9MgAAMAYAvrF-YHg6GchGo3346XkyANKm+5myNmiHmC8XS7HSBWq5BYH2G2ZuQ02xPO1Oe1g+4OQCOcGP25Pw5GaNG63Oq0u03XzXMVb5oWJYrvuG7VkedYNgA4mgPh0DYjQXh2XY3new6jgGL5Xm+M51gACk8KBAnQgLdPA2hUTgGgACx4I4PjvI4WCOOEABCKB4GYJYcGYNCOAAmjKGiCWY3HTGYACcZAAFYwaoZh8EIjjsVARYCGYHCOEIAgAKy0TKZgwGYbqODYuhIDBjBmDKujCQATMZdDsYwAhkKoqiOHwugoKoUAyoJ7Fum0eBBQoZhQGYkWJGgdgAMxIJYKLTEWMoALR0I4MEAIyOGYAASRiqEWaBmOx-YQAAHDKfG6NMFhYD4ADUBVBd8ZgEUIZiOGAABaALpXYABStEEZASAWLJqgKEx7GSQIZUAt5JYaHgCiqBoABiSB2JQBWOP2BX6XgqhgEgEB0GYaBkGYIi6AAXo43wYBwqhPCISVKW1ZiUFAQi0VglB9boboKOxGBuA9MDDYJBV9YJSDsc14j9owzUwEgw3TH1-WUGQRh6YwINCHYqg5WQSCCRoEDsVtZg5elJD6HwskoP2ZAAOxJT4pk0H5djTNMMFYNMABszVQOxMHNTlfXxVtfCqCIZB8GY1OyUl7E2PJFihGAFgABoObRlDxc1jjDexgkEQ5-Y2AoBVfT+y7-hatYLsB25gWuHsBoeta7gVECNlsdQoa+3a9nW96Ps+l5du+n67t+EG-j766e1uoF1qumf+zWx52EYOS7FAEe4VHt51vF8XDgAulakq2o0Dq+M6rpuqXvqN8QrTsigWB2FttAel6ji+vHqFTknfYWK4QYYCcbrYgCB6F3WM05IaFjfEg+rV1nIE7uWvsV12GhLy0NB9ulOV1w+WHjtPeEfnPaAcDY3JguvUG7lvbgYC733pUIC2cT57jPhBHCF8r7ITrPfTCT5sIJxnvhXcRFV7yHImASi1E6IMSYgoFibEbCcW4rxfiQkRJiQktJOSCklIqTUhpLSOl9KGWMqZcyllrK2XsjKJyMAXJuQ8l5HyfkApBRCmgMK7EIpRRilgOKiVkqizSplbKeVCrFVKuVSqNU6oNSaq1dqnVuq9QGkNUa40ICTWmrNVSC0lorTMGtDa21dr7UOsdPSp1zqXWurde6T0XpvQ+l9PgP0-oAyBiDMGEMoYwzhgjJGKMkBowxljHGeMCZExJmTCmVMaZ0wZkzFmbMObczMLzN0-NVCC2FqLCWUsZZywVkrFWasNZax1jBPWBtjam3Npba2tt7aO2dhBAOfYYKehMoPF0YAwHHz7ABP2z9I6XygNfDCD5e4gH7jAQew9R6lzsD3B8QA",
    "Spy II:___ N4IgdghgtgpiBcIDKBjA9gVwC4AICSeIANCAGYA2EAbmgE4AqMAHlgiADwBGAfEngCIBRAIoBVQUnrx2Aeh456ACxg4kAYUEA5QQH0A8gHVtAJR2aAggFlBAcgDOOLLWoxyDiLRUBzTxCzkATxwIAEsAExgwnE4grGUQ2mC7AAcYFCwiRwgAaxCwL0dlKEc0HGTKFBgHAHdlTxwwUrQwFUUIBxgqGETOGBgwADoFOpUQ9xw7fsmcNFIcauaIxLzCqpVyiEq7TIh5xe7CvxwoNCwQqj8q1dUNbX0jQVMLaxKcbL7knGZyujyvHYccSOY3mbVwIVwsAgYEBpV6wVU6GwAwAOmAuLRuBjuMQQFgPF4YFg9C02E4MHASE4Ql5CbQ1IsISFmnYADLnP5sADawBRIBCUGSdHxYCwBjoYT58D5mhk5j5RBlenoUr5pAgbhgCr5ADVjHgkABpeUINUayba8DQLWmkB4OxIVykS0CoW0EVYPCi1UgAAMfIAvplefzBcLoWKJT7ZSbFSBNMqferNZa9QbjUnzTa45BYD77eZyOds3zXeHRV6sD7-SAgzgQ2X3RHxbRJbaY5aEyrbcmLcRdfqjSbpWQs5bczaR-aAOJoML0ELdF1hpsV722mt1hsrj0ttsjgAK5AwKGyCjQ7zA8B0N5wmgALHgvGEvIovFgvMkQgAhFB4czGpw5i0F4ACa1SaKB5j-gAjuYACc5AAFbTmo5j8MIXjflAhqCOYnBeMIggAKz3tU5gwOYrJeCEehINOTDmNUejgQATBR9DfkwgjkGoahePwegoGoUDVKB36sqQaB4OJijmFA5jyRCaB2AAzEgVinDBhrVAAtPQXjTgAjF45gABLGGohpoOY36+hAAAc1RAXoMGWFgYQANRmeJATmAewjmF4YAAFrZLpdgAFL3gekBIJYSFqIoL7fnBgg2dkAnGpoeCKGomgAGJIHYVBmV4vpmSReBqGASAQPQ5hoOQ5iiHoABeXgBBgnBqMeogaehPnmFQUDCPeWBUCFeisoo34YPkbUwJFoFmSFoFIN+nkSL6TCeTASCRTBIWhVQ5DGMRTBTcIdhqEZ5BIKBmgQN+BXmEZumkAY-BISgvrkAA7BpYRUbQwl2DBMHTlgMEAGyeVA37Tp5RkhapBX8GoojkPw5iPUhGnfiEKGWMkYCWAAGqx95UKpnleJF36gQerG+iEihmQNnaJra5IliAaZDpmKb9laea2mZ7SoP0fONh6lbVoGwaljuzZRu2cpc92I69nzAsZj2Y4ixO+Z2MY0JhGgUDLm6cvriOMMw4GAC6uLUrS3QMmAYRMiyrLm9yLskDApCkGkWB2AVdDslQnKIDyys26rrY+pYeQChgxSsie2TjtaPpJdChKWAESD4lWIt68OZrC3GssRpoGe9LQPq6UZqmbkroaJ6Ke4p2gnAhEWWABLnYsjgX+QwMXpd+Kmg769rhu1yrooN1ATc+m3Hf1gn5aRsntpHtn56Xtet4Pk+L5vh+X6-v+gHAWBEFQbBCHIah6GYdhuH4YRJFkRRKiNE6IMSYixao7EYCcW4rxfiglhKiXEpJaSsl5KKSgMpNSGlLBaR0vpQyJlzKWWsrZeyTkXJuQ8t5Xy-lArBTChFaKsUIDxUSslLCaUMpZXMDlPKhViqlXKpVYi1Var1Uas1VqHUuo9T6gNfgQ0RpjQmlNGac0FpLRWmtDaW0kA7T2gdI6J0zoXSujdO6D0novTeh9L6P0-qA3MMDVkoM1Dg0htDOGCMkYozRhjLGOM8YEyJtOEmZNKbU1pvTRmzNWbs05kbPOtppzFnMOkZkYA57pirniWgFJrZ7zXhvDcztcTB1DukCOUdzZ2ADrWIAA"
  ];
  @override
  List<AssociatedStat> stats = new List<AssociatedStat>.unmodifiable(<AssociatedStat>[
    new AssociatedStat(Stats.MAX_LUCK, 2.0, false),
    new AssociatedStat(Stats.ALCHEMY, 2.1, false),
    new AssociatedStat(Stats.MOBILITY, 1.3, false)
  ]);
  //difficulty of class + aspect results in odds of getting yaldobooger/abraxus equivlent.
  //.5 is normal. .5 + .5 = 1.0, equals 5% chance of  getting either (>95 or < 5)
  @override
  double difficulty = 0.9;
  @override
  String name = "Spy";
  //based on strength of association.
  @override
  Map<Theme, double> themes = new Map<Theme, double>();
  @override
  String savedName;  //for AB restoring an aspects name after a hope player fucks it up
  @override
  FAQFile faqFile;
  @override
  int id = 21; //for classNameToInt
  @override
  bool isCanon = false; //you gotta earn canon, baby.
  @override
  bool isInternal = false; //if you're an internal aspect or class you shouldn't show up in lists.

  Spy(int id) : super(id, "Spy", 21, isCanon: false);
  //i am thinking guides will give other players their own aspects (and not the guides) while scouts will gain whoever they are with's aspect.
  @override
  List<String> levels = ["MIMIC LORD", "BACKSTAB KING", "SAPPING FATHER"];
  @override
  List<String> quests = ["Sneaking in areas no Consort has dared to trespass in", "Discovering hidden information that is covered from the naked-eye.", "Playing pretend with their enemies."];
  @override
  List<String> postDenizenQuests = ["Obtaining information from Consorts to help their allies.", "Finding new unclaimed items to improve their disguises not guarded by the Denizen.", "Fulling their new duties as spy after the Denizen's defeat."];
  @override
  List<String> handles = ["secret", "spook", "strategic", "scramble", "special", "sensor", "sleuth"];

  @override
  bool isProtective = false;
  @override
  bool isSmart = true;
  @override
  bool isSneaky = true;
  @override
  bool isMagical = false;
  @override
  bool isDestructive = false;
  @override
  bool isHelpful = false;

  @override
  bool highHinit() {
    return false;
  }

  @override
  void initializeItems() {
    items = new WeightedList<Item>()
      ..add(new Item("Butterfly Knife",<ItemTrait>[ItemTraitFactory.METAL, ItemTraitFactory.CLASSRELATED, ItemTraitFactory.KNIFE],shogunDesc: "A Foldable Butterfly Knife",abDesc:"A classic default weapon; useful for hitting people's backs."))
      ..add(new Item("Cloaking Watch",<ItemTrait>[ItemTraitFactory.METAL, ItemTraitFactory.CLASSRELATED, ItemTraitFactory.SMART, ItemTraitFactory.OBSCURING],shogunDesc: "Invisibility Watch",abDesc:"Does what it says, it hides you from enemies."))
      ..add(new Item("Disguise Kit",<ItemTrait>[ItemTraitFactory.PLASTIC, ItemTraitFactory.CLASSRELATED, ItemTraitFactory.OBSCURING, ItemTraitFactory.FASHIONABLE],shogunDesc: "A Makeup Box",abDesc:"Spies have potential to be an actor/actress or a cosplayer i guess..."))
      ..add(new Item("Sapper",<ItemTrait>[ItemTraitFactory.METAL, ItemTraitFactory.RESTRAINING, ItemTraitFactory.ROBOTIC2, ItemTraitFactory.CLASSRELATED],shogunDesc: "How2DestroyRobots",abDesc:"Every machines' worse nightmare."));
  }


  @override
  bool isActive([double multiplier = 0.0]) {
    return true;
  }
  @override
  double getAttackerModifier() {
    return 1.5;
  }

  @override
  void initializeThemes() {
    /*
        new Quest(" "),
        new Quest(""),
        new Quest(" ")

        */
    addTheme(new Theme(<String>["Money","Items", "Stealing"])
      ..addFeature(FeatureFactory.JAZZSOUND, Feature.HIGH)
      ..addFeature(FeatureFactory.ENERGIZINGFEELING, Feature.WAY_LOW)
      ..addFeature(FeatureFactory.LAUGHINGSOUND, Feature.WAY_LOW)
      ..addFeature(FeatureFactory.DECEITSMELL, Feature.WAY_LOW)
      ..addFeature(new PreDenizenQuestChain("Mind If I Have That?", [
        new Quest("The ${Quest.PLAYER1} has noticed something interesting that ${Quest.CONSORT} was holding. Is that a safe? How can ${Quest.CONSORT}s carry safes goes through ${Quest.PLAYER1}'s mind. Regardless, that safe is going to be yours today."),
        new Quest("The ${Quest.PLAYER1} threads behind the rich ${Quest.CONSORT} and it seems to go inside a ${Quest.MCGUFFIN} bar. This may be their chance!"),
        new Quest("Finishing their disguise, the ${Quest.PLAYER1} acts a bartender and kept a close eye on the rich ${Quest.CONSORT}. This is getting harder than you thought. Until! There was a bar fight! Many ${Quest.CONSORT}s begin ${Quest.CONSORTSOUND}ing. With the rich ${Quest.CONSORT} distracted. You take the prize and made a mad dash in the mist of confusion. You opened up the safe and JACKPOT!")
      ], new RandomReward(), QuestChainFeature.defaultOption), Feature.WAY_LOW)

        addTheme(new Theme(<String>["Suitcase","Secure", "Information"])
      ..addFeature(FeatureFactory.JAZZSOUND, Feature.MEDIUM)
      ..addFeature(FeatureFactory.OAKYSMELL, Feature.HIGH)
      ..addFeature(FeatureFactory.FOOTSTEPSOUND, Feature.LOW)
      ..addFeature(FeatureFactory.ECHOSOUND, Feature.LOW)
      ..addFeature(new DenizenQuestChain("Secure the briefcase!", [
        new Quest("From an anonymous source, the ${Quest.PLAYER1} notices that the ${Quest.DENIZEN} is endangering the valuable suitcase belonging to the higher ${Quest.CONSORT}s! Their mission is the secure the suitcase from any harm."),
        new Quest("It seems that the ${Quest.DENIZEN} is smarter than the ${Quest.PLAYER1} anticipated. It seems that the location that the anon gave them leads to a group of underlings guarding something! Time to strife them with the way you know how."),
        new Quest("After taking out the underlings. The ${Quest.PLAYER1} hears from the anonymous source, that the suitcase is nearby! And the ${Quest.PHYSICALMCGUFFIN} that they have is the key!"),
        new DenizenFightQuest("${Quest.PLAYER1} follows the infomation and finds the ${Quest.DENIZEN} with the suitcase! Originally, they suppose to have allies, but ${Quest.PLAYER1} already took care of them. It's a 1v1!", "The ${Quest.CONSORTSOUND}ing was heard from behind of ${Quest.PLAYER1}. It's the anonymous source! They congrats ${Quest.PLAYER1} for being quick with mission to safety return the suitcase to them. When asking for the reward, the ${Quest.CONSORT} says that the real reward is from the denizen.", "Whep, the ${Quest.DENIZEN} just kicked your ass. You need to advise a different plan if you want that suitcase.")
       ], new DenizenReward(), QuestChainFeature.defaultOption), Feature.MEDIUM)


    addTheme(new Theme(<String>["Files","Hacking", "Secret", "Information","Spying"])
      ..addFeature(FeatureFactory.JAZZSOUND, Feature.HIGH)
      ..addFeature(FeatureFactory.ENERGIZINGFEELING, Feature.WAY_LOW)
      ..addFeature(FeatureFactory.RUSTLINGSOUND, Feature.LOW)
      ..addFeature(FeatureFactory.SKETCHYFEELING, Feature.WAY_HIGH)
      ..addFeature(FeatureFactory.CALMFEELING, Feature.MEDIUM)
      ..addFeature(FeatureFactory.OAKYSMELL, Feature.HIGH)
      ..addFeature(new PostDenizenQuestChain("File Gathering", [
        new Quest("At last, the ${Quest.DENIZEN}, has been killed and loads of information from the denizen has scattered across the planet. The ${Quest.PLAYER1} tucking their outfit, strives to obtain the lost files. "),
        new Quest("The ${Quest.PLAYER1} (disguised as a ${Quest.CONSORT}) talks to a ${Quest.CONSORT}. The ${Quest.CONSORT} ${Quest.CONSORTSOUND}s about that the all of the info dropped from the denizen is locked behind a long protection codes. It seems that it's the ${Quest.DENIZEN} final challenge to the ${Quest.PLAYER1}."),
        new Quest("The ${Quest.PLAYER1} spies on the ${Quest.CONSORT}'s Warehouse to pair to sense their patterns and distracts them using ${Quest.MCGUFFIN} ${Quest.WEAPON}! Taking the chance to sneak in the ${Quest.CONSORT}'s Warehouse, the ${Quest.PLAYER1} puts their hacking skills to the test. And they succeeded! Finally, all of the info is now theirs. The ${Quest.PLAYER1} now understands what it means to be a spy.  ")
      ], new BoonieFraymotifReward(), QuestChainFeature.defaultOption), Feature.LOW)

    //space player near guaranteed to do this.
      ..addFeature(new PostDenizenFrogChain("Find the Frogs", [
        new Quest("The ${Quest.DENIZEN} has released the frogs from their vine tangled prisons. The land gets just a little bit less wild. The ${Quest.PLAYER1} is given a map to where all the frogs are and is told to get going. "),
        new Quest("The ${Quest.PLAYER1} is following a detailed guide on which frogs to combine with which other frogs. It's a little boring, but at least the ${Quest.PLAYER1} knows they won't make a mistake."),
        new Quest("Following the last step in the guide booke, the ${Quest.PLAYER1} finds the Final Frog. Luckily, a ${Quest.CONSORT} ${Quest.CONSORTSOUND}s in time to stop them.   "),
      ], new FrogReward(), QuestChainFeature.spacePlayer), Feature.WAY_HIGH)

        ,  Theme.MEDIUM);
  }



}
