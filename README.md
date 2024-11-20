# SHOE-SHOP-ECOMMERCE-WEB-APP
A MERN stack ecommerce website with fully functional front and back end with Mongo DB for database.

## ATTENTION DEAR USERS
Please don't skip any part of the documentation you are going to read. It was documented elaborately, so that you could work on this project without troubles. Thank you for your patience :)

## SYNOPSIS

An E-Commerce website for Shoe Shop which uses ```MERN``` (Mongo, Express JS, React JS and Node JS) stack.

## DESCRIPTION
v~ 1.2\
Some features are:-

- Dual role of ```User``` and ```Admin``` (For admin, in the DB change role to 1 and 0 for user.)
- Admin can add product, with its quantity and price and can upload product photo too and all is updated in the DB at the same time automatically.
- Admin can create categories of items in the shop.
- Users have ```sign up``` and ```sign in``` process with proper password authentication. (Details of new users are automatically updated in the DB).
- Cart option is available for users to save product and its quantity.
- Users can see recommendations of new arrivals, best sellers, etc..... Users can also search product in the search bar or filter by categories.
- User can also access the payment interface by entering the card details. ```(Use fake card number generator available online)```
- Load More option is also available to resemble the real-time website.
- The constraints like OUT OF STOCK, etc.... are also taken care in this website and appropriate messages are displayed.
- Forgot password feature is also added

## INSTRUCTIONS
- Install the latest version of ```node.js``` and ```npm```
- Download the project, or enter the following in terminal ```if you have git installed``` :-
```bash 
git clone https://github.com/smsraj2001/SHOE-SHOP-ECOMMERCE-WEB-APP.git
```
- Select the ```root``` folder.
- Open a terminal and then run the following terminal :-
```bash 
npm i
```
- Also open a terminal inside ```client``` folder and again enter the same command :-
```bash 
npm i
```
- Now, again in the ```root``` folder create a file with name : ```.env``` (No name, just extension) and add the following contents:-
```.env
MONGODB_URI="Your MongoDB URI"
JWT_SECRET=dummySecret
BRAINTREE_MERCHANT_ID=2674wh7xx3hjtv4c
BRAINTREE_PUBLIC_KEY=3q5ngrh78jhpbkc3
BRAINTREE_PRIVATE_KEY=bd43a1cc61e8218ebe3f76dd04eb6599
```

- Also, in the ```client``` folder create a file with name : ```.env``` (No name, just extension) and add the following contents:-
```.env
REACT_APP_API_URL=http://localhost:5000/api
```

#### Steps to connect MONGODB with URI :-
- Go to link : https://www.mongodb.com/cloud/atlas/register
- Create the account if not and then sign in. After signing in, create a new cluster, then you will see ```Connect``` option.
- Then select ```Connect using MongoDB compass```. (If you have not installed MongoDB compass please install it. This provides Mongo DB in GUI interface.)
- Then Copy, connection string as seen and paste it in the ```New Connection``` menu in the MongoDB compass.
- Connection string looks like this : ```mongodb+srv://<User_name>:<Password>@sms.eawks.mongodb.net/test```
- Now in MongoDB compass, under Databases click ```create Database``` option and give it a name.
- Under the created folder create the collection names of ```users```, ```products```, ```orders```, ```categories``` and ```books```
- Lets see the definition of ```user``` collection :-
```.javascript
_id : 63160aeedc20e3e7d9ffb6fe
role : 1
history : Array
name : "Smsraj"
email : "abc@2001"
salt : "b40af360-59d7-11ec-85da-eb0a33e7bf02"
hashed_password : "a2c24fa5fbfa240047494be961c732feafd21b8e"
createdAt : 2021-12-10T16:39:11.516+00:00
updatedAt : 2021-12-10T16:39:11.516+00:00
__v : 0
```
- NOTE : For admin, role = 1(when using for first time click on Forgot password and change the password) and for user, role = 0. 
- The other collections gets updated automatically whenever the admins adds the products in the website.

- Finally to connect MongoDB to the Web app, all you need to do is, in the .env file, type the following for MONGODB_URI :-\
```MONGODB_URI = "mongodb+srv://<username>:<password>@<clustername>.eawks.mongodb.net/<db-Name>?retryWrites=true&w=majority"```
- After this your project is completely ready.
- NOTE : If the BRAINTREE key doesn't work, generate new key in the BRAINTREE official website and copy the values in the .env file.

- Finally run the following command in the root folder to start and run the E-Commerce Web app :-
```bash 
npm run dev
```
## IMPORTANT
- If for an reason , the web app crashes due to deprecated node modules, please enter the following command both in the  ```root``` folder and in the ```client``` folder :-
```bash 
npm install -g npm-check-updates
```
- Then run the ```npm run dev``` command
- Also this website isn't just about the Shoe - Shop, you ```can change this``` according to your needs, like you can ```add different types of products``` in the DB and change the purpose of website!!!

#### ENJOY THE WEBSITE!!!