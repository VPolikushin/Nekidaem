import 'package:nekidaem/tabbar/bloc/tabbar_status.dart';
import 'package:nekidaem/tabbar/model/card_model.dart';

class TabBarState {
 final int row;
 final List<MyCard> cards;
 TabBarStatus tabBarStatus;


 TabBarState({
  this.row = 0,
  this.cards = const [],
  this.tabBarStatus = const InitialTabBarStatus(),
 });

 TabBarState copyWith ({
  int? row,
  List<MyCard>? cards,
  TabBarStatus? tabBarStatus,
}){
  return TabBarState(
   row: row ?? this.row,
   cards: cards ?? this.cards,
   tabBarStatus: tabBarStatus ?? this.tabBarStatus
  );
 }
}

