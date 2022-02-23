import { Grid, Typography, Card, CardMedia, CardContent } from "@mui/material"

export const Movie = ({ movie }) => {
  const renderPrices = () => {
    return movie.price.cinemaworld.number < movie.price.filmworld.number ? (
      <>
        <Typography
          gutterBottom
          variant="body1"
          component="p"
          color="white"
          sx={{ background: "#4caf50" }}
        >
          <b>Cinemaworld: {movie.price.cinemaworld.currency}</b>
        </Typography>
        <Typography gutterBottom variant="body1" component="p" color="#ff1744">
          <del>Filmworld: {movie.price.filmworld.currency}</del>
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
          <b>Filmworld: {movie.price.filmworld.currency}</b>
        </Typography>
        <Typography gutterBottom variant="body1" component="p" color="#ff1744">
          <del>Cinemaworld: {movie.price.cinemaworld.currency}</del>
        </Typography>
      </>
    )
  }

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
