class CommonResponse {
  final String state;
  final String stateDescription;

  CommonResponse({
    required this.state,
    required this.stateDescription,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      state: json["status"],
      stateDescription: json["statusDescription"],
    );
  }

  factory CommonResponse.fromDetails(
    String state,
    String stateDescription,
  ) {
    return CommonResponse(
      state: state,
      stateDescription: stateDescription,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "state": state,
      "stateDescription": stateDescription,
    };
  }
}
