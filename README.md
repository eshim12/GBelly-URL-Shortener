# URL Shortener

* Ruby 2.7.1
* Rails 5.1.7

## 1. Clone the Repository
```
git clone https://github.com/eshim12/GBelly-URL-Shortener.git
cd GBelly-URL-Shortener
bundle install
```

## 2. Configure
Copy the sample application.yml file and edit as required.
```
cp config/application.yml.sample config/application.yml
```
## 3. Create and Setup the database
```
rails db:create
rails db:migrate
```
## 4. Start the Rails Server
```rails s```
Now you can visit http://localhost:3000 !

## 5. Seeded data
You can create a user a url using `rails c` or run `rails db:seed` and access the shortened url. There is one user and one url in the seed file. Feel free to create more in the console!

## 5. Tests
To set up tests, run:
```
rails db:test:prepare
```
And you can run the tests by running `rspec` in your terminal.

## About URL Shortener
This is the backend for the URL Shortener application. The basic idea is that this application will have many users, who can create an account and then create as many url shorteners as they want! As a user, they will not only be able to create a shortened URL, but also edit an existing one and delete it. Once a shortened url is successfully created, it will instantly be accessible via the url (replace `:SLUG` with the newly created shortened slug): http://localhost:3000/:SLUG. 

### Models
The project has a `User` and `Url` models. In order to not only create but to edit and delete shortened urls, I've added these two models where a User `has_many` Urls and a Url `belongs_to` a User. Users are created with a `username` and `password` attributes, where the password is securely saved in the database using the Bcrypt gem. Urls are created with a `long_url`, `slug`, `shortened_url` attributes, but the slug attribute is optional. The shortened_url is generated once the slug attribute is validated. If a user chooses not to customize their slug, they can leave the parameter empty when making the POST request, and a 6-character slug will be randomly generated.

### Controller
The project has `UsersController`, `UrlsController`, and an `AuthController`. I have added an `AuthController` to set up the login flow for a user. I am using the `jwt` gem to generate and encode/decode a token when an existing user logs into the application. On the frontend, the token would be used in the Authorization Header as `Bearer TOKEN` when making any API calls in the application. Only users that are logged in will be able to view all shortened urls that have been created, which are mapped so only the urls that belong to the specific user_id are returned. The `UsersController` has a create action which handles creating a new user. On the frontend, this would be a Signup page. The `UrlsController` contains all CRUD actions for urls. An authorized user will be able to create urls, fetch all the urls that belong to them, update an existing url, delete a url, and instead of fetching more information on a specific url, they can click/type the shortened url and it will redirect to the original long_url. All actions except accessing the shortened URL can only be done if a user is logged in. 

### To test API calls
Because the url shortener backend is currently not integrated with a frontend, the token will not be assigned to the Authorization header when making requests to the API. A workaround is:
I recommend using a development tool like Postman to test the API calls. For example:
 * I am creating a new user with the username `ellishim` and the password `12345` by making a POST request to http://localhost:3000/api/v1/users?username=ellishim&password=12345. A successful response body will return a json object where I will see my newly created user as well as a jwt token. I will copy that jwt token for safekeeping and will now paste it in the Authorization header section when making a request (more on that soon)
 * If I already have a username, I will use that information to log in by making a POST request to http://localhost:3000/api/v1/login?username=ellishim&password=12345. A successful response body will return a json object like mentioned in the previous bullet point.
 * Now that I am logged in, I want to create a shortened url so I make a POST request to http://localhost:3000/api/v1/urls?long_url=ANY_LONG_URL. The response body
will return a json object with all the attributes for this url including the `long_url`, `slug`, and `shortened_url`. On the frontend, this information could be used to include a link that the user can click.
* If I want to edit a url- I can only edit the slug attribute- I make a PATCH request to http://localhost:3000/api/v1/urls/:ID?slug=nEwSluG. A successful response body will return a json object with the updated url.
* If I want to delete a url, I make a DELETE request to http://localhost:3000/api/v1/urls/:ID. On Postman, I will type in one of the urls I recently created. On the frontend, each url would have a delete/edit button. A successful response body will return a message saying that the shortened url is now expired. If I try to access the shortened url after deleting the url, I will see a message saying that the url is expired.

