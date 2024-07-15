<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="../css/createModal.css" rel="stylesheet">

    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        function submitForm2(event) {
            event.preventDefault();
            const form = document.getElementById("single-input-form2");
            const formData = new FormData(form);
            const jsonObject = {};

            formData.forEach((value, key) => {
                jsonObject[key] = value;
            });

            fetch('/api/card', {
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
                    resetFormAndCloseModal('single-input-form2');
                    window.location.reload();
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }

        function resetFormAndCloseModal(formId) {
            const form = document.getElementById(formId);
            form.reset();
            var modal = document.getElementById("myModal");
            modal.style.display = "none";
        }

        document.addEventListener('DOMContentLoaded', (event) => {
            var modal = document.getElementById("myModal");
            var btn = document.getElementById("openModalButton");
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
    <button id="openModalButton" class="open-modal-button">+</button>
</div>

<!-- The Modal -->
<div id="myModal" class="modal">

    <!-- Modal content -->
    <div class="modal-content">
        <span class="close">&times;</span>
        <form id="single-input-form2" onsubmit="submitForm2(event)">
            <label for="card-type">타입:</label>
            <select id="card-type" name="type" required>
                <option value="CREDIT">신용</option>
                <option value="CHECK">체크</option>
            </select><br><br>

            <label for="card-name">카드명:</label>
            <input type="text" id="card-name" name="name" required><br><br>

            <label for="card-alias">별칭:</label>
            <input type="text" id="card-alias" name="cname" required><br><br>

            <label for="card-date">기준일:</label>
            <input type="number" id="card-date" name="bday" required><br><br>

            <label for="card-total-amount">누적금액:</label>
            <input type="number" id="card-total-amount" name="amount" required><br><br>

            <input type="submit" value="생성하기">
        </form>
    </div>
</div>

</body>
</html>
