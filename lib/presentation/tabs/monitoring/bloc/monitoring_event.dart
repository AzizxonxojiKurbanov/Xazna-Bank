part of 'monitoring_bloc.dart';

sealed class MonitoringEvent {
  const MonitoringEvent();
}

class MonitoringStarted extends MonitoringEvent {
  const MonitoringStarted();
}

class MonitoringRefreshed extends MonitoringEvent {
  const MonitoringRefreshed();
}
