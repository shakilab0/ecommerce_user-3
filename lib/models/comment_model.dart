import 'package:ecom_user_3/models/user_model.dart';

const String collectionComment='Comment';

const String commentFieldId='commentId';
const String commentFieldUserModel='userModel';
const String commentFieldProductId='productId';
const String commentFieldComment='comment';
const String commentFieldDate='date';
const String commentFieldApproved='approved';

class CommentModel{
  String? commentId;
  UserModel userModel;
  String productId;
  String comment;
  bool approved;
  String date;

  CommentModel({
     this.commentId,
    required this.userModel,
    required this.productId,
    required this.date,
    required this.comment,
    this.approved=false,
  });

  Map<String,dynamic>toMap(){
    return <String,dynamic>{
      commentFieldId:commentId,
      commentFieldUserModel:userModel.toMap(),
      commentFieldProductId:productId,
      commentFieldDate:date,
      commentFieldComment:comment,
      commentFieldApproved:approved,
    };
  }

  factory CommentModel.fromMap(Map<String,dynamic>map)=>CommentModel(
    commentId: map[commentFieldId],
    userModel:UserModel.fromMap( map[commentFieldUserModel]),
    productId: map[commentFieldProductId],
    date: map[commentFieldDate],
    comment: map[commentFieldComment],
    approved: map[commentFieldApproved],
  );

}