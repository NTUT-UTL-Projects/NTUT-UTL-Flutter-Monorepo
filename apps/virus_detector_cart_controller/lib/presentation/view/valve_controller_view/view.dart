part of 'valve_controller_view.dart';

class ValveControllerView extends StatelessWidget {
  const ValveControllerView({super.key});

  @override
  Widget build(BuildContext context) {
    final trigger = context.select<ValveController, ValveTriggerEvent>(
      (c) => c.triggerEvent,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Valve.values.map((v) {
        return ElevatedButton(
          onPressed: () => trigger(v),
          child: Text(
            v.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );
      }).toList(),
    );
  }
}
