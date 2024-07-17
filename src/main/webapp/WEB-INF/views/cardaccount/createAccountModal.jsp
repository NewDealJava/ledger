<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="../css/createModal.css" rel="stylesheet">

    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        function submitForm(event) {
            event.preventDefault();
            const form = document.getElementById("single-input-form");
            const formData = new FormData(form);
            const jsonObject = {};

            formData.forEach((value, key) => {
                jsonObject[key] = value;
            });

            fetch('/api/account', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams(jsonObject).toString()
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    resetFormAndCloseModal('single-input-form');
                    window.location.reload();
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }

        function resetFormAndCloseModal(formId) {
            const form = document.getElementById(formId);
            form.reset();
            var modal = document.getElementById("myModal2");
            modal.style.display = "none";
        }

        document.addEventListener('DOMContentLoaded', (event) => {
            var modal = document.getElementById("myModal2");
            var btn = document.getElementById("openModalButton2");
            var span = document.getElementsByClassName("close")[0];

            btn.onclick = function () {
                modal.style.display = "block";
            }

            span.onclick = function () {
                modal.style.display = "none";
            }

            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        });
    </script>
</head>
<body>

<div class="container">
    <!-- Trigger/Open The Modal -->
    <button id="openModalButton2" class="open-modal-button">+</button>
</div>

<!-- The Modal -->
<div id="myModal2" class="modal">

    <!-- Modal content -->
    <div class="modal-content">
        <span class="close">&times;</span>
        <form id="single-input-form" onsubmit="submitForm(event)">
            <label for="account-type">타입:</label>
            <select id="account-type" name="type" required>
                <option value="MONEY">MONEY</option>
                <option value="ACCOUNT">ACCOUNT</option>
            </select><br><br>

            <label for="account-name">계좌명:</label>
            <input type="text" id="account-name" name="name" required><br><br>

            <label for="account-cname">별칭:</label>
            <input type="text" id="account-cname" name="nickname" required><br><br>

            <label for="account-amount">잔돈:</label>
            <input type="number" id="account-amount" name="amount" required><br><br>

            <label for="account-memo">메모:</label>
            <textarea id="account-memo" name="memo"></textarea><br><br>

            <label for="account-imgUrl">이미지 URL:</label>
            <input type="text" id="account-imgUrl" name="imgUrl"><br><br>

            <input type="submit" value="생성하기">
        </form>
    </div>
</div>

</body>
</html>
