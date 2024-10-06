import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/admin_log_entity.dart';

abstract class AdminLogManagerState extends Equatable {
  const AdminLogManagerState();

  @override
  List<Object> get props => [];
}

class AdminLogManagerInitial extends AdminLogManagerState {
  final List<AdminLogEntity> logs = [];
  final int pageNumber = -1;
  final int pageSize = 25;
  final bool hasReachedMax = false;
  final String filterType = 'null';

  AdminLogManagerInitial();

  @override
  List<Object> get props =>
      [logs, pageNumber, pageSize, hasReachedMax, filterType];
}

class AdminLogManagerLoaded extends AdminLogManagerState {
  final List<AdminLogEntity> logs;
  final String filterType;
  final int pageNumber;
  final int pageSize;
  final bool hasReachedMax;

  const AdminLogManagerLoaded({
    required this.logs,
    required this.filterType,
    required this.pageNumber,
    required this.pageSize,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props =>
      [logs, filterType, pageNumber, pageSize, hasReachedMax];

  AdminLogManagerLoaded copyWith({
    List<AdminLogEntity>? logs,
    String? filterType,
    int? pageNumber,
    int? pageSize,
    bool? hasReachedMax,
  }) {
    return AdminLogManagerLoaded(
      logs: logs ?? this.logs,
      filterType: filterType ?? this.filterType,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class AdminLogManagerFailure extends AdminLogManagerState {
  final String message;

  const AdminLogManagerFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
