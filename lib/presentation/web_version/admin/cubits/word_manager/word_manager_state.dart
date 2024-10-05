import 'package:equatable/equatable.dart';

abstract class WordManagerState extends Equatable{
  const WordManagerState();

  @override
  List<Object?> get props => [];
}

class WordManagerInitial extends WordManagerState{}