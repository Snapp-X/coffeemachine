import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final _client = MqttServerClient(_broker, 'asdasdasd');
const _broker = '10.42.0.1';
const _username = 'dash';
const _passwd = 'esel1234';
const _clientIdentifier = 'FlutterClient';

var pongCount = 0; // Pong counter

Future<int> initMqtt() async {
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

  /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
  /// You can add these before connection or change them dynamically after connection if
  /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
  /// can fail either because you have tried to subscribe to an invalid topic or the broker
  /// rejects the subscribe request.
  _client.onSubscribed = onSubscribed;

  /// Create a connection message to use or use the default one. The default one sets the
  /// client identifier, any supplied username/password and clean session,
  /// an example of a specific one below.
  final connMess = MqttConnectMessage()
      .withClientIdentifier(_clientIdentifier)
      .startClean(); // Non persistent session for testing
  print('EXAMPLE::Mosquitto client connecting....');
  _client.connectionMessage = connMess;

  /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
  /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
  /// never send malformed messages.
  try {
    await _client.connect(_username, _passwd);
  } on NoConnectionException catch (e) {
    // Raised by the client when connection fails.
    print('EXAMPLE::client exception - $e');
    _client.disconnect();
  } on SocketException catch (e) {
    // Raised by the socket layer
    print('EXAMPLE::socket exception - $e');
    _client.disconnect();
  }

  /// Check we are connected
  if (_client.connectionStatus!.state == MqttConnectionState.connected) {
    print('EXAMPLE::Mosquitto client connected');
  } else {
    /// Use status here rather than state if you also want the broker return code.
    print(
        'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${_client.connectionStatus}');
    _client.disconnect();
    exit(-1);
  }

  /// Ok, lets try a subscription
  print(
      'SUBSCRIBING::Subscribing to the flutter/Coffeemachine.fluttercoffee/temperature');
  const topic =
      'flutter/Coffeemachine.fluttercoffee/temperature'; // Not a wildcard topic
  _client.subscribe(topic, MqttQos.atMostOnce);

  /// The client has a change notifier object(see the Observable class) which we then listen to to get
  /// notifications of published updates to each subscribed topic.
  _client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
    final recMess = c![0].payload as MqttPublishMessage;
    final pt =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    /// The above may seem a little convoluted for users only interested in the
    /// payload, some users however may be interested in the received publish message,
    /// lets not constrain ourselves yet until the package has been in the wild
    /// for a while.
    /// The payload is a byte buffer, this will be specific to the topic
    print(
        'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
    print('');
  });

  /// If needed you can listen for published messages that have completed the publishing
  /// handshake which is Qos dependant. Any message received on this stream has completed its
  /// publishing handshake with the broker.
  _client.published!.listen((MqttPublishMessage message) {
    print(
        'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
  });

  /// Lets publish to our topic
  /// Use the payload builder rather than a raw buffer
  /// Our known topic to publish to
  // const pubTopic = 'Dart/Mqtt_client/testtopic';
  // final builder = MqttClientPayloadBuilder();
  // builder.addString('Hello from mqtt_client');

  // /// Subscribe to it
  // print('EXAMPLE::Subscribing to the Dart/Mqtt_client/testtopic topic');
  // _client.subscribe(pubTopic, MqttQos.exactlyOnce);

  // /// Publish it
  // print('EXAMPLE::Publishing our topic');
  // _client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);

  // /// Ok, we will now sleep a while, in this gap you will see ping request/response
  // /// messages being exchanged by the keep alive mechanism.
  // print('EXAMPLE::Sleeping....');
  // await MqttUtilities.asyncSleep(60);

  // /// Finally, unsubscribe and exit gracefully
  // print('EXAMPLE::Unsubscribing');
  // _client.unsubscribe(topic);

  // /// Wait for the unsubscribe message from the broker if you wish.
  // await MqttUtilities.asyncSleep(2);
  // print('EXAMPLE::Disconnecting');
  // _client.disconnect();
  // print('EXAMPLE::Exiting normally');
  return 0;
}

/// The subscribed callback
void onSubscribed(String topic) {
  print('EXAMPLE::Subscription confirmed for topic $topic');
}

/// The unsolicited disconnect callback
void onDisconnected() {
  print('EXAMPLE::OnDisconnected client callback - Client disconnection');
  if (_client.connectionStatus!.disconnectionOrigin ==
      MqttDisconnectionOrigin.solicited) {
    print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
  } else {
    print(
        'EXAMPLE::OnDisconnected callback is unsolicited or none, this is incorrect - exiting');
    exit(-1);
  }
  if (pongCount == 3) {
    print('EXAMPLE:: Pong count is correct');
  } else {
    print('EXAMPLE:: Pong count is incorrect, expected 3. actual $pongCount');
  }
}

/// The successful connect callback
void onConnected() {
  print(
      'EXAMPLE::OnConnected client callback - Client connection was successful');
}

/// Pong callback
void pong() {
  print('EXAMPLE::Ping response client callback invoked');
  pongCount++;
}
