import 'package:hive/hive.dart';
part 'senderdetail.g.dart';
@HiveType(typeId: 0)
class SenderDetail extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String address;
  SenderDetail({
    required this.name,
    required this.address,
  });
}
