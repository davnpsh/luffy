import { createRoot } from "react-dom/client"
import { App } from "./App"

container = document.getElementById("app")
root = createRoot(container)
root.render(<App />)