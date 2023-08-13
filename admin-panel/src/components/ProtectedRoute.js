// src/components/ProtectedRoute.js

import { Navigate, Outlet } from 'react-router-dom';

function ProtectedRoute() {
  const isAuthenticated = true; // Replace this with your actual authentication check

  return isAuthenticated ? <Outlet /> : <Navigate to="/" />;
}

export default ProtectedRoute;
