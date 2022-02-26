import { Grid, Typography, Card, CardMedia, CardContent } from "@mui/material"
import { CinemaMoviePrice } from "./CinemaMoviePrice"

export const Movie = ({ movie, moviesPrices, idx }) => {
  const renderPrices = () =>
    // Maps the MoviesPrices props to display the CinemaMoviePrice component and sorts it
    Object.entries(moviesPrices)
      .map((cinemaMoviePrices) => (
        <CinemaMoviePrice
          key={cinemaMoviePrices[1][idx].movie_id}
          cinema={cinemaMoviePrices[0]}
          moviePrice={cinemaMoviePrices[1][idx]}
        />
      ))
      .sort((a, b) => a.props.moviePrice.number - b.props.moviePrice.number)

  return (
    <Grid item xs={6} sm={6} md={3} lg={3}>
      <Card id={movie.id} className="movie-card" sx={{ height: "100%", display: "flex", flexDirection: "column" }}>
        <CardMedia
          component="img"
          sx={{
            pt: "10%",
          }}
          height="300px"
          image={movie.poster}
          alt="moviePoster"
        />

        <CardContent sx={{ flexGrow: 1 }}>
          <Typography gutterBottom variant="h6" component="h2">
            {movie.title}
          </Typography>
          <Typography gutterBottom variant="body2" component="p">
            <b>Actors:</b> {movie.actors}
          </Typography>
          {renderPrices()}
        </CardContent>
      </Card>
    </Grid>
  )
}
