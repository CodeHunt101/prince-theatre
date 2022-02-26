import { Header } from "./components/Header/Header"
import { Movies } from "./components/Movies/Movies"
import "./App.css"
import { Container, Box, Paper } from "@mui/material"

function App() {
  return (
    <div className="App">
      <Container maxWidth="xl">
        <Box component={Paper} sx={{ backgroundColor: "#ffffffd9" }}>
          <Box sx={{ pt: 5, pb: 5 }}>
            <Header />
            <Movies />
          </Box>
        </Box>
      </Container>
    </div>
  )
}

export default App
