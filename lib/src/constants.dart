final RegExp NAME_VALIDATION_REGEX =
    RegExp(r"^(?! )[A-ZÀ-ÿ][-,a-zA-ZÀ-ÿ. ']*(?! )$");

final RegExp EMAIL_VALIDATION_REGEX =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

final RegExp PASSWORD_VALIDATION_REGEX =
    RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$");

final String PROF_PIC_PLACEHOLDER =
    "lib/src/assets/images/profile_pic_placeholder.jpg";
