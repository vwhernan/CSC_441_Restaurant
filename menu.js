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
        displayMenu(menuArray);

        return menuArray;

    } catch (error) {
        console.error('Error loading menu:', error);

        const menuContainer = document.querySelector('.food-menu');

        if (menuContainer) {
            menuContainer.textContent = 
                'Unable to load the menu. Please try again later';
        }
    }
}

// display the menu items on the page
function displayMenu(items) {

    // get the menu categories
    const categories = [...new Set(items.map(dish => dish.category))];
    const drinkCategories = [
        'HIGHBALLS & COCKTAILS',
        'BEERS, SAKE & NO-ALC'
    ];
    const orderedCategories = [
        ...categories.filter(category => !drinkCategories.includes(category)),
        ...drinkCategories.filter(category => categories.includes(category))
    ];
    
    const menuContainer = document.querySelector('.food-menu');

    if (!menuContainer) {
        console.error('Menu container not found');
        return;
    }

    menuContainer.innerHTML = ''; 

    // create a section for each category
    orderedCategories.forEach(category => {
        const categorySection = document.createElement('section');

        categorySection.className = 'menu-category';

        const categoryHeading = document.createElement('h2');

        categoryHeading.className = 'menu-category-heading';
        categoryHeading.textContent = category;
        categorySection.appendChild(categoryHeading);

        const categoryDishes = items.filter(dish => dish.category === category);

        // display each dish
        categoryDishes.forEach(dish => {
            const dishElement = document.createElement('article');

            dishElement.className = 'menu-dish';

            const dishHeader = document.createElement('div');

            dishHeader.className = 'menu-dish-header';

            const dishName = document.createElement('h3');

            dishName.className = 'menu-dish-name';
            dishName.textContent = dish.dish_name;
            dishHeader.appendChild(dishName);

            const price = Number(dish.price);
            const fractionDigits = Number.isInteger(price) ? 0 : 2;
            const dishPrice = document.createElement('span');

            dishPrice.className = 'menu-dish-price';
            dishPrice.textContent = new Intl.NumberFormat('en-US', {
                style: 'currency',
                currency: 'USD',
                minimumFractionDigits: fractionDigits,
                maximumFractionDigits: 2
            }).format(price);
            dishHeader.appendChild(dishPrice);
            dishElement.appendChild(dishHeader);

            if (dish.description) {
                const descriptionElement = document.createElement('p');

                descriptionElement.className = 'menu-dish-description';
                descriptionElement.textContent = dish.description;
                dishElement.appendChild(descriptionElement);
            }

            if (dish.dietary_tags) {
                const dietaryElement = document.createElement('span');

                dietaryElement.className = 'menu-dish-tags';
                dietaryElement.textContent = dish.dietary_tags;
                dishElement.appendChild(dietaryElement);
            }

            categorySection.appendChild(dishElement);
        });

        menuContainer.appendChild(categorySection);
    });

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
document.addEventListener('DOMContentLoaded', fetchMenu);