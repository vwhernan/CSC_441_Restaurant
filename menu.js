// menu.js

async function fetchMenu() {
    try {
        const response = await fetch('http://localhost:3000/api/menu');
        
        if (!response.ok) {
            throw new Error('Failed to fetch menu from server');
        }

        const menuArray = await response.json();
        console.log('Menu items successfully loaded into an array:', menuArray);
        
        displayMenuConsole(menuArray);

        return menuArray;

    } catch (error) {
        console.error('Error loading menu:', error);
    }
}

function displayMenuConsole(items) {
    console.log('--- Printing All Menu Items ---');
    
    items.forEach((dish, index) => {
        console.log(`[${index + 1}] ${dish.dish_name} (${dish.category}) - $${dish.price}`);
        console.log(`    Description: ${dish.description}`);
        console.log(`    Ingredients: ${dish.ingredients.join(', ')}`);
    });
    
    console.log('-------------------------------');
}

// Run the fetch when the page loads
fetchMenu();