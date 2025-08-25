-- Insert sample users
INSERT INTO users (id, email, password_hash, role, status, email_verified)
VALUES
  (uuid_generate_v4(), 'cliente1@demo.com', '$2a$10$demoHash1', 'CUSTOMER', 'ACTIVE', TRUE),
  (uuid_generate_v4(), 'vendedor1@demo.com', '$2a$10$demoHash2', 'SELLER', 'ACTIVE', TRUE),
  (uuid_generate_v4(), 'admin@demo.com', '$2a$10$demoHash3', 'ADMIN', 'ACTIVE', TRUE);

-- Insert sample categories
INSERT INTO categories (id, name, description, slug)
VALUES
  (uuid_generate_v4(), 'Electrónica', 'Dispositivos electrónicos', 'electronica'),
  (uuid_generate_v4(), 'Hogar', 'Artículos para el hogar', 'hogar');

-- Insert sample brands
INSERT INTO brands (id, name, description)
VALUES
  (uuid_generate_v4(), 'Samsung', 'Tecnología y electrónica'),
  (uuid_generate_v4(), 'LG', 'Electrodomésticos y electrónica');

-- Insert sample products
INSERT INTO products (id, name, description, sku, category_id, brand_id, price)
SELECT uuid_generate_v4(), 'Smart TV 50"', 'Televisor inteligente 4K', 'SKU-TV-001', c.id, b.id, 350000
FROM categories c, brands b WHERE c.name = 'Electrónica' AND b.name = 'Samsung';

INSERT INTO products (id, name, description, sku, category_id, brand_id, price)
SELECT uuid_generate_v4(), 'Heladera LG', 'Heladera con freezer', 'SKU-HEL-001', c.id, b.id, 220000
FROM categories c, brands b WHERE c.name = 'Hogar' AND b.name = 'LG';

-- Insert sample marketplace listing
INSERT INTO marketplace_listings (id, seller_id, title, description, category_id, brand_id, condition, price, status)
SELECT uuid_generate_v4(), u.id, 'Celular usado', 'Celular Samsung Galaxy S10 en buen estado', c.id, b.id, 'GOOD', 90000, 'ACTIVE'
FROM users u, categories c, brands b WHERE u.email = 'vendedor1@demo.com' AND c.name = 'Electrónica' AND b.name = 'Samsung';

-- Insert sample order
INSERT INTO orders (id, user_id, status, total_amount, created_at)
SELECT uuid_generate_v4(), u.id, 'PENDING', 350000, CURRENT_TIMESTAMP
FROM users u WHERE u.email = 'cliente1@demo.com';

-- Insert sample order item
INSERT INTO order_items (id, order_id, product_id, quantity, price)
SELECT uuid_generate_v4(), o.id, p.id, 1, p.price
FROM orders o, products p WHERE o.total_amount = p.price;
