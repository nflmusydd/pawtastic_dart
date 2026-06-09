///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsId extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsId({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.id,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <id>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsId _root = this; // ignore: unused_field

	@override 
	TranslationsId $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsId(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsCommonId common = _TranslationsCommonId._(_root);
	@override late final _TranslationsAddressId address = _TranslationsAddressId._(_root);
	@override late final _TranslationsAccountId account = _TranslationsAccountId._(_root);
	@override late final _TranslationsNoConnectionId no_connection = _TranslationsNoConnectionId._(_root);
	@override late final _TranslationsAuthId auth = _TranslationsAuthId._(_root);
	@override late final _TranslationsCartId cart = _TranslationsCartId._(_root);
	@override late final _TranslationsHomeId home = _TranslationsHomeId._(_root);
	@override late final _TranslationsMyOrdersId my_orders = _TranslationsMyOrdersId._(_root);
	@override late final _TranslationsSearchId search = _TranslationsSearchId._(_root);
	@override late final _TranslationsProductId product = _TranslationsProductId._(_root);
	@override late final _TranslationsSellerProductId seller_product = _TranslationsSellerProductId._(_root);
	@override late final _TranslationsSellerId seller = _TranslationsSellerId._(_root);
	@override late final _TranslationsNavigationId navigation = _TranslationsNavigationId._(_root);
	@override late final _TranslationsErrorsId errors = _TranslationsErrorsId._(_root);
}

// Path: common
class _TranslationsCommonId extends TranslationsCommonEn {
	_TranslationsCommonId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get search => 'cari';
	@override String get cancel => 'batal';
	@override String get yes => 'ya';
	@override String get confirm => 'konfirmasi';
	@override String get and => 'dan';
	@override String get or => 'atau';
	@override String get next => 'selanjutnya';
	@override String get soon => 'segera';
	@override String get now => 'sekarang';
	@override String get guest => 'tamu';
	@override String get email => 'email';
	@override String get password => 'kata sandi';
	@override String get submit => 'kirim';
	@override String get change => 'ganti';
	@override String get price => 'harga';
	@override String get quantity => 'jumlah';
	@override String get checkout => 'checkout';
	@override String get hello => 'halo';
	@override String get see_all => 'lihat semua';
	@override String get details => 'detail';
	@override String get status => 'status';
	@override String get order_date => 'tanggal pesanan';
	@override String get shipping_address => 'alamat pengiriman';
	@override String get total_amount => 'total belanja';
	@override String get from => 'dari';
	@override String get buy_now => 'beli sekarang';
	@override String get edit => 'ubah';
	@override String get login => 'masuk';
	@override String get login_required => 'login diperlukan';
	@override String get back => 'kembali';
	@override String get shop => 'toko';
	@override String get paw_shop => 'paw shop';
	@override String get address => 'alamat';
	@override String get choose => 'pilih';
	@override String get loading_data => 'memuat data';
	@override String get please_login_to_access_this_page => 'silahkan login dahulu untuk mengakses halaman ini';
	@override String get please_login_as_a_seller_to_access_this_page => 'silahkan login sebagai penjual (Paw Shop) untuk mengakses halaman ini';
}

// Path: address
class _TranslationsAddressId extends TranslationsAddressEn {
	_TranslationsAddressId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAddressIndexId index = _TranslationsAddressIndexId._(_root);
	@override late final _TranslationsAddressFormId form = _TranslationsAddressFormId._(_root);
}

// Path: account
class _TranslationsAccountId extends TranslationsAccountEn {
	_TranslationsAccountId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAccountIndexId index = _TranslationsAccountIndexId._(_root);
	@override late final _TranslationsAccountProfileId profile = _TranslationsAccountProfileId._(_root);
	@override late final _TranslationsAccountChangePasswordId change_password = _TranslationsAccountChangePasswordId._(_root);
	@override late final _TranslationsAccountOptionsId options = _TranslationsAccountOptionsId._(_root);
	@override late final _TranslationsAccountCreateShopId create_shop = _TranslationsAccountCreateShopId._(_root);
}

// Path: no_connection
class _TranslationsNoConnectionId extends TranslationsNoConnectionEn {
	_TranslationsNoConnectionId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get connection_failed => 'koneksi gagal';
	@override String get we_could_not_reach_the_server_please_try_again_later => 'kami tidak dapat terhubung ke server. silakan coba lagi nanti.';
	@override String get try_again => 'coba lagi';
}

// Path: auth
class _TranslationsAuthId extends TranslationsAuthEn {
	_TranslationsAuthId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAuthOnboardingId onboarding = _TranslationsAuthOnboardingId._(_root);
	@override late final _TranslationsAuthLoginId login = _TranslationsAuthLoginId._(_root);
	@override late final _TranslationsAuthSignupId signup = _TranslationsAuthSignupId._(_root);
	@override late final _TranslationsAuthForgotPasswordId forgot_password = _TranslationsAuthForgotPasswordId._(_root);
	@override late final _TranslationsAuthResetPasswordId reset_password = _TranslationsAuthResetPasswordId._(_root);
	@override late final _TranslationsAuthSellerId seller = _TranslationsAuthSellerId._(_root);
}

// Path: cart
class _TranslationsCartId extends TranslationsCartEn {
	_TranslationsCartId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get cart => 'keranjang';
	@override String get my_cart => 'keranjang saya';
	@override String get please_log_in_to_view_your_cart => 'silakan masuk untuk melihat keranjang anda';
	@override String get item_removed_from_cart => 'item dihapus dari keranjang';
	@override String get failed_to_remove_item_please_try_again => 'gagal menghapus item. silakan coba lagi.';
	@override String get failed_to_load_cart_please_check_your_connection => 'gagal memuat keranjang. silakan periksa koneksi anda.';
	@override String get your_cart_empty => 'keranjang anda kosong.';
	@override String get cart_details => 'detail keranjang';
	@override String get total_price => 'total harga';
	@override String get proceed_to_checkout => 'lanjutkan ke pembayaran';
	@override String error_deleting_item({required Object error}) => 'kesalahan menghapus item: ${error}';
	@override String get proceeding_with_checkout => 'melanjutkan ke pembayaran...';
	@override String get address_not_found => 'alamat tidak ditemukan';
	@override String get error_retrieving_address => 'kesalahan mengambil alamat';
	@override String get seller_not_found => 'penjual tidak ditemukan';
	@override String get error_retrieving_seller_name => 'kesalahan mengambil nama penjual';
}

// Path: home
class _TranslationsHomeId extends TranslationsHomeEn {
	_TranslationsHomeId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeIndexId index = _TranslationsHomeIndexId._(_root);
	@override late final _TranslationsHomeMostPopularId most_popular = _TranslationsHomeMostPopularId._(_root);
	@override late final _TranslationsHomeProductCategoryId product_category = _TranslationsHomeProductCategoryId._(_root);
}

// Path: my_orders
class _TranslationsMyOrdersId extends TranslationsMyOrdersEn {
	_TranslationsMyOrdersId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMyOrdersIndexId index = _TranslationsMyOrdersIndexId._(_root);
	@override late final _TranslationsMyOrdersDetailsId details = _TranslationsMyOrdersDetailsId._(_root);
	@override late final _TranslationsMyOrdersCheckoutId checkout = _TranslationsMyOrdersCheckoutId._(_root);
}

// Path: search
class _TranslationsSearchId extends TranslationsSearchEn {
	_TranslationsSearchId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get no_products_available => 'produk tidak tersedia';
	@override String get no_products_match_your_search => 'tidak ada produk yang cocok dengan pencarian anda';
	@override String get seller_not_found => 'penjual tidak ditemukan';
}

// Path: product
class _TranslationsProductId extends TranslationsProductEn {
	_TranslationsProductId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsProductDetailsId details = _TranslationsProductDetailsId._(_root);
}

// Path: seller_product
class _TranslationsSellerProductId extends TranslationsSellerProductEn {
	_TranslationsSellerProductId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSellerProductManageProductId manage_product = _TranslationsSellerProductManageProductId._(_root);
}

// Path: seller
class _TranslationsSellerId extends TranslationsSellerEn {
	_TranslationsSellerId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSellerHomeId home = _TranslationsSellerHomeId._(_root);
	@override late final _TranslationsSellerManageOrdersId manage_orders = _TranslationsSellerManageOrdersId._(_root);
	@override late final _TranslationsSellerCashierId cashier = _TranslationsSellerCashierId._(_root);
	@override late final _TranslationsSellerSettingsId settings = _TranslationsSellerSettingsId._(_root);
}

// Path: navigation
class _TranslationsNavigationId extends TranslationsNavigationEn {
	_TranslationsNavigationId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get home => 'beranda';
	@override String get cart => 'keranjang';
	@override String get my_orders => 'pesanan saya';
	@override String get account => 'akun';
}

// Path: errors
class _TranslationsErrorsId extends TranslationsErrorsEn {
	_TranslationsErrorsId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsErrorsCommonId common = _TranslationsErrorsCommonId._(_root);
	@override late final _TranslationsErrorsAuthId auth = _TranslationsErrorsAuthId._(_root);
	@override late final _TranslationsErrorsShopId shop = _TranslationsErrorsShopId._(_root);
}

// Path: address.index
class _TranslationsAddressIndexId extends TranslationsAddressIndexEn {
	_TranslationsAddressIndexId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get my_addresses => 'alamat saya';
	@override String get add_new_address => 'tambah alamat baru';
	@override String get edit_address => 'ubah alamat';
	@override String get no_address_found => 'alamat tidak ditemukan';
	@override String get set_as_default => 'set sebagai alamat utama';
	@override String get kDefault => 'utama';
	@override String get shop_pickup => 'titik jemput toko';
}

// Path: address.form
class _TranslationsAddressFormId extends TranslationsAddressFormEn {
	_TranslationsAddressFormId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get address_title => 'label alamat';
	@override String get address_title_hint => 'misal: rumah, kantor';
	@override String get recipient_name => 'nama penerima';
	@override String get recipient_name_hint => 'masukkan nama penerima';
	@override String get phone_number => 'nomor telepon';
	@override String get phone_number_hint => 'masukkan nomor telepon aktif';
	@override String get full_address => 'alamat lengkap';
	@override String get full_address_hint => 'nama jalan, nomor rumah, dsb';
	@override String get province => 'provinsi';
	@override String get province_hint => 'pilih provinsi';
	@override String get shop_contact_name => 'nama kontak toko';
	@override String get city => 'kota/kabupaten';
	@override String get city_hint => 'pilih kota/kabupaten';
	@override String get district => 'kecamatan';
	@override String get subdistrict => 'kelurahan/desa';
	@override String get postal_code => 'kode pos';
	@override String get postal_code_hint => 'masukkan kode pos';
	@override String get save_address => 'simpan alamat';
	@override String get delete_address => 'hapus alamat';
	@override String get are_you_sure_you_want_to_delete_this_address => 'apakah Anda yakin ingin menghapus alamat ini?';
}

// Path: account.index
class _TranslationsAccountIndexId extends TranslationsAccountIndexEn {
	_TranslationsAccountIndexId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get account => 'akun';
	@override String get profile => 'profil';
	@override String get options => 'opsi';
	@override String get paw_shop => 'paw shop';
	@override String get about_us => 'tentang kami';
	@override String get sign_out => 'keluar';
}

// Path: account.profile
class _TranslationsAccountProfileId extends TranslationsAccountProfileEn {
	_TranslationsAccountProfileId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get change_password => 'ubah password';
	@override String get joined_since => 'bergabung sejak';
	@override String get full_name => 'nama lengkap';
	@override String get username => 'username';
}

// Path: account.change_password
class _TranslationsAccountChangePasswordId extends TranslationsAccountChangePasswordEn {
	_TranslationsAccountChangePasswordId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get cannot_find_user_email => 'email user tidak ditemukan';
	@override String get your_current_password_is_incorrect => 'password lama salah';
	@override String get password_changed_successfully => 'password berhasil diubah';
	@override String get are_you_sure_you_want_to_change_yout_password => 'apakah Anda yakin ingin mengganti password?';
	@override String get you_will_be_logged_out_and_required_to_login_again => 'sesi Anda akan dihapus dan Anda diminta masuk kembali.';
	@override String get secure_your_account => 'amankan akunmu';
	@override String get please_enter_your_current_password_and_your_new_password_below => 'silahkan masukkan password lama dan password baru di bawah';
	@override String get current_password => 'kata sandi lama';
}

// Path: account.options
class _TranslationsAccountOptionsId extends TranslationsAccountOptionsEn {
	_TranslationsAccountOptionsId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get options => 'opsi';
	@override String get language => 'bahasa';
	@override String get other_settings => 'pengaturan lainnya';
	@override String get notifications => 'notifikasi';
	@override String get dark_mode => 'mode gelap';
	@override String get change_language => 'ganti bahasa';
	@override String are_you_sure_you_want_to_change_the_language_to({required Object flag, required Object language}) => 'apakah anda yakin ingin mengganti bahasa ke ${flag} ${language}';
	@override String language_changed_to({required Object language}) => 'bahasa berhasil diubah ke ${language}';
	@override String get yes_change => 'ya, ganti';
}

// Path: account.create_shop
class _TranslationsAccountCreateShopId extends TranslationsAccountCreateShopEn {
	_TranslationsAccountCreateShopId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get confirmation => 'buat Paw Shop?';
	@override String get shop_profile => 'profil toko';
	@override String get please_fill_in_all_fields => 'mohon isi semua bidang';
	@override String get shop_created_successfully => 'toko berhasil dibuat!';
	@override String get open_pawshop_for_free => 'buka toko gratis';
	@override String get start_your_journey_with_pawtastic => 'mulai perjalanan bisnismu di Pawtastic dengan mengisi data berikut';
	@override String get shop_name => 'nama toko';
	@override String get store_slug => 'nama unik toko';
	@override String get store_slug_example => '(cth: toko-meong)';
	@override String get shop_description => 'deskripsi toko';
	@override String get open_shop_now => 'buka toko sekarang';
	@override String get an_error_occured => 'terjadi kesalahan';
	@override String get please_try_different_store_slug => 'coba ganti nama unik toko';
	@override String get cancel_creating_a_shop => 'batal buat toko?';
	@override String get please_fill_pickup_address_date => 'mohon lengkapi data alamat penjemputan';
	@override String get make_sure_the_store_data_and_pickup_address_are_correct => 'pastikan data toko dan alamat penjemputan sudah benar';
	@override String get shop_pickup_address => 'alamat penjemputan toko';
	@override String get this_address_will_be_used_by_the_courier_to_pick_up_the_order => 'alamat ini akan digunakan kurir untuk menjemput paket pesanan Anda';
}

// Path: auth.onboarding
class _TranslationsAuthOnboardingId extends TranslationsAuthOnboardingEn {
	_TranslationsAuthOnboardingId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get welcome_to_pawtastic => 'selamat datang di pawtastic!';
	@override String get one_app_for_all_of_your_pet_equipment => 'satu aplikasi untuk semua kebutuhan hewan peliharaanmu!';
	@override String get get_started => 'mulai sekarang';
	@override String get login => 'masuk';
}

// Path: auth.login
class _TranslationsAuthLoginId extends TranslationsAuthLoginEn {
	_TranslationsAuthLoginId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get welcome_back => 'selamat datang kembali!';
	@override String get pawtastic_email => 'email pawtastic';
	@override String get password => 'kata sandi';
	@override String get forgot_your_password => 'lupa kata sandi?';
	@override String get login => 'masuk';
	@override String get or => 'atau';
	@override String get create_an_account => 'buat akun baru';
	@override String get please_enter_email_and_password => 'harap masukkan email dan kata sandi';
	@override String get an_unexpected_error_occurred_please_try_again => 'terjadi kesalahan tak terduga. silakan coba lagi.';
}

// Path: auth.signup
class _TranslationsAuthSignupId extends TranslationsAuthSignupEn {
	_TranslationsAuthSignupId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get create_account => 'buat akun!';
	@override String get full_name => 'nama lengkap';
	@override String get password => 'kata sandi';
	@override String get confirm_password => 'konfirmasi kata sandi';
	@override String get by_clicking_create_account_i_have_agreed_to_our => 'dengan mengklik buat akun, saya menyetujui';
	@override String get terms_and_conditions => 'syarat dan ketentuan';
	@override String get and_have_read_our => 'dan telah membaca';
	@override String get privacy_statement => 'pernyataan privasi';
	@override String get create_account_button => 'buat akun';
	@override String get i_already_have_an_account => 'saya sudah punya akun,';
	@override String get login => 'masuk';
	@override String get please_fill_in_all_required_fields => 'harap isi semua bidang yang diperlukan';
	@override String get passwords_do_not_match => 'kata sandi tidak cocok!';
	@override String get password_must_be_at_least_6_characters => 'kata sandi minimal harus 6 karakter';
	@override String get account_created_successfully_please_check_your_email_for_verification => 'akun berhasil dibuat! silakan periksa email anda untuk verifikasi.';
	@override String get an_unexpected_error_occurred_please_try_again => 'terjadi kesalahan tak terduga. silakan coba lagi.';
}

// Path: auth.forgot_password
class _TranslationsAuthForgotPasswordId extends TranslationsAuthForgotPasswordEn {
	_TranslationsAuthForgotPasswordId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get forgot_your_password => 'lupa kata sandi anda?';
	@override String get enter_registered_email_address => 'masukkan alamat email yang terdaftar';
	@override String get we_will_send_you_a_message_to_set_or_reset_your_new_password => 'kami akan mengirimkan pesan untuk mengatur atau mengatur ulang kata sandi baru anda';
	@override String get please_enter_your_email_address => 'harap masukkan alamat email anda';
	@override String get reset_link_has_been_sent_to_your_email => 'tautan atur ulang sandi telah dikirim ke email anda!';
	@override String wait({required Object seconds}) => 'tunggu ${seconds} dtk';
	@override String get submit => 'kirim';
}

// Path: auth.reset_password
class _TranslationsAuthResetPasswordId extends TranslationsAuthResetPasswordEn {
	_TranslationsAuthResetPasswordId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get reset_password => 'atur ulang kata sandi';
	@override String get set_new_password => 'atur kata sandi baru';
	@override String get please_enter_your_new_password_below => 'harap masukkan kata sandi baru anda di bawah ini.';
	@override String get new_password => 'kata sandi baru';
	@override String get confirm_new_password => 'konfirmasi kata sandi baru';
	@override String get update_password => 'perbarui kata sandi';
	@override String get please_fill_in_all_fields => 'harap isi semua bidang';
	@override String get password_updated_successfully => 'kata sandi berhasil diperbarui!';
}

// Path: auth.seller
class _TranslationsAuthSellerId extends TranslationsAuthSellerEn {
	_TranslationsAuthSellerId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAuthSellerLoginId login = _TranslationsAuthSellerLoginId._(_root);
	@override late final _TranslationsAuthSellerSignupId signup = _TranslationsAuthSellerSignupId._(_root);
}

// Path: home.index
class _TranslationsHomeIndexId extends TranslationsHomeIndexEn {
	_TranslationsHomeIndexId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get search_here => 'cari di sini';
	@override String get categories => 'kategori';
	@override String get no_products_available => 'produk tidak tersedia';
	@override String get most_popular => 'paling populer';
	@override String get no_popular_products => 'tidak ada produk populer';
	@override String get seller_not_found => 'penjual tidak ditemukan';
}

// Path: home.most_popular
class _TranslationsHomeMostPopularId extends TranslationsHomeMostPopularEn {
	_TranslationsHomeMostPopularId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get most_popular => 'paling populer';
	@override String get product => 'produk';
}

// Path: home.product_category
class _TranslationsHomeProductCategoryId extends TranslationsHomeProductCategoryEn {
	_TranslationsHomeProductCategoryId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get product_category => 'kategori produk';
	@override String get no_products_found_for_this_category => 'tidak ada produk untuk kategori ini.';
}

// Path: my_orders.index
class _TranslationsMyOrdersIndexId extends TranslationsMyOrdersIndexEn {
	_TranslationsMyOrdersIndexId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get my_orders => 'pesanan saya';
	@override String get delivered => 'terkirim';
	@override String get processing => 'diproses';
	@override String get cancelled => 'dibatalkan';
	@override String get order => 'pesanan';
	@override String delivered_on({required Object date}) => 'terkirim ${date}';
	@override String get details => 'detail';
}

// Path: my_orders.details
class _TranslationsMyOrdersDetailsId extends TranslationsMyOrdersDetailsEn {
	_TranslationsMyOrdersDetailsId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get details => 'detail';
	@override String get order => 'pesanan';
	@override String get confirm_order => 'pesanan selesai';
	@override String get confirm_receipt_message => 'apakah pesananmu telah sampai dengan selamat?';
	@override String get shop_information => 'informasi toko';
	@override String get shop => 'toko';
	@override String get shop_address => 'alamat toko';
	@override String get products => 'produk';
	@override String get product_subtotal => 'subtotal produk';
	@override String get order_details => 'detail pesanan';
	@override String get status => 'status';
	@override String get order_date => 'tanggal pesanan';
	@override String get delivered_date => 'tanggal terkirim';
	@override String get not_delivered => 'belum terkirim';
	@override String get payment_method => 'metode pembayaran';
	@override String get shipping_cost => 'biaya pengiriman';
	@override String get discount => 'diskon';
	@override String get total_payment => 'total pembayaran';
	@override String get shipping_address => 'alamat pengiriman';
}

// Path: my_orders.checkout
class _TranslationsMyOrdersCheckoutId extends TranslationsMyOrdersCheckoutEn {
	_TranslationsMyOrdersCheckoutId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get checkout => 'pembayaran';
	@override String get order_summary => 'ringkasan pesanan';
	@override String order_from({required Object name}) => 'pesanan dari ${name}';
	@override String get order_number => 'nomor pesanan';
	@override String get total_price => 'total harga';
	@override String get shipping_address => 'alamat pengiriman';
	@override String get cart_items => 'item keranjang';
	@override String get qty => 'jumlah';
	@override String get buy_now => 'beli sekarang';
	@override String get please_log_in_to_place_an_order => 'silakan masuk untuk melakukan pemesanan.';
	@override String get please_log_in_to_proceed => 'silakan masuk untuk melanjutkan.';
	@override String get not_enough_stock_available => 'stok tidak mencukupi.';
	@override String get order_placed_successfully => 'pesanan berhasil dibuat!';
	@override String error_placing_order({required Object error}) => 'kesalahan saat membuat pesanan: ${error}';
}

// Path: product.details
class _TranslationsProductDetailsId extends TranslationsProductDetailsEn {
	_TranslationsProductDetailsId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get details => 'detail';
	@override String get order => 'pesanan';
	@override String get sold => 'terjual';
	@override String get stock => 'stok';
	@override String get kFor => 'untuk';
	@override String get description => 'deskripsi';
	@override String get seller => 'penjual';
	@override String get please_log_in_to_add_to_cart => 'silakan masuk untuk menambah ke keranjang';
	@override String get added_to_cart_successfully => 'berhasil ditambah ke keranjang!';
	@override String get quantity_updated_in_cart => 'jumlah diperbarui di keranjang!';
}

// Path: seller_product.manage_product
class _TranslationsSellerProductManageProductId extends TranslationsSellerProductManageProductEn {
	_TranslationsSellerProductManageProductId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get product_list => 'daftar produk';
	@override String current_stock({required Object stock}) => 'stok saat ini: ${stock}';
	@override String get edit_product => 'ubah produk';
	@override String edit_details_for({required Object name}) => 'ubah detail untuk ${name}';
}

// Path: seller.home
class _TranslationsSellerHomeId extends TranslationsSellerHomeEn {
	_TranslationsSellerHomeId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get add_product => 'tambah produk';
	@override String get manage_products => 'kelola produk';
	@override String get manage_orders => 'kelola pesanan';
	@override String get cashier => 'kasir';
	@override String get sign_out => 'keluar';
}

// Path: seller.manage_orders
class _TranslationsSellerManageOrdersId extends TranslationsSellerManageOrdersEn {
	_TranslationsSellerManageOrdersId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'kelola pesanan';
	@override String get pending => 'menunggu';
	@override String get delivered => 'terkirim';
	@override String get cancelled => 'dibatalkan';
	@override String get tracking_number => 'nomor resi';
	@override String get product_list => 'daftar produk';
	@override String get confirm => 'konfirmasi';
	@override String get confirm_order_message => 'apakah anda yakin ingin mengonfirmasi pesanan ini?';
	@override String get cancel_order_message => 'apakah anda yakin ingin membatalkan pesanan ini?';
}

// Path: seller.cashier
class _TranslationsSellerCashierId extends TranslationsSellerCashierEn {
	_TranslationsSellerCashierId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'kasir';
	@override String get transaction_record => 'catatan transaksi';
	@override String get add_offline_transaction => 'tambah transaksi offline';
	@override String get total_income => 'total pendapatan';
	@override String get shipping_cost => 'biaya pengiriman';
	@override String get discount => 'diskon';
	@override String get offline_form_placeholder => 'placeholder formulir transaksi offline';
}

// Path: seller.settings
class _TranslationsSellerSettingsId extends TranslationsSellerSettingsEn {
	_TranslationsSellerSettingsId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'pengaturan toko';
	@override String get notifications => 'notifikasi';
	@override String get pickup_address => 'alamat penjemputan';
	@override String get manage_pickup_address => 'atur alamat penjemputan';
	@override String get cant_reach_your_address => 'tidak dapat mengakses alamat';
}

// Path: errors.common
class _TranslationsErrorsCommonId extends TranslationsErrorsCommonEn {
	_TranslationsErrorsCommonId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get please_fill_in_all_fields => 'mohon isi semua bidang';
	@override String get unsaved_data_will_be_lost => 'data yang belum disimpan akan hilang';
	@override String get any_data_you_have_filled_will_be_lost => 'data yang sudah kamu isi akan hilang';
	@override String get required_field => 'wajib diisi';
	@override String get required_fields => 'wajib diisi';
	@override String failed_to_load_data({required Object dataName}) => 'gagal memuat data ${dataName}';
	@override String get please_try_again => 'silakan coba lagi';
}

// Path: errors.auth
class _TranslationsErrorsAuthId extends TranslationsErrorsAuthEn {
	_TranslationsErrorsAuthId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get this_email_is_already_registered_please_use_another_email => 'email ini sudah terdaftar. silakan gunakan email lain.';
	@override String get connection_problem_check_your_internet => 'masalah koneksi. periksa internet Anda.';
	@override String get failed_to_register_make_sure_the_data_is_correct_or_try_again_later => 'gagal mendaftar. pastikan data benar atau coba lagi nanti.';
	@override String get system_error_occurred_please_try_again_in_a_few_moments => 'terjadi kesalahan sistem. silakan coba beberapa saat lagi.';
	@override String get incorrect_email_or_password => 'email atau kata sandi salah.';
	@override String get your_email_has_not_been_confirmed_please_check_your_email_inbox => 'email Anda belum dikonfirmasi. silakan cek inbox email Anda.';
	@override String get failed_to_login_please_try_again => 'gagal masuk. silakan coba lagi.';
	@override String get system_error => 'kesalahan sistem.';
	@override String get email_not_registered_please_check_again => 'email tidak terdaftar. silakan cek kembali.';
	@override String get too_many_requests_please_wait_a_few_moments => 'terlalu banyak permintaan. silakan tunggu beberapa saat.';
	@override String get failed_to_send_reset_email_make_sure_your_email_is_correct => 'gagal mengirim email atur ulang. pastikan email anda benar.';
	@override String get connection_problem_please_try_again => 'masalah koneksi. silakan coba lagi.';
	@override String get new_password_cannot_be_the_same_as_the_old_password => 'kata sandi baru tidak boleh sama dengan kata sandi lama.';
	@override String get failed_to_update_password_please_try_again => 'gagal memperbarui kata sandi. silakan coba lagi.';
}

// Path: errors.shop
class _TranslationsErrorsShopId extends TranslationsErrorsShopEn {
	_TranslationsErrorsShopId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get shop_name_already_used_or_contains_unauthorized_characters => 'nama toko sudah digunakan atau mengandung karakter yang tidak diizinkan.';
	@override String get failed_to_create_shop_please_try_again => 'gagal membuat toko. silakan coba lagi.';
	@override String get failed_to_create_shop_account => 'gagal membuat akun toko.';
}

// Path: auth.seller.login
class _TranslationsAuthSellerLoginId extends TranslationsAuthSellerLoginEn {
	_TranslationsAuthSellerLoginId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get pawsitively_profitable => 'pawsitively profitable';
	@override String get shop_email => 'email toko';
	@override String get login => 'masuk';
	@override String get have_not_registered_paw_shop_yet => 'belum daftar paw shop?';
	@override String get register => 'daftar sekarang!';
	@override String get please_enter_shop_email_and_password => 'harap masukkan email toko dan kata sandi.';
}

// Path: auth.seller.signup
class _TranslationsAuthSellerSignupId extends TranslationsAuthSellerSignupEn {
	_TranslationsAuthSellerSignupId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get build_a_paw_shop_business => 'bangun bisnis paw shop';
	@override String get shop_name => 'nama toko';
	@override String get shop_address => 'alamat toko';
	@override String get shop_description => 'deskripsi toko';
	@override String get create_shop => 'buat toko';
	@override String get i_already_have_paw_shop => 'saya sudah punya paw shop,';
	@override String get shop_account_created_successfully => 'akun toko berhasil dibuat!';
}

/// The flat map containing all translations for locale <id>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsId {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.search' => 'cari',
			'common.cancel' => 'batal',
			'common.yes' => 'ya',
			'common.confirm' => 'konfirmasi',
			'common.and' => 'dan',
			'common.or' => 'atau',
			'common.next' => 'selanjutnya',
			'common.soon' => 'segera',
			'common.now' => 'sekarang',
			'common.guest' => 'tamu',
			'common.email' => 'email',
			'common.password' => 'kata sandi',
			'common.submit' => 'kirim',
			'common.change' => 'ganti',
			'common.price' => 'harga',
			'common.quantity' => 'jumlah',
			'common.checkout' => 'checkout',
			'common.hello' => 'halo',
			'common.see_all' => 'lihat semua',
			'common.details' => 'detail',
			'common.status' => 'status',
			'common.order_date' => 'tanggal pesanan',
			'common.shipping_address' => 'alamat pengiriman',
			'common.total_amount' => 'total belanja',
			'common.from' => 'dari',
			'common.buy_now' => 'beli sekarang',
			'common.edit' => 'ubah',
			'common.login' => 'masuk',
			'common.login_required' => 'login diperlukan',
			'common.back' => 'kembali',
			'common.shop' => 'toko',
			'common.paw_shop' => 'paw shop',
			'common.address' => 'alamat',
			'common.choose' => 'pilih',
			'common.loading_data' => 'memuat data',
			'common.please_login_to_access_this_page' => 'silahkan login dahulu untuk mengakses halaman ini',
			'common.please_login_as_a_seller_to_access_this_page' => 'silahkan login sebagai penjual (Paw Shop) untuk mengakses halaman ini',
			'address.index.my_addresses' => 'alamat saya',
			'address.index.add_new_address' => 'tambah alamat baru',
			'address.index.edit_address' => 'ubah alamat',
			'address.index.no_address_found' => 'alamat tidak ditemukan',
			'address.index.set_as_default' => 'set sebagai alamat utama',
			'address.index.kDefault' => 'utama',
			'address.index.shop_pickup' => 'titik jemput toko',
			'address.form.address_title' => 'label alamat',
			'address.form.address_title_hint' => 'misal: rumah, kantor',
			'address.form.recipient_name' => 'nama penerima',
			'address.form.recipient_name_hint' => 'masukkan nama penerima',
			'address.form.phone_number' => 'nomor telepon',
			'address.form.phone_number_hint' => 'masukkan nomor telepon aktif',
			'address.form.full_address' => 'alamat lengkap',
			'address.form.full_address_hint' => 'nama jalan, nomor rumah, dsb',
			'address.form.province' => 'provinsi',
			'address.form.province_hint' => 'pilih provinsi',
			'address.form.shop_contact_name' => 'nama kontak toko',
			'address.form.city' => 'kota/kabupaten',
			'address.form.city_hint' => 'pilih kota/kabupaten',
			'address.form.district' => 'kecamatan',
			'address.form.subdistrict' => 'kelurahan/desa',
			'address.form.postal_code' => 'kode pos',
			'address.form.postal_code_hint' => 'masukkan kode pos',
			'address.form.save_address' => 'simpan alamat',
			'address.form.delete_address' => 'hapus alamat',
			'address.form.are_you_sure_you_want_to_delete_this_address' => 'apakah Anda yakin ingin menghapus alamat ini?',
			'account.index.account' => 'akun',
			'account.index.profile' => 'profil',
			'account.index.options' => 'opsi',
			'account.index.paw_shop' => 'paw shop',
			'account.index.about_us' => 'tentang kami',
			'account.index.sign_out' => 'keluar',
			'account.profile.change_password' => 'ubah password',
			'account.profile.joined_since' => 'bergabung sejak',
			'account.profile.full_name' => 'nama lengkap',
			'account.profile.username' => 'username',
			'account.change_password.cannot_find_user_email' => 'email user tidak ditemukan',
			'account.change_password.your_current_password_is_incorrect' => 'password lama salah',
			'account.change_password.password_changed_successfully' => 'password berhasil diubah',
			'account.change_password.are_you_sure_you_want_to_change_yout_password' => 'apakah Anda yakin ingin mengganti password?',
			'account.change_password.you_will_be_logged_out_and_required_to_login_again' => 'sesi Anda akan dihapus dan Anda diminta masuk kembali.',
			'account.change_password.secure_your_account' => 'amankan akunmu',
			'account.change_password.please_enter_your_current_password_and_your_new_password_below' => 'silahkan masukkan password lama dan password baru di bawah',
			'account.change_password.current_password' => 'kata sandi lama',
			'account.options.options' => 'opsi',
			'account.options.language' => 'bahasa',
			'account.options.other_settings' => 'pengaturan lainnya',
			'account.options.notifications' => 'notifikasi',
			'account.options.dark_mode' => 'mode gelap',
			'account.options.change_language' => 'ganti bahasa',
			'account.options.are_you_sure_you_want_to_change_the_language_to' => ({required Object flag, required Object language}) => 'apakah anda yakin ingin mengganti bahasa ke ${flag} ${language}',
			'account.options.language_changed_to' => ({required Object language}) => 'bahasa berhasil diubah ke ${language}',
			'account.options.yes_change' => 'ya, ganti',
			'account.create_shop.confirmation' => 'buat Paw Shop?',
			'account.create_shop.shop_profile' => 'profil toko',
			'account.create_shop.please_fill_in_all_fields' => 'mohon isi semua bidang',
			'account.create_shop.shop_created_successfully' => 'toko berhasil dibuat!',
			'account.create_shop.open_pawshop_for_free' => 'buka toko gratis',
			'account.create_shop.start_your_journey_with_pawtastic' => 'mulai perjalanan bisnismu di Pawtastic dengan mengisi data berikut',
			'account.create_shop.shop_name' => 'nama toko',
			'account.create_shop.store_slug' => 'nama unik toko',
			'account.create_shop.store_slug_example' => '(cth: toko-meong)',
			'account.create_shop.shop_description' => 'deskripsi toko',
			'account.create_shop.open_shop_now' => 'buka toko sekarang',
			'account.create_shop.an_error_occured' => 'terjadi kesalahan',
			'account.create_shop.please_try_different_store_slug' => 'coba ganti nama unik toko',
			'account.create_shop.cancel_creating_a_shop' => 'batal buat toko?',
			'account.create_shop.please_fill_pickup_address_date' => 'mohon lengkapi data alamat penjemputan',
			'account.create_shop.make_sure_the_store_data_and_pickup_address_are_correct' => 'pastikan data toko dan alamat penjemputan sudah benar',
			'account.create_shop.shop_pickup_address' => 'alamat penjemputan toko',
			'account.create_shop.this_address_will_be_used_by_the_courier_to_pick_up_the_order' => 'alamat ini akan digunakan kurir untuk menjemput paket pesanan Anda',
			'no_connection.connection_failed' => 'koneksi gagal',
			'no_connection.we_could_not_reach_the_server_please_try_again_later' => 'kami tidak dapat terhubung ke server. silakan coba lagi nanti.',
			'no_connection.try_again' => 'coba lagi',
			'auth.onboarding.welcome_to_pawtastic' => 'selamat datang di pawtastic!',
			'auth.onboarding.one_app_for_all_of_your_pet_equipment' => 'satu aplikasi untuk semua kebutuhan hewan peliharaanmu!',
			'auth.onboarding.get_started' => 'mulai sekarang',
			'auth.onboarding.login' => 'masuk',
			'auth.login.welcome_back' => 'selamat datang kembali!',
			'auth.login.pawtastic_email' => 'email pawtastic',
			'auth.login.password' => 'kata sandi',
			'auth.login.forgot_your_password' => 'lupa kata sandi?',
			'auth.login.login' => 'masuk',
			'auth.login.or' => 'atau',
			'auth.login.create_an_account' => 'buat akun baru',
			'auth.login.please_enter_email_and_password' => 'harap masukkan email dan kata sandi',
			'auth.login.an_unexpected_error_occurred_please_try_again' => 'terjadi kesalahan tak terduga. silakan coba lagi.',
			'auth.signup.create_account' => 'buat akun!',
			'auth.signup.full_name' => 'nama lengkap',
			'auth.signup.password' => 'kata sandi',
			'auth.signup.confirm_password' => 'konfirmasi kata sandi',
			'auth.signup.by_clicking_create_account_i_have_agreed_to_our' => 'dengan mengklik buat akun, saya menyetujui',
			'auth.signup.terms_and_conditions' => 'syarat dan ketentuan',
			'auth.signup.and_have_read_our' => 'dan telah membaca',
			'auth.signup.privacy_statement' => 'pernyataan privasi',
			'auth.signup.create_account_button' => 'buat akun',
			'auth.signup.i_already_have_an_account' => 'saya sudah punya akun,',
			'auth.signup.login' => 'masuk',
			'auth.signup.please_fill_in_all_required_fields' => 'harap isi semua bidang yang diperlukan',
			'auth.signup.passwords_do_not_match' => 'kata sandi tidak cocok!',
			'auth.signup.password_must_be_at_least_6_characters' => 'kata sandi minimal harus 6 karakter',
			'auth.signup.account_created_successfully_please_check_your_email_for_verification' => 'akun berhasil dibuat! silakan periksa email anda untuk verifikasi.',
			'auth.signup.an_unexpected_error_occurred_please_try_again' => 'terjadi kesalahan tak terduga. silakan coba lagi.',
			'auth.forgot_password.forgot_your_password' => 'lupa kata sandi anda?',
			'auth.forgot_password.enter_registered_email_address' => 'masukkan alamat email yang terdaftar',
			'auth.forgot_password.we_will_send_you_a_message_to_set_or_reset_your_new_password' => 'kami akan mengirimkan pesan untuk mengatur atau mengatur ulang kata sandi baru anda',
			'auth.forgot_password.please_enter_your_email_address' => 'harap masukkan alamat email anda',
			'auth.forgot_password.reset_link_has_been_sent_to_your_email' => 'tautan atur ulang sandi telah dikirim ke email anda!',
			'auth.forgot_password.wait' => ({required Object seconds}) => 'tunggu ${seconds} dtk',
			'auth.forgot_password.submit' => 'kirim',
			'auth.reset_password.reset_password' => 'atur ulang kata sandi',
			'auth.reset_password.set_new_password' => 'atur kata sandi baru',
			'auth.reset_password.please_enter_your_new_password_below' => 'harap masukkan kata sandi baru anda di bawah ini.',
			'auth.reset_password.new_password' => 'kata sandi baru',
			'auth.reset_password.confirm_new_password' => 'konfirmasi kata sandi baru',
			'auth.reset_password.update_password' => 'perbarui kata sandi',
			'auth.reset_password.please_fill_in_all_fields' => 'harap isi semua bidang',
			'auth.reset_password.password_updated_successfully' => 'kata sandi berhasil diperbarui!',
			'auth.seller.login.pawsitively_profitable' => 'pawsitively profitable',
			'auth.seller.login.shop_email' => 'email toko',
			'auth.seller.login.login' => 'masuk',
			'auth.seller.login.have_not_registered_paw_shop_yet' => 'belum daftar paw shop?',
			'auth.seller.login.register' => 'daftar sekarang!',
			'auth.seller.login.please_enter_shop_email_and_password' => 'harap masukkan email toko dan kata sandi.',
			'auth.seller.signup.build_a_paw_shop_business' => 'bangun bisnis paw shop',
			'auth.seller.signup.shop_name' => 'nama toko',
			'auth.seller.signup.shop_address' => 'alamat toko',
			'auth.seller.signup.shop_description' => 'deskripsi toko',
			'auth.seller.signup.create_shop' => 'buat toko',
			'auth.seller.signup.i_already_have_paw_shop' => 'saya sudah punya paw shop,',
			'auth.seller.signup.shop_account_created_successfully' => 'akun toko berhasil dibuat!',
			'cart.cart' => 'keranjang',
			'cart.my_cart' => 'keranjang saya',
			'cart.please_log_in_to_view_your_cart' => 'silakan masuk untuk melihat keranjang anda',
			'cart.item_removed_from_cart' => 'item dihapus dari keranjang',
			'cart.failed_to_remove_item_please_try_again' => 'gagal menghapus item. silakan coba lagi.',
			'cart.failed_to_load_cart_please_check_your_connection' => 'gagal memuat keranjang. silakan periksa koneksi anda.',
			'cart.your_cart_empty' => 'keranjang anda kosong.',
			'cart.cart_details' => 'detail keranjang',
			'cart.total_price' => 'total harga',
			'cart.proceed_to_checkout' => 'lanjutkan ke pembayaran',
			'cart.error_deleting_item' => ({required Object error}) => 'kesalahan menghapus item: ${error}',
			'cart.proceeding_with_checkout' => 'melanjutkan ke pembayaran...',
			'cart.address_not_found' => 'alamat tidak ditemukan',
			'cart.error_retrieving_address' => 'kesalahan mengambil alamat',
			'cart.seller_not_found' => 'penjual tidak ditemukan',
			'cart.error_retrieving_seller_name' => 'kesalahan mengambil nama penjual',
			'home.index.search_here' => 'cari di sini',
			'home.index.categories' => 'kategori',
			'home.index.no_products_available' => 'produk tidak tersedia',
			'home.index.most_popular' => 'paling populer',
			'home.index.no_popular_products' => 'tidak ada produk populer',
			'home.index.seller_not_found' => 'penjual tidak ditemukan',
			'home.most_popular.most_popular' => 'paling populer',
			'home.most_popular.product' => 'produk',
			'home.product_category.product_category' => 'kategori produk',
			'home.product_category.no_products_found_for_this_category' => 'tidak ada produk untuk kategori ini.',
			'my_orders.index.my_orders' => 'pesanan saya',
			'my_orders.index.delivered' => 'terkirim',
			'my_orders.index.processing' => 'diproses',
			'my_orders.index.cancelled' => 'dibatalkan',
			'my_orders.index.order' => 'pesanan',
			'my_orders.index.delivered_on' => ({required Object date}) => 'terkirim ${date}',
			'my_orders.index.details' => 'detail',
			'my_orders.details.details' => 'detail',
			'my_orders.details.order' => 'pesanan',
			'my_orders.details.confirm_order' => 'pesanan selesai',
			'my_orders.details.confirm_receipt_message' => 'apakah pesananmu telah sampai dengan selamat?',
			'my_orders.details.shop_information' => 'informasi toko',
			'my_orders.details.shop' => 'toko',
			'my_orders.details.shop_address' => 'alamat toko',
			'my_orders.details.products' => 'produk',
			'my_orders.details.product_subtotal' => 'subtotal produk',
			'my_orders.details.order_details' => 'detail pesanan',
			'my_orders.details.status' => 'status',
			'my_orders.details.order_date' => 'tanggal pesanan',
			'my_orders.details.delivered_date' => 'tanggal terkirim',
			'my_orders.details.not_delivered' => 'belum terkirim',
			'my_orders.details.payment_method' => 'metode pembayaran',
			'my_orders.details.shipping_cost' => 'biaya pengiriman',
			'my_orders.details.discount' => 'diskon',
			'my_orders.details.total_payment' => 'total pembayaran',
			'my_orders.details.shipping_address' => 'alamat pengiriman',
			'my_orders.checkout.checkout' => 'pembayaran',
			'my_orders.checkout.order_summary' => 'ringkasan pesanan',
			'my_orders.checkout.order_from' => ({required Object name}) => 'pesanan dari ${name}',
			'my_orders.checkout.order_number' => 'nomor pesanan',
			'my_orders.checkout.total_price' => 'total harga',
			'my_orders.checkout.shipping_address' => 'alamat pengiriman',
			'my_orders.checkout.cart_items' => 'item keranjang',
			'my_orders.checkout.qty' => 'jumlah',
			'my_orders.checkout.buy_now' => 'beli sekarang',
			'my_orders.checkout.please_log_in_to_place_an_order' => 'silakan masuk untuk melakukan pemesanan.',
			'my_orders.checkout.please_log_in_to_proceed' => 'silakan masuk untuk melanjutkan.',
			'my_orders.checkout.not_enough_stock_available' => 'stok tidak mencukupi.',
			'my_orders.checkout.order_placed_successfully' => 'pesanan berhasil dibuat!',
			'my_orders.checkout.error_placing_order' => ({required Object error}) => 'kesalahan saat membuat pesanan: ${error}',
			'search.no_products_available' => 'produk tidak tersedia',
			'search.no_products_match_your_search' => 'tidak ada produk yang cocok dengan pencarian anda',
			'search.seller_not_found' => 'penjual tidak ditemukan',
			'product.details.details' => 'detail',
			'product.details.order' => 'pesanan',
			'product.details.sold' => 'terjual',
			'product.details.stock' => 'stok',
			'product.details.kFor' => 'untuk',
			'product.details.description' => 'deskripsi',
			'product.details.seller' => 'penjual',
			'product.details.please_log_in_to_add_to_cart' => 'silakan masuk untuk menambah ke keranjang',
			'product.details.added_to_cart_successfully' => 'berhasil ditambah ke keranjang!',
			'product.details.quantity_updated_in_cart' => 'jumlah diperbarui di keranjang!',
			'seller_product.manage_product.product_list' => 'daftar produk',
			'seller_product.manage_product.current_stock' => ({required Object stock}) => 'stok saat ini: ${stock}',
			'seller_product.manage_product.edit_product' => 'ubah produk',
			'seller_product.manage_product.edit_details_for' => ({required Object name}) => 'ubah detail untuk ${name}',
			'seller.home.add_product' => 'tambah produk',
			'seller.home.manage_products' => 'kelola produk',
			'seller.home.manage_orders' => 'kelola pesanan',
			'seller.home.cashier' => 'kasir',
			'seller.home.sign_out' => 'keluar',
			'seller.manage_orders.title' => 'kelola pesanan',
			'seller.manage_orders.pending' => 'menunggu',
			'seller.manage_orders.delivered' => 'terkirim',
			'seller.manage_orders.cancelled' => 'dibatalkan',
			'seller.manage_orders.tracking_number' => 'nomor resi',
			'seller.manage_orders.product_list' => 'daftar produk',
			'seller.manage_orders.confirm' => 'konfirmasi',
			'seller.manage_orders.confirm_order_message' => 'apakah anda yakin ingin mengonfirmasi pesanan ini?',
			'seller.manage_orders.cancel_order_message' => 'apakah anda yakin ingin membatalkan pesanan ini?',
			'seller.cashier.title' => 'kasir',
			'seller.cashier.transaction_record' => 'catatan transaksi',
			'seller.cashier.add_offline_transaction' => 'tambah transaksi offline',
			'seller.cashier.total_income' => 'total pendapatan',
			'seller.cashier.shipping_cost' => 'biaya pengiriman',
			'seller.cashier.discount' => 'diskon',
			'seller.cashier.offline_form_placeholder' => 'placeholder formulir transaksi offline',
			'seller.settings.title' => 'pengaturan toko',
			'seller.settings.notifications' => 'notifikasi',
			'seller.settings.pickup_address' => 'alamat penjemputan',
			'seller.settings.manage_pickup_address' => 'atur alamat penjemputan',
			'seller.settings.cant_reach_your_address' => 'tidak dapat mengakses alamat',
			'navigation.home' => 'beranda',
			'navigation.cart' => 'keranjang',
			'navigation.my_orders' => 'pesanan saya',
			'navigation.account' => 'akun',
			'errors.common.please_fill_in_all_fields' => 'mohon isi semua bidang',
			'errors.common.unsaved_data_will_be_lost' => 'data yang belum disimpan akan hilang',
			'errors.common.any_data_you_have_filled_will_be_lost' => 'data yang sudah kamu isi akan hilang',
			'errors.common.required_field' => 'wajib diisi',
			'errors.common.required_fields' => 'wajib diisi',
			'errors.common.failed_to_load_data' => ({required Object dataName}) => 'gagal memuat data ${dataName}',
			'errors.common.please_try_again' => 'silakan coba lagi',
			'errors.auth.this_email_is_already_registered_please_use_another_email' => 'email ini sudah terdaftar. silakan gunakan email lain.',
			'errors.auth.connection_problem_check_your_internet' => 'masalah koneksi. periksa internet Anda.',
			'errors.auth.failed_to_register_make_sure_the_data_is_correct_or_try_again_later' => 'gagal mendaftar. pastikan data benar atau coba lagi nanti.',
			'errors.auth.system_error_occurred_please_try_again_in_a_few_moments' => 'terjadi kesalahan sistem. silakan coba beberapa saat lagi.',
			'errors.auth.incorrect_email_or_password' => 'email atau kata sandi salah.',
			'errors.auth.your_email_has_not_been_confirmed_please_check_your_email_inbox' => 'email Anda belum dikonfirmasi. silakan cek inbox email Anda.',
			'errors.auth.failed_to_login_please_try_again' => 'gagal masuk. silakan coba lagi.',
			'errors.auth.system_error' => 'kesalahan sistem.',
			'errors.auth.email_not_registered_please_check_again' => 'email tidak terdaftar. silakan cek kembali.',
			'errors.auth.too_many_requests_please_wait_a_few_moments' => 'terlalu banyak permintaan. silakan tunggu beberapa saat.',
			'errors.auth.failed_to_send_reset_email_make_sure_your_email_is_correct' => 'gagal mengirim email atur ulang. pastikan email anda benar.',
			'errors.auth.connection_problem_please_try_again' => 'masalah koneksi. silakan coba lagi.',
			'errors.auth.new_password_cannot_be_the_same_as_the_old_password' => 'kata sandi baru tidak boleh sama dengan kata sandi lama.',
			'errors.auth.failed_to_update_password_please_try_again' => 'gagal memperbarui kata sandi. silakan coba lagi.',
			'errors.shop.shop_name_already_used_or_contains_unauthorized_characters' => 'nama toko sudah digunakan atau mengandung karakter yang tidak diizinkan.',
			'errors.shop.failed_to_create_shop_please_try_again' => 'gagal membuat toko. silakan coba lagi.',
			'errors.shop.failed_to_create_shop_account' => 'gagal membuat akun toko.',
			_ => null,
		};
	}
}
