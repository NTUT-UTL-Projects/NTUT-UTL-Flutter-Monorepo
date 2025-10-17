part of 'move_controller_view.dart';

typedef MoveTriggerEvent = void Function(Point<double> point);

class MoveController extends ChangeNotifier {
  @protected
  final MoveTriggerEvent trigger;
  MoveTriggerEvent get triggerEvent => (point) {
    trigger(point);
    _point = point;
    notifyListeners();
  };

  MoveController({required this.trigger});

  Point<double> _point = Point(0.0, 0.0);

  Point<double> get point => _point;
}
