-- Create marketplace listings table (for second-hand products)
CREATE TABLE marketplace_listings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    seller_id UUID NOT NULL REFERENCES users(id),
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    category_id UUID NOT NULL REFERENCES categories(id),
    brand_id UUID REFERENCES brands(id),
    condition VARCHAR(50) NOT NULL, -- NEW, LIKE_NEW, GOOD, FAIR, POOR
    price DECIMAL(10,2) NOT NULL,
    original_price DECIMAL(10,2), -- Original retail price
    
    -- Product details
    model VARCHAR(100),
    year_manufactured INTEGER,
    color VARCHAR(50),
    storage_capacity VARCHAR(50), -- e.g., "64GB", "128GB"
    
    -- Listing details
    status VARCHAR(50) NOT NULL DEFAULT 'DRAFT', -- DRAFT, ACTIVE, SOLD, EXPIRED, REMOVED
    is_negotiable BOOLEAN DEFAULT TRUE,
    is_featured BOOLEAN DEFAULT FALSE,
    views_count INTEGER DEFAULT 0,
    
    -- Location
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100) DEFAULT 'Argentina',
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    published_at TIMESTAMP,
    expires_at TIMESTAMP,
    sold_at TIMESTAMP
);

-- Create marketplace listing images table
CREATE TABLE marketplace_listing_images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    listing_id UUID NOT NULL REFERENCES marketplace_listings(id) ON DELETE CASCADE,
    url VARCHAR(500) NOT NULL,
    alt_text VARCHAR(255),
    is_primary BOOLEAN DEFAULT FALSE,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create marketplace transactions table
CREATE TABLE marketplace_transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    transaction_number VARCHAR(50) NOT NULL UNIQUE,
    listing_id UUID NOT NULL REFERENCES marketplace_listings(id),
    buyer_id UUID NOT NULL REFERENCES users(id),
    seller_id UUID NOT NULL REFERENCES users(id),
    
    -- Financial details
    item_price DECIMAL(10,2) NOT NULL,
    platform_fee DECIMAL(10,2) NOT NULL DEFAULT 0,
    payment_processing_fee DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL, -- What buyer pays
    seller_amount DECIMAL(10,2) NOT NULL, -- What seller receives
    
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING', -- PENDING, PAID, COMPLETED, CANCELLED, DISPUTED
    payment_status VARCHAR(50) NOT NULL DEFAULT 'PENDING', -- PENDING, PAID, FAILED, REFUNDED
    
    -- Meeting details (for in-person exchanges)
    meeting_type VARCHAR(50) DEFAULT 'IN_PERSON', -- IN_PERSON, SHIPPING
    meeting_location VARCHAR(255),
    meeting_date TIMESTAMP,
    meeting_notes TEXT,
    
    -- Shipping details (if applicable)
    shipping_method VARCHAR(100),
    tracking_number VARCHAR(100),
    shipped_at TIMESTAMP,
    delivered_at TIMESTAMP,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP
);

-- Create reviews table (for both products and marketplace)
CREATE TABLE reviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    reviewer_id UUID NOT NULL REFERENCES users(id),
    
    -- Review target (either product or marketplace transaction)
    product_id UUID REFERENCES products(id),
    transaction_id UUID REFERENCES marketplace_transactions(id),
    
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    title VARCHAR(255),
    comment TEXT,
    
    -- Review metadata
    is_verified_purchase BOOLEAN DEFAULT FALSE,
    is_featured BOOLEAN DEFAULT FALSE,
    helpful_count INTEGER DEFAULT 0,
    reported_count INTEGER DEFAULT 0,
    
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING', -- PENDING, APPROVED, REJECTED, HIDDEN
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Ensure review is for either product or transaction, not both
    CONSTRAINT chk_review_target CHECK (
        (product_id IS NOT NULL AND transaction_id IS NULL) OR 
        (product_id IS NULL AND transaction_id IS NOT NULL)
    )
);

-- Create review images table
CREATE TABLE review_images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    review_id UUID NOT NULL REFERENCES reviews(id) ON DELETE CASCADE,
    url VARCHAR(500) NOT NULL,
    alt_text VARCHAR(255),
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create user ratings table (seller/buyer reputation)
CREATE TABLE user_ratings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    rated_user_id UUID NOT NULL REFERENCES users(id),
    rater_user_id UUID NOT NULL REFERENCES users(id),
    transaction_id UUID NOT NULL REFERENCES marketplace_transactions(id),
    
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    rating_type VARCHAR(50) NOT NULL, -- SELLER, BUYER
    comment TEXT,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Prevent users from rating themselves
    CONSTRAINT chk_no_self_rating CHECK (rated_user_id != rater_user_id),
    
    -- Ensure one rating per transaction per user
    UNIQUE(transaction_id, rater_user_id, rating_type)
);

-- Create wishlist table
CREATE TABLE wishlists (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id),
    product_id UUID REFERENCES products(id),
    listing_id UUID REFERENCES marketplace_listings(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Ensure wishlist item is for either product or listing
    CONSTRAINT chk_wishlist_target CHECK (
        (product_id IS NOT NULL AND listing_id IS NULL) OR 
        (product_id IS NULL AND listing_id IS NOT NULL)
    ),
    
    -- Prevent duplicate wishlist items
    UNIQUE(user_id, product_id, listing_id)
);

-- Indexes for performance
CREATE INDEX idx_marketplace_listings_seller_id ON marketplace_listings(seller_id);
CREATE INDEX idx_marketplace_listings_category_id ON marketplace_listings(category_id);
CREATE INDEX idx_marketplace_listings_status ON marketplace_listings(status);
CREATE INDEX idx_marketplace_listings_condition ON marketplace_listings(condition);
CREATE INDEX idx_marketplace_listings_price ON marketplace_listings(price);
CREATE INDEX idx_marketplace_listings_created_at ON marketplace_listings(created_at);
CREATE INDEX idx_marketplace_listing_images_listing_id ON marketplace_listing_images(listing_id);

CREATE INDEX idx_marketplace_transactions_listing_id ON marketplace_transactions(listing_id);
CREATE INDEX idx_marketplace_transactions_buyer_id ON marketplace_transactions(buyer_id);
CREATE INDEX idx_marketplace_transactions_seller_id ON marketplace_transactions(seller_id);
CREATE INDEX idx_marketplace_transactions_status ON marketplace_transactions(status);
CREATE INDEX idx_marketplace_transactions_transaction_number ON marketplace_transactions(transaction_number);

CREATE INDEX idx_reviews_reviewer_id ON reviews(reviewer_id);
CREATE INDEX idx_reviews_product_id ON reviews(product_id);
CREATE INDEX idx_reviews_transaction_id ON reviews(transaction_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);
CREATE INDEX idx_reviews_status ON reviews(status);
CREATE INDEX idx_review_images_review_id ON review_images(review_id);

CREATE INDEX idx_user_ratings_rated_user_id ON user_ratings(rated_user_id);
CREATE INDEX idx_user_ratings_rater_user_id ON user_ratings(rater_user_id);
CREATE INDEX idx_user_ratings_transaction_id ON user_ratings(transaction_id);

CREATE INDEX idx_wishlists_user_id ON wishlists(user_id);
CREATE INDEX idx_wishlists_product_id ON wishlists(product_id);
CREATE INDEX idx_wishlists_listing_id ON wishlists(listing_id);
