import {
  Grid,
  Typography,
  Card,
  CardMedia,
  CardContent,
} from "@mui/material"

export const Movie = ({ movie }) => {
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
          <Typography gutterBottom variant="body1" component="p">
            Cinemaworld: {movie.price.cinemaworld}
          </Typography>
          <Typography gutterBottom variant="body1" component="p">
            Filmworld: {movie.price.filmworld}
          </Typography>
        </CardContent>
      </Card>
    </Grid>
  )
}
