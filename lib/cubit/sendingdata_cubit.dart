import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_tracking/data/firebasedata.dart';
import 'package:covid_tracking/screen/introscreen.dart';
import 'package:covid_tracking/screen/login.dart';
import 'package:covid_tracking/screen/sendrequest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
part 'sendingdata_state.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference reference =
    firebaseFirestore.collection("SendingRequest");

final CollectionReference userreference = firebaseFirestore.collection("Users");
final FirebaseAuth auth = FirebaseAuth.instance;
var uid = auth.currentUser!.uid;
Firebasedata firebasedata =
    Firebasedata(name: name, address: address, ages: age, contacts: contact);
var names, senderaddress;
UserData userData = UserData(introname:intronames, usercontact: phoneno );

class SendingdataCubit extends Cubit<SendingdataInitial> {
  SendingdataCubit()
      : super(SendingdataInitial(
            address: 'junagam',
            age: '99',
            name: 'jashmehta',
            number: '7096747394'));
// ignore: slash_for_doc_comments
/**
 * * Sending data to the collection("SendingRequest") to firebase.....
 */
  void submit() {
    if (name != null && address != null) {
      reference.doc(uid).set({
        'Name': firebasedata.name,
        'Address': firebasedata.address,
        'Contact': firebasedata.contacts,
        'Age': firebasedata.ages
      }, SetOptions(merge: true));
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
    }
  }

// ignore: slash_for_doc_comments
/**
 * * Getting Hive data.....
 */
  void getdata() {
    var boxs = Hive.box('senderdetail');
    names = boxs.get('name');
    senderaddress = boxs.get('address');
  }

// ignore: slash_for_doc_comments
/**
 * * Sending data to the collection("Users") on Firebase.....
 */
  void userdata() {
    userreference.doc(uid).set({
      'UserName':userData.introname,
      'UserPhoneno.': userData.usercontact,
    });
  }
}
