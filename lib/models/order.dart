import 'package:dep_college_app/models/fooditem.dart';

class Orderr {
  final String orderid;
  final String phonenumber;
  final String custname;
  final List<FoodItem> items;

  int status; //-1=paymentnotdone ,0=paymentdone, 1=orderaccepted, 2=orderready, 3=DONE

  Orderr(this.orderid, this.phonenumber, this.custname, this.items, this.status);
}
