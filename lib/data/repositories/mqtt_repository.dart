import 'dart:async';

abstract class MqttRepository {
  static const currentTemperature = 'temperature';
  static const targetTemperature = 'brewSetPoint';
  static const varP = 'aggKp';
  static const varI = 'aggTn';
  static const varD = 'aggTv';
  static const topicPrefix = 'flutter/Coffeemachine.fluttercoffee/';

  Future<void> connect();
  Future<void> subscribeTo(
      List<MqttValue> topics, Function(String payload, String topic) callback);
  Future<void> publish(String value, MqttValue topic);
  void onSubscribed(String topic);
  void onDisconnected();
  void onConnected();
  void pong();
}

enum MqttValue {
  currentTemperature,
  targetTemperature,
  varP,
  varI,
  varD,
}
