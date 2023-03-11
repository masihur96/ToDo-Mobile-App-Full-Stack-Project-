import 'package:dio/dio.dart';
import '../model/constants.dart';
import '../model/preferences.dart';
import '../model/task_model.dart';
import '../model/user_model.dart';
import 'connection_helper.dart';

class DataFetcher {
  final ConnectionHelper _connectionHelper = ConnectionHelper();

  SharedPref pref = SharedPref();
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    // required String nid,
  }) async {
    bool status = false;
    dynamic data = {
      "name": name,
      "email": email,
      "password": password,

    };

    Response<dynamic>? response =
    await _connectionHelper.postData(AppUrls.registerUser, data);
    print(response);
    if (response != null) {
      if (response.statusCode == 201) {
        status = true;
      }
    }
    return status;
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    User? user;
    FormData formData = FormData.fromMap({
      "username": email, "password": password
    });


    Response<dynamic>? response =
    await _connectionHelper.postData(AppUrls.loginUser, formData);


    if (response != null) {
      if (response.statusCode == 200) {
        try {
          var data = response.data;
          // print("Token: ${data["access_token"]}");
          // print("Type: ${data["token_type"]}");
          // print("User Id: ${data["data"]["id"]}");
         await pref.setToken(token: "${data["access_token"]}");
         await pref.setUserId(id: "${data["data"]["id"]}");

         print(await pref.getToken());
         print(await pref.getUserId());
          //

          user = User(
            userId:data["data"]["id"],
            userName: data["data"]["name"],
            email: data["data"]["email"],
          );
        } catch (e) {
          print(e);

        }
      }
    }
    return user;
  }

  Future<User?> retrieveUserWithUid({

    required String customerUid,
  }) async {
    User? user;
    Response<dynamic>? response =
    await _connectionHelper.getData(AppUrls.getUser + customerUid);
    if (response != null) {
      if (response.statusCode == 200) {
        try {
          var data = response.data;
          user = User(
            userName: data["name"],
            email: data["email"],
            userId: data["id"],
          );
        } catch (e) {

          print(e);
        }
      }
    }
    return user;
  }

  Future<List<User>?> retrieveAllUser() async {
   List<User> users=[];
    Response<dynamic>? response =
    await _connectionHelper.getData(AppUrls.getUser);

    if (response != null) {
      if (response.statusCode == 200) {
        try {
          var data = response.data;

          List<dynamic> dataList = data;
          print("User List: ${dataList.length}");
          for( int d=0;d<dataList.length; d++) {
            // print(dataList[d]['title']);
            users.add(User(
              userName: data[d]["name"],
              email: data[d]["email"],
              userId: data[d]["id"],
            ));
          }

        } catch (e) {

          print(e);
        }
      }
    }
    return users;
  }

  Future<List<Task>?> retrieveAllTask() async {
    List<Task> tasks=[];
    Response<dynamic>? response =
    await _connectionHelper.getData(AppUrls.getTask);
    //
    // print(response);
    if (response != null) {
      if (response.statusCode == 200) {
        try {
          var data = response.data;
       //   print(data.length);

          List<dynamic> dataList = data;

          for( int d=0;d<dataList.length; d++) {
            // print(dataList[d]['title']);
           tasks.add(Task(
             title: dataList[d]['title'],
               taskId: dataList[d]['id'],
               body:  dataList[d]['body'],
               isFinished:  dataList[d]['isFinished'],
             submitorId: dataList[d]['assign_to_id'],
             user_id: dataList[d]['user_id'],

           ));
          }
        //  print(tasks.length);

        } catch (e) {

          print(e);
        }
      }
    }

    return tasks;

  }

  Future<Task?> createTask({
    required String title,
    required String body,
    required String isFinished,
    required String assignTo,
    required String assignBy,
  }) async {
    Task? task;
    FormData formData = FormData.fromMap({
      "title": title, "body": body,"isFinished":isFinished,"user_id":assignBy,"assign_to_id":assignTo
    });


    Response<dynamic>? response =
    await _connectionHelper.postData(AppUrls.createTask, formData);


    if (response != null) {
      if (response.statusCode == 200) {
        try {
          var data = response.data;

          // task = User(
          //   userId:data["data"]["id"],
          //   userName: data["data"]["name"],
          //   email: data["data"]["email"],
          // );
        } catch (e) {
          print(e);

        }
      }
    }
    return task;
  }

  // Future<User?> getValidity({
  //   required String deviceId,
  // }) async {
  //   User? user;
  //   Map<String, dynamic> deviceCodeMap = <String, dynamic>{
  //     'device_code': deviceId,
  //   };
  //   FormData formData = FormData.fromMap(deviceCodeMap);
  //
  //   Response<dynamic>? response =
  //   await _connectionHelper.postData(AppUrls.checkDevice, formData);
  //   if (response != null) {
  //     if (response.statusCode == 201) {
  //       var data = response.data["data"];
  //       if (data['status'] == 1) {
  //         user = User(
  //           status: data['status'],
  //           userId: data['user_id'],
  //           userName: data['user_name'],
  //           email: data['email'],
  //           pCompanyId: data['pcompany_id'],
  //           companyName: data['company_name'],
  //         );
  //       } else {
  //         user = User(
  //           status: 0,
  //         );
  //       }
  //     } else {
  //       user = User(
  //         status: 0,
  //       );
  //     }
  //   }
  //   return user;
  // }



// // EVCS API
  // Future<VersionResponse?> checkVersion() async {
  //   VersionResponse? versionResponse;
  //   var response = await _connectionHelper.getData(
  //       "https://api.evidentbd.com/avcs/api/v1/version_controller/get-one-version/IK/");
  //   if (response != null) {
  //     try {
  //       var data = response.data["data"];
  //       if (response.statusCode == 200) {
  //         try {
  //           versionResponse = VersionResponse(
  //             androidLatestVersion: data["android_latest"],
  //             androidMinimumVersion: data["android_min"],
  //             iosLatestVersion: data["ios_latest"],
  //             iosMinimumVersion: data["ios_min"],
  //           );
  //         } catch (e) {
  //           print(e);
  //         }
  //       }
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  //   return versionResponse;
  // }

  // Future<Box?> fetchBoxFromQR({
  //   required String userId,
  //   required String boxUid,
  // }) async {
  //   Box? scannedBox;
  //   Map<String, dynamic> boxData = <String, dynamic>{
  //     'box_uid': boxUid,
  //     'user_id': userId,
  //   };
  //   print("Box Data: ${boxData}");
  //   FormData formData = FormData.fromMap(boxData);
  //   Response<dynamic>? response =
  //   await _connectionHelper.postData(AppUrls.boxDetails, formData);
  //   if (response != null) {
  //     if (response.statusCode == 200) {
  //       var data = response.data["box"];
  //       List<Package> packages = [];
  //       Country country = Country(
  //         id: data['shipment']['country']['id'],
  //         name: data['shipment']['country']['name'],
  //         pcompanyId: data['shipment']['country']['pcompany_id'],
  //         createdAt: data['shipment']['country']['created_at'],
  //         updatedAt: data['shipment']['country']['updated_at'],
  //       );
  //       Shipment shipment = Shipment(
  //         id: data['shipment']['id'],
  //         name: data['shipment']['name'],
  //         countryId: data['shipment']['country_id'],
  //         shipmentDate: data['shipment']['shipment_date'],
  //         pcompanyId: data['shipment']['pcompany_id'],
  //         companyId: data['shipment']['company_id'],
  //         createdUserId: data['shipment']['created_user_id'],
  //         createdAt: data['shipment']['created_at'],
  //         updatedAt: data['shipment']['updated_at'],
  //         country: country,
  //       );
  //       for (var package in data['packages']) {
  //         Product product = Product(
  //           id: package['product']['id'],
  //           name: package['product']['name'],
  //           sku: package['product']['sku'],
  //           pcompanyId: package['product']['pcompany_id'],
  //           createdAt: package['product']['created_at'],
  //           updatedAt: package['product']['updated_at'],
  //           price: package['product']['price'].toString(),
  //         );
  //         packages.add(
  //           Package(
  //             id: package['id'],
  //             boxId: package['box_id'],
  //             productId: package['product_id'],
  //             quantity: package['quantity'],
  //             pcompanyId: package['pcompany_id'],
  //             createdAt: package['created_at'],
  //             updatedAt: package['updated_at'],
  //             product: product,
  //           ),
  //         );
  //       }
  //       scannedBox = Box(
  //         id: data['id'],
  //         name: data['name'],
  //         shipmentId: data['shipment_id'],
  //         receiveDate: data['receive_date'],
  //         receivedUserId: data['received_user_id'],
  //         dispatchedByUserId: data['dispatched_by_user_id'],
  //         dispatchDatetime: data['dispatch_datetime'],
  //         receiverCustomerId: data['receiver_customer_id'],
  //         pcompanyId: data['pcompany_id'],
  //         createdAt: data['created_at'],
  //         updatedAt: data['updated_at'],
  //         uid: data['uid'],
  //         shipment: shipment,
  //         packages: packages,
  //       );
  //     } else {
  //       scannedBox = Box(name: "Input a Valid Qr Code");
  //     }
  //   }
  //   return scannedBox;
  // }
  //
  // Future<List<Customer>> fetchCustomer({
  //   required int userId,
  //   required int pCompanyId,
  // }) async {
  //   List<Customer> customers = [];
  //   Map<String, dynamic> customerReqData = {
  //     'user_id': userId,
  //     'pcompany_id': pCompanyId,
  //   };
  //   print(customerReqData);
  //   FormData formData = FormData.fromMap(customerReqData);
  //   Response<dynamic>? response =
  //   await _connectionHelper.postData(AppUrls.getCustomers, formData);
  //   if (response != null) {
  //     if (response.statusCode == 201) {
  //       var data = response.data['data'];
  //       for (var eachData in data) {
  //         customers.add(
  //           Customer(
  //             id: eachData['id'],
  //             name: eachData['name'],
  //           ),
  //         );
  //       }
  //     }
  //   }
  //   return customers;
  // }
  //
  // Future<List<Customer>> fetchShipment({
  //   required String deviceCode,
  // }) async {
  //   List<Customer> customers = [];
  //   // Map<String, dynamic> customerReqData = {
  //   //   'device_code': deviceCode,
  //   // };
  //   // print(customerReqData);
  //   // FormData formData = FormData.fromMap(customerReqData);
  //   Response<dynamic>? response = await _connectionHelper.getDataWithQuery(
  //     "https://inventorykeeper.net/api/v2/shipment-list?device_code=$deviceCode",
  //   );
  //   if (response != null) {
  //     if (response.statusCode == 200) {
  //       var data = response.data['data'];
  //       for (var eachData in data) {
  //         customers.add(
  //           Customer(
  //             id: eachData['id'],
  //             name: eachData['name'],
  //           ),
  //         );
  //       }
  //     }
  //   }
  //   return customers;
  // }
  //
  // Future<CustomResponse?> confirmBoxes({
  //   required int userId,
  //   required String boxIds,
  //   int force = 0,
  // }) async {
  //   CustomResponse? status;
  //   Map<String, dynamic> data = {
  //     'user_id': userId,
  //     'box_ids': boxIds,
  //     'force': force
  //   };
  //   FormData formData = FormData.fromMap(data);
  //   Response<dynamic>? response =
  //   await _connectionHelper.postData(AppUrls.confirmBoxes, formData);
  //   if (response != null) {
  //     var data = response.data;
  //     if (response.statusCode == 201) {
  //       List<String> boxes = [];
  //       var data = response.data;
  //       for (var eachData in data['received_boxes']) {
  //         boxes.add(eachData['name']);
  //       }
  //       status = CustomResponse(
  //         status: 1,
  //         success: data['success'],
  //         actionBoxes: boxes,
  //       );
  //     } else if (response.statusCode == 400) {
  //       List<String> boxes = [];
  //       var data = response.data;
  //       if (data['data']['already_received_boxes'] != null) {
  //         for (var eachData in data['data']['already_received_boxes']) {
  //           boxes.add(eachData['name']);
  //         }
  //       }
  //       status = CustomResponse(
  //         status: 2,
  //         success: data['success'],
  //         details: data['details'],
  //         actionBoxes: boxes,
  //       );
  //     } else {
  //       status = CustomResponse(
  //         status: 0,
  //       );
  //     }
  //   }
  //   return status;
  // }
  //
  // Future<CustomResponse?> disPatchBoxes({
  //   required int userId,
  //   required String boxIds,
  //   required int customerId,
  //   int force = 0,
  // }) async {
  //   CustomResponse? status;
  //   Map<String, dynamic> data = {
  //     'user_id': userId,
  //     'box_ids': boxIds,
  //     'customer_id': customerId,
  //     'force': force
  //   };
  //   FormData formData = FormData.fromMap(data);
  //   Response<dynamic>? response =
  //   await _connectionHelper.postData(AppUrls.dispatchBoxes, formData);
  //   if (response != null) {
  //     var data = response.data;
  //     if (response.statusCode == 400) {
  //       List<String> unrecievedBoxes = [];
  //       List<String> dispatchedBoxes = [];
  //       var data = response.data;
  //       if (data['data']['unreceived_boxes'] != null) {
  //         for (var eachData in data['data']['unreceived_boxes']) {
  //           unrecievedBoxes.add(eachData['name']);
  //         }
  //       }
  //       if (data['data']['dispatched_boxes'] != null) {
  //         for (var eachData in data['data']['dispatched_boxes']) {
  //           dispatchedBoxes.add(eachData['name']);
  //         }
  //       }
  //       status = CustomResponse(
  //         status: data['data']['status'],
  //         success: data['success'],
  //         actionBoxes: dispatchedBoxes,
  //         unreceivedBoxes: unrecievedBoxes,
  //       );
  //     } else if (response.statusCode == 200) {
  //       List<String> dispatchedBoxes = [];
  //       for (var eachData in data['data']['dispatched_boxes']) {
  //         dispatchedBoxes.add(eachData['name']);
  //       }
  //       status = CustomResponse(
  //         status: data['status'],
  //         success: data['success'],
  //         actionBoxes: dispatchedBoxes,
  //       );
  //     } else {
  //       status = CustomResponse(
  //         status: 0,
  //       );
  //     }
  //   }
  //   return status;
  // }
  //
  // Future<CustomResponse?> transferBox({
  //   required String boxIds,
  //   required int shipmentId,
  //   int force = 0,
  // }) async {
  //   CustomResponse? status;
  //   Map<String, dynamic> data = {
  //     'box_ids': boxIds,
  //     'shipment_id': shipmentId,
  //   };
  //   print(data);
  //
  //   FormData formData = FormData.fromMap(data);
  //   Response<dynamic>? response =
  //   await _connectionHelper.postData(AppUrls.transferBoxes, formData);
  //   // print(response!.statusCode);
  //   if (response != null) {
  //     var data = response.data;
  //     print(response);
  //     if (response.statusCode == 400) {
  //       // List<String> transferredBoxes = [];
  //       // var data = response.data;
  //       // if (data['data']['unreceived_boxes'] != null) {
  //       //   for (var eachData in data['data']['unreceived_boxes']) {
  //       //     unrecievedBoxes.add(eachData['name']);
  //       //   }
  //       // }
  //       // if (data['data']['dispatched_boxes'] != null) {
  //       //   for (var eachData in data['data']['dispatched_boxes']) {
  //       //     dispatchedBoxes.add(eachData['name']);
  //       //   }
  //       // }
  //       // status = CustomResponse(
  //       //   status: data['data']['status'],
  //       //   success: data['success'],
  //       //   actionBoxes: dispatchedBoxes,
  //       //   unreceivedBoxes: unrecievedBoxes,
  //       // );
  //       status = CustomResponse(
  //         status: 0,
  //       );
  //     } else if (response.statusCode == 200) {
  //       // List<String> dispatchedBoxes = [];
  //       // for (var eachData in data['data']['dispatched_boxes']) {
  //       //   dispatchedBoxes.add(eachData['name']);
  //       // }
  //       print(data['success']);
  //       print(data['details']);
  //       status = CustomResponse(
  //         status: 1,
  //         success: data['success'],
  //         details: data['details'],
  //       );
  //
  //       print(status);
  //     } else {
  //       status = CustomResponse(
  //         status: 0,
  //       );
  //     }
  //   }
  //   return status;
  // }
}