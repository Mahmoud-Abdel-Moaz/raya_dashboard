part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

class LoadingAddOrderState extends OrderState {
  @override
  List<Object> get props => [];
}

class LoadedAddOrderState extends OrderState {
  @override
  List<Object> get props => [];
}

class ErrorAddOrderState extends OrderState {
  final String errorMessage;

  const ErrorAddOrderState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class LoadingOrdersState extends OrderState {
  @override
  List<Object> get props => [];
}

class LoadedOrdersState extends OrderState {
  final List<Orderr> orders;

  const LoadedOrdersState(this.orders);
  @override
  List<Object> get props => [orders];
}

class ErrorOrdersState extends OrderState {
  final String errorMessage;

  const ErrorOrdersState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
