// API Configuration
const API_BASE = 'php';

// State
let currentUser = null;

// Product Data (fallback if API is not available)
let PRODUCTS = [];

// Cart state
let cart = [];
let selectedSport = 'all';
let selectedCategory = 'all';
let searchQuery = '';

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    checkAuthentication();
    loadProducts();
    setupEventListeners();
    
    // Check for sport parameter in URL
    const urlParams = new URLSearchParams(window.location.search);
    const sportParam = urlParams.get('sport');
    if (sportParam) {
        selectedSport = sportParam;
        // Update active tab if exists
        const tabs = document.querySelectorAll('.tab-button');
        tabs.forEach(tab => {
            if (tab.dataset.sport === sportParam) {
                document.querySelectorAll('.tab-button').forEach(b => b.classList.remove('active'));
                tab.classList.add('active');
            }
        });
    }
});

// Event Listeners
function setupEventListeners() {
    // Sport tabs
    document.querySelectorAll('.tab-button').forEach(button => {
        button.addEventListener('click', (e) => {
            document.querySelectorAll('.tab-button').forEach(b => b.classList.remove('active'));
            e.target.classList.add('active');
            selectedSport = e.target.dataset.sport;
            renderProducts();
        });
    });

    // Equipment category filter
    document.querySelectorAll('.filter-button').forEach(button => {
        button.addEventListener('click', (e) => {
            document.querySelectorAll('.filter-button').forEach(b => b.classList.remove('active'));
            e.target.classList.add('active');
            selectedCategory = e.target.dataset.category;
            renderProducts();
        });
    });

    // Search modal
    const searchModalInput = document.getElementById('search-modal-input');
    if (searchModalInput) {
        searchModalInput.addEventListener('input', (e) => {
            const query = e.target.value.toLowerCase();
            handleSearchModal(query);
        });
    }

    // Cart
    document.getElementById('cart-button').addEventListener('click', openCart);
    document.getElementById('close-cart').addEventListener('click', closeCart);
    document.getElementById('cart-overlay').addEventListener('click', closeCart);

    // Mobile Menu
    const menuButton = document.getElementById('menu-button');
    const mobileNav = document.getElementById('mobile-nav');
    
    if (menuButton && mobileNav) {
        menuButton.addEventListener('click', toggleMobileMenu);
        
        // Close mobile menu when clicking on a link
        document.querySelectorAll('.mobile-nav-link').forEach(link => {
            link.addEventListener('click', () => {
                mobileNav.classList.remove('open');
            });
        });
    }
}

// Toggle Mobile Menu
function toggleMobileMenu() {
    const mobileNav = document.getElementById('mobile-nav');
    if (mobileNav) {
        const isOpening = !mobileNav.classList.contains('open');
        mobileNav.classList.toggle('open');
        
        // Don't prevent body scroll for mobile menu since it's part of the header
        // Only prevent for overlays like cart
    }
}

// Render Products
function renderProducts() {
    const grid = document.getElementById('products-grid');
    const noResults = document.getElementById('no-results');
    
    const filtered = PRODUCTS.filter(product => {
        const matchesSport = selectedSport === 'all' || product.sport === selectedSport;
        const matchesCategory = selectedCategory === 'all' || product.category === selectedCategory;
        const matchesSearch = searchQuery === '' || 
            product.name.toLowerCase().includes(searchQuery) ||
            product.description.toLowerCase().includes(searchQuery) ||
            product.sport.toLowerCase().includes(searchQuery);
        return matchesSport && matchesCategory && matchesSearch;
    });

    if (filtered.length === 0) {
        grid.style.display = 'none';
        noResults.style.display = 'block';
        return;
    }

    grid.style.display = 'grid';
    noResults.style.display = 'none';

    // Helper function to get category display name in French
    const getCategoryLabel = (cat) => {
        const labels = {
            'maillots': 'Maillots',
            'chaussures': 'Chaussures',
            'accessoires': 'Accessoires'
        };
        return labels[cat] || cat;
    };

    // Helper function to get sport display name
    const getSportLabel = (sport) => {
        const labels = {
            'football': '⚽ Football',
            'basketball': '🏀 Basketball',
            'natation': '🏊 Natation',
            'boxe': '🥊 Boxe',
            'tennis': '🎾 Tennis',
            'running': '🏃 Running',
            'fitness': '💪 Fitness'
        };
        return labels[sport] || sport;
    };

    grid.innerHTML = filtered.map(product => `
        <div class="product-card" onclick="openProductModal(${product.id})">
            <div class="product-image-container">
                <img src="${product.image}" alt="${product.name}" class="product-image">
                ${product.featured ? '<span class="badge badge-featured">En vedette</span>' : ''}
                ${product.stock < 5 && product.stock > 0 ? '<span class="badge badge-low-stock">Stock bas</span>' : ''}
            </div>
            <div class="product-content">
                <div style="display: flex; gap: 0.5rem; margin-bottom: 0.5rem;">
                    <span class="category-badge" style="background: #dbeafe; color: #1e40af;">${getSportLabel(product.sport)}</span>
                    <span class="category-badge">${getCategoryLabel(product.category)}</span>
                </div>
                <h3 class="product-name">${product.name}</h3>
                <p class="product-description">${product.description}</p>
                <div class="product-footer">
                    <span class="product-price">${product.price.toFixed(0)}FCFA</span>
                    <span class="product-stock">${product.stock > 0 ? `${product.stock} en stock` : 'Rupture de stock'}</span>
                </div>
            </div>
            <div class="product-actions">
                <button class="btn btn-primary" onclick="event.stopPropagation(); addToCart(${product.id})" ${product.stock === 0 ? 'disabled' : ''}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="9" cy="21" r="1"></circle>
                        <circle cx="20" cy="21" r="1"></circle>
                        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                    </svg>
                    ${product.stock === 0 ? 'Rupture de stock' : 'Ajouter au panier'}
                </button>
            </div>
        </div>
    `).join('');
}

// Add to Cart
function addToCart(productId) {
    const product = PRODUCTS.find(p => p.id === productId);
    if (!product) return;

    const existingItem = cart.find(item => item.id === productId);
    
    if (existingItem) {
        if (existingItem.quantity >= product.stock) {
            showToast('Cannot add more items than available in stock', 'error');
            return;
        }
        existingItem.quantity++;
        showToast(`${product.name} ajouté à nouveau au panier`, 'success');
    } else {
        cart.push({ ...product, quantity: 1 });
        showToast(`${product.name} ajouté au panier`, 'success');
    }

    updateCart();
}

// Update Cart
function updateCart() {
    const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
    const badge = document.getElementById('cart-badge');
    badge.textContent = totalItems;
    badge.style.display = totalItems > 0 ? 'flex' : 'none';

    renderCart();
}

// Render Cart
function renderCart() {
    const cartBody = document.getElementById('cart-body');
    const cartEmpty = document.getElementById('cart-empty');
    const cartFooter = document.getElementById('cart-footer');
    const cartCount = document.getElementById('cart-count');

    const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
    cartCount.textContent = totalItems;

    if (cart.length === 0) {
        cartBody.style.display = 'none';
        cartEmpty.style.display = 'flex';
        cartFooter.style.display = 'none';
        return;
    }

    cartBody.style.display = 'block';
    cartEmpty.style.display = 'none';
    cartFooter.style.display = 'block';

    cartBody.innerHTML = cart.map(item => `
        <div class="cart-item">
            <div class="cart-item-image">
                <img src="${item.image}" alt="${item.name}">
            </div>
            <div class="cart-item-details">
                <h4 class="cart-item-name">${item.name}</h4>
                <p class="cart-item-price">${item.price.toFixed(0)}FCFA</p>
                <div class="cart-item-actions">
                    <button class="quantity-btn" onclick="updateQuantity(${item.id}, ${item.quantity - 1})">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <line x1="5" y1="12" x2="19" y2="12"></line>
                        </svg>
                    </button>
                    <span class="quantity">${item.quantity}</span>
                    <button class="quantity-btn" onclick="updateQuantity(${item.id}, ${item.quantity + 1})" ${item.quantity >= item.stock ? 'disabled' : ''}>
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <line x1="12" y1="5" x2="12" y2="19"></line>
                            <line x1="5" y1="12" x2="19" y2="12"></line>
                        </svg>
                    </button>
                    <button class="remove-btn" onclick="removeFromCart(${item.id})">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="3 6 5 6 21 6"></polyline>
                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                        </svg>
                    </button>
                </div>
            </div>
            <div class="cart-item-total">
                ${(item.price * item.quantity).toFixed(0)}FCFA
            </div>
        </div>
    `).join('');

    const total = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
    document.getElementById('cart-subtotal').textContent = `${total.toFixed(0)}FCFA`;
    document.getElementById('cart-total').textContent = `${total.toFixed(0)}FCFA`;
}

// Update Quantity
function updateQuantity(productId, quantity) {
    if (quantity < 1) return;
    
    const item = cart.find(item => item.id === productId);
    if (!item) return;

    item.quantity = quantity;
    updateCart();
}

// Remove from Cart
function removeFromCart(productId) {
    cart = cart.filter(item => item.id !== productId);
    showToast('Article retiré du panier', 'success');
    updateCart();
}

// Open/Close Cart
function openCart() {
    document.getElementById('cart-drawer').classList.add('open');
    document.body.style.overflow = 'hidden';
}

function closeCart() {
    document.getElementById('cart-drawer').classList.remove('open');
    document.body.style.overflow = '';
}

// Product Modal
function openProductModal(productId) {
    const product = PRODUCTS.find(p => p.id === productId);
    if (!product) return;

    const modal = document.getElementById('product-modal');
    const modalBody = document.getElementById('modal-body');

    // Helper functions for labels
    const getCategoryLabel = (cat) => {
        const labels = {
            'maillots': 'Maillots',
            'chaussures': 'Chaussures',
            'accessoires': 'Accessoires'
        };
        return labels[cat] || cat;
    };

    const getSportLabel = (sport) => {
        const labels = {
            'football': '⚽ Football',
            'basketball': '🏀 Basketball',
            'natation': '🏊 Natation',
            'boxe': '🥊 Boxe',
            'tennis': '🎾 Tennis',
            'running': '🏃 Running',
            'fitness': '💪 Fitness'
        };
        return labels[sport] || sport;
    };

    modalBody.innerHTML = `
        <div class="modal-grid">
            <div class="modal-image">
                <img src="${product.image}" alt="${product.name}">
                ${product.featured ? '<span class="badge badge-featured">En vedette</span>' : ''}
            </div>
            <div class="modal-info">
                <div style="display: flex; gap: 0.5rem; margin-bottom: 1rem; flex-wrap: wrap;">
                    <span class="category-badge" style="background: #dbeafe; color: #1e40af;">${getSportLabel(product.sport)}</span>
                    <span class="category-badge">${getCategoryLabel(product.category)}</span>
                </div>
                <h2>${product.name}</h2>
                <div class="modal-price">${product.price.toFixed(0)}FCFA</div>
                
                <div class="modal-section">
                    <h3>Description</h3>
                    <p>${product.description}</p>
                    <p>Équipement de haute qualité pour ${getSportLabel(product.sport).replace(/[⚽🏀🏊🥊🎾🏃💪]/g, '').trim()}. 
                    Fabriqué avec des matériaux premium et une technologie de pointe pour vous aider à 
                    atteindre vos objectifs sportifs.</p>
                </div>

                <div class="modal-section">
                    <h3>Disponibilité</h3>
                    <div class="availability">
                        <div class="availability-dot ${product.stock > 0 ? 'in-stock' : 'out-of-stock'}"></div>
                        <span>${product.stock > 0 ? `En stock (${product.stock} disponibles)` : 'Rupture de stock'}</span>
                    </div>
                </div>

                <div class="modal-section">
                    <h3>Caractéristiques</h3>
                    <ul class="modal-features">
                        <li>Matériaux de qualité premium</li>
                        <li>Design ergonomique pour un confort maximum</li>
                        <li>Construction durable pour une utilisation longue durée</li>
                        <li>Performance de niveau professionnel</li>
                    </ul>
                </div>

                <div class="modal-actions">
                    <button class="btn btn-primary" onclick="addToCart(${product.id}); closeProductModal();" ${product.stock === 0 ? 'disabled' : ''}>
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="9" cy="21" r="1"></circle>
                            <circle cx="20" cy="21" r="1"></circle>
                            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                        </svg>
                        ${product.stock === 0 ? 'Rupture de stock' : 'Ajouter au panier'}
                    </button>
                    <button class="btn btn-outline" onclick="closeProductModal()">Continuer vos achats</button>
                </div>
            </div>
        </div>
    `;

    modal.classList.add('open');
    document.body.style.overflow = 'hidden';
}

function closeProductModal() {
    document.getElementById('product-modal').classList.remove('open');
    document.body.style.overflow = '';
}

// Toast Notifications
function showToast(message, type = 'success') {
    const container = document.getElementById('toast-container');
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    toast.textContent = message;

    container.appendChild(toast);

    setTimeout(() => {
        toast.style.animation = 'slideIn 0.3s ease-out reverse';
        setTimeout(() => {
            container.removeChild(toast);
        }, 300);
    }, 3000);
}

// Navigate to sport products page
function navigateToSport(sport) {
    window.location.href = `products.html?sport=${sport}`;
}

// Scroll to Products
function scrollToProducts() {
    const productsSection = document.getElementById('products');
    if (productsSection) {
        productsSection.scrollIntoView({ behavior: 'smooth' });
    }
}

// ============ API FUNCTIONS ============

// Load products from API
async function loadProducts() {
    try {
        const response = await fetch(`${API_BASE}/products.php?action=list`);
        if (response.ok) {
            const products = await response.json();
            // Map API field names to local structure
            PRODUCTS = products.map(p => ({
                id: p.id_article,
                name: p.name,
                price: p.price,
                sport: p.sport,
                category: p.category,
                image: p.image_url,
                description: p.description,
                stock: p.stock,
                featured: p.featured
            }));
            renderProducts();
        } else {
            // Use fallback data
            renderProducts();
        }
    } catch (error) {
        console.error('Error loading products:', error);
        renderProducts(); // Use fallback data
    }
}

// Check authentication status
async function checkAuthentication() {
    try {
        const response = await fetch(`${API_BASE}/auth.php?action=check`);
        const data = await response.json();
        
        if (data.authenticated) {
            currentUser = data.user;
            updateUIForAuthState();
        }
    } catch (error) {
        console.error('Error checking authentication:', error);
    }
}

// Update UI based on auth state
function updateUIForAuthState() {
    const userButton = document.getElementById('user-button');
    const userName = document.getElementById('user-name');
    const userIcon = document.getElementById('user-icon');
    const userAvatar = document.getElementById('user-avatar');
    
    if (currentUser) {
        console.log('User logged in:', currentUser.email);
        userButton.style.display = 'flex';
        userName.textContent = currentUser.firstName || currentUser.email.split('@')[0];
        
        // Set avatar letter (first letter of first name)
        const firstLetter = (currentUser.firstName || currentUser.email.charAt(0)).charAt(0).toUpperCase();
        userAvatar.textContent = firstLetter;
        
        // Add class to indicate logged in state
        userButton.classList.add('logged-in');
        
        // Change onclick to show user menu instead
        userButton.onclick = () => {
            if (confirm(`Logged in as ${currentUser.email}\n\nDo you want to logout?`)) {
                handleLogout();
            }
        };
    } else {
        userButton.style.display = 'flex';
        userName.textContent = 'Login';
        userButton.classList.remove('logged-in');
        userButton.onclick = openAuthModal;
    }
}

// Handle logout
async function handleLogout() {
    try {
        const response = await fetch(`${API_BASE}/auth.php?action=logout`);
        if (response.ok) {
            currentUser = null;
            showToast('Logged out successfully', 'success');
            updateUIForAuthState();
        }
    } catch (error) {
        console.error('Logout error:', error);
    }
}

// ============ AUTH FUNCTIONS ============

// Handle login form submission
async function handleLogin(event) {
    event.preventDefault();
    
    const email = document.getElementById('login-email').value;
    const password = document.getElementById('login-password').value;
    const errorEl = document.getElementById('login-error');
    const btn = document.getElementById('login-btn');
    
    errorEl.textContent = '';
    btn.disabled = true;
    btn.textContent = 'Logging in...';
    
    try {
        const response = await fetch(`${API_BASE}/auth.php?action=login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
        });
        
        const data = await response.json();
        
        if (response.ok && data.success) {
            currentUser = data.user;
            showToast('Connexion réussie !', 'success');
            closeAuthModal();
            updateUIForAuthState();
            
            // If we were trying to checkout, show shipping modal
            if (window.pendingCheckout) {
                window.pendingCheckout = false;
                openShippingModal();
            }
        } else {
            errorEl.textContent = data.error || 'Login failed';
        }
    } catch (error) {
        errorEl.textContent = 'Network error. Please try again.';
    } finally {
        btn.disabled = false;
        btn.textContent = 'Login';
    }
}

// Handle register form submission
async function handleRegister(event) {
    event.preventDefault();
    
    const firstName = document.getElementById('register-firstname').value;
    const lastName = document.getElementById('register-lastname').value;
    const email = document.getElementById('register-email').value;
    const password = document.getElementById('register-password').value;
    const passwordConfirm = document.getElementById('register-password-confirm').value;
    const errorEl = document.getElementById('register-error');
    const btn = document.getElementById('register-btn');
    
    errorEl.textContent = '';
    
    if (password !== passwordConfirm) {
        errorEl.textContent = 'Passwords do not match';
        return;
    }
    
    btn.disabled = true;
    btn.textContent = 'Creating account...';
    
    try {
        const response = await fetch(`${API_BASE}/auth.php?action=register`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password, firstName, lastName })
        });
        
        const data = await response.json();
        
        if (response.ok && data.success) {
            currentUser = data.user;
            showToast('Compte créé avec succès !', 'success');
            closeAuthModal();
            updateUIForAuthState();
            
            // If we were trying to checkout, show shipping modal
            if (window.pendingCheckout) {
                window.pendingCheckout = false;
                openShippingModal();
            }
        } else {
            errorEl.textContent = data.error || 'Registration failed';
        }
    } catch (error) {
        errorEl.textContent = 'Network error. Please try again.';
    } finally {
        btn.disabled = false;
        btn.textContent = 'Create Account';
    }
}

// Show/hide auth forms
function showLoginForm() {
    document.getElementById('login-form').style.display = 'block';
    document.getElementById('register-form').style.display = 'none';
    document.getElementById('login-error').textContent = '';
}

function showRegisterForm() {
    document.getElementById('login-form').style.display = 'none';
    document.getElementById('register-form').style.display = 'block';
    document.getElementById('register-error').textContent = '';
}

function openAuthModal() {
    document.getElementById('auth-modal').classList.add('open');
    document.body.style.overflow = 'hidden';
    showLoginForm();
}

function closeAuthModal() {
    document.getElementById('auth-modal').classList.remove('open');
    document.body.style.overflow = '';
    // Reset forms
    document.getElementById('login-form').reset();
    document.getElementById('register-form').reset();
    document.getElementById('login-error').textContent = '';
    document.getElementById('register-error').textContent = '';
}

// ============ CHECKOUT FUNCTIONS ============

// Handle checkout button click
function handleCheckout() {
    if (!currentUser) {
        // User not logged in, show auth modal
        window.pendingCheckout = true;
        closeCart();
        openAuthModal();
        showToast('Veuillez vous connecter pour finaliser votre achat', 'error');
    } else {
        // User is logged in, show shipping info modal
        closeCart();
        openShippingModal();
    }
}

// Open/Close Shipping Modal
function openShippingModal() {
    const modal = document.getElementById('shipping-modal');
    
    // Pre-fill with user data if available
    if (currentUser) {
        document.getElementById('shipping-address').value = currentUser.address || '';
        document.getElementById('shipping-city').value = currentUser.city || '';
        document.getElementById('shipping-postal').value = currentUser.postal_code || '';
        document.getElementById('shipping-country').value = currentUser.country || '';
        document.getElementById('shipping-phone').value = currentUser.phone || '';
    }
    
    modal.classList.add('open');
    document.body.style.overflow = 'hidden';
}

function closeShippingModal() {
    const modal = document.getElementById('shipping-modal');
    modal.classList.remove('open');
    document.body.style.overflow = '';
    
    // Reset form
    const form = modal.querySelector('form');
    if (form) form.reset();
    document.getElementById('shipping-error').textContent = '';
}

// Handle shipping form submission
async function handleShippingSubmit(event) {
    event.preventDefault();
    
    if (cart.length === 0) {
        showToast('Votre panier est vide', 'error');
        closeShippingModal();
        return;
    }
    
    const address = document.getElementById('shipping-address').value;
    const city = document.getElementById('shipping-city').value;
    const postalCode = document.getElementById('shipping-postal').value;
    const country = document.getElementById('shipping-country').value;
    const phone = document.getElementById('shipping-phone').value;
    const errorEl = document.getElementById('shipping-error');
    const btn = document.getElementById('shipping-btn');
    
    errorEl.textContent = '';
    btn.disabled = true;
    btn.textContent = 'Traitement...';
    
    // Prepare order data
    const orderData = {
        items: cart.map(item => ({
            id: item.id,
            quantity: item.quantity
        })),
        shippingAddress: address,
        shippingCity: city,
        shippingPostalCode: postalCode,
        shippingCountry: country,
        phone: phone
    };
    
    try {
        const response = await fetch(`${API_BASE}/orders.php?action=create`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(orderData)
        });
        
        const data = await response.json();
        
        if (response.ok && data.success) {
            showToast(`Commande confirmée ! Numéro: ${data.orderId}`, 'success');
            cart = [];
            updateCart();
            closeShippingModal();
            
            // Reload products to update stock
            loadProducts();
        } else {
            errorEl.textContent = data.error || 'Échec de la commande. Veuillez réessayer.';
        }
    } catch (error) {
        errorEl.textContent = 'Erreur réseau. Veuillez réessayer.';
    } finally {
        btn.disabled = false;
        btn.textContent = 'Confirmer la Commande';
    }
}

// ============ SEARCH MODAL FUNCTIONS ============

// Open/Close Search Modal
function openSearchModal() {
    const modal = document.getElementById('search-modal');
    const input = document.getElementById('search-modal-input');
    modal.classList.add('open');
    document.body.style.overflow = 'hidden';
    
    // Focus on input
    setTimeout(() => {
        if (input) input.focus();
    }, 100);
    
    // Show initial results (all products)
    handleSearchModal('');
}

function closeSearchModal() {
    const modal = document.getElementById('search-modal');
    modal.classList.remove('open');
    document.body.style.overflow = '';
    
    // Clear search
    const input = document.getElementById('search-modal-input');
    if (input) input.value = '';
    document.getElementById('search-results').innerHTML = '';
}

// Handle search in modal
function handleSearchModal(query) {
    const resultsContainer = document.getElementById('search-results');
    
    if (!PRODUCTS || PRODUCTS.length === 0) {
        resultsContainer.innerHTML = '<p style="text-align: center; color: #6b7280; padding: 2rem;">Chargement des produits...</p>';
        return;
    }
    
    const filtered = PRODUCTS.filter(product => {
        if (query === '') return true; // Show all if no query
        
        return product.name.toLowerCase().includes(query) ||
               product.description.toLowerCase().includes(query) ||
               product.sport.toLowerCase().includes(query) ||
               product.category.toLowerCase().includes(query);
    });
    
    if (filtered.length === 0) {
        resultsContainer.innerHTML = '<p style="text-align: center; color: #6b7280; padding: 2rem;">Aucun produit trouvé</p>';
        return;
    }
    
    // Helper functions
    const getCategoryLabel = (cat) => {
        const labels = {
            'maillots': 'Maillots',
            'chaussures': 'Chaussures',
            'accessoires': 'Accessoires'
        };
        return labels[cat] || cat;
    };

    const getSportLabel = (sport) => {
        const labels = {
            'football': '⚽ Football',
            'basketball': '🏀 Basketball',
            'natation': '🏊 Natation',
            'boxe': '🥊 Boxe',
            'tennis': '🎾 Tennis',
            'running': '🏃 Running',
            'fitness': '💪 Fitness'
        };
        return labels[sport] || sport;
    };
    
    resultsContainer.innerHTML = filtered.slice(0, 10).map(product => `
        <div class="search-result-item" onclick="selectSearchResult(${product.id})">
            <img src="${product.image}" alt="${product.name}" class="search-result-image">
            <div class="search-result-info">
                <h4>${product.name}</h4>
                <p>${getSportLabel(product.sport)} • ${getCategoryLabel(product.category)}</p>
            </div>
            <div class="search-result-price">${product.price.toFixed(0)}FCFA</div>
        </div>
    `).join('');
}

// Handle search result selection
function selectSearchResult(productId) {
    closeSearchModal();
    
    // Scroll to products section
    document.getElementById('products').scrollIntoView({ behavior: 'smooth' });
    
    // Open product modal after a short delay
    setTimeout(() => {
        openProductModal(productId);
    }, 500);
}
// ============ BACK TO TOP BUTTON ============
  const btn = document.getElementById("btnTop");

  // Quand on défile vers le bas de 100px, on affiche le bouton
  window.onscroll = function() {
    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
      btn.style.display = "block";
    } else {
      btn.style.display = "none";
    }
  };

  // Quand on clique, on remonte doucement en haut
  btn.onclick = function() {
    window.scrollTo({ top: 0, behavior: "smooth" });
  };