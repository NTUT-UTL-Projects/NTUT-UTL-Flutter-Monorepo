part of 'joystick.dart';

class JoystickView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trigger = context.select<JoystickController, JoystickTriggerEvent>((c) => c.triggerEvent);
    return Column();
  }
}