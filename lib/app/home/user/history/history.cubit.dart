import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_post/config/application.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/delivery/delivery.service.dart';

part 'history.state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  Orders? orders;
  DeliveryService _deliveryService;

  HistoryCubit(this._deliveryService) : super(HistoryInitial()) {
    emit(OrdersLoading());
    getListOrderByUser();
  }

  Future<Orders?> getListOrderByUser() async {
    emit(OrdersLoading());
    orders = await _deliveryService.getOrderByUser(Application.sharePreference.getInt("userId") ?? 0);
    emit(OrdersLoaded());
    return orders;
  }
}
