
A modern, user-friendly shopping cart application built with **Flutter**. It allows users to browse products, view detailed product information, add items to a cart, and proceed to checkout with a seamless experience. The app fetches product data from the [DummyJSON API](https://dummyjson.com/products) and implements features like pagination, search, sorting, and a discount carousel to enhance the shopping experience.

## Features

- **Product Catalog**: Browse a paginated list of products with infinite scrolling.
- **Discount Carousel**: View the top 5 discounted products in a carousel at the top of the catalog screen.
- **Search and Sort**: Search products by title or brand, and sort by price (High to Low or Low to High).
- **Product Details**: View detailed product information, including price, discount, description, and additional details like warranty and shipping.
- **Cart Management**: Add products to the cart, update quantities, and view the total price with a modern UI.
- **Checkout**: Confirm and clear the cart with a styled checkout dialog and a custom checkout button.
- **User Experience Enhancements**:
  - Pull-to-refresh to reload products.
  - Snackbar notifications when adding items to the cart.
  - Fade transition animations for a polished UI.
  - Error handling with retry options for failed API calls.

## Screenshots

### Catalog Screen
The main screen displays a list of products with a discount carousel, search bar, and sort options.

![Catalog Screen](https://raw.githubusercontent.com/atalantadey/havahavai/tree/main/assignment_screenshots/homescreen.png)

### Product Description Screen
View detailed information about a product, including its image, price, discount, description, and additional details.

![Product Description Screen](https://raw.githubusercontent.com/atalantadey/havahavai/tree/main/assignment_screenshots/productscreen.png)

### Cart Screen
Manage your cart by viewing added items, adjusting quantities, and proceeding to checkout with a modern, gradient-styled button.

![Cart Screen](https://raw.githubusercontent.com/atalantadey/havahavai/tree/main/assignment_screenshots/cartscreen.png)

## Dependencies

HavaHavai uses the following dependencies to provide a robust and feature-rich experience:

- **flutter_riverpod**: ^2.5.1 - For state management and dependency injection.
- **http**: ^1.2.2 - For making API requests to fetch product data.
- **dartz**: ^0.10.1 - For functional programming constructs like `Either` to handle errors.
- **carousel_slider**: ^4.2.1 - For the discount carousel on the catalog screen.
- **google_fonts**: ^6.2.1 - For custom typography using the Poppins font.

### Dev Dependencies
- **flutter_test**: SDK - For unit and widget testing.
- **test**: ^1.24.9 - For writing unit tests.
- **mockito**: ^5.4.4 - For mocking dependencies in tests.
- **build_runner**: ^2.4.6 - For generating mock classes with Mockito.

You can find the full list of dependencies in the `pubspec.yaml` file.

## Setup Instructions

Follow these steps to set up and run the HavaHavai app on your local machine.

## Functionalities

**Catalog Screen**
- Displays a paginated list of products fetched from the DummyJSON API.
- Features a carousel of the top 5 discounted products.
- Allows searching by title or brand and sorting by price.
- Implements infinite scrolling for pagination.
- Includes pull-to-refresh to reload products.

**Product Decription Screen**
- Shows detailed product information, including:
- Product image with a gradient background.
- Title, price, discounted price, and discount percentage.
- Description and additional information (warranty, shipping, availability, return policy).
- Includes an "Add to Cart" button with a snackbar confirmation.

**Cart Screen**

- Displays items added to the cart with a modern card-based UI, including:
- Product image, title, price, and quantity.
- Quantity controls with increment/decrement buttons.
- Features a visually appealing total price section with a gradient background.
- Includes a custom checkout button with a gradient, shadow, and tap animation.
- Shows an engaging empty cart state with an icon and message.
- Allows checkout with a confirmation dialog and snackbar feedback.

**State Management**
- Uses Riverpod for state management.
- Providers like productListProvider, topDiscountedProductsProvider, and cartProvider manage the app’s state reactively.

**API Integration**
- Fetches product data from https://dummyjson.com/products using the http package.
- Implements pagination with skip and limit parameters to load products in batches.

**Testing**

*Unit Tests*:
- Tests for use cases (FetchProducts, ManageCart).
- Tests for repositories (ProductRepositoryImpl).
- Tests for providers (cartProvider, totalPriceProvider).