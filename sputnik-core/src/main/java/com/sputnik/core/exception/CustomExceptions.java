package com.sputnik.core.exception;

public class CustomExceptions {

    public static class UserNotFoundException extends RuntimeException {
        public UserNotFoundException(String message) {
            super(message);
        }
    }

    public static class ProductNotFoundException extends RuntimeException {
        public ProductNotFoundException(String message) {
            super(message);
        }
    }

    public static class OrderNotFoundException extends RuntimeException {
        public OrderNotFoundException(String message) {
            super(message);
        }
    }

    public static class MarketplaceListingNotFoundException extends RuntimeException {
        public MarketplaceListingNotFoundException(String message) {
            super(message);
        }
    }

    public static class StoreNotFoundException extends RuntimeException {
        public StoreNotFoundException(String message) {
            super(message);
        }
    }

    public static class ReviewNotFoundException extends RuntimeException {
        public ReviewNotFoundException(String message) {
            super(message);
        }
    }
}