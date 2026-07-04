class SetPinRequest {
  final String pin;

  SetPinRequest({required this.pin});

  Map<String, dynamic> toJson() => {"pin": pin};
}
