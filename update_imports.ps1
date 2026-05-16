$map = @{
    'package:pawtastic/pages/auth/forgot_password.dart' = 'package:pawtastic/features/auth/presentation/pages/forgot_password_page.dart'
    'package:pawtastic/pages/auth/login_page.dart' = 'package:pawtastic/features/auth/presentation/pages/login_page.dart'
    'package:pawtastic/pages/auth/login_page_seller.dart' = 'package:pawtastic/features/auth/presentation/pages/login_seller_page.dart'
    'package:pawtastic/pages/auth/onboarding.dart' = 'package:pawtastic/features/auth/presentation/pages/onboarding_page.dart'
    'package:pawtastic/pages/auth/reset_password.dart' = 'package:pawtastic/features/auth/presentation/pages/reset_password_page.dart'
    'package:pawtastic/pages/auth/signup_page.dart' = 'package:pawtastic/features/auth/presentation/pages/signup_page.dart'
    'package:pawtastic/pages/auth/signup_page_seller.dart' = 'package:pawtastic/features/auth/presentation/pages/signup_seller_page.dart'
    'package:pawtastic/pages/auth/splash_screen.dart' = 'package:pawtastic/features/auth/presentation/pages/splash_page.dart'
    'package:pawtastic/pages/auth/splash_screen_shop.dart' = 'package:pawtastic/features/auth/presentation/pages/splash_seller_page.dart'
    'package:pawtastic/pages/common/about_us_page.dart' = 'package:pawtastic/features/common/presentation/pages/about_us_page.dart'
    'package:pawtastic/pages/common/no_connection_page.dart' = 'package:pawtastic/features/common/presentation/pages/no_connection_page.dart'
    'package:pawtastic/pages/common/options_page.dart' = 'package:pawtastic/features/common/presentation/pages/options_page.dart'
    'package:pawtastic/pages/common/settings_page.dart' = 'package:pawtastic/features/common/presentation/pages/settings_page.dart'
    'package:pawtastic/pages/buyer/bottom_bar.dart' = 'package:pawtastic/features/buyer/presentation/pages/bottom_bar_page.dart'
    'package:pawtastic/pages/buyer/search_page.dart' = 'package:pawtastic/features/buyer/presentation/pages/search_page.dart'
    'package:pawtastic/pages/buyer/home/home.dart' = 'package:pawtastic/features/buyer/presentation/pages/home_page.dart'
    'package:pawtastic/pages/buyer/home/most_popular.dart' = 'package:pawtastic/features/buyer/presentation/pages/most_popular_page.dart'
    'package:pawtastic/pages/buyer/home/product_category.dart' = 'package:pawtastic/features/buyer/presentation/pages/product_category_page.dart'
    'package:pawtastic/pages/buyer/product/product_details.dart' = 'package:pawtastic/features/product/presentation/pages/product_details_page.dart'
    'package:pawtastic/pages/buyer/product/seller_product_list.dart' = 'package:pawtastic/features/product/presentation/pages/seller_product_list_page.dart'
    'package:pawtastic/pages/buyer/cart/cart.dart' = 'package:pawtastic/features/cart/presentation/pages/cart_page.dart'
    'package:pawtastic/pages/buyer/cart/cart_detail_page.dart' = 'package:pawtastic/features/cart/presentation/pages/cart_detail_page.dart'
    'package:pawtastic/pages/buyer/cart/order_page.dart' = 'package:pawtastic/features/order/presentation/pages/checkout_page.dart'
    'package:pawtastic/pages/buyer/orders/my_orders.dart' = 'package:pawtastic/features/order/presentation/pages/my_orders_page.dart'
    'package:pawtastic/pages/buyer/orders/detail_orders.dart' = 'package:pawtastic/features/order/presentation/pages/order_details_page.dart'
    'package:pawtastic/pages/seller/home_seller.dart' = 'package:pawtastic/features/seller/presentation/pages/home_seller_page.dart'
    'package:pawtastic/pages/seller/cashier.dart' = 'package:pawtastic/features/seller/presentation/pages/cashier_page.dart'
    'package:pawtastic/pages/seller/manage_order.dart' = 'package:pawtastic/features/seller/presentation/pages/manage_order_page.dart'
    'package:pawtastic/pages/seller/manage_product.dart' = 'package:pawtastic/features/seller/presentation/pages/manage_product_page.dart'
    'package:pawtastic/pages/test_page.dart' = 'package:pawtastic/features/common/presentation/pages/test_page.dart'
}

$files = Get-ChildItem -Path D:\githubproject\Pawtastic-flutter\pawtastic_dart\lib -Filter *.dart -Recurse
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $changed = $false
    foreach ($old in $map.Keys) {
        if ($content.Contains($old)) {
            $content = $content.Replace($old, $map[$old])
            $changed = $true
        }
    }
    if ($changed) {
        Set-Content -Path $file.FullName -Value $content
    }
}
