import 'dart:typed_data';

import '../parameters/parameters.dart';

extension ElectrochemicalParametersToBytes on ElectrochemicalParameters {
  static const bytesMaxLength = 28;
  ByteData toByteData({
    required bool align,
  }) {
    switch(type) {
      case ElectrochemicalType.ca:
        final temp = this as CaElectrochemicalParameters;
        return ByteData((align) ? bytesMaxLength : 12)
          ..setFloat32(0, temp.eDc, Endian.little)
          ..setFloat32(4, temp.tInterval, Endian.little)
          ..setFloat32(8, temp.tRun, Endian.little);
      case ElectrochemicalType.cv:
        final temp = this as CvElectrochemicalParameters;
        return ByteData((align) ? bytesMaxLength : 24)
          ..setFloat32(0, temp.eBegin, Endian.little)
          ..setFloat32(4, temp.eVertex1, Endian.little)
          ..setFloat32(8, temp.eVertex2, Endian.little)
          ..setFloat32(12, temp.eStep, Endian.little)
          ..setFloat32(16, temp.scanRate, Endian.little)
          ..setUint16(20, temp.numberOfScans, Endian.little);
      case ElectrochemicalType.dpv:
        final temp = this as DpvElectrochemicalParameters;
        return ByteData((align) ? bytesMaxLength : 28)
          ..setFloat32(0, temp.eBegin, Endian.little)
          ..setFloat32(4, temp.eEnd, Endian.little)
          ..setFloat32(8, temp.eStep, Endian.little)
          ..setFloat32(12, temp.ePulse, Endian.little)
          ..setFloat32(16, temp.tPulse, Endian.little)
          ..setFloat32(20, temp.scanRate, Endian.little)
          ..setUint8(24, temp.inversionOption.index);
    }
  }
}
