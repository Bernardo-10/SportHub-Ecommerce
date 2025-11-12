# SportHub E-commerce - Configuration du backend PHP

## Prérequis

- PHP 7.4 ou supérieur
- MySQL 5.7 ou supérieur
- Serveur web Apache ou Nginx
- XAMPP, WAMP ou LAMP (recommandé pour le développement local)

## Étapes d'installation

### 1. Configuration de la base de données

1. Démarrez votre serveur MySQL (via XAMPP, WAMP ou la ligne de commande)

2. Ouvrez phpMyAdmin ou la ligne de commande MySQL

3. Importez le schéma de la base de données :
   ```sql
   mysql -u root -p < database.sql
   ```
   
   Ou exécutez manuellement le fichier SQL dans phpMyAdmin :
   - Allez sur http://localhost/phpmyadmin
   - Cliquez sur l'onglet "Importer"
   - Choisissez le fichier `database.sql`
   - Cliquez sur "Exécuter" (ou "Go")

4. La base de données `sporthub_db` sera créée avec :
   - la table `users` (informations clients)
   - la table `articles` (produits)
   - la table `orders` (commandes clients)
   - la table `order_items` (détails des commandes)
   - des données d'exemple pour les produits

### 2. Configuration PHP

1. Ouvrez `/php/config.php` et mettez à jour les identifiants de la base de données si nécessaire :
   ```php
   define('DB_HOST', 'localhost');
   define('DB_USER', 'root');        
   define('DB_PASS', '');            
   define('DB_NAME', 'sporthub_db');
   ```

### 3. Configuration du serveur web

#### Option A : Utiliser XAMPP/WAMP

1. Copiez le dossier du projet entier dans le répertoire de votre serveur web :
   - XAMPP : `C:\xampp\htdocs\sporthub\`
   - WAMP : `C:\wamp64\www\sporthub\`

2. Démarrez Apache et MySQL depuis le panneau de contrôle XAMPP/WAMP

3. Accédez au site via : `http://localhost/sporthub/index.html`

#### Option B : Utiliser le serveur intégré PHP (pour tests seulement)

1. Ouvrez un terminal / invite de commandes dans le répertoire du projet

2. Exécutez :
   ```powershell
   php -S localhost:8000
   ```

3. Accédez au site via : `http://localhost:8000/index.html`

### 4. Tester l'application

1. Ouvrez le site web dans votre navigateur

2. Parcourez les produits - ils doivent être chargés depuis la base de données

3. Essayez de passer à la caisse - on vous demandera de vous connecter

4. Créez un nouveau compte :
   - Cliquez sur "Proceed to Checkout"
   - Cliquez sur "Register here"
   - Remplissez le formulaire d'inscription
   - Soumettez le formulaire

5. Après l'inscription, vous pouvez :
   - Ajouter des produits au panier
   - Finaliser la commande
   - Les commandes seront enregistrées dans la base de données

### 5. Aperçu des tables de la base de données

#### Table Users
- Contient les informations clients (email, mot de passe, nom, adresse)
- Les mots de passe sont hachés avec la fonction PHP `password_hash()`

#### Table Articles
- Contient les informations produit
- Pré-remplie avec 12 produits d'exemple

#### Table Orders
- Contient les informations d'en-tête des commandes
- Fait le lien avec la table `users`
- Contient les informations de livraison et le montant total

#### Table Order_Items
- Contient les articles individuels de chaque commande
- Fait le lien entre les commandes et les articles
- Contient la quantité et le prix au moment de l'achat

## Endpoints API

### Authentification (`/php/auth.php`)
- `?action=register` - Enregistrer un nouvel utilisateur (POST)
- `?action=login` - Connexion utilisateur (POST)
- `?action=logout` - Déconnexion (GET)
- `?action=check` - Vérifier si l'utilisateur est authentifié (GET)
- `?action=profile` - Récupérer / mettre à jour le profil utilisateur (GET/PUT)

### Produits (`/php/products.php`)
- `?action=list` - Récupérer tous les produits (GET)
- `?action=get&id={id}` - Récupérer un produit (GET)

### Commandes (`/php/orders.php`)
- `?action=create` - Créer une nouvelle commande (POST)
- `?action=list` - Récupérer les commandes de l'utilisateur (GET)
- `?action=get&id={id}` - Récupérer les détails d'une commande (GET)

## Remarques de sécurité

- Les mots de passe sont hachés avec `password_hash()` (bcrypt)
- Protection contre les injections SQL via les requêtes préparées PDO
- Authentification basée sur les sessions
- Ajouter une protection CSRF pour la production
- Utiliser HTTPS en production

## Dépannage

### « Échec de la connexion à la base de données »
- Vérifiez que MySQL est démarré
- Vérifiez les identifiants dans `/php/config.php`
- Assurez-vous que la base de données `sporthub_db` existe

### « Erreurs CORS »
- Vérifiez que le module mod_headers d'Apache est activé
- Vérifiez les en-têtes CORS définis dans `/php/config.php`

### « Les sessions ne fonctionnent pas »
- Assurez-vous que les sessions PHP sont activées
- Vérifiez que `session.save_path` dans php.ini est accessible en écriture

### Les produits ne s'affichent pas
- Ouvrez la console du navigateur pour chercher des erreurs
- Vérifiez que `/php/products.php` est accessible
- Vérifiez que la base de données contient des produits

## Compte de test par défaut

Vous pouvez créer manuellement un compte de test via phpMyAdmin ou vous enregistrer via le site.

Pour ajouter manuellement un utilisateur de test :
```sql
INSERT INTO users (email, password, first_name, last_name) 
VALUES ('test@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Test', 'User');
-- Mot de passe : password
```

