import 'package:nekidaem/tabbar/model/card_model.dart';

abstract class TabBarStatus {
  const TabBarStatus();
}

class InitialTabBarStatus extends TabBarStatus{
  const InitialTabBarStatus();
}

class TabBarLoading extends TabBarStatus {
  const TabBarLoading();
}

class TabBarLoaded extends TabBarStatus {}

class TabBarLoadError extends TabBarStatus {
  final Exception exception;

  TabBarLoadError(this.exception);
  @override
  String toString() => 'ChangePasswordFailure { error: $exception }';
}
