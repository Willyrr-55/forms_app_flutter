part of 'counter_bloc.dart';

abstract class CounterEvent {
  const CounterEvent();
}

class CounterIncreased extends CounterEvent{
  final int valueFromEvent;
  const CounterIncreased(this.valueFromEvent);
}

class CounterReset extends CounterEvent{}