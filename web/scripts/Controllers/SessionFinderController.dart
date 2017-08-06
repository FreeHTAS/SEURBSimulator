import '../SBURBSim.dart';
import '../navbar.dart';
import 'dart:html';
import 'dart:async';
import 'dart:typed_data';
import 'dart:collection';

//replaces the poorly named scenario_controller2.js
/*
  AB seems to treat sessions normally UNTIL they end. though I WILL override start session to avoid
  AB rewriting the page title.
 */
Random rand;
SessionFinderController self; //want to access myself as more than just a sim controller occasionally
void main() {
  doNotRender = true;
  loadNavbar();
  window.onError.listen((Event event){
    ErrorEvent e = event as ErrorEvent;
    //String msg, String url, lineNo, columnNo, error
    printCorruptionMessage(e);//(e.message, e.path.toString(), e.lineno.toString(), e.colno.toString(), e.toString());
    return;
  });
  new SessionFinderController();
  self = SimController.instance;
  self.percentBullshit();

  if(getParameterByName("seed",null) != null){
    self.initial_seed = int.parse(getParameterByName("seed",null));
  }else{
    var tmp = getRandomSeed();
    self.initial_seed = tmp;
  }
  self.formInit();
}

void checkSessions() {
  self.checkSessions();
}

void filterSessionSummaries() {
  self.filterSessionSummaries();
}


//todo remove these if it turns out i can onclick to instance method
void toggleCorpse(){
  self.toggleCorpse();
}



void toggleRomance(){
  self.toggleRomance();
}



void toggleDrama(){
  self.toggleDrama();
}



void toggleMisc(){
  self.toggleMisc();
}



void toggleEnding(){
  self.toggleEnding();
}



void toggleAverage(){
  self.toggleAverage();
}




class SessionFinderController extends SimController { //works exactly like Sim unless otherwise specified.
  List<int> sessionsSimulated = [];

  List<SessionSummary> allSessionsSummaries = [];
  //how filtering works
  List<SessionSummary> sessionSummariesDisplayed = [];

  int numSimulationsDone = 0;
  int numSimulationsToDo = 0;
  bool needToScratch = false;
  bool displayRomance = true;
  bool displayEnding = true;
  bool displayDrama = true;
  bool displayCorpse = false;
  bool displayMisc = true;
  bool displayAverages = true;
  bool displayClasses = false;
  bool displayAspects = false;
  bool tournamentMode = false;
  SessionFinderController() : super();

  void checkSessions() {
    numSimulationsDone = 0; //but don't reset stats
    sessionSummariesDisplayed = [];
    for(num i = 0; i<allSessionsSummaries.length; i++){
      sessionSummariesDisplayed.add(allSessionsSummaries[i]);
    }
    querySelector("#story").setInnerHtml("");
    numSimulationsToDo = int.parse((querySelector("#num_sessions")as InputElement).value);
    (querySelector("#button")as ButtonElement).disabled =true;
    startSession(); //my callback is what will be different
  }

  void toggleCorpse() {
    toggle(querySelector('#multiSessionSummaryCorpseParty'));
    displayCorpse = !displayCorpse;
    if(displayCorpse){
      (querySelector("#avatar") as ImageElement).src = "images/corpse_party_robot_author.png";
    }else{
      (querySelector("#avatar") as ImageElement).src ="images/robot_author.png";
    }
  }

  void filterSessionSummaries() {
    print("attempting to filter");
    List<SessionSummary> tmp = [];
    List<String> filters = [];
    sessionSummariesDisplayed = [] ;//can filter already filtered arrays.;
    for(num i = 0; i<allSessionsSummaries.length; i++){
      sessionSummariesDisplayed.add(allSessionsSummaries[i]);
    }
    List<Element> filterCheckBoxes = querySelectorAll("input[name='filter']:checked");
    print("debugging ab: I think i have found this many checked boxes: ${filterCheckBoxes.length}");
    for(CheckboxInputElement c in filterCheckBoxes) {
      filters.add(c.value);
    }
    print("debugging ab: I think i have found this manyfilters: ${filters.length}");
    for(int i = 0; i<sessionSummariesDisplayed.length; i++){
      SessionSummary ss = sessionSummariesDisplayed[i];
      if(ss.satifies_filter_array(filters)){
        tmp.add(ss);
      }
    }

    List<String> classes = [];
    List<String> aspects = [];


    List<Element> filterAspects = querySelectorAll("input[name='filterAspect']:checked");
    for(CheckboxInputElement c in filterAspects) {
       aspects.add(c.value);
    }

    List<Element> filterClasses = querySelectorAll("input[name='filterClass']:checked");
    for(CheckboxInputElement c in filterClasses) {
      classes.add(c.value);
    }

    tmp = removeNonMatchingClasspects(tmp,classes,aspects);


    ////print(tmp);
    sessionSummariesDisplayed = tmp;
    print("debugging ab: I think i have this many session summaries: ${sessionSummariesDisplayed.length}");
    printSummaries();
    printStats(filters,classes, aspects);

  }

  void printSummaries(){
    querySelector("#debug").setInnerHtml("");
    for(num i = 0; i<sessionSummariesDisplayed.length; i++){
      var ssd = sessionSummariesDisplayed[i];
      var str = ssd.generateHTML();
      debug("<br><hr><font color = 'red'> AB: " + getQuipAboutSession(ssd) + "</font><Br>" );
      debug(str);
    }
  }

  List<SessionSummary> removeNonMatchingClasspects(List<SessionSummary> tmp, List<String> classes, List<String> aspects) {
    List<SessionSummary> toRemove = [];
    for(num i = 0; i<tmp.length; i++){
      var ss = tmp[i];
      if(!ss.matchesClasspect(classes, aspects)){ //if no classes or aspects, thenexpect to return true
        toRemove.add(ss);
      }
    }

    for(num i = 0; i<toRemove.length; i++){
      removeFromArray(toRemove[i],tmp);
    }
    print("debugging ab: I think i have found this summaries after removing non matching claspects: ${tmp.length}");

    return tmp;
  }

  void toggleAverage() {
    toggle(querySelector('#multiSessionSummaryAverage'));
    displayAverages = !displayAverages;
  }

  void toggleEnding() {
    toggle(querySelector('#multiSessionSummaryEnding'));
    displayEnding = !displayEnding;
  }

  void toggleMisc() {
    toggle(querySelector('#multiSessionSummaryMisc'));
    displayMisc = !displayMisc;
  }

  void toggleDrama() {
    toggle(querySelector('#multiSessionSummaryDrama'));
    displayDrama = !displayDrama;
  }

  void toggleRomance() {
    toggle(querySelector('#multiSessionSummaryRomance'));
    displayRomance = !displayRomance;
  }

  void percentBullshit(){
    double pr = 90+(new Random().nextDouble())*10; //this is not consuming randomness. what to do?
    querySelector("#percentBullshit").setInnerHtml("$pr%");
  }

  void formInit(){
    querySelector("#button").onClick.listen((e) => checkSessions());
    (querySelector("#button")as ButtonElement).disabled =false;
    (querySelector("#num_sessions_text")as InputElement).value =(querySelector("#num_sessions")as InputElement).value;

    querySelector("#num_sessions").onChange.listen((Event e) {
      (querySelector("#num_sessions_text")as InputElement).value =(querySelector("#num_sessions")as InputElement).value;
    });
  }


  @override
  void checkSGRUB() {
    throw "ab does not do this";
  }


  @override
  void easterEggCallBack() {
    //only diff from story is don't check SGRUB
    initializePlayers(curSessionGlobalVar.players,curSessionGlobalVar); //need to redo it here because all other versions are in case customizations
    if(doNotRender == true){
      intro();
    }else{
      load(curSessionGlobalVar.players, getGuardiansForPlayers(curSessionGlobalVar.players),""); //in loading.js
    }
  }

  @override
  void easterEggCallBackRestart() {
    initializePlayers(curSessionGlobalVar.players,curSessionGlobalVar); //need to redo it here because all other versions are in case customizations
    intro();
  }


  @override
  void processCombinedSession() {
    print("Debugging AB: Checking process combo session");
    Session newcurSessionGlobalVar = curSessionGlobalVar.initializeCombinedSession();
    if(newcurSessionGlobalVar != null){
      print("debugging AB: doing a combo session");
      curSessionGlobalVar = newcurSessionGlobalVar;
      appendHtml(querySelector("#story"),"<br><Br> But things aren't over, yet. The survivors manage to contact the players in the universe they created. Time has no meaning between universes, and they are given ample time to plan an escape from their own Game Over. They will travel to the new universe, and register as players there for session " + curSessionGlobalVar.session_id.toString() + ". ");
      intro();
    }else{
      print("Debugging AB: can't combo, can't scratch. just do next session.");
      needToScratch = false; //can't scratch if skaiai is a frog
      curSessionGlobalVar.makeCombinedSession = false;
      summarizeSession(curSessionGlobalVar);
    }
  }

  //AB's reckoning is like the normal one, but if the session ends at the recknoing, ab knows what to do.
  @override
  void reckoning() {
    Scene s = new Reckoning(curSessionGlobalVar);
    s.trigger(curSessionGlobalVar.players);
    s.renderContent(curSessionGlobalVar.newScene());
    if(!curSessionGlobalVar.doomedTimeline){
      print("debugging AB: reckoning tick for ${curSessionGlobalVar.session_id}");
      reckoningTick();
      return null;
    }else{
      print("debugging AB: no reckoning, doomed timeline for ${curSessionGlobalVar.session_id}");
      if(needToScratch){
        print("debugging AB: scratch ${curSessionGlobalVar.session_id}");
        scratchAB(curSessionGlobalVar);
        return null;
      }
      print("debugging AB: no scratch ${curSessionGlobalVar.session_id}");
      ////print("doomed timeline prevents reckoning");
      List<Player> living = findLivingPlayers(curSessionGlobalVar.players);
      if(curSessionGlobalVar.scratched || living.length == 0){ //can't scrach so only way to keep going.
        //print("doomed scratched timeline");
        summarizeSession(curSessionGlobalVar);
        return null;
      }

    }
    print("debugging AB: should never get here from reckoning, should either tick or ${curSessionGlobalVar.session_id}");
  }

  @override
    void reckoningTick() {
    print("Debugging AB: reckoning tick in session:  ${curSessionGlobalVar.session_id}");
    //print("Reckoning Tick: " + curSessionGlobalVar.timeTillReckoning);
    if(curSessionGlobalVar.timeTillReckoning > -10){
      curSessionGlobalVar.timeTillReckoning += -1;
      curSessionGlobalVar.processReckoning(curSessionGlobalVar.players);
      new Timer(new Duration(milliseconds: 10), () => reckoningTick()); //sweet sweet async
      return null;
    }else{
      print("Debugging AB: Aftermath in session:  ${curSessionGlobalVar.session_id}");
      Scene s = new Aftermath(curSessionGlobalVar);
      print("Debugging AB:made aftermath session:  ${curSessionGlobalVar.session_id}");

      s.trigger(curSessionGlobalVar.players);
      print("Debugging AB: triggered Aftermath in session:  ${curSessionGlobalVar.session_id}");

      s.renderContent(curSessionGlobalVar.newScene());
      print("Debugging AB: done with Aftermath in session:  ${curSessionGlobalVar.session_id}");
      if(curSessionGlobalVar.makeCombinedSession == true){
        print("Debugging AB: going to check for combo in session: ${curSessionGlobalVar.session_id}");
        processCombinedSession();  //make sure everything is done rendering first
        return null;
      }else{
        print("Debugging AB: not a combo in session:  ${curSessionGlobalVar.session_id}");
        if(needToScratch){
          print("Debugging AB: going to scratch in session: curSessionGlobalVar.session_id");
          scratchAB(curSessionGlobalVar);
          return null;
        }
        List<Player> living = findLivingPlayers(curSessionGlobalVar.players);
        print("debugging AB: about to see if i should summarize session ${curSessionGlobalVar.session_id}");
        if(curSessionGlobalVar.won || living.length == 0 || curSessionGlobalVar.scratched){
          print("debugging AB: victory or utter defeat in session session ${curSessionGlobalVar.session_id}");
          summarizeSession(curSessionGlobalVar);
          return null;
        }else {
          print("debugging AB: I think i should not summarize session ${curSessionGlobalVar.session_id}, won is ${curSessionGlobalVar.won} living is ${living.length} and scratched is ${curSessionGlobalVar.scratched}");
          return null;
        }
      }
    }

    print("Debugging AB: should neever get here, should be combo or scratch or victory or SOMEThing.");
  }


  void scratchAB(Session session) {
    needToScratch = false;
    //treat myself as a different session that scratched one?
    List<Player> living = findLivingPlayers(session.players);
    if(!session.scratched && living.length > 0 && !tournamentMode){
      //print("scartch");
      //alert("AB sure loves scratching!");
      session.scratchAvailable = true;
      summarizeSessionNoFollowup(session);
      scratch(); //not user input, just straight up do it.
    }else{
      //print("no scratch");
      session.scratchAvailable = false;
      summarizeSession(session);
    }

  }

  //stripped out tournament stuff, that'll be a different controller.
  void summarizeSession(Session session) {
    print("Debugging AB: Summarizing session ${session.session_id}");
    //print("summarizing: " + curSessionGlobalVar.session_id + " please ignore: " +curSessionGlobalVar.pleaseIgnoreThisSessionAB);
    //don't summarize the same session multiple times. can happen if scratch happens in reckoning, both point here.
    if(sessionsSimulated.indexOf(session.session_id) != -1 && !session.scratched){ //scratches are allowed to be repeats
      print("Debugging AB: should be skipping a repeat session: " + curSessionGlobalVar.session_id.toString());
      return;
    }
    sessionsSimulated.add(curSessionGlobalVar.session_id);

    SessionSummary sum = curSessionGlobalVar.generateSummary();
    querySelector("#story").setInnerHtml("");
    allSessionsSummaries.add(sum);
    sessionSummariesDisplayed.add(sum);
    //printSummaries();  //this slows things down too much. don't erase and reprint every time.
    var str = sum.generateHTML();
    debug("<br><hr><font color = 'red'> AB: " + getQuipAboutSession(sum) + "</font><Br>" );
    debug(str);
    printStats(null,null,null); //no filters here
    numSimulationsDone ++;
    initial_seed = curSessionGlobalVar.rand.nextInt(); //child session
    print("num sim done is $numSimulationsDone vs todo of $numSimulationsToDo");
    if(numSimulationsDone >= numSimulationsToDo){
      (querySelector("#button")as ButtonElement).disabled =false;
      print("Debugging AB: I think I am done now");
      window.alert("Notice: should be ready to check more sessions.");
      List<Element> filters = querySelectorAll("input[name='filter']");
      for(CheckboxInputElement e in filters) {
          e.disabled = false;
      }
    }else{
        print("Debugging AB: going to start new session");
        new Timer(new Duration(milliseconds: 10), () => startSession()); //sweet sweet async
    }
    print("Debugging AB: done summarizing session ${curSessionGlobalVar.session_id}");

  }

  String getQuipAboutSession(SessionSummary sessionSummary) {
    String quip = "";
    num living = sessionSummary.getNumStat("numLiving");
    num dead = sessionSummary.getNumStat("numDead");
    Player strongest = sessionSummary.mvp;

    if(sessionSummary.session_id == 33 || getParameterByName("nepeta","")  == ":33"){
      quip += "Don't expect any of my reports on those cat trolls to be accurate. They are random as fuck. " ;
    }

    if(sessionSummary.getBoolStat("crashedFromSessionBug")){
      quip += Zalgo.generate("Fuck. Shit crashed hardcore. It's a good thing I'm a flawless robot, or I'd have nightmares from that. Just. Fuck session crashes.  Also, shout out to star.eyes: 'His palms are sweaty, knees weak, arms are heavy. There's vomit on his sweater already, mom's spaghetti'");
    }else if(sessionSummary.getBoolStat("crashedFromPlayerActions")){
      quip += Zalgo.generate("Fuck. God damn. Do Grim Dark players even KNOW how much it sucks to crash? Assholes.");
    }else if(sessionSummary.frogStatus == "Purple Frog" && sessionSummary.getBoolStat("blackKingDead")){
      quip += "Oh my fucking god is THAT what the Grim Dark players have been trying to do. Are organics really so dumb as to not realize how very little that benefits them?";
    }else if(!sessionSummary.scratched && dead == 0 && sessionSummary.frogStatus == "Full Frog" && sessionSummary.getBoolStat("ectoBiologyStarted") && !sessionSummary.getBoolStat("crashedFromCorruption") && !sessionSummary.getBoolStat("crashedFromPlayerActions")){
      quip += "Everything went better than expected." ; //???
    }else if(sessionSummary.getBoolStat("yellowYard") == true){
      quip += "Fuck. I better go grab JR. They'll want to see this. " ;
    }else if(living == 0){
      quip += "Shit, you do not even want to KNOW how everybody died." ;
    }else  if(strongest.getStat("power") > 3000){
      //alert([!sessionSummary.scratched,dead == 0,sessionSummary.frogStatus == "Full Frog",sessionSummary.ectoBiologyStarted,!sessionSummary.crashedFromCorruption,!sessionSummary.crashedFromPlayerActions ].join(","))
      quip += "Holy Shit, do you SEE the " + strongest.titleBasic() + "!?  How even strong ARE they?" ;
    }else if(sessionSummary.frogStatus == "No Frog" ){
      quip += "Man, why is it always the frogs? " ;
      if(sessionSummary.parentSession != null){
        quip += " You'd think what with it being a combo session, they would have gotten the frog figured out. ";
      }
    }else  if(sessionSummary.parentSession != null){
      quip += "Combo sessions are always so cool. " ;
    }else  if(sessionSummary.getBoolStat("jackRampage")){
      quip += "Jack REALLY gave them trouble." ;
    }else  if(sessionSummary.getNumStat("num_scenes") > 200){
      quip += "God, this session just would not END." ;
      if(sessionSummary.parentSession == null){
        quip += " It didn't even have the excuse of being a combo session. ";
      }
    }else  if(sessionSummary.getBoolStat("murderMode")){
      quip += "It always sucks when the players start trying to kill each other." ;
    }else  if(sessionSummary.getNumStat("num_scenes") < 50){
      quip += "Holy shit, were they even in the session an entire hour?" ;
    }else  if(sessionSummary.getBoolStat("scratchAvailable") == true){
      quip += "Maybe the scratch would fix things? Now that JR has upgraded me, I guess I'll go find out." ;
    }else{
      quip += "It was slightly less boring than calculating pi." ;
    }

    if(sessionSummary.getBoolStat("threeTimesSessionCombo")){
      quip+= " Holy shit, 3x SessionCombo!!!";
    }else if(sessionSummary.getBoolStat("fourTimesSessionCombo")){
      quip+= " Holy shit, 4x SessionCombo!!!!";
    }else if(sessionSummary.getBoolStat("fiveTimesSessionCombo")){
      quip+= " Holy shit, 5x SessionCombo!!!!!";
    }else if(sessionSummary.getBoolStat("holyShitMmmmmonsterCombo")){
      quip+= " Holy fuck, what is even HAPPENING here!?";
    }
    return quip;
  }

  //none can be inline anymore
  void wireUpAllCheckBoxesAndButtons() {
    wireUpAllFilters();
    wireUpAllButtons();
  }

  void wireUpAllFilters() {
    //except for corpse party apparently
    List<Element> allFilters = querySelectorAll("input[name='filter']");
    print("debugging AB: wiring up ${allFilters.length} filters");
    for(CheckboxInputElement e in allFilters) {
      e.onChange.listen((e) => filterSessionSummaries());
    }


    List<Element> classFilters = querySelectorAll("input[name='filterClass']");
    print("debugging AB: wiring up class ${classFilters.length} filters");
    for(CheckboxInputElement e in classFilters) {
      e.onChange.listen((e) => filterSessionSummaries());
    }

    List<Element> aspectFilters = querySelectorAll("input[name='filterAspect']");
    print("debugging AB: wiring up aspect ${aspectFilters.length} filters");
    for(CheckboxInputElement e in aspectFilters) {
      e.onChange.listen((e) => filterSessionSummaries());
    }
  }


  //can't be in session summary cuz needs globals only found here, or instance methods only found here.
  void wireUpAllButtons() {
    if(querySelector("#corpseButton") != null) querySelector("#corpseButton").onClick.listen((e) => toggleCorpse());
    if(querySelector("#romanceButton") != null) querySelector("#romanceButton").onClick.listen((e) => toggleRomance());
    if(querySelector("#dramaButton") != null) querySelector("#dramaButton").onClick.listen((e) => toggleDrama());
    if(querySelector("#miscButton") != null) querySelector("#miscButton").onClick.listen((e) => toggleMisc());
    if(querySelector("#endingButton") != null) querySelector("#endingButton").onClick.listen((e) => toggleEnding());
    if(querySelector("#averageButton") != null) querySelector("#averageButton").onClick.listen((e) => toggleAverage());
  }

  void printStats(List<String> filters, List<String> classes, List<String> aspects) {
    MultiSessionSummary mms;
    if(sessionSummariesDisplayed.isEmpty) {
      mms = new MultiSessionSummary(); //don't try to collate nothing, wont' fail gracefully like javascript did
    }else {
      mms = MultiSessionSummary.collateMultipleSessionSummaries(sessionSummariesDisplayed);
    }

    print("MMS is: ${mms.num_stats}");
    querySelector("#stats").setInnerHtml(mms.generateHTML());
    mms.wireUpCorpsePartyCheckBoxes();
    wireUpAllCheckBoxesAndButtons();

    if(displayMisc) show(querySelector('#multiSessionSummaryMisc'));  //memory. don't always turn off when making new ones.
    if(!displayMisc) hide(querySelector('#multiSessionSummaryMisc'));

    if(displayRomance) show(querySelector('#multiSessionSummaryRomance'));  //memory. don't always turn off when making new ones.
    if(!displayRomance)hide(querySelector('#multiSessionSummaryRomance'));

    if(displayDrama) show(querySelector('#multiSessionSummaryDrama'));  //memory. don't always turn off when making new ones.
    if(!displayDrama)hide(querySelector('#multiSessionSummaryDrama'));

    if(displayEnding) show(querySelector('#multiSessionSummaryEnding'));  //memory. don't always turn off when making new ones.
    if(!displayEnding)hide(querySelector('#multiSessionSummaryEnding'));

    if(displayAverages)show(querySelector('#multiSessionSummaryAverage'));  //memory. don't always turn off when making new ones.
    if(!displayAverages)hide(querySelector('#multiSessionSummaryAverage'));

    if(displayCorpse) show(querySelector('#multiSessionSummaryCorpseParty')); //memory. don't always turn off when making new ones.
    if(!displayCorpse)hide(querySelector('#multiSessionSummaryCorpseParty'));

    if(filters != null){
      List<Element> allFilters = querySelectorAll("input[name='filter']");
      for(CheckboxInputElement e in allFilters) {
        e.disabled = false;
        if(filters.indexOf(e.value) != -1){
          e.checked = true;
        }else{
          e.checked = false;
        }
      }
    }

    if(classes != null && aspects != null){
      List<Element> filterClass = querySelectorAll("input[name='filterClass']");
      for(CheckboxInputElement e in filterClass) {
        e.disabled = false;
        if(classes.indexOf(e.value) != -1){
          e.checked = true;
        }else{
          e.checked = false;
        }

      }

      List<Element> filterAspect = querySelectorAll("input[name='filterAspect']");
      for(CheckboxInputElement e in filterAspect) {
        e.disabled = false;
        if(aspects.indexOf(e.value) != -1){
          e.checked = true;
        }else{
          e.checked = false;
        }

      }

    }

  }

  void summarizeSessionNoFollowup(Session session) {
    //print("no timeout summarizing: " + curSessionGlobalVar.session_id);
    //don't summarize the same session multiple times. can happen if scratch happens in reckoning, both point here.
    if(sessionsSimulated.indexOf(session.session_id) != -1){
      ////print("should be skipping a repeat session: " + curSessionGlobalVar.session_id);
      return;
    }
    sessionsSimulated.add(curSessionGlobalVar.session_id);
    querySelector("#story").setInnerHtml("");
    var sum = curSessionGlobalVar.generateSummary();
    allSessionsSummaries.add(sum);
    sessionSummariesDisplayed.add(sum);
    //printSummaries();  //this slows things down too much. don't erase and reprint every time.
    var str = sum.generateHTML();
    debug("<br><hr><font color = 'red'> AB: " + getQuipAboutSession(sum) + "</font><Br>" );
    debug(str);
    printStats(null, null, null); //not filtering anything

  }



  @override
  void recoverFromCorruption() {
    print("AB thinks she should check a new session after finding a shitty crashed session");
    summarizeSession(curSessionGlobalVar); //well...THAT session ended
  }


  @override
  void renderScratchButton(Session session) {
    needToScratch = true;
  }

  @override
  void restartSession() {
    querySelector("#story").setInnerHtml('');
    window.scrollTo(0, 0);
    checkEasterEgg(easterEggCallBackRestart,null);
  }

  @override
  void shareableURL() {
    throw "AB doesn't do this";
  }


}