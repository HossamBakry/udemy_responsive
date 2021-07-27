abstract class CounterStates {}

class CounterInitialSate extends CounterStates {}

class CounterPlusSate extends CounterStates
{
  final int counter;

  CounterPlusSate(this.counter);
}
class CounterMinusSate extends CounterStates
{
  final int counter;

  CounterMinusSate(this.counter);
}