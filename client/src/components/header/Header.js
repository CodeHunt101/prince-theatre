import { Typography, Box } from "@mui/material"
import "../../App.css"

export const Header = () => (
  <Box component="header">
    <Typography component="h1" gutterBottom variant="h2">
      <b>Prince's Theatre</b>
    </Typography>
    <Typography component="h4" gutterBottom variant="h4">
      Save your money, guaranteed!
    </Typography>
    <Typography
      component="p"
      gutterBottom
      sx={{ ml: 2, mr: 2 }}
      variant="body1"
    >
      Hi there! Welcome to Prince's Theatre, here you'll save tons of money by
      always seeing the best deals.
    </Typography>
  </Box>
)
