// reviews.js communicates with Node.js backend through the API.

// Helper function to turn numeric ratings (1-5) into star strings (e.g., ★★★★☆)
function renderStars(rating) {
    const maxStars = 5;
    const filledStars = '★'.repeat(Math.min(Math.max(rating, 0), maxStars));
    const emptyStars = '☆'.repeat(maxStars - filledStars.length);
    return `${filledStars}${emptyStars}`;
}

async function loadReviews() {
    const container = document.getElementById("reviews-container");

    try {
        const response = await fetch("/api/reviews");

        if (!response.ok) {
            throw new Error(`Failed to retrieve reviews: ${response.status}`);
        }

        const reviews = await response.json();

        container.replaceChildren();

        // If no reviews exist in the database, display a friendly message instead of failed to load reviews.
        if (reviews.length === 0) {
            const noReviewsMessage = document.createElement("p");
            noReviewsMessage.className = "no-reviews-message";
            noReviewsMessage.textContent = "No reviews yet. Be the first to leave one!";
            container.appendChild(noReviewsMessage);
            return;
        }

        reviews.forEach(review => {
            // Main card container element
            const reviewElement = document.createElement("div");
            reviewElement.className = "review-card";

            // Optional Pin/Tape header element for visual flare
            const pin = document.createElement("div");
            pin.className = "postit-pin";
            pin.textContent = "📌";
            pin.style.textAlign = "center";
            pin.style.marginTop = "-10px";
            pin.style.marginBottom = "5px";

            // Header layout for name + star rating
            const headerElement = document.createElement("div");
            headerElement.className = "review-card-header";

            const name = document.createElement("h3");
            name.className = "review-name";
            name.textContent = review.customer_name;

            const rating = document.createElement("div");
            rating.className = "review-rating";
            
            const starsSpan = document.createElement("span");
            starsSpan.className = "rating-stars";
            starsSpan.textContent = renderStars(review.rating);
            
            const scoreSpan = document.createElement("span");
            scoreSpan.className = "rating-score";
            scoreSpan.textContent = ` (${review.rating}/5)`;

            rating.append(starsSpan, scoreSpan);
            headerElement.append(name, rating);

            // Review text comment
            const comment = document.createElement("p");
            comment.className = "review-comment";
            comment.textContent = review.comment;

            reviewElement.append(pin, headerElement, comment);
            container.appendChild(reviewElement);
        });
    } catch (error) {
        console.error(error);
        container.textContent = "Unable to load customer reviews.";
    }
}

document.addEventListener("DOMContentLoaded", () => {
    // Each page only has some of these elements (list on home, form on Contact Us)
    if (document.getElementById("reviews-container")) {
        loadReviews();
    }
    const reviewForm = document.getElementById("review-submit-form");
    if (reviewForm) {
        reviewForm.addEventListener("submit", submitReview);
    }
});

async function submitReview(event) {
    event.preventDefault();

    const customer_name = document.getElementById("customer-name").value.trim();
    const rating = Number(document.getElementById("review-rating").value);
    const comment = document.getElementById("review-comment").value.trim();

    const message = document.getElementById("review-message");

    // Regular Expression patterns for validation
    const nameRegex = /^[a-zA-Z\s]+$/;
    const commentRegex = /^[a-zA-Z\s.,]+$/;

    // Validate Customer Name (only text/letters and spaces allowed)
    if (!nameRegex.test(customer_name)) {
        message.textContent = "Validation error: Name can only contain letters and spaces.";
        return;
    }

    // Validate Comment (only text/letters, spaces, commas, and periods allowed)
    if (!commentRegex.test(comment)) {
        message.textContent = "Validation error: Review comment can only contain letters, spaces, commas, and periods.";
        return;
    }

    try {
        const response = await fetch("/api/reviews", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                customer_name,
                rating,
                comment
            })
        });

        if (!response.ok) {
            throw new Error("Unable to submit review");
        }

        message.textContent = "Review submitted successfully!";

        document.getElementById("review-submit-form").reset();

        if (document.getElementById("reviews-container")) {
            await loadReviews();
        }

    } catch (error) {
        console.error("Error submitting review:", error);
        message.textContent = "Unable to submit review. Please try again.";
    }
}