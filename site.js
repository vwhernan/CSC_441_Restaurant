const components = [
    { file: 'MyNav.html', id: 'nav-placeholder' },
    { file: 'Hero.html', id: 'hero-placeholder' },
    { file: 'About.html', id: 'about-placeholder' },
    { file: 'Menu.html', id: 'menu-placeholder' },
    { file: 'Locations.html', id: 'locations-placeholder' },
    { file: 'Footer.html', id: 'footer-placeholder' }
];



// Loop through the array and fetch each file
components.forEach(component => {
    fetch(component.file)
        .then(response => {
            if (!response.ok) throw new Error(`Could not load ${component.file}`);
            return response.text();
        })
        .then(data => {
            const element = document.getElementById(component.id);
            if (element) {
                element.innerHTML = data;
            }
        })
        .catch(error => console.error('Error:', error));
});