import { Typography, Box } from "@mui/material"
import "../App.css"

export const Header = () => (
  <Box component="header">
    <Typography gutterBottom variant="h2" component="h1">
      <b>Prince's Theatre</b>
    </Typography>
    <Typography gutterBottom variant="h4" component="h4">
      Save your money, guaranteed!
    </Typography>
    <Typography
      gutterBottom
      variant="body1"
      component="p"
      sx={{ ml: 2, mr: 2 }}
    >
      Hi there! Welcome to Prince's Theatre, here you'll see the movie prices
      from two cinemas! The{" "}
      <span className="highlight-cheapest">
        <b>cheapest are highlighted in green</b>
      </span>{" "}
      and the{" "}
      <span className="highlight-expensive">
        <del>expensive ones are in red with a strikethrough</del>
      </span>
      .
    </Typography>
  </Box>
)
