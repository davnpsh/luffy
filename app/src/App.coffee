import "./styles/tailwind.scss"
import { BrowserRouter, Routes, Route } from "react-router-dom"
import { Home } from "./pages/home.coffee"

export App = () ->
    <BrowserRouter>
        <Routes>
            <Route path="/" element={<Home />} />
        </Routes>
    </BrowserRouter>