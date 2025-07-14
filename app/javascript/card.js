let payjpInstance = null;

const pay = () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  // 初期化済みなら再利用
  if (!payjpInstance) {
    payjpInstance = Payjp("pk_test_7fb398a9bb75c79e8c6bab89");
  }

  const elements = payjpInstance.elements();

  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  if (!document.getElementById('card-number')) return;
  if (!document.getElementById('card-exp-month')) return;
  if (!document.getElementById('card-cvc')) return;

  numberElement.mount('#card-number');
  expiryElement.mount('#card-exp-month');
  cvcElement.mount('#card-cvc');

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    payjpInstance.createToken(numberElement).then((response) => {
      if (response.error) {
        const dummyToken = `<input value="" name="token" type="hidden">`;
        form.insertAdjacentHTML("beforeend", dummyToken);
        form.submit();
        return;
      }

      const token = response.id;
      const tokenInput = `<input value="${token}" name="token" type="hidden">`;
      form.insertAdjacentHTML("beforeend", tokenInput);
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      form.submit();
    });
  });
};

document.addEventListener("turbo:load", pay);
