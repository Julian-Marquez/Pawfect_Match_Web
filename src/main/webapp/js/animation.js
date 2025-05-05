function addToCart(button) {
    const cartIcon = document.getElementById("cart-icon");
    const productCard = button.closest(".card");
    const productImage = productCard.querySelector(".product-img");

    // Clone the image and position it
    const flyingImage = productImage.cloneNode(true);
    const rect = productImage.getBoundingClientRect();

    flyingImage.style.position = "absolute";
    flyingImage.style.top = rect.top + "px";
    flyingImage.style.left = rect.left + "px";
    flyingImage.style.width = productImage.offsetWidth + "px";
    flyingImage.style.height = productImage.offsetHeight + "px";
    flyingImage.style.transition = "transform 1s ease-in-out, opacity 1s ease-in-out";
    flyingImage.style.opacity = "1";
    document.body.appendChild(flyingImage);

    // Calculate the target position (cart icon)
    const cartRect = cartIcon.getBoundingClientRect();
    const targetX = cartRect.left - rect.left;
    const targetY = cartRect.top - rect.top;

    // Animate the image
    setTimeout(() => {
        flyingImage.style.transform = `translate(${targetX}px, ${targetY}px) scale(0.2)`;
        flyingImage.style.opacity = "0";
    }, 100);

    // Remove the image after animation
    flyingImage.addEventListener("transitionend", () => {
        flyingImage.remove();
    });

    // Optional: Add a visual/cart logic update (e.g., increment cart count)
}
