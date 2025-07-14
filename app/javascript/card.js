let payjpLoaded = false;

const pay = () => {
  if (payjpLoaded) return; // ← すでに実行済なら何もしない
  payjpLoaded = true;

  // PAY.JPの公開鍵を設定（直接書く or 環境変数経由）
  const payjp = Payjp("pk_test_7fb398a9bb75c79e8c6bab89"); // テスト用公開鍵に書き換える
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  // 要素をDOMに差し込む
  numberElement.mount('#card-number');
  expiryElement.mount('#card-exp-month');
  cvcElement.mount('#card-cvc');

  // フォーム送信時の処理
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        alert(response.error.message);
      } else {
        const token = response.id;
        const tokenInput = `<input value="${token}" name="token" type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenInput);
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        form.submit();
      }
    });
  });
};

document.addEventListener("DOMContentLoaded", pay);
document.addEventListener("turbo:load", pay); // ←両方対応
