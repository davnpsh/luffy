import "./styles/general.scss"
import { BrowserRouter, Routes, Route } from "react-router-dom"

# Pages
import { Home } from "./pages/home.coffee"
import { Watch } from "./pages/watch.coffee"

# Components
import { Navbar } from "./components/navbar.coffee"

export App = ->
  <>
    <BrowserRouter>
      <Navbar />

      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/watch" element={<Watch />} />
        <Route path="*" element={<h1>Not found</h1>} />
      </Routes>
    </BrowserRouter>
  </>
