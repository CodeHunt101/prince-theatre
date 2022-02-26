# PRINCE'S THEATRE

The place you'll find the best deals for movies in terms of price, guaranteed!

## Description

This application renders a group of classic movies and compares the prices of two well-known streaming providers, "Filmworld" and "Cinemaworld".
It displays movie posters, titles, actors, and the most impoart thing: prices!
The cheapest prices are highlighted in green, and the expensive prices have strikethrough and are red coloured.

For this project, the following technologies were used:

🧰 Languages

![](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)

🧰 Frameworks/Libraries

![](https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB)
![](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![](https://img.shields.io/badge/materialui-%230081CB.svg?style=for-the-badge&logo=material-ui&logoColor=white)

Other worth mentioning frameworks/libraries/gems used are:
- RSpec
- Jest
- HTTParty

## API Key
- The API key is safely stored in an environment variable in both development and production modes. 
- If you are going to clone this repository, make sure you have a valid API Key.

## How to Install and Run the Project

1. Clone this repository.

2. Please make sure you are using **Ruby 2.7.4**, otherwise go to *Gemfile* and change the ruby version to the one you currently have (However, I encourage you to use **Ruby 2.7.4** to avoid incompatibility issues). Then please run:

```
bundle install
```
That will install rails and all its dependencies

3. To install all the react dependencies, please run from the root directory:
```
npm install --prefix client
```

4. Create a *.env* file on the root directory to store your API key in an environment variable. Name it API_KEY.
```
API_KEY = your_api_key
```

5. To call the server run:

```
rails server
```

6. Run the following to display the app in the browser:
```
npm start --prefix client
```

Ports from server and client are already set to be different, so there is no need to specify them. Port 3000 for Rails and Port 4000 for React.

## Structure (MVC)

### Models & Controllers
The *Rails* server handles the logic of the app from the **GetMovies** (*get_movies.rb*) and **Movie** (*movie.rb*) models. The movies details are sent to the Client from  **Api::V1::MoviesController** (*movies_controller.rb*) as JSON.

### Views
The components structure is the following:

```
App.js
  |
  |-->Header.js
  |
  |-->Movies.js
          |
          |-->Movie.js
                |
                |-->CinemaMoviePrice.js
```

*index.css* contains some stylings and layout that was not implemented from Material UI.

## Tests

For Ruby on Rails (server), RSpec was the designated testing tool.

To execute the tests from Ruby on Rails, please run from the **root** directory:

```
rspec
```
It will automatically run all the tests where green means that a test passed and red means it didn't pass.

For React (client), Jest was the designated testing tool.

To execute the tests from React, please run from the **root** directory:
```
npm test --prefix client
```
If an error is thrown before the watcher is set up and tests are ran, please execute the following:
```
npm i -D --exact jest-watch-typeahead@0.6.5
```

## Responsiveness
This application is fully responsive. It adapts to any screen size.

## Assumptions
- The general information such as Movie titles and actors are the same. Therefore, those two attributes are rendered from Film World assuming that the Cinema World attributes will be the same.
- The problem to solve is to compare price, so it is assumed that prices might not be the same.

<!-- ## Improvement Opportunities -->


Thank you for your time!
