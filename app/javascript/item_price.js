document.addEventListener("turbo:load", () => {
  setupPriceListener();
});

document.addEventListener("DOMContentLoaded", () => {
  setupPriceListener();
});

function setupPriceListener() {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    if (inputValue.match(/^\d+$/)) {
      const tax = Math.floor(inputValue * 0.1);
      const profit = Math.floor(inputValue - tax);
      addTaxDom.innerHTML = tax;
      profitDom.innerHTML = profit;
    } else {
      addTaxDom.innerHTML = "";
      profitDom.innerHTML = "";
    }
  });
  
  if (priceInput.value.match(/^\d+$/)) {
    const inputValue = priceInput.value;
    const tax = Math.floor(inputValue * 0.1);
    const profit = Math.floor(inputValue - tax);
    addTaxDom.innerHTML = tax;
    profitDom.innerHTML = profit;
  }
}
