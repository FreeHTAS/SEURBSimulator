import "../../../SBURBSim.dart";
import 'dart:html';

//has no sub form, just exists
class TargetIsAlive extends TargetConditionLiving {
    @override
    String name = "IsAlive";

    Item crown;

    @override
    String get importantWord => "N/A";

    @override
    String descText = "<br><br><br><b>Is Alive:</b><br>Target Entity must be ALIVE (zombies count). <br><br>";
    @override
    String notDescText = "<br><br><br><b>Is NOT Alive:</b><br>Target Entity must be NOT ALIVE (zombies  don'tcount). <br><br>";

    //strongly encouraged for this to be replaced
    //like, "An ominous 'honk' makes the Knight of Rage drop the Juggalo Poster in shock. With growing dread they realize that shit is about to get hella rowdy, as the Mirthful Messiahs have rolled into town.

    TargetIsAlive(SerializableScene scene) : super(scene){
    }


    @override
    void renderForm(Element div) {
        DivElement me = new DivElement();
        div.append(me);
        me.setInnerHtml("<br><br><br><b>Is Alive:</b><br>Target Entity must be ALIVE (zombies count). <br><br>");
        syncToForm();
    }

    @override
    TargetCondition makeNewOfSameType() {
        return new TargetIsAlive(scene);
    }

    @override
    void syncFormToMe() {
            //does nothing
    }

    @override
    void syncToForm() {
        scene.syncForm();
    }
    @override
    void copyFromJSON(JSONObject json) {
        //nothing to do
    }

    @override
    bool conditionForFilter(GameEntity item) {
        return item.dead;
    }
}