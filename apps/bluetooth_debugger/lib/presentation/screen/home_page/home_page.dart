import 'package:bluetooth_presentation/devices/details_tile/tile.dart';
import 'package:bluetooth_presentation/flutter_blue_plus/device_view.dart';
import 'package:data_utils/data_utils.dart';
import 'package:data_presentation/formatter/hex_formatter.dart';
import 'package:data_presentation/bytes/bytes_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;
import 'package:provider/provider.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../../../application/write_bluetooth_packet_file.dart';
import '../../dto/bluetooth_devices_filter.dart';

part 'home_page.tailor.dart'; 
part 'utils/controller.dart';
part 'utils/theme.dart';
part 'utils/page.dart';