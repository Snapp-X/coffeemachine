import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:coffeemachine/data/repositories/mqtt_repository.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttRepositoryImpl implements MqttRepository {
  final _broker = '10.42.0.1';
  final _username = 'dash';
  final _passwd = 'esel1234';
  final _clientIdentifier = 'FlutterClient';

  late final _client = MqttServerClient(_broker, 'asdasdasd');

  @override
  Future<void> connect() async {
    _client.logging(on: true);

    /// Set the correct MQTT protocol for mosquito
    _client.setProtocolV311();

    /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
    _client.keepAlivePeriod = 30;

    /// The connection timeout period can be set if needed, the default is 5 seconds.
    _client.connectTimeoutPeriod = 2000; // milliseconds

    /// Add the unsolicited disconnection callback
    _client.onDisconnected = onDisconnected;

    /// Add the successful connection callback
    _client.onConnected = onConnected;

    /// Add the successful onSubscribed callback
    _client.onSubscribed = onSubscribed;

    /// Create a connection message to use or use the default one. The default one sets the
    final connMess = MqttConnectMessage()
        .withClientIdentifier(_clientIdentifier)
        .startClean(); // Non persistent session for testing
    _client.connectionMessage = connMess;

    /// Connect the client
    try {
      await _client.connect(_username, _passwd);
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      log('MqttClient::client exception - $e');
      _client.disconnect();
      rethrow;
    } on SocketException catch (e) {
      // Raised by the socket layer
      log('MqttClient::socket exception - $e');
      _client.disconnect();
      rethrow;
    }

    /// Connection state message
    if (_client.connectionStatus?.state == MqttConnectionState.connected) {
      log('MqttClient::Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      log('MqttClient::ERROR Mosquitto client connection failed - disconnecting, status is ${_client.connectionStatus}');
      _client.disconnect();
    }
  }

  @override
  Future<void> subscribeTo(List<MqttValue> topics,
      Function(String payload, String topic) callback) async {
    for (final topic in topics) {
      switch (topic) {
        case MqttValue.currentTemperature:
          _client.subscribe(
              '${MqttRepository.topicPrefix}${MqttRepository.currentTemperature}',
              MqttQos.atMostOnce);
          break;
        case MqttValue.targetTemperature:
          _client.subscribe(
              '${MqttRepository.topicPrefix}${MqttRepository.targetTemperature}',
              MqttQos.atMostOnce);
          break;
        case MqttValue.varP:
          _client.subscribe(
              '${MqttRepository.topicPrefix}${MqttRepository.varP}',
              MqttQos.atMostOnce);
          break;
        case MqttValue.varI:
          _client.subscribe(
              '${MqttRepository.topicPrefix}${MqttRepository.varI}',
              MqttQos.atMostOnce);
          break;
        case MqttValue.varD:
          _client.subscribe(
              '${MqttRepository.topicPrefix}${MqttRepository.varD}',
              MqttQos.atMostOnce);
          break;
      }
    }

    _client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final MqttPublishMessage message = c![0].payload as MqttPublishMessage;
      final messageTopic = c[0].topic;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      callback.call(payload, messageTopic);
    });
  }

  @override
  Future<void> publish(String value, MqttValue topic) async {
    final builder = MqttClientPayloadBuilder();
    var pubTopic = '';

    switch (topic) {
      case MqttValue.currentTemperature:
        return;
      case MqttValue.targetTemperature:
        pubTopic =
            '${MqttRepository.topicPrefix}${MqttRepository.targetTemperature}';
        break;
      case MqttValue.varP:
        pubTopic = '${MqttRepository.topicPrefix}${MqttRepository.varP}';
        break;
      case MqttValue.varI:
        pubTopic = '${MqttRepository.topicPrefix}${MqttRepository.varI}';
        break;
      case MqttValue.varD:
        pubTopic = '$MqttRepository.topicPrefix}${MqttRepository.varD}';
        break;
    }

    builder.addString(value);
    _client.publishMessage(
        '$pubTopic/set', MqttQos.exactlyOnce, builder.payload!);
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
