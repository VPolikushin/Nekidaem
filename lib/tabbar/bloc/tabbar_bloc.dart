import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekidaem/tabbar/bloc/tabbar_event.dart';
import 'package:nekidaem/tabbar/bloc/tabbar_state.dart';
import 'package:nekidaem/tabbar/bloc/tabbar_status.dart';
import 'package:nekidaem/tabbar/model/card_model.dart';
import 'package:nekidaem/tabbar/repository/tabbar_repository.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  final TabBarRepository? tabBarRepository;

  TabBarBloc({this.tabBarRepository}) : super(TabBarState());

  Stream<TabBarState> mapEventToState(TabBarEvent event) async* {
    if (event is LoadCardsEvent) {
      yield state.copyWith(tabBarStatus: const TabBarLoading());

      try {
        final List<MyCard> cardsList = await tabBarRepository!.fetchCards(event.row);
        yield state.copyWith(tabBarStatus: TabBarLoaded(), cards: cardsList);
      } catch (e) {
        yield state.copyWith(tabBarStatus: TabBarLoadError(e as Exception));
      }
    }
    if (event is SetInitialStateEvent) {
      yield state.copyWith(tabBarStatus: const InitialTabBarStatus());
    }
  }
}