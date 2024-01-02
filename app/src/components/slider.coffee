import Slider from "react-slick"
import { ShowCard } from "./showCard.coffee"
import { Typography } from "@material-tailwind/react"
import "slick-carousel/slick/slick.css"
import "slick-carousel/slick/slick-theme.css"

LoadedSlider = ({ scheduleData }) ->
  settings =
    dots: false
    infinite: true
    slidesToShow: 5
    slidesToScroll: 1
    autoplay: true
    speed: 500
    autoplaySpeed: 2000

  <div>
    <Slider {...settings}>
      {Object.keys(scheduleData).map (day) ->
        scheduleData[day].map (show) ->
          <ShowCard
            url={show.identifier}
            picurl={show.picture}
            name={show.name}
          />
      }
    </Slider>
  </div>

export ScheduleSlider = ({ scheduleData }) ->
  <section className="container mx-auto mt-10 mb-10">
    <Typography
      variant="h2"
      color="white"
      className="mb-4 ml-5 md:ml-0 text-2xl md:text-3xl"
    >
      Streaming this season
    </Typography>
    <LoadedSlider scheduleData={scheduleData} />
  </section>
