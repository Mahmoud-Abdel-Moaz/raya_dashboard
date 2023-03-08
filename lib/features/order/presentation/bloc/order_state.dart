part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

class LoadingAddOrder extends OrderState {
  @override
  List<Object> get props => [];
}

class LoadedAddOrder extends OrderState {
  @override
  List<Object> get props => [];
}

class ErrorAddOrder extends OrderState {
  final String errorMessage;

  const ErrorAddOrder(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
