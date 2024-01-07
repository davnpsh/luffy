import Slider from "react-slick"
import { ShowCard, CardSkeleton } from "./showCard.coffee"
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
    responsive: [
      {
      breakpoint: 850
      settings:
        slidesToShow: 4
        arrows: false
        touchMove: true
      }
      {
      breakpoint: 640
      settings:
        slidesToShow: 3
        arrows: false
        touchMove: true
      }
    ]

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

LoadingSlider = ->
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
      {Array 6
        .fill()
        .map (_, index) ->
          <CardSkeleton key={index} />
        }
    </Slider>
  </div>

export SliderSkeleton = ->
  <section className="container mx-auto mt-10 mb-10">
    <Typography
      variant="h2"
      color="white"
      className="mb-4 ml-5 md:ml-0 text-2xl md:text-3xl"
    >
      Streaming this season
    </Typography>
    <LoadingSlider />
  </section>

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
