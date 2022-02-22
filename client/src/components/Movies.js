import { useState, useEffect } from "react"
import { Movie } from "./Movie"
import { Box, LinearProgress } from "@mui/material"

// const moviesPerPage = 8

export const Movies = () => {
  
  const [movies, setMovies] = useState([])
  

  // Page state & handlers
  // const [page, setPage] = useState(1)
  // const handleOnPageChange = (event, page) => setPage(page)

  
  const fetchMovies = () => {
    fetch('/api/v1/movie_cards')
      .then(resp => resp.json())
      .then(movies=>setMovies(movies.response))
  }

  useEffect(()=> {
    fetchMovies()
  },[])
  console.log(movies)
  
  const renderMoviesOnPage = (page = 1) => {
    if (movies.length === 0) {
      return (
        <Box sx={{ width: "50%" }}>
          <LinearProgress />
        </Box>
      )
    } else {
      return movies
        // .slice(page * moviesPerPage - moviesPerPage, page * moviesPerPage)
        .map((movie) => (
          <Movie key={movie.id} movie={movie} />
        ))
    }
  }

  return (
    renderMoviesOnPage()
  )
  
}