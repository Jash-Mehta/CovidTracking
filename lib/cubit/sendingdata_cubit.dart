import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_tracking/data/firebasedata.dart';
import 'package:covid_tracking/screen/sendrequest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
part 'sendingdata_state.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference reference =
    firebaseFirestore.collection("SendingRequest");
final FirebaseAuth auth = FirebaseAuth.instance;
var uid = auth.currentUser!.uid;
Firebasedata firebasedata =
    Firebasedata(name: name, address: address, ages: age, contacts: contact);
var names, senderaddress;

class SendingdataCubit extends Cubit<SendingdataInitial> {
  SendingdataCubit()
      : super(SendingdataInitial(
            address: 'junagam',
            age: '99',
            name: 'jashmehta',
            number: '7096747394'));

  void submit() { 
   if (name != null && address != null) {
      reference.doc(uid).set({
        'Name': firebasedata.name,
        'Address': firebasedata.address,
        'Contact': firebasedata.contacts,
        'Age': firebasedata.ages
      }, SetOptions(merge: true));
      print("we are printing 2");
      print(name);
      // emit(SendingdataInitial(
      //     name: firebasedata.names as String,
      //     address: firebasedata.address as String,
      //     number: firebasedata.contacts,
      //     age: firebasedata.ages));
    } else {
      getdata();
      reference.doc(uid).set(
          {
            'Name': names,
            'Address': senderaddress,
            'Contact': firebasedata.contacts,
            'Age': firebasedata.ages
          },
          SetOptions(
            merge: true,
          ));
      print("We are printing 3");
    }
  }

  void getdata() {
    var boxs = Hive.box('senderdetail');
    names = boxs.get('name');
    senderaddress = boxs.get('address');
  }
}
