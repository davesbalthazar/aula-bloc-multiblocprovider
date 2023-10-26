part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoogedIn extends UserState {
  final String userId;
  final String userName;

  const UserLoogedIn(this.userId, this.userName);

  @override
  List<Object> get props => [userId, userName];
}
