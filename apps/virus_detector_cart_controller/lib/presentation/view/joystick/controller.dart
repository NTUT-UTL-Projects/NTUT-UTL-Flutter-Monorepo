part of 'joystick.dart';

typedef JoystickTriggerEvent = void Function(Point<double> point);

class JoystickController extends ChangeNotifier {
  @protected
  final JoystickTriggerEvent trigger;
  JoystickTriggerEvent get triggerEvent => (point) {
    trigger(point);
    _point = point;
    notifyListeners();
  };

  JoystickController({required this.trigger});

  Point<double> _point = Point(0.0, 0.0);

  Point<double> get point => _point;
}