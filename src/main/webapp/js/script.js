fetch('headernav.html')
.then(response => response.text())
.then(data => {
	document.getElementById('header-container').innerHTML = data;
});

fetch('footer.html')
.then(response => response.text())
.then(data => {
	document.getElementById('footer-container').innerHTML = data;
});

function updateDateTime() {
	fetch('DateTimeServlet') // Call the servlet
	.then(response => response.text()) // Get response text
	.then(data => {
		document.getElementById('dateTime').innerHTML = data; // Update UI
	})
	.catch(error => console.error('Error fetching date/time:', error));
}
// Update every second for real-time effect
setInterval(updateDateTime, 1000);
// Call once immediately to prevent delay
updateDateTime();
	
		
document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("registerForm").addEventListener("submit", function (event) {
        let password = document.getElementById("password").value;
        let confirmPassword = document.getElementById("confirmPassword").value;
        let errorMessage = document.getElementById("passwordError");

        if (password !== confirmPassword) {
            errorMessage.innerHTML = "<br><br>Passwords do not match!";
            errorMessage.style.color = "red";
            event.preventDefault(); // Prevent form submission
           
        } else {
            errorMessage.textContent = "";
         
        }
    });
});



document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("loginForm").addEventListener("submit", function (event) {
        event.preventDefault(); // Prevent page refresh

        let email = document.getElementById("email").value;
        let password = document.getElementById("password").value;
        let errorMessage = document.getElementById("error-message");

        fetch("LoginServlet", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: new URLSearchParams({ email: email, password: password }),
        })
        .then(response => response.text()) // Read response as text
        .then(data => {
            if (data.trim() === "success") {
                window.location.href = "dashboard.jsp"; // Redirect on success
            } else {
                errorMessage.innerHTML = "<br><br>" + data; // Show error message
            }
        })
        .catch(error => {
            errorMessage.innerHTML = "<br>Error: " + error.message;
        });
    });
});


document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("adminLogin").addEventListener("submit", function (event) {
        event.preventDefault(); // Prevent page refresh

        let email = document.getElementById("email").value;
        let password = document.getElementById("password").value;
        let errorMessage = document.getElementById("error-message");

        fetch("AdminLoginServlet", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: new URLSearchParams({ email: email, password: password }),
        })
        .then(response => response.text()) // Read response as text
        .then(data => {
            if (data.trim() === "success") {
                window.location.href = "adminDashboard.jsp"; // Redirect on success
            } else {
                errorMessage.innerHTML = "<br><br>" + data; // Show error message
            }
        })
        .catch(error => {
            errorMessage.innerHTML = "<br>Error: " + error.message;
        });
    });
});


