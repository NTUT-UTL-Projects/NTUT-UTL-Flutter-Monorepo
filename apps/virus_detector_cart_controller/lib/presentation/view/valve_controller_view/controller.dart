part of 'valve_controller_view.dart';

enum Valve {
  r0,
  r45,
  r90,
  r180,
}

typedef ValveTriggerEvent = void Function(Valve valve);

class ValveController extends ChangeNotifier {
  @protected
  final ValveTriggerEvent trigger;
  ValveTriggerEvent get triggerEvent => (valve) {
    trigger(valve);
    _valve = valve;
    notifyListeners();
  };

  ValveController({required this.trigger});

  Valve _valve = Valve.r0;

  Valve get valve => _valve;
}
