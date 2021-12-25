import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_tracking/data/firebasedata.dart';
import 'package:covid_tracking/screen/sendrequest.dart';
import 'package:hive/hive.dart';
part 'sendingdata_state.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference reference =
    firebaseFirestore.collection("SendingRequest");
Firebasedata firebasedata =
    Firebasedata(names: name, address: address, ages: age, contacts: contact);
var names, senderaddress;

class SendingdataCubit extends Cubit<SendingdataInitial> {
  SendingdataCubit()
      : super(SendingdataInitial(
            address: 'junagam',
            age: '99',
            name: 'jashmehta',
            number: '7096747394'));
  void submit() {
    getdata();
    if (names != null && senderaddress != null) {
      reference.add({
        'Name': names,
        'Address': senderaddress,
        'Contact': firebasedata.contacts,
        'Age': firebasedata.ages
      });
      print("we are printing this 1");
      // emit(SendingdataInitial(
      //     name: names!.names as String,
      //     address: senderaddress!.address as String,
      //     number: firebasedata.contacts,
      //     age: firebasedata.ages));
    } else {
      reference.add({
        'Name': firebasedata.names,
        'Address': firebasedata.address,
        'Contact': firebasedata.contacts,
        'Age': firebasedata.ages
      });
      print("we are printing 2");
      // emit(SendingdataInitial(
      //     name: firebasedata.names as String,
      //     address: firebasedata.address as String,
      //     number: firebasedata.contacts,
      //     age: firebasedata.ages));
    }
  }

  void getdata() {
    var boxs = Hive.box('senderdetail');
    names = boxs.get('name');
    senderaddress = boxs.get('address');
  }
}
