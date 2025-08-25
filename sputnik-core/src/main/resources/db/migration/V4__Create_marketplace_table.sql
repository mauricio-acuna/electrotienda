-- Create the marketplace table
CREATE TABLE marketplace_listings (
    id SERIAL PRIMARY KEY,
    seller_id INT NOT NULL,
    product_id INT NOT NULL,
    condition VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (seller_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);