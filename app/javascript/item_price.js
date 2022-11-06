function item_price() {

  const priceInput = document.getElementById('item-price');
  const inputValue = priceInput.value;
  const addTaxDom = document.getElementById('add-tax-price');
  const addPofitDom = document.getElementById('profit');

  priceInput.addEventListener("input", () => {
    addTaxDom.innerHTML = Math.floor(priceInput.value * 0.1 );
    addPofitDom.innerHTML = Math.floor(priceInput.value - Math.floor(priceInput.value * 0.1 ));
  })
};

window.addEventListener('load', item_price)