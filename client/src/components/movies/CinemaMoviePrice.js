import { Typography } from "@mui/material"
import { capitalise } from "../../utils"

export const CinemaMoviePrice = ({ cinema, moviePrice }) => {
  const displayCinemaAndPrice = () => (
    <>
      <span>{capitalise(cinema)}</span>: <span>{moviePrice.currency}</span>
    </>
  )

  const defineCinemaMoviePriceFormat = () =>
    moviePrice.cheapest ? (
      <b>{displayCinemaAndPrice()}</b>
    ) : (
      <del>{displayCinemaAndPrice()}</del>
    )

  return (
    <Typography
      className={moviePrice.cheapest ? "cheapest" : "not-cheapest"}
      color={moviePrice.cheapest ? "white" : "#ff1744"}
      component="p"
      gutterBottom
      sx={{ background: moviePrice.cheapest ? "#4caf50" : "white" }}
      variant="body1"
    >
      {defineCinemaMoviePriceFormat()}
    </Typography>
  )
}
