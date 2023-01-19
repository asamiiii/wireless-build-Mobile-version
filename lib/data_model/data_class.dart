class User{
  String? userId ;      // Document Id
  String? ipAddress;

  User({this.userId,this.ipAddress});

  User.fromJson(Map<String, Object?> json):this(
        userId: json['userId']! as String,
        ipAddress: json['ipAddress'] as String
      );

      Map<String, Object?> toJson() {
    return {
      'userId': userId,
      'ipAddress': ipAddress,

    };
  

}
}