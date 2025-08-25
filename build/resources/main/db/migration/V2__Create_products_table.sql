-- Create categories table
CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_id UUID REFERENCES categories(id),
    slug VARCHAR(100) NOT NULL UNIQUE,
    image_url VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create brands table
CREATE TABLE brands (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    logo_url VARCHAR(500),
    website_url VARCHAR(300),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create products table
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    short_description VARCHAR(500),
    sku VARCHAR(100) UNIQUE,
    category_id UUID NOT NULL REFERENCES categories(id),
    brand_id UUID REFERENCES brands(id),
    price DECIMAL(10,2) NOT NULL,
    compare_price DECIMAL(10,2), -- Original price for discounts
    cost_price DECIMAL(10,2), -- Internal cost
    weight DECIMAL(8,3), -- in kg
    dimensions VARCHAR(50), -- WxHxD in cm
    status VARCHAR(50) NOT NULL DEFAULT 'DRAFT', -- DRAFT, ACTIVE, INACTIVE, ARCHIVED
    is_featured BOOLEAN DEFAULT FALSE,
    is_digital BOOLEAN DEFAULT FALSE,
    requires_shipping BOOLEAN DEFAULT TRUE,
    track_inventory BOOLEAN DEFAULT TRUE,
    meta_title VARCHAR(255),
    meta_description VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create product images table
CREATE TABLE product_images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    url VARCHAR(500) NOT NULL,
    alt_text VARCHAR(255),
    is_primary BOOLEAN DEFAULT FALSE,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create product attributes table (for specifications)
CREATE TABLE product_attributes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL, -- e.g., "Screen Size", "Memory", "Color"
    value VARCHAR(500) NOT NULL, -- e.g., "6.1 inches", "128GB", "Black"
    type VARCHAR(50) DEFAULT 'TEXT', -- TEXT, NUMBER, BOOLEAN, COLOR
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create product variants table (for different configurations)
CREATE TABLE product_variants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    sku VARCHAR(100) UNIQUE,
    name VARCHAR(255), -- e.g., "iPhone 14 - 128GB - Black"
    price DECIMAL(10,2),
    compare_price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    weight DECIMAL(8,3),
    image_url VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create product variant attributes table
CREATE TABLE product_variant_attributes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    variant_id UUID NOT NULL REFERENCES product_variants(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL, -- e.g., "Color", "Storage"
    value VARCHAR(500) NOT NULL, -- e.g., "Black", "128GB"
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX idx_categories_parent_id ON categories(parent_id);
CREATE INDEX idx_categories_slug ON categories(slug);
CREATE INDEX idx_brands_name ON brands(name);
CREATE INDEX idx_products_category_id ON products(category_id);
CREATE INDEX idx_products_brand_id ON products(brand_id);
CREATE INDEX idx_products_status ON products(status);
CREATE INDEX idx_products_sku ON products(sku);
CREATE INDEX idx_product_images_product_id ON product_images(product_id);
CREATE INDEX idx_product_attributes_product_id ON product_attributes(product_id);
CREATE INDEX idx_product_variants_product_id ON product_variants(product_id);
CREATE INDEX idx_product_variant_attributes_variant_id ON product_variant_attributes(variant_id);

-- Insert sample categories
INSERT INTO categories (name, description, slug, sort_order) VALUES
('Smartphones', 'Teléfonos móviles y smartphones', 'smartphones', 1),
('Tablets', 'Tablets y dispositivos táctiles', 'tablets', 2),
('Accessories', 'Accesorios para dispositivos electrónicos', 'accessories', 3),
('Audio', 'Auriculares, parlantes y audio', 'audio', 4),
('Charging', 'Cargadores y cables', 'charging', 5);

-- Insert subcategories
INSERT INTO categories (name, description, slug, parent_id, sort_order) VALUES
('Android Phones', 'Smartphones con sistema Android', 'android-phones', (SELECT id FROM categories WHERE slug = 'smartphones'), 1),
('iPhone', 'Smartphones Apple iPhone', 'iphone', (SELECT id FROM categories WHERE slug = 'smartphones'), 2),
('Cases & Covers', 'Fundas y cubiertas protectoras', 'cases-covers', (SELECT id FROM categories WHERE slug = 'accessories'), 1),
('Screen Protectors', 'Protectores de pantalla', 'screen-protectors', (SELECT id FROM categories WHERE slug = 'accessories'), 2);

-- Insert sample brands
INSERT INTO brands (name, description, website_url) VALUES
('Apple', 'Tecnología e innovación desde California', 'https://www.apple.com'),
('Samsung', 'Líder mundial en tecnología', 'https://www.samsung.com'),
('Xiaomi', 'Tecnología para todos', 'https://www.mi.com'),
('Huawei', 'Construyendo un mundo mejor conectado', 'https://www.huawei.com'),
('Google', 'Organizando la información del mundo', 'https://www.google.com');
