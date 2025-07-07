window.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");

  if (!priceInput) return;

  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    // 半角数字以外は弾く（optional: バリデーション強化したい場合）
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
});
