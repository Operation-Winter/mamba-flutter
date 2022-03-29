import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'join_landing_session_event.dart';
part 'join_landing_session_state.dart';

class JoinLandingSessionBloc extends Bloc<JoinLandingSessionEvent, JoinLandingSessionState> {
  JoinLandingSessionBloc() : super(JoinLandingSessionInitial()) {
    on<JoinLandingSessionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
