import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigator_event.dart';
part 'navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorScreenState> {
  NavigatorBloc() : super(NavigatorInitial()) {
    on<NavigateProfileEvent>(_onProfile);
    on<NavigateSearchEvent>(_onSearch);
  }
  _onProfile(NavigateProfileEvent event, emit) {
    emit(NavigateProfileState());
  }
  _onSearch(NavigateSearchEvent event, emit) {
    emit(NavigateSearchState());
  }
}
