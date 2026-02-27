# Food ordering, Coupon exchanging App with Food demand forecasting

This is an app created to be used inside a college campus, to ease the process of buying and selling mess coupons, as well as the process of ordering food at different outlets within the campus. Using this app, vendors can streamline their workflow and help students reduce their time wastage. They don't have to wait in line or wait at the outlet for food to get ready, and instead, only visit the outlet once their order is ready to go


## How to start

### For Flutter app
Uses Firebase as DB
GOOGLE API KEY - add google-service.json to android/app 
flutter pub get
flutter run

### For food demand forecasting
In prediction_model directory
1. pip install -r requirements.txt
2. Run data_setup.ipynb to create total_data.csv
3. Run demand_forecasting.ipynb


## Login/Signup flow

User have to login with created account and password
New users can tap sign up to proceed through the account creation flow and enter details like Name, Valid phone number and Graduation year
For outlets, account creation can only be done in the backend, by reaching out

<img width="1920" height="1080" alt="login_flow" src="https://github.com/user-attachments/assets/d72f986d-e0e4-4fb8-92ca-d2e5a68634b4" />

On successful login/signup, the following home page is shown
<img width="1920" height="1080" alt="first_time" src="https://github.com/user-attachments/assets/910504ce-e20b-4a57-99f1-496982723aa0" />

## Coupon Exchange Flow
In coupons tab, user can view available coupons and tap chat icon on coupon they choose to buy to message with seller on whatsapp
Search and filter coupons by tapping on filter icon
Add coupons specifying mess vendor, price and valid day
View, edit and delete user's own listed coupons
<img width="3840" height="2160" alt="coupon_flow" src="https://github.com/user-attachments/assets/2f957df6-637e-4b12-ab6a-f97c031b31f3" />


## Food Menu
<img width="3840" height="2160" alt="menu_flow" src="https://github.com/user-attachments/assets/7d52ab41-c0c1-4047-b4b0-94926091ff31" />

Customers can select vendor, search for desired items and add to cart (cart icon appears on top right once items are added, which can be used to access the cart)


## Food ordering Flow
<img width="3840" height="2160" alt="order_flow1" src="https://github.com/user-attachments/assets/a7c4dc9b-a7b7-47f5-8780-ea5b9f073d77" />
<img width="3840" height="2160" alt="order_flow2" src="https://github.com/user-attachments/assets/af99cce7-1c58-4933-afd4-a9d232c466e2" />

1. After placing items in cart, customer can adjust quantity and select whether item should be packed. Total price is displayed at the bottom. Once ready tap Order to place order
2. The vendor's UPI QR appears. Scan and pay the amount. Once done, tap Payment Completed
3. Wait for outlet's confirmation that payment is received
4. Vendor can tap verify payment once payment is received on their screen. If order is cancelled despite receiving payment, customer can raise complaint.
5. Customer waits for order to get ready, status is under orders tab
6. Vendor taps Order Ready once order is ready, notifying the customer
7. Order is marked green until Customer receives order
8. Upon receiving order, customer taps Received Order button, adding the order to both the Vendor's and Customer's Order history, removing it form the active orders tab


#### In order to prevent false cancellation after payment, or failure in confirming order is received, an intermediate bank account/upi can be created that will hold the payment related to an order until order is received. This will prevent false cancellation as vendor will not receive the payment, and if order received is not pressed by customer, it can be resolved by contacting the devs


## Profile and demand forecast

Profile can be viewed by tapping the drawer and then tapping profile
The vendor can see their predicted demand by tapping on the sales button (Sales upto now will also be added in the future)

<img width="2160" height="3840" alt="profile_sale" src="https://github.com/user-attachments/assets/9614f74c-8fde-40f8-8189-84250572bcec" />



## Food Demand Forecasting Models

For predicting food demand based past sales data, I compared multiple models that are suited for Time Series Regression. A sample dataset with 456548 total rows was used to train the models and compare.
The dataset consolidates the sales on a week-by-week basis(not daily)

### Cleaning data
There was no null data, and only a few outliers had to be removed

### Feature Engineering
-- The number of orders, base price and checkout price were normalized using log(1+x)  
-- New columns such as discount, discount ratio were added, as these could affect demand on a day  
-- Column price_last_curr_diff was added, which is the difference in price from last day  
-- Lag features on number of orders from 10th, 11th and 12th previous week were added  
-- Exponentially weighted mean features with shifts from 10-15 weeks were added  
-- Encoding of categorical variables was only done for models other than CatBoost, as it takes care of these and null values on its own  


### Model Comparison

Models used - CatBoost, LightGBM, GradientBoost, RandomForest, DecisionTree

Metric used for comparison - RMSLE/MSLE (Mean Squared Logarithmic Error)

<img width="434" height="83" alt="msle" src="https://github.com/user-attachments/assets/69cbd2a6-249e-4df7-9df3-b2c1769630de" />


### Results
RandomForest gave best value of MSLE, with the minimum value among the lot of 0.09337, closely followed by LGBoost and Catboost.
This is despite models like Catboost being more resource intensive and taking more time for training.
Gradient boost and Decision Tree performed the worst

<img width="989" height="590" alt="output" src="https://github.com/user-attachments/assets/a1b9a341-af5b-4304-a683-24932e5f930a" />
















