import 'package:event_bus/event_bus.dart';

class EventBusUtils {
  static late EventBus _instance;

  static init() {
    _instance = EventBus();
  }

  static EventBus getInstance() {
    if (null == _instance) {
      _instance = EventBus();
    }
    return _instance;
  }
}

class EventBus_data {
  int number;
  EventBus_data(this.number);
}
