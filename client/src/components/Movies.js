import { useState, useEffect } from "react"
import { Movie } from "./Movie"
import {
  Box,
  LinearProgress,
  Container,
  Grid,
  Pagination,
  Typography
} from "@mui/material"

const moviesPerPage = 4

export const Movies = () => {
  // Page state & handlers
  const [page, setPage] = useState(1)
  const handleOnPageChange = (event, page) => setPage(page)

  // Movies state, fetch on component load and render method
  const [movies, setMovies] = useState([])
  const [moviePrices, setMoviePrices] = useState({})

  const fetchMovieCards = () => {
    // Fetches movies from the server and assign them to the movies state
    fetch("/api/v1/movie_cards")
      .then((resp) => resp.json())
      .then((movies) => setMovies(movies.response))
      .catch((error) => {
        console.log(error)
        setMovies("hello")
      })
  }

  const fetchMoviePrices = () => {
    // Fetches movies prices from the server and assign them to the movies state
    fetch("/api/v1/movie_prices")
      .then((resp) => resp.json())
      .then((prices) => setMoviePrices(prices.response))
      .catch((error) => {
        console.log(error)
        setMovies("hello")
      })
  }

  useEffect(() => {
    // Fetches movies on component load
    fetchMovieCards()
    fetchMoviePrices()
  }, [])

  const renderMoviesOnPage = (page = 1) => {
    /* Shows a progress line until movies state has the required data, 
    then shows only the ones needed depending on the current page */
    if (movies.error) {
      return <Typography variant="h5" component="p">Oops, we couldn't retrieve the movies data, please try again later.</Typography>
    } 
     else if (movies.length === 0) {
      return (
        <Box sx={{ width: "50%" }}>
          <LinearProgress />
        </Box>
      )
    }
    else {
      if (Object.keys(moviePrices).length>0) {
        return movies
        .map((movie, idx) => <Movie key={movie.id} movie={movie} moviePrices={moviePrices} idx={idx}/>)
        .slice(page * moviesPerPage - moviesPerPage, page * moviesPerPage)
      }
      
    }
  }

  return (
    <>
      <Grid
        id="movie-cards-list"
        component="section"
        item
        sx={{ mx: "auto", minHeight: "75vh", maxWidth: "1220px", mt:5 }}
        circle="true"
      >
        {movies.length > 0 && (
          <Container
            sx={{ display: "flex", justifyContent: "center" }}
          >
            <Pagination
              count={Math.ceil(movies.length / moviesPerPage)}
              page={page}
              onChange={handleOnPageChange}
              color="primary"
            />
          </Container>
        )}
        <Container sx={{ py: 5 }} maxWidth="lg">
          <Grid
            container
            sx={{ display: "flex", justifyContent: "center" }}
            spacing={4}
          >
            {renderMoviesOnPage(page)}
          </Grid>
        </Container>
      </Grid>
    </>
  )
}
