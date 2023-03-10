
import 'package:equatable/equatable.dart';

class Orderr extends Equatable{
  final String id;
  final String address;
  final String details;
  final String stats;
  final DateTime createdOn;

  const Orderr(this.id, this.address, this.details, this.stats, this.createdOn);

  @override
  List<Object?> get props => [id,address,details,stats,createdOn];

}