package haxefrog;

using java.Lib;

import arc.Core;
import arc.Events;
import arc.func.Cons;
import arc.util.Log;
import arc.util.Time;
import java.lang.Runnable;
import mindustry.game.EventType.EventType_ClientLoadEvent;
import mindustry.mod.Mod;
import mindustry.ui.dialogs.BaseDialog;

/** What an abomination that wasted me 9 hours */
class Haxefrog extends Mod {
	public function new() {
		super();
		Log.info("[HF] Calling constructor.");
		Events.on(Lib.toNativeType(EventType_ClientLoadEvent), new Haxefrog_ClientLoadEventListener());
	}

	@:overload
	public override function loadContent() {
		Log.info("[HF] Loading some example content.");
	}
}

class Haxefrog_ClientLoadEventListener implements Cons<EventType_ClientLoadEvent> {
	public function new() {}

	public function get(c:EventType_ClientLoadEvent):Void {
		Time.runTask(10., new Haxefrog_ClientLoadEventListener_TimeTask());
	}
}

class Haxefrog_ClientLoadEventListener_TimeTask implements Runnable {
	public function new() {}

	public function run():Void {
		var dialog = new BaseDialog("frog");
		dialog.cont.add("behold").row();
		dialog.cont.image(Core.atlas.find("haxefrog-frog")).pad(20.).row();
		dialog.cont.button("I see", new Haxefrog_ClientLoadEventListener_TimeTask_ButtonListener(dialog)).size(100., 50.);
		dialog.show();
	}
}

class Haxefrog_ClientLoadEventListener_TimeTask_ButtonListener implements Runnable {
	var dialog:BaseDialog;

	public function new(dialog:BaseDialog) {
		this.dialog = dialog;
	}

	public function run():Void {
		this.dialog.hide();
	}
}
