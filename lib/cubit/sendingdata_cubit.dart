import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_tracking/data/firebasedata.dart';
import 'package:meta/meta.dart';

part 'sendingdata_state.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference reference =
    firebaseFirestore.collection("SendingRequest");
Firebasedata? firebasedata;
HiveSendingdata? hiveSendingdata;

class SendingdataCubit extends Cubit<SendingdataInitial> {
  SendingdataCubit()
      : super(SendingdataInitial(
            address: 'junagam',
            age: '99',
            name: 'jashmehta',
            number: '7096747394'));
  void submit() {
    reference.add({
      'Name': firebasedata!.name,
      'Address': firebasedata!.address,
      'Contact': firebasedata!.contact,
      'Age': firebasedata!.age
    });
    emit(SendingdataInitial(
        name: firebasedata!.name as String,
        address: firebasedata!.address as String,
        number: firebasedata!.contact,
        age: firebasedata!.age));
  }

  void hivesubmit() {
    reference.add({
      'Name': hiveSendingdata!.name,
      'Address': hiveSendingdata!.address,
      'Contact': firebasedata!.contact,
      'Age': firebasedata!.age
    });
    emit(SendingdataInitial(
        name: hiveSendingdata!.name as String,
        address: hiveSendingdata!.address as String,
        number: firebasedata!.contact,
        age: firebasedata!.age));
  }
}
