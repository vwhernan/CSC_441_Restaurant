// reviews.js communicates with Node.js backend through the API.

async function loadReviews() {
    const container = document.getElementById("reviews-container");

    try {
        const response = await fetch("/api/reviews");

        if (!response.ok) {
            throw new Error(`Failed to retrieve reviews: ${response.status}`);
        }

        const reviews = await response.json();

        container.replaceChildren();

        reviews.forEach(review => {
            const reviewElement = document.createElement("div");

            const name = document.createElement("h3");
            name.textContent = review.customer_name;

            const rating = document.createElement("p");
            rating.textContent = `Rating: ${review.rating}/5`;

            const comment = document.createElement("p");
            comment.textContent = review.comment;

            reviewElement.append(name, rating, comment);
            container.appendChild(reviewElement);
        });
    } catch (error) {
        console.error(error);
        container.textContent = "Unable to load customer reviews.";
    }
}

document.addEventListener("DOMContentLoaded", loadReviews);

document.getElementById("review-form").addEventListener("submit", submitReview);

async function submitReview(event) {
    event.preventDefault();

    const customer_name = document.getElementById("customer-name").value;
    const rating = Number(document.getElementById("review-rating").value);
    const comment = document.getElementById("review-comment").value;

    const message = document.getElementById("review-message");

    try {
        // Send the customer review to the Node.js backend
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

        document.getElementById("review-form").reset();

        await loadReviews();

    } catch (error) {
        console.error("Error submitting review:", error);
        message.textContent = "Unable to submit review. Please try again.";
    }
}
