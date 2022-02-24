import { Grid, Typography, Card, CardMedia, CardContent } from "@mui/material"

export const Movie = ({ movie, moviesPrices, idx }) => {
  
  const renderPrices = () => {
    return moviesPrices.cinemaworld[idx].number < moviesPrices.filmworld[idx].number ? (
      <>
        <Typography
          gutterBottom
          variant="body1"
          component="p"
          color="white"
          sx={{ background: "#4caf50" }}
        >
          <b>Cinemaworld: {moviesPrices.cinemaworld[idx].currency}</b>
        </Typography>
        <Typography gutterBottom variant="body1" component="p" color="#ff1744">
          <del>Filmworld: {moviesPrices.filmworld[idx].currency}</del>
        </Typography>
      </>
    ) : (
      <>
        <Typography
          gutterBottom
          variant="body1"
          component="p"
          color="white"
          sx={{ background: "#4caf50" }}
        >
          <b>Filmworld: {moviesPrices.filmworld[idx].currency}</b>
        </Typography>
        <Typography gutterBottom variant="body1" component="p" color="#ff1744">
          <del>Cinemaworld: {moviesPrices.cinemaworld[idx].currency}</del>
        </Typography>
      </>
    )
  }

  // const cheapestCinemaByMovie = () => {
  //   // cinemas = ['filmworld', 'cinemaworld']
  //   const cinemas = Object.keys(moviesPrices)
  //   for (let i=0; i<=moviesPrices[cinemas[0]].length; i++) {
  //     cinemas.forEach(cinema => {
  //       moviesPrices[cinema].number
  //     })
  //   }
  // }

  return (
    <Grid item xs={6} sm={6} md={3} lg={3}>
      <Card sx={{ height: "100%", display: "flex", flexDirection: "column" }}>
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
            By: {movie.actors}
          </Typography>
          {renderPrices()}
        </CardContent>
      </Card>
    </Grid>
  )
}
