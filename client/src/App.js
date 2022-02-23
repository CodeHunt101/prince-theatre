import { Header } from './components/Header';
import { Movies } from './components/Movies';
import './App.css';
import { Container, Box, Paper } from '@mui/material';

function App() {
  
  return (
    <div className="App">
      <Container maxWidth="lg">
        <Box component={Paper}>
          <Box sx={{pt:5, pb:5}} >
            <Header />
            <Movies />
          </Box>
        </Box>
      </Container>
    </div>
  );
}

export default App;
