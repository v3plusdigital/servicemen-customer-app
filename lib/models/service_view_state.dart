import 'package:servicemen_customer_app/models/services_response_model.dart';

class ServicesViewState {
  final ServicesResponseModel? services;
  final bool isLoading;

  const ServicesViewState({required this.services, required this.isLoading});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicesViewState &&
          services == other.services &&
          isLoading == other.isLoading;

  @override
  int get hashCode => Object.hash(services, isLoading);
}
