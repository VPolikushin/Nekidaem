abstract class TabBarEvent {}

class LoadCardsEvent extends TabBarEvent{
  final int row;

  LoadCardsEvent({required this.row});
}

class SetInitialStateEvent extends TabBarEvent{}