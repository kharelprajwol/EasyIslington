import React from 'react';
import { Container, Paper, Typography } from '@mui/material';

function Dashboard() {
  return (
    <Container maxWidth="100%">
      <Paper style={{ padding: 20 }}>
        <Typography variant="h4">Dashboard</Typography>
        <Typography>
          Welcome to the admin dashboard! Expand upon this as needed.
        </Typography>
      </Paper>
    </Container>
  );
}

export default Dashboard;
