import React from 'react';
import { BrowserRouter, Route, Routes } from 'react-router-dom';

import Main from './pages/Main/Main';
import Login from './pages/Login/Login';
import Home from './pages/Home/Home';
import Logs from './pages/Logs/Log';
import Setting from './pages/Setting/Setting';

export default function AppRoutes() {
    return (
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<Main />} />
                <Route path="/login" element={<Login />} />
                <Route path="/home" element={<Home />} />
                <Route path="/logs" element={<Logs />} />
                <Route path="/setting" element={<Setting />} />
            </Routes>
        </BrowserRouter>
    );
}
