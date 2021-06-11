class CollectionHistoryModel {
  final String requestStatus;
  final String requestTime;
  final String pickUpDeliveryType;
  final String trashType;
  final String paymentStatus;
  final String paymentDetail;
  final String address;
  final String trashWeightFormatted;
  final String remainingPayment;
  final String downPayment;

  CollectionHistoryModel({
    this.trashWeightFormatted,
    this.remainingPayment,
    this.downPayment,
    this.requestStatus,
    this.requestTime,
    this.pickUpDeliveryType,
    this.trashType,
    this.paymentStatus,
    this.paymentDetail,
    this.address,
  });
}
