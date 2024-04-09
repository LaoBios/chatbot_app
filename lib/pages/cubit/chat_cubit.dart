import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class CubitCubit extends Cubit<ChatState> {
  CubitCubit() : super(CubitInitial());
}
