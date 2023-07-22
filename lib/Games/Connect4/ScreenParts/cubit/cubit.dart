import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intelligent_learning/Games/Connect4/ScreenParts/cubit/state.dart';

class GameCubit extends Cubit<State_>
{
  GameCubit(): super(initState());
  static GameCubit get(context)=>BlocProvider.of(context);
  String? player;

  void setPlayer(bool start) {
    player= start?"Orange":"Black";
    emit(playerState());
  }

  void changePlayer() {
    player= player=='Orange'? 'Black':"Orange";
    emit(playerState());
  }
}