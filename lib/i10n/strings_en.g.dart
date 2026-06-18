///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsCommonEn common = TranslationsCommonEn.internal(_root);
	late final TranslationsAddressEn address = TranslationsAddressEn.internal(_root);
	late final TranslationsAccountEn account = TranslationsAccountEn.internal(_root);
	late final TranslationsNoConnectionEn no_connection = TranslationsNoConnectionEn.internal(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn.internal(_root);
	late final TranslationsCartEn cart = TranslationsCartEn.internal(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn.internal(_root);
	late final TranslationsMyOrdersEn my_orders = TranslationsMyOrdersEn.internal(_root);
	late final TranslationsSearchEn search = TranslationsSearchEn.internal(_root);
	late final TranslationsProductEn product = TranslationsProductEn.internal(_root);
	late final TranslationsSellerProductEn seller_product = TranslationsSellerProductEn.internal(_root);
	late final TranslationsSellerEn seller = TranslationsSellerEn.internal(_root);
	late final TranslationsNavigationEn navigation = TranslationsNavigationEn.internal(_root);
	late final TranslationsErrorsEn errors = TranslationsErrorsEn.internal(_root);
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'search'
	String get search => 'search';

	/// en: 'cancel'
	String get cancel => 'cancel';

	/// en: 'yes'
	String get yes => 'yes';

	/// en: 'confirm'
	String get confirm => 'confirm';

	/// en: 'and'
	String get and => 'and';

	/// en: 'or'
	String get or => 'or';

	/// en: 'next'
	String get next => 'next';

	/// en: 'soon'
	String get soon => 'soon';

	/// en: 'now'
	String get now => 'now';

	/// en: 'guest'
	String get guest => 'guest';

	/// en: 'email'
	String get email => 'email';

	/// en: 'password'
	String get password => 'password';

	/// en: 'submit'
	String get submit => 'submit';

	/// en: 'change'
	String get change => 'change';

	/// en: 'price'
	String get price => 'price';

	/// en: 'quantity'
	String get quantity => 'quantity';

	/// en: 'checkout'
	String get checkout => 'checkout';

	/// en: 'hello'
	String get hello => 'hello';

	/// en: 'see all'
	String get see_all => 'see all';

	/// en: 'details'
	String get details => 'details';

	/// en: 'status'
	String get status => 'status';

	/// en: 'order date'
	String get order_date => 'order date';

	/// en: 'shipping address'
	String get shipping_address => 'shipping address';

	/// en: 'total amount'
	String get total_amount => 'total amount';

	/// en: 'from'
	String get from => 'from';

	/// en: 'buy now'
	String get buy_now => 'buy now';

	/// en: 'edit'
	String get edit => 'edit';

	/// en: 'login'
	String get login => 'login';

	/// en: 'login required'
	String get login_required => 'login required';

	/// en: 'back'
	String get back => 'back';

	/// en: 'shop'
	String get shop => 'shop';

	/// en: 'paw shop'
	String get paw_shop => 'paw shop';

	/// en: 'address'
	String get address => 'address';

	/// en: 'choose'
	String get choose => 'choose';

	/// en: 'loading data'
	String get loading_data => 'loading data';

	/// en: 'loading $data'
	String loading_data_name({required Object data}) => 'loading ${data}';

	/// en: 'seller mode'
	String get seller_mode => 'seller mode';

	/// en: 'buyer mode'
	String get buyer_mode => 'buyer mode';

	/// en: 'make sure all the data you have filled in is correct'
	String get make_sure_all_the_data_you_have_filled_in_is_correct => 'make sure all the data you have filled in is correct';

	/// en: 'please log in to access this page'
	String get please_login_to_access_this_page => 'please log in to access this page';

	/// en: 'please log in as a seller (Paw Shop) to access this page'
	String get please_login_as_a_seller_to_access_this_page => 'please log in as a seller (Paw Shop) to access this page';
}

// Path: address
class TranslationsAddressEn {
	TranslationsAddressEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAddressIndexEn index = TranslationsAddressIndexEn.internal(_root);
	late final TranslationsAddressFormEn form = TranslationsAddressFormEn.internal(_root);
}

// Path: account
class TranslationsAccountEn {
	TranslationsAccountEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAccountIndexEn index = TranslationsAccountIndexEn.internal(_root);
	late final TranslationsAccountProfileEn profile = TranslationsAccountProfileEn.internal(_root);
	late final TranslationsAccountChangePasswordEn change_password = TranslationsAccountChangePasswordEn.internal(_root);
	late final TranslationsAccountOptionsEn options = TranslationsAccountOptionsEn.internal(_root);
	late final TranslationsAccountCreateShopEn create_shop = TranslationsAccountCreateShopEn.internal(_root);
}

// Path: no_connection
class TranslationsNoConnectionEn {
	TranslationsNoConnectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'connection failed'
	String get connection_failed => 'connection failed';

	/// en: 'we couldn't reach the server. please try again later.'
	String get we_could_not_reach_the_server_please_try_again_later => 'we couldn\'t reach the server. please try again later.';

	/// en: 'try again'
	String get try_again => 'try again';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAuthOnboardingEn onboarding = TranslationsAuthOnboardingEn.internal(_root);
	late final TranslationsAuthLoginEn login = TranslationsAuthLoginEn.internal(_root);
	late final TranslationsAuthSignupEn signup = TranslationsAuthSignupEn.internal(_root);
	late final TranslationsAuthForgotPasswordEn forgot_password = TranslationsAuthForgotPasswordEn.internal(_root);
	late final TranslationsAuthResetPasswordEn reset_password = TranslationsAuthResetPasswordEn.internal(_root);
	late final TranslationsAuthSellerEn seller = TranslationsAuthSellerEn.internal(_root);
}

// Path: cart
class TranslationsCartEn {
	TranslationsCartEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'cart'
	String get cart => 'cart';

	/// en: 'my cart'
	String get my_cart => 'my cart';

	/// en: 'please log in to view your cart'
	String get please_log_in_to_view_your_cart => 'please log in to view your cart';

	/// en: 'item removed from cart'
	String get item_removed_from_cart => 'item removed from cart';

	/// en: 'failed to remove item. please try again.'
	String get failed_to_remove_item_please_try_again => 'failed to remove item. please try again.';

	/// en: 'failed to load cart. please check your connection.'
	String get failed_to_load_cart_please_check_your_connection => 'failed to load cart. please check your connection.';

	/// en: 'your cart is empty.'
	String get your_cart_empty => 'your cart is empty.';

	/// en: 'cart details'
	String get cart_details => 'cart details';

	/// en: 'total price'
	String get total_price => 'total price';

	/// en: 'proceed to checkout'
	String get proceed_to_checkout => 'proceed to checkout';

	/// en: 'error deleting item: $error'
	String error_deleting_item({required Object error}) => 'error deleting item: ${error}';

	/// en: 'proceeding with checkout...'
	String get proceeding_with_checkout => 'proceeding with checkout...';

	/// en: 'address not found'
	String get address_not_found => 'address not found';

	/// en: 'error retrieving address'
	String get error_retrieving_address => 'error retrieving address';

	/// en: 'seller not found'
	String get seller_not_found => 'seller not found';

	/// en: 'error retrieving seller name'
	String get error_retrieving_seller_name => 'error retrieving seller name';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsHomeIndexEn index = TranslationsHomeIndexEn.internal(_root);
	late final TranslationsHomeMostPopularEn most_popular = TranslationsHomeMostPopularEn.internal(_root);
	late final TranslationsHomeProductCategoryEn product_category = TranslationsHomeProductCategoryEn.internal(_root);
}

// Path: my_orders
class TranslationsMyOrdersEn {
	TranslationsMyOrdersEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsMyOrdersIndexEn index = TranslationsMyOrdersIndexEn.internal(_root);
	late final TranslationsMyOrdersDetailsEn details = TranslationsMyOrdersDetailsEn.internal(_root);
	late final TranslationsMyOrdersCheckoutEn checkout = TranslationsMyOrdersCheckoutEn.internal(_root);
}

// Path: search
class TranslationsSearchEn {
	TranslationsSearchEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'no products available'
	String get no_products_available => 'no products available';

	/// en: 'no products match your search'
	String get no_products_match_your_search => 'no products match your search';

	/// en: 'seller not found'
	String get seller_not_found => 'seller not found';
}

// Path: product
class TranslationsProductEn {
	TranslationsProductEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsProductDetailsEn details = TranslationsProductDetailsEn.internal(_root);
}

// Path: seller_product
class TranslationsSellerProductEn {
	TranslationsSellerProductEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSellerProductManageProductEn manage_product = TranslationsSellerProductManageProductEn.internal(_root);
}

// Path: seller
class TranslationsSellerEn {
	TranslationsSellerEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSellerHomeEn home = TranslationsSellerHomeEn.internal(_root);
	late final TranslationsSellerManageOrdersEn manage_orders = TranslationsSellerManageOrdersEn.internal(_root);
	late final TranslationsSellerCashierEn cashier = TranslationsSellerCashierEn.internal(_root);
	late final TranslationsSellerSettingsEn settings = TranslationsSellerSettingsEn.internal(_root);
}

// Path: navigation
class TranslationsNavigationEn {
	TranslationsNavigationEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'home'
	String get home => 'home';

	/// en: 'cart'
	String get cart => 'cart';

	/// en: 'my orders'
	String get my_orders => 'my orders';

	/// en: 'account'
	String get account => 'account';
}

// Path: errors
class TranslationsErrorsEn {
	TranslationsErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsErrorsCommonEn common = TranslationsErrorsCommonEn.internal(_root);
	late final TranslationsErrorsAuthEn auth = TranslationsErrorsAuthEn.internal(_root);
	late final TranslationsErrorsShopEn shop = TranslationsErrorsShopEn.internal(_root);
}

// Path: address.index
class TranslationsAddressIndexEn {
	TranslationsAddressIndexEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'my addresses'
	String get my_addresses => 'my addresses';

	/// en: 'add new address'
	String get add_new_address => 'add new address';

	/// en: 'edit address'
	String get edit_address => 'edit address';

	/// en: 'no address found'
	String get no_address_found => 'no address found';

	/// en: 'set as default'
	String get set_as_default => 'set as default';

	/// en: 'default'
	String get kDefault => 'default';

	/// en: 'shop pickup'
	String get shop_pickup => 'shop pickup';
}

// Path: address.form
class TranslationsAddressFormEn {
	TranslationsAddressFormEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'address label'
	String get address_title => 'address label';

	/// en: 'e.g., home, office'
	String get address_title_hint => 'e.g., home, office';

	/// en: 'seller name'
	String get seller_name => 'seller name';

	/// en: 'recipient name'
	String get recipient_name => 'recipient name';

	/// en: 'enter recipient name'
	String get recipient_name_hint => 'enter recipient name';

	/// en: 'phone number'
	String get phone_number => 'phone number';

	/// en: 'enter active phone number'
	String get phone_number_hint => 'enter active phone number';

	/// en: 'full address'
	String get full_address => 'full address';

	/// en: 'street name, house number, etc.'
	String get full_address_hint => 'street name, house number, etc.';

	/// en: 'province'
	String get province => 'province';

	/// en: 'select province'
	String get province_hint => 'select province';

	/// en: 'shop contact name'
	String get shop_contact_name => 'shop contact name';

	/// en: 'city/regency'
	String get city => 'city/regency';

	/// en: 'select city/regency'
	String get city_hint => 'select city/regency';

	/// en: 'district'
	String get district => 'district';

	/// en: 'sub-district'
	String get subdistrict => 'sub-district';

	/// en: 'postal code'
	String get postal_code => 'postal code';

	/// en: 'enter postal code'
	String get postal_code_hint => 'enter postal code';

	/// en: 'save address'
	String get save_address => 'save address';

	/// en: 'delete address'
	String get delete_address => 'delete address';

	/// en: 'add address'
	String get add_address => 'add address';

	/// en: 'change address'
	String get change_address => 'change address';

	/// en: 'change shop address'
	String get change_shop_address => 'change shop address';

	/// en: 'are you sure you want to delete this address?'
	String get are_you_sure_you_want_to_delete_this_address => 'are you sure you want to delete this address?';

	/// en: 'successfully saved address'
	String get successfully_saved_address_data => 'successfully saved address';

	/// en: 'successfully deleted address'
	String get successfully_deleted_address_data => 'successfully deleted address';

	/// en: 'failed to save address data'
	String get failed_to_save_address_data => 'failed to save address data';

	/// en: 'failed to delete address data'
	String get failed_to_delete_address_data => 'failed to delete address data';

	/// en: 'cannot delete the main address. set another address as main first'
	String get cannot_delete_default_address => 'cannot delete the main address. set another address as main first';

	/// en: 'invalid phone number format (08xxx atau +62xxx)'
	String get invalid_phone_number_format => 'invalid phone number format (08xxx atau +62xxx)';

	/// en: '5-15 character'
	String get k5To15Character => '5-15 character';

	/// en: 'number_only'
	String get number_only => 'number_only';
}

// Path: account.index
class TranslationsAccountIndexEn {
	TranslationsAccountIndexEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'account'
	String get account => 'account';

	/// en: 'profile'
	String get profile => 'profile';

	/// en: 'options'
	String get options => 'options';

	/// en: 'paw shop'
	String get paw_shop => 'paw shop';

	/// en: 'about us'
	String get about_us => 'about us';

	/// en: 'sign out'
	String get sign_out => 'sign out';
}

// Path: account.profile
class TranslationsAccountProfileEn {
	TranslationsAccountProfileEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'change password'
	String get change_password => 'change password';

	/// en: 'joined since'
	String get joined_since => 'joined since';

	/// en: 'full name'
	String get full_name => 'full name';

	/// en: 'username'
	String get username => 'username';
}

// Path: account.change_password
class TranslationsAccountChangePasswordEn {
	TranslationsAccountChangePasswordEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'cannot find user email'
	String get cannot_find_user_email => 'cannot find user email';

	/// en: 'your current password is incorrect'
	String get your_current_password_is_incorrect => 'your current password is incorrect';

	/// en: 'password changed successfully'
	String get password_changed_successfully => 'password changed successfully';

	/// en: 'are you sure you want to change your password?'
	String get are_you_sure_you_want_to_change_yout_password => 'are you sure you want to change your password?';

	/// en: 'you will be logged out and required to log in again.'
	String get you_will_be_logged_out_and_required_to_login_again => 'you will be logged out and required to log in again.';

	/// en: 'secure your account'
	String get secure_your_account => 'secure your account';

	/// en: 'please enter your current password and your new password below'
	String get please_enter_your_current_password_and_your_new_password_below => 'please enter your current password and your new password below';

	/// en: 'current password'
	String get current_password => 'current password';
}

// Path: account.options
class TranslationsAccountOptionsEn {
	TranslationsAccountOptionsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'options'
	String get options => 'options';

	/// en: 'language'
	String get language => 'language';

	/// en: 'english'
	String get english_language => 'english';

	/// en: 'bahasa indonesia'
	String get indonesia_language => 'bahasa indonesia';

	/// en: 'other settings'
	String get other_settings => 'other settings';

	/// en: 'notifications'
	String get notifications => 'notifications';

	/// en: 'dark mode'
	String get dark_mode => 'dark mode';

	/// en: 'change language'
	String get change_language => 'change language';

	/// en: 'are you sure you want to change the language to $flag $language'
	String are_you_sure_you_want_to_change_the_language_to({required Object flag, required Object language}) => 'are you sure you want to change the language to ${flag} ${language}';

	/// en: 'language changed to $language'
	String language_changed_to({required Object language}) => 'language changed to ${language}';

	/// en: 'yes, change'
	String get yes_change => 'yes, change';
}

// Path: account.create_shop
class TranslationsAccountCreateShopEn {
	TranslationsAccountCreateShopEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'create Paw Shop?'
	String get confirmation => 'create Paw Shop?';

	/// en: 'shop profile'
	String get shop_profile => 'shop profile';

	/// en: 'please fill in all fields'
	String get please_fill_in_all_fields => 'please fill in all fields';

	/// en: 'shop created successfully!'
	String get shop_created_successfully => 'shop created successfully!';

	/// en: 'open pawshop for free'
	String get open_pawshop_for_free => 'open pawshop for free';

	/// en: 'start your journey with Pawtastic by filling in the following data'
	String get start_your_journey_with_pawtastic => 'start your journey with Pawtastic by filling in the following data';

	/// en: 'shop name'
	String get shop_name => 'shop name';

	/// en: 'store slug'
	String get store_slug => 'store slug';

	/// en: '(ex: meow-shop)'
	String get store_slug_example => '(ex: meow-shop)';

	/// en: 'shop description'
	String get shop_description => 'shop description';

	/// en: 'open shop now'
	String get open_shop_now => 'open shop now';

	/// en: 'an error occured'
	String get an_error_occured => 'an error occured';

	/// en: 'please try different store slug'
	String get please_try_different_store_slug => 'please try different store slug';

	/// en: 'cancel creating a shop?'
	String get cancel_creating_a_shop => 'cancel creating a shop?';

	/// en: 'please fill pickup address data'
	String get please_fill_pickup_address_date => 'please fill pickup address data';

	/// en: 'shop pickup address'
	String get shop_pickup_address => 'shop pickup address';

	/// en: 'this address will be used by the courier to pick up the order'
	String get this_address_will_be_used_by_the_courier_to_pick_up_the_order => 'this address will be used by the courier to pick up the order';

	/// en: 'make sure the shop data and pickup address are correct'
	String get make_sure_the_shop_data_and_pickup_address_are_correct => 'make sure the shop data and pickup address are correct';

	/// en: 'successfully saved shop data'
	String get successfully_saved_shop_data => 'successfully saved shop data';

	/// en: 'failed to save shop data'
	String get failed_to_save_shop_data => 'failed to save shop data';
}

// Path: auth.onboarding
class TranslationsAuthOnboardingEn {
	TranslationsAuthOnboardingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'welcome to pawtastic!'
	String get welcome_to_pawtastic => 'welcome to pawtastic!';

	/// en: 'one app for all of your pet equipment!'
	String get one_app_for_all_of_your_pet_equipment => 'one app for all of your pet equipment!';

	/// en: 'get started'
	String get get_started => 'get started';

	/// en: 'login'
	String get login => 'login';
}

// Path: auth.login
class TranslationsAuthLoginEn {
	TranslationsAuthLoginEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'welcome back!'
	String get welcome_back => 'welcome back!';

	/// en: 'pawtastic email'
	String get pawtastic_email => 'pawtastic email';

	/// en: 'password'
	String get password => 'password';

	/// en: 'forgot your password?'
	String get forgot_your_password => 'forgot your password?';

	/// en: 'login'
	String get login => 'login';

	/// en: 'or'
	String get or => 'or';

	/// en: 'create an account'
	String get create_an_account => 'create an account';

	/// en: 'please enter email and password'
	String get please_enter_email_and_password => 'please enter email and password';

	/// en: 'an unexpected error occurred. please try again.'
	String get an_unexpected_error_occurred_please_try_again => 'an unexpected error occurred. please try again.';
}

// Path: auth.signup
class TranslationsAuthSignupEn {
	TranslationsAuthSignupEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'create account!'
	String get create_account => 'create account!';

	/// en: 'full name'
	String get full_name => 'full name';

	/// en: 'password'
	String get password => 'password';

	/// en: 'confirm password'
	String get confirm_password => 'confirm password';

	/// en: 'by clicking create account, i have agreed to our'
	String get by_clicking_create_account_i_have_agreed_to_our => 'by clicking create account, i have agreed to our';

	/// en: 'terms and conditions'
	String get terms_and_conditions => 'terms and conditions';

	/// en: 'and have read our'
	String get and_have_read_our => 'and have read our';

	/// en: 'privacy statement'
	String get privacy_statement => 'privacy statement';

	/// en: 'create account'
	String get create_account_button => 'create account';

	/// en: 'i already have an account,'
	String get i_already_have_an_account => 'i already have an account,';

	/// en: 'login'
	String get login => 'login';

	/// en: 'please fill in all required fields'
	String get please_fill_in_all_required_fields => 'please fill in all required fields';

	/// en: 'passwords do not match!'
	String get passwords_do_not_match => 'passwords do not match!';

	/// en: 'password must be at least 6 characters'
	String get password_must_be_at_least_6_characters => 'password must be at least 6 characters';

	/// en: 'account created successfully! please check your email for verification.'
	String get account_created_successfully_please_check_your_email_for_verification => 'account created successfully! please check your email for verification.';

	/// en: 'an unexpected error occurred. please try again.'
	String get an_unexpected_error_occurred_please_try_again => 'an unexpected error occurred. please try again.';
}

// Path: auth.forgot_password
class TranslationsAuthForgotPasswordEn {
	TranslationsAuthForgotPasswordEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'forgot your password?'
	String get forgot_your_password => 'forgot your password?';

	/// en: 'enter registered email address'
	String get enter_registered_email_address => 'enter registered email address';

	/// en: 'we will send you a message to set or reset your new password'
	String get we_will_send_you_a_message_to_set_or_reset_your_new_password => 'we will send you a message to set or reset your new password';

	/// en: 'please enter your email address'
	String get please_enter_your_email_address => 'please enter your email address';

	/// en: 'reset link has been sent to your email!'
	String get reset_link_has_been_sent_to_your_email => 'reset link has been sent to your email!';

	/// en: 'wait $seconds s'
	String wait({required Object seconds}) => 'wait ${seconds} s';

	/// en: 'submit'
	String get submit => 'submit';
}

// Path: auth.reset_password
class TranslationsAuthResetPasswordEn {
	TranslationsAuthResetPasswordEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'reset password'
	String get reset_password => 'reset password';

	/// en: 'set new password'
	String get set_new_password => 'set new password';

	/// en: 'please enter your new password below.'
	String get please_enter_your_new_password_below => 'please enter your new password below.';

	/// en: 'new password'
	String get new_password => 'new password';

	/// en: 'confirm new password'
	String get confirm_new_password => 'confirm new password';

	/// en: 'update password'
	String get update_password => 'update password';

	/// en: 'please fill in all fields'
	String get please_fill_in_all_fields => 'please fill in all fields';

	/// en: 'password updated successfully!'
	String get password_updated_successfully => 'password updated successfully!';
}

// Path: auth.seller
class TranslationsAuthSellerEn {
	TranslationsAuthSellerEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAuthSellerLoginEn login = TranslationsAuthSellerLoginEn.internal(_root);
	late final TranslationsAuthSellerSignupEn signup = TranslationsAuthSellerSignupEn.internal(_root);
}

// Path: home.index
class TranslationsHomeIndexEn {
	TranslationsHomeIndexEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'search here'
	String get search_here => 'search here';

	/// en: 'categories'
	String get categories => 'categories';

	/// en: 'no products available'
	String get no_products_available => 'no products available';

	/// en: 'most popular'
	String get most_popular => 'most popular';

	/// en: 'no popular products'
	String get no_popular_products => 'no popular products';

	/// en: 'seller not found'
	String get seller_not_found => 'seller not found';
}

// Path: home.most_popular
class TranslationsHomeMostPopularEn {
	TranslationsHomeMostPopularEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'most_popular'
	String get most_popular => 'most_popular';

	/// en: 'product'
	String get product => 'product';
}

// Path: home.product_category
class TranslationsHomeProductCategoryEn {
	TranslationsHomeProductCategoryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'product category'
	String get product_category => 'product category';

	/// en: 'no products found for this category.'
	String get no_products_found_for_this_category => 'no products found for this category.';
}

// Path: my_orders.index
class TranslationsMyOrdersIndexEn {
	TranslationsMyOrdersIndexEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'my orders'
	String get my_orders => 'my orders';

	/// en: 'delivered'
	String get delivered => 'delivered';

	/// en: 'processing'
	String get processing => 'processing';

	/// en: 'cancelled'
	String get cancelled => 'cancelled';

	/// en: 'order'
	String get order => 'order';

	/// en: 'delivered $date'
	String delivered_on({required Object date}) => 'delivered ${date}';

	/// en: 'details'
	String get details => 'details';
}

// Path: my_orders.details
class TranslationsMyOrdersDetailsEn {
	TranslationsMyOrdersDetailsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'details'
	String get details => 'details';

	/// en: 'order'
	String get order => 'order';

	/// en: 'confirm order'
	String get confirm_order => 'confirm order';

	/// en: 'has your order arrived safely?'
	String get confirm_receipt_message => 'has your order arrived safely?';

	/// en: 'shop information'
	String get shop_information => 'shop information';

	/// en: 'shop'
	String get shop => 'shop';

	/// en: 'shop address'
	String get shop_address => 'shop address';

	/// en: 'products'
	String get products => 'products';

	/// en: 'product subtotal'
	String get product_subtotal => 'product subtotal';

	/// en: 'order details'
	String get order_details => 'order details';

	/// en: 'status'
	String get status => 'status';

	/// en: 'order date'
	String get order_date => 'order date';

	/// en: 'delivered date'
	String get delivered_date => 'delivered date';

	/// en: 'not delivered'
	String get not_delivered => 'not delivered';

	/// en: 'payment method'
	String get payment_method => 'payment method';

	/// en: 'shipping cost'
	String get shipping_cost => 'shipping cost';

	/// en: 'discount'
	String get discount => 'discount';

	/// en: 'total payment'
	String get total_payment => 'total payment';

	/// en: 'shipping address'
	String get shipping_address => 'shipping address';
}

// Path: my_orders.checkout
class TranslationsMyOrdersCheckoutEn {
	TranslationsMyOrdersCheckoutEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'checkout'
	String get checkout => 'checkout';

	/// en: 'order summary'
	String get order_summary => 'order summary';

	/// en: 'order from $name'
	String order_from({required Object name}) => 'order from ${name}';

	/// en: 'order number'
	String get order_number => 'order number';

	/// en: 'total price'
	String get total_price => 'total price';

	/// en: 'shipping address'
	String get shipping_address => 'shipping address';

	/// en: 'cart items'
	String get cart_items => 'cart items';

	/// en: 'qty'
	String get qty => 'qty';

	/// en: 'buy now'
	String get buy_now => 'buy now';

	/// en: 'please log in to place an order.'
	String get please_log_in_to_place_an_order => 'please log in to place an order.';

	/// en: 'please log in to proceed.'
	String get please_log_in_to_proceed => 'please log in to proceed.';

	/// en: 'not enough stock available.'
	String get not_enough_stock_available => 'not enough stock available.';

	/// en: 'order placed successfully!'
	String get order_placed_successfully => 'order placed successfully!';

	/// en: 'error placing order: $error'
	String error_placing_order({required Object error}) => 'error placing order: ${error}';
}

// Path: product.details
class TranslationsProductDetailsEn {
	TranslationsProductDetailsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'details'
	String get details => 'details';

	/// en: 'order'
	String get order => 'order';

	/// en: 'sold'
	String get sold => 'sold';

	/// en: 'stock'
	String get stock => 'stock';

	/// en: 'for'
	String get kFor => 'for';

	/// en: 'description'
	String get description => 'description';

	/// en: 'seller'
	String get seller => 'seller';

	/// en: 'please log in to add to cart'
	String get please_log_in_to_add_to_cart => 'please log in to add to cart';

	/// en: 'added to cart successfully!'
	String get added_to_cart_successfully => 'added to cart successfully!';

	/// en: 'quantity updated in cart!'
	String get quantity_updated_in_cart => 'quantity updated in cart!';
}

// Path: seller_product.manage_product
class TranslationsSellerProductManageProductEn {
	TranslationsSellerProductManageProductEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'product list'
	String get product_list => 'product list';

	/// en: 'current stock: $stock'
	String current_stock({required Object stock}) => 'current stock: ${stock}';

	/// en: 'edit product'
	String get edit_product => 'edit product';

	/// en: 'edit details for $name'
	String edit_details_for({required Object name}) => 'edit details for ${name}';
}

// Path: seller.home
class TranslationsSellerHomeEn {
	TranslationsSellerHomeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'add product'
	String get add_product => 'add product';

	/// en: 'manage products'
	String get manage_products => 'manage products';

	/// en: 'manage orders'
	String get manage_orders => 'manage orders';

	/// en: 'cashier'
	String get cashier => 'cashier';

	/// en: 'to buyer mode'
	String get to_buyer_mode => 'to buyer mode';
}

// Path: seller.manage_orders
class TranslationsSellerManageOrdersEn {
	TranslationsSellerManageOrdersEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'manage orders'
	String get title => 'manage orders';

	/// en: 'pending'
	String get pending => 'pending';

	/// en: 'delivered'
	String get delivered => 'delivered';

	/// en: 'cancelled'
	String get cancelled => 'cancelled';

	/// en: 'tracking number'
	String get tracking_number => 'tracking number';

	/// en: 'product list'
	String get product_list => 'product list';

	/// en: 'confirm'
	String get confirm => 'confirm';

	/// en: 'are you sure you want to confirm this order?'
	String get confirm_order_message => 'are you sure you want to confirm this order?';

	/// en: 'Are you sure you want to cancel this order?'
	String get cancel_order_message => 'Are you sure you want to cancel this order?';
}

// Path: seller.cashier
class TranslationsSellerCashierEn {
	TranslationsSellerCashierEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'cashier'
	String get title => 'cashier';

	/// en: 'transaction record'
	String get transaction_record => 'transaction record';

	/// en: 'add offline transaction'
	String get add_offline_transaction => 'add offline transaction';

	/// en: 'total income'
	String get total_income => 'total income';

	/// en: 'shipping cost'
	String get shipping_cost => 'shipping cost';

	/// en: 'discount'
	String get discount => 'discount';

	/// en: 'offline transaction form placeholder'
	String get offline_form_placeholder => 'offline transaction form placeholder';
}

// Path: seller.settings
class TranslationsSellerSettingsEn {
	TranslationsSellerSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'shop settings'
	String get title => 'shop settings';

	/// en: 'notifications'
	String get notifications => 'notifications';

	/// en: 'pickup address'
	String get pickup_address => 'pickup address';

	/// en: 'manage pickup address'
	String get manage_pickup_address => 'manage pickup address';

	/// en: 'manage shop profile'
	String get manage_shop_profile => 'manage shop profile';

	/// en: 'shop name'
	String get shop_name => 'shop name';

	/// en: 'store slug'
	String get store_slug => 'store slug';

	/// en: 'ex: meow-shop'
	String get store_slug_hint => 'ex: meow-shop';

	/// en: 'description'
	String get description => 'description';

	/// en: 'verified'
	String get verified => 'verified';

	/// en: 'not verified'
	String get not_verified => 'not verified';

	/// en: 'save shop profile'
	String get save_shop_profile => 'save shop profile';

	/// en: 'shop profile updated successfully'
	String get successfully_saved_shop_profile => 'shop profile updated successfully';

	/// en: 'failed to update shop profile'
	String get failed_to_save_shop_profile => 'failed to update shop profile';

	/// en: 'cannot reach your address'
	String get cant_reach_your_address => 'cannot reach your address';
}

// Path: errors.common
class TranslationsErrorsCommonEn {
	TranslationsErrorsCommonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'please fill in all fields'
	String get please_fill_in_all_fields => 'please fill in all fields';

	/// en: 'unsaved data will be lost'
	String get unsaved_data_will_be_lost => 'unsaved data will be lost';

	/// en: 'any data you have filled will be lost'
	String get any_data_you_have_filled_will_be_lost => 'any data you have filled will be lost';

	/// en: 'required field'
	String get required_field => 'required field';

	/// en: 'required fields'
	String get required_fields => 'required fields';

	/// en: 'failed to load $dataName data'
	String failed_to_load_data({required Object dataName}) => 'failed to load ${dataName} data';

	/// en: 'please try again'
	String get please_try_again => 'please try again';

	/// en: 'please fill in all data validly'
	String get please_fill_in_all_data_validly => 'please fill in all data validly';

	/// en: 'an error occured'
	String get an_error_occured => 'an error occured';

	/// en: 'while saving data'
	String get while_saving_data => 'while saving data';

	/// en: 'please check the data you have filled in'
	String get please_check_the_data_you_have_filled_in => 'please check the data you have filled in';

	/// en: '$number minimum charater'
	String minimum_character({required Object number}) => '${number} minimum charater';

	/// en: 'maximum $number characters'
	String maximum_character({required Object number}) => 'maximum ${number} characters';
}

// Path: errors.auth
class TranslationsErrorsAuthEn {
	TranslationsErrorsAuthEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'this email is already registered. please use another email.'
	String get this_email_is_already_registered_please_use_another_email => 'this email is already registered. please use another email.';

	/// en: 'connection problem. check your internet.'
	String get connection_problem_check_your_internet => 'connection problem. check your internet.';

	/// en: 'failed to register. make sure the data is correct or try again later.'
	String get failed_to_register_make_sure_the_data_is_correct_or_try_again_later => 'failed to register. make sure the data is correct or try again later.';

	/// en: 'system error occurred. please try again in a few moments.'
	String get system_error_occurred_please_try_again_in_a_few_moments => 'system error occurred. please try again in a few moments.';

	/// en: 'incorrect email or password.'
	String get incorrect_email_or_password => 'incorrect email or password.';

	/// en: 'your email has not been confirmed. please check your email inbox.'
	String get your_email_has_not_been_confirmed_please_check_your_email_inbox => 'your email has not been confirmed. please check your email inbox.';

	/// en: 'failed to login. please try again.'
	String get failed_to_login_please_try_again => 'failed to login. please try again.';

	/// en: 'system error.'
	String get system_error => 'system error.';

	/// en: 'email not registered. please check again.'
	String get email_not_registered_please_check_again => 'email not registered. please check again.';

	/// en: 'too many requests. please wait a few moments.'
	String get too_many_requests_please_wait_a_few_moments => 'too many requests. please wait a few moments.';

	/// en: 'failed to send reset email. make sure your email is correct.'
	String get failed_to_send_reset_email_make_sure_your_email_is_correct => 'failed to send reset email. make sure your email is correct.';

	/// en: 'connection problem. please try again.'
	String get connection_problem_please_try_again => 'connection problem. please try again.';

	/// en: 'new password cannot be the same as the old password.'
	String get new_password_cannot_be_the_same_as_the_old_password => 'new password cannot be the same as the old password.';

	/// en: 'failed to update password. please try again.'
	String get failed_to_update_password_please_try_again => 'failed to update password. please try again.';
}

// Path: errors.shop
class TranslationsErrorsShopEn {
	TranslationsErrorsShopEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'shop name already used or contains unauthorized characters.'
	String get shop_name_already_used_or_contains_unauthorized_characters => 'shop name already used or contains unauthorized characters.';

	/// en: 'failed to create shop. please try again.'
	String get failed_to_create_shop_please_try_again => 'failed to create shop. please try again.';

	/// en: 'failed to create shop account.'
	String get failed_to_create_shop_account => 'failed to create shop account.';
}

// Path: auth.seller.login
class TranslationsAuthSellerLoginEn {
	TranslationsAuthSellerLoginEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'pawsitively profitable'
	String get pawsitively_profitable => 'pawsitively profitable';

	/// en: 'shop email'
	String get shop_email => 'shop email';

	/// en: 'login'
	String get login => 'login';

	/// en: 'have not registered paw shop yet?'
	String get have_not_registered_paw_shop_yet => 'have not registered paw shop yet?';

	/// en: 'register!'
	String get register => 'register!';

	/// en: 'please enter shop email and password.'
	String get please_enter_shop_email_and_password => 'please enter shop email and password.';
}

// Path: auth.seller.signup
class TranslationsAuthSellerSignupEn {
	TranslationsAuthSellerSignupEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'build a paw shop business'
	String get build_a_paw_shop_business => 'build a paw shop business';

	/// en: 'shop name'
	String get shop_name => 'shop name';

	/// en: 'shop address'
	String get shop_address => 'shop address';

	/// en: 'shop description'
	String get shop_description => 'shop description';

	/// en: 'create shop'
	String get create_shop => 'create shop';

	/// en: 'i already have paw shop,'
	String get i_already_have_paw_shop => 'i already have paw shop,';

	/// en: 'shop account created successfully!'
	String get shop_account_created_successfully => 'shop account created successfully!';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.search' => 'search',
			'common.cancel' => 'cancel',
			'common.yes' => 'yes',
			'common.confirm' => 'confirm',
			'common.and' => 'and',
			'common.or' => 'or',
			'common.next' => 'next',
			'common.soon' => 'soon',
			'common.now' => 'now',
			'common.guest' => 'guest',
			'common.email' => 'email',
			'common.password' => 'password',
			'common.submit' => 'submit',
			'common.change' => 'change',
			'common.price' => 'price',
			'common.quantity' => 'quantity',
			'common.checkout' => 'checkout',
			'common.hello' => 'hello',
			'common.see_all' => 'see all',
			'common.details' => 'details',
			'common.status' => 'status',
			'common.order_date' => 'order date',
			'common.shipping_address' => 'shipping address',
			'common.total_amount' => 'total amount',
			'common.from' => 'from',
			'common.buy_now' => 'buy now',
			'common.edit' => 'edit',
			'common.login' => 'login',
			'common.login_required' => 'login required',
			'common.back' => 'back',
			'common.shop' => 'shop',
			'common.paw_shop' => 'paw shop',
			'common.address' => 'address',
			'common.choose' => 'choose',
			'common.loading_data' => 'loading data',
			'common.loading_data_name' => ({required Object data}) => 'loading ${data}',
			'common.seller_mode' => 'seller mode',
			'common.buyer_mode' => 'buyer mode',
			'common.make_sure_all_the_data_you_have_filled_in_is_correct' => 'make sure all the data you have filled in is correct',
			'common.please_login_to_access_this_page' => 'please log in to access this page',
			'common.please_login_as_a_seller_to_access_this_page' => 'please log in as a seller (Paw Shop) to access this page',
			'address.index.my_addresses' => 'my addresses',
			'address.index.add_new_address' => 'add new address',
			'address.index.edit_address' => 'edit address',
			'address.index.no_address_found' => 'no address found',
			'address.index.set_as_default' => 'set as default',
			'address.index.kDefault' => 'default',
			'address.index.shop_pickup' => 'shop pickup',
			'address.form.address_title' => 'address label',
			'address.form.address_title_hint' => 'e.g., home, office',
			'address.form.seller_name' => 'seller name',
			'address.form.recipient_name' => 'recipient name',
			'address.form.recipient_name_hint' => 'enter recipient name',
			'address.form.phone_number' => 'phone number',
			'address.form.phone_number_hint' => 'enter active phone number',
			'address.form.full_address' => 'full address',
			'address.form.full_address_hint' => 'street name, house number, etc.',
			'address.form.province' => 'province',
			'address.form.province_hint' => 'select province',
			'address.form.shop_contact_name' => 'shop contact name',
			'address.form.city' => 'city/regency',
			'address.form.city_hint' => 'select city/regency',
			'address.form.district' => 'district',
			'address.form.subdistrict' => 'sub-district',
			'address.form.postal_code' => 'postal code',
			'address.form.postal_code_hint' => 'enter postal code',
			'address.form.save_address' => 'save address',
			'address.form.delete_address' => 'delete address',
			'address.form.add_address' => 'add address',
			'address.form.change_address' => 'change address',
			'address.form.change_shop_address' => 'change shop address',
			'address.form.are_you_sure_you_want_to_delete_this_address' => 'are you sure you want to delete this address?',
			'address.form.successfully_saved_address_data' => 'successfully saved address',
			'address.form.successfully_deleted_address_data' => 'successfully deleted address',
			'address.form.failed_to_save_address_data' => 'failed to save address data',
			'address.form.failed_to_delete_address_data' => 'failed to delete address data',
			'address.form.cannot_delete_default_address' => 'cannot delete the main address. set another address as main first',
			'address.form.invalid_phone_number_format' => 'invalid phone number format (08xxx atau +62xxx)',
			'address.form.k5To15Character' => '5-15 character',
			'address.form.number_only' => 'number_only',
			'account.index.account' => 'account',
			'account.index.profile' => 'profile',
			'account.index.options' => 'options',
			'account.index.paw_shop' => 'paw shop',
			'account.index.about_us' => 'about us',
			'account.index.sign_out' => 'sign out',
			'account.profile.change_password' => 'change password',
			'account.profile.joined_since' => 'joined since',
			'account.profile.full_name' => 'full name',
			'account.profile.username' => 'username',
			'account.change_password.cannot_find_user_email' => 'cannot find user email',
			'account.change_password.your_current_password_is_incorrect' => 'your current password is incorrect',
			'account.change_password.password_changed_successfully' => 'password changed successfully',
			'account.change_password.are_you_sure_you_want_to_change_yout_password' => 'are you sure you want to change your password?',
			'account.change_password.you_will_be_logged_out_and_required_to_login_again' => 'you will be logged out and required to log in again.',
			'account.change_password.secure_your_account' => 'secure your account',
			'account.change_password.please_enter_your_current_password_and_your_new_password_below' => 'please enter your current password and your new password below',
			'account.change_password.current_password' => 'current password',
			'account.options.options' => 'options',
			'account.options.language' => 'language',
			'account.options.english_language' => 'english',
			'account.options.indonesia_language' => 'bahasa indonesia',
			'account.options.other_settings' => 'other settings',
			'account.options.notifications' => 'notifications',
			'account.options.dark_mode' => 'dark mode',
			'account.options.change_language' => 'change language',
			'account.options.are_you_sure_you_want_to_change_the_language_to' => ({required Object flag, required Object language}) => 'are you sure you want to change the language to ${flag} ${language}',
			'account.options.language_changed_to' => ({required Object language}) => 'language changed to ${language}',
			'account.options.yes_change' => 'yes, change',
			'account.create_shop.confirmation' => 'create Paw Shop?',
			'account.create_shop.shop_profile' => 'shop profile',
			'account.create_shop.please_fill_in_all_fields' => 'please fill in all fields',
			'account.create_shop.shop_created_successfully' => 'shop created successfully!',
			'account.create_shop.open_pawshop_for_free' => 'open pawshop for free',
			'account.create_shop.start_your_journey_with_pawtastic' => 'start your journey with Pawtastic by filling in the following data',
			'account.create_shop.shop_name' => 'shop name',
			'account.create_shop.store_slug' => 'store slug',
			'account.create_shop.store_slug_example' => '(ex: meow-shop)',
			'account.create_shop.shop_description' => 'shop description',
			'account.create_shop.open_shop_now' => 'open shop now',
			'account.create_shop.an_error_occured' => 'an error occured',
			'account.create_shop.please_try_different_store_slug' => 'please try different store slug',
			'account.create_shop.cancel_creating_a_shop' => 'cancel creating a shop?',
			'account.create_shop.please_fill_pickup_address_date' => 'please fill pickup address data',
			'account.create_shop.shop_pickup_address' => 'shop pickup address',
			'account.create_shop.this_address_will_be_used_by_the_courier_to_pick_up_the_order' => 'this address will be used by the courier to pick up the order',
			'account.create_shop.make_sure_the_shop_data_and_pickup_address_are_correct' => 'make sure the shop data and pickup address are correct',
			'account.create_shop.successfully_saved_shop_data' => 'successfully saved shop data',
			'account.create_shop.failed_to_save_shop_data' => 'failed to save shop data',
			'no_connection.connection_failed' => 'connection failed',
			'no_connection.we_could_not_reach_the_server_please_try_again_later' => 'we couldn\'t reach the server. please try again later.',
			'no_connection.try_again' => 'try again',
			'auth.onboarding.welcome_to_pawtastic' => 'welcome to pawtastic!',
			'auth.onboarding.one_app_for_all_of_your_pet_equipment' => 'one app for all of your pet equipment!',
			'auth.onboarding.get_started' => 'get started',
			'auth.onboarding.login' => 'login',
			'auth.login.welcome_back' => 'welcome back!',
			'auth.login.pawtastic_email' => 'pawtastic email',
			'auth.login.password' => 'password',
			'auth.login.forgot_your_password' => 'forgot your password?',
			'auth.login.login' => 'login',
			'auth.login.or' => 'or',
			'auth.login.create_an_account' => 'create an account',
			'auth.login.please_enter_email_and_password' => 'please enter email and password',
			'auth.login.an_unexpected_error_occurred_please_try_again' => 'an unexpected error occurred. please try again.',
			'auth.signup.create_account' => 'create account!',
			'auth.signup.full_name' => 'full name',
			'auth.signup.password' => 'password',
			'auth.signup.confirm_password' => 'confirm password',
			'auth.signup.by_clicking_create_account_i_have_agreed_to_our' => 'by clicking create account, i have agreed to our',
			'auth.signup.terms_and_conditions' => 'terms and conditions',
			'auth.signup.and_have_read_our' => 'and have read our',
			'auth.signup.privacy_statement' => 'privacy statement',
			'auth.signup.create_account_button' => 'create account',
			'auth.signup.i_already_have_an_account' => 'i already have an account,',
			'auth.signup.login' => 'login',
			'auth.signup.please_fill_in_all_required_fields' => 'please fill in all required fields',
			'auth.signup.passwords_do_not_match' => 'passwords do not match!',
			'auth.signup.password_must_be_at_least_6_characters' => 'password must be at least 6 characters',
			'auth.signup.account_created_successfully_please_check_your_email_for_verification' => 'account created successfully! please check your email for verification.',
			'auth.signup.an_unexpected_error_occurred_please_try_again' => 'an unexpected error occurred. please try again.',
			'auth.forgot_password.forgot_your_password' => 'forgot your password?',
			'auth.forgot_password.enter_registered_email_address' => 'enter registered email address',
			'auth.forgot_password.we_will_send_you_a_message_to_set_or_reset_your_new_password' => 'we will send you a message to set or reset your new password',
			'auth.forgot_password.please_enter_your_email_address' => 'please enter your email address',
			'auth.forgot_password.reset_link_has_been_sent_to_your_email' => 'reset link has been sent to your email!',
			'auth.forgot_password.wait' => ({required Object seconds}) => 'wait ${seconds} s',
			'auth.forgot_password.submit' => 'submit',
			'auth.reset_password.reset_password' => 'reset password',
			'auth.reset_password.set_new_password' => 'set new password',
			'auth.reset_password.please_enter_your_new_password_below' => 'please enter your new password below.',
			'auth.reset_password.new_password' => 'new password',
			'auth.reset_password.confirm_new_password' => 'confirm new password',
			'auth.reset_password.update_password' => 'update password',
			'auth.reset_password.please_fill_in_all_fields' => 'please fill in all fields',
			'auth.reset_password.password_updated_successfully' => 'password updated successfully!',
			'auth.seller.login.pawsitively_profitable' => 'pawsitively profitable',
			'auth.seller.login.shop_email' => 'shop email',
			'auth.seller.login.login' => 'login',
			'auth.seller.login.have_not_registered_paw_shop_yet' => 'have not registered paw shop yet?',
			'auth.seller.login.register' => 'register!',
			'auth.seller.login.please_enter_shop_email_and_password' => 'please enter shop email and password.',
			'auth.seller.signup.build_a_paw_shop_business' => 'build a paw shop business',
			'auth.seller.signup.shop_name' => 'shop name',
			'auth.seller.signup.shop_address' => 'shop address',
			'auth.seller.signup.shop_description' => 'shop description',
			'auth.seller.signup.create_shop' => 'create shop',
			'auth.seller.signup.i_already_have_paw_shop' => 'i already have paw shop,',
			'auth.seller.signup.shop_account_created_successfully' => 'shop account created successfully!',
			'cart.cart' => 'cart',
			'cart.my_cart' => 'my cart',
			'cart.please_log_in_to_view_your_cart' => 'please log in to view your cart',
			'cart.item_removed_from_cart' => 'item removed from cart',
			'cart.failed_to_remove_item_please_try_again' => 'failed to remove item. please try again.',
			'cart.failed_to_load_cart_please_check_your_connection' => 'failed to load cart. please check your connection.',
			'cart.your_cart_empty' => 'your cart is empty.',
			'cart.cart_details' => 'cart details',
			'cart.total_price' => 'total price',
			'cart.proceed_to_checkout' => 'proceed to checkout',
			'cart.error_deleting_item' => ({required Object error}) => 'error deleting item: ${error}',
			'cart.proceeding_with_checkout' => 'proceeding with checkout...',
			'cart.address_not_found' => 'address not found',
			'cart.error_retrieving_address' => 'error retrieving address',
			'cart.seller_not_found' => 'seller not found',
			'cart.error_retrieving_seller_name' => 'error retrieving seller name',
			'home.index.search_here' => 'search here',
			'home.index.categories' => 'categories',
			'home.index.no_products_available' => 'no products available',
			'home.index.most_popular' => 'most popular',
			'home.index.no_popular_products' => 'no popular products',
			'home.index.seller_not_found' => 'seller not found',
			'home.most_popular.most_popular' => 'most_popular',
			'home.most_popular.product' => 'product',
			'home.product_category.product_category' => 'product category',
			'home.product_category.no_products_found_for_this_category' => 'no products found for this category.',
			'my_orders.index.my_orders' => 'my orders',
			'my_orders.index.delivered' => 'delivered',
			'my_orders.index.processing' => 'processing',
			'my_orders.index.cancelled' => 'cancelled',
			'my_orders.index.order' => 'order',
			'my_orders.index.delivered_on' => ({required Object date}) => 'delivered ${date}',
			'my_orders.index.details' => 'details',
			'my_orders.details.details' => 'details',
			'my_orders.details.order' => 'order',
			'my_orders.details.confirm_order' => 'confirm order',
			'my_orders.details.confirm_receipt_message' => 'has your order arrived safely?',
			'my_orders.details.shop_information' => 'shop information',
			'my_orders.details.shop' => 'shop',
			'my_orders.details.shop_address' => 'shop address',
			'my_orders.details.products' => 'products',
			'my_orders.details.product_subtotal' => 'product subtotal',
			'my_orders.details.order_details' => 'order details',
			'my_orders.details.status' => 'status',
			'my_orders.details.order_date' => 'order date',
			'my_orders.details.delivered_date' => 'delivered date',
			'my_orders.details.not_delivered' => 'not delivered',
			'my_orders.details.payment_method' => 'payment method',
			'my_orders.details.shipping_cost' => 'shipping cost',
			'my_orders.details.discount' => 'discount',
			'my_orders.details.total_payment' => 'total payment',
			'my_orders.details.shipping_address' => 'shipping address',
			'my_orders.checkout.checkout' => 'checkout',
			'my_orders.checkout.order_summary' => 'order summary',
			'my_orders.checkout.order_from' => ({required Object name}) => 'order from ${name}',
			'my_orders.checkout.order_number' => 'order number',
			'my_orders.checkout.total_price' => 'total price',
			'my_orders.checkout.shipping_address' => 'shipping address',
			'my_orders.checkout.cart_items' => 'cart items',
			'my_orders.checkout.qty' => 'qty',
			'my_orders.checkout.buy_now' => 'buy now',
			'my_orders.checkout.please_log_in_to_place_an_order' => 'please log in to place an order.',
			'my_orders.checkout.please_log_in_to_proceed' => 'please log in to proceed.',
			'my_orders.checkout.not_enough_stock_available' => 'not enough stock available.',
			'my_orders.checkout.order_placed_successfully' => 'order placed successfully!',
			'my_orders.checkout.error_placing_order' => ({required Object error}) => 'error placing order: ${error}',
			'search.no_products_available' => 'no products available',
			'search.no_products_match_your_search' => 'no products match your search',
			'search.seller_not_found' => 'seller not found',
			'product.details.details' => 'details',
			'product.details.order' => 'order',
			'product.details.sold' => 'sold',
			'product.details.stock' => 'stock',
			'product.details.kFor' => 'for',
			'product.details.description' => 'description',
			'product.details.seller' => 'seller',
			'product.details.please_log_in_to_add_to_cart' => 'please log in to add to cart',
			'product.details.added_to_cart_successfully' => 'added to cart successfully!',
			'product.details.quantity_updated_in_cart' => 'quantity updated in cart!',
			'seller_product.manage_product.product_list' => 'product list',
			'seller_product.manage_product.current_stock' => ({required Object stock}) => 'current stock: ${stock}',
			'seller_product.manage_product.edit_product' => 'edit product',
			'seller_product.manage_product.edit_details_for' => ({required Object name}) => 'edit details for ${name}',
			'seller.home.add_product' => 'add product',
			'seller.home.manage_products' => 'manage products',
			'seller.home.manage_orders' => 'manage orders',
			'seller.home.cashier' => 'cashier',
			'seller.home.to_buyer_mode' => 'to buyer mode',
			'seller.manage_orders.title' => 'manage orders',
			'seller.manage_orders.pending' => 'pending',
			'seller.manage_orders.delivered' => 'delivered',
			'seller.manage_orders.cancelled' => 'cancelled',
			'seller.manage_orders.tracking_number' => 'tracking number',
			'seller.manage_orders.product_list' => 'product list',
			'seller.manage_orders.confirm' => 'confirm',
			'seller.manage_orders.confirm_order_message' => 'are you sure you want to confirm this order?',
			'seller.manage_orders.cancel_order_message' => 'Are you sure you want to cancel this order?',
			'seller.cashier.title' => 'cashier',
			'seller.cashier.transaction_record' => 'transaction record',
			'seller.cashier.add_offline_transaction' => 'add offline transaction',
			'seller.cashier.total_income' => 'total income',
			'seller.cashier.shipping_cost' => 'shipping cost',
			'seller.cashier.discount' => 'discount',
			'seller.cashier.offline_form_placeholder' => 'offline transaction form placeholder',
			'seller.settings.title' => 'shop settings',
			'seller.settings.notifications' => 'notifications',
			'seller.settings.pickup_address' => 'pickup address',
			'seller.settings.manage_pickup_address' => 'manage pickup address',
			'seller.settings.manage_shop_profile' => 'manage shop profile',
			'seller.settings.shop_name' => 'shop name',
			'seller.settings.store_slug' => 'store slug',
			'seller.settings.store_slug_hint' => 'ex: meow-shop',
			'seller.settings.description' => 'description',
			'seller.settings.verified' => 'verified',
			'seller.settings.not_verified' => 'not verified',
			'seller.settings.save_shop_profile' => 'save shop profile',
			'seller.settings.successfully_saved_shop_profile' => 'shop profile updated successfully',
			'seller.settings.failed_to_save_shop_profile' => 'failed to update shop profile',
			'seller.settings.cant_reach_your_address' => 'cannot reach your address',
			'navigation.home' => 'home',
			'navigation.cart' => 'cart',
			'navigation.my_orders' => 'my orders',
			'navigation.account' => 'account',
			'errors.common.please_fill_in_all_fields' => 'please fill in all fields',
			'errors.common.unsaved_data_will_be_lost' => 'unsaved data will be lost',
			'errors.common.any_data_you_have_filled_will_be_lost' => 'any data you have filled will be lost',
			'errors.common.required_field' => 'required field',
			'errors.common.required_fields' => 'required fields',
			'errors.common.failed_to_load_data' => ({required Object dataName}) => 'failed to load ${dataName} data',
			'errors.common.please_try_again' => 'please try again',
			'errors.common.please_fill_in_all_data_validly' => 'please fill in all data validly',
			'errors.common.an_error_occured' => 'an error occured',
			'errors.common.while_saving_data' => 'while saving data',
			'errors.common.please_check_the_data_you_have_filled_in' => 'please check the data you have filled in',
			'errors.common.minimum_character' => ({required Object number}) => '${number} minimum charater',
			'errors.common.maximum_character' => ({required Object number}) => 'maximum ${number} characters',
			'errors.auth.this_email_is_already_registered_please_use_another_email' => 'this email is already registered. please use another email.',
			'errors.auth.connection_problem_check_your_internet' => 'connection problem. check your internet.',
			'errors.auth.failed_to_register_make_sure_the_data_is_correct_or_try_again_later' => 'failed to register. make sure the data is correct or try again later.',
			'errors.auth.system_error_occurred_please_try_again_in_a_few_moments' => 'system error occurred. please try again in a few moments.',
			'errors.auth.incorrect_email_or_password' => 'incorrect email or password.',
			'errors.auth.your_email_has_not_been_confirmed_please_check_your_email_inbox' => 'your email has not been confirmed. please check your email inbox.',
			'errors.auth.failed_to_login_please_try_again' => 'failed to login. please try again.',
			'errors.auth.system_error' => 'system error.',
			'errors.auth.email_not_registered_please_check_again' => 'email not registered. please check again.',
			'errors.auth.too_many_requests_please_wait_a_few_moments' => 'too many requests. please wait a few moments.',
			'errors.auth.failed_to_send_reset_email_make_sure_your_email_is_correct' => 'failed to send reset email. make sure your email is correct.',
			'errors.auth.connection_problem_please_try_again' => 'connection problem. please try again.',
			'errors.auth.new_password_cannot_be_the_same_as_the_old_password' => 'new password cannot be the same as the old password.',
			'errors.auth.failed_to_update_password_please_try_again' => 'failed to update password. please try again.',
			'errors.shop.shop_name_already_used_or_contains_unauthorized_characters' => 'shop name already used or contains unauthorized characters.',
			'errors.shop.failed_to_create_shop_please_try_again' => 'failed to create shop. please try again.',
			'errors.shop.failed_to_create_shop_account' => 'failed to create shop account.',
			_ => null,
		};
	}
}
