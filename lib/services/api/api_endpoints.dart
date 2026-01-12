class ApiEndPoints {
  static final baseUrl = "https://staging.servicemen.in/api/v1/";

  static const requestOtp = 'customer/auth/request-otp';
  static const verifyOtp = 'customer/auth/verify-otp';
  static const logout = 'auth/logout';
  static const createProfile = 'customer/profile/create';
  static const dashboard = 'customer/dashboard';
  static const serviceArea = 'service-areas';
  static const services = 'service-types/services';
  static const uploadPhoto = 'customer/profile/upload-photo';
  static const createAddress = 'customer/addresses/create';
  static const updateAddress = 'customer/addresses/update';
  static const addressList = 'customer/addresses';
  static const setDefaultAddress = 'customer/addresses/set-default';
  static const deleteAddress = 'customer/addresses/delete';
  static const getProfile = 'customer/profile';
  static const updateProfile = 'customer/profile/update';
  static const deleteProfilePhoto = 'customer/profile/delete-photo';

  static const addToCart = 'cart/items/add';
  static const getCart = 'cart';
  static const timeSlot = 'config/time-slot';
  static const getOrderSummary = 'cart';
  static const deletecart = 'cart/delete';
}
