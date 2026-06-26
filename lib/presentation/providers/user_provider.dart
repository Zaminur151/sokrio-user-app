import 'package:flutter/material.dart';
import 'package:sokrio_user/domain/entities/user.dart';
import 'package:sokrio_user/domain/usecases/get_users.dart';

class UserProvider extends ChangeNotifier {
  final GetUsers getUsers;
  final TextEditingController searchController = TextEditingController();

  UserProvider({required this.getUsers}) {
    searchController.addListener(() {
      if (_searchQuery != searchController.text) {
        searchUsers(searchController.text);
      }
    });
    fetchUsers();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<User> _users = [];
  List<User> _filteredUsers = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _errorMessage;
  int _page = 1;
  int _totalPages = 1;
  String _searchQuery = '';

  List<User> get users => _filteredUsers;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  bool get hasReachedMax => _page > _totalPages;

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (_isLoading || _isLoadingMore) return;

    if (isRefresh) {
      _page = 1;
      _totalPages = 1;
      _errorMessage = null;
    }

    if (_page > _totalPages) return;

    if (_page == 1) {
      _isLoading = true;
    } else {
      _isLoadingMore = true;
    }
    notifyListeners();

    final result = await getUsers(page: _page, perPage: 10);

    result.fold(
      (response) {
        if (_page == 1) {
          _users = response.users;
        } else {
          final existingIds = _users.map((u) => u.id).toSet();
          final newUsers = response.users
              .where((u) => !existingIds.contains(u.id))
              .toList();
          _users.addAll(newUsers);
        }
        _totalPages = response.totalPages;
        _page++;
        _errorMessage = null;
        _applySearchFilter();
      },
      (failure) {
        _errorMessage = failure.message;
      },
    );

    _isLoading = false;
    _isLoadingMore = false;
    notifyListeners();
  }

  void searchUsers(String query) {
    _searchQuery = query;
    _applySearchFilter();
    notifyListeners();
  }

  void _applySearchFilter() {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      _filteredUsers = List.from(_users);
    } else {
      final queryParts = query.split(RegExp(r'\s+'));
      _filteredUsers = _users.where((user) {
        final fullName = user.fullName.toLowerCase();
        return queryParts.every((part) => fullName.contains(part));
      }).toList();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
