import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/address_model.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';

import '../utils/widget_functions.dart';
import 'otp_verification_page.dart';

class UserProfilePage extends StatelessWidget {
  static const String routeName = '/profile';

  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('My Profile'),
      ),
      body: userProvider.userModel == null
          ? const Center(
              child: Text('Failed to load user data'),
            )
          : ListView(
              children: [
                _headerSection(context, userProvider),
                ListTile(
                  leading: const Icon(Icons.call),
                  title: Text(userProvider.userModel!.phone ?? 'Not set yet'),
                  trailing: IconButton(
                    onPressed: () {
                      showSingleTextFieldInputDialog(
                        context: context,
                        title: 'Mobile Number',
                        onSubmit: (value) {
                          Navigator.pushNamed(
                              context, OtpVerificationPage.routeName,
                              arguments: value);
                        },
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: Text(userProvider.userModel!.age ?? 'Not set yet'),
                  subtitle: const Text('Date of Birth'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(userProvider.userModel!.gender ?? 'Not set yet'),
                  subtitle: const Text('Gender'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(
                      userProvider.userModel!.addressModel?.addressLine1 ??
                          'Not set yet'),
                  subtitle: const Text('Address Line 1'),
                  trailing: IconButton(
                    onPressed: () {
                      showSingleTextFieldInputDialog(
                        context: context,
                        title: 'Set Address Line 1',
                        onSubmit: (value) {
                          userProvider.updateUserProfileField(
                              '$userFieldAddressModel.$addressFieldAddressLine1',
                              value);
                        },
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(
                      userProvider.userModel!.addressModel?.addressLine2 ??
                          'Not set yet'),
                  subtitle: const Text('Address Line 2'),
                  trailing: IconButton(
                    onPressed: () {
                      showSingleTextFieldInputDialog(
                        context: context,
                        title: 'Set Address Line 2',
                        onSubmit: (value) {
                          userProvider.updateUserProfileField(
                              '$userFieldAddressModel.$addressFieldAddressLine2',
                              value);
                        },
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(userProvider.userModel!.addressModel?.city ??
                      'Not set yet'),
                  subtitle: const Text('City'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(userProvider.userModel!.addressModel?.zipcode ??
                      'Not set yet'),
                  subtitle: const Text('Zip Code'),
                  trailing: IconButton(
                    onPressed: () {
                      showSingleTextFieldInputDialog(
                        context: context,
                        title: 'Set Zip Code',
                        onSubmit: (value) {
                          userProvider.updateUserProfileField(
                              '$userFieldAddressModel.$addressFieldZipcode',
                              value);
                        },
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
              ],
            ),
    );
  }

  Container _headerSection(BuildContext context, UserProvider userProvider) {
    return Container(
      height: 150,
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Card(
            elevation: 5,
            child: userProvider.userModel!.imageUrl == null
                ? const Icon(
                    Icons.person,
                    size: 90,
                    color: Colors.grey,
                  )
                : CachedNetworkImage(
                    width: 90,
                    height: 90,
                    imageUrl: userProvider.userModel!.imageUrl!,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userProvider.userModel!.displayName ?? 'No Display Name',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
              Text(
                userProvider.userModel!.email,
                style: TextStyle(color: Colors.white60),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
