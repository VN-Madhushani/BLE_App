class CommonDataResponse {
  final String state;
  final String stateDescription;
  final dynamic data;

  CommonDataResponse({
    required this.state,
    required this.stateDescription,
    this.data,
  });

  factory CommonDataResponse.fromJson(Map<String, dynamic> json) {
    return CommonDataResponse(
      state: json["status"],
      stateDescription: json["statusDescription"],
    );
  }

  factory CommonDataResponse.fromDetails(
    String state,
    String stateDescription, {
    dynamic? data,
  }) {
    return CommonDataResponse(
      state: state,
      stateDescription: stateDescription,
      data: data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "state": state,
      "stateDescription": stateDescription,
      "data": data,
    };
  }
}
