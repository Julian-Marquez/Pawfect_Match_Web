<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link href="css/CheckOut.css" rel="stylesheet">
<head>
<meta charset="UTF-8">
<title>Add Payment</title>
</head>
<body>

    <div class="mainscreen">
    <!-- <img src="https://image.freepik.com/free-vector/purple-background-with-neon-frame_52683-34124.jpg"  class="bgimg " alt="">--> 
      <div class="card">
        <div class="leftside">
          <img
            src="images/checkOut.png"
            class="product"
            alt="Shoes"
          />
        </div>
        <div class="rightside">
          <form action="CheckOut" method="get">
            <h1>CheckOut</h1>
            <h2>Payment Information</h2>
            <p>Cardholder Name</p>
            <input type="text" class="inputbox" name="holderName" required />
            <p>Card Number</p>
            <input type="text" class="inputbox" name="cardNumber" id="card_number" required maxlength="16" />

            <p>Card Type</p>
            <select class="inputbox" name="cardType" id="card_type" required>
              <option value="empty" >--Select a Card Type--</option>
              <option value="Visa">Visa</option>
              <option value="RuPay">RuPay</option>
              <option value="MasterCard">MasterCard</option>
            </select>
<div class="expcvv">

            <p class="expcvv_text">Expiry</p>
            <input name="expiry" type="date" class="inputbox" id="exp_date" required />

            <p class="expcvv_text2">CVV</p>
            <input name="cvv" type="password" class="inputbox" id="cvv" required />
        </div>
            <p></p>
            <button type="submit" class="button">CheckOut</button>
          </form>
        </div>
      </div>
    </div>
  


</body>
</html>