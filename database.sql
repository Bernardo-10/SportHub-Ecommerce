-- SportHub E-commerce Database Schema

-- Create database
CREATE DATABASE IF NOT EXISTS sporthub_db;
USE sporthub_db;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Articles/Products table with sport and equipment category
CREATE TABLE IF NOT EXISTS articles (
    id_article INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price INT NOT NULL,
    sport VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    image_url TEXT,
    featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_sport (sport),
    INDEX idx_category (category),
    INDEX idx_featured (featured)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Orders/Commands table
CREATE TABLE IF NOT EXISTS orders (
    id_order INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount INT NOT NULL,
    status ENUM('pending', 'processing', 'completed', 'cancelled') DEFAULT 'pending',
    shipping_address TEXT,
    shipping_city VARCHAR(100),
    shipping_postal_code VARCHAR(20),
    shipping_country VARCHAR(100),
    FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE,
    INDEX idx_user (id_user),
    INDEX idx_status (status),
    INDEX idx_order_date (order_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Order items table (details of each order)
CREATE TABLE IF NOT EXISTS order_items (
    id_order_item INT AUTO_INCREMENT PRIMARY KEY,
    id_order INT NOT NULL,
    id_article INT NOT NULL,
    quantity INT NOT NULL,
    price INT NOT NULL,
    FOREIGN KEY (id_order) REFERENCES orders(id_order) ON DELETE CASCADE,
    FOREIGN KEY (id_article) REFERENCES articles(id_article) ON DELETE CASCADE,
    INDEX idx_order (id_order),
    INDEX idx_article (id_article)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO articles (name, description, price, sport, category, stock, image_url, featured) VALUES
-- Football
('Maillot de Football Pro', 'Maillot de football professionnel avec technologie respirante', 59.99, 'football', 'maillots', 25, 'https://images.unsplash.com/photo-1638260753148-d0316920e0af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBzaGlydCUyMGplcnNleXxlbnwxfHx8fDE3NjEwNjE0Mzl8MA&ixlib=rb-4.1.0&q=80&w=1080', TRUE),
('Crampons de Football Elite', 'Chaussures de football avec crampons pour adhérence maximale', 129.99, 'football', 'chaussures', 18, 'https://images.unsplash.com/photo-1620650663972-a03f6f55930a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmb290YmFsbCUyMGNsZWF0cyUyMGJvb3RzfGVufDF8fHx8MTc2MTA2MTQ0MHww&ixlib=rb-4.1.0&q=80&w=1080', TRUE),
('Ballon de Football Professional', 'Ballon de football professionnel pour tous les terrains', 34.99, 'football', 'accessoires', 30, 'https://images.unsplash.com/photo-1663270010598-f288e7801ce7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzb2NjZXIlMjBiYWxsJTIwZXF1aXBtZW50fGVufDF8fHx8MTc2MTA0NzU4Mnww&ixlib=rb-4.1.0&q=80&w=1080', FALSE),
('Gants de Gardien Pro', 'Gants de gardien avec grip professionnel', 49.99, 'football', 'accessoires', 15, 'https://images.unsplash.com/photo-1663270010598-f288e7801ce7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzb2NjZXIlMjBiYWxsJTIwZXF1aXBtZW50fGVufDF8fHx8MTc2MTA0NzU4Mnww&ixlib=rb-4.1.0&q=80&w=1080', FALSE),

-- Basketball
('Maillot de Basketball Pro', 'Maillot de basketball léger et respirant', 54.99, 'basketball', 'maillots', 20, 'https://images.unsplash.com/photo-1638260753148-d0316920e0af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBzaGlydCUyMGplcnNleXxlbnwxfHx8fDE3NjEwNjE0Mzl8MA&ixlib=rb-4.1.0&q=80&w=1080', TRUE),
('Chaussures de Basketball Elite', 'Baskets montantes avec support de cheville optimal', 149.99, 'basketball', 'chaussures', 12, 'https://images.unsplash.com/photo-1605348532760-6753d2c43329?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxiYXNrZXRiYWxsJTIwc2hvZXN8ZW58MXx8fHwxNzYxMDA3MjIzfDA&ixlib=rb-4.1.0&q=80&w=1080', TRUE),
('Ballon de Basketball Official', 'Ballon de basketball taille officielle', 39.99, 'basketball', 'accessoires', 25, 'https://images.unsplash.com/photo-1677417281771-2a861ce553ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBlcXVpcG1lbnQlMjBneW18ZW58MXx8fHwxNzYxMDQ3MDMzfDA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),
('Genouillères Basketball', 'Protection genoux pour basketball', 29.99, 'basketball', 'accessoires', 18, 'https://images.unsplash.com/photo-1677417281771-2a861ce553ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBlcXVpcG1lbnQlMjBneW18ZW58MXx8fHwxNzYxMDQ3MDMzfDA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),

-- Natation
('Maillot de Bain Competition', 'Maillot de natation haute performance', 79.99, 'natation', 'maillots', 22, 'https://images.unsplash.com/photo-1638260753148-d0316920e0af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBzaGlydCUyMGplcnNleXxlbnwxfHx8fDE3NjEwNjE0Mzl8MA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),
('Lunettes de Natation Pro', 'Lunettes de natation anti-buée professionnelles', 34.99, 'natation', 'accessoires', 35, 'https://images.unsplash.com/photo-1677417281771-2a861ce553ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBlcXVpcG1lbnQlMjBneW18ZW58MXx8fHwxNzYxMDQ3MDMzfDA&ixlib=rb-4.1.0&q=80&w=1080', TRUE),
('Bonnet de Natation Silicone', 'Bonnet de natation en silicone confortable', 14.99, 'natation', 'accessoires', 40, 'https://images.unsplash.com/photo-1677417281771-2a861ce553ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBlcXVpcG1lbnQlMjBneW18ZW58MXx8fHwxNzYxMDQ3MDMzfDA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),
('Palmes de Natation Training', 'Palmes d\'entraînement pour natation', 44.99, 'natation', 'accessoires', 20, 'https://images.unsplash.com/photo-1677417281771-2a861ce553ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBlcXVpcG1lbnQlMjBneW18ZW58MXx8fHwxNzYxMDQ3MDMzfDA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),

-- Boxe
('Short de Boxe Pro', 'Short de boxe professionnel et confortable', 44.99, 'boxe', 'maillots', 16, 'https://images.unsplash.com/photo-1638260753148-d0316920e0af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBzaGlydCUyMGplcnNleXxlbnwxfHx8fDE3NjEwNjE0Mzl8MA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),
('Chaussures de Boxe Elite', 'Chaussures de boxe montantes légères', 119.99, 'boxe', 'chaussures', 10, 'https://images.unsplash.com/photo-1605348532760-6753d2c43329?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxiYXNrZXRiYWxsJTIwc2hvZXN8ZW58MXx8fHwxNzYxMDA3MjIzfDA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),
('Gants de Boxe Professional', 'Gants de boxe professionnels en cuir', 89.99, 'boxe', 'accessoires', 14, 'https://images.unsplash.com/photo-1677417281771-2a861ce553ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBlcXVpcG1lbnQlMjBneW18ZW58MXx8fHwxNzYxMDQ3MDMzfDA&ixlib=rb-4.1.0&q=80&w=1080', TRUE),
('Casque de Protection Boxe', 'Casque de protection pour entraînement de boxe', 69.99, 'boxe', 'accessoires', 12, 'https://images.unsplash.com/photo-1677417281771-2a861ce553ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBlcXVpcG1lbnQlMjBneW18ZW58MXx8fHwxNzYxMDQ3MDMzfDA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),

-- Tennis
('Polo de Tennis Premium', 'Polo de tennis élégant et technique', 64.99, 'tennis', 'maillots', 19, 'https://images.unsplash.com/photo-1638260753148-d0316920e0af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBzaGlydCUyMGplcnNleXxlbnwxfHx8fDE3NjEwNjE0Mzl8MA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),
('Chaussures de Tennis Court', 'Chaussures de tennis pour surface dure', 139.99, 'tennis', 'chaussures', 14, 'https://images.unsplash.com/photo-1719523677291-a395426c1a87?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxydW5uaW5nJTIwc2hvZXMlMjBzbmVha2Vyc3xlbnwxfHx8fDE3NjEwMjExNzV8MA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),
('Raquette de Tennis Pro', 'Raquette de tennis professionnelle en graphite', 199.99, 'tennis', 'accessoires', 10, 'https://images.unsplash.com/photo-1677417281771-2a861ce553ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBlcXVpcG1lbnQlMjBneW18ZW58MXx8fHwxNzYxMDQ3MDMzfDA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),
('Balles de Tennis Pack', 'Pack de 3 balles de tennis officielles', 9.99, 'tennis', 'accessoires', 50, 'https://images.unsplash.com/photo-1677417281771-2a861ce553ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBlcXVpcG1lbnQlMjBneW18ZW58MXx8fHwxNzYxMDQ3MDMzfDA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),

-- Running
('T-shirt Running Technique', 'T-shirt de running avec évacuation de transpiration', 39.99, 'running', 'maillots', 28, 'https://images.unsplash.com/photo-1638260753148-d0316920e0af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBzaGlydCUyMGplcnNleXxlbnwxfHx8fDE3NjEwNjE0Mzl8MA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),
('Chaussures de Running Elite', 'Chaussures de course avec amorti avancé', 159.99, 'running', 'chaussures', 20, 'https://images.unsplash.com/photo-1719523677291-a395426c1a87?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxydW5uaW5nJTIwc2hvZXMlMjBzbmVha2Vyc3xlbnwxfHx8fDE3NjEwMjExNzV8MA&ixlib=rb-4.1.0&q=80&w=1080', TRUE),
('Montre GPS Running', 'Montre connectée avec GPS pour running', 249.99, 'running', 'accessoires', 8, 'https://images.unsplash.com/photo-1677417281771-2a861ce553ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBlcXVpcG1lbnQlMjBneW18ZW58MXx8fHwxNzYxMDQ3MDMzfDA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),
('Ceinture Running Hydratation', 'Ceinture de running avec porte-bidon', 34.99, 'running', 'accessoires', 22, 'https://images.unsplash.com/photo-1677417281771-2a861ce553ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBlcXVpcG1lbnQlMjBneW18ZW58MXx8fHwxNzYxMDQ3MDMzfDA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),

-- Fitness
('Débardeur Fitness Compression', 'Débardeur de fitness avec compression musculaire', 34.99, 'fitness', 'maillots', 24, 'https://images.unsplash.com/photo-1638260753148-d0316920e0af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBzaGlydCUyMGplcnNleXxlbnwxfHx8fDE3NjEwNjE0Mzl8MA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),
('Chaussures Cross Training', 'Chaussures polyvalentes pour cross-training', 109.99, 'fitness', 'chaussures', 16, 'https://images.unsplash.com/photo-1719523677291-a395426c1a87?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxydW5uaW5nJTIwc2hvZXMlMjBzbmVha2Vyc3xlbnwxfHx8fDE3NjEwMjExNzV8MA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),
('Kit Bandes de Résistance', 'Set de 5 bandes de résistance avec différentes forces', 29.99, 'fitness', 'accessoires', 35, 'https://images.unsplash.com/photo-1677417281771-2a861ce553ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBlcXVpcG1lbnQlMjBneW18ZW58MXx8fHwxNzYxMDQ3MDMzfDA&ixlib=rb-4.1.0&q=80&w=1080', TRUE),
('Tapis de Yoga Premium', 'Tapis de yoga extra épais avec sac de transport', 49.99, 'fitness', 'accessoires', 28, 'https://images.unsplash.com/photo-1677417281771-2a861ce553ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBlcXVpcG1lbnQlMjBneW18ZW58MXx8fHwxNzYxMDQ3MDMzfDA&ixlib=rb-4.1.0&q=80&w=1080', FALSE),
('Haltères Réglables Set', 'Set d\'haltères réglables 2-10kg', 149.99, 'fitness', 'accessoires', 12, 'https://images.unsplash.com/photo-1677417281771-2a861ce553ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcG9ydHMlMjBlcXVpcG1lbnQlMjBneW18ZW58MXx8fHwxNzYxMDQ3MDMzfDA&ixlib=rb-4.1.0&q=80&w=1080', FALSE);
