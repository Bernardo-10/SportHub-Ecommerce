// Configuration du site SportHub
const SITE_CONFIG = {
    // Numéro WhatsApp du site (format international sans le +)
    // Exemple pour le Cameroun: 237XXXXXXXXX (237 = code pays + 9 chiffres)
    // Pour modifier, remplacez par votre numéro WhatsApp professionnel
    whatsappNumber: '237656811646',
    
    // Nom du site
    siteName: 'SportHub',
    
    // Email de contact
    contactEmail: 'SportHub@gmail.com',
    
    // URL de base de l'API
    apiBase: 'php'
};

// Export de la configuration
if (typeof module !== 'undefined' && module.exports) {
    module.exports = SITE_CONFIG;
}
