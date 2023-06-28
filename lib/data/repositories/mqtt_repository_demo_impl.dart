import 'dart:async';
import 'package:coffeemachine/data/repositories/mqtt_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mqttDemoProvider = Provider((ref) {
  return MqttDemoRepository();
});

class MqttDemoRepository implements MqttRepository {
  String _currentTemperature = '100';
  String _targetTemperature = '0';
  String _varP = '10';
  String _varI = '20';
  String _varD = '30';
  bool rise = true;

  late final Stream _stream;

  @override
  Future<void> connect() async {
    _stream = Stream.periodic(const Duration(milliseconds: 50), (count) {
      if (count % 100 == 0) {
        rise = !rise;
      }

      if (rise == true) {
        _currentTemperature =
            (double.parse(_currentTemperature) + 1).toString();
        _targetTemperature = (double.parse(_targetTemperature) - 1).toString();
      } else {
        _currentTemperature =
            (double.parse(_currentTemperature) - 1).toString();
        _targetTemperature = (double.parse(_targetTemperature) + 1).toString();
      }
    });
  }

  @override
  Future<void> subscribeTo(List<MqttValue> topics,
      Function(String payload, String topic) callback) async {
    List<MqttValue> listenTo = List.empty(growable: true);
    for (final topic in topics) {
      switch (topic) {
        case MqttValue.currentTemperature:
          listenTo.add(MqttValue.currentTemperature);
          break;
        case MqttValue.targetTemperature:
          listenTo.add(MqttValue.targetTemperature);
          break;
        case MqttValue.varP:
          listenTo.add(MqttValue.varP);
          break;
        case MqttValue.varI:
          listenTo.add(MqttValue.varI);
          break;
        case MqttValue.varD:
          listenTo.add(MqttValue.varD);
          break;
      }
    }
    _stream.listen((count) {
      for (final subscribedTopic in listenTo) {
        switch (subscribedTopic) {
          case MqttValue.currentTemperature:
            callback(_currentTemperature, MqttRepository.currentTemperature);
            break;
          case MqttValue.targetTemperature:
            callback(_targetTemperature, MqttRepository.targetTemperature);
            break;
          case MqttValue.varP:
            callback(_varP, MqttRepository.varP);
            break;
          case MqttValue.varI:
            callback(_varI, MqttRepository.varI);
            break;
          case MqttValue.varD:
            callback(_varD, MqttRepository.varD);
            break;
        }
      }
    });
  }

  @override
  Future<void> publish(String value, MqttValue topic) async {
    switch (topic) {
      case MqttValue.targetTemperature:
        _targetTemperature = value;
        break;
      case MqttValue.varP:
        _varP = value;
        break;
      case MqttValue.varI:
        _varI = value;
        break;
      case MqttValue.varD:
        _varD = value;
        break;
      default:
        break;
    }
  }

  /// Subscribed callback
  @override
  void onSubscribed(String topic) {}

  /// Disconnected callback
  @override
  void onDisconnected() {}

  /// Connected callback
  @override
  void onConnected() {}

  /// Pong callback
  @override
  void pong() {}
}
