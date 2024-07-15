const kakaoPostcode = () => {
  new daum.Postcode({
    oncomplete: (data) => {
      let addr = "";

      if (data.userSelectedType === "R") {
        addr = data.roadAddress;
      } else {
        addr = data.jibunAddress;
      }

      document.getElementById("address").value = addr;
    },
  }).open();
};

$(document).ready(() => {
  let hasFocused = false;

  $("#address").on("focus", () => {
    if (!hasFocused) {
      kakaoPostcode();
      hasFocused = true;
    } else {
      hasFocused = false;
    }
  });
});
