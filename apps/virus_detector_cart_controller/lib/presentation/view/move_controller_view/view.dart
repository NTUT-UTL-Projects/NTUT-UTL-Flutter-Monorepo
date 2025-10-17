part of 'move_controller_view.dart';

class MoveControllerView extends StatelessWidget {
  const MoveControllerView({super.key});

  @override
  Widget build(BuildContext context) {
    final trigger = context.select<MoveController, MoveTriggerEvent>(
      (c) => c.triggerEvent,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Builder(
          builder: (context) {
            final point = context.select<MoveController, Point>(
              (c) => c.point,
            );
            return Text(
              "(${point.x.toStringAsFixed(5)}, ${point.y.toStringAsFixed(5)})",
              style: Theme.of(context).textTheme.titleLarge,
            );
          },
        ),
        Divider(),
        Joystick(
          listener: (details) {
            trigger(Point(details.x, details.y));
          },
        ),
      ],
    );
  }
}
