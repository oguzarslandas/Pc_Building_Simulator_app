
//region App Name
const mAppName = 'PC Creator';
//endregion

//region AppBase URl
const url = 'https://oldubilin.com'; // Don't add slash at the end of the url
const mBaseUrl = "$url/api/";

const termsConditionUrl = 'https://oldubilin.com/#/term-conditions/';
const privacyPolicyUrl = 'https://oldubilin.com/#/privacy-policy/';
const purchaseUrl = '';
const helpSupportUrl = 'https://oldubilin.com/#/contact-us/';
//endregion

//region Configs
const decimalPoint = 2;
const defaultLanguage = 'tr';
const perPageItem = 25;
const planRemainingDays = 15;
//endregion

//region Commission Types
const CommissionTypePercent = 'percent';
const CommissionTypeFixed = 'fixed';
//endregion

const DiscountTypeFixed = 'fixed';

//region One Signal Configuration
const mOneSignalAppId = '0a1b62c6-0415-45eb-a326-3bcb608a079d';  //01e97a22-4721-475e-a96d-62948ebfbaf4
const mOneSignalChannelId = "2c600ee0-9fcd-49a1-b611-f1267a6b5a67"; // 0ee01f0d-2e1c-4554-9050-27dd9c020292
const mOneSignalRestKey = "OGM2ODQwN2EtZTVhZS00NDY5LWJmY2MtNjMwOGNlMjQ1MDE5";  //NzFhNDZjYTEtOWUzYS00NzgxLThlZDktODYyYWZmOTQ1ODJk
//endregion

//region DemoUser
const demoUser = "demo@provider.com";
const demoHandyman = "demo@handyman.com";
const password="12345678";

//endregion

//region Messages
/// var passwordLengthMsg = 'Password length should be more than $passwordLengthGlobal';
//endregion

//region MapKey
const API_KEY = 'AIzaSyCHJwjZjGSOBc18-3mJM8tCqDYoV3Nk9tQ';
//endregion

//region LiveStream Keys
const tokenStream = 'tokenStream';
const streamTab = 'streamTab';
const LiveStreamUpdateBookings = 'LiveStreamUpdateBookings';
const HandyBoardStream = 'HandyBoardStream';
const handymanAllBooking = "handymanAllBooking";
const providerAllBooking = "providerAllBooking";

//endregion

//region Theme Mode Type
const ThemeModeLight = 0;
const ThemeModeDark = 1;
const ThemeModeSystem = 2;
//endregion

//region SharedPreferences Keys
const IS_FIRST_TIME = 'IsFirstTime';
const IS_LOGGED_IN = 'IS_LOGGED_IN';
const USER_ID = 'USER_ID';
const USER_TYPE = 'USER_TYPE';
const FIRST_NAME = 'FIRST_NAME';
const LAST_NAME = 'LAST_NAME';
const USER_EMAIL = 'USER_EMAIL';
const PROFILE_IMAGE = 'PROFILE_IMAGE';
const IS_REMEMBERED = "IS_REMEMBERED";
const TOKEN = 'TOKEN';
const USERNAME = 'USERNAME';
const DISPLAY_NAME = 'DISPLAY_NAME';
const CONTACT_NUMBER = 'CONTACT_NUMBER';
const COUNTRY_ID = 'COUNTRY_ID';
const STATE_ID = 'STATE_ID';
const CITY_ID = 'CITY_ID';
const STATUS = 'STATUS';
const ADDRESS = 'ADDRESS';
const PLAYERID = 'PLAYERID';
const UID = 'UID';
const SERVICE_ADDRESS_ID = 'SERVICE_ADDRESS_ID';
const PROVIDER_ID = 'PROVIDER_ID';
const TOTAL_BOOKING = 'total_booking';
const CREATED_AT = 'created_at';
const IS_PLAN_SUBSCRIBE = 'IS_PLAN_SUBSCRIBE';
const PLAN_TITLE = 'PLAN_TITLE';
const PLAN_END_DATE = 'PLAN_END_DATE';
const PLAN_IDENTIFIER = 'PLAN_IDENTIFIER';
const PAYMENT_LIST = 'PAYMENT_LIST';

//endregion

//region  Login Type
const UserTypeProvider = 'provider';
const UserTypeHandyman = 'handyman';
const UserStatusCode = 1;
//endregion

//region Notification Mark as Read
const MarkAsRead = 'markas_read';
//endregion

//region service type
//region SERVICE TYPE

const ServiceTypeHourly = 'hourly';
const ServiceTypeFixed = 'fixed';
const TXT_HOURLY = 'hr';
//endregion

//region service payment method
const COD = 'cash';
//endregion

//region service payment status
const PAID = 'paid';
const PENDING = 'pending';
//endregion

const RESTORE = "restore";
const FORCE_DELETE = "forcedelete";
const type = "type";

//region default handyman login
const DEFAULT_PROVIDER_EMAIL = 'demo@provider.com';
const DEFAULT_HANDYMAN_EMAIL = 'demo@handyman.com';
const DEFAULT_PASS = '12345678';
//endregion

//region currency
const CURRENCY_COUNTRY_SYMBOL = 'CURRENCY_COUNTRY_SYMBOL';
const CURRENCY_COUNTRY_CODE = 'CURRENCY_COUNTRY_CODE';
const CURRENCY_COUNTRY_ID = 'CURRENCY_COUNTRY_ID';
//endregion

//region ADS
const showMobileAds = true;
const INITIAL_AD_COUNT = 'INITIAL_AD_COUNT';
const SHOW_INITIAL_AD_NUMBER = 3;
const maxFailedLoadAttempts = 3;
const bannerAdIdForAndroid = 'ca-app-pub-3940256099942544/6300978111';
const bannerAdIdForIos = 'ca-app-pub-3940256099942544/2934735716';
//endregions

//region Mail And Tel URL
const MAIL_TO = 'mailto:';
const TEL = 'tel:';
//endregion

//region FireBase Collection Name
const MESSAGES_COLLECTION = "messages";
const USER_COLLECTION = "users";
const CONTACT_COLLECTION = "contact";
const CHAT_DATA_IMAGES = "chatImages";

const IS_ENTER_KEY = "IS_ENTER_KEY";
const SELECTED_WALLPAPER = "SELECTED_WALLPAPER";
const PER_PAGE_CHAT_COUNT = 50;

const TEXT = "TEXT";
const IMAGE = "IMAGE";

const VIDEO = "VIDEO";
const AUDIO = "AUDIO";
//endregion

//region RTLLanguage
List<String> RTLLanguage = ['ar', 'ur'];
//endregion

//region MessageType
enum MessageType {
  TEXT,
  IMAGE,
  VIDEO,
  AUDIO,
}
//endregion

//region MessageExtension
extension MessageExtension on MessageType {
  String? get name {
    switch (this) {
      case MessageType.TEXT:
        return 'TEXT';
      case MessageType.IMAGE:
        return 'IMAGE';
      case MessageType.VIDEO:
        return 'VIDEO';
      case MessageType.AUDIO:
        return 'AUDIO';
      default:
        return null;
    }
  }
}
//endregion

//region SERVICE PAYMENT STATUS
const SERVICE_PAYMENT_STATUS_PAID = 'paid';
const SERVICE_PAYMENT_STATUS_PENDING = 'pending';
//endregion

//region PAYMENT METHOD
const PAYMENT_METHOD_COD = 'cash';
const PAYMENT_METHOD_STRIPE = 'stripe';
const PAYMENT_METHOD_RAZOR = 'razorPay';
const PAYMENT_METHOD_FLUTTER_WAVE = 'flutterwave';
//endregion

//region DateFormat
const DATE_FORMAT_1 = 'M/d/yyyy hh:mm a';
const DATE_FORMAT_2 = 'd-MM-yyyy';
const DATE_FORMAT_3 = 'HH:mm';
const DATE_FORMAT_4 = 'd/MM';
const DATE_FORMAT_5 = 'yyyy';
const DATE_FORMAT_6 = 'd-MM-yyyy';
const DATE_FORMAT_7 = 'yyyy-MM-dd';
//endregion

//region SUBSCRIPTION PAYMENT STATUS
const SUBSCRIPTION_STATUS_ACTIVE = 'active';
const SUBSCRIPTION_STATUS_INACTIVE = 'inactive';
//endregion

//region EARNING TYPE
const EARNING_TYPE = 'EARNING_TYPE';
const EARNING_TYPE_COMMISSION = 'commission';
const FREE = 'free';
//endregion