import 'package:coffeemachine/data/repositories/mqtt_repository.dart';
import 'package:coffeemachine/data/repositories/mqtt_repository_demo_impl.dart';
import 'package:coffeemachine/data/repositories/mqtt_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mqttClientProvider =
    Provider.family<MqttRepository, bool>((ref, bool isDemo) {
  return isDemo ? MqttDemoRepository() : MqttRepositoryImpl();
});
