import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'is_logged_in_state.dart';

class IsLoggedInCubit extends Cubit<IsLoggedInState> {
  IsLoggedInCubit() : super(IsLoggedInInitial());
}
