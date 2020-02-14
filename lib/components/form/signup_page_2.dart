import 'dart:io';

import 'package:ah_mobile/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ah_mobile/utilities/utilities.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'auth_form_input.dart';
import 'components.dart';

enum SelectedImageSource {
  camera,
  gallery,
}

Future handleProfilePictureSelect(BuildContext context, FileFormField profilePic) async {
  final res = await showModalBottomSheet<SelectedImageSource>(
    useRootNavigator: true,
    context: context,
    builder: (context) {
      return Container(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[Text('Camera'), Icon(Icons.camera)],
                ),
                onPressed: () {
                  Navigator.of(context).pop<SelectedImageSource>(SelectedImageSource.camera);
                },
              ),
            ),
            VerticalDivider(
              thickness: 2,
              color: Colors.grey,
            ),
            Expanded(
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Gallery'),
                    Icon(Icons.image),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop<SelectedImageSource>(SelectedImageSource.gallery);
                },
              ),
            ),
          ],
        ),
      );
    },
  );

  ImageSource source;
  if (res == SelectedImageSource.camera) {
    source = ImageSource.camera;
  } else if (res == SelectedImageSource.gallery) {
    source = ImageSource.gallery;
  } else {
    return;
  }

  try {
    File selectedImage = await ImagePicker.pickImage(source: source);
    if (selectedImage == null) return;

    selectedImage = await ImageCropper.cropImage(
      sourcePath: selectedImage.path,
      // maxHeight: 1000,
      // maxWidth: 1000,
      cropStyle: CropStyle.circle,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: "Author's Haven",
        toolbarColor: kCTAbuttonColor,
        toolbarWidgetColor: Colors.white,
        activeControlsWidgetColor: kCTAbuttonColor,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
    );
    profilePic.file = selectedImage;
  } catch (e) {
    print(e);
  }
}

class _SignUpPage2 extends StatelessWidget {
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static Fnodes focusNodes = Fnodes();
  final AuthFormField username;
  final AuthFormField bio;
  final FileFormField profilePic;
  final PageHandler pageHandler;

  _SignUpPage2({
    Key key,
    this.username,
    this.bio,
    this.profilePic,
    this.pageHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    focusNodes.provideContext(context);

    bool hasImage = profilePic.file != null;

    bool isFormValid = username.isValid == true && bio.isValid == true;

    username.validate();
    bio.validate();

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
          child: Column(
            children: <Widget>[
              FormTitleBar(
                mainTitle: 'Step 2!',
                subTitle: 'the interesting parts',
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 30, 5, 10),
                      child: GestureDetector(
                        onTap: () => handleProfilePictureSelect(context, profilePic),
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: hasImage ? FileImage(profilePic.file) : AssetImage('images/default_profile_image.png'),
                            ),
                            borderRadius: BorderRadius.circular(150),
                            border: Border.fromBorderSide(
                              BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Align(
                            alignment: FractionalOffset(1, 0.9),
                            child: Container(
                              height: 35,
                              width: 35,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 12.5,
                                    left: 11.5,
                                    child: Container(
                                      height: 15.5,
                                      width: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    child: Icon(
                                      Icons.add_a_photo,
                                      size: 35,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AuthFormInput(
                      field: username,
                      textInputAction: TextInputAction.next,
                      focusNode: focusNodes.getNode('username'),
                      label: 'username',
                      prefixIcon: FormInputIcon(
                        field: username,
                        icon: Icons.person_outline,
                      ),
                      onBlur: username.blur,
                      onChanged: (val) => username.value = val,
                      autofocus: true,
                      onFieldSubmitted: (_) => focusNodes.transferFocus('username', 'bio'),
                    ),
                    AuthFormInput(
                      field: bio,
                      textInputAction: TextInputAction.next,
                      minLines: 2,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      focusNode: focusNodes.getNode('bio'),
                      label: 'bio',
                      prefixIcon: FormInputIcon(
                        field: bio,
                        icon: Icons.short_text,
                        height: 115,
                      ),
                      onBlur: bio.blur,
                      onChanged: (val) => bio.value = val,
                      onFieldSubmitted: (_) => focusNodes.transferFocus('bio'),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FormButton(
                    child: AuthButtonText('Back'),
                    onPressed: () {
                      focusNodes.removeFocus();
                      pageHandler.previous();
                      Navigator.of(context).pop();
                    },
                  ),
                  FormButton(
                    child: AuthButtonText('Next'),
                    onPressed: isFormValid
                        ? () {
                            pageHandler.next();
                            focusNodes.removeFocus();
                            _formKey.currentState..save();
                            Navigator.of(context).pushNamed('signup/page3');
                          }
                        : null,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SignUpPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<SignUpData, Tuple4<AuthFormField, AuthFormField, FileFormField, PageHandler>>(
      selector: (_, data) => Tuple4(data.username, data.bio, data.profilePic, data.pageHandler),
      builder: (_, data, __) => _SignUpPage2(
        username: data.item1,
        bio: data.item2,
        profilePic: data.item3,
        pageHandler: data.item4,
      ),
    );
  }
}
