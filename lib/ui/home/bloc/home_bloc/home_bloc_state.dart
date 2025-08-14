// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc_bloc.dart';

class HomeBlocState extends Equatable {
  String? todoName;
  HomeBlocState({
     this.todoName,
  });
  
  
  @override
  List<Object> get props => [];

  HomeBlocState copyWith({
    String? todoName,
  }) {
    return HomeBlocState(
      todoName: todoName ?? this.todoName,
    );
  }
}

