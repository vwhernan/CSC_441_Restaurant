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
    
    const menuContainer = document.querySelector('.food-menu');

    if (!menuContainer) {
        console.error('Menu container not found');
        return;
    }

    menuContainer.innerHTML = ''; 

    // create a section for each category
    categories.forEach(category => {
        const categoryHeading = document.createElement('h2');

        categoryHeading.textContent = category;
        menuContainer.appendChild(categoryHeading);

        const categoryDishes = items.filter(dish => dish.category === category);

        // display each dish
        categoryDishes.forEach(dish => {
            const dishElement = document.createElement('div');
            dishElement.classList.add('menu-dish');

            dishElement.textContent = `${dish.dish_name} - $${Number(dish.price).toFixed(2)}`;

            // add dietary tags where applicable
            if (dish.dietary_tags) {
                const dietaryElement = document.createElement('span');

                dietaryElement.className = 'dietary-tags';
                dietaryElement.textContent = ` (${dish.dietary_tags})`;

                dishElement.appendChild(dietaryElement);
            }
            
            // add description where applicable
            if (dish.description) {
                const descriptionElement = document.createElement('p');

                descriptionElement.textContent = dish.description;

                dishElement.appendChild(descriptionElement);
            }

            menuContainer.appendChild(dishElement);
        
        })
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