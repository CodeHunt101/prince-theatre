import { useState, useEffect } from "react"
import { Movie } from "./Movie"
import {
  Box,
  LinearProgress,
  Container,
  Grid,
  Pagination,
  Typography,
} from "@mui/material"

const moviesPerPage = 4

export const Movies = () => {
  // Page state & handlers
  const [page, setPage] = useState(1)
  const handleOnPageChange = (event, page) => setPage(page)

  // Movies state, fetch on component load and render method
  const [movies, setMovies] = useState([])
  const [moviesPrices, setMoviesPrices] = useState([])

  const fetchMovieCards = () => {
    // Fetches movies from the server and assign them to the movies state
    fetch("/api/v1/movie_cards")
      .then((resp) => resp.json())
      .then((movies) => setMovies(movies.response))
      .catch((error) => {
        console.log(error)
      })
  }

  const fetchMoviesPrices = () => {
    // Fetches movies prices from the server and assign them to the movies state
    fetch("/api/v1/movie_prices")
      .then((resp) => resp.json())
      .then((prices) => setMoviesPrices(prices.response))
      .catch((error) => {
        console.log(error)
      })
  }

  useEffect(() => {
    // Fetches movies on component load
    fetchMovieCards()
    fetchMoviesPrices()
  }, [])

  const renderMoviesOnPage = (page = 1) => {
    /* Shows a progress line until movies state has the required data, 
    then shows only the ones needed depending on the current page */
    if (movies.error) {
      return (
        <Typography component="p" variant="h5">
          Oops, we couldn't retrieve the movies data, please try again later.
        </Typography>
      )
    } 
    
    if (movies.length === 0 || moviesPrices.length === 0) {
      return (
        <Box sx={{ width: "50%", p: 10 }}>
          <LinearProgress />
        </Box>
      )
    } else {
      // In any other case, map over the movies state to the render each movie
      return movies
        .map((movie, idx) => (
          <Movie
            key={movie.id}
            idx={idx}
            movie={movie}
            moviesPrices={moviesPrices}
          />
        ))
        .slice(page * moviesPerPage - moviesPerPage, page * moviesPerPage)
    }
  }

  return (
    <>
      <Grid
        circle="true"
        component="section"
        id="movie-cards-list"
        item
        sx={{ mx: "auto", minHeight: "75vh", maxWidth: "1220px", mt: 5 }}
      >
        {movies.length > 0 && (
          <Container sx={{ display: "flex", justifyContent: "center" }}>
            <Pagination
              color="primary"
              count={Math.ceil(movies.length / moviesPerPage)}
              onChange={handleOnPageChange}
              page={page}
            />
          </Container>
        )}
        <Container sx={{ py: 5 }} maxWidth="lg">
          <Grid
            container
            spacing={4}
            sx={{ display: "flex", justifyContent: "center" }}
          >
            {renderMoviesOnPage(page)}
          </Grid>
        </Container>
      </Grid>
    </>
  )
}
