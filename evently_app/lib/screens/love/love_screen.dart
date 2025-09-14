import 'package:easy_localization/easy_localization.dart';
import 'package:evently_v2/config/firebase/fire_store.dart';
import 'package:evently_v2/core/cashing/cashing.dart';
import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:evently_v2/core/extension/build_context_extension.dart';
import 'package:evently_v2/core/models/event_model.dart';
import 'package:evently_v2/core/widgets/custome_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoveScreen extends StatefulWidget {
  const LoveScreen({super.key});

  @override
  State<LoveScreen> createState() => _LoveScreenState();
}

class _LoveScreenState extends State<LoveScreen> {
  TextEditingController? get _controller => TextEditingController();
  bool isDark = Cashing.getTheme();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              CustomeTextFormField(
                controller: _controller,
                prefixIcon: Icons.search,
                prefixIconColor: isDark
                    ? ColorsManager.blue56
                    : ColorsManager.grey7B,
                hintText: "search_for_event".tr(),
              ),
              SizedBox(height: 20.h,),
              StreamBuilder(
                stream: FireStore.getAllEvents(isFave: true),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          'something_went_wrong'.tr(),
                          style: context.labelMedium?.copyWith(
                            color: ColorsManager.blue56,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (!snapshot.hasData) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          'no_data_found'.tr(),
                          style: context.labelMedium?.copyWith(
                            color: ColorsManager.blue56,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          'no_data_found'.tr(),
                          style: context.labelMedium?.copyWith(
                            color: ColorsManager.blue56,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        var date = DateTime.fromMillisecondsSinceEpoch(
                          snapshot.data!.docs[index].data().date,
                        );
                        String month = DateFormat('MMM').format(date);
          
                       return Container(
                          padding: EdgeInsets.all(8),
                          width: double.infinity.w,
                          height: 200.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: ColorsManager.blue56,
                              width: 2.w,
                            ),
                            image: DecorationImage(
                              image: AssetImage(snapshot.data!.docs[index].data().imagePath),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 8.h,
                                ),
          
                                decoration: BoxDecoration(
                                  color: ColorsManager.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      date.toString().substring(8, 10),
                                      style: context.labelMedium?.copyWith(
                                        color: ColorsManager.blue56,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                    Text(
                                      month,
                                      style: context.labelSmall?.copyWith(
                                        color: ColorsManager.blue56,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
          
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorsManager.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: ListTile(
                                  title: Text(
                                    snapshot.data!.docs[index].data().title,
                                    style: context.labelSmall?.copyWith(
                                      color: ColorsManager.black1c,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      FireStore.updateEvent(
                                        snapshot.data!.docs[index].data().id,
                                        !snapshot.data!.docs[index]
                                            .data()
                                            .isFave,
                                      );
                                    },
                                    icon: Icon(
                                      snapshot.data!.docs[index].data().isFave
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 15.h);
                      },
                      itemCount: snapshot.data!.docs.length,
                    ),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
