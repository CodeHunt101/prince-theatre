import { Typography, Box } from "@mui/material"
import "../../App.css"

export const Header = () => (
  <Box component="header">
    <Typography component="h1" gutterBottom variant="h2">
      <b>Prince's Theatre</b>
    </Typography>
    <Typography component="h3" gutterBottom variant="h4">
      Save your money, guaranteed!
    </Typography>
    <Typography
      component="h6"
      gutterBottom
      sx={{ ml: 2, mr: 2 }}
      variant="body1"
    >
      Welcome to Prince's Theatre, the pleace that helps you save tons of money
      by always giving you the best movie deals.
    </Typography>
  </Box>
)
