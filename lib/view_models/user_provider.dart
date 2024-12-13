import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:brototypeuserlist/models/newusermodel.dart';

class UserProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  NewUserModel? _userModel;
  NewUserModel get userModel => _userModel!;
  List<NewUserModel> _userList = [];
  
  ValueNotifier<String> selectedCategoryNotifier = ValueNotifier<String>('all');

  
  List<NewUserModel> get userList => _userList;
  bool _isLoading = false;

  String _selectedCategory = 'all';
  String _searchQuery = '';

  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  set selectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  set searchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Add user to Firestore
  void addUser({
    required BuildContext context,
    required NewUserModel userlist,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final userId = _firestore.collection('addusers').doc().id;
      NewUserModel userModel = NewUserModel(
        name: userlist.name,
        age: userlist.age,
        uid: userId,
      );

      // Save user data to Firestore
      await _firestore
          .collection('addusers')
          .doc(userModel.uid)
          .set(userModel.toMap());

      _userModel = userModel;
      Provider.of<UserProvider>(context, listen: false).refreshUserList();
      _isLoading = false;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Error adding user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add user: $e')),
      );
    }
  }

  // Fetch user data from Firestore
  Stream<List<NewUserModel>> fetchUserData() {
    return FirebaseFirestore.instance
        .collection("addusers")
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return NewUserModel.fromMap(data);
      }).toList();
    }).handleError((e) {
      throw Exception("Failed to fetch data: $e");
    });
  }

  void refreshUserList() {
    fetchUserData().listen((newList) {
      _userList = newList;
      notifyListeners();
    }, onError: (e) {
      print('Error refreshing user list: $e');
    });
  }

  // Fetch filtered user data based on the selected category
  Stream<List<NewUserModel>> fetchFilteredUsers() {
    if (selectedCategoryNotifier.value == 'all' ||
        selectedCategoryNotifier.value == '') {
      return fetchUserData();
    } else if (selectedCategoryNotifier.value == 'younger') {
      return fetchYoungerUsers();
    } else if (selectedCategoryNotifier.value == 'older') {
      return fetchOlderUsers();
    }
    return Stream.value([]);
  }

  Stream<List<NewUserModel>> fetchYoungerUsers() {
    return FirebaseFirestore.instance
        .collection('addusers')
        .where('age', isLessThan: 60)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        return [];
      }
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return NewUserModel.fromMap(data);
      }).toList();
    });
  }

  Stream<List<NewUserModel>> fetchOlderUsers() {
    return FirebaseFirestore.instance
        .collection('addusers')
        .where('age', isGreaterThanOrEqualTo: 60)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        return [];
      }
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return NewUserModel.fromMap(data);
      }).toList();
    });
  }
  Stream<List<NewUserModel>> searchname() {
  return _firestore.collection('addusers').snapshots().map((querySnapshot) {
    if (_searchQuery.isEmpty) {
      // If the search query is empty, return all users
      return querySnapshot.docs.map((doc) {
        final data = doc.data() ;
        return NewUserModel.fromMap(data);
      }).toList();
    } else {
      // Filter users based on the search query
      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            final user = NewUserModel.fromMap(data);
            if (user.name!.toLowerCase().contains(_searchQuery.toLowerCase())) {
              return user; // Ensure the user is not nullable here
            }
            return null;
          })
          .where((user) => user != null)
          .cast<NewUserModel>() // Explicitly cast to List<NewUserModel>
          .toList();
    }
  }).handleError((e) {
    // Handle errors
    print("Error fetching data: $e");
    throw Exception("Failed to fetch data: $e");
  });
}

Stream<List<NewUserModel>> getFilteredUsers() {
    return fetchUserData().map((users) {
      return users.where((user) {
        final matchesCategory = (_selectedCategory == 'all') ||
            (_selectedCategory == 'younger' && user.age! < 30) ||
            (_selectedCategory == 'elder' && user.age! >= 30);
        final matchesSearch = user.name!.toLowerCase().contains(_searchQuery.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

}
