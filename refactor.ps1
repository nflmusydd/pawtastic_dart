
$replacements = @{
    '\bForgotpassword\b' = 'ForgotPasswordPage';
    '\bLoginpage\b' = 'LoginPage';
    '\bLoginpageSeller\b' = 'LoginSellerPage';
    '\bOnboarding\b' = 'OnboardingPage';
    '\bSignuppage\b' = 'SignUpPage';
    '\bSignuppageSeller\b' = 'SignUpSellerPage';
    '\bStartingAnimation\b' = 'SplashPage';
    '\bStartingAnimationShop\b' = 'SplashSellerPage';
    '\bBottombar\b' = 'BottomBarPage';
    '\bHome\b' = 'HomePage';
    '\bMostPopular\b' = 'MostPopularPage';
    '\bProductCategory\b' = 'ProductCategoryPage';
    '\bSearch\b' = 'SearchPage';
    '\bAboutUs\b' = 'AboutUsPage';
    '\bSettings\b' = 'SettingsPage';
    '\bOrderPage\b' = 'CheckoutPage';
    '\bMyOrders\b' = 'MyOrdersPage';
    '\bDetailorders\b' = 'OrderDetailsPage';
    '\bProductDetails\b' = 'ProductDetailsPage';
    '\bSellerProductList\b' = 'SellerProductListPage';
    '\bCashier\b' = 'CashierPage';
    '\bHomeSeller\b' = 'HomeSellerPage';
    '\bManageOrders\b' = 'ManageOrdersPage';
    '\bManageProduct\b' = 'ManageProductPage';
    
    '\b_ForgotpasswordState\b' = '_ForgotPasswordPageState';
    '\b_LoginpageState\b' = '_LoginPageState';
    '\b_LoginpageSellerState\b' = '_LoginSellerPageState';
    '\b_OnboardingState\b' = '_OnboardingPageState';
    '\b_SignuppageState\b' = '_SignUpPageState';
    '\b_SignuppageSellerState\b' = '_SignUpSellerPageState';
    '\b_StartingAnimationState\b' = '_SplashPageState';
    '\b_StartingAnimationShopState\b' = '_SplashSellerPageState';
    '\b_BottombarState\b' = '_BottomBarPageState';
    '\b_HomeState\b' = '_HomePageState';
    '\b_MostPopularState\b' = '_MostPopularPageState';
    '\b_SearchState\b' = '_SearchPageState';
    '\b_OrderPageState\b' = '_CheckoutPageState';
    '\b_MyOrdersState\b' = '_MyOrdersPageState';
    '\b_DetailordersState\b' = '_OrderDetailsPageState';
    '\b_SellerProductListState\b' = '_SellerProductListPageState';
    '\b_CashierState\b' = '_CashierPageState';
    '\b_ManageOrdersState\b' = '_ManageOrdersPageState';

    '\btoHomePage\b' = 'ToHomePage';
    '\btoSearchPage\b' = 'ToSearchPage';
    '\btoMyOrdersPage\b' = 'ToMyOrdersPage';
    '\btoSettingsPage\b' = 'ToSettingsPage';
    '\btoManageOrdersPage\b' = 'ToManageOrdersPage';

    't\.settings' = 't.profile.settings';
    't\.options' = 't.profile.options';
    
    'features/common/presentation/pages/settings_page\.dart' = 'features/profile/presentation/pages/settings_page.dart';
    'features/common/presentation/pages/options_page\.dart' = 'features/profile/presentation/pages/options_page.dart';
}

Get-ChildItem -Path "lib" -Filter "*.dart" -Recurse | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $modified = $false
    foreach ($old in $replacements.Keys) {
        if ($content -match $old) {
            $content = $content -replace $old, $replacements[$old]
            $modified = $true
        }
    }
    if ($modified) {
        Set-Content $_.FullName $content -NoNewline
    }
}
