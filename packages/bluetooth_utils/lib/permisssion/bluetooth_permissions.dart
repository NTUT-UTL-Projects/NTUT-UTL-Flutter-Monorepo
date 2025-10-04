import 'package:permission_handler/permission_handler.dart';

List<Permission> get bluetoothPermissions => List.unmodifiable([
  Permission.bluetoothAdvertise,
  Permission.bluetoothConnect,
  Permission.bluetoothScan,
  Permission.location,
]);
