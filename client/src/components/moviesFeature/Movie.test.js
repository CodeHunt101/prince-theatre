import { render, screen } from '@testing-library/react';
import {Movie} from './Movie'
import {mockMovieCards} from '../../mocks/movieCards'
import {mockCinemaMoviesPrices} from '../../mocks/cinemaMoviesPrices'

describe('<Movie />', () => {
  test('is displays the title, actors, cinemas and prices', () => {
    // Pass required props to <Movie/> (using first movie of the array)
    render(
      <Movie
        movie={mockMovieCards.response[0]}
        moviesPrices={mockCinemaMoviesPrices.response}
        idx={0}
      />,
    )
    // Check the movie is rendered
    const movieTitle = screen.getByText('Star Wars: Episode VII - The Force Awakens')
    const movieActors = screen.getByText('Harrison Ford, Mark Hamill, Carrie Fisher, Adam Driver')
    const filmworld = screen.getByText('Filmworld')
    const filmworldPrice = screen.getByText('$25.00')
    const cinemaworld = screen.getByText('Cinemaworld')
    const cinemaworldPrice = screen.getByText('$24.70')

    expect(movieTitle).toBeInTheDocument()
    expect(movieActors).toBeInTheDocument()
    expect(filmworld).toBeInTheDocument()
    expect(filmworldPrice).toBeInTheDocument()
    expect(cinemaworld).toBeInTheDocument()
    expect(cinemaworldPrice).toBeInTheDocument()
  })

  test('is displays the not cheapest prices inside a <del> tag as the minimum requirement format', () => {
    // Pass required props to <Movie/> (using first movie of the array)
    render(
      <Movie
        movie={mockMovieCards.response[0]}
        moviesPrices={mockCinemaMoviesPrices.response}
        idx={0}
      />,
    )
    // Check the price is rendered as per format requirement
    const notCheapestPrice = screen.getByText('$25.00')
    
    // eslint-disable-next-line testing-library/no-node-access
    expect(notCheapestPrice.parentElement.outerHTML.includes("<del>")).toBe(true)
    // eslint-disable-next-line testing-library/no-node-access
    expect(notCheapestPrice.parentElement.outerHTML.includes("</del>")).toBe(true)
  })

  test('is displays the cheapest prices inside a <b> tag as the minimum requirement format', () => {
    // Pass required props to <Movie/> (using first movie of the array)
    render(
      <Movie
        movie={mockMovieCards.response[4]}
        moviesPrices={mockCinemaMoviesPrices.response}
        idx={4}
      />,
    )
     // Check the price is rendered as per format requirement
    const cheapestPrice = screen.getByText('$24.00')
    
    // eslint-disable-next-line testing-library/no-node-access
    expect(cheapestPrice.parentElement.outerHTML.includes("<b>")).toBe(true)
    // eslint-disable-next-line testing-library/no-node-access
    expect(cheapestPrice.parentElement.outerHTML.includes("</b>")).toBe(true)
  })
})