import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekidaem/services/storage_token.dart';
import 'package:nekidaem/tabbar/bloc/tabbar_bloc.dart';
import 'package:nekidaem/tabbar/bloc/tabbar_event.dart';
import 'package:nekidaem/tabbar/bloc/tabbar_state.dart';
import 'package:nekidaem/tabbar/bloc/tabbar_status.dart';
import 'package:nekidaem/tabbar/model/card_model.dart';
import 'package:nekidaem/tabbar/repository/tabbar_repository.dart';

class MyTabBarView extends StatefulWidget {
  static const routeName = '/tabBar';
  const MyTabBarView({Key? key}) : super(key: key);

  @override
  _MyTabBarViewState createState() => _MyTabBarViewState();
}

class _MyTabBarViewState extends State<MyTabBarView> with TickerProviderStateMixin{
  late TabController _controller;
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            controller: _controller,
            tabs: const [
              Tab(text: 'On hold',),
              Tab(text: 'In progress',),
              Tab(text: 'Needs review',),
              Tab(text: 'Approved',),
            ],
          ),
          actions: [
            InkWell(
              onTap: () async {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/login');
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle
                ),
                child: const Icon(Icons.arrow_back),
              ),
            )
          ],
        ),
        body: BlocProvider(
          create: (context) => TabBarBloc(
            tabBarRepository: context.read<TabBarRepository>(),
          ),
            child: _myTabBarView(context),
        ),
      ),
    );
  }

  Widget _myTabBarView(BuildContext context) {
    return BlocBuilder<TabBarBloc, TabBarState>(
        builder: (context, state)
    {
      if (state.tabBarStatus is InitialTabBarStatus) {
        context.read<TabBarBloc>().add(LoadCardsEvent(row: _controller.index));
      }

      if (state.tabBarStatus is TabBarLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state.tabBarStatus is TabBarLoadError) {
        return Text(state.tabBarStatus.toString());
      }

      if (state.tabBarStatus is TabBarLoaded) {
      return PageView.builder(
        onPageChanged: (int page) {
          if (_pageController.position.userScrollDirection.index == 2) {
            currentPage++;
            if(currentPage >= 4) {
              currentPage = 0;
            }
          }
          if (_pageController.position.userScrollDirection.index == 1) {
            currentPage--;
            if(currentPage < 0) {
              currentPage = 3;
            }
          }

          _controller.index = currentPage;
          context.read<TabBarBloc>().add(SetInitialStateEvent());
        },
        itemCount: 4,
        controller: _pageController,
        itemBuilder: (context, index) {
          return ListView(
            children: <Widget>[
              ...state.cards.map((card) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                  padding: const EdgeInsets.all(6),

                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID: ${card.id}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white54
                        ),
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        card.text,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          );
        }
      );
    }
      return Text('none');
    });
  }
}
