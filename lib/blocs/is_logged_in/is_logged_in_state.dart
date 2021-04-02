part of 'is_logged_in_cubit.dart';

abstract class IsLoggedInState extends Equatable {
  const IsLoggedInState();

  @override
  List<Object> get props => [];
}

class IsLoggedInInitial extends IsLoggedInState {}

class IsLoggedInLoadingState extends IsLoggedInState {
  @override
  List<Object> get props => [];
}

class IsLoggedInAuthenticatedState extends IsLoggedInState {
  final Status status;

  IsLoggedInAuthenticatedState({this.status});
  @override
  List<Object> get props => [status];
}

class IsLoggedInUnAuthenticatedState extends IsLoggedInState {
  @override
  List<Object> get props => [];
}

class IsLoggedInErrorState extends IsLoggedInState {
  final String errorMessage;

  IsLoggedInErrorState({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
