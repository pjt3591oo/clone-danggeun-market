
import 'package:intl/intl.dart';

final oCcy = new NumberFormat("#,###", "ko_KR");

String calulatorStringToWon(String price) {
  if (double.tryParse(price) == null) return price;
  return "${oCcy.format(int.parse(price))}원";
}