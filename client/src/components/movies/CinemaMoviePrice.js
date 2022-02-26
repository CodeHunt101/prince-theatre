import { Typography } from "@mui/material"
import { capitalise } from "../../utils"

export const CinemaMoviePrice = ({ cinema, moviePrice }) => {
  const renderCinemaMoviePrice = () => (
    <Typography
      gutterBottom
      variant="body1"
      component="p"
      className={moviePrice.cheapest ? "cheapest" : "not-cheapest"}
      color={moviePrice.cheapest ? "white" : "#ff1744"}
      sx={{ background: moviePrice.cheapest ? "#4caf50" : "white" }}
    >
      {moviePrice.cheapest ? (
        <b>
          <span>{capitalise(cinema)}</span>: <span>{moviePrice.currency}</span>
        </b>
      ) : (
        <del>
          <span>{capitalise(cinema)}</span>: <span>{moviePrice.currency}</span>
        </del>
      )}
    </Typography>
  )

  return renderCinemaMoviePrice()
}
