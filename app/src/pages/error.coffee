import { Typography } from "@material-tailwind/react"

export Error = ->
  luffy = new URL "../img/luffy.jpg", import.meta.url

  <div className="container mx-auto w-full flex-1 flex flex-col items-center pt-32">
    <div className="h-56">
      <img src={luffy} className="h-full"/>
    </div>
    <Typography
      variant="h1"
      className="text-xl text-center text-white mt-5"
    >
      Not found ¯\_(ツ)_/¯
    </Typography>
  </div>