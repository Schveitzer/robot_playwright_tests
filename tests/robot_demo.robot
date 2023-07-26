*** Settings ***
Documentation       Example to Youtube Teasy Class
...                 Another line

Resource            ./resources/comomm.resource

*** Variables ***

${_button_add_to_cart_backpack}=    id=add-to-cart-sauce-labs-backpack
${button_shop_cart}=                css=.shopping_cart_link
${cart_container}=                  css=.cart_contents_container

*** Test Cases ***
Add a product to cart
    Open Home Page Loged With Regular User
    Add Product To Cart

*** Keywords ***
Add Product To Cart
    Click          ${_button_add_to_cart_backpack}
    Click          ${button_shop_cart}
    Get Text       ${cart_container}    contains    Sauce Labs Backpack
