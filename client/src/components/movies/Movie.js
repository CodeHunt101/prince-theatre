import { Grid, Typography, Card, CardMedia, CardContent } from "@mui/material"
import { CinemaMoviePrice } from "./CinemaMoviePrice"

export const Movie = ({ idx, movie, moviesPrices }) => {
  const renderPrices = () =>
    /* Maps the moviesPrices prop to display the CinemaMoviePrice component and sorts it 
    so that the cheapest is displayed above the rest*/
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
      <Card
        className="movie-card"
        id={movie.id}
        sx={{ display: "flex", flexDirection: "column", height: "100%" }}
      >
        <CardMedia
          alt={`Poster: ${movie.title}`}
          component="img"
          height="300px"
          image={movie.poster}
          sx={{
            pt: "10%",
          }}
        />

        <CardContent sx={{ flexGrow: 1 }}>
          <Typography gutterBottom component="h2" variant="h6">
            {movie.title}
          </Typography>
          <Typography gutterBottom component="p" variant="body2">
            <b>Actors:</b> {movie.actors}
          </Typography>
          {renderPrices()}
        </CardContent>
      </Card>
    </Grid>
  )
}
