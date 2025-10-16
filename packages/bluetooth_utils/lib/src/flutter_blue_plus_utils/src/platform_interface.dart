part of '../flutter_blue_plus_utils.dart';

BluetoothBondState _bmToBondState(BmBondStateEnum value) {
  switch (value) {
    case BmBondStateEnum.none:
      return BluetoothBondState.none;
    case BmBondStateEnum.bonding:
      return BluetoothBondState.bonding;
    case BmBondStateEnum.bonded:
      return BluetoothBondState.bonded;
  }
}

extension _BmCharacteristicData on BmCharacteristicData {
  BluetoothCharacteristic? get characteristic {
    return BluetoothCharacteristic(
      remoteId: remoteId,
      primaryServiceUuid: primaryServiceUuid,
      serviceUuid: serviceUuid,
      characteristicUuid: characteristicUuid,
      instanceId: instanceId,
    );
  }
}

extension _BmDescriptorData on BmDescriptorData {
  BluetoothCharacteristic? get characteristic {
    if (!success) return null;
    return BluetoothCharacteristic(
      remoteId: remoteId,
      primaryServiceUuid: primaryServiceUuid,
      serviceUuid: serviceUuid,
      characteristicUuid: characteristicUuid,
      instanceId: instanceId,
    );
  }

  BluetoothDescriptor? get descriptor {
    if (!success) return null;
    return BluetoothDescriptor(
      remoteId: remoteId,
      primaryServiceUuid: primaryServiceUuid,
      serviceUuid: serviceUuid,
      characteristicUuid: characteristicUuid,
      instanceId: instanceId,
      descriptorUuid: descriptorUuid,
    );
  }
}
